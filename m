Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56E8CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 19:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 420C38354B;
	Mon, 22 Sep 2025 21:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B232E83443; Mon, 22 Sep 2025 21:21:18 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0243E83423
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 21:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
X-QQ-mid: zesmtpsz5t1758568834t739d4ce6
X-QQ-Originating-IP: OY9Pmb8IZ+zUCpHzWmGbUbNu/nOxw6UW36c0v4bYF4o=
Received: from debian.. ( [218.1.219.45]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 23 Sep 2025 03:20:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6931439695365615145
EX-QQ-RecipientCnt: 11
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
Subject: [PATCH 3/4] net: phy: aquantia: use generic firmware loader
Date: Tue, 23 Sep 2025 03:20:10 +0800
Message-ID: <22B58FA5C3636AC4+20250922192021.268592-4-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922192021.268592-1-root@infi.wang>
References: <20250922192021.268592-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:infi.wang:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M5fvx+1r+K0Q0XyQK6kVGm6e1+KC8gxwGeoM4zMkbPdAZHQbHoxbiyAS
 KpbjSnw04wnth33TvcRia2XMPaNzZ1qWwcZD7H7cRAivGU4mD6VqiTpCCdzsLNFRdGhR2vA
 twaenimmWhG2ZQVujGHf/xsHUrIcE8MIm1YPmdxnBGRolUF7Q/DJH6YV/F6amFMZ+jKX1gc
 UauEN446HzwE7j7/2H75YC8GS6UlyN6/D1RwgUHUva6Q0/nwZ3ViWgWM6aw8IIX7H3qenuT
 J177+9I6T9t/mCjwOxvLx75zW0AfBH47fQkm25YkO1r/A64avE2dIfwBys7cHgxM2fLi/Vq
 Red0+7FxHYHbY8lNmJOJohvKF5nQRSdxfwEoQuSLf7n9rUneNV4P9Lb4QDNGuSHgValw/mW
 f5PquUHvs3z4tdeeqyckM+iTGE0QeGouHPI1fvhWy26WEbPjtwweU2C+WQ3OJsi/2D7/cQN
 7ML0P/0v/7Ud8NzQrrTb9v2llb803Hwh8XE2QsYZkTB8xpNPLcfhEUAmzOUFkzDh7wGifAB
 22J+BhdHEgzI7ZP86Wy3YL9PmdkW6eXlMmFZ9rZp8qrefTvP1SrQIXItg7rusihpqgoa+XI
 XFzTZOqyiuUYcR0yhMk1BN8XHsQW9rYnuw1jMdpIkkj3PKc1A47qrks5iSO621O55G0eRai
 rvrGfAUQJEjK4kwFcIYES6c3DVS12Ziu6dsg4g0R9pZ20b/uW94wX5yOFV/1auDbR919RZp
 QH/QrIEzmmYq52CIn3i8TH1bbDxaR2IGDl8AQbjehPpYHljeT0VhLzcvTdPW2GYHiM7NtoL
 8U7ElC3NEfoGGQhKf6MjN9x79Xopjyy9ot6oG0JJPjWAlCS+u0GwfPYivSOXoZwUI7MW6J8
 UgW3J1AGFxqFRT7lQXTvnKnzZuKJsxmHFO36Te6ipJvxRD0az9vwFOz5aV/myWGkWatOcov
 wtd9tr5/wFRIOXGyr9mhvzZ/Nq76Tdz8HVSebvQ7G0/fViMfNiozuk/FXMwydxYdRNl937C
 nTD+u77w==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Mon, 22 Sep 2025 21:42:39 +0200
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

