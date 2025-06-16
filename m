Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDA4C71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 22:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76C2482C8D;
	Tue, 17 Jun 2025 00:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XBcDg0Wa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED08782C79; Tue, 17 Jun 2025 00:09:44 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C10181760
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 00:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-042.46.114.pool.telefonica.de
 [46.114.105.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CA45D4063D; 
 Mon, 16 Jun 2025 22:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1750111780;
 bh=C+1Be7GLb83OjjaNhWePT98KB1YViv38rHpqMWUGbN8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=XBcDg0WaDVD6HbNJjIG4LElaQ3ktCkQTgsHgKlt7CMDM8cF6AoO9wl2qTKyWO0j4Z
 zBmHsJq9gv4hWQdiiA8mHK64B6wQ+rjKQ6d33Ry/CPVSgW5RBFLlRoWW5jT27GODhp
 xZPmYuTVHIX9cXu+fy+uOmAqJbifumCRwn2oc3MyziH1t/vTnVApaUQsHwQo5/7HoW
 RI1CvESIph/4G+EyN0jo5686ByNXqF9n1fO5MUxW4mQx0JVkbgB+0eBinmOk1bsC45
 OxYNlf/BA2GLqfB4WEpWjN2d9bFTo4tKKDYOplmy8/TNofK0nEPjYlEqk8TH0t4L0K
 OiV/czl4d3kBQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Javier Martinez Canillas <javierm@redhat.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] sandbox: enable CONFIG_CMD_BOOTEFI_SELFTEST by default
Date: Tue, 17 Jun 2025 00:09:17 +0200
Message-ID: <20250616220917.34189-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250616220917.34189-1-heinrich.schuchardt@canonical.com>
References: <20250616220917.34189-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The sandbox is used for a lot of generic development, we should run the
UEFI tests there, too.

Reported-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index ea33d07c086..7b1c334d3fc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -213,6 +213,7 @@ config SANDBOX
 	imply BITREVERSE
 	select BLOBLIST
 	imply LTO
+	imply CMD_BOOTEFI_SELFTEST
 	imply CMD_DM
 	imply CMD_EXCEPTION
 	imply CMD_GETTIME
-- 
2.48.1

