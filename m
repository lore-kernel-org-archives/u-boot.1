Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13849C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 12:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54BE68743A;
	Mon, 15 Jan 2024 13:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="EfaWxRWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F15D2876CB; Mon, 15 Jan 2024 13:48:31 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78EF587530
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 13:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d57945=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40F8IxEM002788; Mon, 15 Jan 2024 13:48:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=Yr2PIjTGAiX9VDNwm9ubQPK5zMFh9kkKbdnsGiF0VZc=; b=Ef
 aWxRWgQ2s+tkNpEFZamQmD5IakDL3pI+JhGK5FBH4oHFZtjmEZ01+FyW38qAr6Vp
 CG52mjCd3h55FFqgKlR8Wecb72pdBHkqeExgSQXP1zmKCC9Qn7FJjxv9MmABov2G
 xm1pNnKsuLk+iQ52Xz51/rpRBnzWQRXl0Qk/TgoRlx14JhsWrvKIPrYpek2roQxm
 u2im2fchoS5tH8Dakf9uAfZuyh0EmsG2sfQdQ/bhMoqTgVPCf6oGcXxivUR1iwW5
 Z6ukRDH3MZ8yaYV/84KQHKbMDk0ZcH0uHaP7Blfa5BApzjYFCooG/TzvKgaLwY5t
 NuMwbTGBmVg4TgBL0Q2w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vm6bnwy27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 13:48:25 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4343310002A;
 Mon, 15 Jan 2024 13:48:25 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 39A5D2721D7;
 Mon, 15 Jan 2024 13:48:25 +0100 (CET)
Received: from localhost (10.201.22.165) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 13:48:24 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Bhupesh Sharma
 <bhupesh.sharma@linaro.org>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Patrice Chotard
 <patrice.chotard@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 08/12] smt32mp: add setup_mac_address for stm32mp25
Date: Mon, 15 Jan 2024 13:46:53 +0100
Message-ID: <20240115134642.8.Ifc2389c624c7de76bda3fa91484d4be8fc71ba1f@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115124657.39109-1-patrick.delaunay@foss.st.com>
References: <20240115124657.39109-1-patrick.delaunay@foss.st.com>
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

Add a function setup_mac_address() to update the MAC address from the
default location in OTP for stm32mp2 platform.

The max number of OTP for MAC address is increased to 8 for STM32MP25,
defined with get_eth_nb() and checked in setup_mac_address.

The MAC address FF:FF:FF:FF:FF:FF, the broadcast ethaddr, is a invalid
value used for unused MAC address slot in OTP, for example for board
with STM32MP25x part number allows up to 5 ethernet ports but it is not
supported by the hardware, without switch; the associated variable
"enetaddr%d" is not created.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm/mach-stm32mp/soc.c          | 70 ++++++++++++++++++++++++++++
 arch/arm/mach-stm32mp/stm32mp1/cpu.c | 58 +----------------------
 arch/arm/mach-stm32mp/stm32mp2/cpu.c |  1 +
 3 files changed, 72 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-stm32mp/soc.c b/arch/arm/mach-stm32mp/soc.c
index ff70ebe97464..fa56b0d2e0f1 100644
--- a/arch/arm/mach-stm32mp/soc.c
+++ b/arch/arm/mach-stm32mp/soc.c
@@ -5,10 +5,14 @@
 
 #include <env.h>
 #include <misc.h>
+#include <net.h>
 #include <asm/arch/sys_proto.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 
+/* max: 8 OTP for 5 mac address on stm32mp2*/
+#define MAX_NB_OTP	8
+
 /* used when CONFIG_DISPLAY_CPUINFO is activated */
 int print_cpuinfo(void)
 {
@@ -46,3 +50,69 @@ int setup_serial_number(void)
 
 	return 0;
 }
+
+/*
+ * If there is no MAC address in the environment, then it will be initialized
+ * (silently) from the value in the OTP.
+ */
+__weak int setup_mac_address(void)
+{
+	int ret;
+	int i;
+	u32 otp[MAX_NB_OTP];
+	uchar enetaddr[ARP_HLEN];
+	struct udevice *dev;
+	int nb_eth, nb_otp, index;
+
+	if (!IS_ENABLED(CONFIG_NET))
+		return 0;
+
+	nb_eth = get_eth_nb();
+	if (!nb_eth)
+		return 0;
+
+	/* 6 bytes for each MAC addr and 4 bytes for each OTP */
+	nb_otp = DIV_ROUND_UP(ARP_HLEN * nb_eth, 4);
+	if (nb_otp > MAX_NB_OTP) {
+		log_err("invalid number of OTP = %d, max = %d\n", nb_otp, MAX_NB_OTP);
+		return -EINVAL;
+	}
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(stm32mp_bsec),
+					  &dev);
+	if (ret)
+		return ret;
+
+	ret = misc_read(dev, STM32_BSEC_SHADOW(BSEC_OTP_MAC), otp, 4 * nb_otp);
+	if (ret < 0)
+		return ret;
+
+	for (index = 0; index < nb_eth; index++) {
+		/* MAC already in environment */
+		if (eth_env_get_enetaddr_by_index("eth", index, enetaddr))
+			continue;
+
+		for (i = 0; i < ARP_HLEN; i++)
+			enetaddr[i] = ((uint8_t *)&otp)[i + ARP_HLEN * index];
+
+		/* skip FF:FF:FF:FF:FF:FF */
+		if (is_broadcast_ethaddr(enetaddr))
+			continue;
+
+		if (!is_valid_ethaddr(enetaddr)) {
+			log_err("invalid MAC address %d in OTP %pM\n",
+				index, enetaddr);
+			return -EINVAL;
+		}
+		log_debug("OTP MAC address %d = %pM\n", index, enetaddr);
+		ret = eth_env_set_enetaddr_by_index("eth", index, enetaddr);
+		if (ret) {
+			log_err("Failed to set mac address %pM from OTP: %d\n",
+				enetaddr, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index f84cb26fa565..524778f00c67 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -14,8 +14,8 @@
 #include <log.h>
 #include <lmb.h>
 #include <misc.h>
-#include <net.h>
 #include <spl.h>
+#include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/arch/stm32.h>
 #include <asm/arch/sys_proto.h>
@@ -280,62 +280,6 @@ static void setup_boot_mode(void)
 	clrsetbits_le32(TAMP_BOOT_CONTEXT, TAMP_BOOT_FORCED_MASK, BOOT_NORMAL);
 }
 
-/*
- * If there is no MAC address in the environment, then it will be initialized
- * (silently) from the value in the OTP.
- */
-__weak int setup_mac_address(void)
-{
-	int ret;
-	int i;
-	u32 otp[3];
-	uchar enetaddr[6];
-	struct udevice *dev;
-	int nb_eth, nb_otp, index;
-
-	if (!IS_ENABLED(CONFIG_NET))
-		return 0;
-
-	nb_eth = get_eth_nb();
-
-	/* 6 bytes for each MAC addr and 4 bytes for each OTP */
-	nb_otp = DIV_ROUND_UP(6 * nb_eth, 4);
-
-	ret = uclass_get_device_by_driver(UCLASS_MISC,
-					  DM_DRIVER_GET(stm32mp_bsec),
-					  &dev);
-	if (ret)
-		return ret;
-
-	ret = misc_read(dev, STM32_BSEC_SHADOW(BSEC_OTP_MAC), otp, 4 * nb_otp);
-	if (ret < 0)
-		return ret;
-
-	for (index = 0; index < nb_eth; index++) {
-		/* MAC already in environment */
-		if (eth_env_get_enetaddr_by_index("eth", index, enetaddr))
-			continue;
-
-		for (i = 0; i < 6; i++)
-			enetaddr[i] = ((uint8_t *)&otp)[i + 6 * index];
-
-		if (!is_valid_ethaddr(enetaddr)) {
-			log_err("invalid MAC address %d in OTP %pM\n",
-				index, enetaddr);
-			return -EINVAL;
-		}
-		log_debug("OTP MAC address %d = %pM\n", index, enetaddr);
-		ret = eth_env_set_enetaddr_by_index("eth", index, enetaddr);
-		if (ret) {
-			log_err("Failed to set mac address %pM from OTP: %d\n",
-				enetaddr, ret);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 __weak void stm32mp_misc_init(void)
 {
 }
diff --git a/arch/arm/mach-stm32mp/stm32mp2/cpu.c b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
index 301e365cf4f4..9530aa8534b7 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
@@ -70,6 +70,7 @@ void enable_caches(void)
 int arch_misc_init(void)
 {
 	setup_serial_number();
+	setup_mac_address();
 
 	return 0;
 }
-- 
2.25.1

