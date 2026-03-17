Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F856FF6E87
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 21:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E171840BE;
	Tue, 17 Mar 2026 22:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Sf5/h2Qh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F42840C1; Tue, 17 Mar 2026 22:41:34 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B7C18401A
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 22:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-66f3e7d9eccso3863457eaf.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773783690; x=1774388490;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzZiEzwsIRm66iX5MxxgNQan6X22w3HkU3zV3yhXUjQ=;
 b=Sf5/h2QhTBDvallYPoAWTf3uoPc0dIkJDqu/1Kpz03PqbMndtLrgjRpyzmAYToci0s
 OBnpoE0BkqXNCZaoQdOamfZHB6KhMwS5Q2LliSiNEvNPOFsLtcwqFHtuUU2prtAqwfXi
 HDBWtADvm8a9T68vitvGCKRJuiKwAupndQvlHMPaNr0SBIjlBsT2/LbZB9ifXvRMP49h
 FbN8mOhZSEcP5lJWovz7BS4Cipx32BpUtz9w6JXTASL/KtGcnJ/QP9CpdYMPYtUuTJhX
 YrBr8+o5tjeScnFaDa4kIMs4BH9R2BcJwKa6bqMb6JYTxDZlZ3TduthmIwELxww7mIvV
 EL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773783690; x=1774388490;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MzZiEzwsIRm66iX5MxxgNQan6X22w3HkU3zV3yhXUjQ=;
 b=EkEWvPD2mlNogjHlttdG6pv8eJ5IQ1hLqfXFWhQIea7RKX7+yEKhaJlCK5NH0bolPV
 dJHrYUuQMst412fVjypONkTvY0nORUfi71L682mwxBeY2mDzkOr4d3RL2yQsNDbJur/A
 DzFeO5U4Ut9KTPPEefSNyo9a4Figm1M8OgnYjYWj5HXRmb5EBYrNIaX0XKTDFMkXnUm8
 7DtDbIKEoBp3UBPzKAcQdL/MLfTtGA7HAs11J8/kA8B+MOlCaMvoNeSdW/AEl4teJOcE
 a9eh+Ez0yke7vGbsV1usIh/yK0J6tIJ8grGhxevMNqJiKFV2sHxBpJChrkOa76qsd1cY
 l36g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL4Qxh+KhvaeuoWAGLuhLDW8YlGNRM+O2PYMZVtHINcW1ACxzTNXia59PFPv/OpXTTkg0LB2E=@lists.denx.de
X-Gm-Message-State: AOJu0YyzZfXqGaBuRVXGDBZH0gGYn551PYeC3275jhteY5oQqzg127MV
 FMeQo+BPxhiHn6j4cMruYCY5LO2Z96nRkHxaJh5HBPVPBIjsH/yS0eGRMqY07XPaEbg=
X-Gm-Gg: ATEYQzwmgYFXNMZk2rrdeoGj5cUv+3eOO9nDpIWdyCBrEaX5TH2q0pT/dEkp3k58GG7
 phLVO884cJ69yrxKXXGt+jh9DaA8aZS3CHzW5Oq+PJP1xUatT+Va5t030jGIHCPTCPTzlQgllQV
 Jm+14SIde8oPPQTN1k67Be0U1zzZeb9jVySp+ujdJwkmvm4bYue1BWSZjpQhDnbOfpF8RMvofX3
 TKvzBrO2wopldckGYfAuln1LYCr63g8S9G5+oOhknWpM9lsh795wyXmSdoIxDG6ZBM/bdxPUw7Y
 b+S7Eekzpu4qSj89W/IVwVHAs+bX+y2kH/z17iMiNFI0pQYaVvyypurlKNeTe9HMb/MLUfL1jbV
 H557QqTHhIlHT6C6/kWsTvHW7mh2F6h0yhnWHMTCOtAfeNemat8kGWg97l0YNRe81cEHEW6oMW/
 +IYVQFuQfTG92GRgQBCa98Hmqb0wY=
X-Received: by 2002:a05:6820:4a11:b0:67b:baae:333f with SMTP id
 006d021491bc7-67c0dae3b68mr511914eaf.39.1773783690576; 
 Tue, 17 Mar 2026 14:41:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6995:28aa:eeda:102])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c0d89c99bsm448953eaf.14.2026.03.17.14.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 14:41:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 Irving-CH Lin <irving-ch.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
In-Reply-To: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
Subject: Re: [PATCH v4 0/7] clk: mediatek: new mt8189 driver
Message-Id: <177378365236.670517.14105942366222536551.b4-ty@b4>
Date: Tue, 17 Mar 2026 16:40:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Udc7CfcXkLe39Zzgj3PW1DWVVh8rkGhhumRZ5bsK9yQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpucqCeWxFu+QtWPkaNMawlX7WmSSrfwCwHePRC
 3FzO1KexnqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabnKghYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AUUEIAJiAbVOGweiJ4dVmS7jkhWQQAN+0PgRI1lbnwVa
 wBzfEvxk/nUDXX191/Xti6SeUZlrTEv6mqgsiDbS7fxr/sbcME/3Y7gBaIwd18zCgGDNKs9+ARL
 4zUGP/fKPsfor4D4CCRFbP9/w1C54UucI406X2tqPnss6wR6km5Xg4AezLt+8oNlejIF2S/8DNk
 6vdyacLaJ+coLAtxSrtWEk4bPGTL4ckLUV/II7kwdEtnIo3WE7VmKwOSyZ/AOdUDqVwe1aIUqJo
 ToiiMickTS2B+m1FpbPXD2pM2MezDL3bXAvxcJvpX0/x2ym2C5QnNjJoJyAMwB8q6KnmyRoKPzA
 7cDY=
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

On Tue, 03 Mar 2026 13:54:48 -0600, David Lechner wrote:
> clk: mediatek: new mt8189 driver
> 
> This series adds a new clock driver for MediaTek MT8189 and similar
> SoCs. This one has some unique characteristics compared to other
> MediaTek clock drivers, so there are a number of preparatory changes
> first in the series. And, as mentioned in a note on the dt-bindings
> patch, this is simultaneously being upstreamed to the Linux kernel so
> it will be a while before we can use the upstream devicetree sources.
> In the meantime, we add a copy of the dt-bindings header file for the
> clock IDs.
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/7] clk: mediatek: use correct struct type for infrasys clocks
      commit: de34c13fe303ebcd84b52c550f493bfa5215d6e8
[2/7] clk: mediatek: refactor parent rate lookup functions
      commit: 6616694539eda70a96c96dae2d9a5aa4ddb957aa
[3/7] clk: mediatek: add mtk_clk_id_is_* helper functions
      commit: 00b555a0fcd24050a460f1408111e0e300243b2c
[4/7] clk: mediatek: add CLK_PARENT_EXT
      commit: ddd72d6c01adfd889c8467983f58c38fec38553f
[5/7] clk: mediatek: add MUX_MIXED_CLR_SET_UPD_FLAGS() macro
      commit: 24c1d1a427873b314cf3159b75b3d155ea63ece3
[6/7] dt-bindings: clock: Add MediaTek MT8189 clock
      commit: 44640421f83eed45f1c5f8bde22cd4188a49a474
[7/7] clk: mediatek: add clock driver for MT8189
      commit: 5c8f4d33732fe64514e3b84799c86ebfe0e8c596

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

