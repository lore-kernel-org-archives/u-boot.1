Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BA8C5AD2C
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1709605D8;
	Sat,  8 Aug 2026 17:39:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z5kmJc_OLUoi; Sat,  8 Aug 2026 17:39:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2141B6073F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786210783;
	bh=iTdrhibAsziBNINWyiyRqqmozTzUwBmGlHdaP8oWIX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eCSlhOGZCbNt+X7mxTYDIjZSF6/eI63rGzwe91P4BohUvScS9w8gAApM+XJOjlHNc
	 j2wKTtf/4z6GmobPV3k8aqvwl0NreQ05S4E77PWCwmo9bIPjUELhmDCzf9x+6c+c4r
	 DY/GBk1anCX4hDjopAmv9IPETOsp73tWGKgTpTA+ODXwVKwTIuCaVAgHbba74OkIvS
	 +pwWoAotBGYeDBzTPkgYbJcPusfshKBFecedQ1AvcoKW5JCKM71svo42dJ7xmWoc1d
	 a8RlMlFC3w67kCNhF0ETAFeiG3fE+yQjJnexKE++CFVUaCN5OB1ON/wa1wSiQG71/F
	 62me0y2WR8/Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2141B6073F;
	Sat,  8 Aug 2026 17:39:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DD26E296
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB3076073F
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:39:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jP5CPNZ2XxqV for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:39:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BBDA46078C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBDA46078C
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBDA46078C
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:39:40 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a1b51723a9so824148a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786210779; cv=none;
 d=google.com; s=arc-20260327;
 b=RZJVZySprL6GMdNoHpI9jt4fprX3f2BOQNngLQjiRv2o5k2STAtMoiQEuB/u3C+XPT
 sV0DPFUGXXuMTGQeKqNuvYimRQCzYC5305P/SmZSU0oXOo8on6wKwsCB6g99f4UE6mqy
 KpOH4fiAbaWCxwD7d2zo/p0Tesz2MedF14QvUVKZRyQc3rfzXwKhTJ0njYnu+mNh2IFC
 O9zw3Rf8k8LnYcaee5yXyXxvO9jiM09dWM1s6I/MC4Rfz6qvhewPQYrma82KsCIVGGqR
 Ino9+1F6lUaXzZ+oGCx9Kg2y4vd9fINIRFYdulIc68IuwLE+uurDxt4ml5qpt44PNNtN
 cQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iTdrhibAsziBNINWyiyRqqmozTzUwBmGlHdaP8oWIX4=;
 fh=em4dZjraAS33t+1gqYuMw/xp92wGIl21I3NINTg2Owk=;
 b=iA0ck3jzMvhYI12C1k2DQ7nUrVgui+TJZLyhKHHKjoYvDBlr+KyUVPMguKzjuUPBAR
 /oI8yf8xHQxGxw7PuBQgQBayG+Eo1V8kl8UHoRdY2hyTYZmDbF4s0mESw5pVQYYGQF+H
 T8OBb+pPehqDltutDfVjMwAPuhj4BWimahXwY+8Q36JNovs/3bHvnZ9j3oNZ/uKnGXvX
 fYibKQSpT4MWeehh5Bvgh5qrS9U1xDfZ00iQzNFDSkcMSelM67LxLQW4+DR5IzeQWtLy
 MPl6bYXAC3FOWBVdvtkXV74ZIvkqVJdaD8zvqVvERcYXDTFdatEu98UECiYGBoJqw7Uh
 8BFQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786210779; x=1786815579;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iTdrhibAsziBNINWyiyRqqmozTzUwBmGlHdaP8oWIX4=;
 b=d3oqYkAHQnNrdwDcijwv2tlKwiKvHbJecqLRnYXcvxgctOnVMXKmihO9yoGhWgQ3/X
 fVlnl0vSRAogMoRa4gD8cn1d9MB34AVw3K5MLbG6OQ6Zow7NshCDnqNA50/3ikKud5O5
 FzUM62uDSaP3BOaaxlOqmaqOrLAyKpwDbwsPtVoE/B0z4hakSE2WKuv7uJVMaE0X9Fy2
 K6uWVpfUj+oBLI3tsXNs8m1iJ1Im3dU+kWtr7NH9HFKG2cg7RWaZ+sdNu5GcE7Anl+Yq
 JjAw1xVjBwb67yOSHtQb1/ZE6f+XDaYXNG9ZID4K/NbcxxoZPm9whCLImiNfI5Q6v9EU
 YQCA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4XjgF/ZMOo9I4kIhkjLJsTOKqM7OB4bPKJQx3QK3OEdYMPvap2IpPdzK2e24bArQG4HvQTgM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy3RvIfcJD80r6Qh22mM1p8YuZxAy9DoVVDONx1UnecphGiDyPg
 +P0lyAJ7hw1/yfO74/HeW11Bc6lboGVPQTk/iZOmzlyQUb5Rek2ZrQo6hvQmx3DoaTzdZLF1YXV
 K8acswDqnd06FYXASd3MuIhl0xA9NpScTCR0wXpTu
X-Gm-Gg: AR+sD113qLhDNITBx9saJZ/TZlGsCDVIV9HFKuOcK2FtXTVPcl/pdbQKlU1Dwh52/1V
 Vh5dNq7LiwNChhwQZh8/L4XixOQB66gB4oVDHFI3TFB1RpkLLN8u/fi2tnL8RggIdk6j/YkS2Eo
 Kyrxju5WK+a2LIWM6aa7jZ5wiLz3R54gcpcjaXUiD3KQQQ0ZH3AppAny0LJ9zUp71WdMeGZrIVd
 arrSidruIaV2VeEqDgZVCmjuub86jy1IMUWZN5tJGk18mvBUeR2xfyiEfhWHwOwZGEF2HJ9R1R+
 mKBmAU1aSoErdij1cSmxaR0ND2SYXX2Ag+NZwRR6Jaw=
X-Received: by 2002:a05:6402:241b:b0:6a1:c908:1701 with SMTP id
 4fb4d7f45d1cf-6a1c90819c8mr7627304a12.13.1786210778887; Sat, 08 Aug 2026
 10:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-6-jonas@kwiboo.se>
In-Reply-To: <20260803190946.2259514-6-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:39:24 -0600
X-Gm-Features: AUfX_myat9alelN5eSe_BDTqIHR8ZYaAd7Iiqydu44EU0RQ3DmuUFPayEgWTn34
Message-ID: <CAFLszTi07unpXzmbnAvZBnDEoz5VMFu=Em2yz-Fjja-9S4idMg@mail.gmail.com>
Subject: Re: [PATCH 5/6] clk: rockchip: rk3506: Use FIELD_PREP_WM16 macro
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786210779; x=1786815579;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iTdrhibAsziBNINWyiyRqqmozTzUwBmGlHdaP8oWIX4=;
 b=Y/VEnGR5UDig1dnLMEsi5CG+EcyZ1J39tyT6zJrO5G2COUcHttb0Kwsyv1o92WItUy
 9hwD4Jnu7q/v1BomfWn5fYdI82tpx/FMDp9BYLy3ccst9+t3pF09/TNQ0fJUsCA5AT4d
 DeToT34vm/Ruk012N5X4veTtNJmxJrMLKXosw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Y/VEnGR5
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

On 2026-08-03T19:09:38, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3506: Use FIELD_PREP_WM16 macro
>
> Change to use writel() together with the FIELD_PREP_WM16() macro
> instead of using the rk_clrsetreg() macro to avoid having to define the
> mask as a parameter to both rk_clrsetreg() and FIELD_PREP(). Also change
> to use u32 variables consistently.
>
> No change in behavior is expected due to this code style change.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> drivers/clk/rockchip/clk_rk3506.c | 195 ++++++++++++++++++--------------------
>  1 file changed, 90 insertions(+), 105 deletions(-)

> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
> @@ -485,6 +479,7 @@ static ulong rk3506_tsadc_get_rate(struct rk3506_clk_priv *priv, ulong clk_id)
>       u32 con, div;
>
>       con = readl(RK3506_CLKSEL_CON(61));
> +
>       switch (clk_id) {

Unrelated to the FIELD_PREP_WM16 conversion - might be best to drop
it. In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
