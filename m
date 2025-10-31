Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89352CCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B8483959;
	Fri, 31 Oct 2025 16:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="Hgqr50Ow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04FB9839AC; Fri, 31 Oct 2025 16:24:16 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster2-host3-snip4-2.eps.apple.com [57.103.64.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC67E83677
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPS id
 37BA61800236; Fri, 31 Oct 2025 15:24:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=oIcAW1FZggBeT0+EhWRVUDRKtgJy2n7KhhcGbpNBPLw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Hgqr50OwxAjTU8NeResYyD8qLxP15j/YIWAXK2rc6mm6RxiKosY9ogWTI8aH7LlVGDxSEclnRkKS/cGDsPuAlEdXklWUwMbtKe28Nyjr7BbD0Ku+lGGaEe6Hp1qV84lUc+/Fb0+dHEDn4vthfM6YWA1KZhMSt47Zm04MBSCP1ElbqSUrSx0BWTNJGPSWZmNxwYR/gulQ1k62hw3+VbGb3Ow7Gnas+auz2uDgzJFYXIJr6jt8cCATb7tB1U2n66rtaFnKb5mmIFUfB9GM5qKZKyqbU3DLbWZUTws0gq2RanHHJB8OYiCt6vBUAoKTLXpg67sTt5ZwOHnjkVDno26z5w==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPSA id
 76A711800B4C; Fri, 31 Oct 2025 15:24:07 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Yao Zi <ziyao@disroot.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v4 1/5] net: phy: aquantia: refresh format
Date: Fri, 31 Oct 2025 23:21:03 +0800
Message-ID: <20251031152348.60571-2-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031152348.60571-1-root@infi.wang>
References: <20251031152348.60571-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: u-ylHbWapH_ZoCSu-eH8mE_uGgL1lxcB
X-Proofpoint-GUID: u-ylHbWapH_ZoCSu-eH8mE_uGgL1lxcB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzOCBTYWx0ZWRfX8CZ9uiWDj60g
 CU3SqmQRFbDi+b8EAHSSj1bu4BkwSL/HGetyPYQLZ67PgYtT6z77ph3rYAhoYlAjin7Uo4lb4mk
 m78OTy6qxRDIHQHS02zm1bZugqmxsjE3saPkTOhpny5wTRRZzAi2CUbkn4ngV6Y1xbxIlD+Qo5k
 ItkQio1NJB0D8IWMVedJivoBY3TeAIRu95tLKhl7VYxnf/CaCcmBq+gavKk6c69tLVJOlnB618O
 Jml2mXbTFVa1K3l/IeRzGFrwcmFxOs3aXsT7j91alhJrk9kOefTJQD1i+aRuT2hCiuP8f9vJg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=925 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510310138
X-JNJ: AAAAAAABWaHLowBnhqHwIJxmYBJdE9WmlKLovaBmE7SYQle/bpA3fYt8YgfQJl37U1iSXuIAU1a7LflOENqGgxqOYw/1kkgyzGw3uEcsE3Uj9/WWmzjJ3nfvHQxQSDPIdtDfnR5VdiZhQEYdVtq9HkZToASJLROCIW2d7N+d9UYJ4zFf4WGwR/YRUX/fBfJgXWfaD4qP16M6lsadpVcLSi9fcipqcG98BjgNTA2T4/sKBqEPbaaZbO4FtwsLfWKykwvdNjduhxCg9T3QyiQcLAzNSxoWnJQNz8R1pVFKNPy4pK2Llia8R+lWq7qXEEW1oYp0G66DOJZWjeJn3DIGgWydNrLiUgu7uON/PK9IqniNX5CRta6kjsLAmQeYvLR+Fe3bGt/3lT2LMDurWvsBRj4e+Ke9roGR0Bt0LY7DzO0QULF1K/EFNaMggs2xjLqvRnAZtPf4dBgKMbLVsb6wcTkAJz+Htj4XRY2A6eQz0BO0IhGKQj4p0oPz7ndAdiHmIgyA8JJmi+n7hsbvLpdsEY4kUrnEfk+mhgkOvdZ4OWqj/+5LTrQDMVX9ItQo5sbwQjWGLk8gVL2Zxg2blROEbz2JW3A/oQezhMBihPirZ5Q4sl8EqtKvJs8oV9lDzmexFXoOynS8qroX+Ew0Le/UqiwGWi927L+oyFY8L1myDoJZ3DsJcoCkxdHPYxbu55ZG4/jq39I+uXT3EoOM77SA2od/M7JF1Wve0JAvi7Q=
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

Refresh format using clang-format.

Signed-off-by: Beiyan Yun <root@infi.wang>

---

Changes in v4:
- New

 drivers/net/phy/aquantia.c | 159 +++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 84 deletions(-)

diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index 903fcd667f6..439c4c48bdc 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -18,28 +18,28 @@
 #include <asm/byteorder.h>
 #include <fs.h>
 
-#define AQUNTIA_10G_CTL		0x20
-#define AQUNTIA_VENDOR_P1	0xc400
+#define AQUNTIA_10G_CTL 0x20
+#define AQUNTIA_VENDOR_P1 0xc400
 
-#define AQUNTIA_SPEED_LSB_MASK	0x2000
-#define AQUNTIA_SPEED_MSB_MASK	0x40
+#define AQUNTIA_SPEED_LSB_MASK 0x2000
+#define AQUNTIA_SPEED_MSB_MASK 0x40
 
-#define AQUANTIA_SYSTEM_INTERFACE_SR     0xe812
-#define  AQUANTIA_SYSTEM_INTERFACE_SR_READY	BIT(0)
+#define AQUANTIA_SYSTEM_INTERFACE_SR 0xe812
+#define AQUANTIA_SYSTEM_INTERFACE_SR_READY BIT(0)
 #define AQUANTIA_VENDOR_PROVISIONING_REG 0xC441
-#define AQUANTIA_FIRMWARE_ID		 0x20
-#define AQUANTIA_RESERVED_STATUS	 0xc885
-#define AQUANTIA_FIRMWARE_MAJOR_MASK	 0xff00
-#define AQUANTIA_FIRMWARE_MINOR_MASK	 0xff
-#define AQUANTIA_FIRMWARE_BUILD_MASK	 0xf0
+#define AQUANTIA_FIRMWARE_ID 0x20
+#define AQUANTIA_RESERVED_STATUS 0xc885
+#define AQUANTIA_FIRMWARE_MAJOR_MASK 0xff00
+#define AQUANTIA_FIRMWARE_MINOR_MASK 0xff
+#define AQUANTIA_FIRMWARE_BUILD_MASK 0xf0
 
 #define AQUANTIA_USX_AUTONEG_CONTROL_ENA 0x0008
-#define AQUANTIA_SI_IN_USE_MASK          0x0078
-#define AQUANTIA_SI_USXGMII              0x0018
+#define AQUANTIA_SI_IN_USE_MASK 0x0078
+#define AQUANTIA_SI_USXGMII 0x0018
 
 /* registers in MDIO_MMD_VEND1 region */
-#define AQUANTIA_VND1_GLOBAL_SC			0x000
-#define  AQUANTIA_VND1_GLOBAL_SC_LP		BIT(0xb)
+#define AQUANTIA_VND1_GLOBAL_SC 0x000
+#define AQUANTIA_VND1_GLOBAL_SC_LP BIT(0xb)
 
 #define GLOBAL_FIRMWARE_ID 0x20
 #define GLOBAL_FAULT 0xc850
@@ -71,35 +71,35 @@
 #define UP_RUN_STALL_OVERRIDE BIT(6)
 #define UP_RUN_STALL BIT(0)
 
-#define AQUANTIA_PMA_RX_VENDOR_P1		0xe400
-#define  AQUANTIA_PMA_RX_VENDOR_P1_MDI_MSK	GENMASK(1, 0)
+#define AQUANTIA_PMA_RX_VENDOR_P1 0xe400
+#define AQUANTIA_PMA_RX_VENDOR_P1_MDI_MSK GENMASK(1, 0)
 /* MDI reversal configured through registers */
-#define  AQUANTIA_PMA_RX_VENDOR_P1_MDI_CFG	BIT(1)
+#define AQUANTIA_PMA_RX_VENDOR_P1_MDI_CFG BIT(1)
 /* MDI reversal enabled */
-#define  AQUANTIA_PMA_RX_VENDOR_P1_MDI_REV	BIT(0)
+#define AQUANTIA_PMA_RX_VENDOR_P1_MDI_REV BIT(0)
 
 /*
  * global start rate, the protocol associated with this speed is used by default
  * on SI.
  */
-#define AQUANTIA_VND1_GSTART_RATE		0x31a
-#define  AQUANTIA_VND1_GSTART_RATE_OFF		0
-#define  AQUANTIA_VND1_GSTART_RATE_100M		1
-#define  AQUANTIA_VND1_GSTART_RATE_1G		2
-#define  AQUANTIA_VND1_GSTART_RATE_10G		3
-#define  AQUANTIA_VND1_GSTART_RATE_2_5G		4
-#define  AQUANTIA_VND1_GSTART_RATE_5G		5
+#define AQUANTIA_VND1_GSTART_RATE 0x31a
+#define AQUANTIA_VND1_GSTART_RATE_OFF 0
+#define AQUANTIA_VND1_GSTART_RATE_100M 1
+#define AQUANTIA_VND1_GSTART_RATE_1G 2
+#define AQUANTIA_VND1_GSTART_RATE_10G 3
+#define AQUANTIA_VND1_GSTART_RATE_2_5G 4
+#define AQUANTIA_VND1_GSTART_RATE_5G 5
 
 /* SYSCFG registers for 100M, 1G, 2.5G, 5G, 10G */
-#define AQUANTIA_VND1_GSYSCFG_BASE		0x31b
-#define AQUANTIA_VND1_GSYSCFG_100M		0
-#define AQUANTIA_VND1_GSYSCFG_1G		1
-#define AQUANTIA_VND1_GSYSCFG_2_5G		2
-#define AQUANTIA_VND1_GSYSCFG_5G		3
-#define AQUANTIA_VND1_GSYSCFG_10G		4
+#define AQUANTIA_VND1_GSYSCFG_BASE 0x31b
+#define AQUANTIA_VND1_GSYSCFG_100M 0
+#define AQUANTIA_VND1_GSYSCFG_1G 1
+#define AQUANTIA_VND1_GSYSCFG_2_5G 2
+#define AQUANTIA_VND1_GSYSCFG_5G 3
+#define AQUANTIA_VND1_GSYSCFG_10G 4
 
-#define AQUANTIA_VND1_SMBUS0			0xc485
-#define AQUANTIA_VND1_SMBUS1			0xc495
+#define AQUANTIA_VND1_SMBUS0 0xc485
+#define AQUANTIA_VND1_SMBUS1 0xc495
 
 /* addresses of memory segments in the phy */
 #define DRAM_BASE_ADDR 0x3FFE0000
@@ -111,10 +111,10 @@
 #define HEADER_OFFSET 0x300
 
 /* driver private data */
-#define AQUANTIA_NA		0
-#define AQUANTIA_GEN1		1
-#define AQUANTIA_GEN2		2
-#define AQUANTIA_GEN3		3
+#define AQUANTIA_NA 0
+#define AQUANTIA_GEN1 1
+#define AQUANTIA_GEN2 2
+#define AQUANTIA_GEN3 3
 
 #pragma pack(1)
 struct fw_header {
@@ -168,8 +168,8 @@ static int aquantia_read_fw(u8 **fw_addr, size_t *fw_length)
 cleanup:
 	if (ret < 0) {
 		printf("loading firmware file %s %s failed with error %d\n",
-		       CONFIG_PHY_AQUANTIA_FW_PART,
-		       CONFIG_PHY_AQUANTIA_FW_NAME, ret);
+		       CONFIG_PHY_AQUANTIA_FW_PART, CONFIG_PHY_AQUANTIA_FW_NAME,
+		       ret);
 		free(addr);
 	}
 	return ret;
@@ -232,7 +232,7 @@ static int aquantia_upload_firmware(struct phy_device *phydev)
 	if (ret != 0)
 		return ret;
 
-	read_crc = (addr[fw_length - 2] << 8)  | addr[fw_length - 1];
+	read_crc = (addr[fw_length - 2] << 8) | addr[fw_length - 1];
 	calculated_crc = crc16_ccitt(0, addr, fw_length - 2);
 	if (read_crc != calculated_crc) {
 		printf("%s bad firmware crc: file 0x%04x calculated 0x%04x\n",
@@ -257,21 +257,22 @@ static int aquantia_upload_firmware(struct phy_device *phydev)
 
 	strlcpy(version, (char *)&addr[dram_offset + VERSION_STRING_OFFSET],
 		VERSION_STRING_SIZE);
-	printf("%s loading firmware version '%s'\n", phydev->dev->name, version);
+	printf("%s loading firmware version '%s'\n", phydev->dev->name,
+	       version);
 
 	/* stall the microcprocessor */
 	phy_write(phydev, MDIO_MMD_VEND1, UP_CONTROL,
 		  UP_RUN_STALL | UP_RUN_STALL_OVERRIDE);
 
-	debug("loading dram 0x%08x from offset=%d size=%d\n",
-	      DRAM_BASE_ADDR, dram_offset, dram_size);
+	debug("loading dram 0x%08x from offset=%d size=%d\n", DRAM_BASE_ADDR,
+	      dram_offset, dram_size);
 	ret = aquantia_load_memory(phydev, DRAM_BASE_ADDR, &addr[dram_offset],
 				   dram_size);
 	if (ret != 0)
 		goto done;
 
-	debug("loading iram 0x%08x from offset=%d size=%d\n",
-	      IRAM_BASE_ADDR, iram_offset, iram_size);
+	debug("loading iram 0x%08x from offset=%d size=%d\n", IRAM_BASE_ADDR,
+	      iram_offset, iram_size);
 	ret = aquantia_load_memory(phydev, IRAM_BASE_ADDR, &addr[iram_offset],
 				   iram_size);
 	if (ret != 0)
@@ -306,14 +307,14 @@ struct {
 	int cnt;
 	u16 start_rate;
 } aquantia_syscfg[PHY_INTERFACE_MODE_MAX] = {
-	[PHY_INTERFACE_MODE_SGMII] =      {0x04b, AQUANTIA_VND1_GSYSCFG_1G,
-					   AQUANTIA_VND1_GSTART_RATE_1G},
-	[PHY_INTERFACE_MODE_2500BASEX]  = {0x144, AQUANTIA_VND1_GSYSCFG_2_5G,
-					   AQUANTIA_VND1_GSTART_RATE_2_5G},
-	[PHY_INTERFACE_MODE_10GBASER] =   {0x100, AQUANTIA_VND1_GSYSCFG_10G,
-					   AQUANTIA_VND1_GSTART_RATE_10G},
-	[PHY_INTERFACE_MODE_USXGMII] =    {0x080, AQUANTIA_VND1_GSYSCFG_10G,
-					   AQUANTIA_VND1_GSTART_RATE_10G},
+	[PHY_INTERFACE_MODE_SGMII] = { 0x04b, AQUANTIA_VND1_GSYSCFG_1G,
+				       AQUANTIA_VND1_GSTART_RATE_1G },
+	[PHY_INTERFACE_MODE_2500BASEX] = { 0x144, AQUANTIA_VND1_GSYSCFG_2_5G,
+					   AQUANTIA_VND1_GSTART_RATE_2_5G },
+	[PHY_INTERFACE_MODE_10GBASER] = { 0x100, AQUANTIA_VND1_GSYSCFG_10G,
+					  AQUANTIA_VND1_GSTART_RATE_10G },
+	[PHY_INTERFACE_MODE_USXGMII] = { 0x080, AQUANTIA_VND1_GSYSCFG_10G,
+					 AQUANTIA_VND1_GSTART_RATE_10G },
 };
 
 static int aquantia_set_proto(struct phy_device *phydev,
@@ -352,8 +353,8 @@ static int aquantia_dts_config(struct phy_device *phydev)
 
 	if (!ofnode_read_u32(node, "mdi-reversal", &prop)) {
 		debug("mdi-reversal = %d\n", (int)prop);
-		reg =  phy_read(phydev, MDIO_MMD_PMAPMD,
-				AQUANTIA_PMA_RX_VENDOR_P1);
+		reg = phy_read(phydev, MDIO_MMD_PMAPMD,
+			       AQUANTIA_PMA_RX_VENDOR_P1);
 		reg &= ~AQUANTIA_PMA_RX_VENDOR_P1_MDI_MSK;
 		reg |= AQUANTIA_PMA_RX_VENDOR_P1_MDI_CFG;
 		reg |= prop ? AQUANTIA_PMA_RX_VENDOR_P1_MDI_REV : 0;
@@ -501,11 +502,11 @@ int aquantia_config(struct phy_device *phydev)
 		    !(val & AQUNTIA_SPEED_MSB_MASK))
 			phy_write(phydev, MDIO_MMD_PMAPMD, MII_BMCR,
 				  AQUNTIA_SPEED_LSB_MASK |
-				  AQUNTIA_SPEED_MSB_MASK);
+					  AQUNTIA_SPEED_MSB_MASK);
 
 		/* If SI is USXGMII then start USXGMII autoneg */
-		reg_val1 =  phy_read(phydev, MDIO_MMD_PHYXS,
-				     AQUANTIA_VENDOR_PROVISIONING_REG);
+		reg_val1 = phy_read(phydev, MDIO_MMD_PHYXS,
+				    AQUANTIA_VENDOR_PROVISIONING_REG);
 
 		if (usx_an) {
 			reg_val1 |= AQUANTIA_USX_AUTONEG_CONTROL_ENA;
@@ -542,8 +543,7 @@ int aquantia_config(struct phy_device *phydev)
 	reg_val1 = phy_read(phydev, MDIO_MMD_VEND1, AQUANTIA_FIRMWARE_ID);
 
 	debug("%s: %s Firmware Version %x.%x.%x\n", phydev->dev->name,
-	      phydev->drv->name,
-	      (reg_val1 & AQUANTIA_FIRMWARE_MAJOR_MASK) >> 8,
+	      phydev->drv->name, (reg_val1 & AQUANTIA_FIRMWARE_MAJOR_MASK) >> 8,
 	      reg_val1 & AQUANTIA_FIRMWARE_MINOR_MASK,
 	      (val & AQUANTIA_FIRMWARE_BUILD_MASK) >> 4);
 
@@ -604,9 +604,8 @@ U_BOOT_PHY_DRIVER(aq1202) = {
 	.uid = 0x3a1b445,
 	.mask = 0xfffffff0,
 	.features = PHY_10G_FEATURES,
-	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS|
-			MDIO_MMD_PHYXS | MDIO_MMD_AN |
-			MDIO_MMD_VEND1),
+	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS | MDIO_MMD_PHYXS | MDIO_MMD_AN |
+		 MDIO_MMD_VEND1),
 	.config = &aquantia_config,
 	.startup = &aquantia_startup,
 	.shutdown = &gen10g_shutdown,
@@ -617,9 +616,8 @@ U_BOOT_PHY_DRIVER(aq2104) = {
 	.uid = 0x3a1b460,
 	.mask = 0xfffffff0,
 	.features = PHY_10G_FEATURES,
-	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS|
-			MDIO_MMD_PHYXS | MDIO_MMD_AN |
-			MDIO_MMD_VEND1),
+	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS | MDIO_MMD_PHYXS | MDIO_MMD_AN |
+		 MDIO_MMD_VEND1),
 	.config = &aquantia_config,
 	.startup = &aquantia_startup,
 	.shutdown = &gen10g_shutdown,
@@ -630,9 +628,8 @@ U_BOOT_PHY_DRIVER(aqr105) = {
 	.uid = 0x3a1b4a2,
 	.mask = 0xfffffff0,
 	.features = PHY_10G_FEATURES,
-	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS|
-			MDIO_MMD_PHYXS | MDIO_MMD_AN |
-			MDIO_MMD_VEND1),
+	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS | MDIO_MMD_PHYXS | MDIO_MMD_AN |
+		 MDIO_MMD_VEND1),
 	.config = &aquantia_config,
 	.startup = &aquantia_startup,
 	.shutdown = &gen10g_shutdown,
@@ -644,9 +641,8 @@ U_BOOT_PHY_DRIVER(aqr106) = {
 	.uid = 0x3a1b4d0,
 	.mask = 0xfffffff0,
 	.features = PHY_10G_FEATURES,
-	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS|
-			MDIO_MMD_PHYXS | MDIO_MMD_AN |
-			MDIO_MMD_VEND1),
+	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS | MDIO_MMD_PHYXS | MDIO_MMD_AN |
+		 MDIO_MMD_VEND1),
 	.config = &aquantia_config,
 	.startup = &aquantia_startup,
 	.shutdown = &gen10g_shutdown,
@@ -657,9 +653,8 @@ U_BOOT_PHY_DRIVER(aqr107) = {
 	.uid = 0x3a1b4e0,
 	.mask = 0xfffffff0,
 	.features = PHY_10G_FEATURES,
-	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS|
-			MDIO_MMD_PHYXS | MDIO_MMD_AN |
-			MDIO_MMD_VEND1),
+	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS | MDIO_MMD_PHYXS | MDIO_MMD_AN |
+		 MDIO_MMD_VEND1),
 	.config = &aquantia_config,
 	.startup = &aquantia_startup,
 	.shutdown = &gen10g_shutdown,
@@ -671,8 +666,7 @@ U_BOOT_PHY_DRIVER(aqr112) = {
 	.uid = 0x3a1b660,
 	.mask = 0xfffffff0,
 	.features = PHY_10G_FEATURES,
-	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS |
-		 MDIO_MMD_PHYXS | MDIO_MMD_AN |
+	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS | MDIO_MMD_PHYXS | MDIO_MMD_AN |
 		 MDIO_MMD_VEND1),
 	.config = &aquantia_config,
 	.startup = &aquantia_startup,
@@ -685,8 +679,7 @@ U_BOOT_PHY_DRIVER(aqr113c) = {
 	.uid = 0x31c31c12,
 	.mask = 0xfffffff0,
 	.features = PHY_10G_FEATURES,
-	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS |
-		 MDIO_MMD_PHYXS | MDIO_MMD_AN |
+	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS | MDIO_MMD_PHYXS | MDIO_MMD_AN |
 		 MDIO_MMD_VEND1),
 	.config = &aquantia_config,
 	.startup = &aquantia_startup,
@@ -699,8 +692,7 @@ U_BOOT_PHY_DRIVER(aqr405) = {
 	.uid = 0x3a1b4b2,
 	.mask = 0xfffffff0,
 	.features = PHY_10G_FEATURES,
-	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS|
-		 MDIO_MMD_PHYXS | MDIO_MMD_AN |
+	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS | MDIO_MMD_PHYXS | MDIO_MMD_AN |
 		 MDIO_MMD_VEND1),
 	.config = &aquantia_config,
 	.startup = &aquantia_startup,
@@ -713,8 +705,7 @@ U_BOOT_PHY_DRIVER(aqr412) = {
 	.uid = 0x3a1b710,
 	.mask = 0xfffffff0,
 	.features = PHY_10G_FEATURES,
-	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS |
-		 MDIO_MMD_PHYXS | MDIO_MMD_AN |
+	.mmds = (MDIO_MMD_PMAPMD | MDIO_MMD_PCS | MDIO_MMD_PHYXS | MDIO_MMD_AN |
 		 MDIO_MMD_VEND1),
 	.config = &aquantia_config,
 	.startup = &aquantia_startup,
-- 
2.47.3

