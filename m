Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF45C71155
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 06:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3386C82C8D;
	Tue, 17 Jun 2025 08:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SdbhGM99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1469082C84; Tue, 17 Jun 2025 08:20:35 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DB0782C84
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 08:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-042.46.114.pool.telefonica.de
 [46.114.105.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E0FAE4B67F; 
 Tue, 17 Jun 2025 06:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1750141229;
 bh=tY47Ga7KCAPv4LdG9WseiyvFYBW8xl4G1W8XcedOj/I=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=SdbhGM99Lxv2Zm9rg8W1qxrQA+ea5EXftkbKw0oZjcLpO50BgPz6wcL13i2VBduzh
 OHxqbxHBZdUKQdgx7RkrRUfE0lTZWbYOab18Ft/J9x4RNH2LjcV5EbtOc7Lw2EQHpO
 s5I8CsADyHHkf6OUTZLOmdEJo7wejbz/l3kl3qd4/+5qZFe8Jb3LVkuzKaQ4fpRmxm
 6HXh6reeexEHvxUNZGaojf/R8u/c7fy8x/Uj1/NGwCGXLPGrW6ziQQXtlRzJvurqGd
 V+6u7f6aY5AB9TTHqv4DREa0VmQkYc9oS78l/jPTzuML0VFWYMHUTo2rpGfD6AHxB7
 JzMcUs0cYqnVg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/2] sandbox: enable CONFIG_CMD_BOOTEFI_SELFTEST by default
Date: Tue, 17 Jun 2025 08:19:45 +0200
Message-ID: <20250617061945.9266-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250617061945.9266-1-heinrich.schuchardt@canonical.com>
References: <20250617061945.9266-1-heinrich.schuchardt@canonical.com>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
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

