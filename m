Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EF6C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 15:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B31B7880D6;
	Tue,  9 Apr 2024 17:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="j9ooea7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CDB98817E; Tue,  9 Apr 2024 17:03:14 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5631A870AB
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 17:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=482956ac1a=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 439BGfvP025347; Tue, 9 Apr 2024 17:02:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=VmPmGS775HkIgx4dBFMjAljRi0Gc/btFJ9lwde3hqrI=; b=j9
 ooea7undIZtwjgikQ2WKHBXjGVNIFtj+DUxUs9u1foO6Mp6wLQD+cwBhvCO2NLUh
 tnQShDJFTSyLKXXTLJIi3aYOhqqqSItGxNXpaTNjJKJxVSCwRf2OfD2yAIs6dWe/
 pc4Xe8ZqX+DQOUXBYlmNoRlTLifxAekxS5yMNCet85YKF7EIaz3FVKj3aDtQdzOy
 eOn+9v6grNZ1G0WaMuz4ArX2GBPZj0Mw2lxFb4zaSyUbUMHGq4JlXhUAlw5KA9lX
 PUf7eF4PzRnxgN3Q6HOi7mQxBNwevsjBah1gBp4uNOWlmS53VfTkH/AQmHfAF/ll
 PBfF8uUZmV1QwjnNEMow==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xautfv5t2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 17:02:47 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 19D7E4002D;
 Tue,  9 Apr 2024 17:02:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 729D52207AE;
 Tue,  9 Apr 2024 17:02:20 +0200 (CEST)
Received: from localhost (10.48.86.98) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 9 Apr
 2024 17:02:20 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 01/25] configs: stm32mp13: Enable FASTBOOT
Date: Tue, 9 Apr 2024 17:01:51 +0200
Message-ID: <20240409150215.2497778-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.98]
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
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

Enable FASTBOOT relative flags for stm32mp13_defconfig.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

 configs/stm32mp13_defconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
index c893e272db9..db09e63100e 100644
--- a/configs/stm32mp13_defconfig
+++ b/configs/stm32mp13_defconfig
@@ -15,6 +15,7 @@ CONFIG_CMD_STM32PROG=y
 CONFIG_SYS_LOAD_ADDR=0xc2000000
 CONFIG_SYS_MEMTEST_START=0xc0000000
 CONFIG_SYS_MEMTEST_END=0xc4000000
+# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_DISTRO_DEFAULTS=y
@@ -53,6 +54,13 @@ CONFIG_SYS_MMC_ENV_DEV=-1
 CONFIG_ENV_MMC_USE_DT=y
 CONFIG_CLK_SCMI=y
 CONFIG_SET_DFU_ALT_INFO=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0xc0000000
+CONFIG_FASTBOOT_BUF_SIZE=0x02000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_FASTBOOT_CMD_OEM_PARTCONF=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_STM32F7=y
@@ -92,7 +100,6 @@ CONFIG_USB_GADGET_MANUFACTURER="STMicroelectronics"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0483
 CONFIG_USB_GADGET_PRODUCT_NUM=0x5720
 CONFIG_USB_GADGET_DWC2_OTG=y
-CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_ERRNO_STR=y
 # CONFIG_LMB_USE_MAX_REGIONS is not set
 CONFIG_LMB_MEMORY_REGIONS=2
-- 
2.25.1

