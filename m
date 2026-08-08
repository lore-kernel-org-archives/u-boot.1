Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051A9C5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C414606AF;
	Sat,  8 Aug 2026 17:39:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dU-RcTX2E1y8; Sat,  8 Aug 2026 17:39:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 55A79605FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786210771;
	bh=dfLBBi55/tT8acwjmAz7jsIlmF5SltZOzK4gnr1nv6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UZdsUQfPWH8/GzgJJYNUcqzbiOf9uLrKXgwy2KTNbPyDqrNprVMQ87og739W/Fs8q
	 GbgLVnzUVUHjDaqvojaPKnXLO0xRZkUHr8LqSyMBEf/yDf4eJZ5oRn+Z4boXkvkjkH
	 rMhP4g+U+bgWLPzhJPmhcBe+YqfpmkpjbJV6+7/H6BGwaUYo4q5WWpQyegh+id09RB
	 IlX2hzKKfcibRsXlUKt2SwRr7x3iLkw20De4JvGi8XYE0dw/xMUhzuPBiI6rjVL4hs
	 E+KEBoo5ygALA4XsbV4sMUam5896c9eWCSWjhPIX1SBTPeFqbdnOsPAqocOchKjtj9
	 XRaXCKA6j9qpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55A79605FD;
	Sat,  8 Aug 2026 17:39:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 91C57218
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83BF2605FD
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:39:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o55R4thIcTxx for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:39:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7F528605D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F528605D8
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F528605D8
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:39:28 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a1f7f42510so457728a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786210766; cv=none;
 d=google.com; s=arc-20260327;
 b=dXNy3BF9J1NFtbI8hbQh/7wJfZPil4RVETY/ir0Mg28CKynnCngd/evy11+Hyvou9+
 bFSQpvoNQBJ6YIwNn4lXZJH2Gt8RPog+4BoatK5lXrVLMyEHkHTe9137KOxSkn6CcrRE
 /0eeyGk9fvZuh3ARoVmdSPe3bPDosAcUDKW5t1FC3mmNSbVvJtIiyB4KMDdole6RWfyG
 fgpV4CYPwrxi7MB1weFDEk6g9VW8e7qYGsZU+p9T8J4moiy6taoTNd2YQUVQ7JGQ3J52
 WNueNsuytFFzzUUmOy9xIWrgMUBlbUfgUBkBCQTvbaUpUwLaK9SSIiLIkNtQ0yBzZ2vC
 uKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dfLBBi55/tT8acwjmAz7jsIlmF5SltZOzK4gnr1nv6c=;
 fh=p1OkXB4SUn+UNVrgWooW1WNDAErRXY1lH6yAG2CEm4o=;
 b=RYo4jxFUYu6ith09aZN4Qry8MsNbZBh8AY1FBpb+42s5+UhQmWKYPsPTZZVocUsG7O
 gQ985AhGPjVX3xNgzU4gVcD5YwwqaW88BE8HwC81cXI7/3hw5qVvmfevU9KRZC4GIFsV
 f+UrRR6FHZ41vGpVy16Dnpvoe9hBvpnSO0KL2VYoLybkHA/9Ci72dw9Qc0dMRl1Elm7u
 Z7+xoZk/IKOEd9U0uNiadLg3UijvkzF/gs13DRpLtLvMW5yuaUAihfXuzuPOBy+y94CY
 dMJZcltjveyb8fL8I21JpWxdUbwsMLdP8OLz5vsRYt3r6Ys4iYvtbJ5NZMCJgnZ5J0/5
 WjwQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786210766; x=1786815566;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dfLBBi55/tT8acwjmAz7jsIlmF5SltZOzK4gnr1nv6c=;
 b=shzN3N9gy6l2Tnu3oV+Dy7Cn88qP5Xfb7gXr/8ZUekHxZ5FVqYtZQ2OOPI7hxOyf+D
 MjVm/yHibK2K5O9AArWKrMAzWCk8p3yw6EF3cJfgIvtc9hJTGl+1xYav1pkbqQt1T60o
 eOvHA+/rr5jQQBdQAGIoZgm1sjXgO8xK1l/TNhIdQRuq2x2AsQDCIZBEsNj6iFb+34md
 RXnclF03imY8i2Iu0hxPFTMqQzUKJBwV2LwS3Q8vruYZYm5egOJe38PU5yLUsxkOnALx
 haBDQNd546jaPwLqn9Jn4QKCdq05dhyPq0D6tE2FedPgTno3WFdvIBXueDdE6cZRo8G7
 C0AA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIDR0R0s4Cn1e21cFwaV5swFoq5WNjKnwqOwvgqvoSkGm8FrrnUYfr1utnTI/iKsNAsrxXjO0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzJ3SFyefsyx0gYmoARfsTTZhnCLJ3lhg+uEnrkVQb0WkjikHu9
 VqdDhL3YIlSueW3A6dg4aKFG/ky3fP5olB5MRv62/oAhSt8P44Qa8W77CfKsOFAjHx9tU92JTmo
 FrTjZlxQFzcqYqXYEudTzUI/v4JSLr35khLJfizS/
X-Gm-Gg: AR+sD13QNjL81apKpW+164upxO9mp9qbV9NDJs8rHX7mctEe/fe9VyMONmdXQTu318Y
 BT/jji11kRy7nrtW4Hoxr1VDfLXF3lYntsHyrVQwBzHNmhJTZd8Tc9cfMBxMUtVgC+TK+QwVrv0
 xT0K4yX2OLDNy2QQfO2V/uNmu+I8h8sQr/bxq2ECwfx+ldMrDWEQUm5IbS6Y69iDogAYGDTNHo+
 CP/zwHBwPrpfi85Z9xWLA1z/5Azk2V9YWe053PG/UQIOu2I+uihiHWKvF1SGdeW+AI75FkvIkaX
 GlXtPs9qWW+9VX2KCVNb2L4vOiZBYgDp/cB1HWjKm58KwQJeOthBXw==
X-Received: by 2002:a05:6402:278f:b0:698:af31:5a9b with SMTP id
 4fb4d7f45d1cf-6a14f0b8fa8mr15106159a12.9.1786210766268; Sat, 08 Aug 2026
 10:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-4-jonas@kwiboo.se>
In-Reply-To: <20260803190946.2259514-4-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:39:13 -0600
X-Gm-Features: AUfX_mzyEgqBr8r4qCA1bIPZAhnO0JkCG3EWufKs1gFztlws3os5CWwArwDc-wQ
Message-ID: <CAFLszTi9GQNih7W338r2PtfNJoY8TEgCqTNKT=6rCbH67MAefA@mail.gmail.com>
Subject: Re: [PATCH 3/6] adc: rockchip-saradc: Add driver data for RK3506
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786210766; x=1786815566;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dfLBBi55/tT8acwjmAz7jsIlmF5SltZOzK4gnr1nv6c=;
 b=Y2V09puM3LzJ6+0359HzgD0OZL+omqs0FNLWgJbYLGTChQCA1vN3rMuA04UPOKqT+7
 Q1ouiLLnYMrJ9rb1cgWQC4Rz3cCQzPL2I1Puyvs0njldzLfmg1GhkfAo2WubZAE05z5K
 i99Neh/IYJJ+bu8Rk/KlKcq+i63DnrjsY5KPw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Y2V09puM
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
> adc: rockchip-saradc: Add driver data for RK3506
>
> Current rockchip,rk3528-saradc fallback instruct the driver to use a
> 1 GHz clock rate. However, the CLK_SARADC used on RK3506 can only be
> configured to use a 32 KHz, 400 KHz or 1.5-24 GHz rate.

>
> Add driver data for rockchip,rk3506-saradc that request use of a 1.5 GHz
> clock rate, to avoid clock divider overflow in the RK3506 clock driver.

Units look wrong throughout - clk_rate is in Hz, so 1000000 is 1 MHz
and 1500000 is 1.5 MHz, not GHz. Please s/GHz/MHz/ in all four places.
Also 'instruct' -> 'instructs' and 'request' -> 'requests'.

>
> Add driver data for rockchip,rk3506-saradc that request use of a 1.5 GHz
> clock rate, to avoid clock divider overflow in the RK3506 clock driver.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> drivers/adc/rockchip-saradc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
> @@ -339,6 +339,14 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
> +static const struct rockchip_saradc_data rk3506_saradc_data = {
> +     .num_bits = 10,
> +     .num_channels = 4,
> +     .clk_rate = 1500000,
> +     .channel_data = rockchip_saradc_channel_data_v2,
> +     .start_channel = rockchip_saradc_start_channel_v2,
> +};

Just to check - the other v2 entries (rk3528, rk3588) also omit .stop,
so this matches the existing pattern. Is that deliberate because v2
hardware auto-stops, or is a stop_v2 callback missing? A brief note in
the commit message would help.

Regards,
Simon
