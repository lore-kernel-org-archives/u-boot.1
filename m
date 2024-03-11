Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F02C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 12:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F9388011;
	Mon, 11 Mar 2024 13:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17AEA87FED; Mon, 11 Mar 2024 13:03:11 +0100 (CET)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch
 [84.16.66.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A7587F3D
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:02:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ttb4v3f6MzMq4BW;
 Mon, 11 Mar 2024 13:02:55 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Ttb4t44Yqz1sc; Mon, 11 Mar 2024 13:02:54 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 11 Mar 2024 13:01:52 +0100
Subject: [PATCH v4 09/20] rockchip: merge misc.c into board.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-jaguar-v4-9-d2ca1af68ed3@theobroma-systems.com>
References: <20240311-jaguar-v4-0-d2ca1af68ed3@theobroma-systems.com>
In-Reply-To: <20240311-jaguar-v4-0-d2ca1af68ed3@theobroma-systems.com>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Otavio Salvador <otavio@ossystems.com.br>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The functions aren't used anywhere else than in board.c, therefore,
let's not expose them anymore at all.

This merges misc.c and board.c together and removes the functions from
the misc.h header file.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/include/asm/arch-rockchip/misc.h |   5 --
 arch/arm/mach-rockchip/Makefile           |   1 -
 arch/arm/mach-rockchip/board.c            | 125 +++++++++++++++++++++++++++
 arch/arm/mach-rockchip/misc.c             | 135 ------------------------------
 4 files changed, 125 insertions(+), 141 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/misc.h b/arch/arm/include/asm/arch-rockchip/misc.h
index 4155af8c3b0..ef37ff1661a 100644
--- a/arch/arm/include/asm/arch-rockchip/misc.h
+++ b/arch/arm/include/asm/arch-rockchip/misc.h
@@ -6,9 +6,4 @@
  *      Rohan Garg <rohan.garg@collabora.com>
  */
 
-int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
-			      const u32 cpuid_length,
-			      u8 *cpuid);
-int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length);
-int rockchip_setup_macaddr(void);
 void rockchip_capsule_update_board_setup(void);
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 1dc92066bbf..c07bdaee4c3 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -23,7 +23,6 @@ ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
 # meaning "turn it off".
 obj-y += boot_mode.o
 obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
-obj-$(CONFIG_MISC_INIT_R) += misc.o
 endif
 
 ifeq ($(CONFIG_TPL_BUILD),)
diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index d5cb59c10fa..80b4514852f 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -1,20 +1,32 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd.
+ *
+ * Copyright (C) 2019 Collabora Inc - https://www.collabora.com/
+ *      Rohan Garg <rohan.garg@collabora.com>
+ *
+ * Based on puma-rk3399.c:
+ *      (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
  */
 #include <common.h>
 #include <clk.h>
 #include <cpu_func.h>
+#include <env.h>
 #include <dm.h>
 #include <efi_loader.h>
 #include <fastboot.h>
+#include <hash.h>
 #include <init.h>
 #include <log.h>
 #include <mmc.h>
+#include <dm/uclass-internal.h>
+#include <misc.h>
 #include <part.h>
 #include <ram.h>
 #include <syscon.h>
 #include <uuid.h>
+#include <u-boot/crc.h>
+#include <u-boot/sha256.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/boot_mode.h>
@@ -297,6 +309,119 @@ int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 #endif
 
 #ifdef CONFIG_MISC_INIT_R
+int rockchip_setup_macaddr(void)
+{
+#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
+	int ret;
+	const char *cpuid = env_get("cpuid#");
+	u8 hash[SHA256_SUM_LEN];
+	int size = sizeof(hash);
+	u8 mac_addr[6];
+
+	/* Only generate a MAC address, if none is set in the environment */
+	if (env_get("ethaddr"))
+		return 0;
+
+	if (!cpuid) {
+		debug("%s: could not retrieve 'cpuid#'\n", __func__);
+		return -1;
+	}
+
+	ret = hash_block("sha256", (void *)cpuid, strlen(cpuid), hash, &size);
+	if (ret) {
+		debug("%s: failed to calculate SHA256\n", __func__);
+		return -1;
+	}
+
+	/* Copy 6 bytes of the hash to base the MAC address on */
+	memcpy(mac_addr, hash, 6);
+
+	/* Make this a valid MAC address and set it */
+	mac_addr[0] &= 0xfe;  /* clear multicast bit */
+	mac_addr[0] |= 0x02;  /* set local assignment bit (IEEE802) */
+	eth_env_set_enetaddr("ethaddr", mac_addr);
+
+	/* Make a valid MAC address for ethernet1 */
+	mac_addr[5] ^= 0x01;
+	eth_env_set_enetaddr("eth1addr", mac_addr);
+#endif
+	return 0;
+}
+
+int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
+			      const u32 cpuid_length,
+			      u8 *cpuid)
+{
+#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE) || IS_ENABLED(CONFIG_ROCKCHIP_OTP)
+	struct udevice *dev;
+	int ret;
+
+	/* retrieve the device */
+#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE)
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(rockchip_efuse), &dev);
+#elif IS_ENABLED(CONFIG_ROCKCHIP_OTP)
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(rockchip_otp), &dev);
+#endif
+	if (ret) {
+		debug("%s: could not find efuse device\n", __func__);
+		return -1;
+	}
+
+	/* read the cpu_id range from the efuses */
+	ret = misc_read(dev, cpuid_offset, cpuid, cpuid_length);
+	if (ret < 0) {
+		debug("%s: reading cpuid from the efuses failed\n",
+		      __func__);
+		return -1;
+	}
+#endif
+	return 0;
+}
+
+int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length)
+{
+	u8 low[cpuid_length / 2], high[cpuid_length / 2];
+	char cpuid_str[cpuid_length * 2 + 1];
+	u64 serialno;
+	char serialno_str[17];
+	const char *oldid;
+	int i;
+
+	memset(cpuid_str, 0, sizeof(cpuid_str));
+	for (i = 0; i < cpuid_length; i++)
+		sprintf(&cpuid_str[i * 2], "%02x", cpuid[i]);
+
+	debug("cpuid: %s\n", cpuid_str);
+
+	/*
+	 * Mix the cpuid bytes using the same rules as in
+	 *   ${linux}/drivers/soc/rockchip/rockchip-cpuinfo.c
+	 */
+	for (i = 0; i < cpuid_length / 2; i++) {
+		low[i] = cpuid[1 + (i << 1)];
+		high[i] = cpuid[i << 1];
+	}
+
+	serialno = crc32_no_comp(0, low, cpuid_length / 2);
+	serialno |= (u64)crc32_no_comp(serialno, high, cpuid_length / 2) << 32;
+	snprintf(serialno_str, sizeof(serialno_str), "%016llx", serialno);
+
+	oldid = env_get("cpuid#");
+	if (oldid && strcmp(oldid, cpuid_str) != 0)
+		printf("cpuid: value %s present in env does not match hardware %s\n",
+		       oldid, cpuid_str);
+
+	env_set("cpuid#", cpuid_str);
+
+	/* Only generate serial# when none is set yet */
+	if (!env_get("serial#"))
+		env_set("serial#", serialno_str);
+
+	return 0;
+}
+
 __weak int rockchip_early_misc_init_r(void)
 {
 	return 0;
diff --git a/arch/arm/mach-rockchip/misc.c b/arch/arm/mach-rockchip/misc.c
deleted file mode 100644
index 15397cff009..00000000000
--- a/arch/arm/mach-rockchip/misc.c
+++ /dev/null
@@ -1,135 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * RK3399: Architecture common definitions
- *
- * Copyright (C) 2019 Collabora Inc - https://www.collabora.com/
- *      Rohan Garg <rohan.garg@collabora.com>
- *
- * Based on puma-rk3399.c:
- *      (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
- */
-
-#include <common.h>
-#include <env.h>
-#include <dm.h>
-#include <hash.h>
-#include <log.h>
-#include <dm/uclass-internal.h>
-#include <misc.h>
-#include <u-boot/crc.h>
-#include <u-boot/sha256.h>
-
-#include <asm/arch-rockchip/misc.h>
-
-int rockchip_setup_macaddr(void)
-{
-#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
-	int ret;
-	const char *cpuid = env_get("cpuid#");
-	u8 hash[SHA256_SUM_LEN];
-	int size = sizeof(hash);
-	u8 mac_addr[6];
-
-	/* Only generate a MAC address, if none is set in the environment */
-	if (env_get("ethaddr"))
-		return 0;
-
-	if (!cpuid) {
-		debug("%s: could not retrieve 'cpuid#'\n", __func__);
-		return -1;
-	}
-
-	ret = hash_block("sha256", (void *)cpuid, strlen(cpuid), hash, &size);
-	if (ret) {
-		debug("%s: failed to calculate SHA256\n", __func__);
-		return -1;
-	}
-
-	/* Copy 6 bytes of the hash to base the MAC address on */
-	memcpy(mac_addr, hash, 6);
-
-	/* Make this a valid MAC address and set it */
-	mac_addr[0] &= 0xfe;  /* clear multicast bit */
-	mac_addr[0] |= 0x02;  /* set local assignment bit (IEEE802) */
-	eth_env_set_enetaddr("ethaddr", mac_addr);
-
-	/* Make a valid MAC address for ethernet1 */
-	mac_addr[5] ^= 0x01;
-	eth_env_set_enetaddr("eth1addr", mac_addr);
-#endif
-	return 0;
-}
-
-int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
-			      const u32 cpuid_length,
-			      u8 *cpuid)
-{
-#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE) || IS_ENABLED(CONFIG_ROCKCHIP_OTP)
-	struct udevice *dev;
-	int ret;
-
-	/* retrieve the device */
-#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE)
-	ret = uclass_get_device_by_driver(UCLASS_MISC,
-					  DM_DRIVER_GET(rockchip_efuse), &dev);
-#elif IS_ENABLED(CONFIG_ROCKCHIP_OTP)
-	ret = uclass_get_device_by_driver(UCLASS_MISC,
-					  DM_DRIVER_GET(rockchip_otp), &dev);
-#endif
-	if (ret) {
-		debug("%s: could not find efuse device\n", __func__);
-		return -1;
-	}
-
-	/* read the cpu_id range from the efuses */
-	ret = misc_read(dev, cpuid_offset, cpuid, cpuid_length);
-	if (ret < 0) {
-		debug("%s: reading cpuid from the efuses failed\n",
-		      __func__);
-		return -1;
-	}
-#endif
-	return 0;
-}
-
-int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length)
-{
-	u8 low[cpuid_length / 2], high[cpuid_length / 2];
-	char cpuid_str[cpuid_length * 2 + 1];
-	u64 serialno;
-	char serialno_str[17];
-	const char *oldid;
-	int i;
-
-	memset(cpuid_str, 0, sizeof(cpuid_str));
-	for (i = 0; i < cpuid_length; i++)
-		sprintf(&cpuid_str[i * 2], "%02x", cpuid[i]);
-
-	debug("cpuid: %s\n", cpuid_str);
-
-	/*
-	 * Mix the cpuid bytes using the same rules as in
-	 *   ${linux}/drivers/soc/rockchip/rockchip-cpuinfo.c
-	 */
-	for (i = 0; i < cpuid_length / 2; i++) {
-		low[i] = cpuid[1 + (i << 1)];
-		high[i] = cpuid[i << 1];
-	}
-
-	serialno = crc32_no_comp(0, low, cpuid_length / 2);
-	serialno |= (u64)crc32_no_comp(serialno, high, cpuid_length / 2) << 32;
-	snprintf(serialno_str, sizeof(serialno_str), "%016llx", serialno);
-
-	oldid = env_get("cpuid#");
-	if (oldid && strcmp(oldid, cpuid_str) != 0)
-		printf("cpuid: value %s present in env does not match hardware %s\n",
-		       oldid, cpuid_str);
-
-	env_set("cpuid#", cpuid_str);
-
-	/* Only generate serial# when none is set yet */
-	if (!env_get("serial#"))
-		env_set("serial#", serialno_str);
-
-	return 0;
-}

-- 
2.44.0

