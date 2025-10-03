Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4206CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 16:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA4F48386D;
	Fri,  3 Oct 2025 18:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="KZAaWtyC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F30838AE; Fri,  3 Oct 2025 18:34:40 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67F4983759
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 18:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 1EBC9C00DA9;
 Fri,  3 Oct 2025 16:34:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 236CA60683;
 Fri,  3 Oct 2025 16:34:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ECCBC102F1D06; 
 Fri,  3 Oct 2025 18:34:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759509277; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=IoD+tqZ15TpmNrq3C8D22Y7ppZbtDrDZMEBn6cXOJvk=;
 b=KZAaWtyCkHXpbC690qLr3rqP0M4hkfZOPeHNdaXG3GAvpgFckiBH5+D/tTkm4v+5DrkX4W
 i0q/boZ+WOZP2FgEW+kWca/1CJFjCtEYuco3pOZQEVwz7sgPhfWFGEjCYWqskqM3l3o76F
 uTgOR4uxbFdKRlo4mnY9adB5ZbIS4VCmnc/mWwQ4XZQ0rgw00YVUcu9kg8Tfy+fPFBCrGD
 jzvQHHRY6Roonq7MFUwxrt+R5QTJfuC4TBsVFLqaK14rlJRHqsw2himBocxatbHErxlwFe
 PwT5VdeUlnnCcGHFreYYnQF+y4vtbErxYI5ldQno2fAIePtBpMs60zDhsQQ6mg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Oct 2025 18:33:50 +0200
Subject: [PATCH 10/16] board: sandbox: Convert extension support to UCLASS
 framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-feature_sysboot_extension_board-v1-10-458b8bf85325@bootlin.com>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
In-Reply-To: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Kory Maincent <kory.maincent@bootlin.com>
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

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
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
index c5d7b9651a9..21e1e2583fd 100644
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
+U_BOOT_EXTENSION(sandbox_extension, extension_board_scan);
 #endif
 
 #ifdef CONFIG_BOARD_LATE_INIT

-- 
2.43.0

