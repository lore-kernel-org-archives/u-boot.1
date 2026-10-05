Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A3DCA5FFE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 22:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4154040685;
	Mon,  5 Oct 2026 22:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f9WPZjVA6XxZ; Mon,  5 Oct 2026 22:50:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 29B8E40687
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791240643;
	b=kOc4wfVR55xnjTxDKBHuLysAguteZj9nVp1kfiPtAzo5ltb+Auc4LQ0afPQFY5zMVqcm
	 bVV15X2OCz4e5dwl29lKFvGO8YidJrVAerqKc6N2zyTcgOOjtE/ykBl0XBRfe1Uf/uU7c
	 oXQ6/RGom2aEpeCXyIPaOwvpNQDg7Cv7gyXoPfkiUViEqSwssF8zc19Ym0MNJ0gP9M8hG
	 22KOWLwzHpJOW+5WMOqh1A1CZX/E/sTSZEO6xEcuAUuK4Y9O6nVd26XZXwZBTZc5mFK0R
	 C+k3xHzvy87zIZtmEQy6yfJVjFS2Vqo+HgxT4SYZ1/XscljbEG1YqykDgsS309JaFCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791240643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aljWoMC/kR3NRkcDqiM+pA8jsUsGyr1sucqof6iY/4s=;
	b=hZHZFC9pV/gWsV7HzixjogS2nVqmAs6uBpRp1e96OXmlG75xhVegZVabDTNNSy5WwgA2
	 LZbBsqjrgej2jTXq8m/a8Xz9mHI6yEP2XIKh8Hg89ZLMs63DBDtNZd/zXZcF7UhB7VXdK
	 XNWwX6hhxXN8eZlevGwzaPMerBz2q8TJZ8GNhh1kjSyEnkJZ81cX17fYao5NpK/tUOBuB
	 chUPBzkGxYQj+WBw5nBNBipgIlXkztOXg9CEbLvdiuIoQy72nbNvGaFH2tiOhqz5GvFV7
	 DSh8D9tJQ3qU3b55owaEWBnpy2QGdRm8n+LwLhgciIRkKUb9hiPY2+F61S7d1Ci+qIA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791240643;
	bh=aljWoMC/kR3NRkcDqiM+pA8jsUsGyr1sucqof6iY/4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jiHRDn8sZwMKzvmzT2CbaN2v2PO0S39Ih4NCq98EnZGVhT0fymqp9bODsgSRBFoQN
	 zj1wZmZ97RlBGTKOmbDnpIQto1QfJbDuO7VyOBUza/pN5OF52fh2egqkQdhcsbBTOG
	 xv16GWKUYFQ4TFDDS3quvQ2Zspt47/gH+wakOZpyb5qCpHKtoCLeMfseLdHDcsKH0Z
	 THQNWeaI93e840HxFdtc31PN623gNU5UVeUlLEFtJGiLUw7OI9GwLVA+H0a4lj3LjS
	 GbQaOmr/4trFt/ou1mk7zr5lSks/tIs2oIvHNbON/i/yixtcaEM3XCC9o7BTIDv+kl
	 HrH2l+QXZGhSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29B8E40687;
	Mon,  5 Oct 2026 22:50:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E4EE534E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6B668087F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LuHq0vPFVhpl for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 22:43:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1AC4780875
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791240214;
 b=ZjeEhx4aY2kNTuR9L4lbt9EpYtPQViSN7wF3mgXSi5dAzDHf0EHeeynjhHBENRZvyXS6
 TB4ZUskV/hYUU+sG0dygEpUdGtZ7EtHvmHxNnOL/8IxUYRq98L+CaiYheMQQy3ENlrxB0
 Be7WXBjEZ6ByivrMeoDKdiJHpBxPOqXeuJ01tIZRC/HnTWEgep4nWRTIqLuLdgLceEMRO
 923gvFpargLbGygxep8/U5gNvgJUfPkYnExPC63hGfBgaaXhk0nBNKptOM/Fr6u7GikaO
 M+kRHcvHdFPUxufPwnP4+QPxdfBcQqTAXdR4DloF5upM8glS0hVwrpnD/uEZa5vzzzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791240214;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=aljWoMC/kR3NRkcDqiM+pA8jsUsGyr1sucqof6iY/4s=;
 b=rp7CbdXuBj1iMsoqJmr/ZqRs9KEcbjuHpIejCfZqSKFb3kNgl6ucErcOIuaEazhXH37w
 u50QKPEo/NytbtSgVKJHDkoh+K7dJFyfFXCyD/gEPkqRU54tmdemAOQzImBgwb+XY4VfJ
 XLXhsScfjh9AZECDK3QiUbsa9rIOwGYgcSgSXqPC3j5rqXwUAS0Tghhnm9szVjJpXheqg
 O26jXN6kViAEZdzA4F1EHUUEUgxBgnN5wYFSeeWcl3PMJDHEnUm14gEwNai0XqI2SwnMN
 EjC0mlVoGL9Y5DjMte7sDGi54np3ALEpzfblo6uj74OEV7R22dskzdjMRxQ068xri7A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=i2TALown; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=i2TALown
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1AC4780875
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:33 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-483c65c2fa7so1863348fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 15:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791240213; x=1791845013;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aljWoMC/kR3NRkcDqiM+pA8jsUsGyr1sucqof6iY/4s=;
 b=i2TALownWJNIXzG0ge2V0ZA69UjOnojVm0C5wsutyFOglrV+e0KZdFnvOz0tpQokw3
 Zb+oeJAbRMO4fL4DpRb+rnjLCw6y8ofCaTx5tl2BS21kYFfJx1ei180b44rjQbu/ZdBl
 wLo0CwmZC6/oLHj4Cdc8JPI4voDoEie21gI8x+HClnh5IWwhO9Jd76AbxdnZE1CYRsjM
 eOHQLRyiDV7oWSTHFZ0YpwyT/9d1YKyjpvGCtZfW1Qm/Zst6XW85yB4aOPwQTrUyYNgB
 wGDnBB6LNfJxksy/48uwgseQTqtZ/xOLY+Lj+a7QvTt//3EhPdplROUvVmpNxYv00ZU9
 DH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791240213; x=1791845013;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aljWoMC/kR3NRkcDqiM+pA8jsUsGyr1sucqof6iY/4s=;
 b=FnCrgyJjkxB1jK/dhn/2tupLkELZpb4q9xrAEGV0gcReQGxSxXeE/nOOlPOmuw/Fl7
 +XTwQ6BqblIAojn5cJjPgmrOJRLHef+yf83Qc4SJ9pO7baza11WaXaGNv39uXkW9Oeoe
 F+xFeF7+DIuK/WMBhizCHuTvc4hmUBjYldZ7e/6zBSeywP6G5KP1cXSsJZNxQFYAX3eq
 RY+X9rXkNfcwvALnEjgWsyQswiO38hRl1wy5QcFLamNhQ9ArLs58WKQP7gzvx4s15mTn
 9rHenesXlJZuRqpHjYiopF8TWzKL2W1wl+ZNzKY/pGHuS7gYm9AoSTlp7Yf2Txm+MEHZ
 /XLg==
X-Gm-Message-State: AFuF++niMtL5M1M4khuz9BHihZPVWRSIq7D7V+PnoKyuyopDu2nUzg/8
 2Sc1omBQm0iF5rAXrhujEn0FE863gfcEBBF/m4jdjuLQ/bI4y/JZZIpR0NcBqG2uvL0=
X-Gm-Gg: AYBFou0a295LqEiiuAtNebOQPPJyis8FOrRsCZvKWckNEVz+feRxp7c6AaQZs23NM0F
 0dmnWl9ipsyxJxJfIERWjFXUY0KawaAZNTKSo+b4t5aVYOqM4gMkVmMXYbHS6n7Fm+lnz2FJ0Ca
 ZXo8OTIQq/KDDKWnw799m2ZBJ/yiMPnB8F4gaXA0TmKewniR97zVW2gHkkaYQJXog3YZ9nFrWLk
 V8UMH7/G+38tczB+7d/+8R96bxZhC4vlicfYodwPLYAEqmK+pMJkU4wB8ud039PSB+gNetSpQa8
 /f6u6UiJzDW1ZiUW0JZ8LWOtS2o96PCdtBb9QhdSbUBYxXfQ5tbGgvMXP8Y5b7CnP1+lb/evj/R
 VErfu2g6lt8jp37NBy0axuACLSwrvP3lfmYrrEMe/tWjTyLPve72l7jlUbd+19w3YzI6VrSaVBE
 fvHru52CSfA4eCV9kTNAIGV1DReNEtyXMI2qqDQMdwvUvUwoIGwWSUxAoHtXQFH/WjwqOA5QMih
 nk=
X-Received: by 2002:a05:6820:298f:b0:6d7:895e:862 with SMTP id
 006d021491bc7-6df3622739amr9986389eaf.83.1791240212829; 
 Mon, 05 Oct 2026 15:43:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:33e3:ea0f:8b95:f69b])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e4c04d915bsm694448eaf.2.2026.10.05.15.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 15:43:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Oct 2026 17:42:48 -0500
Subject: [PATCH v2 2/4] clk: mediatek: return the new rate from PLL
 set_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-clk-mtk-propagate-rate-v2-2-b823df57e4c8@baylibre.com>
References: <20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com>
In-Reply-To: <20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4200; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Q6xmjUf1vZf1PdfFP+vuba7GgJOzqRz9V/5VSHEr8cI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxCf3aX+sY/1W7cdXUXQq7fbp2LUuTGwZbdK/m
 J+kGzFRHIOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasQn9xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AiDQH/3+/A+EMMEVmbY5xU/JWgCaafvc5fyU5LhmU3WA
 gCLYoLtb2GYXkJq2tnDACDso88m32NqstxmRYfuo2LFSapfMgAvigejUSxCUf0F7I5yycx2XYqk
 hm35A0aIsapU3IRLaFTwOdzwaE7uj6H3IPOK5jRXiOQMTzI3It/NICs28grEg72dr81JvYj60Cg
 RI85e+6TKY/f2mOCbe5/g7uV+wqngSz6Ng0FoYDYmDmo904+D4VLqP79I1Qc3qt4KZbw3RCpf2Q
 5FIHa8dZFZ02owD7zA58JqYEj5yPuVCYRFnfOBcjD+TZUuaJ5HhrmrJmzc3s6mySXdZ/NfPVOyM
 aLzU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Return the rate the PLL ends up at from set_rate instead of 0, and make
the MT7629 and MT8516 early PLL setup check the result with
IS_ERR_VALUE().

The clk_ops set_rate() contract is to return the new rate on success,
but the PLL returned 0, and the two early PLL setups had come to treat
any other value as an error. mtk_pll_get_rate() moves above set_rate so
it can be used to read the rate back.

Fixes: 0bd7dc74d2ff ("clk: MediaTek: add clock driver for MT7629 SoC.")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt7629/init.c |  8 +++++---
 arch/arm/mach-mediatek/mt8516/init.c |  8 +++++---
 drivers/clk/mediatek/clk-mtk.c       | 38 ++++++++++++++++++------------------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt7629/init.c b/arch/arm/mach-mediatek/mt7629/init.c
index d12eb5339e9..193d4cb176e 100644
--- a/arch/arm/mach-mediatek/mt7629/init.c
+++ b/arch/arm/mach-mediatek/mt7629/init.c
@@ -16,6 +16,7 @@
 #include <asm/sections.h>
 #include <dm/uclass.h>
 #include <linux/bitops.h>
+#include <linux/err.h>
 #include <linux/io.h>
 
 #include <dt-bindings/clock/mt7629-clk.h>
@@ -38,6 +39,7 @@ static int mtk_pll_early_init(void)
 		[CLK_APMIXED_SGMIPLL] = 650000000,
 	};
 	struct udevice *dev;
+	ulong rate;
 	int ret, i;
 
 	ret = uclass_get_device_by_driver(UCLASS_CLK,
@@ -49,9 +51,9 @@ static int mtk_pll_early_init(void)
 	for (i = 0; i < ARRAY_SIZE(pll_rates); i++) {
 		struct clk clk = { .id = i, .dev = dev };
 
-		ret = clk_set_rate(&clk, pll_rates[i]);
-		if (ret)
-			return ret;
+		rate = clk_set_rate(&clk, pll_rates[i]);
+		if (IS_ERR_VALUE(rate))
+			return rate;
 
 		ret = clk_enable(&clk);
 		if (ret)
diff --git a/arch/arm/mach-mediatek/mt8516/init.c b/arch/arm/mach-mediatek/mt8516/init.c
index 99574c14822..6427df10a91 100644
--- a/arch/arm/mach-mediatek/mt8516/init.c
+++ b/arch/arm/mach-mediatek/mt8516/init.c
@@ -19,6 +19,7 @@
 #include <dm/ofnode.h>
 #include <dm/uclass.h>
 #include <dt-bindings/clock/mt8516-clk.h>
+#include <linux/err.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -42,6 +43,7 @@ static int mtk_pll_early_init(void)
 		[CLK_APMIXED_MMPLL] =     380000000,
 	};
 	struct udevice *dev;
+	ulong rate;
 	ofnode node;
 	int ret, i;
 
@@ -54,9 +56,9 @@ static int mtk_pll_early_init(void)
 	for (i = 0; i < ARRAY_SIZE(pll_rates); i++) {
 		struct clk clk = { .id = i, .dev = dev };
 
-		ret = clk_set_rate(&clk, pll_rates[i]);
-		if (ret)
-			return ret;
+		rate = clk_set_rate(&clk, pll_rates[i]);
+		if (IS_ERR_VALUE(rate))
+			return rate;
 
 		ret = clk_enable(&clk);
 		if (ret)
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index b3f4a07c8b9..dd2d7e4e755 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -547,25 +547,6 @@ static int mtk_pll_calc_values(struct mtk_clk_priv *priv, struct clk *clk,
 	return 0;
 }
 
-static ulong mtk_clk_set_rate(struct clk *clk, ulong rate)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	u32 pcw = 0;
-	u32 postdiv;
-	int ret;
-
-	if (!mtk_clk_id_is_pll(priv->tree, clk->id))
-		return -EINVAL;
-
-	ret = mtk_pll_calc_values(priv, clk, &pcw, &postdiv, rate);
-	if (ret)
-		return ret;
-
-	mtk_pll_set_rate_regs(priv, clk->id, pcw, postdiv);
-
-	return 0;
-}
-
 static ulong mtk_pll_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -592,6 +573,25 @@ static ulong mtk_pll_get_rate(struct clk *clk)
 	return __mtk_pll_recalc_rate(pll, xtal_rate, pcw, postdiv);
 }
 
+static ulong mtk_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	u32 pcw = 0;
+	u32 postdiv;
+	int ret;
+
+	if (!mtk_clk_id_is_pll(priv->tree, clk->id))
+		return -EINVAL;
+
+	ret = mtk_pll_calc_values(priv, clk, &pcw, &postdiv, rate);
+	if (ret)
+		return ret;
+
+	mtk_pll_set_rate_regs(priv, clk->id, pcw, postdiv);
+
+	return mtk_pll_get_rate(clk);
+}
+
 static int mtk_pll_enable(struct mtk_clk_priv *priv,
 			  const struct mtk_pll_data *pll)
 {

-- 
2.53.0

