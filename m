Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A29BC9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 16:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09A0760DC2;
	Fri, 25 Sep 2026 16:00:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eWtyR40KXX4V; Fri, 25 Sep 2026 16:00:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 622CD60C2E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790352023;
	b=ZUIVbZWzWSvJn+1Wz3gQ2G06FJNPh5fyO+5r0EwEEk6larDwwHxwXlN2cYtvHs4B2ERM
	 6bGzeEYorpd9CcSX0Hx009hM68pge/9zN8NjH8XqTXtvbIigmM8mTaCgaX0J4A4Rx3Q4c
	 mz5AZlH45B8ZOJJtt2tZEOa6uU9NKfiv9gxHXxdFoEdUOn4BPC4suo+MzwN6aeBRQO5kx
	 y/n9+mhmWjZLWPxCeTRpPiNAmilwrNKfnRo1nIz5bheKXU3Jl/HoTAFS7ZIrF8NgEGta3
	 rz6iXxr3G0tgsImdKgWTwKo8oRfpU7kf21XqEIkDpeDy1hcUZYAlJQhvnAc9fHjWKww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790352023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EZvAGGOCvGI31nUqPlHSNY7MAwIrwRIp5pxdLD0LzFA=;
	b=SjxE2W74tSEcNhyCtyDcmvNO+v4N6kViawEA+XaU6nOFzeEv/6mfguzNMnrvmtN29wIl
	 ym64G7SO/WGuPwEjxuxpqqygvYGIYy66bW68XnFv3B3cpd2m3QfFuVYpAH8CB+KhIg1f2
	 1Y/Y6rklppwQCq35aLl3+os4q/QB3hQU6jtVHpX07zLBpyERctqoRDML6HDgCpijNpaGn
	 yuh5m8XyAsCq525rrnI2oYF4yCWK8IW/Usx1l1VEeAl3ot5BBwptU1M8U0GT1vxIHZ8h9
	 rnnQyna9AG/qme3Ip96jYiEJWDqm+uhRiq6NQt3prVG0b0sSfi2N/qlIVBvo0kxX+ww==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790352023;
	bh=EZvAGGOCvGI31nUqPlHSNY7MAwIrwRIp5pxdLD0LzFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hX/RbaVWohvVqPVhRff/R4MNAXbCR1hk3AHqql+xRNyYNssPGvPUChD3iMlu+fRAT
	 ChCq4SzJUXmBxH3qhvwjxHKnur/h3pMIxibb2Ub4fbFR0WBiZeP5zppS5ouomBmubN
	 7zvdnkkDzNjte9j/fINU3CpEjRhqZxIaYxcvOQv+Lj3OOvPFE37QMped0LZNbWqs4Z
	 HADEkE3FtCZ2y5aVZGqcIikpcDfk5dJO0BX3Sufq/6OB336z9OoU9xaCxIhGKmR6jy
	 rWFMLM38uyPgKcTzwOu1IVEsWYaBSgW58Ha6C9+5WSDvYeCvTifDMvt+YgxXxF2L39
	 wujMgfNBG6bBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 622CD60C2E;
	Fri, 25 Sep 2026 16:00:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 13B56355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 037E340BF2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:00:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LybphUilgdwp for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 16:00:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2DF8740BD4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790352019;
 b=pGKUu+gg5Tav88kBePCEm2qbYxmxIHQi81vmsvIOGdf6Vg+4XAo08/lz4COczjFxxlOt
 xFyyrdkRZFtbTlDYP0iOpjjkv2EnzQReR1mNJs+3C8swNu29yGbaqoL8vF6oW/eHe2gKw
 r79HPJdwBvdKKJrEzQFATU35UR1yF9A0GflqsKCk2mfU64Xa5lhDLIsJiecJrTeTzq+b6
 vK+Vr99tNjQQIWKG6yAODfdImhNva7D3CZOWIhvK0LeDG7jmM66JPcHtttlcLL3ZEeQCP
 z8czlprUf0gxSjOU06iK1Lk0ve9z1J+AhwLe3KpU0tSxGv6RIwuQbbI6wedGyPZmyFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790352019;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=EZvAGGOCvGI31nUqPlHSNY7MAwIrwRIp5pxdLD0LzFA=;
 b=lSm3/5fERTLrUKGA/SExWgXdoSk4ltUr2I2ku0fpXt3yyfsq4T82DElcR4n47ZdFMnFr
 PXTpEqHiIAFY/amsWjYZdg6AMdTyRQfaav34pn+scrX+GZIayfHARUd4OB0kNhTqvpD7T
 mkSx0dQ1JrE6WseagkS05lCdqgC/DODysQi7VGqMftgYrgm1TGO3r/c6vT6iNmPkq2yoF
 I2rCuuzLozF82nLw7fP8xfBC6qH2+K4sXxk0wMbXVyymANnlR8kk2alnYge0Rq9dg09gb
 8MmM0NANYYONxPwxtbSeelIwlUtK2rqY1FmlheggHEhGYvq5pu3ZKDHDbOKOqFHJbIA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kvyYW3n8; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kvyYW3n8
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DF8740BD4
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:00:15 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-7f4f0c89e34so676731a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 09:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790352014; x=1790956814;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EZvAGGOCvGI31nUqPlHSNY7MAwIrwRIp5pxdLD0LzFA=;
 b=kvyYW3n8Y1CVcMFF1cZqeMZQg+SxhUoUH1lZsEWC4n+MvH3+EeLtp3Q5DprWyMqW/e
 nrMuq/nMneP1HbjoMGjE/fvl3uXFcgV0LK3kWN5t0Vhpm87VYSqSuvKr9Q5AdFdgf+u0
 HtLPO+Hr2KpGBUc8nN5+g93uFChrxAmedOIyAU8rN0nbEUkp7EQVNm9BPAmMofzGKCI1
 +IjT7mjaOKE/VzXLRD1y0arsi4oFFNLGUvQCDLzAjyv9apz/ZuC4cX9O2efK1y33fufU
 02MytttDkU6hyobRmpaeOr5GWlX44p8BE5iSMRFXUrKe0hTNWBVKVg0ikRBersOWLbGV
 sYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790352014; x=1790956814;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EZvAGGOCvGI31nUqPlHSNY7MAwIrwRIp5pxdLD0LzFA=;
 b=Q7URVc5vcZUJMWia4qNXKwzmUuKtm/c40y77Gebc5Z08wYQAY7/cAuHHCKtxIKeK5d
 slKQL7L+St8XokExWCJk9j9lYe7oagzc4uWoFoY7NG5Ao8NlSotI64GLrpE7/koKywsF
 /3Qu723VJe5VG1OEktBkwUT0QlpPffjLtwMns9lNCS57o2Amv1I5LEzK4U2qfgcLv9J8
 vepdKi8ZoJnIS4Wv3yVb1pLa0Rb5nZwHClQC0t/B0wLNVlqD0VyXWPIy5hqTj2ydbQFg
 rQVEBbGK3TbwuN19ta4glXRKMgs7BaBN0KYkSIFBbPil5MaZ8G+nvd/9Vy1XvsdF+dqS
 peAg==
X-Gm-Message-State: AFuF++nx32TdnoDBQDOAgHhS1rHfXL7PsPuDr3GwB/NPPb5ypRwm8ntS
 HHhhfjuf8BodIkuLWr0ybFTdwzjITzpZkJ1/4mJAzDpY7K6T2u8gPqw1pqrmwqNYNbA=
X-Gm-Gg: AYBFou2P5omS1s+1p6WBR8SZQI7CbYblgN00whvDkJu28vpQ6j35/MJGfVKcxbYBVI5
 EBoNluzIRcFHo6aMq7wEUW18NiBDnapnzN7s5PdsfavbJ+VJz1rDKrR23C68GV9qlcpyp4rxXj/
 RZ+k2VCdAw54Xs5dPbBqszY+21DLbRKhBzRXBi138QDPPJ0sFK7Ad4GMj+Jrr2+RXZzoekqzGyP
 QFjL6oyevzO10JAF4d/xratGInsku/605tfK4Gm/ahfFzgikZz1dWckSrBp7DIoYDO+9Bm3gjNw
 g1G3nwIG7Bl5oJtkYW0jx7rB0hb+d6rmQtag3iw/hTabgKiWgiBFOe1Gays1ffvMB4DILZlmalZ
 /xsAwLCYhZZxIL4+JYaH7mAwieD0UNZyzAUOwN4wql7BftXpxhG1VpUmk/BDRaEXkQ/IwehDUWS
 gV1UCDugFUhHDig9WZ6rLYmd3MmiBoIghAzFCMbPiMMuDLxJ8Ohiq7d+B9V6iDUHCFbZs31B9om
 p4=
X-Received: by 2002:a05:6830:2a06:b0:805:352c:a6a1 with SMTP id
 46e09a7af769-81782d82ecemr6735460a34.24.1790352014373; 
 Fri, 25 Sep 2026 09:00:14 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ecea:a30a:390f:322b])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e6211cedsm2469164a34.3.2026.09.25.09.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:00:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 25 Sep 2026 10:59:37 -0500
Subject: [PATCH 2/3] clk: mediatek: return the new rate from PLL set_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-clk-mtk-propagate-rate-v1-2-8c7169b4eeb5@baylibre.com>
References: <20260925-clk-mtk-propagate-rate-v1-0-8c7169b4eeb5@baylibre.com>
In-Reply-To: <20260925-clk-mtk-propagate-rate-v1-0-8c7169b4eeb5@baylibre.com>
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
 bh=jGFNdGG8wS3wQFMokaXyawhXLL+95XgA7bXSjg5RM7s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtpp7DQQa9Rp8/68YFeO5wsuR7rx3Fjo0gieGk
 czAyFueFbCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaraaexYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ADH0H/2R2fHaUxVbwNxHU8SnL4u5nnv9rRQd5mgVSj8U
 YQvbwTj+AS0Qed3KKSMm8lVZMx32Abq6an2boBT3WS0EaeCP0s5LibTin0dMm9sYjvRn/VL4lDe
 phnJvlDNvGI2SS/Sqns+R50X7WdEM/UVX+x4olRSKYg5dTehvB12pSFxzz+jxnVIPf/bpeEKaqc
 5sy9Bu6x4RdArG8EFHuRGiOkUGfBrDJAHny2vNejiydPBhW//2Pb5IUlKwN7+E7gNapQcDNlHoM
 SrZfx1mVQHysScFVb4Jy//0c5r3k7LnlTxCRUbqLbHZH/BHuUr6vNjX2OxnVSjw64eKTf+W6Of9
 zor0=
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
2.43.0

