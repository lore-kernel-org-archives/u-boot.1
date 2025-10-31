Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A2ECCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5EB839B7;
	Fri, 31 Oct 2025 16:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="oxy2QeHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BBB783677; Fri, 31 Oct 2025 16:24:26 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster5-host10-snip4-7.eps.apple.com [57.103.66.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40BA9839B7
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:24:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPS id
 3E8BD1800222; Fri, 31 Oct 2025 15:24:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=o5AJ6Zn0NCmP0UHTb3C0rOdTdE/85JGLuTyFsdQvx7w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=oxy2QeHLbFaxYBg/qWoONevJQnfpftunu4Bn1GL1HKnEaigUgd4gk3RVqMxLF3IN6UB/GU5326i0kfvaUiL9K3IZ8GQjZwNwsiXmeZaLqlMQDeThb6QorMCLnsRhxxs3GLf9RXURveG8slwp3NAV8saK8RfI9l1FP822vyQnOpLQSPYV+bztTaKzU8bVmtxVHGp629VxKX3AADeOBa8n25gvokI1hT5VmQ/1caMCE/snJy3QYY4hjSygmE9A9uDeVxa15uhTcIm8JkD65LqapRvABlmw/cxFS7Ny6i5PhORs9SSFGkaWX1QNIFnXLymwIaxSZ43ANyAeUEBe3pBZSg==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPSA id
 6E1B918003EF; Fri, 31 Oct 2025 15:24:17 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Yao Zi <ziyao@disroot.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v4 4/5] net: phy: aquantia: refactor firmware upload helpers
Date: Fri, 31 Oct 2025 23:21:06 +0800
Message-ID: <20251031152348.60571-5-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031152348.60571-1-root@infi.wang>
References: <20251031152348.60571-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tYcJ0k8NbeY0QEtcX_QajT6Iar4n54fD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzOCBTYWx0ZWRfXw1J0+KKTi4Zo
 qgPoZeFFn1JtbclyyqOm0KKePASEzGODqKQPVMPPHX6lHGRAK2ND877QlPYskBvk4LYcEgtoi0E
 CgxcmDuBX6cPjVK3ww0yujebwNud4ZTvb8bS8+lW6RRzPFBodUkkF+tWOPNw8FKl7+YDYKKaboY
 d4gAWoVd6OhZAlQeDgX7DLf/hRSuP309/LNa7VwbL6dZgodRP0ERPl5RRSsllJuayhSUbpR7Z3e
 sE4hRk1N7LV7u+o1IMNL8zvTSVP4E5MSIsrU8vot3JP953MENNTDF1nX/MY7o0HBJ1mw/UcWk=
X-Proofpoint-ORIG-GUID: tYcJ0k8NbeY0QEtcX_QajT6Iar4n54fD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=910 phishscore=0 clxscore=1030
 suspectscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510310138
X-JNJ: AAAAAAABrQVwTslQd4jY81TmrvMuTg69ASc9pXXxKmKTkbbx5EmaLlMT+Yzx/AQI3ZQpL3yEwz+K9FsUYlDw9S3hCLJJHhNL0J4Ql/dNz7AdEXeEZh9bZu2rAnDRUQ4M5NGQ8bgqTWn5gFdazsNnzSlTvyi8gBJk1Ej3oGv1ONfXZ0PcyORx0Pi7X9RY7FKSv0pUiAiV2vQsvde82hvA7vvmgM9qPwC5XY03RABqgPUDuT0JdIryfUdRgpU9CM14BRG28BjW0gZB/u5+nQFxsBp/HvS0gq22iQVWcQ6HsDMGCTwESey+gu7qNRGyjHcKBLnmWvdiGSEyB+opjwZusE/ANsXfs1ZQBgRq1X4vZaKJmIjw3cpgCFWPTfNESWIgfjE2dZoDEiq088iRsmXwD/p7781y0FUDgm+nl3xxjYBnG/A4qYTAfBFzgiJoNiPmHJqy9+8HOLdoAiy6xYzGMe/FjvEIETMtR0E4jZugKD5jW0U7ckvu9NgIgC4AuC9rDeylqbALUepKLiT4oAJtdsrVYZYfRuzTsahP3si6jOR/09Xjd32KY694sIK97DJ4PY9VluK9U1+ChTmr5M/WM6MJOgLd0bqPAUcIsQGclJLosdXzSPBXfxpPHyn+/tUfjnJ94IQdCu5NsHsCQ8AfosxErcwT7X1Ugyci82AXPhqWHapMxA6pvQgiadwgbECwzUGBcsy+Y1Uh1Ce78EWX+TQICKLc/8K4mffX+VrWTMI=
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

Split `aquantia_upload_firmware` into `aquantia_upload_firmware`
and `aquantia_do_upload_firmware` to prepare for fsloader change.

Signed-off-by: Beiyan Yun <root@infi.wang>

Patch-cc:marek
---

Changes in v4:
- New

 drivers/net/phy/aquantia.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index 11e450cdb0b..461d4b07a40 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -218,27 +218,21 @@ static u32 unpack_u24(const u8 *data)
 	return (data[2] << 16) + (data[1] << 8) + data[0];
 }
 
-static int aquantia_upload_firmware(struct phy_device *phydev)
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
-
 	read_crc = (addr[fw_length - 2] << 8) | addr[fw_length - 1];
 	calculated_crc = crc16_ccitt(0, addr, fw_length - 2);
 	if (read_crc != calculated_crc) {
 		printf("%s bad firmware crc: file 0x%04x calculated 0x%04x\n",
 		       phydev->dev->name, read_crc, calculated_crc);
-		ret = -EINVAL;
-		goto done;
+		return -EINVAL;
 	}
 
 	/* Find the DRAM and IRAM sections within the firmware file. */
@@ -269,14 +263,14 @@ static int aquantia_upload_firmware(struct phy_device *phydev)
 	ret = aquantia_load_memory(phydev, DRAM_BASE_ADDR, &addr[dram_offset],
 				   dram_size);
 	if (ret != 0)
-		goto done;
+		return ret;
 
 	debug("loading iram 0x%08x from offset=%d size=%d\n", IRAM_BASE_ADDR,
 	      iram_offset, iram_size);
 	ret = aquantia_load_memory(phydev, IRAM_BASE_ADDR, &addr[iram_offset],
 				   iram_size);
 	if (ret != 0)
-		goto done;
+		return ret;
 
 	/* make sure soft reset and low power mode are clear */
 	phy_write(phydev, MDIO_MMD_VEND1, GLOBAL_STANDARD_CONTROL, 0);
@@ -290,8 +284,24 @@ static int aquantia_upload_firmware(struct phy_device *phydev)
 	phy_write(phydev, MDIO_MMD_VEND1, UP_CONTROL, UP_RUN_STALL_OVERRIDE);
 
 	printf("%s firmware loading done.\n", phydev->dev->name);
-done:
+
+	return 0;
+}
+
+static int aquantia_upload_firmware(struct phy_device *phydev)
+{
+	int ret;
+	u8 *addr = NULL;
+	size_t fw_length = 0;
+
+	ret = aquantia_read_fw(&addr, &fw_length);
+	if (ret != 0)
+		return ret;
+
+	ret = aquantia_do_upload_firmware(phydev, addr, fw_length);
+
 	free(addr);
+
 	return ret;
 }
 #else
-- 
2.47.3

