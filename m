Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CFEC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 16:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1AF782145;
	Thu, 30 Jan 2025 17:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="5zeEks4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A1C82107; Thu, 30 Jan 2025 17:45:06 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7643A80AE4
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 17:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4125720023=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UEUtm4015284;
 Thu, 30 Jan 2025 17:44:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 b/xt2kGbgJBa6s3VXcmCfq8Y5SF+zrWTckcBbDXzN7o=; b=5zeEks4KImEnZmbV
 D7hRYNcz9mObSRySBgGPArkvnQS8F7GyScFFtTKPgNGPHhSzdlxOn5uNguvsXjYd
 /0SgpFSVIJ+tsKvRs12WkN8ncXvjhJPgqkkPlepU7K38ojYR9W6zLA9BL+yFkBgq
 pINnUD+JMNNkNmiU5tbDkq8v8XpOg50IKBGyq2p8QLhPElbRT0of/rCd04xvHcJ0
 WeCoat5GGRpM8Xd1fRkPWTOcbQMAN+ykOPwfwFVHKTnhWjPBz8EaFBK3sKAvNmsI
 48LgNQ9lq+SA7TzS0GWzv6TFkaS4y7D2oJgaU/qK/YYw+maiBAZje2h8ivzjxiS7
 B9ktxA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gawj0pde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 17:44:59 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5212340045;
 Thu, 30 Jan 2025 17:43:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 64A223EC659;
 Thu, 30 Jan 2025 17:35:52 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 30 Jan
 2025 17:35:52 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 4/9] usb: dwc3-generic: Reorder include
Date: Thu, 30 Jan 2025 17:35:42 +0100
Message-ID: <20250130163547.512990-5-patrice.chotard@foss.st.com>
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

Reorder include following rules available here :
https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files

Remove useless include files.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Marek Vasut <marex@denx.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

---

(no changes since v3)

Changes in v3:
  - Update comment by adding "Remove useless include files"

Changes in v2:
  - remove useless include files

 drivers/usb/dwc3/dwc3-generic.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2ab41cbae45..bc7d2d4234b 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -7,29 +7,17 @@
  * Based on dwc3-omap.c.
  */
 
-#include <cpu_func.h>
-#include <log.h>
 #include <dm.h>
-#include <dm/device-internal.h>
+#include <reset.h>
+#include <asm/gpio.h>
 #include <dm/lists.h>
-#include <dwc3-uboot.h>
-#include <generic-phy.h>
-#include <linux/bitops.h>
 #include <linux/delay.h>
-#include <linux/printk.h>
-#include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <malloc.h>
 #include <power/regulator.h>
-#include <usb.h>
-#include "core.h"
-#include "gadget.h"
-#include <reset.h>
-#include <clk.h>
 #include <usb/xhci.h>
-#include <asm/gpio.h>
-
+#include "core.h"
 #include "dwc3-generic.h"
+#include "gadget.h"
 
 struct dwc3_generic_plat {
 	fdt_addr_t base;
-- 
2.25.1

