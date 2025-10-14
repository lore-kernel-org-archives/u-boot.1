Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2970ECCD18D
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 12:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31481831D6;
	Tue, 14 Oct 2025 14:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="SACrhnkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D82830E4; Tue, 14 Oct 2025 14:13:39 +0200 (CEST)
Received: from outbound.mr.icloud.com
 (p-west2-cluster5-host3-snip4-4.eps.apple.com [57.103.71.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6F808313B
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 14:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 7D7A6180010D; Tue, 14 Oct 2025 12:13:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=30Hr+UqmAQ98EyIPv8WSpTF923qeSyYs4o+p8B4ZwHQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=SACrhnkGkca5WOkgH2+fNoxYLn7ZgpLcVofxbHyt02h+ONVam9uIY+JVk4ohGELJ0JeRI4bWKrCLMZk9K/wGHZOHBZQPF3l3mPY6cpmrs0cJ3yW006f8UZiHFlh4FVCnPAKoKvIp9tt9lzczEJ/qB0cWQ3plfEj2e4UTvAHkhTuhCaVpb4TZnd29jApKO0oI+nKMBqrzdnYYYgatuvyhAc6/Gclk8SJ5TVX7zjMdB9RSGRAa8uv1yCyO2AqArt+dTikYfx9/iUR4typSVMiCG/8RoY8UMz0oLWivt6QV4MKhJboYN2aUNcyEwZ2dXKY5oXiqEz0G7Nx+0Ba/xSLr8Q==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 76812180553E; Tue, 14 Oct 2025 12:13:33 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v3 3/4] net: phy: aquantia: replace the "mdi-reversal" node
 with "marvell, mdi-cfg-order"
Date: Tue, 14 Oct 2025 20:12:48 +0800
Message-ID: <20251014121318.453701-4-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014121318.453701-1-root@infi.wang>
References: <20251014121318.453701-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDA5NSBTYWx0ZWRfX3hrWUjKpp/lH
 /k1Y4a7nwsQpVpb9ij/i6wxpZiBBIJrTY6JwJZd1MG+uFLvNqTAzTN6fV28fIp3TDetMTe57/Um
 R03NxqdlQG6hUceEkcH+46QAY3CNiand+E5PkE2KtL4e9bgAUwiskcBs1eBiToGZPcgYc7P6pDc
 yEFn1l38eueFvshYkcL/F8xW3yBzpfTTnZM4uGB2epJN4OLaguo8V+JCh/LYgUPo9d8ZgovcBlH
 abCVtvaW4b4xRdSqk8I6Z9j69gqC8pOuQ4UCKyLbskY/AnqlFiRmRfmxygETxnf5LPy218sms=
X-Proofpoint-GUID: PMCiBkj5JT0ji0lVk5XNd-gFIgJO7u0T
X-Proofpoint-ORIG-GUID: PMCiBkj5JT0ji0lVk5XNd-gFIgJO7u0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0 clxscore=1030 phishscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=723 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510140095
X-JNJ: AAAAAAABkDHDUfrtRZf3cfl5R8kfe1VSfiSOxcSiq8N2d2mYY+9rbEhhUwmrB9cSt/GVPFy3i7/S6HVZ3AnQQuIzOFRXqDxY7emQA8XtwNfaUCq6/oVs2mZrqyb0OjViUcC8n6huVlw26s6drxf9+5hFSdHVqbq5bRJx+dTnm6K4U9I2I0f0U77IK/uDk6zIw5Rxt3f4X1UiiVGjcCkjyfrUsLMdMyI8jxzHgBdgPtH1mGDJ7UohKC6QuZTTXJ5AiEkmuRSnWgiXGM1dPfhsdjAJGB0RQ5sqELmBvFpw7TQVrU3VMA3AaAb4z02MaYEim2Pxo8kduTFdsisHbZMa6HmfftjCgfTrmDuVikiDjFMSXmLv+2XAcSm4ajy66oCg9BiPCf1K/+knkCe75ZLZLE4AtYmosLDEZrrdZ/RrNaKj/rU043ifEcuMjSbP0H5cPuqmmNl2JL50H4/kdif3oXjZn9DwnAU3mZ6JU/xEQmJMCVHQm3vq0DgQ/1oUMPpOJ5/GtkpTBZwQAJMWhEt6XauYXl/BCG6MZFac70/u4rXnCEMksSpKfGxyaNbVERSZbeUlNTcaBCAxur6ZZFB2VtZ0NI76wOzlKxJf3GgmGBZuL0YOXg5sVfzemHvV4IFHvNi5F/7uJuhoJTvMMYFqS9vk31Me5VHox2Av6wnzNGLy7E4XbrV/Dge8QaVqxDw0Q79ZZ2bV50J1JVUYDRpdGHBGYhh7+Ji8fOOY9QG2Y5xPRXjoB39Z+vsB+nIJLsvG6jv3OHvFIA==
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

