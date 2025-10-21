Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A610CCD1AF
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 18:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5AD4802C1;
	Tue, 21 Oct 2025 20:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gs2qvn5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAD2D807C0; Tue, 21 Oct 2025 20:50:33 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4524F80107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 20:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7827025e548so2468926a34.2
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 11:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761072630; x=1761677430; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YqPQlgIbf9JYf5h3zPnOdYuYlDIv3K8ijNoMm1ZgQEA=;
 b=gs2qvn5tav0SQjWQZVaWW0nifkEu98loRTsmvmUIuEGKxo8jHOPqcVL58/Jd108muq
 k36neZhM4p8S5fAecZbSxcyCBUkWuWjlTj726vrdAZfxQNjQ49BFiMZnuWcJzvSqivJr
 xN6ZRnQPklnUirC5pdwBJxgju9N3TshjDVQDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761072630; x=1761677430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqPQlgIbf9JYf5h3zPnOdYuYlDIv3K8ijNoMm1ZgQEA=;
 b=ZuEPDkiDxRVsKa03j6BcE+COVmmQz3ynujqfFeLjgAekLP6iZbUjRlURuu0DLJSzx4
 t9VbNyBJCXrc+3HzSj0YhlihFVk/8j3hN/Hp2puDSCU9KtR7jaVCewRsvfL1qKkw1imK
 rfklU371dOcbyunyECB4hBd41T477z2Y6iQzQkylmcax27I2phbLKL+0wTPlPLCNUShH
 ermMVl08vN0PH/RWHLBGyyyts9RlC0P0gl5148IkIwxc2Pq7WpZBqw/1i3aEE8qAr9W1
 MvEfo+vWhROum3cieVfXOq9cF8hCTf8Dd4UbAh82IXTYkOw/GA3DfuuFrOpzmketUcFd
 bagQ==
X-Gm-Message-State: AOJu0YycGYQBNKPjiEBN8+sgdNKL7BIOsR2jRwPr/ngxnctgSDNO4hkk
 dlx0YnFahca/zCWI9Kc8X9T89U9vPsoCjWmTc0jf4XaRE6C723t8twiCz3PsmLa+qek=
X-Gm-Gg: ASbGncu2M18WE6OmfYtmXISG+wDH7LpGrchmqPDjDtB7Z/aj0d26WFFc+RxOEwgWxMs
 t3UPdbmVvMCr8aoOWUtgmAnARFj+/2eOBev6AN6THUkiOnlZicBfxYjOfsJLm/FoLB0sAvZeM0/
 s+WBe03IfbUyCG8d9FWWfRdZkfKReq8/tKns3VoPA2WJNIMIAGcKos/5V2ZiOLJKYLZf/+6iatJ
 v+EQWBpGJKApJ+C4uKckg1/TI21RcrKUGUDLGHGPFrJn+Su0ry/h0vJqt4O22O/HcAe9WQgPgh+
 k5CcjIQOEXXzo9dDJPMqllXGYIqwMyjQw9lieafcVvLw/F/JpTXsaJv9IeHRRXtaZNQDa+mQNX9
 ktW70DtXFybZjj/dGMyaJprgT6Zq0Vq2izvVEYS+5DhP0uAqkjv9llEE8p/0b8BmUllV6iT9uH9
 wviqFSmc6N6s/TemhZJ9FrNU6pcNl6yugKV7p182HyASdVHSyiTQ==
X-Google-Smtp-Source: AGHT+IFivaEi4ggbRXqlZ0V2sWmvMB4OlDCtOArd2J65dHUsANXBvkmTsh3/XvtDPKQ6XhvIa3u7qQ==
X-Received: by 2002:a05:6830:3109:b0:746:db50:7dea with SMTP id
 46e09a7af769-7c27c9ee4ecmr9248985a34.9.1761072629934; 
 Tue, 21 Oct 2025 11:50:29 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c288935ed5sm3906521a34.32.2025.10.21.11.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:50:29 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:50:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] armv8: implement workaround for broken CNTFRQ_EL0 value
Message-ID: <20251021185027.GA1249517@bill-the-cat>
References: <20251017-armv8-broken-cntfrq-v2-1-1e043cbb657e@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PES4pRsLb1zvnNDw"
Content-Disposition: inline
In-Reply-To: <20251017-armv8-broken-cntfrq-v2-1-1e043cbb657e@disroot.org>
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


--PES4pRsLb1zvnNDw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 08:49:47PM +0530, Kaustabh Chakraborty wrote:

> In devices where the U-Boot is used as a secondary bootloader, we rely
> on the device's primary bootloader to implement CNTFRQ_EL0. However,
> this reliance may lead to a non-functional timer in broken firmware.
>=20
> For instance, some versions of Samsung's S-Boot don't implement it. It's
> also not possible to set it in the U-Boot, because it's booted in a lower
> exception level. CNTFRQ_EL0 is reported to be 0.
>=20
> Use gd->arch.timer_rate_hz to override the queried value if set. This
> setting needs to be done in the board file, preferrably in timer_init().
>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Changes in v2:
> - Switched to using gd->arch.timer_rate_hz instead of a new config
>   option (Ahmad Fatoum)
> - Link to v1: https://lore.kernel.org/r/20251014-armv8-broken-cntfrq-v1-1=
-b63f9c69ffcb@disroot.org
> ---
>  arch/arm/cpu/armv8/generic_timer.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/cpu/armv8/generic_timer.c b/arch/arm/cpu/armv8/gene=
ric_timer.c
> index 1de7ec596fc7cbbc3e78a241f163bc0a4fcad6b6..1bc72ed26ca31af8e8e72008e=
d7885cbde23b076 100644
> --- a/arch/arm/cpu/armv8/generic_timer.c
> +++ b/arch/arm/cpu/armv8/generic_timer.c
> @@ -19,6 +19,10 @@ DECLARE_GLOBAL_DATA_PTR;
>  unsigned long notrace get_tbclk(void)
>  {
>  	unsigned long cntfrq;
> +
> +	if (gd->arch.timer_rate_hz)
> +		return gd->arch.timer_rate_hz;
> +
>  	asm volatile("mrs %0, cntfrq_el0" : "=3Dr" (cntfrq));
>  	return cntfrq;
>  }

If we do a size comparison on say imx8mm_evk_fspi, we see:
               u-boot: add: 1/0, grow: 5/0 bytes: 68/0 (68)
                 function                                   old     new   d=
elta
                 get_tbclk                                    -      32    =
 +32
                 timer_get_us                                44      56    =
 +12
                 static.get_timer_us                         44      56    =
 +12
                 udelay                                     116     120    =
  +4
                 static.efi_stall                            88      92    =
  +4
                 cli_readline_into_buffer                  2452    2456    =
  +4
               spl-u-boot-spl: add: 1/0, grow: 3/0 bytes: 52/0 (52)
                 function                                   old     new   d=
elta
                 get_tbclk                                    -      32    =
 +32
                 static.get_timer_us                         44      56    =
 +12
                 timer_get_us                                44      48    =
  +4
                 __udelay                                    64      68    =
  +4

So I think the CONFIG option from before was part of what we want too.
I think this happens late enough that we can do:
#ifdef CONFIG_WHATEVER
	return gd->arch.timer_rate_hz;
#else
	asm(...);
	return cntfrq;
#endif

Yes? Thanks.

--=20
Tom

--PES4pRsLb1zvnNDw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPfV7wAKCRAr4qD1Cr/k
CuIPAQCZnItRqlSUHdVaK7lG8EAJRVBDgskB/URZ+Hu+mCBxWAD/Q9y0TIbo3Q2C
qjnpBSTu0di+lzSz9wT4I9kZNHAwLwI=
=WRkz
-----END PGP SIGNATURE-----

--PES4pRsLb1zvnNDw--
