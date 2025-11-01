Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69739CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 12:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B72383A5C;
	Sat,  1 Nov 2025 13:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="JrGpTMst";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D109183A1B; Sat,  1 Nov 2025 13:34:25 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster4-host6-snip4-10.eps.apple.com [57.103.65.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C949D83A5C
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 13:34:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-4 (Postfix) with ESMTPS id
 D4B1B18013A1; Sat,  1 Nov 2025 12:34:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=XXQTMNOzUPOXliKBI8omXIcmtVSKXZbfKn7vdudqa1E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JrGpTMstfRV4WZN7or1ttknFCJXCKXvmv9jHUclebfPz79s+zByVf5vCEKs0/y8W5JNZHrkMGjVbOIsEVcbmO22xuOyqJCeYpyPrEREodC66/Ru67GQ4+a5yUI/aa0vDzmzKPDLVaMJOeNpgf14I4kYDRo+Ifvfv2B4DiGZ9LtLUMlKNEIl5UUjwJUisNsq71ub9x6p4FPeFCrOLjLrWVXkwhnSYDrNlSWjI2jARoVAiNzktWDKvNt4eJwhZPEDQJQbe+F3V6tI2/F+/+O/+ZToo2viRfpNe+92BeiztqX9jhvma/HB+X60q5ZrxHWH83e+rQnM4lYzgDg1qhKY33w==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-4 (Postfix) with ESMTPSA id
 286EB18013A8; Sat,  1 Nov 2025 12:34:16 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v5 1/2] net: phy: aquantia: refactor firmware upload helpers
Date: Sat,  1 Nov 2025 20:31:34 +0800
Message-ID: <20251101123401.110681-2-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101123401.110681-1-root@infi.wang>
References: <20251101123401.110681-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JXQEm3yoXgdC1C7FAhlP_ZywXSKcqr8j
X-Proofpoint-GUID: JXQEm3yoXgdC1C7FAhlP_ZywXSKcqr8j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDEwNyBTYWx0ZWRfX5YUHqD/m+tGT
 ksWiG+M5CJdQrL2eVbic1KE98wKf8zcjxmXFVZet8Ne+npuoXbkBGiSP/buXPOckW/tezpLd2Pq
 +75u72eJgY7K1X1u5wN8fmulLmTKFO4DjbhQJdJLSVYmxGP+QAV98Ux+uwILHvE7wd+0Lq8cXPe
 gL8wxu3eUMetCOWRj5OKlI2NIHPlAjaEiQjCbm5ccWeZbvTmGitKZ1sWLEAUorGwLRJ2WVFUj8J
 H4AO3G3rKAmBVdqwX2pEk20vCxtLi8EXA+unIYAx8dhbPXyOkC+N0A0gHNxPwYTG6xCwD3xno=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 clxscore=1030
 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2511010107
X-JNJ: AAAAAAAB941vIeXaCQJ+iKY22O0BvZu4fa9IuQ4YTYz6vROiuWhLLDAiR/NK2EeO8GUSMHP/StDYYdDObwPaNiCBPUbIwZcomtI5OwovqmKiTckXlc7t5NVS/ntHhoIikEO/vHx5Fa4N1tq+w3nteJzE2z93T+buAA7ymNc9p+ZC8TLj1Q52kCHDvkvmO0GsvHKTZeQKcYLrX1DJybqW91VLD+5B0vrivX+Fjb6K3qKlirm6d+rz0O8Pqevg9oBWULnSljBMcWF/qAwtuGUL++8+aa//5mRbPkXLNCuy1O6r/sXH2kbADZ9LE7H0Qf/0WMzB1UTl8CNi/4roaLFzUL0eJq4kcmgMITmiLKwoyd+MOjMiKuCZmopwwMYI4DB6+f+7YSWVQWmvt6DiG6a/vcqu88ZNMaWKTHCZhp1IEB4QlHLDBgXjT/NSg3xufRhhKYcrA7xHhobXo3vnpv+jDvPw/EryPN20aF7jk9vSjAd2iJBanvV2b/fQBlcrpwI1guFWT8wjGA41Kf/XLARjrtGxeyJ8YYzVkXIt0myz1fr0IzauI/vLoG01LoAlzsC6Ft46HcyFQ1OX1xiIkMLeTu9RHIah4AKn4MkeKHkVWU8MI29FdXGCA9tok8SeDWwsL6BcGAQMrgPnaAfEfyy149JSGR5v8iaIzPSYwBz+wE+b/TdfdAt+BVkPYSmKkQIxvf1pszuDaf9uAuorjSJ8hIxU21ldIih5bkQiaWJgyzrZvjJuA0tm
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
and `aquantia_do_upload_firmware` to prepare for fwloader change.

Signed-off-by: Beiyan Yun <root@infi.wang>

---

Changes in v5:
- Minor refactor

Changes in v4:
- New

 drivers/net/phy/aquantia.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index 903fcd667f6..fc2476fb038 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -218,27 +218,26 @@ static u32 unpack_u24(const u8 *data)
 	return (data[2] << 16) + (data[1] << 8) + data[0];
 }
 
-static int aquantia_upload_firmware(struct phy_device *phydev)
+static int aquantia_do_upload_firmware(struct phy_device *phydev,
+					const u8 *addr, size_t fw_length)
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
@@ -268,14 +267,14 @@ static int aquantia_upload_firmware(struct phy_device *phydev)
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
@@ -289,8 +288,22 @@ static int aquantia_upload_firmware(struct phy_device *phydev)
 	phy_write(phydev, MDIO_MMD_VEND1, UP_CONTROL, UP_RUN_STALL_OVERRIDE);
 
 	printf("%s firmware loading done.\n", phydev->dev->name);
-done:
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
 	free(addr);
+
 	return ret;
 }
 #else
-- 
2.47.3

