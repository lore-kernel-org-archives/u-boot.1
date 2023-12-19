Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC3AC46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 12:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7E76876B1;
	Tue, 19 Dec 2023 13:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uvm8E+nj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A96C874FB; Tue, 19 Dec 2023 13:25:00 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9274287600
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9E9B4420F3; 
 Tue, 19 Dec 2023 12:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702988696;
 bh=5Ex2YvctX6+vgkj0gPY1JamG+V70LULNXkq7zEZzgXw=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=uvm8E+njN1Ltdua63eiNpYJINf4pE3s+W6KxIvISTnePdSUzWxbtPIO7NZr+zttVc
 133Ytady6tWti2SLzag8wcUVmUHMyweBVg8PS1eRshR/Qj9A0InAgCO+4nxq1MOYHo
 Wax5LjIJYhf44QP1DBWFSLQFeV8xwq3ZqHemwJog6sl9Y6/oXgY6AOPR0EHdT2T7YC
 y38cO3o8W7ooyymrWQRnoExX7keGvQdich1Qy2JZaZd7nWGycW4B+e30cLLQ9XhbiI
 KaQ/u2YRSpXsQ6vzQvrekauKzBoXspP4uzCfLwxeyPGsCLdOgkoAtnJZeWM27tLoJm
 spDChkgSjnR/g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 7/9] risc-v: allow usage of ACPI
Date: Tue, 19 Dec 2023 13:24:37 +0100
Message-Id: <20231219122439.31983-8-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
References: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
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

Select CONFIG_SUPPORT_ACPI to allow usage of ACPI tables with RISC-V.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v3:
	no change
v2:
	no change
---
 arch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 2e0528d819..c23d57e4c4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -108,6 +108,7 @@ config PPC
 config RISCV
 	bool "RISC-V architecture"
 	select CREATE_ARCH_SYMLINK
+	select SUPPORT_ACPI
 	select SUPPORT_OF_CONTROL
 	select OF_CONTROL
 	select DM
-- 
2.40.1

