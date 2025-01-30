Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA53BC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 16:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E4EB820F6;
	Thu, 30 Jan 2025 17:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="dste2yFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF7C82114; Thu, 30 Jan 2025 17:44:35 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4461882106
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 17:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4125720023=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UFwHaI020351;
 Thu, 30 Jan 2025 17:44:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 PL4gvKG6GbKG0++vo1SlSxiLNviibMwc1zQTIvY5uU0=; b=dste2yFjlr6e6143
 UMWnN/zvGL54KU7jRIrx2YpIDYgLPZg3AUX9+cJeGnaVwIeSR0WItXGQltrk5wQG
 ZdzeWmIJqYS1ZyN6Re+oJBZn0F3Hyhvm2iAhjA+DnhtKTJjh/uHpwuYRvlfLb97x
 qxM4+Qa+xtBIw/CDJzAlJNDZt5uxCKgIaPIaOW5YHoW4fin6hIR/WnUzgVKa9Agj
 QaYhqj/kKZ2mvQ4mTHAnEmVbdnpk+ql1ScyKxFRdq+mF/jQk5/YAKfQo+4TGAxUm
 kTHYJcmgvb/W3BN68p7T1omaq9tuaXNPaI4+4c5BI70zpIWWkyrd8+Q7S3fy3cNv
 mcQhAA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gchmr57p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 17:44:29 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 517C840044;
 Thu, 30 Jan 2025 17:43:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A36813EC643;
 Thu, 30 Jan 2025 17:35:55 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 30 Jan
 2025 17:35:55 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 8/9] board: stih410-b2260: Remove board_usb_init/cleanup()
Date: Thu, 30 Jan 2025 17:35:46 +0100
Message-ID: <20250130163547.512990-9-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250130163547.512990-1-patrice.chotard@foss.st.com>
References: <20250130163547.512990-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_08,2025-01-30_01,2024-11-22_01
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

Since DM_USB_GADGET is enable for this board, board_usb_init()
and board_usb_cleanup() can be removed.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

---

(no changes since v3)

Changes in v3:
  - add RB Mattijs Korpershoek

 board/st/stih410-b2260/board.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/board/st/stih410-b2260/board.c b/board/st/stih410-b2260/board.c
index 3a495eb5089..8ad593cccdd 100644
--- a/board/st/stih410-b2260/board.c
+++ b/board/st/stih410-b2260/board.c
@@ -7,10 +7,6 @@
 #include <cpu_func.h>
 #include <init.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
-#include <linux/usb/otg.h>
-#include <dwc3-uboot.h>
-#include <usb.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -42,31 +38,6 @@ int board_init(void)
 }
 
 #ifdef CONFIG_USB_DWC3
-static struct dwc3_device dwc3_device_data = {
-	.maximum_speed = USB_SPEED_HIGH,
-	.dr_mode = USB_DR_MODE_PERIPHERAL,
-	.index = 0,
-};
-
-int board_usb_init(int index, enum usb_init_type init)
-{
-	int node;
-	const void *blob = gd->fdt_blob;
-
-	/* find the snps,dwc3 node */
-	node = fdt_node_offset_by_compatible(blob, -1, "snps,dwc3");
-
-	dwc3_device_data.base = fdtdec_get_addr(blob, node, "reg");
-
-	return dwc3_uboot_init(&dwc3_device_data);
-}
-
-int board_usb_cleanup(int index, enum usb_init_type init)
-{
-	dwc3_uboot_exit(index);
-	return 0;
-}
-
 int g_dnl_board_usb_cable_connected(void)
 {
 	return 1;
-- 
2.25.1

