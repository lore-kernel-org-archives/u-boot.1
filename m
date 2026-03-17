Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1712FD877E
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A938439F;
	Tue, 17 Mar 2026 15:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QrmEZWon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 260888439E; Tue, 17 Mar 2026 15:24:28 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AACF084332
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:24:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852fdb36a8so67940545e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757464; x=1774362264;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PuNXYZVzw0DujiCucHh+c05lMjqeIxZujLeTFBthwzQ=;
 b=QrmEZWonnawBdtLhQ5IdjYLjJ6C+mKlZ7erMWd6vbkmAftjyz/eKz8PwUp6Q3rkXsz
 V0unGQ1GrVu223xgZ5eiVglF/ibtWA635swwCQKKqANW/FJj2lCClFj2EsQEambAZhTW
 a8ywqxZ4cLm2oHr8qj/pvcop+CnFQK0imMcFJd+lR6fzPiKrlSpyOctRa6w3VaxD/opl
 Sudl/4nRKP9hexu0to5HqKa1DC7sYgeUe3l3yitnoad9pZVJZd90y7mazvR7KPqhf47C
 SSk1vcBdevjAK66PdDCNV6DYTWQwt+7+oh1u2JLTnTGg3gwmM5iP20FhXC1jWERHDaLl
 25MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757464; x=1774362264;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PuNXYZVzw0DujiCucHh+c05lMjqeIxZujLeTFBthwzQ=;
 b=bUjClcp43JzJzdtf9fHXclv4wUVsEhsihPzxPY3oTBjq6c0+3pRGbJRAcN3GEq7JKl
 WM87KLzfCligjZFGNOu3iyEsiHPG2EQDoNFOKT7EytISGxoYSR4BTnvYZKyeh8QeLdJN
 nSmhPvxsFZuHDN06FrVQAFjwMUN1B4JgV0gnz/NseUKvTRrfL2h/Dba1DajXA6sv982H
 0FAr0IxRVXDYWOrWlWy5KoQQcngPEEd9tvqx0LGv5nKm6MVDobuJBOWb3/Rq9WxnHvGH
 nPc8Ge6PkE0AloP+gWoHna2qo2yYsId8HkeVl6/R3LAX6rqi8HIUoYgMYfezXMm5s0Ue
 C0Hw==
X-Gm-Message-State: AOJu0YwmBeu7woTQJi7d7d/MiT3GS5xhmaqPLzXsuKxu3WH4keeadwSs
 DG5TuN3MKYL+iE9hBbHl+xm7dcjrPG2/ctgNZOgPFlkA2iHD5zHXxhH15aUXjK4WwrM=
X-Gm-Gg: ATEYQzwc/EJ45WpsEESJMBe3CQr74s+a/OaMq1W3x1ulD+DPT5Udu1u2Ou9qIt6lH2q
 pVpk9so9GSbzjToHuj/bM+7YHYz0gqAH+dlhsPtgSojWEYOMTLWRbyP84Y4I4JMCKRUyQTpf6jt
 5oO0HlSJBHBTbfVULM+tJOu/ALYveOP0ul6echVPvn7jTj82J2csR4W3xlPkuHG4Fm0aT0KOkZJ
 LlZj6PGgoMp2nFH6Em7LfMAGqYUCv5gn2viH6pIZtSlaNHSIX4FSW1W0x5CaYzS0g/MWhQs3dR7
 iWRxIZnhEWtzfmTxhBOM/SF5BNRvkIySS6c+gB9rwoRLRyweB5zgP4XQ7UOT4GOs5sud21hTiVP
 hLxR8jJWS/GFhVU5gfUKMUmMCI76aSQIrN1GutAKlCjMS1gvhLd4gRNDnOpjltfNKApMN5o0Ul6
 FgXy2DVzjeYVbjXP6baexc+Sf/4GgUfFVjzbfDaGPEDthVQWKIgrLjF/adkLQGaumGU29T0+VYu
 gcjWVDsCzpNWdF1G5uj4A+GVu3Y/AjCNoGlKvOCXoBaeBfAfiTvRlxMcLrbz44D1t5T99ZJDXbZ
 ub9G7C8=
X-Received: by 2002:a05:600c:4f54:b0:485:353f:c651 with SMTP id
 5b1f17b1804b1-48556702b4dmr291086725e9.22.1773757463944; 
 Tue, 17 Mar 2026 07:24:23 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556400f76sm125425675e9.1.2026.03.17.07.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:24:23 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 17 Mar 2026 15:24:24 +0100
Subject: [PATCH 06/11] drivers: phy: phy-mtk-ufs: disable clk in power_off
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-mt8195-add-ufs-support-v1-6-7d731ec438ae@baylibre.com>
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Disable clocks in power_off(). Also define ufs_mtk_phy_set_inactive()
helper function to keep consistency with power_on() and
ufs_mtk_phy_set_active().

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/phy/phy-mtk-ufs.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
index c7a671ebfad..0522e1ab683 100644
--- a/drivers/phy/phy-mtk-ufs.c
+++ b/drivers/phy/phy-mtk-ufs.c
@@ -88,34 +88,44 @@ static int mtk_phy_power_on(struct phy *phy)
 	return 0;
 }
 
-static int mtk_phy_power_off(struct phy *phy)
+static void ufs_mtk_phy_set_inactive(struct mtk_ufs_phy *phy)
 {
-	struct mtk_ufs_phy *ufs_phy = dev_get_priv(phy->dev);
-
 	/* Set PHY to Deep Hibernate mode */
-	setbits_le32(ufs_phy->mmio + MP_LN_DIG_RX_9C, FSM_DIFZ_FRC);
+	setbits_le32(phy->mmio + MP_LN_DIG_RX_9C, FSM_DIFZ_FRC);
 
 	/* force DA_MP_RX0_SQ_EN */
-	setbits_le32(ufs_phy->mmio + MP_LN_DIG_RX_AC, FRC_RX_SQ_EN);
-	clrbits_le32(ufs_phy->mmio + MP_LN_DIG_RX_AC, RX_SQ_EN);
+	setbits_le32(phy->mmio + MP_LN_DIG_RX_AC, FRC_RX_SQ_EN);
+	clrbits_le32(phy->mmio + MP_LN_DIG_RX_AC, RX_SQ_EN);
 
 	/* force DA_MP_CDR_ISO_EN */
-	setbits_le32(ufs_phy->mmio + MP_LN_RX_44, FRC_CDR_ISO_EN);
-	setbits_le32(ufs_phy->mmio + MP_LN_RX_44, CDR_ISO_EN);
+	setbits_le32(phy->mmio + MP_LN_RX_44, FRC_CDR_ISO_EN);
+	setbits_le32(phy->mmio + MP_LN_RX_44, CDR_ISO_EN);
 
 	/* force DA_MP_CDR_PWR_ON */
-	setbits_le32(ufs_phy->mmio + MP_LN_RX_44, FRC_CDR_PWR_ON);
-	clrbits_le32(ufs_phy->mmio + MP_LN_RX_44, CDR_PWR_ON);
+	setbits_le32(phy->mmio + MP_LN_RX_44, FRC_CDR_PWR_ON);
+	clrbits_le32(phy->mmio + MP_LN_RX_44, CDR_PWR_ON);
 
 	/* force DA_MP_PLL_ISO_EN */
-	setbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, FRC_PLL_ISO_EN);
-	setbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, PLL_ISO_EN);
+	setbits_le32(phy->mmio + MP_GLB_DIG_8C, FRC_PLL_ISO_EN);
+	setbits_le32(phy->mmio + MP_GLB_DIG_8C, PLL_ISO_EN);
 
 	/* force DA_MP_PLL_PWR_ON */
-	setbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, FRC_FRC_PWR_ON);
-	clrbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, PLL_PWR_ON);
+	setbits_le32(phy->mmio + MP_GLB_DIG_8C, FRC_FRC_PWR_ON);
+	clrbits_le32(phy->mmio + MP_GLB_DIG_8C, PLL_PWR_ON);
+}
 
-	return 0;
+static int mtk_phy_power_off(struct phy *phy)
+{
+	struct mtk_ufs_phy *ufs_phy = dev_get_priv(phy->dev);
+	int ret;
+
+	ufs_mtk_phy_set_inactive(ufs_phy);
+
+	ret = clk_disable_bulk(&ufs_phy->clk_bulk);
+	if (ret)
+		dev_err(phy->dev, "failed to disable clocks (ret=%d)\n", ret);
+
+	return ret;
 }
 
 static const struct phy_ops mtk_ufs_phy_ops = {

-- 
2.52.0

