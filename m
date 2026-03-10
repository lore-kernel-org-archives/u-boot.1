Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03480EB1070
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC348410C;
	Tue, 10 Mar 2026 16:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t5rAe21e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED2B98413A; Tue, 10 Mar 2026 16:34:28 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F4D784119
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-466ed3bc95eso1036092b6e.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156865; x=1773761665;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hefk/dIlK3DvJrJryjiPD3GsTryQpIu5Jy6Lkp6oo8o=;
 b=t5rAe21eKJOp4VKADBhY00wa1NW4UfRhchLlEGMot6WZR6pt7KXGWifz/fB1cAciyV
 WoQ4IJzfD5dGKyB515bd6OZtg4GCn5TNMi7TBAjMmNiFNZN6JsGch/IMQWxoHEwiot8b
 utf+TuBiiz9HmTi6jmbKdBQi2YjLbdnOBJD6SJXdh+pHKiOK3TZes5ku7FEreKSvOgpG
 RW4JyVcLFUaN2PyoxZnObCj6BG6gHHUfrK75LiwZdfksxWqMl3VGhpBjlQU6Y2M1xn4U
 sYmno4G2fy+KwmXwb5WwHWbcEEBIthEpX3S0cVF5bkAxxcBNh9ZA+8SIMn9eQHL0YEEv
 d8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156865; x=1773761665;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hefk/dIlK3DvJrJryjiPD3GsTryQpIu5Jy6Lkp6oo8o=;
 b=CS6wmPUMSpFdyxZFu7hVkS3Z1sLAjjWMRxf3usvmU3Q8KOF8NVEIC6LkrX3JWbTbCH
 D/hCPWSwQdZ4xK3FA9pa3fBmkR76qvl9kV/haV7n3cjDrxCmqlMLNGdott5BM6y5bFPm
 Zmu8BcykwRv8saN1s804Qm62G2EBcfLD5jc+pzSepYnwK8Qw6SBHTyeT2I2hkyszVJDb
 dWpib+GXXTkkBEAt9cSmO1NTtcOcpp/HP7eQLCFEPDbCn02nnQJJAxYKJn/0CRdtxNbm
 kCZuDqfgyuWyJ4t9lnSfqoaTWrL6UYWT0ryr1zybnpEhrCvxjM78eMACjObHd2W0XI7T
 UYwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX39ScAXTO88KTZjM9wmMT3a0D7OyZybAWu/0iuktNe+dRZ1WO1WkkF5bmN/r/fZTEo/iKFvA=@lists.denx.de
X-Gm-Message-State: AOJu0YzmeMs/69WpGnQu6ceH67YptBmjv2FbzwbfIrPPKvhY1H/HuX7Y
 NaLJy+v8qIVkDgJ8PdU3/kmayFVrQgDIe4K8IjkSWzsbdx04Ruk6MVflqCdc72NFmJA=
X-Gm-Gg: ATEYQzy7u2OsJnBrY8Y5qXk7lhMr4rgmQGAXEQTKvInrDKN5t26IkMoEWoMbxc8EYk0
 WcPHWy5sqPh8+hEvOiuduh6rduAVZtcaEdpZLYfiB8/JjKI5Gl+y0du+I+mht1c9DxWynSpB8Q6
 hC2WXmB96IJef30eQIKITcFx48C0FWXrdiPC7zr5vQDMDtaXgQFnxbj3QugSMtDLfQkdzN8MygH
 KtW3IF5Of/JTeNB28ZYPzmZR7lcH2RwGHLypu54LEcLDXe3tHYbTk/SjlW0lBDznmowW78HUEJQ
 Vt+FUavXXulhWTGYjhS882mwrqU/6jLvMvRKaSJNGcMQCgHgGDhOqskUzIU+fwx4XM+25FNMRyD
 ycVpvOgtg4xfvNHD16shWzUg1HLYSDliJRnrqQnTuk1I+RKQNmoGPRTQ+98QG1l+IwIhqPKqzN6
 Dk8fWDbl5bbUcN9nLTSfI94IOxMaLm
X-Received: by 2002:a05:6808:1b0c:b0:467:1f50:8814 with SMTP id
 5614622812f47-4671f50898cmr1593532b6e.59.1773156864843; 
 Tue, 10 Mar 2026 08:34:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:22 -0500
Subject: [PATCH 09/16] clk: mediatek: mt8183: convert CLK_XTAL to
 CLK_PAD_CLK26M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-9-66175ca8f637@baylibre.com>
References: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
In-Reply-To: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=1sdIQfjni7Ziyo6Nzp6ODRtlwr0gUNi/Hg+HUBFMXgU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDm/9LtohURuaHztti1heOLH7VBWTGwsegQZr
 IvhBxmnFJ2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA5vxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AqykH/iXfFRS5crCfPlayyudAi2dVEUDkt4IpeL10K+I
 jHmVagpl68hey9n3k+9UOf6C917YKDAPuEE6SugCDrvWqjjY25EZn9YQKiLPkGbvNtkl5VFyiPX
 DatR2+cAxnrxES1aMKIzG065+1Rk3aTj0lmts+0WmUau4SDFT86B8tCCD2QMpWNbBkcljE/zMzb
 4Fdk8j78GhmA6MCkl5wrAUm8/hgFn5pm/nEDJMdbkdFSVCbuCJihGUX+49C+E+rDG5HW8Vw9Tya
 zrQ9kgMoLRAg4BVwsZfzjXwmQ0hPRxSHSOLCQJSnmq93iV3iVWHhDbYR24p4YUN0u2noMe1znoW
 5Ifc=
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

Replace all uses of CLK_XTAL with CLK_PAD_CLK26M.

This avoids declaring the same parent clock two different ways and will
eventually let us remove CLK_PARENT_XTAL completely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 6158441fb95..7b2d796bc6c 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -76,7 +76,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 };
 
 #define FIXED_CLK0(_id, _rate)						\
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK26M, CLK_PARENT_EXT, _rate)
 
 #define FIXED_CLK1(_id, _rate)						\
 	FIXED_CLK(_id, CLK_TOP_UNIVPLL, CLK_PARENT_TOPCKGEN, _rate)
@@ -605,7 +605,6 @@ static const struct mtk_composite top_muxes[] = {
 };
 
 static const struct mtk_clk_tree mt8183_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),

-- 
2.43.0

