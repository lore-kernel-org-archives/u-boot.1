Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DA1CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179BC883D2;
	Thu,  4 Apr 2024 09:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a04xaVRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1866883BF; Thu,  4 Apr 2024 09:51:21 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECA4883C2
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CB13CCE2FB1;
 Thu,  4 Apr 2024 07:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D95C43390;
 Thu,  4 Apr 2024 07:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712217078;
 bh=AGhUAiCybYpJt36w1h9cgTo4ktMWme+mtjgBvilG5s8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a04xaVRtGSkdCzn9wtM0Xhn0FYOV3ZKuPI8vf7YRflzH1Ast3Wyu9D5oRnczYRvv9
 ju0d4NWtuhO48ZZp0bZq7pynOHM2WlfzXqJs9doV5Io8HpBiWZ+9fsZtmKpw+DqAD+
 PsXnJD2XUJ735A6+DA3bTBTb9N2l+e/rNvqVX3EY01oW6DPKhFNZtLkTRIPSJmHqx+
 tG525OUuK9Ru3ztjp7bX3qFZjbUKMsuj+jzeck1j73qUNCO9X+o7GwChnhkwOt5y8/
 SDUGtHdgNi+OBqtoXKNSLQaCeflxF643kXRPud6VadLYy7VBWE3WOQadQgG/Na0QlY
 uHQRNMgQyUxew==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v4 05/18] arm: mvebu: turris_omnia: Implement
 getting board information from MCU
Date: Thu,  4 Apr 2024 09:50:54 +0200
Message-ID: <20240404075107.19636-6-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240404075107.19636-1-kabel@kernel.org>
References: <20240404075107.19636-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Implement reading board serial number, first MAC address and board
version from MCU. MCU supports board information if the FEAT_BOARD_INFO
feature bit is set in MCU features.

Prefer getting board information from MCU if supported, fallback to
Atmel SHA chip.

Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Stefan Roese <sr@denx.de>
---
 board/CZ.NIC/turris_atsha_otp.c          | 27 +------
 board/CZ.NIC/turris_common.c             | 42 +++++++++++
 board/CZ.NIC/turris_common.h             | 10 +++
 board/CZ.NIC/turris_omnia/Makefile       |  2 +-
 board/CZ.NIC/turris_omnia/turris_omnia.c | 94 +++++++++++++++++++++++-
 5 files changed, 145 insertions(+), 30 deletions(-)
 create mode 100644 board/CZ.NIC/turris_common.c
 create mode 100644 board/CZ.NIC/turris_common.h

diff --git a/board/CZ.NIC/turris_atsha_otp.c b/board/CZ.NIC/turris_atsha_otp.c
index a29fe36231..85eebcdf18 100644
--- a/board/CZ.NIC/turris_atsha_otp.c
+++ b/board/CZ.NIC/turris_atsha_otp.c
@@ -11,6 +11,7 @@
 #include <atsha204a-i2c.h>
 
 #include "turris_atsha_otp.h"
+#include "turris_common.h"
 
 #define TURRIS_ATSHA_OTP_VERSION	0
 #define TURRIS_ATSHA_OTP_SERIAL		1
@@ -32,26 +33,6 @@ static struct udevice *get_atsha204a_dev(void)
 	return dev;
 }
 
-static void increment_mac(u8 *mac)
-{
-	int i;
-
-	for (i = 5; i >= 3; i--) {
-		mac[i] += 1;
-		if (mac[i])
-			break;
-	}
-}
-
-static void set_mac_if_invalid(int i, u8 *mac)
-{
-	u8 oldmac[6];
-
-	if (is_valid_ethaddr(mac) &&
-	    !eth_env_get_enetaddr_by_index("eth", i, oldmac))
-		eth_env_set_enetaddr_by_index("eth", i, mac);
-}
-
 int turris_atsha_otp_init_mac_addresses(int first_idx)
 {
 	struct udevice *dev = get_atsha204a_dev();
@@ -84,11 +65,7 @@ int turris_atsha_otp_init_mac_addresses(int first_idx)
 	mac[4] = mac1[2];
 	mac[5] = mac1[3];
 
-	set_mac_if_invalid((first_idx + 0) % 3, mac);
-	increment_mac(mac);
-	set_mac_if_invalid((first_idx + 1) % 3, mac);
-	increment_mac(mac);
-	set_mac_if_invalid((first_idx + 2) % 3, mac);
+	turris_init_mac_addresses(first_idx, mac);
 
 	return 0;
 }
diff --git a/board/CZ.NIC/turris_common.c b/board/CZ.NIC/turris_common.c
new file mode 100644
index 0000000000..1717dda82e
--- /dev/null
+++ b/board/CZ.NIC/turris_common.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Marek Behún <kabel@kernel.org>
+ */
+
+#include <env.h>
+#include <net.h>
+
+#include "turris_common.h"
+
+static void increment_mac(u8 *mac)
+{
+	int i;
+
+	for (i = 5; i >= 3; i--) {
+		mac[i] += 1;
+		if (mac[i])
+			break;
+	}
+}
+
+static void set_mac_if_invalid(int i, u8 *mac)
+{
+	u8 oldmac[6];
+
+	if (is_valid_ethaddr(mac) &&
+	    !eth_env_get_enetaddr_by_index("eth", i, oldmac))
+		eth_env_set_enetaddr_by_index("eth", i, mac);
+}
+
+void turris_init_mac_addresses(int first_idx, const u8 *first_mac)
+{
+	u8 mac[6];
+
+	memcpy(mac, first_mac, sizeof(mac));
+
+	set_mac_if_invalid((first_idx + 0) % 3, mac);
+	increment_mac(mac);
+	set_mac_if_invalid((first_idx + 1) % 3, mac);
+	increment_mac(mac);
+	set_mac_if_invalid((first_idx + 2) % 3, mac);
+}
diff --git a/board/CZ.NIC/turris_common.h b/board/CZ.NIC/turris_common.h
new file mode 100644
index 0000000000..5565ea9fd2
--- /dev/null
+++ b/board/CZ.NIC/turris_common.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef TURRIS_COMMON_H
+#define TURRIS_COMMON_H
+
+#include <asm/types.h>
+
+void turris_init_mac_addresses(int first_idx, const u8 *first_mac);
+
+#endif
diff --git a/board/CZ.NIC/turris_omnia/Makefile b/board/CZ.NIC/turris_omnia/Makefile
index dc39b44ae1..341378b4e5 100644
--- a/board/CZ.NIC/turris_omnia/Makefile
+++ b/board/CZ.NIC/turris_omnia/Makefile
@@ -2,4 +2,4 @@
 #
 # Copyright (C) 2017 Marek Behún <kabel@kernel.org>
 
-obj-y	:= turris_omnia.o ../turris_atsha_otp.o
+obj-y	:= turris_omnia.o ../turris_atsha_otp.o ../turris_common.o
diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index 6dfde5ee7a..f63640ad64 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
+#include <asm/unaligned.h>
 #include <dm/uclass.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <fdt_support.h>
@@ -25,12 +26,14 @@
 #include <time.h>
 #include <turris-omnia-mcu-interface.h>
 #include <linux/bitops.h>
+#include <linux/bitrev.h>
 #include <linux/delay.h>
 #include <u-boot/crc.h>
 
 #include "../drivers/ddr/marvell/a38x/ddr3_init.h"
 #include <../serdes/a38x/high_speed_env_spec.h>
 #include "../turris_atsha_otp.h"
+#include "../turris_common.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -186,6 +189,70 @@ static bool omnia_mcu_has_feature(u32 feature)
 	return feature & features;
 }
 
+static u32 omnia_mcu_crc32(const void *p, size_t len)
+{
+	u32 val, crc = 0;
+
+	compiletime_assert(!(len % 4), "length has to be a multiple of 4");
+
+	while (len) {
+		val = bitrev32(get_unaligned_le32(p));
+		crc = crc32(crc, (void *)&val, 4);
+		p += 4;
+		len -= 4;
+	}
+
+	return ~bitrev32(crc);
+}
+
+/* Can only be called after relocation, since it needs cleared BSS */
+static int omnia_mcu_board_info(char *serial, u8 *mac, char *version)
+{
+	static u8 reply[17];
+	static bool cached;
+
+	if (!cached) {
+		u8 csum;
+		int ret;
+
+		ret = omnia_mcu_read(CMD_BOARD_INFO_GET, reply, sizeof(reply));
+		if (ret)
+			return ret;
+
+		if (reply[0] != 16)
+			return -EBADMSG;
+
+		csum = reply[16];
+		reply[16] = 0;
+
+		if ((omnia_mcu_crc32(&reply[1], 16) & 0xff) != csum)
+			return -EBADMSG;
+
+		cached = true;
+	}
+
+	if (serial) {
+		const char *serial_env;
+
+		serial_env = env_get("serial#");
+		if (serial_env && strlen(serial_env) == 16) {
+			strcpy(serial, serial_env);
+		} else {
+			sprintf(serial, "%016llX",
+				get_unaligned_le64(&reply[1]));
+			env_set("serial#", serial);
+		}
+	}
+
+	if (mac)
+		memcpy(mac, &reply[9], ETH_ALEN);
+
+	if (version)
+		sprintf(version, "%u", reply[15]);
+
+	return 0;
+}
+
 static void enable_a385_watchdog(unsigned int timeout_minutes)
 {
 	struct sar_freq_modes sar_freq;
@@ -965,13 +1032,23 @@ int board_late_init(void)
 
 int checkboard(void)
 {
-	char serial[17];
+	char serial[17], version[4];
+	bool has_version;
 	int err;
 
-	err = turris_atsha_otp_get_serial_number(serial);
 	printf("  MCU type: %s\n", omnia_get_mcu_type());
 	printf("  MCU version: %s\n", omnia_get_mcu_version());
 	printf("  RAM size: %i MiB\n", omnia_get_ram_size_gb() * 1024);
+
+	if (omnia_mcu_has_feature(FEAT_BOARD_INFO)) {
+		err = omnia_mcu_board_info(serial, NULL, version);
+		has_version = !err;
+	} else {
+		err = turris_atsha_otp_get_serial_number(serial);
+		has_version = false;
+	}
+
+	printf("  Board version: %s\n", has_version ? version : "unknown");
 	printf("  Serial Number: %s\n", !err ? serial : "unknown");
 
 	return 0;
@@ -979,8 +1056,17 @@ int checkboard(void)
 
 int misc_init_r(void)
 {
-	turris_atsha_otp_init_mac_addresses(1);
-	turris_atsha_otp_init_serial_number();
+	if (omnia_mcu_has_feature(FEAT_BOARD_INFO)) {
+		char serial[17];
+		u8 first_mac[6];
+
+		if (!omnia_mcu_board_info(serial, first_mac, NULL))
+			turris_init_mac_addresses(1, first_mac);
+	} else {
+		turris_atsha_otp_init_mac_addresses(1);
+		turris_atsha_otp_init_serial_number();
+	}
+
 	return 0;
 }
 
-- 
2.43.2

