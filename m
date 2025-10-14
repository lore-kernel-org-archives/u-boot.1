Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FE9CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 11:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1BEA82991;
	Tue, 14 Oct 2025 13:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="ccN7bGQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69DCF83327; Tue, 14 Oct 2025 13:56:34 +0200 (CEST)
Received: from outbound.mr.icloud.com
 (p-west2-cluster4-host7-snip4-10.eps.apple.com [57.103.69.221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EBB88206E
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 13:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPS id
 62F5418085B5; Tue, 14 Oct 2025 11:56:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=US7bAvTgLaVYsKQzKuobmUcoSSQcOmfRMDMjj0OpLyI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ccN7bGQkg0ZxD86yKRBGhwRax0ExUyZZ7md1gI84VHmN2NtwCLPtw5SsmlM4lLncj2Z3X5STVQprZPXujBmJLzQGGel3HVZ3V0UXq3wLhdebloxHxa8spp/2Zfxv7hBLKidvDfRBorcnR4bCkPM55G/tWGxI/AL9ywqCs8X11Xr/Jbm6/E5SsuD9t1uBsnH5HkUAk/9/XxJoiOrZQ8eTQWoAPA/thSv3fd1HNJxEJNRvuDqbkeIacv0w8910GnSIIogJH+RfKpPlwmlq+DsGs67iDcOA5OQpUMjB8JwAsIY364RtItuwo2rlw0FxvvVeQ+WsDcX70+bUwOFU4Hd2BA==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPSA id
 B8D5D1800096; Tue, 14 Oct 2025 11:56:25 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v2 3/4] net: phy: aquantia: replace the "mdi-reversal" node
 with "marvell, mdi-cfg-order"
Date: Tue, 14 Oct 2025 19:53:59 +0800
Message-ID: <20251014115604.194150-4-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014115604.194150-1-root@infi.wang>
References: <20251014115604.194150-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gXF2_eGnQaikh7NAmVhIagvNbW2yAvNN
X-Proofpoint-ORIG-GUID: gXF2_eGnQaikh7NAmVhIagvNbW2yAvNN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDA5MyBTYWx0ZWRfX+SmCaFgg03kY
 64dDHsV8qtPREfqDCmQdimbLpt4qkZWjNKKWFS0jZdXH3chUD0H7M5E4ZoUlz+ZynE38Bj94Wy/
 Et9VlVn8KhFFX2sTMB9+8zfNuVnu1Bq2K3uv667K2fUFg5UZCa+OA+6/Dy8GXGVIILQ4ukx9Cca
 Lv16LSJhwCNPa6Sh/PTN/UUOgaxQx4PH1XkP87Nv2eOfaam/NpAz199tZo4qW/a72AWODXgDxxl
 jB5mTh7Y53wCFjT3o9NMLpZIkNMEJZuYFpDME8w4+aRcWH4Y+Hqjgwws9pPoa5rxzKfryzAO4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0 mlxlogscore=708 clxscore=1030 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510140093
X-JNJ: AAAAAAAB0IldinxpJ8bAW87IqzMzJ/lzSStQzubRvyGbgvOVT2GBqN8/QfPmsIgzGRZpf8e+gfn5Mdu4wozQIMlY/j4OjLviKWQ2ntpT9i/0/tHMtuZ7pC1aPiMk4lmgseCXFnuq2+PBvSX8k9/gQDHivMFfJ2HppHManLIezrI2vY42IAYOkiNIQOgLO9USLb9GZWMciZgVLyecyutqse70y+0+d1/9z+nwUqs/tOyKVhFHAQkCsApnKlFWyFp8ahYt/HMFH8i/Tg+PK89qiWkVIjHUNHDeTUEWrc3ax0vWLLRSyL8u4N7E7UpTXtmZScCNGvwMql/Om1PIhsVhiQp4Ka/ToJLZ9FT6pjwcb1Bp+onPP71uvHxT1FHgrSXTP4l/FrzGhJGe2aQptAMpfTZEHwoxphu6uVVG25ofcsCbe8BXfuskNkWrt1b7Uf0eoc9I+lmBwzKnPWj2kWotahrFGJ0iu0xhd1s21yTvuywJkhHxWUHvx37mNDIo7ojwAJCm0ivY3lTjW2VjwaujAUw7izgdOv9WbbXHpQLgsJd/huATFQBosH2qeIjTF6MOfFIt74hBDMsz0yzNgksokvF07kKWXgLtr34hesYNg0+hdDLgoder27kXtwcFKuNubuHJo7C6QcCHGXRRh3HooA3tHQH1o9OPR5wZ6c8LGFKjGrpV+Uy4DBL1fTpo7z1zJNLcTUAm09PesFB6EhIM9GEL8/Zi6QvMtqYs3eKel+u6fv9our+hRBRptdpOHBf3gZaoHoXhCQ==
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
index 903fcd667f6..d9df0e23a45 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -350,8 +350,8 @@ static int aquantia_dts_config(struct phy_device *phydev)
 	if (!ofnode_valid(node))
 		return 0;
 
-	if (!ofnode_read_u32(node, "mdi-reversal", &prop)) {
-		debug("mdi-reversal = %d\n", (int)prop);
+	if (!ofnode_read_u32(node, "marvell,mdi-cfg-order", &prop)) {
+		debug("marvell,mdi-cfg-order = %d\n", (int)prop);
 		reg =  phy_read(phydev, MDIO_MMD_PMAPMD,
 				AQUANTIA_PMA_RX_VENDOR_P1);
 		reg &= ~AQUANTIA_PMA_RX_VENDOR_P1_MDI_MSK;
-- 
2.47.3

