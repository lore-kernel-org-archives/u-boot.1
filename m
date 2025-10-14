Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D89CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 12:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7303B831D5;
	Tue, 14 Oct 2025 14:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="sf5Ec5kb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F98831A4; Tue, 14 Oct 2025 14:13:44 +0200 (CEST)
Received: from outbound.mr.icloud.com
 (p-west2-cluster5-host2-snip4-8.eps.apple.com [57.103.71.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64873809A5
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 14:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 F164C1800104; Tue, 14 Oct 2025 12:13:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=32TjgWTuTnDXbKEmfwAziGwoUMNP1vuVnCHqrdvmcgA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=sf5Ec5kbZJcroqWOBRpKOBzrwX9PwlY44Egpim0gYuYGt97eSoZXs62AGEGLwdvLLPk9sd26g0PbeaPw1IN+2WDA62EPQlgNFjBZcrQGAaNwxr4HQbrnfhWKsioYf87aZO+fT2PnLfWhmH0OhKq1JPiaXnowz0WU5GhWZu5ePteeta4z7Rg8S9V6sQYrHZQbwQkBRrZ618D1kExfHMoIJwn4SPRS5UcMXH9lJepM3PFwRqmi+zGz0C8LVbkG54Phtb6wCOyNfKVrsnWn4RJjQnqevUn8wuQS9j7VDbp6ayKbKK0+AdkF0aoTaKIkU7DLEWu6Wp13c7KQclus2DBGrg==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 B2228180018E; Tue, 14 Oct 2025 12:13:36 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Beiyan Yun <root@infi.wang>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 4/4] net: phy: aquantia: use generic firmware loader
Date: Tue, 14 Oct 2025 20:12:49 +0800
Message-ID: <20251014121318.453701-5-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014121318.453701-1-root@infi.wang>
References: <20251014121318.453701-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDA5NSBTYWx0ZWRfX659dYu75tPsn
 AcfTgXyav4+TVa547qxub61hdTlZr6SceG6USuPoTKOa9xXV5+cVqzQv2tm5AVu0eL2rgg4uN1a
 RucIW7o/rzFjCUZRXS6SC7euEkh5ucMeQz2U6wz/q4GVYQX5BQPoO8TLFq7dzLI0YgbklYvYeiQ
 Wv6lz0aPBLeX3cENI0D6ZBRVPaLQ22nKWbO32V+7bw0Wq5geJlT6w6w1FySQA8g8KELm+otM3ob
 h8LTJLJAdS9sco4gyLgEubw3hHHXEmFx+9fZSIBiRkFLHMwy9GTTZjGDgkXTYzi9+XX2oHaY0=
X-Proofpoint-ORIG-GUID: fEIEUv5mJKetq6rIaAU5m1KxT4xKZVaS
X-Proofpoint-GUID: fEIEUv5mJKetq6rIaAU5m1KxT4xKZVaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=776 clxscore=1030 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510140095
X-JNJ: AAAAAAABgRG2/XLth9nxku2n/nBZnN20aUaQiZtqYoqGlNn1ZK0NlSZy5ifzk/A1wHB0riNI0toAZkezFEXLfNI2Pwmak7lGWLCL4CDcZFZc1QnDK56D/aFN+jSmj+16qAahy49nGlt1IqNkozcQ1ufsrBYdWxxl0UJkxP+QV3ZKktQV9aSjBhCKx1o5wM22wqX3Uje6M9O/B9R3NEFK2Sl5jSd/MraARlNiA0rdn6tU82lNvasBmSBuqBFrtOa217Z7mZWVDOjcG++70v822Tma2P/ibcNYBvMnROthytHPxPyyGxfs4gbCBLUPkXq31YG2Y8nY+JSkhOQdheClgZyyR+AWBvNp2oBbqT8gOYEb38PpXhT6f1Kyj4FBZQPWV84KyLbNVCthJPjAHN+/GBoYUMeb84cvG7M2QcndeY9GXo7tMf6CtqPoGcgI4dzadkNrOUDWMXbVFq2ul8Wm+Cm3vgUJwTAGXUGl3J+LyXHtbEtugjVLL442LRVA5KLRPWI7NuXcMRAbV6Z0nbtidXVSZs261QRQa31DfL4WomoBulIjFX9fImfUmukl/00ON8ItYKDhg8kS9GcobTdLxSvHIcKER5BVW6jnVcpR2n77X0tYsTlljvOfPSPoVxNsi8cxenzjO6GDcOKyng7zVXJDSbMpI1VU/APKgQn+n0cnlaLwBUfhD5FgpoGWJrR68LTtzGPvLmMQCEuy/j2jWiCuIn99nP0LYKubnX4II1dPG5bX0JW9q4zeqOy2WpQE3Mz8D7DMj+fIHDDXBHXd5aTjRLqdMVST
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

Removed the old firmware loader, migrate to generic firmware loader to
allow a wider range and runtime override of firmware source. (e.g., USB).

Tested on Buffalo WXR18000BE10P with UBIFS.

Tested-by: Beiyan Yun <root@infi.wang>
Signed-off-by: Beiyan Yun <root@infi.wang>


---

Changes in v3:
- Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW

Changes in v2:
- Add support for script based loader

 drivers/net/phy/Kconfig    |  24 ++++---
 drivers/net/phy/aquantia.c | 133 ++++++++++++++++++++-----------------
 2 files changed, 88 insertions(+), 69 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 185c6a3156e..68765290671 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -1,4 +1,3 @@
-
 config BITBANGMII
 	bool "Bit-banged ethernet MII management channel support"
 
@@ -90,23 +89,30 @@ menuconfig PHY_AQUANTIA
 config PHY_AQUANTIA_UPLOAD_FW
 	bool "Aquantia firmware loading support"
 	depends on PHY_AQUANTIA
+	select FS_LOADER
+	select FW_LOADER
 	help
 		Aquantia PHYs use firmware which can be either loaded automatically
 		from storage directly attached to the phy or loaded by the boot loader
-		via MDIO commands.  The firmware is loaded from a file, specified by
-		the PHY_AQUANTIA_FW_PART and PHY_AQUANTIA_FW_NAME options.
+		via MDIO commands.
+
+		This option enables loading the firmware using the generic
+		file system firmware loader framework.
 
-config PHY_AQUANTIA_FW_PART
-	string "Aquantia firmware partition"
+config PHY_AQUANTIA_FW_MAX_SIZE
+	hex "Max firmware size"
 	depends on PHY_AQUANTIA_UPLOAD_FW
+	default 0x80000
 	help
-		Partition containing the firmware file.
+	  The maximum size of the Aquantia PHY firmware. This is used to
+	  allocate a buffer to load the firmware into.
 
-config PHY_AQUANTIA_FW_NAME
-	string "Aquantia firmware filename"
+config PHY_AQUANTIA_FW_LOADER_SCRIPT
+	string "Aquantia firmware loader script"
 	depends on PHY_AQUANTIA_UPLOAD_FW
+	default "aqr_phy_load_firmware"
 	help
-		Firmware filename.
+		The firmware loading script variable name.
 
 config PHY_ATHEROS
 	bool "Atheros Ethernet PHYs support"
diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index d9df0e23a45..98ee7ae10e7 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -17,6 +17,10 @@
 #include <malloc.h>
 #include <asm/byteorder.h>
 #include <fs.h>
+#if (IS_ENABLED(CONFIG_PHY_AQUANTIA_UPLOAD_FW))
+#include <fs_loader.h>
+#include <fw_loader.h>
+#endif
 
 #define AQUNTIA_10G_CTL		0x20
 #define AQUNTIA_VENDOR_P1	0xc400
@@ -127,53 +131,7 @@ struct fw_header {
 
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
@@ -218,27 +176,27 @@ static u32 unpack_u24(const u8 *data)
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
@@ -268,14 +226,14 @@ static int aquantia_upload_firmware(struct phy_device *phydev)
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
@@ -289,8 +247,63 @@ static int aquantia_upload_firmware(struct phy_device *phydev)
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
+	fw_addr = malloc(CONFIG_PHY_AQUANTIA_FW_MAX_SIZE);
+	if (!fw_addr) {
+		printf("Failed to allocate memory for firmware\n");
+		return -ENOMEM;
+	}
+
+	/* First, try to load firmware via script */
+	ret = request_firmware_into_buf_via_script(fw_addr,
+						   CONFIG_PHY_AQUANTIA_FW_MAX_SIZE,
+						   CONFIG_PHY_AQUANTIA_FW_LOADER_SCRIPT,
+						   &fw_length);
+	if (ret) {
+		/* Fallback to DT specified firmware */
+		node = phy_get_ofnode(phydev);
+		if (!ofnode_valid(node)) {
+			printf("Failed to get PHY node\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		fw_name = ofnode_read_string(node, "firmware-name");
+		if (!fw_name) {
+			printf("Failed to get firmware name\n");
+			ret = -ENOENT;
+			goto out;
+		}
+
+		ret = get_fs_loader(&loader_dev);
+		if (ret) {
+			printf("Failed to get fs_loader instance: %d\n", ret);
+			goto out;
+		}
+
+		ret = request_firmware_into_buf(loader_dev, fw_name, fw_addr,
+						CONFIG_PHY_AQUANTIA_FW_MAX_SIZE, 0);
+		if (ret < 0) {
+			printf("Failed to load firmware %s: %d\n", fw_name, ret);
+			goto out;
+		}
+		fw_length = ret;
+	}
+
+	ret = aquantia_do_upload_firmware(phydev, fw_addr, fw_length);
+out:
+	free(fw_addr);
 	return ret;
 }
 #else
-- 
2.47.3

