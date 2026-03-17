Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED02FD877D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A739E84399;
	Tue, 17 Mar 2026 15:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V6ogz+xh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A6384394; Tue, 17 Mar 2026 15:24:27 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36E8E8437E
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso49152105e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757462; x=1774362262;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9Frt2WCjaAbchvRO6lnpP1qkx5cZrOMngcPe09VhIec=;
 b=V6ogz+xhWbCCOkQ44RE+7bUS7Ae4PVjLtOqBDWWbBuCyCg6cSvQgRrcHzl/EkR2aPZ
 D8BStn2QdGKGrsmqeVFBViPY2KsCtKWSCXKYqP9whzjAj7tVNaahT7jEvWbd8GOKhlWd
 ilPdB9ZiK9JHWksylq8hqEQUMI5JffZcLBYu87pdmgu2CMbUj7Rwb97vVyTk30zk+ykU
 VZCp3EMe8Pz4FKUIdbYbuMOGfAL+DpWqo6E+5EL1q9oYbexwHQSFviAg5J9sczWYNqMj
 YZvBaAT0KEcb2X5D8XtvD8hSC1bATd7BWcKcXSQ07Bc3ZPAHCqeXJCO2udOD0VyxYWYV
 khVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757462; x=1774362262;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9Frt2WCjaAbchvRO6lnpP1qkx5cZrOMngcPe09VhIec=;
 b=MngLqg1gjPHDV7Nr6RmS4rjvctXVTX7rMXVifdQhXJJuNQX/U+bVh8a6uoJnFogwsT
 zX9jxsMISVVddLCFud6fGdd6VLDN/q0YEYrk2yXvQ45sQH+WdiXQIaC/kUn7EWAiqjzI
 zIIO40CVsKRBFvh6tmpEjNxgWXJM5JLfDGL6mzRhm3OY7h4RkLUexYadvkevpYUUPmTy
 qHGDN/tO51W0wu+XARVu885zjMwEtMPcFMbmEN/pWdfJO4xih3cgh3OLNCNx8u6fO4IG
 Stp+U7DnBMRu5OvQe8LVnWSOZS1JuWmw04OSoaq7rYmCKrR4qczLUKr77LbedAnOI7Ge
 I+uA==
X-Gm-Message-State: AOJu0Yz4ztpSuCNekRisWHiulJCVTEbSMIfjUHE+myVmQs8lG5/HKmZr
 j16+vuswexu1JAM9uRDwXziPsFibPfWsdUeXXqGwyHAsUoZVXUhP1wAXf1E/zoFXltI=
X-Gm-Gg: ATEYQzydzmVpFhHvN86WN+xcYvst77Tbxu/roPW7O8F40fkdUxaqOH9dbScE+Rs/LX1
 C9o+E1vjp7lNmI1wI5eiBy9Oqia6d3tooqleH4tbMSByek6WbOjATL/tekmJm+L1ALrio9mdtw4
 tAgCe+X3XGIEh+wXRC4F+7NIH8w1ZMv2DdA3N+v3ajSHPIu8fNZmA7zN8rpzETh0Rbhgn8EIPgj
 hhW5NoDsill+q0jPhjAdeLmvYV6QJMttDojk3YNII3sHDx7hw8W5dhsZs+somCy86ZJkZvj9e4Q
 1zScybDhfah8giANFXeabJu5xkIumpZMU9Nk9mp6poNH6z4uL3jrure373ZZpQvcri249O/awrt
 uOUB3rD0oRztn2tDHycjDe0zv8/pgdAd4DF6sGY87334L1nrvS4hj+eaDD+vZ12D6Z4+Y/O8nUB
 3NHYf+CCfM20tX2zGFViAs1rt+iMEU7WZaZ5btWPIDaVvyusF0dzEosvD4Pw76wEgPhumxn37N3
 xwEHZCypUZ+fwjwaHVJNhqnkswPmEHjJMTmWaEyLFix35Pmb03910yB3tmDhEysRdnv7qyWBa8y
 YtuAUWk=
X-Received: by 2002:a05:600c:1d0e:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-485566ea474mr313421675e9.11.1773757462415; 
 Tue, 17 Mar 2026 07:24:22 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556400f76sm125425675e9.1.2026.03.17.07.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:24:21 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 17 Mar 2026 15:24:23 +0100
Subject: [PATCH 05/11] drivers: phy: phy-mtk-ufs: use clk_bulk functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-mt8195-add-ufs-support-v1-5-7d731ec438ae@baylibre.com>
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

simply the driver by using clk_bulk functions

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

