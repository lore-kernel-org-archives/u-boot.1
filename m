Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BBDCCF2C3
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 19:21:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77DD040A32;
	Fri, 16 Oct 2026 19:21:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7g_GPnRHbqoQ; Fri, 16 Oct 2026 19:21:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC46A40BF3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792178497;
	b=gy3c6ueIv5ZFcdzafdy1y5/svwfUS3vL4hOTf4l/q9EBNlMrBsZ0gHr2LMoKa52hAQKT
	 tEW1J9Ai2cLh9FiFbK0h1UvuSfD6xaCp/khaC0RaAPEaeezF7a2CQEROSgS8YYdqUEFLO
	 aoCBojgSwAa6WxyBkMbbGIx5CrEr4FnyKaeMnSniP6tw26nYvu2yQDzll5OHgnw27RSH2
	 ECe5eYaem4KccAsGBP/2Xg1zpULF5TosvWuAxw+jRQAvsHw2vwLOFSSGnVcBlelQ0kegn
	 NGknq+pPxkhy8uRfmMSE5AhuEH3h7IaarJ+h4ZYPegycHscrMKY5WQh4hgoSPI/5Gng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792178497;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=i5ERJRl92Kc8DWLWDVoLtALz0RQOuX+qKWWYSmX9ziM=;
	b=texBK4reW+dCm1rNtLn2UUUYsvXmCVHT2in+dp86jIZcMosLEUhHCdTK5UlHCYA3Xfjd
	 aun4ZAF6coc0jliwcb4VMcH5vu3c69vQHO/teHDI9ED8q8xYERp1xolciArFVfrLaaTYb
	 UqgPIBibZYITaOobadzuuEiI2wVSmR9f8Ee3sFVd9LaDk4sNZQaIVXABPHGUYn0gtfOfo
	 focpNm4didJoHHLuUb58S8jjCw57HRq2xZL64jFdJJf32HQqoEVigoE68hMiyIl3JHjM7
	 Zwcs5kHoFz5pqxj66ueP0oU0U8TmP/L9FASPo5ejVlhk54rhXKV+4W4iaDsL2UngSqA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792178496;
	bh=i5ERJRl92Kc8DWLWDVoLtALz0RQOuX+qKWWYSmX9ziM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mre1EoYTV5r/GLFNVA8IH/XIDIKrb43RySlcjD9ZfvhYNkuk2XP8xJrlAiEaphCRJ
	 VciVVl7vgK8JUzSZOhrFZ7ZjdiM/atcihF1aHNJtU659uX8Cf1Eg88qaGlzByX4m7C
	 cHzXWgYOaXHLyFUHDyFr3Ql53Qlgk1JapQGkYK6al8uyMYhpcg1ociOTxCVl2sE0pv
	 VV0R7HtDwW348E9Nyoa2RfM4sYVU8vntc8JCcBvVFHUoI0RduHAQzxYYLBssWw0URh
	 Mw4eD/0S98m6t6B8mv8FSCEzhkIaEkdLHB34dyvBqEJM9isHOKNwtpERbs0b0C1+pC
	 9Fn/OqJ7iMpzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC46A40BF3;
	Fri, 16 Oct 2026 19:21:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 61043362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52E0981773
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJl17H7XwHcH for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 19:21:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8273281769
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792178493;
 b=AIG5vQORldlqqkvyY+vQ9pFXtKE8C0yr4nlHeVTofTzq80lYQRwFVc1oV0jThG3oYW91
 n4pEwbij0JwUFvoTZysnYlEHojjzQXFk2JufylYIuD/m2qALQdL69+5V/j1WwCN472l0J
 62wZQaNKVpbVcPHo1ZGzpxCbC8GKjfHYVZxJ/AOGZFtSw6EIZtMOFyG4X2rqUvff76v4i
 sjZLCISjtWP91YZwp8pO6fKH0SO+vFzvAW6Yia3fZOGJk01knZEDHIr7YtXrxosNlHajW
 0j9UB+Z4HtQuJ0eokhbw6Hoq9zzfNwauqC/1y15CBQTP0ob7uSuhacf5n1VZ0J1d02w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792178493;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=i5ERJRl92Kc8DWLWDVoLtALz0RQOuX+qKWWYSmX9ziM=;
 b=Sd8otVs0a9cYYcboE+gAvL/ZAtZHPfSLlxT6KZeCB0dNWU9QuWwNJqwgZtU/oSgmr8Ac
 zwpM8rrFajJJOAYXHVTqbFJNGu6xiL4zrQ6FBbQnwzwsL5eLPCDYKFfU39E/1JgZ3CKEt
 1hi047N61AMyMGhjZqC/GuWQ3L5m5Rpu4YJh9pTzwN97oEPelwHgsH3IL7HuUbnDUCgkb
 ASIeOEPk71Z/cTSn1YgZXYzXeJd4uITQxFKt3SD1FpwEP1aKC8mW/QEwTNAcArb5shPGx
 F+zv0Pzr+dR5XGO0A3NjSLre5OBJpmX962sPzuuDWOAdwkzV73nCAvoBBU0E8k31uHA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EjouPMli; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EjouPMli
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8273281769
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:21:33 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-81b54d0cb17so117478a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792178492; x=1792783292;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i5ERJRl92Kc8DWLWDVoLtALz0RQOuX+qKWWYSmX9ziM=;
 b=EjouPMliwxYMracz2GnBlVzZoBL27noPk8jOgTr4HauLximQEy70kwLSQoa7M+KZUR
 l8R9LA1YegRKBvv8OFomr7WKykFExO2FlTzmh8F+SVbyVuBiSZ9G1FOMVDv9FqdDmFhJ
 V2OGuShen8jxcmfjNfzPOER31R1RzCj3YMEro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792178492; x=1792783292;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i5ERJRl92Kc8DWLWDVoLtALz0RQOuX+qKWWYSmX9ziM=;
 b=D7C1huDMQolD1OnGj2zmfeU2av+uWgDqXrbFcrNv+AwJrIpuuERU5c+WDT2Z3dMcoA
 AWdn6RfWNFv+Ki5RZkzU/YLkVQDcPfHFmRHMq0irR8bqdnl1to0mF3AW8yN8eMjxhKXD
 /DbJcejt2XrE5FV6QhC+wSPdqf/ZfjvFEc9wx5AVC6CnjE1RRcuihyL2H2Hz0ZHWSf+l
 OF4aRcXEYHC/bsZCsoZnpvX7dQ5jbzZDKDjtbGqN4ZdgOCrcB0QtyzLUdORJqGSylmsy
 KyX+jMj2CnO4UK0yEmiY5cgx+Gtg9kebMF4H9hjXORcyosbaLjJAMFAkOc33vzilSKbf
 wZTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfiW7CsjBkpzeyxEquSSe73lSeML05hygQ2S/rRFtNNmGqmmit3befztQivVSuXGGwCFbwpek=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLO6MAVx9j93yPBe+grQAPBliHzM/oF6aZ9A6qOEAXynArTvzaj
 YCpSYBr6G4l8NW1KwqBZX084x/qh1DjyYmgDsXlEBI0QlLvCTIjIfaaiFcPTAees430=
X-Gm-Gg: AYBFou1OZk0re6S6l6OzAE6y4O0J3u4Le+8YOgC+aaW2NTfUlwRyWSDXAXtL4xEH9kP
 4dtnQ7o6y/DbrBAvhCGA5o4ioGq3qwDle7AJC25sRbL11Ytj4kETnAcmcgUllFNG3Pg1660HHUc
 wfSuYKwtKGpMutV7yoVPxstCm1Vd5q6dDs2Vl+W3g+rz4EAGCgkZZFbbeK5tr/MnVV+FG1pq8xm
 ueXirS6IhOBXSOlTR09HCSTIAGWt6ScymlcNzlA4CuSt9T/S+/UHbScz4xpqvCnkF/MaLdPAa/3
 Z+cY9Y1jHIOYiK4GhMJvqQaLXVwuoSzVrwv4hngqjzWMoFB3guYNlx5cAkQZBzH7jy6thUZU8UA
 +weMuBlQXSrHyFmWjXQoP89jeEyRiMW0YpI1JVTRMmqZWPoUN393tBnu71lNhiUQ8NW9ofNfInV
 BgoAv8yId/OZEW4x4COfpKDDAcX4WRSKgPCdtjAAGpDBaDP5M8LZ2Dw4HJVkAaMQjggUME67c6S
 cwz4dWFZ/heIFt0GQd0ePuc309W5kBAfFx0yiZI0FgtXCOhhHyMPMcTSje5JL5399XDPI++Y5n8
 5PUqxWsr5F7KXtv+AGY=
X-Received: by 2002:a05:6830:4391:b0:80c:d30f:97e with SMTP id
 46e09a7af769-84501a08710mr513625a34.31.1792178491610; 
 Fri, 16 Oct 2026 12:21:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-842a53d8a52sm2702583a34.11.2026.10.16.12.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 12:21:31 -0700 (PDT)
Date: Fri, 16 Oct 2026 13:21:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: ilias.apalodimas@linaro.org, marscheng@google.com, eleanor15x@gmail.com,
 jserv@ccns.ncku.edu.tw, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/4] board: google: Add Google Tensor G5 board support
Message-ID: <20261016192128.GL259661@bill-the-cat>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
 <20261016040216.3636305-3-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JAReyLHfEhXHDKw/"
Content-Disposition: inline
In-Reply-To: <20261016040216.3636305-3-visitorckw@gmail.com>
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


--JAReyLHfEhXHDKw/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 04:02:14AM +0000, Kuan-Wei Chiu wrote:
> Add initial board support for Google Tensor G5 SoC boards. U-Boot
> runs as BL33 loaded at 0xbe000000. Configure the MMU map, DRAM
> bounds, and disable the APC watchdog left running by earlier
> bootloader stages.
>=20
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
[snip]
> diff --git a/include/configs/lga.h b/include/configs/lga.h
> new file mode 100644
> index 00000000000..c770c5837f4
> --- /dev/null
> +++ b/include/configs/lga.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright 2026 Google LLC
> + */
> +
> +#ifndef __CONFIG_LGA_H
> +#define __CONFIG_LGA_H
> +
> +#endif /* __CONFIG_LGA_H */

Does this get populated later? I *thought* we had done the required
changes so that a board can avoid having an empty config.h file.

--=20
Tom

--JAReyLHfEhXHDKw/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatJ5NQAKCRAr4qD1Cr/k
CstNAP40RUz/gnWw6ZSjClstqtm2lIq/laiQK5QdJ+I6ImXrQgD/dto6nFDBqzSv
fHinaZQO3DS7IjmbZd8RoWquRKcA/AI=
=m0MH
-----END PGP SIGNATURE-----

--JAReyLHfEhXHDKw/--
