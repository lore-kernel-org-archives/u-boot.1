Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA0FC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C1184A4A;
	Tue,  7 Jul 2026 21:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="IxgXMfTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A636849B1; Tue,  7 Jul 2026 21:12:06 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE102849B1
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4955cd5da3dso1467440b6e.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451522; x=1784056322; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yMPYsohWqJPBiF3LvbfbdEsFN4TNvlHk78mjWt9wZNQ=;
 b=IxgXMfTc0uMUQGylMzi9W7xijpfkKWW7x1nraqFuSzlgH8rPHB15eXfEw9QuO0FFY2
 EFryBBo7UhuUMQQrb0ZyspIgdJyWo5cM/GhSlbdAzBcqnWg+IiODJc7XOqGBGXKhvLYv
 +Nbt7sruAya9QUcuykBmjk3z8BfSoa3RjPMI8EWv2rZGHn3Mf0q58XBN/vWvspSncMCA
 qiAcQzv8otEHAHvtHASecNhVji6sNmTvGjISukGjcDRX2YTqwYAMOKwasdjHay+bKfjN
 X5s8Yw38/hj5ZwwHhkZGa6n4PQXC3eDmGrey4KTqu8g5K/5mRIUMECoeiYE2M+UuuABP
 1W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451522; x=1784056322;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yMPYsohWqJPBiF3LvbfbdEsFN4TNvlHk78mjWt9wZNQ=;
 b=GQWqNk0CHHsIu+9rV2svnw60m+nrJeExI17SnZrv9VO2SRx35XourQSdFJy6DJgJ/O
 d4IDpZO3LHfyb2ycO34TbpjoTPc2g6Od76mj4fN+6dl1sZ7P1goI//7VR0YnyVH3GcXr
 PrqqxFqf/JDIgVkd1JAbiqlMVo9XJrfiSNk+EmNV6XKo7HidymC4punbD1oN5JPIIRZS
 QhuuKhQcEZyqC97OIJoN0UaCvC7qS3mikMmcCFBwTNbXIUtzK4YnutE9auhHRKgjX1yw
 CWrlZvusc+2rwHG+P0LQJ9h9xnN/CLIaRo9c+iq4PAmhi5SQ21SNK/FKcLY4F1rfNydz
 zNlw==
X-Gm-Message-State: AOJu0YxiZQxby40Rl9WTZ+lEnH89X3sMmij98w7sY6xN2V2JoWGQDTHJ
 1lqudDu+61nNqJVNPmxKFu/zrMOLXgtvIxdopILBUROqpxWqOiqhY5yjrnFaMS/zXHc=
X-Gm-Gg: AfdE7clErsl5BJh7jfIcHbO4WmJTYjZ68y7p+zIscyarnYH1yjmtyYVLMqwMQZvBiC/
 D3sJ96d/6EyXKBnYK6mr7fydUP/ZR4ClmweadL/UTMN67RwxaaI7u+sg3+16QeBxVk8i04c7Mpn
 vKbTTaZBwEcCr+v+ccUOVMwfIcdI7IQr3jAUQOlFj3KX/VFLgH+1N9q4UKdxcdOUuvlS7Gsr023
 alHqRgrVo1r/mcrtEaGwgl5fZIMxAztQn4WbjdL2q/D1Aecv68oHkpaJIBbd45Foo7nGrNDybbq
 UG+2s1ROgogjyhPtbAzC+nxY+b0PFqEYbeau77NFVKC8OBKbQo2Y5LozwkpWruxFGe++gOWCmBL
 G3m1AGvEpQqEeTDWR3hYQYI0FTKHwCMen0/xLss3Lp1Jb9v2z8o32+BUiFq3/WJtWo3xBuO+eyj
 x3jS+4gRj9JOYD1T8UmA==
X-Received: by 2002:a05:6808:1688:b0:489:5d05:552c with SMTP id
 5614622812f47-49fdc872bf5mr3650605b6e.18.1783451522588; 
 Tue, 07 Jul 2026 12:12:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:06 -0500
Subject: [PATCH 04/15] clk: mediatek: mt7981: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-4-283d9a55361e@baylibre.com>
References: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
In-Reply-To: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2286; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BB5GeDZNyIMZrVLAYzRWdbmKMkA8p3f8tdtbNe5WGSs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU8qmtaA99M9mDau74pauKuToucztlytWZDLl
 h3oglcxJ3uJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PKhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZykH/RiUBGh277X9iQnJ/5YLBRG2xrpLyNkuBbKFN+v
 tlQ3axeih2DmKfvwJ3hDNna0S8CABnVSUdBSWvA5lJ8za/VCdvRY7xFH7RWV2Q+mVKodvUymJSQ
 xh6pu4w9icCOPztLLGXrMyi25qcR8H6N+6mEuaqs3/AiypeCQPDmB1Eue3ww8G90DM6WXfzhnAv
 AfGy3FHqW4qlboVpiJhh7U3H3ClWDYfYUqJL0+XPzjndgoYe1MB5HkFi6PbSqVIlrAeM+LDLjWo
 lBFb65Dwd3KshADHbq6Q24xbMVi2uaMPx/Gfjj4qBKbFbPLED7DJYUPmW+XMbRmrngMrO/Y54bw
 Lt9A=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Change driver names for MediaTek mt7981 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index f7b2e559baa..5e111ce9def 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -687,7 +687,7 @@ static int mt7981_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7981_topckgen_clk_tree);
 }
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt7981_clk_apmixedsys) = {
 	.name = "mt7981-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_fixed_pll_compat,
@@ -697,7 +697,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt7981_clk_topckgen) = {
 	.name = "mt7981-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_topckgen_compat,
@@ -717,7 +717,7 @@ static int mt7981_infracfg_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7981_infracfg_clk_tree);
 }
 
-U_BOOT_DRIVER(mtk_clk_infracfg) = {
+U_BOOT_DRIVER(mt7981_clk_infracfg) = {
 	.name = "mt7981-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_infracfg_compat,
@@ -759,7 +759,7 @@ static const struct udevice_id mt7981_sgmii0sys_compat[] = {
 	{}
 };
 
-U_BOOT_DRIVER(mtk_clk_sgmii0sys) = {
+U_BOOT_DRIVER(mt7981_clk_sgmii0sys) = {
 	.name = "mt7981-clock-sgmii0sys",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_sgmii0sys_compat,
@@ -786,7 +786,7 @@ static const struct udevice_id mt7981_sgmii1sys_compat[] = {
 	{}
 };
 
-U_BOOT_DRIVER(mtk_clk_sgmii1sys) = {
+U_BOOT_DRIVER(mt7981_clk_sgmii1sys) = {
 	.name = "mt7981-clock-sgmii1sys",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_sgmii1sys_compat,
@@ -840,7 +840,7 @@ static const struct udevice_id mt7981_ethsys_compat[] = {
 	{}
 };
 
-U_BOOT_DRIVER(mtk_clk_ethsys) = {
+U_BOOT_DRIVER(mt7981_clk_ethsys) = {
 	.name = "mt7981-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_ethsys_compat,

-- 
2.43.0

