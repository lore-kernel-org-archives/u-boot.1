Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F22AE87853
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 18:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E28583BFE;
	Tue,  3 Feb 2026 19:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FGX+DiDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA6A083C14; Tue,  3 Feb 2026 19:02:05 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DBE983BF4
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 19:02:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7cfd53a8c31so41764a34.1
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 10:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770141722; x=1770746522; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rYHtubIb4FAqSbK4EK3rq5X+RuqupNqbo+4a6JMJsKA=;
 b=FGX+DiDOj8D8kBZvRAopNFXb+oF1LvNgXNnWp3aPPUZw8RMf8hZqWULzVJoM5jRSTs
 SLUFD3F7VJJngRTw0G054hNdVKVo58BdT8pXye+X1zVl5xZmj2aOMQ4yqE6gKl6gY673
 niisJf6ELqITQJO05EF1vLmBYMiRH9MPMoSTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770141722; x=1770746522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rYHtubIb4FAqSbK4EK3rq5X+RuqupNqbo+4a6JMJsKA=;
 b=nLUoMurM64Bj3Vs1XIZCL+4yK3+bkXJhmjgZsSIXBwhZX1E96GLTAmY8qAQor68RFd
 4AQ8BDj9lO/g1mH/PLaqhkeAJVXv1edVomRWAvkU/kP3JZYS7UFRHt7T6pPqbV6Cd9Ah
 YvXtv3kms1zqMl17ANp2DwQj5hBPF3KWi8LvywxfzF6rD/oTZsaPzUY8kMzwz3j/6ZDD
 jWEixnHC5ii2gPRslNvz5ewS/vPNbL/pO9GpnXJwpjUsopfZcOZ/Bjo9KA8ImjNGqNXN
 8kRLFD2e9QSZCDT3YLYVaCA8Q9HuXRy4QHbD0A64V47ik9NsvnFeQBUN/bqsaQ46ooM0
 m1WQ==
X-Gm-Message-State: AOJu0YxiZGRgMFIZEx2NIDI7kSNba6f6X/DcyxVrwZvM/BZ1e1R2DzYJ
 EizgAssNWIsS0ra8IgIG48uNyx2Dpr8vsm9SB1iHRwO29EOrYBJP3H954YB7rFWf3bY=
X-Gm-Gg: AZuq6aJwa3HA7DHcrfXHiqXvzvoruaocUAA0Kp/rTgGU8FIMUm3oJVASRvDW8AokA2f
 hv5p5bW4C7dQpRpSO36YrBe1XAV2HhxCCiS43aPjM+oSoy8Sa1qRN/pFr2XugTBf/q6XjUlNUd6
 TCcq9U790JlRreSCm97q00ChUcugFlQhHj62sdQWO0e+YcvctXJwzTxmhOAq8GSvUvzYCa5w5TM
 6R0aY42Eo3d8ZRskrCZC7W5pkVWLN2NUGIyHJxiywYnu3krx6L853JWErSVtcray5wePYvN0s1d
 5QcAkDzsENy0z404nn1Ko5eS7lruSIrYkByhv0gpYvMivVPNHdR5n2szm5GdJahr0jAvHJr/+nD
 TGezoAp5TGgMYfX7q/6J7Y61V/yB2uYxjLr+v2OA2QnNlil9TUdX6oP7V6Lp4+hA8rqr9RUAOnf
 LvEp/UyDN1ZSbuKSxU9C7S9EvOPwZ77+fanNXAnKBYdajroXtf4ZzJ7eDrPu3fWyf3Z/WK+cq5J
 kBxiLTgkrB9/+V9izu0eYgJAhDWr1W39WVR8uY=
X-Received: by 2002:a05:6808:2225:b0:45e:fff5:89b4 with SMTP id
 5614622812f47-462c11eb9e8mr1958216b6e.10.1770141722155; 
 Tue, 03 Feb 2026 10:02:02 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462d680ca17sm670b6e.22.2026.02.03.10.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:02:01 -0800 (PST)
Date: Tue, 3 Feb 2026 12:01:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Cc: u-boot@lists.denx.de, bmeng.cn@gmail.com
Subject: Re: [PATCH 1/2] Fix x86 baytrail boot flow.
Message-ID: <20260203180159.GP2603314@bill-the-cat>
References: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NM87h7Kc4DlQjgPo"
Content-Disposition: inline
In-Reply-To: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--NM87h7Kc4DlQjgPo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 04:02:48PM -0500, Eric Schikschneit wrote:

> It was found that on modern versions of GCC the transition from low level
> assembly into the C function 'fsp_find_header' was no longer valid. A det=
ailed
> step by step analysis with GDB showed that various registers were not bei=
ng
> initialized properly which would result in the hardware to fail to setup =
the
> Cache As Ram (CAR) portion. This failure cascades down into later stages =
of
> initialization because there is no valid stack, or memory for later funct=
ions.
>=20
> The function 'fsp_find_header' has been rewritten in assembly, which shou=
ld
> no longer be dependant on a specific version of GCC in order to be usable=
 on
> actual hardware.
>=20
> Testing was done using GCC 11.4.0 on Ubuntu 22.04.
> Hardware used for verification: Intel E3845 SoC
>=20
> Patch 1 of 2
>=20
> Upstream-Status: Pending
>=20
> Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.co=
m>

Sorry for the delayed response here.

[snip]
> diff --git a/common/board_f.c b/common/board_f.c
> index 442b8349d08..3a9ae741d97 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -860,6 +860,7 @@ __weak int clear_bss(void)
>  }
> =20
>  static const init_fnc_t init_sequence_f[] =3D {
> +	arch_fsp_init,          // FSP on platforms like baytrail MUST be done =
before memory ops
>  	setup_mon_len,
>  #ifdef CONFIG_OF_CONTROL
>  	fdtdec_setup,
> diff --git a/include/init.h b/include/init.h
> index 9a1951d10a0..21d9cea30f6 100644
> --- a/include/init.h
> +++ b/include/init.h
> @@ -68,6 +68,15 @@ int mach_cpu_init(void);
>   */
>  int arch_fsp_init_r(void);
> =20
> +/**
> + * arch_fsp_init() - perform firmware support package init
> + *
> + * Where U-Boot relies on binary blobs to handle part of the system init=
, this
> + * function can be used to set up the blobs. This is used on some Intel
> + * platforms.
> + */
> +int arch_fsp_init(void);
> +
>  int dram_init(void);
> =20
>  /**

Doing it this way will break other architectures. Can we just call the
function needed inside of x86 assembly?

--=20
Tom

--NM87h7Kc4DlQjgPo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYI4EAAKCRAr4qD1Cr/k
CkjpAPwKMyqLrifP7pKkwsW20UI5YVIm6Qk6bDXptaSeaY0PQwEA3YmE8B3x1Wfq
d1XQT+YuC9tW5+R7E8Pkv7652iTiPw8=
=JRDi
-----END PGP SIGNATURE-----

--NM87h7Kc4DlQjgPo--
