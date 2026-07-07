Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32332C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63EEE84A9A;
	Tue,  7 Jul 2026 21:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="jNIdOsCH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C88BB84A9A; Tue,  7 Jul 2026 21:12:11 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA6AD848EB
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4a071495be0so625679b6e.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451528; x=1784056328; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pealUxwn6jSje80ZhpVfIg7h3b5xqazCDrUETnQ52nA=;
 b=jNIdOsCHjDinpo1iZ7OUp0OoASmVymFmcdVm3ElLSD5qL5LyijUiF7GGg2CeJ43qio
 HJrTZL9qL/XABseBG+w/DHLEoXweeIlYjjFEJaUZzkm1OHlFcV79PgLUGwNrqTJmFP5E
 6FcRfHKoXKoNYxI22tWQKBQ/IrixbuUKoXm2/M9Oq+OMFt52UonfTrcENSxoKP9yzvDt
 qnUm8D8eXw82Bd10rOF/ylb3ZlxyufPbEIRbEChtAMPN4dnzlglJL4zv26kDmg03DzzN
 T6opGiHGJcj+ro3eAn9BD+ZLZPWxd3H480dRgpTWlWxwwksZaaTKXTiR04tuCLcxEm8b
 yDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451528; x=1784056328;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pealUxwn6jSje80ZhpVfIg7h3b5xqazCDrUETnQ52nA=;
 b=o1ZATFrF5BnwMsJNv+/zK1Qbb9g87xvgyUzKVdNRrMTglVIVT/DD4qkoJFsSTyze8C
 e4D9DbtVbVajqILJ1W6DFd331Qm5hKZyW+gfu8G1LGIBHVFERl3SWxOFFS5YBu+tTICr
 rr3P9lKOnz/QILY/fhghj9uztfZnRHk39rZX20zBUEQis45kAgP+u0RpNzfslJ33cncM
 Ud1ESJe/VwocOxoLW6m+m2ivcGz3V+YE5L2PiWpHtLnHN0z70hYVVyJ0SseHVVzjWiwl
 m2m/JTiommU7+SnJ+FAWgpK3nksI+Fsx4FNzIXzYmQq/v9+5+RNE6mVScQN+MielyyYt
 fvBQ==
X-Gm-Message-State: AOJu0YyYK24OjPvwsC6xvllDuiPDKw9urK1czVyTQnZL6JCdE9iFWR1g
 n6GUmMpzvVi3q8f4/lqnJ/EQb0TVsRa2rrHsC/tgtn2xvYmNbSHqPJQDV0l0cfPlBhM=
X-Gm-Gg: AfdE7cmiTBzgPjGmAybwo53z63pIDf+WmT03YmMGXcg4W8WAZIOk1u8J0b7UErfRYTB
 w78L0GqMRgeb4TilDPj7W0WXAkyThGYSR728WPsjwQ1FU0Q0hmX0tqShgMqgyvBQzPn4oij9LG8
 3mI0Pc9h6PhcPqm3dndUwqQAl9uGkDAeYtVESL5ev/NKIH2odUBzSHa1SCcP2/PZqWR6rccdA0Q
 E6HJmi+7NJNKQoDU4MV3z4CTVKSFs93zNjzKi5218TvzCTyMpRtAG5iAL0xUymL56rBXRTWNR7w
 8wbfoJAQWi8NxlNAXTSq38OBDRE9hwChD+3WMxmUoJvPJ6rh1QuA+gc+kzbBNMZnhfBMao4UY7x
 JuLQbVbjZU5jMSK5KTjEW7fnzG52pbTkzkBf0iwZ1q+pTM2pX2u4w+q9qiKRjx4+msj9gJnzvSI
 2Hk65HZXSdScVm4ss0yA==
X-Received: by 2002:a05:6808:c410:b0:495:db98:cd70 with SMTP id
 5614622812f47-49fde7f03admr5115863b6e.35.1783451528444; 
 Tue, 07 Jul 2026 12:12:08 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:10 -0500
Subject: [PATCH 08/15] clk: mediatek: mt8183: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-8-283d9a55361e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=n5tPuaR2do7vCxVdPBfQ/DZ7uXBBMXrsTo0/bGiihnw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU9GZEb2L7LDh72yp+TE+0J6F1NNEish4vDUJ
 ovfjNk7q3aJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PRhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A8lQIAIM5iz+COX96vfvYkjkGSb+wfoKZZHkH7RPFSrG
 VRSP2YGOhku1l7tJx30WiZ4Hruejzbjhxo3DYl6VS2JmdONbWSTdHpSL/uCD3hUa8buYva7gtnx
 hoyBKWUjKDZZ1TD8fUrkNy1tu+ye5wEnHXnHQIAd9BOZeY5bHEJGnTpg6TFT1lR9iq3Uolc067V
 TwLJfGwoEMJdBtguhDXK67g1c7CrWblwcX/jwFQ7aAb1MsL2ndiurZ4xwkGsHDCdnMe23wLOzaE
 sv8iTB+1I1WmhSONywlepHjtrID5i/YsqSA2Lylpkgl+zmq0BNFqhFnxvVOWJu7my0+pZQl7wbr
 FsSI=
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

Change driver names for MediaTek mt8183 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 5e4b45a57be..3d5cc2df695 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -823,7 +823,7 @@ static const struct udevice_id mt8183_infracfg_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt8183_clk_apmixedsys) = {
 	.name = "mt8183-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8183_apmixed_compat,
@@ -833,7 +833,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt8183_clk_topckgen) = {
 	.name = "mt8183-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8183_topckgen_compat,
@@ -843,7 +843,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_infracfg) = {
+U_BOOT_DRIVER(mt8183_clk_infracfg) = {
 	.name = "mt8183-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt8183_infracfg_compat,

-- 
2.43.0

