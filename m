Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69A1C4707B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 14:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E888787812;
	Mon, 15 Jan 2024 15:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Cpl8nga5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C366876F4; Mon, 15 Jan 2024 15:08:39 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B65908777F
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 15:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d57945=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40FDed77024475; Mon, 15 Jan 2024 15:08:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=t3aZzJfEBzyjH6pNKD0afIjEjju0saaAcgXNPDWEW0U=; b=Cp
 l8nga5v7K4UzkyYGB7E6Gh+M3gv4c2IlO4aH/uARHng9g1+/7RxNJzWDL7xloy/6
 KSHdFB6aAvHpzqeMr5tVu1rbTGJc1apkND98VYVpZ3qoWfAlbNox+Rr21VtNRUB/
 cwd1LW++jW6HHoCmtZlft8Y0pQ+ttjwQ33xeRNP7MgrmwlEcyRZa/uN39+kNdn/A
 jaBRP5hdg06B2CMvhglYuKJEUqxeszGLcD4dLkEj9DJi4Q7Flc/K7HP8UICeTgxb
 8Z/LNl42Uz9sVh8BvJHLZhAHkrUCgwSK5cM8t+vaZo2Pi5ZI1e7i8Tx8mOByaYUN
 1Il44trRfGydUxT0kudA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkma5s04k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 15:08:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 96DDF10002A;
 Mon, 15 Jan 2024 15:08:35 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8F963298668;
 Mon, 15 Jan 2024 15:08:35 +0100 (CET)
Received: from localhost (10.201.22.165) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 15:08:35 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 12/14] board: st: stm32mp2: display the board identification
Date: Mon, 15 Jan 2024 15:05:55 +0100
Message-ID: <20240115150451.v2.12.I23dadcfeb0941c41ad9d8dabeb6c70a0bb9a7b56@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
References: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
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

Add the display of the STMicroelectronics board identification saved in OTP
in stm32mp2 checkboard function.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

(no changes since v1)

 board/st/stm32mp2/stm32mp2.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
index 9a881583d904..aa7dd31996ea 100644
--- a/board/st/stm32mp2/stm32mp2.c
+++ b/board/st/stm32mp2/stm32mp2.c
@@ -9,9 +9,12 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <log.h>
+#include <misc.h>
 #include <asm/global_data.h>
 #include <asm/arch/sys_proto.h>
+#include <dm/device.h>
 #include <dm/ofnode.h>
+#include <dm/uclass.h>
 
 /*
  * Get a global data pointer
@@ -20,6 +23,9 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int checkboard(void)
 {
+	int ret;
+	u32 otp;
+	struct udevice *dev;
 	const char *fdt_compat;
 	int fdt_compat_len;
 
@@ -27,6 +33,23 @@ int checkboard(void)
 
 	log_info("Board: stm32mp2 (%s)\n", fdt_compat && fdt_compat_len ? fdt_compat : "");
 
+	/* display the STMicroelectronics board identification */
+	if (CONFIG_IS_ENABLED(CMD_STBOARD)) {
+		ret = uclass_get_device_by_driver(UCLASS_MISC,
+						  DM_DRIVER_GET(stm32mp_bsec),
+						  &dev);
+		if (!ret)
+			ret = misc_read(dev, STM32_BSEC_SHADOW(BSEC_OTP_BOARD),
+					&otp, sizeof(otp));
+		if (ret > 0 && otp)
+			log_info("Board: MB%04x Var%d.%d Rev.%c-%02d\n",
+				 otp >> 16,
+				 (otp >> 12) & 0xF,
+				 (otp >> 4) & 0xF,
+				 ((otp >> 8) & 0xF) - 1 + 'A',
+				 otp & 0xF);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

