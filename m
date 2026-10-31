Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825E4606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FZWzSW4o;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=E18ptJJI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FE1B81203;
	Sat, 31 Oct 2026 09:36:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X3jdLu1UeyAh; Sat, 31 Oct 2026 09:36:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8A798811F0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439415;
	b=NjELlgtjnrqCxkztVqf4STkO9/H+OIs4f3GUuXFA/0XeM5BVjagNpla89ao01pHdI9OM
	 RJDcLxE1INqp0u/YlBI5yn2sj2Z7aq+0LwWaxgmzAcz47pGz5f15aDhF3yYX0iJv+otV3
	 odIxhiR1UZrvJKE1/qZ3m1UHGXCwcrBiJxlOPRSJ97OE4Fb/OUE1JCC7hxcGS9of0F9Kr
	 0MpazziDhN2ZwtNKKfUI6NPoemIwCr1IOzYLV3ei0DLMTjxAOfXefsi3+fiqH4beaLeEB
	 e//telxG2k0Tac77jKfYrX7JLUf4aVRSjVFGRiT7fOMg7M110avwBaG79vGjCIaS1Tw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439415;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Rz0qmJzRLxyl21r6MYHQf+Bbq0P4gOdl5DTnvXmXJWA=;
	b=REtP4UM1EcEQQ0ES/ypradMntNi8Px/Yv/gAneHyhsc4j/sd7GY/m9QbsUq5OC6/6FzM
	 wMz9s9/8Q0LD/yY18cSbwxh7o2G/ap7bgvdOQ4hb9acCMQV9G6LPOwdP3on6s5FsWqdp2
	 0FineVhSvwhD5AVaGh9ausM/Hq0zRxVRO0xrY+As/Bg6KsvVPd4hzJKpGjrzwo57XSiHG
	 +t8X5MwFtlXNARhCiizd7IZeBDbxoJFNupMg83jOIdvHQjyG64iMMjhVVL5yVG76K4J7i
	 COFRTmxEFsYyB2NqvjLvwMKTleNSUFWNFr951eKftGc48idVMyPpnvCwpFCjIZBEh/A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=E18ptJJI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439415;
	bh=Rz0qmJzRLxyl21r6MYHQf+Bbq0P4gOdl5DTnvXmXJWA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FZWzSW4oj9Slc84EoW0ueYiEHgwxXNoMMokGDXPTH2BxvWTeL2UENQLvseorKitJY
	 +eiYOl+yKCPp/mvhCEa/S9r8hvoNSd3R8ghGskRygT3wYEajtIdT5vKt/kOaJ5VvKb
	 lylWMYBcUK8rO6hKMalv8aLLnDil6qNdTXhsS43TNG7Kbi/IxbC0RVoI6rfGaw+M50
	 Rviglqc1col+I/ry868tif+YPYSzCY4zbgFxXJq5W3pe3fqTOKr0J/fh0vm5Jm6w5A
	 rP8I03wSqLBVkanUkEVKJRtsq6ZBE6n8zteV2rna98fwaTuCF+uS3535u8MmBE6Mof
	 x4/JStkEhvyGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A798811F0;
	Sat, 31 Oct 2026 09:36:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B5CEC2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B4288118D
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KhovtmHDOyGJ for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:36:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C21BE81166
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439393;
 b=oHgCu00yFsLlH+0fZFKsZWUDheee4zi2kvsUfhzqkpaX74sJ1qKX/z+AOVHlxOYkfV0g
 TLm4pRl2IIbRWrEQ6H/y9mAhXbCpfYnRz1M5dDnE3ne8GsoEEQw9UlFNg/larcSWkrets
 RRH4xMBA1SVdvfEk7HdfFBiBOyQ6knldaHv+yFeq+CGmEe37q9dB5G1qpsr0gwugRCLji
 0819jkUhRTORdt9aNUzFxNnL+jexGVrRBAwmfo4J8BysH01WBGlOC//K3JZK/MyJP6IMF
 s9ue20tQLywDVHL9hXngYS/zLzwEMqbFKtFWaF2k/s3D0CRe1J1oZXtN4WrbxMlVdsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439393;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Rz0qmJzRLxyl21r6MYHQf+Bbq0P4gOdl5DTnvXmXJWA=;
 b=M7zqcMIkSlM065l6jVQKQeTHw14Wv26BfmMux32MgcwiMgm6ovPJPAaRtfRhlM9RgFQ9
 P2KTEmqBfN47Fvx7l/eOtjh6bSxGiXsS6SXezx5+Ri8E100ow5ctkRUdi6LJzIuSB2oYu
 z9UZzJwURBRcaxwj8BjEy7CpTFE5PlMjYNuRfQ4pnoZeehIU1xXFZjvftDyd/EjUTUt5F
 tsF7fx1q9SW04DkNsrwe3nZpDj3faCoToly8I8bMd+YxmOpBFuPJUw95718VM8MEkvNXA
 rO+Ba6G+tf3L2aQillPb29q0mutJwfbYfysGgWDrrL6ksyK36yZILW1xMXB4ADcGbww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=E18ptJJI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=E18ptJJI
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C21BE81166
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:32 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c4c9abc1824so229418066b.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439390; cv=none;
 d=google.com; s=arc-20260327;
 b=U/CcQWR6C6z+yJfhRNfTdv/IyY7qh1rhE8Gtp9RghMvd4/SqJCtxzGEjJR4xxjBDNr
 G/gjkv0HHk1mC/5U/K7L/qs4qb8TbzpUta4F2qIOjlV9uu3B2Zmw2gots5n4wT7pLsBN
 3aKj8z4ycZtxLPdAEYRQoe9p7+lb6IFZq1uyjuYNx2t72PC9rfEDrVeRRXco+KcMZzoX
 Scqj9hBJGHYyOS8HXStZ8yP4Z7KxncMPVEg4d99mmSzmIZIBY0z4S47qwit9Ya2jzdU2
 KbYq2/Yu1kARL6XC3CZUNkQ2sjIJmRFOwei17CVQqXFoVGXftb7yqyTyxsT2yCF4dqxb
 nfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Rz0qmJzRLxyl21r6MYHQf+Bbq0P4gOdl5DTnvXmXJWA=;
 fh=cBJvMKFHxZR/YoyiED7dnlcpOXodSrwGZ6opiMUDsY0=;
 b=LoRIF85ovklkQgfCtwvWNKO9em4uWP8LbfYZQ7wq8fmBnCvq9GFzstZVWqF9ZRBmRP
 +fndcBQZvCZSipFGB5T9HAoCD1ooc1a8H5FO9+sJkQZU8jMR7NJp+yAPWZSb2YEFeJZK
 0M+VXgj9VmDv+lCK+0unxtVFKRResDn+GTyyNnqc8tTj8UNuMezYVpD0O/P7CwxXyclc
 k+D1AevZUvsJwtciK9/Lcxp2GE4DGKR6KXvygGckYPU+ky4WGyE1Ct8ED7ksyonFYQOB
 bCUZ9IgOfETVeCj+ECCmNx5aB+RTImGbwTSx0TPMK1+VN9srdVGz1S+xT9y8cL6MIu9C
 qcCA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439390; x=1794044190;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rz0qmJzRLxyl21r6MYHQf+Bbq0P4gOdl5DTnvXmXJWA=;
 b=E18ptJJI54xEpgqYsxvjLNoFxDVnqAED6MpBtoD7kJCUrEBN7FkCxLf5XDMpZ+Qz1p
 H/B+1BUc0yprhJPNRTrb/YK8l8PebeCuhhrbNT0UbXHyezY+v6bsPfnnQypoFdZwFEUZ
 G73AYSNlGrhW4Fc+3Wexx+nm/PB7pk1wjZ4vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439390; x=1794044190;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rz0qmJzRLxyl21r6MYHQf+Bbq0P4gOdl5DTnvXmXJWA=;
 b=gYJ8Vzlm0unhuHU5moDvt0rLeJPsR9MpGmoZq75zUxfdx67Z5uiJmo1oY/B9K1s3Lq
 1aMmMyJmQQFX/mgpj3C01kmoH3b0HucdLmgsEuj4vcmELldbnW9N83iN5bpfO/KjOkP+
 x/d5t4SUQq+Ts01OMSoIzS4LXLT1mOkOmtSNhggEYS1qwBD67QUgcUereHEvDsF30eOv
 w26DoUKJp95B6TAzc3VO9Ol47ydBNcKg5MjVBKvzRryiqWZIzSHA/uiJJk4EIgTV8Xcb
 Ikwm1MfIFh2bY+up/44gtE1hp4q42Ak9Wi0pW8XaxKmzknVTTtFAk3GdvYBRWjGRMLfm
 V0rg==
X-Forwarded-Encrypted: i=1;
 AKwUvByShqWHBT9u3Pz9SkitrUR/kAhYaUHSZJ3gb67f8BoA2L5eLfoX7W8LSZFEqlbZp/Ov8xTOBr0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKk8U/02s7y5Q0VFbUZoi0ROPm3NMnRIFhsCWC3KZmlvP574KJQ
 0+Wx59uWDzTZR4x7P9vZy3x86TVggpd5IC+Gef1plRXI/A6Y3r6+9026gCweid2mEYB0QvVa0gT
 dslFfQG5pVSWoYJUFZWXDC70yu70Zx4ME39ZGbZzn
X-Gm-Gg: AYBFou3CnMk6DQyXW9PNwSVbUnIrvsRoP7f4ItDJCCQzPh1cSOm03tZyz4Ypzh4oxq1
 6Opunkm6b04jxjCQubz3gK+XfwLsvcO8v4SMnv8yDreswlqNzqswu46oEd3eV3HKas47k7WjLZM
 n/8/4q1KQlX4wH5VaBjsqz1u4wYBmvAWVK6vmvUTJtuQDUGoWm0Cglaud04sMjbmXLE02N0hSx3
 J8F6q2ZQk9PQt5fi4uryNF4a/xjMcKFUQvp8eCSp3XtT50rSsEH8SeG1aWzoM3I2GiZHoN28QmB
 HJLrnRXfjf0O6EGss9PKCveZPGPcxrUfamL4zyMfpLqVb4vUw7m+raPShyl+dpmHuvlFFjKkxot
 hrEoUlz3HEU187neGxYMoxgUpq4rxG7OjWGd6hXTxAtHs8AM9iZiV5SZngr1FaOpKEQZ3f44=
X-Received: by 2002:a05:6402:2750:b0:6aa:734a:a091 with SMTP id
 4fb4d7f45d1cf-6b4d5727b34mr3430244a12.40.1793439390464; Sat, 31 Oct 2026
 02:36:30 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 05:36:28 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:33:02 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-38-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-38-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 05:36:28 -0400
X-Gm-Features: AclHuK8gS3R6fRkstu8g5ULzT2euYrImOWqBmDARKTA97PPzzsqt_0W_bHWaSQg
Message-ID: <CAFLszTg+5j0F=hg_gVDNg59PmW7Ni_2Lwo+X8xTnu_KYjKJW0w@mail.gmail.com>
Subject: Re: [PATCH v2 37/37] adc: rockchip-saradc: Use 3 MHz clock rate for
 RK3528
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> adc: rockchip-saradc: Use 3 MHz clock rate for RK3528
>
> The RK3528 CLK_SARADC divider field stores the divisor minus one.
> Its three bits encode divisors 1-8, allowing rates of 24, 12, 8, 6,
> 4.8, 4, ~3.43 or 3 MHz from the 24 MHz oscillator.
>
> When the driver requests 1 MHz rate, the required divisor of 24 is
> encoded as 23. This value is truncated to 7 in the three-bit field,
> selecting a divisor of 8 and producing a 3 MHz clock.

Just to check, is this really just truncation? rk3528_adc_set_clk()
calls rk_clrsetreg(&cru->clksel_con[74], mask, (div - 1) << shift) and
rk_clrsetreg() does not apply the mask to 'set', so the write is ((0x7
| 0x17) << 16) | 0x17, which also write-enables and sets bit 4. Bit 4
is in the CLK_TSADC divider field (bits 7:3), so each SARADC probe has
also been changing the TSADC divider. That is a better reason for this
patch than matching the rate, so please can you mention it in the
commit message.

I suppose you could rk3528_adc_set_clk() clamp the divider to the
field width, so that an out-of-range request can't corrupt the
neighbouring field. Bad for code size though.

>
> Request 3 MHz explicitly to match the rate already used after value
> truncation.
>
> Fixes: 6ef723af18b9 ("adc: rockchip-saradc: Add support for RK3528")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/adc/rockchip-saradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
