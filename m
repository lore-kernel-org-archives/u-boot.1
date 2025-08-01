Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67978C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 12:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 635CC83AAE;
	Fri,  1 Aug 2025 14:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="aMLaot1g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 354A283A8C; Fri,  1 Aug 2025 14:33:45 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D9CF83A84
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 14:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=301ae58c2=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1754051622; x=1785587622;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1nk52t0+L7Mof9w5q4qoeZ6clGiFrQUlH+ZNkLFIS1E=;
 b=aMLaot1gjVMZgaKnxG/siLXPFklIKYIYqacwdgS2t1osEJoVv9DLUWZP
 sWamrOkZX2L6I2oI0sQynWer2Ty4dOL6Y13AYwjqWoX7UKouY+PGU+mAf
 EiTbhRaG9AbN4ckpyJxcMm1nnxoBs08JTSucRFaUD4KMwsd8qPOr0nGix
 PxeU2R8wfvwxtj9OpicMQLioqwIrTiPKlyZLdMW2l95gvg9OcQ2Pvj79X
 XvlY1JlJk4/cvv8Ib175W9/6qpW60Ha33yy6a+aXGiizRZ3Mhhngp9bny
 g0VIdZ4ToqhUuQ1LO6A6DOZyD4FnY69FgPtrHLb+BIng9SpDNQmj6Wy0a A==;
X-CSE-ConnectionGUID: shIRiUSSTtOu5z34fSbi5g==
X-CSE-MsgGUID: tI3tmWkRT7O0n75IbozAMA==
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="212121938"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Aug 2025 05:33:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 1 Aug 2025 05:33:17 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 1 Aug 2025 05:33:16 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 6/6] board: microchip: mpfs_icicle: update to use system
 controller
Date: Fri, 1 Aug 2025 13:36:26 +0100
Message-ID: <20250801123626.1972658-7-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801123626.1972658-1-jamie.gibbons@microchip.com>
References: <20250801123626.1972658-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 01 Aug 2025 14:41:57 +0200
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

A new system controller driver has been created to make code modular and
improve and clean code. Update and remove functions to account for these
additional drivers.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 board/microchip/mpfs_icicle/mpfs_icicle.c | 72 ++++++++++-------------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mpfs_icicle/mpfs_icicle.c
index 19acbbba42b..739a9b6cd76 100644
--- a/board/microchip/mpfs_icicle/mpfs_icicle.c
+++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
@@ -4,55 +4,22 @@
  * Padmarao Begari <padmarao.begari@microchip.com>
  */
 
-#include <dm.h>
-#include <env.h>
-#include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/sections.h>
+#include <dm.h>
+#include <dm/devres.h>
+#include <env.h>
+#include <linux/compat.h>
+#include <mpfs-mailbox.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define MPFS_SYSREG_SOFT_RESET		((unsigned int *)0x20002088)
-#define MPFS_SYS_SERVICE_CR		((unsigned int *)0x37020050)
-#define MPFS_SYS_SERVICE_SR		((unsigned int *)0x37020054)
-#define MPFS_SYS_SERVICE_MAILBOX	((unsigned char *)0x37020800)
-
+#define MPFS_SYSREG_SOFT_RESET	((unsigned int *)0x20002088)
 #define PERIPH_RESET_VALUE		0x1e8u
-#define SERVICE_CR_REQ			0x1u
-#define SERVICE_SR_BUSY			0x2u
 
 static unsigned char mac_addr[6];
 
-static void read_device_serial_number(u8 *response, u8 response_size)
-{
-	u8 idx;
-	u8 *response_buf;
-	unsigned int val;
-
-	response_buf = (u8 *)response;
-
-	writel(SERVICE_CR_REQ, MPFS_SYS_SERVICE_CR);
-	/*
-	 * REQ bit will remain set till the system controller starts
-	 * processing.
-	 */
-	do {
-		val = readl(MPFS_SYS_SERVICE_CR);
-	} while (SERVICE_CR_REQ == (val & SERVICE_CR_REQ));
-
-	/*
-	 * Once system controller starts processing the busy bit will
-	 * go high and service is completed when busy bit is gone low
-	 */
-	do {
-		val = readl(MPFS_SYS_SERVICE_SR);
-	} while (SERVICE_SR_BUSY == (val & SERVICE_SR_BUSY));
-
-	for (idx = 0; idx < response_size; idx++)
-		response_buf[idx] = readb(MPFS_SYS_SERVICE_MAILBOX + idx);
-}
-
 #if defined(CONFIG_MULTI_DTB_FIT)
 int board_fit_config_name_match(const char *name)
 {
@@ -149,8 +116,33 @@ int board_late_init(void)
 	int node;
 	u8 device_serial_number[16] = {0};
 	void *blob = (void *)gd->fdt_blob;
+	struct udevice *dev;
+	struct mpfs_sys_serv *sys_serv_priv;
+
+	ret = uclass_get_device_by_name(UCLASS_MISC, "syscontroller", &dev);
+	if (ret) {
+		debug("%s: system controller setup failed\n", __func__);
+		return ret;
+	}
 
-	read_device_serial_number(device_serial_number, 16);
+	sys_serv_priv = kzalloc(sizeof(*sys_serv_priv), GFP_KERNEL);
+	if (!sys_serv_priv)
+		return -ENOMEM;
+
+	sys_serv_priv->dev = dev;
+
+	sys_serv_priv->sys_controller = mpfs_syscontroller_get(dev);
+	ret = IS_ERR(sys_serv_priv->sys_controller);
+	if (ret) {
+		debug("%s:  Failed to register system controller sub device ret=%d\n", __func__, ret);
+		return -ENODEV;
+	}
+
+	ret = mpfs_syscontroller_read_sernum(sys_serv_priv, device_serial_number);
+	if (ret) {
+		printf("Cannot read device serial number\n");
+		return -EINVAL;
+	}
 
 	/* Update MAC address with device serial number */
 	mac_addr[0] = 0x00;
-- 
2.43.0

