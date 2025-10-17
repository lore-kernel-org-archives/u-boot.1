Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99403CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 20:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C4A8382E;
	Fri, 17 Oct 2025 22:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hGjI1Qr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1065883835; Fri, 17 Oct 2025 22:40:48 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D4D6836D1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 22:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-43f554ed252so1251381b6e.0
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760733644; x=1761338444; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ofyQHRapJFUtcSlum6XqIGjbY3MsPLMUSv+hCRMxzfs=;
 b=hGjI1Qr4RmhA1HQGulzOM/EZejG/IN9LSBGBgOdujtuuDg80ZQqy86fpxdcpW3Iawe
 uxZ/xVR8IULLtZPrTZq24BKE/jgUFTtj29yOHSnU6/eB/cSJbe2pW4I/ryXJW9hb+AjZ
 rqtxWqUmhSkG8RLdqBi9+IwfpbgiLCRPX0ehc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760733644; x=1761338444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofyQHRapJFUtcSlum6XqIGjbY3MsPLMUSv+hCRMxzfs=;
 b=StPN1ncztYFaeg4+hiu3svtivuYgtnJPjpreXl7zAf7cEKVmMQlW3+SNSzur2I40iC
 +5Xi1gW7wQUt+hDbjwKAJo27ccr08AjPAC9H16ZQOs8pMAYZby02wJZP9Ojv6lT4nb9r
 dsIXgmOBHBgj5kCnjsfkT5ba7puc0Bdw2jp9mBhHa/dUR4ZQKSMdHEj4i0jDcm8I7YS7
 Vg6nQJszblMVZfjcK1JGyhIlOOyGHAac8kkQQOR83NO5zh6kNcSFYgpHWBPcs16KihMS
 CrhY/CIYWUeDO4Gv7vi1OsQ6b7dO1DRS/3scEUXbzQrl51ubUPc8lbXJo570OSw/z/fQ
 C+ew==
X-Gm-Message-State: AOJu0YwXZomKXrjURoaREwg7HDQREiuHxoLjmYzrMHp5vhGaeC1Hr4/T
 D2G+N1FEIKOzSa6IqDMITmptAVBFw+AtPPhSk2gACNL2N3yZaJR2bhbcJZ8qz3kKTt4=
X-Gm-Gg: ASbGncvmj9MP99HNPqIJeUrCngtIZ6IPau7n2TcXVI0kNojlYJUM2lSFyYfXIqpDiya
 rNMwnL0yUPwUUHtWAGLzZFrcTRqy7+1tUP3a4qm6u6isefnjFnwE6FIJrPGn+Op5PFOy5Ilj9Uq
 rttNe2oohqw/eI2CdtPQvdiyVbhlYPGccJPyNwzdggbbVoSWy4BSJsNkjpouPPpevCCBL2KLpA1
 u1i8QkM87dDT0VrrnvvllDiG1pQPF8wJ4e3hb8vJG/TeK72f4277QOHk3lgDLtLt9uOA1CIrPrA
 gvI7wN4+H4J44fGMb+kejOROoWGxDCVnkgeeNNojhtmM1v0XovbQVCjDgmGxxun7pT7vtVIdyWg
 wwEdEHJFALfIn4lHELPohkUCRdiVP+2Fygm2mRmv+ql+0RVanDc7E8Z2oNDvpQ7o73E+Howyoku
 D72yF3umcwK6WYH27rZhOTq2UicQkCBJUP8nNaLWyyDW88bHkUIA==
X-Google-Smtp-Source: AGHT+IG8NOILYqTtNh59A8X95jWMtt6ojOAXEr90qxXQTEwaVCWtRwUCWRQHE9TmTfSnYxpDlKNi4g==
X-Received: by 2002:a05:6808:181c:b0:43b:8b5e:d127 with SMTP id
 5614622812f47-443a2dfa07fmr2706945b6e.13.1760733644098; 
 Fri, 17 Oct 2025 13:40:44 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443debfe8f0sm132435b6e.15.2025.10.17.13.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 13:40:42 -0700 (PDT)
Date: Fri, 17 Oct 2025 14:40:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] armv8: implement workaround for broken CNTFRQ_EL0 value
Message-ID: <20251017204040.GI6688@bill-the-cat>
References: <20251017-armv8-broken-cntfrq-v2-1-1e043cbb657e@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qDx3EHW/MWlJWAa2"
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


--qDx3EHW/MWlJWAa2
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

This would impact coreprimevelte (as it's the only ARM64 platform to set
gd->arch.timer_rate_hz) but as it's also a Samsung platform it's likely
in the same broken situation your platforms are.

--=20
Tom

--qDx3EHW/MWlJWAa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPKpxAAKCRAr4qD1Cr/k
CrZqAP9eymrkOEbKcDLXCfGjavdu3y378HzOul+Cy/dKJK10jAEA7BleS/a1T1DO
LkKMoT+K5tFi7jf2TL0kRZAgnVaqvQQ=
=D9Q/
-----END PGP SIGNATURE-----

--qDx3EHW/MWlJWAa2--
