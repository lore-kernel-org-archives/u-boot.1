Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AA0C982D3
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF0A880FE8;
	Thu, 17 Sep 2026 12:51:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J0ncXpECvgsb; Thu, 17 Sep 2026 12:51:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3B5B680FFA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789649467;
	b=PQ38MlYRXOJsQPSWlvJ10nwncKsqy47Vc/rWjdJoXGdw0jl4r3ECuoFlKlvWNIxOWZ6w
	 UWOtJ0ira8ma0mnAqdh+urWz8mgZux9ST3tjjef0C2ugorKPDwlbbdEnD+okYJ4rIhMro
	 oMFjiU334uRTTdv7Tn3I6mE81nuSIwkAIQ0K2RB+wZ6z6+lVXAIIuXecpiHnmoaACh2Wi
	 /b67NZNDJPLTtZK8U/7i0oK9xKrtUlrevEnXDuD/Aj9Mf9Fl9jytb6uMsugNNreyrcMb9
	 dbI+vSHeLEgEs2Q0lJb147i+9qF7mH8+OQp9X4Xt21WBoxy9XKTM9ErpOu/jZ1RvJdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789649467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=G9MN+CWEMym5QY0HIwgiMvVKFUzSfsUSgi2JNBBqufI=;
	b=bmmkacC9tAzon+o8mqN8EELBde4Al8kA+XrKBdyk4zuc37sJeOzvy5MdHQt3O0w9MYQn
	 u24mIBSTzZzqDWuQYtLilJEsHzi4fCVdP1SNSD6mxbT90JEKRnAAJ4iCNAIbLdBkqOm6O
	 FTNFEJW8CEld0PtQ2AtO2os0F5LzJks12dVyx/q976GUSTA2D7s09sglF5Hdi0r6k4miy
	 vxY9DwnogFPegvJLisdrq78KwoiqNaMtZtZhQD2LVqhacVLuPDDxDwLQhYwGJ3YB0J5gB
	 BxIuVdejS7RNdtvYIAFssHVmsxslDkEUAe3KPEB0fk9Z9W+nw93Vr9V/QDrB1TEbUUA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789649467;
	bh=G9MN+CWEMym5QY0HIwgiMvVKFUzSfsUSgi2JNBBqufI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LQtrsE68qIN0GQ4/at1yyd4k2k4WHe8QxzBU+dl8ZvLqCeymZJfr25gjMjuqbfljo
	 6+NTbthBNqSVZjiy0aBOnnUbZbOsgq/3Wsmitj+hHGPjey1fWA61X+SwKMIR8h2ajh
	 z78Kp/iI8NJVV573nfOzlTZM4KYxatyeDXNSzCrhAZAy5dF+hzqIm+CZggfy2mZDDA
	 LVa/xE6NN4t+lhcziSRvgJtMdCfVRlOfLWEJ1djcI6CtC1zzxS9YHXMdvIhsbsczqE
	 +ungV454zUfzePvntyus8xoMOLvwMk5TBABJpmKeq4Hpmc75smxenpCyUZUVFKF7c+
	 mhuONRf1x24Bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B5B680FFA;
	Thu, 17 Sep 2026 12:51:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E0A2C29B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D20F440815
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SrkI2DL2k0KW for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 59D0E40807
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789649461;
 b=ssRZTE8WWWd8BlnsM4NBzsJjOWvbL0MAhoZKvXqv8vmtCNUuNYMy3o5/v39UBKJjgP71
 8BZB+zE10EjET1cvBkJ3kEVDe4eHrJIdpxfRMhNikr21zuZiP8kzpL9IUN+sMHed+5iDA
 Lb/1PTn3uaPSM9DZE6njd0/Oc8h4nMz0yBlkargRqfXHOS9WkTS8ilnOzPpX+vsP73hoq
 e6ZtbVBMloUkiV11aZWPbWmBXCOzVwu1u9cajZ1up7RjVCVEjVbCPesTA0BUNI+HOIDpw
 kpMnlupQ5sMwyImlxJpyWiYkBECmk/T4f9d8aFq/8fYtgNaU3FHsXOb8ECBa6Ev3YLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789649461;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=G9MN+CWEMym5QY0HIwgiMvVKFUzSfsUSgi2JNBBqufI=;
 b=qkI+4SlHgwWyD0DRaPyfMJVyYgpcUNJry/s4u1t1r5aYPHOhK1/tiZQQxzlVjyn3o8Cy
 O41YKzFPXuPTzKWBLzMS755fRsIsWP68SDgQdFGjYRT8xaLWBL9pvoaDq/ZOlw0SP8pZN
 0ZwZfmtDzWhaWtcGfp2ZESqTGmUQSHNoBoJ3DBZ7KNXOvJK6Wj+4xjxkUE7XFIHHjgNzY
 wPggUQGXUsN/oIAK0HsgfBhbedIbQhxYyR5wEQihZi9LmiQS8/Pw+qNm/Qw7R9vWPy612
 j5EUB32PbwVhI4/RELi4R5zZE5CNQsxJxV6HYRmltsxvsCn+TgXKWCrAAct3p8Mi/sw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=T3wWGzPH; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=T3wWGzPH
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59D0E40807
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:51:00 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so5660795e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789649459; x=1790254259;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G9MN+CWEMym5QY0HIwgiMvVKFUzSfsUSgi2JNBBqufI=;
 b=T3wWGzPHYRlH2bGa2/+BsjQ+0SpG3Qa5SkLZMnm4pUILrv+aDFNu6RidNEE42Fa7LR
 9ZRXyjr6JwK8KuHr1vrn2vngKncfiL9ASbwSKVHpo9bO0046xhoQewiaYP7aNJNRKxHK
 zKqZoJ341ULqwGTqU39DC4qxNcAXDTWHypXTQkQae9j1qi1KhCu+6FRUOpz2eIxS1E4y
 9X5Tg+NLJ4m71t6d1duUoREpEISHdwCUWVvT5f4EcvL6gYjpCt+vKIEOuf2lKDd60hxK
 LplKisJio7Y6y9LLf6syOta2sKIFOquqpu5xGnk0w+O3bwnJ06kh8mR5tpoyz/BjcLET
 X1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649459; x=1790254259;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G9MN+CWEMym5QY0HIwgiMvVKFUzSfsUSgi2JNBBqufI=;
 b=iOQbm9CAxMZ3wjO1pRmTOrz5TvwRPMZ0wup25OPTKeHI8rlEEbVIwsoVVURV8vEWyA
 xZ6rF4t679z5RTXfQwQyATGUrbzxsIisTRgKAYdDTHUtw6B9cEW4P38ebm/iRLBm40wF
 J1wXuWFBX5hq4K5ERuhi+swzhRwo+tHyu+RnkhxppJHfagWAdCqkxrUk4vP0TK3Giuyd
 +yxdjsbyfejwKWWriH0+RH0a495lvUaMOVdIbuI5e/GZwOs945wIduIDlLkPCrW1dMDG
 glrT3q0iEcS9pqGa/n3gtJafV07sVQEMNomGloK/jzZUPIABMgXK5Ky4H4Z6XP8RrF0r
 yeBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBydNzw5Fsx1CL91XqslCvmVq+SawwTMihDY9mPwDullP8FN1lT4k/L/PSD2IoYaLftqkBULbvI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++npD7c8K2hePkQVEYPOVPcr+XZFucRRhpVC78wj3HZicymwcnTP
 bdEUrxPf/Dser+oOy0fLhsPLEEpROEMZP6PsLMubPJdOn9jOWU1OEWiFW5kLpGenlB8=
X-Gm-Gg: AYBFou0pAMUjvUf2XL9EA9EA0OsAnM6tMFhSjPs4bEm2q3rZlvlAgRYP6EY94IRs168
 /QxpL7qGl4VENbbhEP/7oyfhq8d5qRtTJrMPB0ZU3HutLciLcQmK7gL2rSUfZXXGMYethH/UStB
 bhlrCvmLmv9Ox8ON9mQLwecSxK7AgE+lCnjyVk8Y/fxq9HZ8yc2EuXQEEy17g6HUILrOu8A7jUK
 OkP1Y56ci3Gu6Nil5uueFzUHaz0zmi+Cj1B2wky0ndlH+TBSdYmRJkcQ78cpf0P4OprrWAd0tRU
 Xl1MuaZmQReAGoaCQJV83SXbfAFvHS3PrDtH3lP9uQ3oJ0H//8W/OanehXZDEF9olygRqdUwFim
 lxLi+ECxpDsU6WB5aoZ+m0I37O92fOQd+GIO1eqgxEAVcvit4dJ6oJImy3tXfED1dt4FptsWLZa
 bVOZXjf+Iio2A1qWgipK3CHPLYfQkfS07hjwm45oixLc8Ikuk3XDfkB9ep8vARmLK5P1KMYQM1L
 S0okadkpmHsc447Ley4mgQwXxrCReZfJ+VA8tDVXj3K6ipJeP1fXwWY782MSWbqsxbOG70DowUh
 G1cp7XuBSgnNbU2eboxfo/4GZ7kWBNNa+TTHAEZyjy3MTHztk9GFwug=
X-Received: by 2002:a05:600c:a14:b0:49d:433:c3b6 with SMTP id
 5b1f17b1804b1-49ec053a640mr79085205e9.27.1789649458780; 
 Thu, 17 Sep 2026 05:50:58 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f4e6sm88614255e9.8.2026.09.17.05.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:50:57 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 17 Sep 2026 14:52:04 +0200
Subject: [PATCH 09/11] clk: mediatek: mt8512: merge the clock drivers into
 a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-clk-mediatek-cleanups-v1-9-4dccf8ed98fc@baylibre.com>
References: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
In-Reply-To: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

The topckgen and gate clock U_BOOT_DRIVER entries only differ by
their of_match table: they share the same probe, ops, private data
and flags. Merge them into a single mt8512-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

While at it, fix the indentation of the .priv_auto assignments.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8512.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index a6fbd6376b7..6288aca9e22 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -827,15 +827,11 @@ static const struct udevice_id mt8512_apmixed_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8512_topckgen_compat[] = {
+static const struct udevice_id mt8512_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8512-topckgen",
 		.data = (ulong)&mt8512_topckgen_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id of_match_mt8512_clk_gate[] = {
 	{
 		.compatible = "mediatek,mt8512-topckgen-cg",
 		.data = (ulong)&mt8512_topckgen_cg_tree,
@@ -852,25 +848,15 @@ U_BOOT_DRIVER(mt8512_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8512_apmixed_compat,
 	.probe = mtk_clk_probe,
-	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8512_clk_topckgen) = {
-	.name = "mt8512-topckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8512_topckgen_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto	= sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8512_clk_gate) = {
-	.name = "mt8512-clk-gate",
+U_BOOT_DRIVER(mt8512_clk) = {
+	.name = "mt8512-clk",
 	.id = UCLASS_CLK,
-	.of_match = of_match_mt8512_clk_gate,
+	.of_match = mt8512_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.55.0

