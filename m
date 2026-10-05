Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7B1CA5FFE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 17:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 602E74072E;
	Mon,  5 Oct 2026 17:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U66vGI4QPsHp; Mon,  5 Oct 2026 17:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8B71C4070C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791219973;
	b=TT07fLfGnFE82KC87RNw+eloDWxM7vmrbSyZvC34to4VBo7grg5FBCwN3z+o3m9jNZ9e
	 7UBATmuFbhdLdq92rSdlcW/h/Ua08n8B5WVy5F6L3I5Xsyn374cg58I7q+c2kCWJ5KvZh
	 MtHgGgBeOzaeUSiAmVuctQa8lczh+tPm39L+fsU9/atCF9zWNnM+8l+UluvATATqyDyjH
	 s2yKaHZdu6N++GextKDyDQM71oIHK4fw1xXawoByqpjjq5g3j+ibt22UFD0X0BZHKgfbn
	 VT5anPpfKuIRNLeuszTP8C10NYyZsZlNcQlrZ9d0wjKn9FYsCWnzua2RKSHeHi8gbHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791219973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=USkRxiCrBbvXBwYZXHis0VZKPH4BG60cwx5caNHnL90=;
	b=AOuzgegJGSdWv5hvcM9Ws353lAxb5xbqBccQ1MYFEBiHZ8UeUAcMfMk/QOA2k48EQ3Fy
	 kx74SwfZxXVerejnI9F5bCLSFWOSAVuho4oR64/7zVGKTTjwpRxNeNYF7H5HbPPPIoT9r
	 xDgzrZ/OQysSpCuCVei1tEFqemNxNr6hhT+oNpSXOveKPzXXwUxoaAaSCbG+EXedmAXjS
	 +606xW6L3Mdf4T1pKsmjbMq3RrNMrz/1Fa60GRLOaW/82wWZCqVm2sZsENhtN2YNlA6Gs
	 8qDI1BA8uFjdQiSFkEQY3mU2e1c2wQ38oqSS2L87tVkCo32Sg7/WwUoY4Bp480WD3tw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791219973;
	bh=USkRxiCrBbvXBwYZXHis0VZKPH4BG60cwx5caNHnL90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YQI7cTCcKBvp4wsamJ5Q8OD0ZbSQjyb7izJ6EtHAZc5s17uvBR2noEAdSTIbm8cZ3
	 PkJSJvwgxwQvmdNiG8rihZmHdZ+s2laaIOcJWnGz2TqBS2cW/Sexk4S2ye4LcFRpv/
	 QwsXPm35b6XAp4WEXyLo9Gr1W6nzlR+qkFi6vR9EVbLtAKg7np/g7fGakGiwh7YbnK
	 JenAkBiQMJa8mQNg1WIrUcKhwtUDPPtFR5PZFgwZurHLr9gThPcsI4Wni5f5JGe1BO
	 MpWs/g32mJI5owFa7K0taky5v12s0so5oVNmZbKd8fjaLXbaCYac/Mbc6lTd3++wCR
	 MNXdmGj6eSQQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B71C4070C;
	Mon,  5 Oct 2026 17:06:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4430334E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 358CA60718
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:02:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7XM4QDyC3aDb for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 17:02:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 198B5606B8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791219725;
 b=MsiGyqAacXRW5m2xXrqznZdSt7vjm/ryNYr6aF0uK1LXRxh8jSu/qyY+N0s6F+Vc7NVP
 SMSCtNXIzgO1oN8zTNBOlI2QEqWSjjrYB1Jf1uoW2cp903X3fznsFoEqctpumfgxz6FK1
 opDr5UvObSt2RaTf4tXyhA82WOFifE16yafwJTyfOYNvWsq9P92OjUsdOYmPUAygqD5yV
 LW3wMGX9eibtYpFm/W09v2WLKvM98srl/7Awsp715ro9689P8xjnsplsrN9ioHM3whqLH
 OSJkqCLAT7K/cIoKU+xmVwI0Ut5i3oezKqkJzmvLzKCeb/N4u9M9lzA355xYRDJEuFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791219725;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=USkRxiCrBbvXBwYZXHis0VZKPH4BG60cwx5caNHnL90=;
 b=S4D7wmwata0b/TvOdgThJFYKkjYpCvGTYHFsbZu4OE91/thztD7WAym6a2ZWmjDwNMhE
 ggFWW0gSbFld8kJjxwm5rFvx4YppLOmFJEMbQyc4f9D84kaeA7t1a0cNW1V0aJGeqFvW6
 /GhIwdAA/qRfXG0YL0eLrsv/dUA6aLwDaXRtTDV+CAWVvAaWLETywAgz8zIb1roSQKH2u
 VqAD/OAcEUm4a2Mr74aACBlrwU2uOsOUQPTbju8cAhLzfQxC+tjDeIEQswApU00DqqShM
 3BIGMxsUOwlY0Fyzal0v/Zqg5R1LfUi0f8M8PgMIhJHeVTwNP5IzptH8CIv90YCQffQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=HJzeHJem; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=HJzeHJem
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 198B5606B8
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:02:04 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4a451915d8aso1365490b6e.2
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791219723; x=1791824523;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=USkRxiCrBbvXBwYZXHis0VZKPH4BG60cwx5caNHnL90=;
 b=HJzeHJemFxlCUZ2KrwPnR3VIJoyxg5+qthdgSdm7OaABFYLGH7z/XofN5Q9ibRw+IV
 E9/jex3rf5/816wwGz8wOISipi0SmvHuXHBR+ILwBBDGxw5uK4ynwMpKBfDsaMNSeaQ1
 xQvFgpUQhzdGd4jDrBYJowatm6pV+bWNsSPvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219723; x=1791824523;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=USkRxiCrBbvXBwYZXHis0VZKPH4BG60cwx5caNHnL90=;
 b=RzGyQ8vROXVZfDnYM0AqLbkiv13ubn8Bs2ooYJ2FYXQpOk9N8O5Lg2Dk/L92LGbqLP
 MVSdOjwGUhfi6tfJbse0iV1s5RLvglrXT37utU5XPtzfWOg08Yd6hmIdl8kGxDAP5Vzw
 NwltGXgC+BQVwjtZ/SNNbubnhVN/L1v9S74DDpbbj7B/9zncU4GyAottKxow9I3gciBt
 6MMotVWAV+WOt/lJVy+SWq6Z+vJhR1MkYurIM6i9prgqwJm6pEl8oxjE/2PFKQ8M3HgQ
 koABQJxvRorNNFFgfMC5t5YxrHvAfYKyD3wx5PRzyAPm6SLKZDQQ0F47THznUv9uEE4u
 TKtA==
X-Gm-Message-State: AFuF++lvZ4I8sZvq41bK75GM88ZHJpejsK0ivGxqA9pSVS2xJnfpysXK
 M2mwA+zDSsubeTeDW/Rafly2vx3CqDahjwaedJEfjQhxnNfGXC/PGYTIcvGCugEnI1bdQiT/hiH
 iFCGrhay1w26a
X-Gm-Gg: AYBFou13698z2nLmtg+T6XJ4XAYbQKJ83uh6yR537SIhTaidfzfSL+Rd5fs2CVhKDsZ
 L4k7zJGRlhRLTe24zBsWcUiUDEF7EtoSxsrtc+M3oXodKLu3hBYSFp6eM61r9F0BxmAF7sZP4ru
 K0l3ybEAqoHUaEZLWksHcy+l6DHVRpfuWv8+J2/cM1Zq43m09TDzOguGNrETyHeb3PxU9hVjeVF
 nq5rFuiKLGgzGwtczRudyJTZNPa/Ak9sEcuDYP6+llOrVx7pueqoF0cwYSInwQDDlwnbrqr6Go1
 u5Dx+hWnAFJ/Cs8v0cnXdW50y7E7vyA62d0ekeXIKbgVNH/AMSUm2toO2HH53pS3srJF+tbeedn
 osnFESOHbzwpCQ+XKnzIcB6oo7B3RQrUf0DYbypkXNkrX0YJ8Qcz4BYEnhzehJrJ6DrvlQi9RfL
 4ygYE2lITPz71NVq70wFwjWlnZggduxGozBMl+k3f5Rfz5QU6DP2TB8eOnnxMFhgzm6usAskNYT
 2m0yhVlVAV+Gdj7/cZa3qPHVaEDTOQOyhPJwqy+TSuNSm0O+PaEOADpkaAfuCYO/y3dMp6kxy4e
 bk2zO2DoB2vQy/RLEFYC
X-Received: by 2002:a05:6808:1790:b0:4f3:890b:5fed with SMTP id
 5614622812f47-4f67703fda6mr7093805b6e.2.1791219723329; 
 Mon, 05 Oct 2026 10:02:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f5252e3207sm10427067b6e.16.2026.10.05.10.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 10:02:02 -0700 (PDT)
Date: Mon, 5 Oct 2026 11:02:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Xiaoyi Suo <18102059357@163.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 5/5] lib: sm3: use memzero_explicit() for the message
 schedule
Message-ID: <20261005170200.GE3724959@bill-the-cat>
References: <20261004152715.1574-1-18102059357@163.com>
 <20261004152715.1574-6-18102059357@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T9CpaAo7MWpooelk"
Content-Disposition: inline
In-Reply-To: <20261004152715.1574-6-18102059357@163.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--T9CpaAo7MWpooelk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2026 at 11:27:14PM +0800, Xiaoyi Suo wrote:
> sm3_update() and sm3_final() clear W in the block where it dies, so both
> clears go away from -O1 up. One of them is the clear the "Zeroize
> sensitive information." comment is about.
>=20
> sm3_final() also clears the caller's context in the same block. That
> store survives today, so leave it as it is.
>=20
> Cc: Tom Rini <trini@konsulko.com>
> Signed-off-by: Xiaoyi Suo <18102059357@163.com>
> ---
>  lib/sm3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/sm3.c b/lib/sm3.c
> index 058800997..4564cdb2a 100644
> --- a/lib/sm3.c
> +++ b/lib/sm3.c
> @@ -230,7 +230,7 @@ void sm3_update(struct sm3_context *sctx, const uint8=
_t *input, size_t ilen)
>  			input +=3D blocks * SM3_BLOCK_SIZE;
>  		}
> =20
> -		memset(W, 0, sizeof(W));
> +		memzero_explicit(W, sizeof(W));
> =20
>  		partial =3D 0;
>  	}
> @@ -263,7 +263,7 @@ void sm3_final(struct sm3_context *sctx, uint8_t outp=
ut[SM3_DIGEST_SIZE])
>  		put_unaligned_be32(sctx->state[i], digest++);
> =20
>  	/* Zeroize sensitive information. */
> -	memset(W, 0, sizeof(W));
> +	memzero_explicit(W, sizeof(W));
>  	memset(sctx, 0, sizeof(*sctx));

Why is this last memset call clear here safe? I'm not saying it's not, I
just want to be clear.

--=20
Tom

--T9CpaAo7MWpooelk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasPYCAAKCRAr4qD1Cr/k
CmxMAQC7M102yJGmzrx5k0EiHzPWoSEdW/5dWeHy4UAa78E1RwD/aOrlje/8+Prt
bUuHz0G49bwAKjycfXzOwRK0coZrKAw=
=eCg4
-----END PGP SIGNATURE-----

--T9CpaAo7MWpooelk--
