Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B59C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 23:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5682C883A4;
	Sat, 20 Jul 2024 01:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721431479;
	bh=+q88Y2MFt2WwHoz8agFIXlZZTORkmZuvt8/UGToAhyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jt7FwYApVBubu6qNN3z6ugfZ1d9hP6E/X93wmxzQL/k+lODMM79XrQkm3w8soPDbl
	 hAJvnRMq66PU5PkrlyaKlroPNHMl/zJdq1vPyPKipBiBLAXLVRiCWacDtFRMR4yRaj
	 pxiFtI4KvXO1vnn1tuhNVPNm+UY/se4mdHHiV3pT9sWOEethqOCmeCeARQMjQtazBa
	 2pVfJh/fHRvXZxSYDU0uKKp6cu78D0zdDJ996qY61yqo9ZENjdMb0uLsQ3GO7Oupj6
	 HFqN6qGnwyvwOTr0e3vTtid/0sXupFRn43o4vWc0KD9modg0Wf8XwN3sYsC8TVesE6
	 5mHJPEhAjrYKw==
Received: from crub.agik.hopto.org (p508b6272.dip0.t-ipconnect.de
 [80.139.98.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 51C0F86BF1;
 Sat, 20 Jul 2024 01:24:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721431477;
 bh=+q88Y2MFt2WwHoz8agFIXlZZTORkmZuvt8/UGToAhyw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t3CUiXwjLSh90cObDV5Cm/gnX08knhOHCvQBTvU85gvzGbsRclu26N3f/RxMi5hoP
 WQmOD0bMSdTpfI77+D4C7hJgN6ApRvO7XUudZk6sBB5g0nB7JJvwNgYsIqRPa3x+cr
 AcgxLy1eg/jdVcTciIk50M/mb1HYk5ImU5ipeVOP+qlqZLSV8HdGZom+juxy36REvn
 Ug+kAaXcbaj+lnFR/l+CABl7Zvw/0YG3Hx9uRTKOVk0vhItmS62citGDICZ2RTQONp
 yL8tW3/Rc7Q74Xu2gMFP1aV8MWjH8Oyxx5WifBJoyOFHbAhmxLLiemUGk+7dxo5RJX
 EDUA3UwejxgYQ==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: [PATCH v2] board: keymile: convert to CONFIG_DM_I2C
Date: Sat, 20 Jul 2024 01:24:22 +0200
Message-Id: <20240719232422.3403700-1-agust@denx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719191656.3323947-1-agust@denx.de>
References: <20240719191656.3323947-1-agust@denx.de>
MIME-Version: 1.0
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

The conversion to DM_I2C is mandatory, rework to remove
use of legacy I2C API.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>
Cc: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
---

Changes in v2:
 - convert pg_wcom_expu1_update_defconfig and
   pg_wcom_seli8_update_defconfig files
 - remove obsolete CONFIG_SYS_I2C_MXC_I2C* in all defconfigs

 board/keymile/Kconfig                          |  3 ---
 board/keymile/common/common.c                  | 12 ------------
 board/keymile/common/common.h                  |  3 +--
 board/keymile/common/ivm.c                     | 18 ++++++------------
 .../keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c  |  8 +++++++-
 configs/pg_wcom_expu1_defconfig                |  8 ++++----
 configs/pg_wcom_expu1_update_defconfig         |  8 ++++----
 configs/pg_wcom_seli8_defconfig                |  8 ++++----
 configs/pg_wcom_seli8_update_defconfig         |  8 ++++----
 include/configs/km/pg-wcom-ls102xa.h           | 13 -------------
 10 files changed, 30 insertions(+), 59 deletions(-)

diff --git a/board/keymile/Kconfig b/board/keymile/Kconfig
index f7e9b74f57..4145881385 100644
--- a/board/keymile/Kconfig
+++ b/board/keymile/Kconfig
@@ -11,9 +11,6 @@ if VENDOR_KM
 
 menu "KM Board Setup"
 
-config SYS_I2C_INIT_BOARD
-	def_bool y if ARM
-
 config HUSH_INIT_VAR
 	def_bool y
 
diff --git a/board/keymile/common/common.c b/board/keymile/common/common.c
index 9358c25dcb..25897af2d8 100644
--- a/board/keymile/common/common.c
+++ b/board/keymile/common/common.c
@@ -129,7 +129,6 @@ void check_for_uboot_update(void)
 }
 #endif
 
-#if defined(CONFIG_SYS_I2C_INIT_BOARD)
 static void i2c_write_start_seq(void)
 {
 	set_sda(1);
@@ -187,17 +186,6 @@ int i2c_make_abort(void)
 	return ret;
 }
 
-/**
- * i2c_init_board - reset i2c bus. When the board is powercycled during a
- * bus transfer it might hang; for details see doc/I2C_Edge_Conditions.
- */
-void i2c_init_board(void)
-{
-	/* Now run the AbortSequence() */
-	i2c_make_abort();
-}
-#endif
-
 #if defined(CONFIG_KM_COMMON_ETH_INIT)
 int board_eth_init(struct bd_info *bis)
 {
diff --git a/board/keymile/common/common.h b/board/keymile/common/common.h
index d16c82487b..7d2fdffe98 100644
--- a/board/keymile/common/common.h
+++ b/board/keymile/common/common.h
@@ -138,13 +138,12 @@ void early_bootcount_store(ulong ebootcount);
 void check_for_uboot_update(void);
 
 #define DELAY_ABORT_SEQ		62  /* @200kHz 9 clocks = 44us, 62us is ok */
-#define DELAY_HALF_PERIOD	(500 / (CONFIG_SYS_I2C_SPEED / 1000))
+#define DELAY_HALF_PERIOD	(500 / (I2C_SPEED_STANDARD_RATE / 1000))
 
 void set_sda(int state);
 void set_scl(int state);
 int get_sda(void);
 int get_scl(void);
 
-int i2c_soft_read_pin(void);
 int i2c_make_abort(void);
 #endif /* __KEYMILE_COMMON_H */
diff --git a/board/keymile/common/ivm.c b/board/keymile/common/ivm.c
index f01fe44303..9360c86566 100644
--- a/board/keymile/common/ivm.c
+++ b/board/keymile/common/ivm.c
@@ -342,9 +342,8 @@ static int ivm_populate_env(unsigned char *buf, int len, int mac_address_offset)
 
 int ivm_read_eeprom(unsigned char *buf, int len, int mac_address_offset)
 {
-	int ret;
-#if CONFIG_IS_ENABLED(DM_I2C)
 	struct udevice *eedev = NULL;
+	int ret;
 
 	ret = i2c_get_chip_for_busnum(CONFIG_KM_IVM_BUS,
 				      CONFIG_SYS_IVM_EEPROM_ADR, 1, &eedev);
@@ -354,22 +353,17 @@ int ivm_read_eeprom(unsigned char *buf, int len, int mac_address_offset)
 		return 1;
 	}
 
+#if CONFIG_IS_ENABLED(ARCH_LS1021A)
+	/* add deblocking here */
+	i2c_make_abort();
+#endif
+
 	ret = dm_i2c_read(eedev, 0, buf, len);
 	if (ret != 0) {
 		printf("Error: Unable to read from I2C EEPROM at address %02X:%02X\n",
 		       CONFIG_SYS_IVM_EEPROM_ADR, 0);
 		return 1;
 	}
-#else
-	i2c_set_bus_num(CONFIG_KM_IVM_BUS);
-	/* add deblocking here */
-	i2c_make_abort();
 
-	ret = i2c_read(CONFIG_SYS_IVM_EEPROM_ADR, 0, 1, buf, len);
-	if (ret != 0) {
-		printf("Error reading EEprom\n");
-		return -2;
-	}
-#endif
 	return ivm_populate_env(buf, len, mac_address_offset);
 }
diff --git a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c b/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
index cc3611e2de..409a55ebda 100644
--- a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
+++ b/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
@@ -5,7 +5,6 @@
 
 #include <config.h>
 #include <event.h>
-#include <i2c.h>
 #include <asm/io.h>
 #include <asm/arch/immap_ls102xa.h>
 #include <asm/arch/clock.h>
@@ -107,6 +106,13 @@ int board_early_init_f(void)
 
 	arch_soc_init();
 
+	/*
+	 * Reset I2C bus. When the board is powercycled during a bus
+	 * transfer it might hang; for details see doc/I2C_Edge_Conditions.
+	 * Now run the AbortSequence()
+	 */
+	i2c_make_abort();
+
 	return 0;
 }
 
diff --git a/configs/pg_wcom_expu1_defconfig b/configs/pg_wcom_expu1_defconfig
index 61513c9e2e..2f3ff9ac9c 100644
--- a/configs/pg_wcom_expu1_defconfig
+++ b/configs/pg_wcom_expu1_defconfig
@@ -8,9 +8,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SOURCE_FILE="pg-wcom-expu1"
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
+CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="ls1021a-pg-wcom-expu1"
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
@@ -78,7 +76,9 @@ CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_DDR_CLK_FREQ=50000000
 CONFIG_SYS_FSL_DDR3=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
diff --git a/configs/pg_wcom_expu1_update_defconfig b/configs/pg_wcom_expu1_update_defconfig
index ec0f975ae3..d7ab3c86fd 100644
--- a/configs/pg_wcom_expu1_update_defconfig
+++ b/configs/pg_wcom_expu1_update_defconfig
@@ -8,9 +8,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SOURCE_FILE="pg-wcom-expu1"
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
+CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="ls1021a-pg-wcom-expu1"
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
@@ -76,7 +74,9 @@ CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_DDR_CLK_FREQ=50000000
 CONFIG_SYS_FSL_DDR3=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
diff --git a/configs/pg_wcom_seli8_defconfig b/configs/pg_wcom_seli8_defconfig
index 82923d32ca..bd3ac2e18a 100644
--- a/configs/pg_wcom_seli8_defconfig
+++ b/configs/pg_wcom_seli8_defconfig
@@ -8,9 +8,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SOURCE_FILE="pg-wcom-seli8"
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
+CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="ls1021a-pg-wcom-seli8"
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
@@ -78,7 +76,9 @@ CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_DDR_CLK_FREQ=50000000
 CONFIG_SYS_FSL_DDR3=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
diff --git a/configs/pg_wcom_seli8_update_defconfig b/configs/pg_wcom_seli8_update_defconfig
index 41931e2476..733050110b 100644
--- a/configs/pg_wcom_seli8_update_defconfig
+++ b/configs/pg_wcom_seli8_update_defconfig
@@ -8,9 +8,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SOURCE_FILE="pg-wcom-seli8"
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
+CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="ls1021a-pg-wcom-seli8"
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
@@ -76,7 +74,9 @@ CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_DDR_CLK_FREQ=50000000
 CONFIG_SYS_FSL_DDR3=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
diff --git a/include/configs/km/pg-wcom-ls102xa.h b/include/configs/km/pg-wcom-ls102xa.h
index 15ef68a050..3a243d789c 100644
--- a/include/configs/km/pg-wcom-ls102xa.h
+++ b/include/configs/km/pg-wcom-ls102xa.h
@@ -145,19 +145,6 @@
  */
 #define CFG_SYS_NS16550_CLK		get_serial_clock()
 
-/*
- * I2C
- */
-
-#define CFG_SYS_I2C_MAX_HOPS		1
-#define CFG_SYS_NUM_I2C_BUSES	3
-#define I2C_MUX_PCA_ADDR		0x70
-#define I2C_MUX_CH_DEFAULT		0x0
-#define CFG_SYS_I2C_BUSES	{	{0, {I2C_NULL_HOP} }, \
-					{0, {{I2C_MUX_PCA9547, 0x70, 1 } } }, \
-					{1, {I2C_NULL_HOP}                 }, \
-				}
-
 #define CFG_SMP_PEN_ADDR		0x01ee0200
 
 #define HWCONFIG_BUFFER_SIZE		256
-- 
2.25.1

