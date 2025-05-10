Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8188EC3ABC3
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 13:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7544D80ADF;
	Sun, 11 May 2025 15:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OU42vBRG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 771A882952; Sat, 10 May 2025 14:53:19 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C53D826AA
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 14:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so2578211b3a.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746881595; x=1747486395; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CXpQlg7s7vaEQ/smZYhmz5XXSELA6xRgRlvw9C5zOS4=;
 b=OU42vBRGY+4ODGdeGoyuxolG41NkIc0oDWj9abEoqe9mkhbWv0I8jHR2zqo7+W50Vl
 p4pGGuXnpteZ7lKy178ppvtnNuxZbMoE4Gnfpy+g992c98xdLk9HCFjMQF+xuJw4BYn6
 DCnXmMH43ndCX9/8saerQWuQyhF87wwRadgww/JXAlDT9/GbqaTNC4IDLT5sraezHnge
 lKZghk8WVz2BgjUgotA5YGvywLFhF7B9PnwmC5UsWbliEaTcAn96Erosec6YwqJ2dbGz
 dF+g/sbov/5BsNuL2zSiakSsoKaTnkomFMNYPNtcKiS7Gw6NPCz1lLYsMLXj/kq3ECX+
 0LJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746881595; x=1747486395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CXpQlg7s7vaEQ/smZYhmz5XXSELA6xRgRlvw9C5zOS4=;
 b=N9iSVe8mKfTuZt+vTPcKq2uIztv+IW/nQZGbOQRHv4EFzHDk9orQvg7FEpGtf+79yX
 Du0sDb62qi6Od3FGD1BOZUgQ6c7szdYxaIFLvS4I0BnAvh3ZCyN9LoarXzJb2oZ82HuA
 DtKMQ0RRIUrKoQbLmLMvWRQCq5SIR18gJnFlpwSYyaUltASYqlYychh6t3vi3hI3pzH3
 9YQI6qV83fJRpOXAA3b7Lmjr8QLQz0b7aoRTU4DqvSMxboOdzgGor6myWJ1hyiC2ODNU
 y/+097OpUmakwUl0aQE7fg1OJXnEAZ9rmlA9CcnUjcmeyhuekUqMmZSbhcZTs7YM3dYs
 q1zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKpCcTNqo3Ht8AYGJSJWolsJEsDudMNIDfkJ4gTGdBi7rKDFBT9nQbTx+/TPPV/4GolFGMgkE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4dIdqC7lnM/UWJgCTPwObNBHEIzvRoha2Hcjk1BtX9bI2y9vV
 Az/gfZbeGEdmjSQ+aIcJP9aYWlq510POy/+EJ8EYGR4Uacx8fTsM
X-Gm-Gg: ASbGncvA9/XRM2aDPimMAPJekroJAgh3q3uoXwVzQBe00IP6sPJ9Yvjiu2G1nFvieyn
 niwfUB49hHXgc3jifvA/50KKnd/byIq0EoaT4sfd9Co869/n1HApBQK9DY+Zug9wcy3M7KF216e
 mgQrvscnHFFSMVEbY8ETfUzof7fkqrvywPzsj9UrCjcMzaQeNFF5fqnR7C5zS6OrqpE6WS1VnVP
 ZCjKuSgDFASPlGjgqBBe7iQWmvchFlSYTcgbTrUDa/tiAczEQyaMKEGzyJkZMCHsx+QWKcjMhOO
 0vWORr64KZC18B+g47hS4i2Ki/iv6JGe8m3ftKiA7FeGG1aOmIOXtgPfB/XSsB/yulyYnMNyQKp
 WuL3qElVExhFzdrKlUCTa/CExXbjYrOqBEAhT78yIn6ATdso=
X-Google-Smtp-Source: AGHT+IH8DwKtyIIhKmdU6d6mGq03dj3fGysqGb7YPuxm4yH6Swi7gkR4uBzoKttwWydIkchkVvwyeA==
X-Received: by 2002:a05:6a00:23cc:b0:736:5753:12fd with SMTP id
 d2e1a72fcca58-7423bc253e9mr10423105b3a.4.1746881595407; 
 Sat, 10 May 2025 05:53:15 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a10867sm3172233b3a.110.2025.05.10.05.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 05:53:15 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 marek.vasut+renesas@mailbox.org, paul.barker.ct@bp.renesas.com,
 pbrobinson@gmail.com, lucienzx159@gmail.com, u-boot@lists.denx.de
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com,
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com
Subject: [U-Boot, v1,
 1/1] net: phy: air_en8811h: load the PHY firmware from filesystem on
 block device by default
Date: Sat, 10 May 2025 20:52:13 +0800
Message-Id: <20250510125213.56400-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 11 May 2025 15:02:43 +0200
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
If need board specific loading override,
please override the en8811h_read_fw function on board or architecture level.

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
 drivers/net/phy/Kconfig       |  39 ++++++-----
 drivers/net/phy/air_en8811h.c | 119 ++++++++++++++++++++--------------
 2 files changed, 95 insertions(+), 63 deletions(-)

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
index 96bb24418a0..b5f27a23343 100644
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
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
-#include <mmc.h>
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
@@ -437,85 +434,111 @@ static int en8811h_wait_mcu_ready(struct phy_device *phydev)
 	return 0;
 }

-static int en8811h_load_firmware(struct phy_device *phydev)
+static void crc32_check(unsigned char *buf, u32 len)
+{
+	u32 ca_crc32;
+
+	ca_crc32 = crc32(0, buf, len);
+	printf("crc32 is 0x%x\n", ca_crc32);
+}
+
+__weak int en8811h_read_fw(void **addr)
 {
+	loff_t read;
 	int ret;
-	char *addr = NULL;
-	struct en8811h_priv *priv = phydev->priv;
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

-	if (IS_ENABLED(CONFIG_PHY_AIROHA_FW_IN_MMC)) {
-		struct mmc *mmc = find_mmc_device(dev);
+	printf("\nLoading Airoha FW from %s %s\n",
+	       CONFIG_PHY_AIROHA_FW_PART,
+	       CONFIG_PHY_AIROHA_FW_DM_FILEPATH);
+	ret = fs_set_blk_dev("mmc", CONFIG_PHY_AIROHA_FW_PART, FS_TYPE_ANY);
+	if (ret < 0)
+		return ret;

-		if (!mmc) {
-			puts("Failed to find MMC device for Airoha ucode\n");
-			goto en8811h_load_firmware_out;
-		}
+	ret = fs_read(CONFIG_PHY_AIROHA_FW_DM_FILEPATH,
+		      (ulong)*addr, 0, EN8811H_MD32_DM_SIZE, &read);
+	if (ret < 0)
+		return ret;

-		printf("MMC read: dev # %u, block # %u, count %u ...\n",
-		       dev, blk, cnt);
+	/* Calculate the CRC32 */
+	crc32_check((unsigned char *)*addr, EN8811H_MD32_DM_SIZE);

-		if (mmc_init(mmc)) {
-			puts("initializing MMC device failed.\n");
-			goto en8811h_load_firmware_out;
-		}
+	printf("Loading Airoha FW from %s %s\n",
+	       CONFIG_PHY_AIROHA_FW_PART,
+	       CONFIG_PHY_AIROHA_FW_DSP_FILEPATH);
+	ret = fs_set_blk_dev("mmc", CONFIG_PHY_AIROHA_FW_PART, FS_TYPE_ANY);
+	if (ret < 0)
+		return ret;

-		ret = mmc_set_part_conf(mmc, 1, 2, 2);
-		if (ret) {
-			puts("cannot access eMMC boot1 hw partition.\n");
-			goto en8811h_load_firmware_out;
-		}
+	ret = fs_read(CONFIG_PHY_AIROHA_FW_DSP_FILEPATH,
+		      (ulong)*addr + EN8811H_MD32_DM_SIZE,
+		      0, EN8811H_MD32_DSP_SIZE, &read);
+	if (ret < 0)
+		return ret;

-		(void)blk_dread(mmc_get_blk_desc(mmc), blk, cnt, addr);
+	/* Calculate the CRC32 */
+	crc32_check((unsigned char *)*addr + EN8811H_MD32_DM_SIZE,
+		    EN8811H_MD32_DSP_SIZE);

-		mmc_set_part_conf(mmc, 1, 1, 0);
+	printf("Found Airoha Firmware.\n");

+	return 0;
+}
+
+static int en8811h_load_firmware(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	void *addr = NULL;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_PHY_AIROHA_FW_IN_MMC)) {
+		u32 fw_length = EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE;
+
+		addr = malloc(fw_length);
+		if (!addr) {
+			printf("Failed to allocate memory for firmware\n");
+			return -ENOMEM;
+		}
+
+		ret = en8811h_read_fw(&addr);
+		if (ret < 0) {
+			free(addr);
+			return ret;
+		}
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

