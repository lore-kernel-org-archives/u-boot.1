Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB33C369BD
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 12:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C3E82105;
	Sat, 19 Apr 2025 14:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XimreI6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B4D8209F; Sat, 19 Apr 2025 11:44:14 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9279810F4
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 11:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso2518156b3a.0
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 02:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745055850; x=1745660650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vHFhnlC+B9D9aMB+LGki8Iy4qVX/C0gWd1F8ZA3sYP8=;
 b=XimreI6RKIajKUYsC27P2vcVrc2GQzw34G+RLUCxaAK8OII/talZZYSVyf3HxPd9hu
 3JJiN6e+bjQ0YfVk7xzeHQxTZALk2gb9mKGF+X4WSLAVjaOT9ubIWkmq6G3L+MasECW4
 LUorA8ZMnLzIEPCv6myXvLgD7/VXj//npcOVpqkHlmYOnzLYlsTnYz75l9t0u9yuZv2Z
 LI7eo2bS9RiUeIa8av8yEakdXAMiA1e6UWmS/BDxinjschnSm5MmIgB+c5zdkhdWAvaR
 EwJ1WIRbZA3rk6KcKS3TpKl0Jk3jMlIpN3ZQ7r3lT8Tmc8TK0PIsbKyWummMjfeOlG9V
 mmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745055850; x=1745660650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vHFhnlC+B9D9aMB+LGki8Iy4qVX/C0gWd1F8ZA3sYP8=;
 b=j8G9sJ1V7MS8XitiY25B3m9kErZK67zCnSvRrF0LKQlFuSvHAAuHLV76z/U+YEsSZH
 jDaA6fk1uKYFwvt+g/5wOo/RIxjR6oiXlDKPfXA3mOnj4cP99rpMokMQK2lEGhg310Rv
 X8z8i4pv+EIC8sEiYSVUdgjcDoVOeeQZpmFu63acrcY7+MZzUa6cNjJh59RCsLAKRuVa
 fz5nyNFpgrxaSAbQTj4Hi8LUmHQgUN2p3EUMWgvmu0BOoDB4nsplA5KNnIEeDxJ9V4DE
 ENun4x79iz+paQ4ynbmcOMmi6z5/DqV+rvB8rDfzDatA35JJ14YJmn1G5LM3ucHZm3Lq
 SuCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6w0xEJQkS68/tcU8oU4l+/r5bdM0MCdYPOdALx+fLcxjW59pVo1JHkNgBLglPQXOcKj5pNeA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy64KnYSNhhh26wi4csBLJJspJawisFA7EAaxtQ8nGhLAnTo78h
 pD3FkrVxhvd5UxWObV4+EESpvK0HKA52RTwnCRbHrRIpkJrtHS6j
X-Gm-Gg: ASbGnctbDhTl5lNTPYrzJq6vFhBbZwU6UznhayPackyy+VgwdtrQrN8K1IPGlj/mTvY
 J0eTryYPHjLmF9EKyZDqWlTNv1RWoq90/Tbx/tmxgV3ctGK+z7VpNTKI0g0ULTFJtiwR0kE42ce
 tG03uyeqJlSVvOLcwLjdpcmmMhR5rLLTYuxrfLGkKKrYbspE90g73WieTDiB9i0oLzmJscqXf+5
 V286U7H5HGJtplmtCGAOOCE/PvY2wB4vvwN0/4hR5mxN8MzbGDU6t1ow88CzCyqmo/dWC3Ccw1k
 usGYSAT9lg4poZXBf1Lw8RvZiwBSihK5Utvw+urWwacJw0WamuOIQJv6q9/NxChoT8CQEiQq9hx
 gGnvbnD6CcppcreOlgocL49r624UivdagpCSi
X-Google-Smtp-Source: AGHT+IGtB13ixnzWExSeNQZ/c+vQkJk6wAj+q6525z14k/vPoT2N8ypx71pnP4jO+y3ekekuFeBJ4A==
X-Received: by 2002:a05:6a00:3995:b0:736:476b:fccc with SMTP id
 d2e1a72fcca58-73dc1b5a9fcmr7707013b3a.8.1745055850064; 
 Sat, 19 Apr 2025 02:44:10 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e46basm3073776b3a.69.2025.04.19.02.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Apr 2025 02:44:09 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 marek.vasut+renesas@mailbox.org, paul.barker.ct@bp.renesas.com,
 pbrobinson@gmail.com, lucienzx159@gmail.com, u-boot@lists.denx.de
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com,
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com
Subject: [U-Boot, v1,
 1/1] net: phy: air_en8811h: load the PHY firmware from filesystem on
 block device instead
Date: Sat, 19 Apr 2025 17:43:19 +0800
Message-Id: <20250419094319.148380-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 19 Apr 2025 14:55:01 +0200
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

Locating the AIROHA FW within the filesystem at the designated partition
and path will trigger its automatic loading and writing to the PHY via MDIO.

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
 drivers/net/phy/Kconfig       | 39 ++++++++------
 drivers/net/phy/air_en8811h.c | 97 +++++++++++++++++++----------------
 2 files changed, 78 insertions(+), 58 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 5b4cf30b0a3..384cef845e1 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -94,24 +94,33 @@ choice
 	depends on PHY_AIROHA_EN8811H

 config PHY_AIROHA_FW_IN_MMC
-	bool "Airoha firmware in MMC boot1 partition"
-
-endchoice
+	bool "Airoha firmware in MMC partition"
+	help
+		Airoha PHYs use firmware which can be loaded automatically
+		from storage directly attached to the PHY, and then loaded
+		via MDIO commands by the boot loader. The firmware is loaded
+		from a file specified by the PHY_AIROHA_FW_PART,
+		PHY_AIROHA_FW_DM_FILEPATH and PHY_AIROHA_FW_DSP_FILEPATH options.
+
+config PHY_AIROHA_FW_PART
+	string "Airoha firmware partition"
+	depends on PHY_AIROHA_FW_IN_MMC
+	help
+		Partition containing the firmware file.

-config AIROHA_FW_ADDR
-	hex "Airoha Firmware Address"
-	depends on PHY_AIROHA_EN8811H
-	default 0x0
+config PHY_AIROHA_FW_DM_FILEPATH
+	string "Airoha firmware DM file path in the filesystem"
+	depends on PHY_AIROHA_FW_IN_MMC
+	help
+		Specify Airoha firmware DM file path in the filesystem.

-config AIROHA_MD32_DM_SIZE
-	hex "Airoha Firmware MD32 DM Size"
-	depends on PHY_AIROHA_EN8811H
-	default 0x4000
+config PHY_AIROHA_FW_DSP_FILEPATH
+	string "Airoha firmware DSP file path in the filesystem"
+	depends on PHY_AIROHA_FW_IN_MMC
+	help
+		Specify Airoha firmware DSP file path in the filesystem.

-config AIROHA_MD32_DSP_SIZE
-	hex "Airoha Firmware MD32 DSP Size"
-	depends on PHY_AIROHA_EN8811H
-	default 0x20000
+endchoice

 menuconfig PHY_AQUANTIA
 	bool "Aquantia Ethernet PHYs support"
diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 96bb24418a0..8a2a25a8c74 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -12,12 +12,14 @@
  */
 #include <phy.h>
 #include <errno.h>
+#include <log.h>
 #include <malloc.h>
+#include <fs.h>
 #include <asm/unaligned.h>
 #include <linux/iopoll.h>
-#include <dm/device_compat.h>
 #include <linux/bitops.h>
-#include <mmc.h>
+#include <dm/device_compat.h>
+#include <u-boot/crc.h>

 #define EN8811H_PHY_ID		0x03a2a411

@@ -415,11 +417,6 @@ restore_page:
 	return air_phy_restore_page(phydev, saved_page, ret);
 }

-__weak ulong *en8811h_get_fw_addr(void)
-{
-	return (ulong *)CONFIG_AIROHA_FW_ADDR;
-}
-
 static int en8811h_wait_mcu_ready(struct phy_device *phydev)
 {
 	int ret, reg_value;
@@ -437,85 +434,99 @@ static int en8811h_wait_mcu_ready(struct phy_device *phydev)
 	return 0;
 }

+static void crc32_check(unsigned char *name, unsigned char *buf, u32 len)
+{
+	u32 ca_crc32;
+
+	ca_crc32 = crc32(0, buf, len);
+	debug("%s: crc32 is 0x%x\n", name, ca_crc32);
+}
+
 static int en8811h_load_firmware(struct phy_device *phydev)
 {
 	int ret;
-	char *addr = NULL;
+	void *addr = NULL;
 	struct en8811h_priv *priv = phydev->priv;
-	int dev = CONFIG_SYS_MMC_ENV_DEV;
-	u32 cnt = (CONFIG_AIROHA_MD32_DM_SIZE +
-		   CONFIG_AIROHA_MD32_DSP_SIZE) / 512;
-	ulong airoha_fw_addr = (ulong)en8811h_get_fw_addr();
-	u32 blk = airoha_fw_addr / 512;
-
-	addr = malloc(CONFIG_AIROHA_MD32_DM_SIZE + CONFIG_AIROHA_MD32_DSP_SIZE);
-	if (!addr) {
-		puts("cannot allocated buffer for firmware.\n");
-		return -ENOMEM;
-	}

 	if (IS_ENABLED(CONFIG_PHY_AIROHA_FW_IN_MMC)) {
-		struct mmc *mmc = find_mmc_device(dev);
+		loff_t read;

-		if (!mmc) {
-			puts("Failed to find MMC device for Airoha ucode\n");
-			goto en8811h_load_firmware_out;
+		addr = malloc(EN8811H_MD32_DM_SIZE +
+			      EN8811H_MD32_DSP_SIZE);
+		if (!addr) {
+			puts("cannot allocated buffer for firmware.\n");
+			return -ENOMEM;
 		}

-		printf("MMC read: dev # %u, block # %u, count %u ...\n",
-		       dev, blk, cnt);
+		debug("\nLoading Airoha FW from %s %s\n",
+		      CONFIG_PHY_AIROHA_FW_PART,
+		      CONFIG_PHY_AIROHA_FW_DM_FILEPATH);
+		ret = fs_set_blk_dev("mmc", CONFIG_PHY_AIROHA_FW_PART, FS_TYPE_ANY);
+		if (ret < 0)
+			goto en8811h_load_firmware_out;

-		if (mmc_init(mmc)) {
-			puts("initializing MMC device failed.\n");
+		ret = fs_read(CONFIG_PHY_AIROHA_FW_DM_FILEPATH,
+			      (ulong)addr, 0, EN8811H_MD32_DM_SIZE, &read);
+		if (ret < 0)
 			goto en8811h_load_firmware_out;
-		}

-		ret = mmc_set_part_conf(mmc, 1, 2, 2);
-		if (ret) {
-			puts("cannot access eMMC boot1 hw partition.\n");
+		/* Calculate the CRC32 */
+		crc32_check(CONFIG_PHY_AIROHA_FW_DM_FILEPATH,
+			    (unsigned char *)addr, EN8811H_MD32_DM_SIZE);
+
+		debug("Loading Airoha FW from %s %s\n",
+		      CONFIG_PHY_AIROHA_FW_PART,
+		      CONFIG_PHY_AIROHA_FW_DSP_FILEPATH);
+		ret = fs_set_blk_dev("mmc", CONFIG_PHY_AIROHA_FW_PART, FS_TYPE_ANY);
+		if (ret < 0)
 			goto en8811h_load_firmware_out;
-		}

-		(void)blk_dread(mmc_get_blk_desc(mmc), blk, cnt, addr);
+		ret = fs_read(CONFIG_PHY_AIROHA_FW_DSP_FILEPATH,
+			      (ulong)addr + EN8811H_MD32_DM_SIZE,
+			      0, EN8811H_MD32_DSP_SIZE, &read);
+		if (ret < 0)
+			goto en8811h_load_firmware_out;

-		mmc_set_part_conf(mmc, 1, 1, 0);
+		/* Calculate the CRC32 */
+		crc32_check(CONFIG_PHY_AIROHA_FW_DSP_FILEPATH,
+			    (unsigned char *)addr + EN8811H_MD32_DM_SIZE,
+			    EN8811H_MD32_DSP_SIZE);

 	} else {
 		puts("EN8811H firmware loading not implemented");
-		free(addr);
-		addr = NULL;
 		return -EOPNOTSUPP;
 	}

 	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
 				     EN8811H_FW_CTRL_1_START);
 	if (ret < 0)
-		return ret;
+		goto en8811h_load_firmware_out;

 	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
 				      EN8811H_FW_CTRL_2_LOADING,
 				      EN8811H_FW_CTRL_2_LOADING);
 	if (ret < 0)
-		return ret;
+		goto en8811h_load_firmware_out;

-	ret = air_write_buf(phydev, AIR_FW_ADDR_DM, CONFIG_AIROHA_MD32_DM_SIZE, addr);
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DM, EN8811H_MD32_DM_SIZE,
+			    (unsigned char *)addr);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;

-	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, CONFIG_AIROHA_MD32_DSP_SIZE,
-			    addr + CONFIG_AIROHA_MD32_DM_SIZE);
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, EN8811H_MD32_DSP_SIZE,
+			    (unsigned char *)addr + EN8811H_MD32_DM_SIZE);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;

 	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
 				      EN8811H_FW_CTRL_2_LOADING, 0);
 	if (ret < 0)
-		return ret;
+		goto en8811h_load_firmware_out;

 	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
 				     EN8811H_FW_CTRL_1_FINISH);
 	if (ret < 0)
-		return ret;
+		goto en8811h_load_firmware_out;

 	ret = en8811h_wait_mcu_ready(phydev);

--
2.34.1

