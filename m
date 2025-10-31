Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BA1CCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A69F839D6;
	Fri, 31 Oct 2025 16:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="bFUCZGGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CDEA83677; Fri, 31 Oct 2025 16:24:30 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster5-host6-snip4-10.eps.apple.com [57.103.66.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B15839D6
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:24:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPS id
 7B50918001CC; Fri, 31 Oct 2025 15:24:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=SFPskJenqTLercDGUqiyYpUXmbjkH+mhjuOyOGjtK3o=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bFUCZGGAmIYqGef7EqO2pnC6nm+tJ59GLC5CJAIJ9vpbscunCs7rSeERNY7KByo4viZQOAfkh8Lodu+qg4ae+TW5vJPJGmwitoDSP0FN9mIjoCOBJKznchSITaZZLRZU1DGf7q3t4md24ETguBKp5t75c0wMyMlUoUE8v8581BxrEpIhcUasdZYPVKt/9bj423IctPEkMeuYRjXfICq34ebEXZ7flh6dNyT8M7r4rrTc206Ysln7N3wsWgzVlZBC6RT+74n2zlAk8MbhFNKAYO92HOTRMJZpXkRj76bGAC5FUUB0uJ+jraR1Ic34pvmF02lM10IQzBPvtTxvEmTBvw==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPSA id
 2523418003E2; Fri, 31 Oct 2025 15:24:20 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Yao Zi <ziyao@disroot.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v4 5/5] net: phy: aquantia: use generic firmware loader
Date: Fri, 31 Oct 2025 23:21:07 +0800
Message-ID: <20251031152348.60571-6-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031152348.60571-1-root@infi.wang>
References: <20251031152348.60571-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: K8zNDpxTvuHJkcqG790axS1Unv3XAg9I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzOCBTYWx0ZWRfXzGX0vBQLO/iJ
 vvSz4C+ex4dpzKmchYIe6uQhYP0TsKgQvS97wSGOM32eltaqQbj2g6cEiHC8gBjEAEL2Sen2ziX
 SVaVKu67PZmlGoUa3yCzKrOEf2cJ2hRDaDdJQQs59iHGAlzAEHwKjbCZqbFaZVcyfSUiOflc6cq
 5OGRs1FLyq6DKPkkET+W1Y3WE5irEuQrU1gpKDps7uG7qtDts/DwnO/4Hd2iBywtecGAp923zAy
 nkDOr+nR+k7KLKMQ5M1y1adZQeSO1Dduygq0D/caKmzG4f8VBeipkGVBnjEugM1qeVFPq5sL0=
X-Proofpoint-ORIG-GUID: K8zNDpxTvuHJkcqG790axS1Unv3XAg9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 phishscore=0 clxscore=1030 mlxscore=0
 mlxlogscore=973
 bulkscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510310138
X-JNJ: AAAAAAABOPtJa+DLb4eDFkIrS5DZwVzNXBbHsTnRRObcuZcsqJv6epNifw4URFQP+BF6r5wQNDL1d4g2RvIgGZm6/BfXecVDyCFWNA/f30YxaHEl82ARvl181JTKFicLEwikU7Kp8Fac6Z3/6+ztXOipnYgsuOavv5I1DUbqD0PPEQfYPZPVDFLBH8Vftj9hX28s5BBFYOaLAH8TZCn7HvojPSbLredHgRtL45/6yO5ganYazqRjR5qTMPqS3YF1bxO5tRY990j+1R3Yy2SxD7Kj7D00D3q3BxBbl6RWM+yqMika5cJr5SBthkT4ZF2F7bHe+DH/0YKW0psAGInuIG1a92himi6/IDKqVB9WWdHBGLuxPYbUxvDr/6RYXMFWHSH6fFcmE5bfLWft5waJkObkLB5IWJL2+QW0qh/S2eAAyJvqc1C5LFXCJ1oyQPyI2tQfjtNmI8tC/yU1Wb+kJCjAfceMyYTNeLksyFhZxp7POoOab8KU5Eh86Lz3Osf7DryKmpUGhVJ7W/fl4igJJDNH3RmMSz6Rf9PuspHJkFpK1I3MlQGjiHGg0zkt5lof7RYFZxmHoh/Pl8ElE3rroAAeGJV6CPTuTldevY9gfYV4HpD9WPphVhUCWXFwgWajrrmUuyU5h5d6YxIYQUoE8z+jMsG9bKKJ8j2O/IyBMcoaMrBgb6FXfL+nWqNLXI8f0n9Ig7GLh0BlxI+mYTzy8qsRkFAqB/WlRcuWCd1Cf0eI+2VL3V5WnKlgKxR1ggRCfnjhG/3DKyumPHbLVzrfcvnUgYg=
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

Signed-off-by: Beiyan Yun <root@infi.wang>
---

Changes in v4:
- Split firmware upload helpers change
- Reorder `aquantia_read_fw`
- Make `aquantia_read_fw` weak to allow overide
- Rename exit label in `aquantia_read_fw`
- Kconfig polish

Changes in v3:
- Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW

Changes in v2:
- Add support for script based loader

 drivers/net/phy/Kconfig    |  28 +++++----
 drivers/net/phy/aquantia.c | 122 ++++++++++++++++++++++---------------
 2 files changed, 91 insertions(+), 59 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 018be98705a..4a74a0d4e8c 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -1,4 +1,3 @@
-
 config BITBANGMII
 	bool "Bit-banged ethernet MII management channel support"
 
@@ -91,23 +90,30 @@ menuconfig PHY_AQUANTIA
 config PHY_AQUANTIA_UPLOAD_FW
 	bool "Aquantia firmware loading support"
 	depends on PHY_AQUANTIA
+	select FS_LOADER
+	select FW_LOADER
 	help
-		Aquantia PHYs use firmware which can be either loaded automatically
-		from storage directly attached to the phy or loaded by the boot loader
-		via MDIO commands.  The firmware is loaded from a file, specified by
-		the PHY_AQUANTIA_FW_PART and PHY_AQUANTIA_FW_NAME options.
+	  Aquantia PHYs use firmware which can be either loaded automatically
+	  from storage directly attached to the phy or loaded by the boot loader
+	  via MDIO commands.
+
+	  This option enables loading the firmware using the generic
+	  firmware loader framework.
 
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
+	  The firmware loading script variable name.
 
 config PHY_ATHEROS
 	bool "Atheros Ethernet PHYs support"
diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index 461d4b07a40..934bd17eadd 100644
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
 
 #define AQUNTIA_10G_CTL 0x20
 #define AQUNTIA_VENDOR_P1 0xc400
@@ -127,51 +131,67 @@ struct fw_header {
 
 #pragma pack()
 
-#if defined(CONFIG_PHY_AQUANTIA_UPLOAD_FW)
-static int aquantia_read_fw(u8 **fw_addr, size_t *fw_length)
+#if (IS_ENABLED(CONFIG_PHY_AQUANTIA_UPLOAD_FW))
+int __weak aquantia_read_fw(struct phy_device *phydev, u8 **fw_addr,
+			    size_t *fw_length)
 {
-	loff_t length, read;
 	int ret;
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
+	ofnode node;
+	struct udevice *loader_dev;
+	const char *fw_name;
+	u8 *tmp_fw_addr;
+	size_t tmp_fw_length;
+
+	tmp_fw_addr = malloc(CONFIG_PHY_AQUANTIA_FW_MAX_SIZE);
+	if (!tmp_fw_addr) {
+		printf("Failed to allocate memory for firmware\n");
+		return -ENOMEM;
 	}
 
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
-		       CONFIG_PHY_AQUANTIA_FW_PART, CONFIG_PHY_AQUANTIA_FW_NAME,
-		       ret);
-		free(addr);
+	/* First, try to load firmware via script */
+	ret = request_firmware_into_buf_via_script(
+		tmp_fw_addr, CONFIG_PHY_AQUANTIA_FW_MAX_SIZE,
+		CONFIG_PHY_AQUANTIA_FW_LOADER_SCRIPT, &tmp_fw_length);
+	if (ret) {
+		/* Fallback to DT specified firmware */
+		node = phy_get_ofnode(phydev);
+		if (!ofnode_valid(node)) {
+			printf("Failed to get PHY node\n");
+			ret = -EINVAL;
+			goto fail_free;
+		}
+
+		fw_name = ofnode_read_string(node, "firmware-name");
+		if (!fw_name) {
+			printf("Failed to get firmware name\n");
+			ret = -ENOENT;
+			goto fail_free;
+		}
+
+		ret = get_fs_loader(&loader_dev);
+		if (ret) {
+			printf("Failed to get fs_loader instance: %d\n", ret);
+			goto fail_free;
+		}
+
+		ret = request_firmware_into_buf(loader_dev, fw_name,
+						tmp_fw_addr,
+						CONFIG_PHY_AQUANTIA_FW_MAX_SIZE,
+						0);
+		if (ret < 0) {
+			printf("Failed to load firmware %s: %d\n", fw_name,
+			       ret);
+			goto fail_free;
+		}
+		tmp_fw_length = ret;
 	}
+
+	*fw_addr = tmp_fw_addr;
+	*fw_length = tmp_fw_length;
+	return 1;
+
+fail_free:
+	free(tmp_fw_addr);
 	return ret;
 }
 
@@ -227,6 +247,11 @@ static int aquantia_do_upload_firmware(struct phy_device *phydev,
 	u32 primary_offset, iram_offset, iram_size, dram_offset, dram_size;
 	const struct fw_header *header;
 
+	if (!addr || !fw_length) {
+		printf("%s: Invalid firmware data\n", phydev->dev->name);
+		return -EINVAL;
+	}
+
 	read_crc = (addr[fw_length - 2] << 8) | addr[fw_length - 1];
 	calculated_crc = crc16_ccitt(0, addr, fw_length - 2);
 	if (read_crc != calculated_crc) {
@@ -290,17 +315,18 @@ static int aquantia_do_upload_firmware(struct phy_device *phydev,
 
 static int aquantia_upload_firmware(struct phy_device *phydev)
 {
-	int ret;
-	u8 *addr = NULL;
-	size_t fw_length = 0;
+	int ret, fwrc;
+	u8 *fw_addr = NULL;
+	size_t fw_length;
 
-	ret = aquantia_read_fw(&addr, &fw_length);
-	if (ret != 0)
-		return ret;
+	fwrc = aquantia_read_fw(phydev, &fw_addr, &fw_length);
+	if (fwrc < 0)
+		return fwrc;
 
-	ret = aquantia_do_upload_firmware(phydev, addr, fw_length);
+	ret = aquantia_do_upload_firmware(phydev, fw_addr, fw_length);
 
-	free(addr);
+	if (fwrc > 0)
+		free(fw_addr);
 
 	return ret;
 }
-- 
2.47.3

