Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8456E7E644
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 15:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A819686E0E;
	Tue, 26 Sep 2023 17:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="SDLEgmhk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E4E86D75; Tue, 26 Sep 2023 17:10:47 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB0286DC7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 17:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QCGET0011037; Tue, 26 Sep 2023 17:10:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=4MOQYMlmQyjmyclULoKph8Qddrd1vY4Y59+xdFCTmJo=; b=SD
 LEgmhksVNDgu6us5MgWbG1hx7N1gs4bJTOKBjn7E/2VBmCSk3mjoG+acX7MbAGRe
 D7ZB3anv8A1oqEb24Qb4sVBpgGw9SLsocGrgRpdBvqUECtgv0Xf1thpzZutaf9/L
 kLtxFE9vIy89AkBUidIUuYExGHeOEA6JShHzZDfYkFEqUFwgO6aQC8faRiK1YRmY
 s6GUUj34SHQMS8SzNV+7AnrLzxTxDKEYCfpI5JBIbPpdsTcMS2ibG/VPWew/1Czv
 DmZp6nrOue775wnEp0BMcYs/3lwiS8kjPRuDO9DbWM8I2InvImWAZdp7zEYerTMn
 Y9jGsC1WZeEdEhwaEUpA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9n54dv3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 17:10:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 19CC210005C;
 Tue, 26 Sep 2023 17:10:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1301B2405B0;
 Tue, 26 Sep 2023 17:10:33 +0200 (CEST)
Received: from localhost (10.201.20.38) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 17:10:32 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v1 6/6] board: st: common: cleanup dfu support
Date: Tue, 26 Sep 2023 17:09:23 +0200
Message-ID: <20230926150924.1150082-7-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926150924.1150082-1-patrice.chotard@foss.st.com>
References: <20230926150924.1150082-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_12,2023-09-26_01,2023-05-22_02
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

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

split the file stm32mp_dfu.c in two files to simplify the Makefile
- stm32mp_dfu.c: required by CONFIG_SET_DFU_ALT_INFO
- stm32mp_dfu_virt.c: required by CONFIG_DFU_VIRT for stm32prog
  command or VIRT device for PMIC for CONFIG_SET_DFU_ALT_INFO.

This patch also remove some remaining #ifdef CONFIG
and avoid compilation error when CONFIG_SET_DFU_ALT_INFO is not
activated.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 board/st/common/Makefile           |   1 +
 board/st/common/stm32mp_dfu.c      | 103 ++---------------------------
 board/st/common/stm32mp_dfu_virt.c |  99 +++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 99 deletions(-)
 create mode 100644 board/st/common/stm32mp_dfu_virt.c

diff --git a/board/st/common/Makefile b/board/st/common/Makefile
index c9608297261..b01245e4b48 100644
--- a/board/st/common/Makefile
+++ b/board/st/common/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
 
 ifeq ($(CONFIG_ARCH_STM32MP),y)
 obj-$(CONFIG_SET_DFU_ALT_INFO) += stm32mp_dfu.o
+obj-$(CONFIG_$(SPL_)DFU_VIRT) += stm32mp_dfu_virt.o
 endif
 
 obj-$(CONFIG_TYPEC_STUSB160X) += stusb160x.o
diff --git a/board/st/common/stm32mp_dfu.c b/board/st/common/stm32mp_dfu.c
index 1cf4a3d5fa1..1ab27a91544 100644
--- a/board/st/common/stm32mp_dfu.c
+++ b/board/st/common/stm32mp_dfu.c
@@ -13,7 +13,6 @@
 #include <misc.h>
 #include <mtd.h>
 #include <mtd_node.h>
-#include <asm/arch/stm32prog.h>
 
 #define DFU_ALT_BUF_LEN SZ_1K
 
@@ -147,108 +146,14 @@ void set_dfu_alt_info(char *interface, char *devstr)
 			board_get_alt_info_mtd(mtd, buf);
 	}
 
-	if (IS_ENABLED(CONFIG_DFU_VIRT) &&
-	    IS_ENABLED(CMD_STM32PROG_USB)) {
-		strncat(buf, "&virt 0=OTP", DFU_ALT_BUF_LEN);
+	if (IS_ENABLED(CONFIG_DFU_VIRT)) {
+		/* virtual device id 0 is aligned with stm32mp_dfu_virt.c */
+		strlcat(buf, "&virt 0=OTP", DFU_ALT_BUF_LEN);
 
 		if (IS_ENABLED(CONFIG_PMIC_STPMIC1))
-			strncat(buf, "&virt 1=PMIC", DFU_ALT_BUF_LEN);
+			strlcat(buf, "&virt 1=PMIC", DFU_ALT_BUF_LEN);
 	}
 
 	env_set("dfu_alt_info", buf);
 	puts("DFU alt info setting: done\n");
 }
-
-#if CONFIG_IS_ENABLED(DFU_VIRT)
-#include <dfu.h>
-#include <power/stpmic1.h>
-
-static int dfu_otp_read(u64 offset, u8 *buffer, long *size)
-{
-	struct udevice *dev;
-	int ret;
-
-	ret = uclass_get_device_by_driver(UCLASS_MISC,
-					  DM_DRIVER_GET(stm32mp_bsec),
-					  &dev);
-	if (ret)
-		return ret;
-
-	ret = misc_read(dev, offset + STM32_BSEC_OTP_OFFSET, buffer, *size);
-	if (ret >= 0) {
-		*size = ret;
-		ret = 0;
-	}
-
-	return 0;
-}
-
-static int dfu_pmic_read(u64 offset, u8 *buffer, long *size)
-{
-	int ret;
-#ifdef CONFIG_PMIC_STPMIC1
-	struct udevice *dev;
-
-	ret = uclass_get_device_by_driver(UCLASS_MISC,
-					  DM_DRIVER_GET(stpmic1_nvm),
-					  &dev);
-	if (ret)
-		return ret;
-
-	ret = misc_read(dev, 0xF8 + offset, buffer, *size);
-	if (ret >= 0) {
-		*size = ret;
-		ret = 0;
-	}
-	if (ret == -EACCES) {
-		*size = 0;
-		ret = 0;
-	}
-#else
-	log_err("PMIC update not supported");
-	ret = -EOPNOTSUPP;
-#endif
-
-	return ret;
-}
-
-int dfu_read_medium_virt(struct dfu_entity *dfu, u64 offset,
-			 void *buf, long *len)
-{
-	switch (dfu->data.virt.dev_num) {
-	case 0x0:
-		return dfu_otp_read(offset, buf, len);
-	case 0x1:
-		return dfu_pmic_read(offset, buf, len);
-	}
-
-	if (IS_ENABLED(CONFIG_CMD_STM32PROG_USB) &&
-	    dfu->data.virt.dev_num >= STM32PROG_VIRT_FIRST_DEV_NUM)
-		return stm32prog_read_medium_virt(dfu, offset, buf, len);
-
-	*len = 0;
-	return 0;
-}
-
-int dfu_write_medium_virt(struct dfu_entity *dfu, u64 offset,
-			  void *buf, long *len)
-{
-	if (IS_ENABLED(CONFIG_CMD_STM32PROG_USB) &&
-	    dfu->data.virt.dev_num >= STM32PROG_VIRT_FIRST_DEV_NUM)
-		return stm32prog_write_medium_virt(dfu, offset, buf, len);
-
-	return -EOPNOTSUPP;
-}
-
-int __weak dfu_get_medium_size_virt(struct dfu_entity *dfu, u64 *size)
-{
-	if (IS_ENABLED(CONFIG_CMD_STM32PROG_USB) &&
-	    dfu->data.virt.dev_num >= STM32PROG_VIRT_FIRST_DEV_NUM)
-		return stm32prog_get_medium_size_virt(dfu, size);
-
-	*size = SZ_1K;
-
-	return 0;
-}
-
-#endif
diff --git a/board/st/common/stm32mp_dfu_virt.c b/board/st/common/stm32mp_dfu_virt.c
new file mode 100644
index 00000000000..f0f99605796
--- /dev/null
+++ b/board/st/common/stm32mp_dfu_virt.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+/*
+ * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
+ */
+
+#include <common.h>
+#include <dfu.h>
+#include <dm.h>
+#include <misc.h>
+#include <asm/arch/stm32prog.h>
+#include <power/stpmic1.h>
+
+static int dfu_otp_read(u64 offset, u8 *buffer, long *size)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(stm32mp_bsec),
+					  &dev);
+	if (ret)
+		return ret;
+
+	ret = misc_read(dev, offset + STM32_BSEC_OTP_OFFSET, buffer, *size);
+	if (ret >= 0) {
+		*size = ret;
+		ret = 0;
+	}
+
+	return 0;
+}
+
+static int dfu_pmic_read(u64 offset, u8 *buffer, long *size)
+{
+	int ret;
+	struct udevice *dev;
+
+	if (!IS_ENABLED(CONFIG_PMIC_STPMIC1)) {
+		log_err("PMIC update not supported");
+		return -EOPNOTSUPP;
+	}
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(stpmic1_nvm),
+					  &dev);
+	if (ret)
+		return ret;
+
+	ret = misc_read(dev, 0xF8 + offset, buffer, *size);
+	if (ret >= 0) {
+		*size = ret;
+		ret = 0;
+	}
+	if (ret == -EACCES) {
+		*size = 0;
+		ret = 0;
+	}
+
+	return ret;
+}
+
+int dfu_read_medium_virt(struct dfu_entity *dfu, u64 offset,
+			 void *buf, long *len)
+{
+	switch (dfu->data.virt.dev_num) {
+	case 0x0:
+		return dfu_otp_read(offset, buf, len);
+	case 0x1:
+		return dfu_pmic_read(offset, buf, len);
+	}
+
+	if (IS_ENABLED(CONFIG_CMD_STM32PROG_USB) &&
+	    dfu->data.virt.dev_num >= STM32PROG_VIRT_FIRST_DEV_NUM)
+		return stm32prog_read_medium_virt(dfu, offset, buf, len);
+
+	*len = 0;
+	return 0;
+}
+
+int dfu_write_medium_virt(struct dfu_entity *dfu, u64 offset,
+			  void *buf, long *len)
+{
+	if (IS_ENABLED(CONFIG_CMD_STM32PROG_USB) &&
+	    dfu->data.virt.dev_num >= STM32PROG_VIRT_FIRST_DEV_NUM)
+		return stm32prog_write_medium_virt(dfu, offset, buf, len);
+
+	return -EOPNOTSUPP;
+}
+
+int dfu_get_medium_size_virt(struct dfu_entity *dfu, u64 *size)
+{
+	if (IS_ENABLED(CONFIG_CMD_STM32PROG_USB) &&
+	    dfu->data.virt.dev_num >= STM32PROG_VIRT_FIRST_DEV_NUM)
+		return stm32prog_get_medium_size_virt(dfu, size);
+
+	*size = SZ_1K;
+
+	return 0;
+}
-- 
2.25.1

