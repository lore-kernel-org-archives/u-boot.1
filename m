Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6E1C5AC67
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 00:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 009F680CF1;
	Sun,  9 Aug 2026 00:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yRzLD55SA3gj; Sun,  9 Aug 2026 00:33:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FAC580D32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786235632;
	bh=ULF8NWtV7QCjWxj9hVw00KAwOuO47M5Gz/Q6SK4Bs4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TxyHrNNSunMkSg7DvSD/ueGD/dfS1DYYjyuesqqAkU18JuKwmtHt9lzYHBqDlUpPm
	 Breu96iaMv3q3jCQmNWVWIIPPqLpzN1PUqE1m9c06YtdNenKvribRa6sq8tuHlA71k
	 xQFfqxpwcDf2dOzrzCfv+QDap8yhtyj2yrtPE4KzdYw5TLKX29aAnStyw8aC32yJKl
	 Qs6PllbAzAZe5L9U2Tu7friW/2zkldrC19BUkrUdeRYTKXyk6fwcOeyWifyWGV5x10
	 jrm6KzIW1hygfngIThInzDJN0D/4aeeZddNNnCjd+1RRtJPZFryGvhp9wn3Po9Kixj
	 CjZ8pc9uw0y9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FAC580D32;
	Sun,  9 Aug 2026 00:33:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A447110E
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88684405C8
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gLYm7OB3xWvT for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 00:33:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8D6B6405AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D6B6405AD
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D6B6405AD
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:33:49 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c2020421077so104088366b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 17:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786235627; cv=none;
 d=google.com; s=arc-20260327;
 b=lFr0yi5uU3w8Tix+fJxUHQZjLEGCCtz3MKMaujb3cosgJ7nRURMlzQ65a/VmvXrXji
 JXmPOBYivztvwbUHHpcT2B1f0ZStMnlNgG0frXCQsGmpLw7ux34NA9erIdfnfurOLuvc
 dAi+2WA9XRXwO0/SLGKFUq1EiKaN99/zMO0wQg/In/JGz3MzzS/9ML0QL9eidGMBuFgM
 A+qj13oUU40RK2MbyTbAEt0sW1YGfjOc+q/2ucjR37nFVHbzNWHQgInbYSx1l6UPPtPt
 aGChS70WOy7jtB+6Yi8b8RgjqoH7wxppZ8gEd70ySWkdaDK/eco5dY0ThvUCWGww12Yn
 ZXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ULF8NWtV7QCjWxj9hVw00KAwOuO47M5Gz/Q6SK4Bs4I=;
 fh=uhXlZ9Z2T2QjpBCqLM42J0rDWa5ngHZp6/E0nOu6f4I=;
 b=X8baeqNx0lqlQrhMVIP27dKGk96LdavKBkvMgJrh6pFTTj2tDhGJzIW5wMNshrjAR4
 j2cyK4mWopPDzxUbumoip9M6sFFxj8MsX+miVYbOJjiy/uu7/zVoueiSaaPuqXTPQc2M
 4jKNipFprDtv16PWuLWONjDoyMeahV0VSUD3sZdscwpSe1P6fWDFBlCroCUq0bpU24nh
 W4tv6aucEKEdSmbBe4h3+ASKE+V0e4NUAkh5ZkTH9AEhhgeHF5DG3bin9MtLtXnQf8qv
 21yDtanVJUF9asHroP+6phW/4gaiqetsJegl9/gI/09iWL+tzon3XRrV/DFSMcO403p1
 ozeg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786235627; x=1786840427;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ULF8NWtV7QCjWxj9hVw00KAwOuO47M5Gz/Q6SK4Bs4I=;
 b=K6H3ZQgOYljTwWc6kutstpsr82OwqCEtCAWqOXIArdzCej2fBv4OYxO81PcmYv8rkn
 Wx2XK/QeQOCu5MZpHHGghIIo3s0+W2KbGzgWurxkwIgath2lXt776C6sPQ34r05fzEnw
 y3Gos+LJaag8TH4JzSVqllc1O3T6lPf6DN065Kb0k91x6ie+e8CQAx++EUsNMNUs+Lh2
 8IAIJjwGF9ESsudqdJIleAyFsCjft2Y/olag6xJJJMem7T6V9grUmbu6srNHOcXxjSpH
 xw55QNTjcslOUUN3O9cEgvhY4fzb+4hIrgov+gM4v6ZP/joGNHW6B2nRopKfINIc3lXx
 GFVA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqoOcQtg7b+A6EnvWWrL1TWnOlulKX6jsvDt2j9mVHG1A2XJAUIX8vaxrpyZa0Pu2RhFJbAIFo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyp+rHpTUAKmwnqSjd01sX6O8+X81Oi/v28yDpCrrnt5116asLB
 II+6Yuma8VTPLolElywsllKoo819nN/WasAP1BY+kzqBXG+TLQdYWG62WTdjDYEs1/ztcQgEqbv
 BN1kJwZle4sFnLSGaZ+9/3qJD+xzfizbw3NZtDbqo
X-Gm-Gg: AR+sD10sefgb+ivOiVaiedo1tUa5rxrge/yNzv7jiP7xUsEK63nTxW1MMw05eNJh4Td
 Iw/+A01Bzg70LymTlaWRutq11AO1dNeNfXYA4HB8njQAVIxBCKkh08D1Oe1ir+a6xEwqvzMUEjf
 qbmXtsgDL+X0nbgehBER72DwR+H/eMh1jbfwnCJkyBH7su5SMarACG3gpf8SOrkPvhl5DuD5h4B
 uqmbs34Uxt4hDYH3sf/SbavX+KYQUfWSHXgq6izOpcCu9W5SHx5K1pds16KzIEmJxsrXYvp85ox
 C72KFdnTCLJSUwJFpe35fMEs0R+xue5LtB52PvhqkyOP
X-Received: by 2002:a17:906:9c8c:b0:c15:f005:63fb with SMTP id
 a640c23a62f3a-c2039ad1e9bmr1697070366b.3.1786235627346; Sat, 08 Aug 2026
 17:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-5-jonas@kwiboo.se>
 <CAFLszThN9ivtWft4VcM6SHZ8-yorzgsOqyFSqVTgsxV_3oq7Rw@mail.gmail.com>
 <799cedbc-9569-4865-90a8-14ce779825ac@kwiboo.se>
In-Reply-To: <799cedbc-9569-4865-90a8-14ce779825ac@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 18:33:29 -0600
X-Gm-Features: AUfX_mygrS2zh5RKp0McM4Qq4cHMXBfjHgaVSbXSuECyCeQq8ARw0oOq4TUxfKo
Message-ID: <CAFLszThT8M56cC7NZ5EH+K6ZZiBNc0muECnnR4ww3VtDXBJ5KQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] clk: rockchip: rk3506: Fix CLK_SARADC set rate issues
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786235627; x=1786840427;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ULF8NWtV7QCjWxj9hVw00KAwOuO47M5Gz/Q6SK4Bs4I=;
 b=Db2GtUhb44BAU6RPEJIHSDRFoNAtI9lwrIRe3b4PhF4noXZY9AIZUVJNG/66Tg/Ebr
 DJ4SiHxVNvgLoN6rmt9sY6caXsHGRPscKazqWjOypNiqJt00L/e/7gjmrWt+C4SJIgx5
 xzCOhCImy639NyEr6b0tYYxdB6CJO5jx+B9/w=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Db2GtUhb
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On Sat, 8 Aug 2026 at 14:41, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 8/8/2026 7:39 PM, Simon Glass wrote:
> > Hi Jonas,
> >
> > On 2026-08-03T19:09:38, Jonas Karlman <jonas@kwiboo.se> wrote:
> >> clk: rockchip: rk3506: Fix CLK_SARADC set rate issues
> >>
> >> The set_rate ops for the CLK_SARADC clock in RK3506 clock driver
> >> force use of 32 KHz or 400 KHz rates when any requested rate is
> >> divisible with 32 KHz or 400 KHz.
> >>
> >> Adjust logic to better match the 32 KHz, 400 KHz or 1.5-24 GHz rate
> >> limitation of the CLK_SARADC clock in RK3506.
> >
> > Shouldn't that should be 1.5-24 MHz, not GHz?
> >
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>
> >> drivers/clk/rockchip/clk_rk3506.c | 13 +++++--------
> >>  1 file changed, 5 insertions(+), 8 deletions(-)
> >
> >> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
> >> @@ -440,22 +440,19 @@ static ulong rk3506_sdmmc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
> >>  static ulong rk3506_saradc_get_rate(struct rk3506_clk_priv *priv, ulong clk_id)
> >>  {
> >>       u32 con, div, sel;
> >> -     ulong prate;
> >
> >>
> >>       con = readl(RK3506_CLKSEL_CON(54));
> >>       sel = FIELD_GET(CLK_SARADC_SEL_MASK, con);
> >>       div = FIELD_GET(CLK_SARADC_DIV_MASK, con);
> >>
> >>       if (sel == CLK_SARADC_SEL_24M)
> >> -             prate = OSC_HZ;
> >> +             return DIV_TO_RATE(OSC_HZ, div);
> >>       else if (sel == CLK_SARADC_SEL_400K)
> >> -             prate = 400000;
> >> +             return 400000;
> >>       else if (sel == CLK_SARADC_SEL_32K)
> >> -             prate = 32000;
> >> +             return 32000;
> >
> > The commit message only mentions set_rate, but this changes get_rate
> > to ignore the divider on the 32K/400K paths. Please mention this and
> > explain why - I assume the hardware divider is only wired to the 24
> > MHz mux input, but that isn't obvious from the code. Also div is now
> > read but unused on those two paths.
>
> The divider is configured to 1 in set_rate path, so this change is a
> simplification to ensure the ops for CLK_SARADC works as expected had
> set_rate been run.
>
> The commit message already mentions that logic is adjusted to better
> match the limitation of the CLK_SARADC clock.
>
> >
> >> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
> >> @@ -463,10 +460,10 @@ static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
> >>  {
> >>       u32 div, sel;
> >
> >>
> >> -     if (32000 % rate == 0) {
> >> +     if (rate <= 32768) {
> >>               sel = CLK_SARADC_SEL_32K;
> >>               div = 1;
> >
> > The threshold 32768 is odd given that get_rate reports this source as
> > 32000 - please pick one value and use it consistently, or add a
> > comment. I suspect the real source is 32.768 kHz, in which case
> > get_rate should return 32768.
>
> I would also think it should be 32768, however TRM only state 32K and
> vendor U-Boot use 32000.
>
> Due to this uncertainty and how the fallback use a very narrow divider
> field, 4-bits, it is more appropriate to check for <= 32768 or rate
> may have fallback to 1.5-24 MHz depending on bits [3:0] of the
> DIV_ROUND_UP(24000000, rate)-1 when close to 32 KHz is requested.
>
> I still think this change fits under adjust logic to fit clock
> limitations.

Yes, agreed.

Regards,
Simon
