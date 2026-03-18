Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4AF10775E6
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B10E83FA6;
	Wed, 18 Mar 2026 17:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tt81pwaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25D2683A1B; Wed, 18 Mar 2026 17:50:57 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D70583952
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so622705e9.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852655; x=1774457455;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GfrQ0JGtqKwW7F1pZf1VwT9/+nAV6JCLGlSEwc7jDYM=;
 b=tt81pwaXAtUOr63rjFGou6AZk3L+yQRVANbNAAqqgv01f16lO9w/WFO8o3CwsBog4J
 rP4cHD+yFhIyyYtMNuEbPBMn1RFUOdlI5DFE3zchfjnG78gl6dD1qBFp3QNG5CWM0t5B
 xzF1ikuvD2+3nxTFT+40+Gyabcuw2eozJDfdCQxN4LEGq06tmxcGYY9S1z5pmzTY0pe6
 /ZUBT6UEO4eokGbzlJEEfjIExQohs7CVirlVuIifbW7YLPDsvd/z+wuNAdS/giXhVqP3
 EoP39fxYtKDxmUjuUJZeUEDZ/kxTw1OeeR03GBnI00J+CKP49NDb2FvNjGiR63zRS/de
 ZORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852655; x=1774457455;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GfrQ0JGtqKwW7F1pZf1VwT9/+nAV6JCLGlSEwc7jDYM=;
 b=l+UCP5Eg3SK7Qd/YXRlTOriFzsm1GhOkfrqxHrclwwTp5pudKGD4IB460HvjL1dajY
 P6bhZwsw4CEfdHorP+srHyYfz+fnU7wfiI3qHlFAbIJUAfSEP4WiqgNaPSDnTWgu6cyI
 bmtvm8dMPbtb0OSDnTV7/iqr06em8LQa9eJMR+2ITkCmXNkFH+BAG3uZFEAoNzXI/4YS
 HMlzknBRPcsKYfxrBcsW+EMxj9VhlrVNiM22DZ6mqpP04utzOCwxWpHXw0i5DH9i2F9/
 8H+nkAkzKflKcUM69+7UEZk2aGMCxpKoBCKVDiSgzgg2iQdE+x8sny2LzvNFLAr3cLkE
 022g==
X-Gm-Message-State: AOJu0YxBpqmptSBnYS8mbwDs5brBXMIdrqvgOfwJ5e2bFeUPgRYuhRNQ
 skpigQ2mEsdLZnES2DKxHHfxNpHb/f10c0hRTgsCaxubs/6tL6ywgMCKRBU+zkyLR7c=
X-Gm-Gg: ATEYQzxyQwrcDW9m2oAFHBeq706U262gFJhpb6gH2i+fjGaKhlLSs1Twy2BH7FTh0a9
 9oCmMCv7CnZffcSMz8zKrShMDN9yQgE6k9tFWECRk+E64FlzjQvQtPoZ1pvM5ur/NnAvWFJGWf0
 Z37fplLB90/a9phcME/JLM9OREZFu0slwhVrXEKX8UblOm4gl3cbGeKSEc85dvTy+Pcl+JjJJJL
 SqlWFa1mFM2V57rnAeKydil1ozqICt0/6Yc1BXLWnRCJmipXNWW5X1WpSuyOsEVj47JQkUd8CC7
 D6+CdP0Vr/k+M5hyeOtPSHNRAfwJMLa0Ar8kt/bOrJRID4Tw5+xDgzMk7B1v+Vy+ZeCZI78Y9dJ
 +z93npi0gOiT7ZYWxy+CE9m/WOEbNrt+fKm5srpIKySNImDS/oe6g4bBwWkfjKr1KhaStw/1JIs
 keM8w8rHlYdTPk0mtssYWWu6oJZsHOSUjrXgBJH6403Boxh8J4pDUdzo+amIKINA11MIgxRJPmR
 vLmfH9EdQcezZ+W5NU18zc1kJ6hqwZ0XefkPE8MMpkfffErWqUTZ5PpqQjs49Msyeu1PKRRi6+l
 h6vXhlM=
X-Received: by 2002:a05:600c:4e4a:b0:485:ae14:8192 with SMTP id
 5b1f17b1804b1-486f442d3d1mr68691895e9.7.1773852654535; 
 Wed, 18 Mar 2026 09:50:54 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892290sm8639527f8f.20.2026.03.18.09.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:50:54 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:50:55 +0100
Subject: [PATCH v2 3/9] drivers: phy: phy-mtk-ufs: use clk_bulk functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-mt8195-add-ufs-support-v2-3-f18eeeeb0e72@baylibre.com>
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

simply the driver by using clk_bulk functions

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/phy/phy-mtk-ufs.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
index 321151172d9..c7a671ebfad 100644
--- a/drivers/phy/phy-mtk-ufs.c
+++ b/drivers/phy/phy-mtk-ufs.c
@@ -40,8 +40,7 @@ struct mtk_ufs_phy {
 	struct udevice *dev;
 	void __iomem *mmio;
 
-	struct clk *unipro_clk;
-	struct clk *mp_clk;
+	struct clk_bulk clk_bulk;
 };
 
 static void ufs_mtk_phy_set_active(struct mtk_ufs_phy *phy)
@@ -78,16 +77,9 @@ static int mtk_phy_power_on(struct phy *phy)
 	struct mtk_ufs_phy *ufs_phy = dev_get_priv(phy->dev);
 	int ret;
 
-	ret = clk_enable(ufs_phy->mp_clk);
-	if (ret < 0) {
-		dev_err(phy->dev, "failed to enable mp_clk\n");
-		return ret;
-	}
-
-	ret = clk_enable(ufs_phy->unipro_clk);
-	if (ret < 0) {
-		dev_err(phy->dev, "failed to enable unipro_clk %d\n", ret);
-		clk_disable(ufs_phy->unipro_clk);
+	ret = clk_enable_bulk(&ufs_phy->clk_bulk);
+	if (ret) {
+		dev_err(phy->dev, "failed to enable clocks (ret=%d)\n", ret);
 		return ret;
 	}
 
@@ -148,21 +140,11 @@ static int mtk_ufs_phy_probe(struct udevice *dev)
 	phy->dev = dev;
 	phy->mmio = map_sysmem(addr, 0);
 
-	phy->mp_clk = devm_clk_get(dev, "mp");
-	if (IS_ERR(phy->mp_clk)) {
-		ret = PTR_ERR(phy->mp_clk);
-		dev_err(dev, "Failed to get mp clock (ret=%d)\n", ret);
-		return ret;
-	}
+	ret = clk_get_bulk(dev, &phy->clk_bulk);
+	if (ret)
+		dev_err(dev, "Failed to get clocks (ret=%d)\n", ret);
 
-	phy->unipro_clk = devm_clk_get(dev, "unipro");
-	if (IS_ERR(phy->unipro_clk)) {
-		ret = PTR_ERR(phy->unipro_clk);
-		dev_err(dev, "Failed to get unipro clock (ret=%d)\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return ret;
 }
 
 static const struct udevice_id mtk_ufs_phy_id_table[] = {

-- 
2.52.0

