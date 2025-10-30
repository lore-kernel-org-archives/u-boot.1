Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6395CCCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C701839A1;
	Thu, 30 Oct 2025 17:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hYdtb9oN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAB6D839B7; Thu, 30 Oct 2025 17:45:40 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9FC6838FA
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 99DA24E413FD;
 Thu, 30 Oct 2025 16:45:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 65CCE60331;
 Thu, 30 Oct 2025 16:45:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9B26A11808CA0; Thu, 30 Oct 2025 17:45:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761842737; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=R9z7VCGAju5mm6Ipj+GE9dFY6l3RrOZ2NIypi9KjPPg=;
 b=hYdtb9oNMt4/NrVw/pGh0K9Xycz8/F6ixyWZ1JMkHyV6NqNASVt8LTR6LXJ7EOzHxJOJEE
 Jse1uaIj9vFWsdOCPnzUf/zrEnfMfnqKyk1Dj3RUEPJ5t8eMaZzec/ewP7kyuPWdRkt0uP
 iQ9c2tks/fSAC4FFrXNZ6wiZW+es9gUPwfilaEHI8Vr4UEoOnWMy6goNyavWkz4dq+w1Ge
 5ZHP0mKMIqdSNPctm2UlKsF7w0qip7LiAAOApwGs5bb7yvCvgfBro/nyAR4Y5gn8IX4sQt
 epS4HcctJYYdf8uK1YOwUCYHYpabf4oMU4DIfuODlLpojZlPvYjn6NcrYRUjUQ==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 30 Oct 2025 17:45:07 +0100
Subject: [PATCH v5 14/20] board: sandbox: Convert extension support to
 UCLASS framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-feature_sysboot_extension_board-v5-14-cfb77672fc68@bootlin.com>
References: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
In-Reply-To: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
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
X-Mailer: b4 0.14.3
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Change in v5:
- Change sandbox extension function build dependency to
  CONFIG_SUPPORT_DM_EXTENSION_SCAN and !CONFIG_XPL_BUILD.

Change in v3:
- Use U_BOOT_DRVINFO.
---
 arch/Kconfig            |  2 +-
 board/sandbox/sandbox.c | 31 ++++++++++++++++++-------------
 2 files changed, 19 insertions(+), 14 deletions(-)

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
index c5d7b9651a9..d46db6d492f 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -110,28 +110,33 @@ int ft_board_setup(void *fdt, struct bd_info *bd)
 	return fdt_add_mem_rsv(fdt, 0x00d02000, 0x4000);
 }
 
-#ifdef CONFIG_CMD_EXTENSION
-int extension_board_scan(struct list_head *extension_list)
+#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN) && \
+	!CONFIG_IS_ENABLED(XPL_BUILD)
+static int sandbox_extension_board_scan(struct udevice *dev,
+					struct alist *extension_list)
 {
 	int i;
 
 	for (i = 0; i < 2; i++) {
-		struct extension *extension;
-
-		extension = calloc(1, sizeof(struct extension));
-		if (!extension)
+		struct extension extension = {0};
+
+		snprintf(extension.overlay, sizeof(extension.overlay), "overlay%d.dtbo", i);
+		snprintf(extension.name, sizeof(extension.name), "extension board %d", i);
+		snprintf(extension.owner, sizeof(extension.owner), "sandbox");
+		snprintf(extension.version, sizeof(extension.version), "1.1");
+		snprintf(extension.other, sizeof(extension.other), "Fictional extension board");
+		if (!alist_add(extension_list, extension))
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
+
+U_BOOT_DRVINFO(sandbox_extension) = {
+	.name = "sandbox_extension",
+};
 #endif
 
 #ifdef CONFIG_BOARD_LATE_INIT

-- 
2.43.0

