Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1922ACCF9F0
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 12:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC83E83A9F;
	Sat,  1 Nov 2025 13:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="ZjxnjiNu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66CD383A84; Sat,  1 Nov 2025 13:34:30 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster4-host11-snip4-8.eps.apple.com [57.103.65.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4387583A84
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 13:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-4 (Postfix) with ESMTPS id
 9EA9E18000BA; Sat,  1 Nov 2025 12:34:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=Swut9NZ3dbC/HhEGlzDTktN/bdW2mQCBKL1pKVXCS+w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZjxnjiNuDUzG+BScK9NaHqlmEaRmDaM9oVjy0GUKc3y2IcbBaBmCtr645JIzETqZ1+xw4iudxnByjN9b1JWHox2aV0+KTr+lExgdmNPHtTme8nq1cAOBPkbYoB6inkOwu0eSDC9hIsvKGKDpIQPa2plcrqcVxec+unjQYk6BD84sdNLKbzDfrKLiJ8PFCad35gR9YVx7M3dM3go3ZqccdCSFQUzPi30n0Dfdgw/yVdEN4CR5ZepOf3RC/fdkv/EyUw1Cp4lzeTlXGZM2JtIkhCLVkQIOwf/VYzQjmhLPCJDcsfT2G1BJ5oUzqXKbd9eYc5fa+rNzrev3z+3/6Uzc+Q==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-4 (Postfix) with ESMTPSA id
 41D6B18013AA; Sat,  1 Nov 2025 12:34:21 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v5 2/2] net: phy: aquantia: use generic firmware loader
Date: Sat,  1 Nov 2025 20:31:35 +0800
Message-ID: <20251101123401.110681-3-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101123401.110681-1-root@infi.wang>
References: <20251101123401.110681-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AmdgBzBfflaXLhcsKaQoxZq3xHO71wum
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDEwNyBTYWx0ZWRfX1NzSxf5xPa/l
 GHWx61j24ZeDzK61FL2h+a1nNW0UQ66QMoKKmfcIdJlan+p4bx/93EEJbbOHS0glOnh3yU1dnxP
 QVEfP1ywabFHpshR0csdH+ZaYzsISidg7K398LAAGiLaP/G9kV1YwRNMqGAKU1i6Yrw0TGL9X5U
 RhitCnHfLTNjYczpUq7DYc0+e+29AmjHkvqJf1dP2gkR7OjAYTrYDk0Y2qI8REvhhInnJDXJ5gh
 QZbeb01IOluTW0dH7lul1y14EitA87TxOyhAoNcaMB1366zQlbpSYgtQSEV4eiPrEXc3lk+G8=
X-Proofpoint-ORIG-GUID: AmdgBzBfflaXLhcsKaQoxZq3xHO71wum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 clxscore=1030 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2511010107
X-JNJ: AAAAAAABthzrDldxNPRizjFEINJx8lBH4U6lY7L8yIWr9kZVViCJI0bO96qvOkwXW74myaSvYOBgykMkuvRwg7khoFIGCyHNn+spnVqcgvJES5sbky9rMCmALpPtmvQyoQZ5K9eryE5mCRvRYz+qScsfurWKk5HCR69TlMVVXKQfDAi9vJ8xD09jZfSn6B8gd3hAtts/zqwAkmkz8Xsib6yBHR+IwjtDubV1RKOaEmPFijfC1IBuW8+SqwMMeYv+sQ/xTL/s6K6wbZP2kjYHak4bSimdJBd4xD75vNTBszR8YCpFMX/i/IAoBwgQSJEmFF+T9iLOV+LQSK5SlJLBalLQyn5q1h2oZ+6HDFIMpmyRsO/6MX1vDT1i0QOk6uGb2Vj5tZ9fIazgVFsq+4Duq405w2F9PKp1xV0vzpjhUzDZPcga8suJEcXIkJk4xyxpqt79UC5wSckJKYFYMzoGmF5xI0U/Qb7fG3fWuJ1fUZsE67xNmsqkvON1qQ8xNHsfPAB9DvgFPUNr6YUWNp+tGkkO4SDxvfYkBN+HiVcfNFcetaNgJcBh0FDahyItJv9D3RLCDaozsYinTKwyrT7795m/Xbt/t80nqcUSR2JNQIUDAQ4kucNeiQR1s5HXMr8/Btv2A5Co4VjRTggaCn9Tv4BbEHFIiIxoAFt73m4LOAbF1sRZeKCSg6J/5guCYnn7CaHQsckViHZ9VmhjvXjGFwgpJuwz6xmt22NLpf/rvAPiXpW5YnqoxP4lgY4HqPxtWWjdikdkkoQFIKzFtCkhBdiumftQQFNemRnKLxlcFuhJAwhEKNTNAJbTBqI=
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

Removed the old firmware loader, migrate to generic script based firmware
loader to allow a wider range and runtime override of firmware source.
(e.g., MMC, USB, UBIFS).

Tested on Buffalo WXR18000BE10P with UBIFS.

Signed-off-by: Beiyan Yun <root@infi.wang>
---

Changes in v5:
- Remove fsloader codepath
- Drop binding changes
- Make script name static

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

 drivers/net/phy/Kconfig    | 23 ++++++------
 drivers/net/phy/aquantia.c | 76 ++++++++++++++------------------------
 2 files changed, 39 insertions(+), 60 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 018be98705a..d8845469dd5 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -91,23 +91,22 @@ menuconfig PHY_AQUANTIA
 config PHY_AQUANTIA_UPLOAD_FW
 	bool "Aquantia firmware loading support"
 	depends on PHY_AQUANTIA
+	select FW_LOADER
 	help
-		Aquantia PHYs use firmware which can be either loaded automatically
-		from storage directly attached to the phy or loaded by the boot loader
-		via MDIO commands.  The firmware is loaded from a file, specified by
-		the PHY_AQUANTIA_FW_PART and PHY_AQUANTIA_FW_NAME options.
+	  Aquantia PHYs use firmware which can be either loaded automatically
+	  from storage directly attached to the phy or loaded by the boot loader
+	  via MDIO commands.
 
-config PHY_AQUANTIA_FW_PART
-	string "Aquantia firmware partition"
-	depends on PHY_AQUANTIA_UPLOAD_FW
-	help
-		Partition containing the firmware file.
+	  This option enables loading the firmware using the generic
+	  firmware loader framework.
 
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
index fc2476fb038..e0deef58f52 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -16,7 +16,9 @@
 #include <u-boot/crc.h>
 #include <malloc.h>
 #include <asm/byteorder.h>
-#include <fs.h>
+#if (IS_ENABLED(CONFIG_PHY_AQUANTIA_UPLOAD_FW))
+#include <fw_loader.h>
+#endif
 
 #define AQUNTIA_10G_CTL		0x20
 #define AQUNTIA_VENDOR_P1	0xc400
@@ -127,52 +129,29 @@ struct fw_header {
 
 #pragma pack()
 
-#if defined(CONFIG_PHY_AQUANTIA_UPLOAD_FW)
-static int aquantia_read_fw(u8 **fw_addr, size_t *fw_length)
+#if (IS_ENABLED(CONFIG_PHY_AQUANTIA_UPLOAD_FW))
+int __weak aquantia_read_fw(struct phy_device *phydev,
+			    u8 **fw_addr, size_t *fw_length)
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
+	u8 *microcode;
 
-	*fw_addr = addr;
-	*fw_length = length;
-	debug("Found Aquantia microcode.\n");
+	microcode = malloc(CONFIG_PHY_AQUANTIA_FW_MAX_SIZE);
+	if (!microcode) {
+		printf("Failed to allocate memory for firmware\n");
+		return -ENOMEM;
+	}
 
-cleanup:
-	if (ret < 0) {
-		printf("loading firmware file %s %s failed with error %d\n",
-		       CONFIG_PHY_AQUANTIA_FW_PART,
-		       CONFIG_PHY_AQUANTIA_FW_NAME, ret);
-		free(addr);
+	ret = request_firmware_into_buf_via_script(
+		microcode, CONFIG_PHY_AQUANTIA_FW_MAX_SIZE,
+		"aqr_phy_load_firmware", fw_length);
+	if (ret) {
+		free(microcode);
+		return ret;
 	}
-	return ret;
+
+	*fw_addr = microcode;
+	return 1;
 }
 
 /* load data into the phy's memory */
@@ -293,16 +272,17 @@ static int aquantia_do_upload_firmware(struct phy_device *phydev,
 
 static int aquantia_upload_firmware(struct phy_device *phydev)
 {
-	int ret;
+	int ret, fwrc;
 	u8 *addr = NULL;
-	size_t fw_length = 0;
+	size_t fw_length;
 
-	ret = aquantia_read_fw(&addr, &fw_length);
-	if (ret != 0)
-		return ret;
+	fwrc = aquantia_read_fw(phydev, &addr, &fw_length);
+	if (fwrc < 0)
+		return fwrc;
 
 	ret = aquantia_do_upload_firmware(phydev, addr, fw_length);
-	free(addr);
+	if (fwrc > 0)
+		free(addr);
 
 	return ret;
 }
-- 
2.47.3

