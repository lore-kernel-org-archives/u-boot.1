Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61BCCCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A6A68458B;
	Thu,  9 Oct 2025 16:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jaXtprhj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 621D784584; Thu,  9 Oct 2025 16:51:21 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79E2884571
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 29AB04E40FB4;
 Thu,  9 Oct 2025 14:51:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F362F6062C;
 Thu,  9 Oct 2025 14:51:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8095F102F21F3; 
 Thu,  9 Oct 2025 16:51:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760021478; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=gi2Hh5amUbSINLhjXT9vRW0uJkgH0Lp3IZvFTS9AVSA=;
 b=jaXtprhjUFP+dVLZpiy7fFPxeuz3Bn6nTER8ccdwH4nGlwWdZ7qFYp3NraxMKpY91LImOf
 TG+g8nudWcpCrNdaJuCoJMqg2JkkwT+xj3/U9ZKjn7rYbU0gQ6JqmW8T2wEEE2pyn853p0
 HHWCsGX8Xzf5B1wEt2YWEelhqjuUxtF3fXOwcOedH6mGsn1IVTOuQ4fDTfqvLNEnN/RKtp
 QlHaokPrZbMF+ZsBod2bAvS3Bpj9jj2/qSMo75+WMNpPH0Gd9E2TOyNgnuOLO3swHGMKVt
 QbbzjCpVsreadWHzkt95lsSaBePLRSwxFPbU8mABVbAQZS2DrhCgma6MSKrlyQ==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 09 Oct 2025 16:50:47 +0200
Subject: [PATCH v2 11/18] board: sandbox: Convert extension support to
 UCLASS framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-feature_sysboot_extension_board-v2-11-e09b39e54de5@bootlin.com>
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3
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

Migrate sandbox extension board detection from legacy implementation to
the new UCLASS-based extension board framework.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 arch/Kconfig            |  2 +-
 board/sandbox/sandbox.c | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 7e05e0c2263..5bb65a29f8d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -215,7 +215,7 @@ config SANDBOX
 	select SYSRESET_CMD_POWEROFF if CMD_POWEROFF
 	select SYS_CACHE_SHIFT_4
 	select IRQ
-	select SUPPORT_EXTENSION_SCAN if CMDLINE
+	select SUPPORT_DM_EXTENSION_SCAN if CMDLINE
 	select SUPPORT_ACPI
 	imply BITREVERSE
 	select BLOBLIST
diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index c5d7b9651a9..0e83173f531 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -111,27 +111,27 @@ int ft_board_setup(void *fdt, struct bd_info *bd)
 }
 
 #ifdef CONFIG_CMD_EXTENSION
-int extension_board_scan(struct list_head *extension_list)
+static int sandbox_extension_board_scan(struct alist *extension_list)
 {
 	int i;
 
 	for (i = 0; i < 2; i++) {
-		struct extension *extension;
-
-		extension = calloc(1, sizeof(struct extension));
-		if (!extension)
+		struct extension extension = {0}, *_extension;
+
+		snprintf(extension.overlay, sizeof(extension.overlay), "overlay%d.dtbo", i);
+		snprintf(extension.name, sizeof(extension.name), "extension board %d", i);
+		snprintf(extension.owner, sizeof(extension.owner), "sandbox");
+		snprintf(extension.version, sizeof(extension.version), "1.1");
+		snprintf(extension.other, sizeof(extension.other), "Fictional extension board");
+		_extension = alist_add(extension_list, extension);
+		if (!_extension)
 			return -ENOMEM;
-
-		snprintf(extension->overlay, sizeof(extension->overlay), "overlay%d.dtbo", i);
-		snprintf(extension->name, sizeof(extension->name), "extension board %d", i);
-		snprintf(extension->owner, sizeof(extension->owner), "sandbox");
-		snprintf(extension->version, sizeof(extension->version), "1.1");
-		snprintf(extension->other, sizeof(extension->other), "Fictional extension board");
-		list_add_tail(&extension->list, extension_list);
 	}
 
 	return i;
 }
+
+U_BOOT_EXTENSION(sandbox_extension, sandbox_extension_board_scan);
 #endif
 
 #ifdef CONFIG_BOARD_LATE_INIT

-- 
2.43.0

