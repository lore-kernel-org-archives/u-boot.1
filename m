Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D138D2F327
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 15:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F8B83015;
	Tue, 13 Jan 2026 16:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BoSk4yiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1446D800AE; Tue, 13 Jan 2026 16:16:25 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E285780050
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 16:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A2ACF60017;
 Tue, 13 Jan 2026 15:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 592BAC19421;
 Tue, 13 Jan 2026 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768317381;
 bh=tYZ5hj1B9DhuygI/o/PSZw/9AcGv0jZ0XhuOsUi0Voo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=BoSk4yiCbYyTskK6GMLZYQFp6h6iyRYiSj42TCtLSzn9kSbixMj8IQpjKykRv+ZPT
 6LlEOBY7oGeESWomXsaXUymfZQD6GT2uwoOK/6MkSZYTbcHG1TdR6hGcG5bitB8Fc8
 CLBxRn9FcPSdzRWpXcAxvUngKf3oKnmfETlkLYfpt2NckraOnbqUT4QDmTzFwUBcT3
 TaQK4BW7zbC/mFDm6eDxMgPp0BTZQcPRoqGH1RQ1/IkfDF1CcPh3JrmITuWlNYjuBq
 o15RYuwONi0uVJVtGn0h2R2JMx0Gwf/vRYH7KFKHd+Qe91wFWX+x0cf5+2s/Yt3/kZ
 TfFoyEjUraxsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 49774D2F32A;
 Tue, 13 Jan 2026 15:16:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 13 Jan 2026 23:16:15 +0800
Subject: [PATCH RFC 1/2] net: dwmac_meson8b: replace setbits() with
 clrsetbits()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-aml_eth-v1-1-3dd74db37c4f@outlook.com>
References: <20260113-aml_eth-v1-0-3dd74db37c4f@outlook.com>
In-Reply-To: <20260113-aml_eth-v1-0-3dd74db37c4f@outlook.com>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jerome Forissier <jerome@forissier.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768317381; l=4115;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=gHhFLguZETRuvn1ptF4TGpP8+u1e6lfmwRCpP93Z7sU=;
 b=980RnZ7CyrCH2deXDg8iIIzoAuuA/6hPhbZE/nxprH8ZzUpfbMT3gs1Mgh8HGZyaUkDb/OfHo
 T+a+jwISnqcDTONbTjd/FOw49/E9W3c9Cd3fyOMwMLB60HKuSSmwlnn
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

setbits() only sets the specified bits and leave other bits untouched.
This is incorrect for ETH_REG_0_TX_PHASE and ETH_REG_0_TX_RATIO fields
assignment. They contain multiple bits and should be cleared before
setting new bits. Otherwize the old value is OR'ed with the new value.
(e.g. 0x2 | 0x4 becomes 0x6)

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/dwmac_meson8b.c | 48 ++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
index fde4aabbacec..b1a3946ce684 100644
--- a/drivers/net/dwmac_meson8b.c
+++ b/drivers/net/dwmac_meson8b.c
@@ -16,7 +16,9 @@
 #define ETH_REG_3		0x1c
 
 #define GX_ETH_REG_0_PHY_INTF		BIT(0)
+#define GX_ETH_REG_0_TX_PHASE_MASK	GENMASK(6, 5)
 #define GX_ETH_REG_0_TX_PHASE(x)	(((x) & 3) << 5)
+#define GX_ETH_REG_0_TX_RATIO_MASK	GENMASK(9, 7)
 #define GX_ETH_REG_0_TX_RATIO(x)	(((x) & 7) << 7)
 #define GX_ETH_REG_0_PHY_CLK_EN	BIT(10)
 #define GX_ETH_REG_0_INVERT_RMII_CLK	BIT(11)
@@ -24,7 +26,9 @@
 
 #define AXG_ETH_REG_0_PHY_INTF_RGMII	BIT(0)
 #define AXG_ETH_REG_0_PHY_INTF_RMII	BIT(2)
+#define AXG_ETH_REG_0_TX_PHASE_MASK	GENMASK(6, 5)
 #define AXG_ETH_REG_0_TX_PHASE(x)	(((x) & 3) << 5)
+#define AXG_ETH_REG_0_TX_RATIO_MASK	GENMASK(9, 7)
 #define AXG_ETH_REG_0_TX_RATIO(x)	(((x) & 7) << 7)
 #define AXG_ETH_REG_0_PHY_CLK_EN	BIT(10)
 #define AXG_ETH_REG_0_INVERT_RMII_CLK	BIT(11)
@@ -59,20 +63,24 @@ static int dwmac_setup_axg(struct udevice *dev, struct eth_pdata *edata)
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 		/* Set RGMII mode */
-		setbits_le32(plat->regs + ETH_REG_0, AXG_ETH_REG_0_PHY_INTF_RGMII |
-						     AXG_ETH_REG_0_TX_PHASE(1) |
-						     AXG_ETH_REG_0_TX_RATIO(4) |
-						     AXG_ETH_REG_0_PHY_CLK_EN |
-						     AXG_ETH_REG_0_CLK_EN);
+		clrsetbits_le32(plat->regs + ETH_REG_0,
+				AXG_ETH_REG_0_TX_PHASE_MASK | AXG_ETH_REG_0_TX_RATIO_MASK,
+				AXG_ETH_REG_0_PHY_INTF_RGMII |
+				AXG_ETH_REG_0_TX_PHASE(1) |
+				AXG_ETH_REG_0_TX_RATIO(4) |
+				AXG_ETH_REG_0_PHY_CLK_EN |
+				AXG_ETH_REG_0_CLK_EN);
 		break;
 
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* TOFIX: handle amlogic,tx-delay-ns & rx-internal-delay-ps from DT */
-		setbits_le32(plat->regs + ETH_REG_0, AXG_ETH_REG_0_PHY_INTF_RGMII |
-						     AXG_ETH_REG_0_TX_RATIO(4) |
-						     AXG_ETH_REG_0_PHY_CLK_EN |
-						     AXG_ETH_REG_0_CLK_EN);
+		clrsetbits_le32(plat->regs + ETH_REG_0,
+				AXG_ETH_REG_0_TX_PHASE_MASK | AXG_ETH_REG_0_TX_RATIO_MASK,
+				AXG_ETH_REG_0_PHY_INTF_RGMII |
+				AXG_ETH_REG_0_TX_RATIO(4) |
+				AXG_ETH_REG_0_PHY_CLK_EN |
+				AXG_ETH_REG_0_CLK_EN);
 		break;
 
 	case PHY_INTERFACE_MODE_RMII:
@@ -97,21 +105,25 @@ static int dwmac_setup_gx(struct udevice *dev, struct eth_pdata *edata)
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 		/* Set RGMII mode */
-		setbits_le32(plat->regs + ETH_REG_0, GX_ETH_REG_0_PHY_INTF |
-						     GX_ETH_REG_0_TX_PHASE(1) |
-						     GX_ETH_REG_0_TX_RATIO(4) |
-						     GX_ETH_REG_0_PHY_CLK_EN |
-						     GX_ETH_REG_0_CLK_EN);
+		clrsetbits_le32(plat->regs + ETH_REG_0,
+				GX_ETH_REG_0_TX_PHASE_MASK | GX_ETH_REG_0_TX_RATIO_MASK,
+				GX_ETH_REG_0_PHY_INTF |
+				GX_ETH_REG_0_TX_PHASE(1) |
+				GX_ETH_REG_0_TX_RATIO(4) |
+				GX_ETH_REG_0_PHY_CLK_EN |
+				GX_ETH_REG_0_CLK_EN);
 
 		break;
 
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* TOFIX: handle amlogic,tx-delay-ns & rx-internal-delay-ps from DT */
-		setbits_le32(plat->regs + ETH_REG_0, GX_ETH_REG_0_PHY_INTF |
-						     GX_ETH_REG_0_TX_RATIO(4) |
-						     GX_ETH_REG_0_PHY_CLK_EN |
-						     GX_ETH_REG_0_CLK_EN);
+		clrsetbits_le32(plat->regs + ETH_REG_0,
+				GX_ETH_REG_0_TX_PHASE_MASK | GX_ETH_REG_0_TX_RATIO_MASK,
+				GX_ETH_REG_0_PHY_INTF |
+				GX_ETH_REG_0_TX_RATIO(4) |
+				GX_ETH_REG_0_PHY_CLK_EN |
+				GX_ETH_REG_0_CLK_EN);
 
 		break;
 

-- 
2.43.0


