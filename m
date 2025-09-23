Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D73CCAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 07:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6103483526;
	Tue, 23 Sep 2025 09:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="dXEgg/K4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2915783510; Tue, 23 Sep 2025 09:14:19 +0200 (CEST)
Received: from outbound.st.icloud.com
 (npq-east2-cluster1-host8-snip4-6.eps.apple.com [57.103.77.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C99834D4
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 09:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 95C78180060F; Tue, 23 Sep 2025 07:14:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=2cmfoFowTLkjHW4NpJRTTHH/Wy2uF6okE0gcy+Sf8CY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=dXEgg/K4TqyJ6RbEG+ppgqC6j1nyxXTxwJWC91aH/TgJdUgsnA2ckqNtRZw3DXB2GB/R7qpsn/sgn76MDPUN9raqXDyUkBQgtwiajMaL8xDdu4e13tQ/NwErbet71oiKhfVins/K+TbNI99tJXrphLIFUJc0Kj7x4YsSEEBRH62Mf/eV9dg4LkGVLga2B79tPf/7kFHJhrSdNF2Qgj3l2Jq5tQWWmYXfi0TSNf2ljze64uLqepXvYVx8r2hx21Rjh5DdFU8THsKHSQr1mOYlFtR1w7mEIV3Dc/SXfUr51kviGNocf9hlpP9uffvbVBoRv9mrt/wXs0MpxNLKKwWPdA==
mail-alias-created-date: 1549370554000
Received: from debian.. (st-asmtp-me-k8s.p00.prod.me.com [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 EC1DB1800283; Tue, 23 Sep 2025 07:14:08 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Beiyan Yun <root@infi.wang>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH RESEND 3/4] net: phy: aquantia: use generic firmware loader
Date: Tue, 23 Sep 2025 15:13:00 +0800
Message-ID: <20250923071315.276114-4-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923071315.276114-1-root@infi.wang>
References: <20250923071315.276114-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA2NiBTYWx0ZWRfX4lZLQ/3Ob+lq
 aB814LroV+wEtXqHf8V9I7PdBPCKfSoUzkg0k4g7Rrw4NqQIO2sh7WMTTLzGn+vk6lpr69YJzK9
 VK4nHk5TyhxwyEIqPU3ayXlh2Ta4QW6zODaHe/EzGlbm9L3+PtPXsP7bxu9MlDA0pLRzzSdrtHu
 dJVzi7O/LiiRvahyPn2e8hs6/kmR1o/4atIq2DWby45Dm4Dx2rOkF8oHESk0RLZIgr2LIh0U7XL
 BbONkhA4yCD9NAsZxTWtm54aME/wy5NCHfMBpv5kVQz/dWXllVgCqA6l3GPE/A0BhuFFiq9ng=
X-Proofpoint-GUID: Wp_-l5vQxNlfB7S0P9DYZJRj657gm8tA
X-Proofpoint-ORIG-GUID: Wp_-l5vQxNlfB7S0P9DYZJRj657gm8tA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=845
 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0
 clxscore=1030 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509230066
X-JNJ: AAAAAAAB2Kg5QhGK3fGO2/606ry99MKXGqDLgnYHXVzycKnAiDRQ1PEqTaBIWLDTz2p1fBtVCrd4urrdiRDQNvAIFkonR/l0CkxYnyeXTLIq6vjp602kRtJn7JatyevCDZX4PcglPakxFFePPhxvKhbe9wrjPLecZVSsAA5gLO9V1BsJg2wEvEiF7GyAPTNwhFPy34Igi+YlAteUsqHE7/N3XfE5LQGAm41y1+rkPW6zWF4xKTaY5zi4BreyD5ynycnSVSG55selEJz0oKILvPrDTd2/37P1huipXfukPOvr845YrDO8j5daXfEAch2Wkn/fM+iCp/E2U92iBRrzMGfnU4W0HETjtTHGs6Eo0mPoSxGSK8bEM9ORXm/LseVdVIXR9byy6AvtLUHONFk0a+TuZBTyB7+1KQvA7ghEe6XnWSEPQkM4x6Wn3zG0Ol+iPKdL829TAG5uLNUan34M/9H2q2edRQm3B7R+rhd9fAyf3AoBDkTs7MbS45KgfjxYLcLFgFksbOUjADvRHsPIfLdKOXSsyFc6jpcVCnGA9L64J8y+B6LDY+ERWv9ZFCW7AmrOGZwCCyLiH8qreWDOcfXzbKxQhluB6Y4o5Z7FzhvgroHKWKizMaxofIESRmamzjotAZy15aXF+09hGnvv06PE9aqFB3maVT/FeSfnFykxGdwfsAnp+LWSuJVvRX5E3MO8yLVGEQ==
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

Aquantia PHYs are being used w/o SPI flash in some routers recently.
Current firmware loader only attempts to load from FS on top of MMC,
limiting the use on many devices.

Removed the old firmware loader, migrate to generic firmware loader
to allow a wider range of firmware source (e.g., USB, UBIFS).

Tested on Buffalo WXR18000BE10P with UBIFS.

Tested-by: Beiyan Yun <root@infi.wang>
Signed-off-by: Beiyan Yun <root@infi.wang>
---

 drivers/net/phy/Kconfig    |  19 +++---
 drivers/net/phy/aquantia.c | 122 +++++++++++++++++++------------------
 2 files changed, 71 insertions(+), 70 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 21bf983056a..16a853793c5 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -90,23 +90,22 @@ menuconfig PHY_AQUANTIA
 config PHY_AQUANTIA_UPLOAD_FW
 	bool "Aquantia firmware loading support"
 	depends on PHY_AQUANTIA
+	select FS_LOADER
 	help
 		Aquantia PHYs use firmware which can be either loaded automatically
 		from storage directly attached to the phy or loaded by the boot loader
-		via MDIO commands.  The firmware is loaded from a file, specified by
-		the PHY_AQUANTIA_FW_PART and PHY_AQUANTIA_FW_NAME options.
+		via MDIO commands.
 
-config PHY_AQUANTIA_FW_PART
-	string "Aquantia firmware partition"
-	depends on PHY_AQUANTIA_UPLOAD_FW
-	help
-		Partition containing the firmware file.
+		This option enables loading the firmware using the generic
+		file system firmware loader framework.
 
-config PHY_AQUANTIA_FW_NAME
-	string "Aquantia firmware filename"
+config PHY_AQUANTIA_FW_MAX_SIZE
+	hex "Max firmware size"
 	depends on PHY_AQUANTIA_UPLOAD_FW
+	default 0x80000
 	help
-		Firmware filename.
+	  The maximum size of the Aquantia PHY firmware. This is used to
+	  allocate a buffer to load the firmware into.
 
 config PHY_ATHEROS
 	bool "Atheros Ethernet PHYs support"
diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index 903fcd667f6..dc5f30a9e53 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -17,6 +17,9 @@
 #include <malloc.h>
 #include <asm/byteorder.h>
 #include <fs.h>
+#if (IS_ENABLED(CONFIG_PHY_AQUANTIA_UPLOAD_FW))
+#include <fs_loader.h>
+#endif
 
 #define AQUNTIA_10G_CTL		0x20
 #define AQUNTIA_VENDOR_P1	0xc400
@@ -127,53 +130,7 @@ struct fw_header {
 
 #pragma pack()
 
-#if defined(CONFIG_PHY_AQUANTIA_UPLOAD_FW)
-static int aquantia_read_fw(u8 **fw_addr, size_t *fw_length)
-{
-	loff_t length, read;
-	int ret;
-	void *addr = NULL;
-
-	*fw_addr = NULL;
-	*fw_length = 0;
-	debug("Loading Aquantia microcode from %s %s\n",
-	      CONFIG_PHY_AQUANTIA_FW_PART, CONFIG_PHY_AQUANTIA_FW_NAME);
-	ret = fs_set_blk_dev("mmc", CONFIG_PHY_AQUANTIA_FW_PART, FS_TYPE_ANY);
-	if (ret < 0)
-		goto cleanup;
-
-	ret = fs_size(CONFIG_PHY_AQUANTIA_FW_NAME, &length);
-	if (ret < 0)
-		goto cleanup;
-
-	addr = malloc(length);
-	if (!addr) {
-		ret = -ENOMEM;
-		goto cleanup;
-	}
-
-	ret = fs_set_blk_dev("mmc", CONFIG_PHY_AQUANTIA_FW_PART, FS_TYPE_ANY);
-	if (ret < 0)
-		goto cleanup;
-
-	ret = fs_read(CONFIG_PHY_AQUANTIA_FW_NAME, (ulong)addr, 0, length,
-		      &read);
-	if (ret < 0)
-		goto cleanup;
-
-	*fw_addr = addr;
-	*fw_length = length;
-	debug("Found Aquantia microcode.\n");
-
-cleanup:
-	if (ret < 0) {
-		printf("loading firmware file %s %s failed with error %d\n",
-		       CONFIG_PHY_AQUANTIA_FW_PART,
-		       CONFIG_PHY_AQUANTIA_FW_NAME, ret);
-		free(addr);
-	}
-	return ret;
-}
+#if (IS_ENABLED(CONFIG_PHY_AQUANTIA_UPLOAD_FW))
 
 /* load data into the phy's memory */
 static int aquantia_load_memory(struct phy_device *phydev, u32 addr,
@@ -218,27 +175,27 @@ static u32 unpack_u24(const u8 *data)
 	return (data[2] << 16) + (data[1] << 8) + data[0];
 }
 
-static int aquantia_upload_firmware(struct phy_device *phydev)
+/* Common firmware upload implementation */
+static int aquantia_do_upload_firmware(struct phy_device *phydev,
+				       const u8 *addr, size_t fw_length)
 {
 	int ret;
-	u8 *addr = NULL;
-	size_t fw_length = 0;
 	u16 calculated_crc, read_crc;
 	char version[VERSION_STRING_SIZE];
 	u32 primary_offset, iram_offset, iram_size, dram_offset, dram_size;
 	const struct fw_header *header;
 
-	ret = aquantia_read_fw(&addr, &fw_length);
-	if (ret != 0)
-		return ret;
+	if (!addr || !fw_length) {
+		printf("%s: Invalid firmware data\n", phydev->dev->name);
+		return -EINVAL;
+	}
 
-	read_crc = (addr[fw_length - 2] << 8)  | addr[fw_length - 1];
+	read_crc = (addr[fw_length - 2] << 8) | addr[fw_length - 1];
 	calculated_crc = crc16_ccitt(0, addr, fw_length - 2);
 	if (read_crc != calculated_crc) {
 		printf("%s bad firmware crc: file 0x%04x calculated 0x%04x\n",
 		       phydev->dev->name, read_crc, calculated_crc);
-		ret = -EINVAL;
-		goto done;
+		return -EINVAL;
 	}
 
 	/* Find the DRAM and IRAM sections within the firmware file. */
@@ -268,14 +225,14 @@ static int aquantia_upload_firmware(struct phy_device *phydev)
 	ret = aquantia_load_memory(phydev, DRAM_BASE_ADDR, &addr[dram_offset],
 				   dram_size);
 	if (ret != 0)
-		goto done;
+		return ret;
 
 	debug("loading iram 0x%08x from offset=%d size=%d\n",
 	      IRAM_BASE_ADDR, iram_offset, iram_size);
 	ret = aquantia_load_memory(phydev, IRAM_BASE_ADDR, &addr[iram_offset],
 				   iram_size);
 	if (ret != 0)
-		goto done;
+		return ret;
 
 	/* make sure soft reset and low power mode are clear */
 	phy_write(phydev, MDIO_MMD_VEND1, GLOBAL_STANDARD_CONTROL, 0);
@@ -289,8 +246,53 @@ static int aquantia_upload_firmware(struct phy_device *phydev)
 	phy_write(phydev, MDIO_MMD_VEND1, UP_CONTROL, UP_RUN_STALL_OVERRIDE);
 
 	printf("%s firmware loading done.\n", phydev->dev->name);
-done:
-	free(addr);
+	return 0;
+}
+
+static int aquantia_upload_firmware(struct phy_device *phydev)
+{
+	int ret;
+	ofnode node;
+	struct udevice *loader_dev;
+	const char *fw_name;
+	u8 *fw_addr = NULL;
+	size_t fw_length;
+
+	node = phy_get_ofnode(phydev);
+	if (!ofnode_valid(node)) {
+		printf("Failed to get PHY node\n");
+		return -EINVAL;
+	}
+
+	fw_name = ofnode_read_string(node, "firmware-name");
+	if (!fw_name) {
+		printf("Failed to get firmware name\n");
+		return -ENOENT;
+	}
+
+	ret = get_fs_loader(&loader_dev);
+	if (ret) {
+		printf("Failed to get fs_loader instance: %d\n", ret);
+		return ret;
+	}
+
+	fw_addr = malloc(CONFIG_PHY_AQUANTIA_FW_MAX_SIZE);
+	if (!fw_addr) {
+		printf("Failed to allocate memory for firmware\n");
+		return -ENOMEM;
+	}
+
+	ret = request_firmware_into_buf(loader_dev, fw_name, fw_addr,
+					CONFIG_PHY_AQUANTIA_FW_MAX_SIZE, 0);
+	if (ret < 0) {
+		printf("Failed to load firmware %s: %d\n", fw_name, ret);
+		free(fw_addr);
+		return ret;
+	}
+	fw_length = ret;
+
+	ret = aquantia_do_upload_firmware(phydev, fw_addr, fw_length);
+	free(fw_addr);
 	return ret;
 }
 #else
-- 
2.47.3

