Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A5EC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 14:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87B7D84B19;
	Fri, 10 Jul 2026 16:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Yr7TVzL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7242284B1E; Fri, 10 Jul 2026 16:12:56 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B9A84A7A
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493f0ae9572so3754305e9.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783692774; x=1784297574; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=seu01KpxZ3sc2WHygC7jCzIDtStuhNC4KlyzfvFeW/k=;
 b=Yr7TVzL0QBsCOv3jmBfKdELuOqo0nufn8RBW0XnuBqEWE8R3T7U6OgbCx/6FKdTrAz
 T9WidnoSjxAyuxNWHLf4Z8KpWEu/sU1Q4SRqMsAgNcaLFv4p17+CELr1iTjQkvafCpFl
 fF8i4A/JuT86rKYtgkGXadU3IjgK0CwLzsMyofcfHXQTmSVF4DHLw+ZXSvBAhKQPOOxV
 DKBL8posUgdPos492RB+aASvdWQ0KIR6rwWm47lOTA1QQ8NfvtgYJPSyIk/cpdukYmFI
 Hri6MqPrPcZBgyROrAaGcn5x1QYr6zsU44DAdlol4Wc3cIqkRVhFxihKYGEV0RJc74jq
 8TWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783692774; x=1784297574;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=seu01KpxZ3sc2WHygC7jCzIDtStuhNC4KlyzfvFeW/k=;
 b=qWq83netJ6SYyqNXPYMHLwAmUWGHyqJBZ37u+hVWeHuNR1g/Y8j3obSf7D7/aJt3Rg
 6RwIkr2Kc2W8n3uNxKHuKOqocMDx+8KJRE4BndEGwGIYZGIfxRvmbcVhmsfA8+jGedoD
 h+9AtWI/MS8OXdieyTuWQW1pv9L5T0Q0X8z0XoKhGIRq4WofhaGrGRcfwJpu1cidcQt6
 NIsD6Iyq8B51NOtC4IqCu/fuCby1ofthfeeQmdVOBDd6UP49RCZtD8VDcTiD0VT7J50O
 gJrOqUNDhUA7M7EgETErPNe0fCmP1Oaa7sx2KcsLuULnlBr4AI4FFqC4ljiK94wItTfV
 1flA==
X-Gm-Message-State: AOJu0Yz857mxncQbtaZRIOwo0ENp/nw9FyPGwBTvEHOGiExrZZLsxfvC
 v49mv9kL5VSGIf++7/h6BNYmVmI3HAR8VSxOVWJzGUZ+Oztz1K7iuiyuuEts7lxJRd0=
X-Gm-Gg: AfdE7cm8YngTkx91ad/Jffo64XdSUngm8JYaJILw1JtDvSDwaAFycQyj7Xr8toVGlYk
 qhu58h3ginIyLyyGSDqTfLMnxdtX7EeiefoesrhCGZVEYT3pCgjpR8qZg8uiwF6olGefd84mEGT
 DxrTfUiD+4E3lGmnoKCJOnKxuvZnYQBvMGe7zFDFOGrp6hK+VZEU6voJmG+EA5DVMdfgeKAxIXq
 eOEWE5F/R+KgkfXEaCEGd7X6/aRifAYKpyIoJVd3xBGMimuP83mKc9HLOEVM3zaRXdI80UZPIzh
 fUoZad/H2LIUnvp2bAlLsLck6u7yruMdAUqCuo2rccHlFcwWLHWInouuQzm/SY4MZ4uy9oCZQDO
 jITXAzrDOkfarKM2ix+5dWZNFdXOfXwO0vQzKybYYFBlHpYPmjfvHzH5AxOjY6PNqpqhqRVK3p+
 Ob8Y6M3bkvmomk7dHsUs9gLyyQXpb0f2/pN903TE9yXQru9alxNE4v2mMV3+3/h3cdMnbKqArtt
 g8Z9CwyQrvaCiarruk0tWYWFn+oXL5xgWDPPGeMYUhmsh0DmtxGj2KOcpNvyCl1MIzuFbQ=
X-Received: by 2002:a05:600c:630c:b0:492:53e8:3bc1 with SMTP id
 5b1f17b1804b1-493e6a4a615mr108512065e9.17.1783692773881; 
 Fri, 10 Jul 2026 07:12:53 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm64073205e9.1.2026.07.10.07.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:12:53 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 10 Jul 2026 16:12:53 +0200
Subject: [PATCH 2/9] clk: mediatek: mt8189: convert to mtk_gate_clk_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-2-a4b5c491d9bf@baylibre.com>
References: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com>
In-Reply-To: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

MT8189 already uses a single generic clock gate driver shared across
multiple compatible strings, but relies on MT8189-specific data
structures to describe each controller.

Convert the driver to use the generic mtk_gate_clk_data infrastructure
introduced in the previous commit.

This serves as the first user of the generic framework.

No functional change is intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 3093fac23ce..e78c9fc0eb9 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1990,23 +1990,13 @@ static const struct udevice_id mt8189_vlpckgen[] = {
 	{ }
 };
 
-struct mt8189_gate_clk_data {
-	const struct mtk_gate *gates;
-	int num_gates;
-};
-
-#define GATE_CLK_DATA(name) \
-static const struct mt8189_gate_clk_data name##_data = { \
-	.gates = name, .num_gates = ARRAY_SIZE(name) \
-}
-
-GATE_CLK_DATA(perao_clks);
-GATE_CLK_DATA(imp_clks);
-GATE_CLK_DATA(mm_clks);
-GATE_CLK_DATA(mminfra_config_clks);
-GATE_CLK_DATA(ufs_config_ao_clks);
-GATE_CLK_DATA(ufs_config_pdn_clks);
-GATE_CLK_DATA(vlpcfg_ao_clks);
+MTK_GATE_CLK_DATA(perao_clks);
+MTK_GATE_CLK_DATA(imp_clks);
+MTK_GATE_CLK_DATA(mm_clks);
+MTK_GATE_CLK_DATA(mminfra_config_clks);
+MTK_GATE_CLK_DATA(ufs_config_ao_clks);
+MTK_GATE_CLK_DATA(ufs_config_pdn_clks);
+MTK_GATE_CLK_DATA(vlpcfg_ao_clks);
 
 static const struct udevice_id of_match_mt8189_clk_gate[] = {
 	{ .compatible = "mediatek,mt8189-peri-ao", .data = (ulong)&perao_clks_data },
@@ -2036,7 +2026,7 @@ static int mt8189_infrasys_probe(struct udevice *dev)
 
 static int mt8189_clk_gate_probe(struct udevice *dev)
 {
-	struct mt8189_gate_clk_data *data;
+	struct mtk_gate_clk_data *data;
 
 	data = (void *)dev_get_driver_data(dev);
 

-- 
2.54.0

