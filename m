Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9D3C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAEB584A72;
	Tue,  7 Jul 2026 21:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="hxl2Mqvm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D79AF84A5D; Tue,  7 Jul 2026 21:12:07 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9CFB849A4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-49fa951b2c6so1196175b6e.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451524; x=1784056324; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nTzWFojdXPU48NH63UdCLNdp9qyR0AaJxgGx20TGkwQ=;
 b=hxl2Mqvmk04fJdGJnETEFXueX9GANbORrvyVGvYwasm4dmbfHxSUJBY0FNjT6riYLX
 /WZ/hfVvMKkT07KBIm6sO0Mod5svfkvLwULL3YGdkn/jh4nFH+a5G4NPyiHeSrrDUkbx
 2s4Yj62PFUC8piLxqCxs+emBrpqiK/RXP1WPmmAMyhUuVxCEdk2YeKigx7EAe4u9qa6O
 Ykc8Dl/s4N3XI7HSIIPoOFo1sb/5x0WrhyfQFRLws5QeU5U4hDqGmOOds3EbRTMQnKeJ
 D9LtRAJstQin8fK6kqZfHAAQqgFgTuACvhuaZvf0HeIk4b/Y/O7YoYtceqloi36BjGq2
 6RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451524; x=1784056324;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nTzWFojdXPU48NH63UdCLNdp9qyR0AaJxgGx20TGkwQ=;
 b=nWrbF5DUsMFpN1MKprymOEbuCvB7RkYAxZPUaGWvWxWPk2xRaOOBMZHhWXpeCw0+Cc
 OBUY9PUhLb4nEs6DqYTIiv25sOvQ0kfppLRgjp8eFn7OJ2A+ZOjZtIU7z6xYSQX6v9Op
 VIaPzFEaXmJ+5Jc45TGO7pnRZjI7jT2XnEf3KpsimJFlBeBTL673Gs/IjytdxVsE0ZTV
 GDXVxG4M4yADUEYeZ+XMA3Cf6JA3XmUrCpWBA6gmfeJEeklaGXo6Vj2KSvVZA2xtD+wO
 P6zk+vP8yiBPlNVPyd/AcWcMbQRmlqpQw4iJ5klVGo8oMpFUbPAAKEiMLpZ81dYG8HqG
 2wEw==
X-Gm-Message-State: AOJu0Yx1thFQ0CNCdlXt2gcru3q06/b3T/hGwOMyfQ1Z973m57zSaP0H
 5oFstAcZ2dtzhVhZquzuOxYdRZ1dOAJlmsQYwBTsP5Fq4hlMAwdtWWtsbJQn/5eSQLs=
X-Gm-Gg: AfdE7cmm5zvMO0reXEZ9uLtJPvdLQsGS6ztoyYmy9yi0Qr3wh0AwRf+kVi9ge5gzJS/
 dKyPXnGXGZlzMSDLZm5BGt53yepzBBu/1GpwE0g4rCSXFN30SvKkVYC/MK+qWtNiaJpEoxsyx5x
 j99pLd2flKw+X2REPac/KrNKy1nUhuffgos/S0yZJbWazgMfh+5Arj/nb7IaGXGSW05HS7UbR6q
 5t329fFhmdmgegcHzsFpwfj6RdpcgFwA+Pt7HGl5Jua3r7e+o7e233/Ekx/mNMBRucEK31wgDXg
 ezvgZNkiNTQqZ5ozjDM2udVLQ/85U/fGxOtpgyXZnHhH5zGdJjUKxl9Az1hWDgQn2Ps8+wREvQA
 Cwh/1sIMR+ptkWsonL5EBybVmROJzSc8y4TTn2ynxKZc3FgeuYymX1+LuWzGYhG2eCqFDSOo0Qw
 vVJbncZFHEOfStH9//Dg==
X-Received: by 2002:a05:6808:5246:b0:487:61da:70fb with SMTP id
 5614622812f47-49fdc441097mr4429960b6e.10.1783451524514; 
 Tue, 07 Jul 2026 12:12:04 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:08 -0500
Subject: [PATCH 06/15] clk: mediatek: mt7987: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-6-283d9a55361e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=7a37DztJRalO112/xEATPZYcCa66E7HVzXk5h9DLJms=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU84nuhiyIzxa4WImavwwxLiZI9ytfMSmbANZ
 PEiilpSda6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1POBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AD4YIAJDJ+12LdQTvAgYQKaWYiJxGopR6tJuQKLcHEjz
 uDAew9Nf/L59ddQYm9PvDKZjEH1X7Gv0IoLMqplImmna/2jyFILjoWxf3vU6FwLmkpnH4uIY3wP
 hKfY6WXLC0YUH9XsUOz7HLsNt/wqGjl92DDqdkaVhm3fbrME0HQ7MsUeZzCX8G97viufhvcGqE/
 ObRby0YZkFsMqe03V2hNuIpHkiT5gdoL9RTUduOsriDepLQ8nPSplxJDhzTv6/QRK236UCvFJ0I
 OzNyuWcFCrkNUqvEH+thnYCOO5P4K3PgtiEzLXXx4Tj4Q8LKl1Lw961tVEeVKtznVnFM2o7KlNb
 5f2E=
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

Change driver names for MediaTek mt7987 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7987.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index e3a95864235..94a988f0cc2 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -74,7 +74,7 @@ static int mt7987_fixed_pll_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7987_fixed_pll_clk_tree);
 }
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt7987_clk_apmixedsys) = {
 	.name = "mt7987-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_fixed_pll_compat,
@@ -483,7 +483,7 @@ static int mt7987_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7987_topckgen_clk_tree);
 }
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt7987_clk_topckgen) = {
 	.name = "mt7987-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_topckgen_compat,
@@ -804,7 +804,7 @@ static int mt7987_infracfg_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7987_infracfg_clk_tree);
 }
 
-U_BOOT_DRIVER(mtk_clk_infracfg) = {
+U_BOOT_DRIVER(mt7987_clk_infracfg) = {
 	.name = "mt7987-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_infracfg_compat,
@@ -861,7 +861,7 @@ static const struct udevice_id mt7987_ethsys_compat[] = {
 	{}
 };
 
-U_BOOT_DRIVER(mtk_clk_ethsys) = {
+U_BOOT_DRIVER(mt7987_clk_ethsys) = {
 	.name = "mt7987-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_ethsys_compat,

-- 
2.43.0

