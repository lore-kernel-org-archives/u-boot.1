Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3596710775E7
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BBCF83FC0;
	Wed, 18 Mar 2026 17:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fpPSwtFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D2083A1B; Wed, 18 Mar 2026 17:50:59 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41F3A83CD3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43b4121c40aso5101f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852656; x=1774457456;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5W5+Ukiwv6NLP+iLcR1EZSNCnznrVzk1k0eVTyIMNH0=;
 b=fpPSwtFzvrkk0NIxJ7t/LYX37YAyvZGUtAjPNmdsfepNzY/Dzi+7YS+7u/4x2RERl2
 ZFE5c/tfD8g5ud0iElb6TW6RqRkDYGBEav9fsFv0i/y8zPxd/4AbvRnumDKmzWdCFLY1
 rtY0tPjQGMyXIcNAbhq1SSEavBV9/cHwV4RqPu/Ta2tBGAQ444MBYgaDPpmZjsedZo9w
 VpVBRaXiwcAMvVf1zK1vgt4FyfifHdLmFpg1RJafOFSEngBYzb20xEcX5hS49eiOFsMd
 dlTFHOz/QJjs+QnvHS2Tnj9h5ktsFKrUcGdDKFkxaVHKYLzXeZtQJn7d0vpatG9kEOSL
 sOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852656; x=1774457456;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5W5+Ukiwv6NLP+iLcR1EZSNCnznrVzk1k0eVTyIMNH0=;
 b=oYY/WKqCHkNwEfZ+CE29MMPtprPQGFtcynUo/VFiN+LxF51r6qgu9Mrfuh/vyssxgj
 jscSeHFN8M76f4DTYuXFyUCLL++ufFipxuFoj0MpfHwxgFK51NedpKcp7XkJwqOOmBC0
 QpYrhyR6vqJDzG3cUEts+N5WCmHup6LHz/RtEeSIR/6mH1axEIcC3HQ2s89siHyItJws
 X0SZmsBtZqy5tw2nPzLWs32n7kJapGp+Q+hKBdTX8rHsNYQztCrT8z+uunWZJv+kS981
 eqeqVr5hiwBVT09Ptkko3dpsv+2WIS+nBPrlTFIRXyYksyltq3R5kNLgaDXaiC/+mxbP
 ZMjw==
X-Gm-Message-State: AOJu0YxGO/arSUe3RmPUf0H85FxQQ/Mgs/+9WCZaq7Ltr7u8IKPrmcy5
 EJ/YPpsVpK2AOTlq13gFxfH6P+/O277JseMYaWKLBmdEGqd6/FUpWtB1sE9eTVxesUc=
X-Gm-Gg: ATEYQzzCYz6+QaqyB4fHNfwwrLW/XiwAC3t18qMzNxOU96IH4szMXXfTyY6ntlM/HnV
 8hPpczxA7vloUOM6IRvT0VjB1ylNZ/0wd4V9ud0rmuq7orjuwHcPfaRGypxWBhxfhYXj8DGqODf
 rdg6Pp4dqZliNVnXwV9IZro0RulLuFAEn0HH6iO76UWCtDPrB4LPlujkHa7qmdi8jorLFjpH5Mw
 UTxBrkVjAb6N55LVZnokAMmOLLeB4rzuhR3xGkse128chJlJRr4WbuiquSdy8JlzIV0JF0ZQgzs
 uv9UGUWPmPIiSLXUptmlYA5FnwMuIyrLzikSS6ZWusao4YTtgjHUmjWEveUaA1L9V2uYWifBw3O
 /JAuT4WKvSq6EjTuV27erdJrRTPSw/JKtV3hPjRhO9ZY+2CYE82M3YhgunvMFq80cO19WnBOoVy
 mBCCbYXFOUR8bkfxYRsiSrild131lrsJKP6PO5KtrypHu/q5qX/8R5ArjUNJuTyqvM/Vv1HnoHF
 n9z4IbW5il9dO3Ql7f1rbtCvCC/PUWv+N2GUk0WHMtn6I4VnJR5dXMoS3naXP0UD3t+B6+T2BWh
 gZi2N24=
X-Received: by 2002:a05:6000:2503:b0:43b:509b:c544 with SMTP id
 ffacd0b85a97d-43b527c4c63mr7503795f8f.26.1773852655624; 
 Wed, 18 Mar 2026 09:50:55 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892290sm8639527f8f.20.2026.03.18.09.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:50:55 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:50:56 +0100
Subject: [PATCH v2 4/9] drivers: phy: phy-mtk-ufs: disable clk in power_off
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-mt8195-add-ufs-support-v2-4-f18eeeeb0e72@baylibre.com>
References: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
In-Reply-To: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
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
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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

