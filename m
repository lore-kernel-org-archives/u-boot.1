Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED443C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 14:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53DC780E65;
	Wed, 29 Jul 2026 14:23:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v3750DirGDHM; Wed, 29 Jul 2026 14:23:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7448A80E43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785334988;
	bh=4FRxEURqlaWgs++lTqoE2KIWnhh5c/yhZJAXSx9VJmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hyQtoE8F73plRAkOP55vtjprjwImZR8XWeSdwM0ANQTni0FMSUNpLPWcdaKUUil13
	 d0wY2k7EWHmyEa79gj65JLx/Ha1yCkd30+fjwEwz5hwJfbR6uhGUX4vImPCnK7NbeL
	 7ATZWghY7EkOqOjT5SCIvGpNlvvt/7pcBkQRGjWx6Y1i7OXs+z3PE8Zq2VCafa7lW8
	 69YsGYIAqQJJ//Ax78t2fmIS8/6mrXs1OOIYPaiEuB+nR9dzIuwHt8O+oWSfxcwyFA
	 WyIwCjZGTOtLPcighsD2qhRmi7MeeGX3sNbvh9pj6R/+/leaTuXUQL9dVJH/7+HJvk
	 /zuJHOLPPwF4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7448A80E43;
	Wed, 29 Jul 2026 14:23:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C9C793B1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB4A06060A
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4QJRoJJbOThx for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 14:23:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 537DF60609
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 537DF60609
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 537DF60609
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:23:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F7628494B; Wed, 29 Jul 2026 16:23:03 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B952982991
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 16:23:00 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c15e03c2763so188329266b.0
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 07:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785334980; cv=none;
 d=google.com; s=arc-20260327;
 b=CS+1jvhUV0y+Kve8DtSHv6RX6sviRtUqSy8Zs5ckK2Waytz5QRhaN38zhjwHkqLp/3
 77PwZ+Xd4NC0b70n0n74PVas73CN1JCF1XLI0HP98BpBqK51TYlGsum/N35+1FMf6DMq
 qbX70nv7/ab1ENNvrcZOWoi6eS4sNqLP3oMPNuQps/BruL5wX5+g/8hsLIv5IXN54wNp
 8u1k+pImPILq2ePLDsT8NH+UTketiAxnr6MBB2HSL432YGnj4q1KE/baaLvEwp7Na/4R
 mi2IHT+RHdEanUJBOAiywwkuDU5ksM43N8q40ir9rRuLxJX6FPCV+Q7PMRLHZsob8GkT
 brBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4FRxEURqlaWgs++lTqoE2KIWnhh5c/yhZJAXSx9VJmk=;
 fh=K663HywGznuJkoJlEa8tCn6crA+DM6R47ZAwn7hwWr8=;
 b=MS93jWu3TFkAUXkJ9S63ZvnRPpF9sVxpincKLTs5hp8zwTuF2t7d4Qdowm3ZNVWybA
 0pnrvSzBb96AVc/8ngwTOjoibkSFdBMcP3i/69qt8/x31S2VbWNNly3/A32ogu4uN259
 tx0x1uo67gz05mAlPeLj/Lmukm6KY6wshMke9NH2ZxpE5spQ5kPEJr0CQp7Ce42PzGSG
 KvBMlKbmUSTDaLUpzzfb0wylVYMH/l9ZS3+D0UZ+iX+NdoUMakZjKs40pa7A/2JEHya2
 pnssKSf/UaU5Ufia+X0iXriDVnEp9EyjWLqB0nvYpAPJ91X2M9vRq7MSyCHaHo5O/hb/
 hCqw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785334980; x=1785939780;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4FRxEURqlaWgs++lTqoE2KIWnhh5c/yhZJAXSx9VJmk=;
 b=VdSFOAu8Mr6MGO4Vjs1gIKjZZ2INMjr+YXP365z4HSVukZ91INkEohdKtUxfLNJ3rx
 +RcJ1V/LAK6ieYZVHf2OjOJDp3RQW4Nh+J8jATaPdmWPNrDZoEDKmSN+HQwTyoFcVC/Q
 COdGZK6/z8bZZY3Kpk0OXG593sULp1LnAbhRmnkj0gnJZwDf/CmZd70LZHgiormiL2gg
 ZWqPjYJVgLQZdqM+aeBSTWACs1s5rsl6HWAC/vCxh+0jLFw3ZuHzkHqUkVRkOHBiDwCn
 YRH9My7pQEvIetbxtl9Szl7vtli7bda7GdZ0JS3mtsLERwm/oiI8M98K04uIqGAf7tK0
 vaaw==
X-Gm-Message-State: AOJu0YxnY+jnFs+DCYBDiMdcNo7MADLdNqZ6Fdm5xgmxI5r4w8RHG9Yd
 DfwuVTEQRmBL5TPmS3YihpWvVpCDh8USkDI+BaaaQqz3hbNYsb45+XTamr8isaFVXhwBJ7txMj1
 XQ9ahapk+m1uSYwRfYf2aUCpX8XGOT/y+hJzkXuw6GTJlODlUrXrIqT0=
X-Gm-Gg: AR+sD11u5ToNDkOVYzvnVqqcUOgNjnluzg0etxFBG8dPlr48HfO4EQ11wMlt8WW/wvU
 Y434EMDJccgSNfqTulHx4+9hvOHcAHNs6A5KcMmw65PItwh0ErCPwRCPj8X1q/MmiaJGECbYQuT
 sE0TojDZrAw9UOKnzDhJpn15JMbiMZ9K1gZ52SP4zkM1NDDXxZXLSSCZ4s485Du0RraOniBWMvt
 qEbX1XCM3OdpgoKS1tKJAtIM8jzXK3Oy/ChRKgzgveWj9n5MOxzPXCA+raMzALtcCWmvEdLLcNm
 ZT9B1KgVbQU4OxSWiir/aMEbP7MZmI12gYJFv5vPAtaN8k8Rq+VSz2ddUMCYTHI1JGIO31WNzxY
 =
X-Received: by 2002:a17:907:f497:b0:c16:aee0:5422 with SMTP id
 a640c23a62f3a-c1f8cbcff84mr159030466b.6.1785334980087; Wed, 29 Jul 2026
 07:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
In-Reply-To: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 29 Jul 2026 18:22:45 +0400
X-Gm-Features: AUfX_mzCKCBoLTuo_syPPX9fq4n7WKQI4DHCBE1NJpPL1u2tl-r7fRRQ4vVQO9g
Message-ID: <CAKTNdwGXzbNSqDxVGi6Z0+MrxYbBkNhM60AcUxV2=Q-PCO7R2w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] clk: rockchip: pll: fixes and simplification of
 maths in RK3588 frac PLL
To: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785334980; x=1785939780; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4FRxEURqlaWgs++lTqoE2KIWnhh5c/yhZJAXSx9VJmk=;
 b=5oLPXl31oBMiYZS3UifVn/uWNpztdWZL2j72ESboZH37pbp5oh3moOSLOtP1jJk6TL
 +MQekFy7zfrATEMQ79SphfA8xHRLZMoK1blJ2qGVWMOtukyaajlWvmTzkIhkqhvEI6vn
 O1lSklEjrZpiIzTZl8DEewppnvotcCoJ0XzkxkBL93Dd5CLq1qBpHtJAVmp86IwDTNgg
 ZUqBhCYT8RoocFGS0FXo3fVtKjMkkeZ1pxPEFOIZIxwiofIgSpb1vDvtzoM0zoKi1udM
 u3P2twdLIQ4DFKKJtr9e8MIqewvQ65Uc29zlq2urk2wyGSb4SwczTJ3hh3lu+siVVyNz
 gBCg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=5oLPXl31
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="5oLPXl31"; 
 dkim-atps=neutral
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

Hi Quentin,

On Thu, Jul 23, 2026 at 7:04=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
>
> Current fractional PLL code for RK3588 (also applies to RK3576) has two
> issues causing it to overshoot the requested frequency for some negative
> values of the fractional coefficient: one due to rounding, the other due
> to treating -32768 as an invalid value where it is actually valid. It
> also overflows the calculation of the fractional PLL rate when reading
> it back, causing the function to return wrong PLL frequencies for non-
> trivial values of the fractional coefficient.
>
> Fix all three, and also use native signed integer arithmetics to avoid
> manual bitwise operations on the unsigned representation of the fractiona=
l
> coefficient, which simplifies the code and makes it easier to read.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Changes in v2:
> - Pass a pointer to the full table entry to rockchip_rk3588_pll_k_get()
>   to make it the single source of truth for both m and k in the fractiona=
l
>   PLL auto-calculation path (thanks Quentin)
> - Do the unsigned->signed conversion in a single patch instead of
>   scattering it across several smaller changes (thanks Quentin)
> - Use s16 to hold the value of k in the rate table, in line with what
>   the hardware uses and also with my similar change submitted to Linux
> - Add a comment in code with the actual clock rate formulas for easier
>   future reference
> - Link to v1: https://patch.msgid.link/20260713-rk3588-fracpll-v1-0-cdf47=
f2ca0b8@flipper.net
>
> To: u-boot@lists.denx.de
> To: Elaine Zhang <zhangqing@rock-chips.com>
> To: Jagan Teki <jagan@edgeble.ai>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Alexey Charkov <alchark@flipper.net>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Finley Xiao <finley.xiao@rock-chips.com>
>
> ---
> Alexey Charkov (5):
>       clk: rockchip: pll: drop misleading fout in rockchip_rk3588_pll_k_g=
et()
>       clk: rockchip: pll: fix rounding of negative k in RK3588 frac PLL
>       clk: rockchip: pll: fix RK3588 frac PLL result for k=3D-32768
>       clk: rockchip: pll: let rockchip_rk3588_pll_k_get update m directly
>       clk: rockchip: pll: fix overflow and drop manual two's complement o=
n RK3588/RK3576
>
>  arch/arm/include/asm/arch-rockchip/clock.h |  8 +--
>  drivers/clk/rockchip/clk_pll.c             | 86 +++++++++++++-----------=
------
>  2 files changed, 41 insertions(+), 53 deletions(-)

I see that Heiko applied the Linux version of related patches [1]. Is
this one good to go, or would you like any changes first?

[1] https://lore.kernel.org/linux-rockchip/178532348703.455945.487247881971=
0322236.b4-ty@sntech.de/T/#t

Best regards,
Alexey
