Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D756C5AC67
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 00:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8785D40581;
	Sun,  9 Aug 2026 00:33:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yYqdG93-EUZe; Sun,  9 Aug 2026 00:33:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26E4740586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786235626;
	bh=Jz7pcek2E+hfxjw9lIxEcxKh9CW0+iJPs9eYh4bucBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fsoREwWvDC6sSoBXiv1rYsVQxnc0RDmKX4q5y1Taq+XJ1wPGwQ8gEIHJEwaaT2vYF
	 Yp4TXWe7EaapCzhi+alHjaD9FaBq5L36H8w5yzU7anZM3eEfZd0G6eMl3jaerR9ZFW
	 r5HuPi4EyN2nO/EeYQwHy2bmWwn10bYM00ajeEi54N/nSz9ZGFUnenbOSHik7Uq/HK
	 2sZ4XixyDmkblITS64mh0wvPx3b/ECsrvhTMzsalKl3oYhCOKIuE1s3Nl/EZ4GjXYa
	 I0PTGvjVPiSyjc+4U9CHh4UVawaV6XBkGgTR2wpoabSQVe1fA2P6KoxWXzHxJ1rQ/K
	 BP/jepzTMIM/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26E4740586;
	Sun,  9 Aug 2026 00:33:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C1B5E218
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7E7C80C50
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:33:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-1gdTn4E5HZ for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 00:33:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AE0BF80C97
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE0BF80C97
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE0BF80C97
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:33:43 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a1f7f42510so604045a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 17:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786235621; cv=none;
 d=google.com; s=arc-20260327;
 b=UM7YyRt5HIxiQW9DUDtY2wagMPRafx97588YLjcR1MC/PNXnn3ALb8dzhARrubhRBB
 gW8o2f+HwmW3KXk7nB9Hz3OZ4XVuoe8VtlNv0ORQoOXaBbBntSO1wLU9SMfuMQ1WIXrr
 dwesnOXKn0WBud3C47AbvIOgUT3w5T1lmrM/2lzQooKK/WK0D1n54jOcL/Nt13C+Ti69
 j9e9tgZRHpP2hEtR3N0RIgqCq2fCyFf0MfEhhCDtk/OpW9U0t6ayD+5UL9nRU8LOGaNS
 B9d5IGEoGI86p9KEpjj/Cg5JfMv79HH4Ut8NVWVfpv1QwNhf7hdHk5N+yUCI2mXguuKg
 8u9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Jz7pcek2E+hfxjw9lIxEcxKh9CW0+iJPs9eYh4bucBk=;
 fh=IeWDZbMZHLG50sCSck1e/BQGPLuLjH4bkP9gPiUSN8o=;
 b=IXdNTZW+YvzQyDwYIPrcxL78W018BnsBkoFWZQx/FaKFN35tpeC4QWpviYv3LdS+QL
 U2xDFTd7fgN3YuZvLlCHHItd3ipd9sfDVmmXENjPRFE6wxKq94NZA721RYHmWWP1DfhJ
 2250zR4t8JCtHd19jWGyvDutkZ2uy3Th/1OtlAvYi4mZNbkUjVJcLgGaSdl2DRqkKMV1
 TMeTuyETln/S9XoQBx5W5ePsR3yi8cHBrt2znYa76aQUTVqEqRKafKRAGElel+zebHMJ
 PX0ZTqGnZhHJNQBjAljVhfrW5xgn4L3jYEpXK5y2iYWdggp0my77QJGnZ/r/fIDzajau
 APHQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786235621; x=1786840421;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Jz7pcek2E+hfxjw9lIxEcxKh9CW0+iJPs9eYh4bucBk=;
 b=WwZhlcqrJZQbpSDMkPhlmcWTpBCPTLbXKNKBYjBv0mmj9aTMECl/vbeN4Cf1ZFJ+c6
 JEFPiJYBPskoRUdVzRTEcQxqawWfTOBXYwnEXIg9Vj5SKwKX3wgifDk8j6ovPPatn9WL
 hytJr8nZxjTTfWjAYbKqPM3RYdYTs4Uf+ZLSsxwFOdsvcAkeWJecYDbANb3qp5B0c4TH
 XVgu8ns4W5vgVUS/BjbHI/pJgt5sTMshVXLKD0ECoJ6ZWr045+CBbGxfW5iOY/rlXw1v
 LzPepb5f9xHVjpT9PEWFPbOYZw4FA4uSn/mqHMhbcPHUQWJQr6iiWtwUTYEAvGnmDI1J
 /Jng==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHI/gEP7+6dOaQ9NDI8bgxH3zoLmBcG0NwgkwhieQs0+VCuKSg+9lIXF7t/xFNfMtQtQFwruI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyxfo5FxNLTxkbgKLBy/gjKvlDrxXvHMK2MFQvTTg1+Ra9Z6m5o
 8ZSM69vR+Mpqsokq6Hfn/2WMESXRFUgxVXKkMOjwwT7J3Qj50PUnhL7SB1hWdLX+Ak++uR0kntV
 ub2Yk0yOE2SEoiDTkxzSXOsfTIogiPMTtiYY9HcKl
X-Gm-Gg: AR+sD1090egbHbzCr8UjnFkRne9zoy4P0PunOBIjYbKrvll4jfN0ODIIyEv939eKdPB
 UYzJJMjXNcat6KA+w97+RHbmg9rRFGcWqhLrJP/nxyHXhQJQUESb3qLtkNbbtZsBp4r/xHKiqDd
 8kW1NpBr6PK9BDKPRA0YixSQZib5wHMgIxHNRcyg/HGVDOZ6PVMvHgUAAaH+n9Q/M410CQh/PDw
 cVVIAqUSMSyTGJkYAD1VZr+nXw4H7hdygi08D7inPBjNw7QsT2DYDrG+bHEMtzV6M5nm8Myuk43
 jId5dFYECKtwOel8z3Uvz8VDnzJ7asDMk1XPlDOY0UQ=
X-Received: by 2002:a05:6402:2394:b0:6a1:7718:ad44 with SMTP id
 4fb4d7f45d1cf-6a17718af13mr11409291a12.21.1786235621504; Sat, 08 Aug 2026
 17:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-4-jonas@kwiboo.se>
 <CAFLszTi9GQNih7W338r2PtfNJoY8TEgCqTNKT=6rCbH67MAefA@mail.gmail.com>
 <c5f7b272-1724-4a68-8efd-a6e5dd010741@kwiboo.se>
In-Reply-To: <c5f7b272-1724-4a68-8efd-a6e5dd010741@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 18:33:27 -0600
X-Gm-Features: AUfX_mymTJIJLKfalP_BDzHTIReqpuEqdCdT_1IDjl2ugejzWomgY9m4rTmH14A
Message-ID: <CAFLszTi4c4e2ND9Y02zy-g9csiMq-Ls02kqTqMdQEKpB6aOqcg@mail.gmail.com>
Subject: Re: [PATCH 3/6] adc: rockchip-saradc: Add driver data for RK3506
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786235621; x=1786840421;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jz7pcek2E+hfxjw9lIxEcxKh9CW0+iJPs9eYh4bucBk=;
 b=ZOtW5oU8MQhRFLwu1X1pW/C/2kZEcJLA3GyItCkpLPLdLP/7O2PhINw6eKZNBSwjdO
 vtUHza3oWslfoNR7xPCLbG0R/W7QOLyjsfF2s5CDC9spnRvYlghaq/4zyK/7tUUinYib
 25UinUOVrr1VPvC4oHMA9VPb2RSNtypqTtLgg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ZOtW5oU8
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

On Sat, 8 Aug 2026 at 14:20, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 8/8/2026 7:39 PM, Simon Glass wrote:
> > Hi Jonas,
> >
> > On 2026-08-03T19:09:38, Jonas Karlman <jonas@kwiboo.se> wrote:
> >> adc: rockchip-saradc: Add driver data for RK3506
> >>
> >> Current rockchip,rk3528-saradc fallback instruct the driver to use a
> >> 1 GHz clock rate. However, the CLK_SARADC used on RK3506 can only be
> >> configured to use a 32 KHz, 400 KHz or 1.5-24 GHz rate.
> >
> >>
> >> Add driver data for rockchip,rk3506-saradc that request use of a 1.5 GHz
> >> clock rate, to avoid clock divider overflow in the RK3506 clock driver.
> >
> > Units look wrong throughout - clk_rate is in Hz, so 1000000 is 1 MHz
> > and 1500000 is 1.5 MHz, not GHz. Please s/GHz/MHz/ in all four places.
> > Also 'instruct' -> 'instructs' and 'request' -> 'requests'.
>
> Hehe, you are correct, it should be MHz and not GHz :-)
>
> >
> >>
> >> Add driver data for rockchip,rk3506-saradc that request use of a 1.5 GHz
> >> clock rate, to avoid clock divider overflow in the RK3506 clock driver.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>
> >> drivers/adc/rockchip-saradc.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >
> >> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
> >> @@ -339,6 +339,14 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
> >> +static const struct rockchip_saradc_data rk3506_saradc_data = {
> >> +     .num_bits = 10,
> >> +     .num_channels = 4,
> >> +     .clk_rate = 1500000,
> >> +     .channel_data = rockchip_saradc_channel_data_v2,
> >> +     .start_channel = rockchip_saradc_start_channel_v2,
> >> +};
> >
> > Just to check - the other v2 entries (rk3528, rk3588) also omit .stop,
> > so this matches the existing pattern. Is that deliberate because v2
> > hardware auto-stops, or is a stop_v2 callback missing? A brief note in
> > the commit message would help.
>
> To my knowledge the v1 needs to be power up/down, hence start/stop. And
> the v2 only need to do initial configuration for single read, and the
> interrupt is acknowledged as part channel_data, after first waiting for
> said interrupt and reading out the data. As you mention this is just a
> copy of the rk3528 (fallback) driver data, so not sure what you want me
> to mention related to this.

Well it makes sense now. Since you are redoing this you could just
mention that the start/stop is not needed.

Regards,
Simon
