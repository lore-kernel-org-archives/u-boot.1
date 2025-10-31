Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC738CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1AD583980;
	Fri, 31 Oct 2025 16:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="cBClQdgH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC59C839C6; Fri, 31 Oct 2025 16:24:21 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster5-host11-snip4-8.eps.apple.com [57.103.66.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F8F283677
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPS id
 526CE1800211; Fri, 31 Oct 2025 15:24:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=WTVSYmsvRj7P4xhKoliZoyRDS7cGmvd5/I8KB1k+0+Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cBClQdgHgD9Ck47RkPPycpmyL3e9zGq9zuoR64rigilDArkAzkmmzpIcRmZbkdgIwN9bnPF6l73aHjOIVNakxho/KV/H9ZkGbtGjWfxtV19V+JcxuOFf7VnHZ/DZTtlyTCOsxE7ZNML5t0kdNJM+tlNZdT5LRL6rHr7Y76kUKk5jv7PjmwwBIw0QQNidgfOFxT9qaeeJyGNBqgVHBg29Tl8jl/m/tEYwoeSIyZgRw8908iqCjaX4h4OED+o2VAjQWmSM2SqwzZiMlKgT6tmGmdRK2O/43PgqVt0cWNH3t2gl8G/9G9/L+ian+j3UzQhv+Vl//6m8ZmZGTVjX68xLKw==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPSA id
 CA32A18003E2; Fri, 31 Oct 2025 15:24:13 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Yao Zi <ziyao@disroot.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v4 3/5] net: phy: aquantia: replace the "mdi-reversal" node
 with "marvell, mdi-cfg-order"
Date: Fri, 31 Oct 2025 23:21:05 +0800
Message-ID: <20251031152348.60571-4-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031152348.60571-1-root@infi.wang>
References: <20251031152348.60571-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vI2ePhX9Zpm8_Z3dTtLbhnTpkUeUSX23
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzOCBTYWx0ZWRfX9tt1SAWdX8Yf
 4a6O7T5/ZlmmL2lBSdCpcXJgPOTxHa1wCMovHGj8nBLmHYB7mirTEhG3ZREyyp6tZe3CJblkN2z
 H6hUg1hHxltCCxu6zA4DW8D45rpp1EeEUZi002sBBt+mJ3kC6pUdi2n0mkiGAzs/CDgrX8JwZPC
 u3s62cbCVveDbjqX+F3qdnDvZiC3og3V3LdVdihiFD63PO/6z12c8S0Ls1+C5JPx43SzK9+ok+f
 saVMwt2Fk0/2+NPVByOVyTEZIVZzJSLDFnItQ0kl/6icOn2SzRN/v4bgiKJLeRi06qIzu/37s=
X-Proofpoint-GUID: vI2ePhX9Zpm8_Z3dTtLbhnTpkUeUSX23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=725 clxscore=1030 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510310138
X-JNJ: AAAAAAABqcEIUcwXst8dNEPoiYkSfmHO3amG/Qts+6rDZ8SII0Sm/Y7M2MqAyzsiUC6B4odXKW7DkWPk+9+Iqvmrrv8iXwvaCCwFYo9rj9DiPgLRbX3cUb4q8Cf3rrBv+r8epmOHRSE/ci5nQiBNsBjU7DpQopOaBmAOYIwFAxOvkQBSZ11QazdmNkkRuiwE0S3lRCtdKTqEG8PD+V7OeNCSCR2SVlWPvlKgoeFjvRD3nbl9EIVuHbL4O5GZUI3ruzFV+uFasZK3nHKRCYBbssQ8y1WVZDTEEDUxs7mPou33jgkeUDjgwKGMJJfn+70lZpFg08FJgVuEH2XDSpWf8UuMuu0Eln1FRy2nWOf/4EZP/HWSN4OuzikutLUcXE0c7Kirl7JsNRZ/3+WJMkw0O99QL8zPO1b1oOdDopGA8gnda/zR7vm8wjRb+yeBvwzeDXQ6lqEHnWlhkKJqbWjJqRtE5NSh/Et3qyb6WaC/ZjTLdVjPBwfBUYw2koq61YR5gSvwi+8RRDxzs4omLYKyo4rw5ZQCpekUSONChBAHCmiyXhcHzMP8KiFLZvWyzmfBbyY70fiubGV9pzZQsd4RKB8Bh7rlTwuTkMB67eV1+qLZsOaYKhJ8FMzt0c18KT3oto91Zr3F/MOEp9mYcut8mnruWBAesQAo26teXI3RuHO3wgNLHOuDbqIWJ4svb4dBgh8/MX+JkL5G43i4eBygn1JiDHi42lSbV80+nqrBa3xAcQhZfOytH6TKHI8MohwBGdAkPZZq4xlyw3zd47J0P0a7MR39rbPQkYqR6tmj7tCH5Q==
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

As part of the effort of making U-Boot work with the same device tree as
Linux, align with upstream node name.

Signed-off-by: Beiyan Yun <root@infi.wang>

---

(no changes since v2)

Changes in v2:
- New

 arch/arm/dts/fsl-sch-30841.dtsi | 8 ++++----
 arch/arm/dts/fsl-sch-30842.dtsi | 2 +-
 drivers/net/phy/aquantia.c      | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/fsl-sch-30841.dtsi b/arch/arm/dts/fsl-sch-30841.dtsi
index 28b1bec18a5..a92d9811fd3 100644
--- a/arch/arm/dts/fsl-sch-30841.dtsi
+++ b/arch/arm/dts/fsl-sch-30841.dtsi
@@ -15,24 +15,24 @@
  */
 phy@00 {
 	reg = <0x00>;
-	mdi-reversal = <1>;
+	marvell,mdi-cfg-order = <1>;
 	smb-addr = <0x25>;
 };
 
 phy@01 {
 	reg = <0x01>;
-	mdi-reversal = <1>;
+	marvell,mdi-cfg-order = <1>;
 	smb-addr = <0x26>;
 };
 
 phy@02 {
 	reg = <0x02>;
-	mdi-reversal = <1>;
+	marvell,mdi-cfg-order = <1>;
 	smb-addr = <0x27>;
 };
 
 phy@03 {
 	reg = <0x03>;
-	mdi-reversal = <1>;
+	marvell,mdi-cfg-order = <1>;
 	smb-addr = <0x28>;
 };
diff --git a/arch/arm/dts/fsl-sch-30842.dtsi b/arch/arm/dts/fsl-sch-30842.dtsi
index bff9e76570b..fca38d14975 100644
--- a/arch/arm/dts/fsl-sch-30842.dtsi
+++ b/arch/arm/dts/fsl-sch-30842.dtsi
@@ -13,6 +13,6 @@
  */
 phy@02 {
 	reg = <0x02>;
-	mdi-reversal = <1>;
+	marvell,mdi-cfg-order = <1>;
 	smb-addr = <0x25>;
 };
diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index 439c4c48bdc..11e450cdb0b 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -351,8 +351,8 @@ static int aquantia_dts_config(struct phy_device *phydev)
 	if (!ofnode_valid(node))
 		return 0;
 
-	if (!ofnode_read_u32(node, "mdi-reversal", &prop)) {
-		debug("mdi-reversal = %d\n", (int)prop);
+	if (!ofnode_read_u32(node, "marvell,mdi-cfg-order", &prop)) {
+		debug("marvell,mdi-cfg-order = %d\n", (int)prop);
 		reg = phy_read(phydev, MDIO_MMD_PMAPMD,
 			       AQUANTIA_PMA_RX_VENDOR_P1);
 		reg &= ~AQUANTIA_PMA_RX_VENDOR_P1_MDI_MSK;
-- 
2.47.3

