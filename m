Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A99510775E1
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EED7883FD9;
	Wed, 18 Mar 2026 17:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h+q5q/H8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5662B83F6D; Wed, 18 Mar 2026 17:51:02 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A6B83642
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso1844f8f.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852657; x=1774457457;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JIqFY1fhaVuSijyuMNNVc47cytsEXhqPRquAyVd7VLM=;
 b=h+q5q/H8BLjeDUDpCqbieRVB/Ibh9oeuAWMeoPDQ0UM/5gpBO6zVip/c/wS/KGPosD
 Sdbq2d2v3hso1Ard47itgzD8Ln6+cyofQ3JNYRc0zRzn2hg7MbkP6vv53BBYFjr6GH99
 7duOyYdLuAeYqx+xxsVezcZX+8WgGbDZ7xIFhkWAiTDg4vJ31xpAP0ORyQNbXnAJ81PV
 /eM2rotHNTEVw25tOZLJ4J6iO+ZMolcZGW3adr1Gwr4+lljWLhm8Se+EaboLLswzUUME
 1WahHhHZzGWDENPT0lpRC1oFrdcM+pwkcqZyVZqGtZFv1lldgkkoiBZZtzuFGGu9v1at
 xEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852657; x=1774457457;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JIqFY1fhaVuSijyuMNNVc47cytsEXhqPRquAyVd7VLM=;
 b=WPf2j5H7V47Q/XBM9AMdQ5BntxqQ/xygKgZEj+hrsWO4QGw9/zZymUPe+G3f/6KtI1
 ZWCxi8wJshcC0j45mx1dM909OZSUT4BVn4xA/EHcUVbA2pZzNyvlKYV1xhL7FLnYNqZp
 oevGMvcoNju2pnSJQUKqlXdFDNFJLd7WcSn3SFB6oycIkqxy3/sr5F3/D2NZV3bgvbD0
 BXZIm+h0bjzIcOxcNqbOLBTHYZTm6bK5I2Ju/nqIo0ZUl1az7SKTmQCPwc/lu0JIlCLg
 u9hRCfg91T5eRtJT/BlziA+FMCrbIK7TBgSWeCEfZkc4veTV71pbKkV6eVl5Ez9lUcDZ
 zbUg==
X-Gm-Message-State: AOJu0YwzYp6b96aKxssKDO+OA2tgqzxRoAYvpM8SpMyYqyVmawD7iW+W
 FD8tArleBzJjlcQFq/sLhSguwmyDSmkHdN1mMt/ndutVOsA1NGLkLlHXgg+jlbkuwaM=
X-Gm-Gg: ATEYQzxagrYJKk1uGqgPV7TMX+gD9nzyytXVjxOh4Yqka6RuNv3yNcIyq5uvh0a9448
 IQXlP8bk9pgrO5Z5McK/tD/Lgh2nwDwKYQ1g6TeohmSfUbF6GN29IGHAtaYuSN4+hFcfGY0XMYz
 /y+J+kG8XVi5eItwa22lMmee7CZjN/HvvJWnIjo8GqZvGA6NUxZ3Xvk453HO6+VSMf1Z176mqlR
 Qaqx6eTXdctKcLMx77V5rE4atSzLkaEnAk1kdDbcvSUt+U/cD5aj4KZm6X5yohfgvzKqk9JURCR
 OfsYCRn4RD+kEUGuL72UkB/O04yKVnK+GUKeInJP/TGFRWAKW9pgRFHJ41yq2OSigjs12asdJaE
 NkoKaJwghBKY0uH91VgmM46YHOKZOQ/AOe+KrhHeXMetGsR0q0en1ZKsyTRSF+oHnQTvIuL6yzW
 y9BqqlQF2NxSyXk/yG9+LJc0/mpAa4NoWJeDz6pM5N9YhtYq0DmAyrXUbzwQsuTTph20H1SRQHB
 9CAPQ5BCHPJeuDTkNGO0RlYz9Pc1CuJ9FEA/6yx3fgKxfZwL7M9zdW9JDf3S78lQf/KTa32NCq5
 FG3i91k=
X-Received: by 2002:a05:6000:2c10:b0:43b:4981:1ba3 with SMTP id
 ffacd0b85a97d-43b527a494cmr7555502f8f.2.1773852656724; 
 Wed, 18 Mar 2026 09:50:56 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892290sm8639527f8f.20.2026.03.18.09.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:50:56 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:50:57 +0100
Subject: [PATCH v2 5/9] drivers: phy: phy-mtk-ufs: do not alloc priv with
 priv_auto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-mt8195-add-ufs-support-v2-5-f18eeeeb0e72@baylibre.com>
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

When priv_auto is specified, we should not manually alloc memory for
priv data.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/phy/phy-mtk-ufs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
index 0522e1ab683..c4c214dcde0 100644
--- a/drivers/phy/phy-mtk-ufs.c
+++ b/drivers/phy/phy-mtk-ufs.c
@@ -139,10 +139,6 @@ static int mtk_ufs_phy_probe(struct udevice *dev)
 	fdt_addr_t addr;
 	int ret;
 
-	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
-	if (!phy)
-		return -ENOMEM;
-
 	addr = dev_read_addr(dev);
 	if (addr == FDT_ADDR_T_NONE)
 		return -ENOMEM;

-- 
2.52.0

