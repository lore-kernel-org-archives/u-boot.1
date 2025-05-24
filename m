Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2200AC54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CF7183082;
	Sat, 24 May 2025 16:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TqL7KMr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B30EE8310F; Sat, 24 May 2025 16:26:20 +0200 (CEST)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB5982AE2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-52e0d047d31so540079e0c.2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748096777; x=1748701577; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xn+evyQft2a1XOsu1BvcW9uccxXS7Z8Dbq9McBlG+Sk=;
 b=TqL7KMr+qMd3ooWbeNh0+TlrKNgaywGfCEIUbvqMzBJMDyA0PAqgF9Qo86z3NzF0tu
 ECkLzE6RGcFaJbn/JUjc23c2Uxs/0oVmJ3SiE0rWLLs4njUQDVdaXulOyawE34BtPlKT
 BpRWVLjoimt39JHUz8Vmy4pDGMntbshcdpD7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748096777; x=1748701577;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xn+evyQft2a1XOsu1BvcW9uccxXS7Z8Dbq9McBlG+Sk=;
 b=wX4wcwih1hGOeASl57GFm5Ev3OutRVCT4eOtWqpjBLMsLaTfIt7RA/tMNiHfO1ngHJ
 5RC+pl0EeYqRyf7fFgcYy9PNVtpkkcl46qnxOqeVnw/fq6L3nv2bJSp//VJB6kaUkZfQ
 EIVfE6jIG+vFPLAdpL6KanlU45GbjszzSgtYP1R0u90sqGDK8zNj7eQJlQCr7r4UaUuU
 QB2OMjblX1rjjU4iATYan//VaTLlQdih4MOOLM9XSxCV7W0NOY9Fjg5TfH9EAn6SJMYQ
 6STZoFX1IVhmJzG+0llO98OrvY93uDPd30CnGESgWOh3SShVJBIrXPgmpK664w+GzhEn
 D7mg==
X-Gm-Message-State: AOJu0YxUJsL+MUeZVfEzkj4zc8aE/1sszcCHbbKumu2Ppexf/dieRPeL
 sj+m3egyvBJxaANv9D/O5knzc17QFT6I+N5GolL02R6mu2NKDKORiNX+jTFXkLMcrHDO3JAdP9f
 vhqRjPUc=
X-Gm-Gg: ASbGnctCwzdA1UZWBIfGLayTmCduZ9JpXqWV//FOsLhyIUylUnTzlMDyT0CRhsbn+QI
 rOk9D1TEfBXMdVtW6L9SfJ2zCbIlPgw8qNy1Q/vOd0NVx5lfR2WaVv/mTN8Px7/X7iC1ArF391p
 QGfeQwuLVzXl2Ki2mwDA9dkr0QMPiBznaVQ5zu9RHqLF7VoPtNs4H9LKvv2EipLHc54TAxwcA+n
 97yphu0EXIJ63gRFcRsm+zQ56qhySPc7hB21U79dHrn4h983xRf33/3+DOySC/UTvIXMj1pGXas
 qfmoYSZk4PDg6ST45ODO6Yi3i4o4UCE13T3A+bTQ9YUXAQIbZ4y/znAIcGIjwBEzUnczr6TJuC9
 Q1IuFLhju3pmc
X-Google-Smtp-Source: AGHT+IHR2rLlENCCCjETrpsKP2Ul1YX58KYk8ZkqMbGfXQaGe/yrvqfuMCnnwCdAHIPdA5JytTv+wA==
X-Received: by 2002:a05:6808:6b47:b0:404:dad4:f973 with SMTP id
 5614622812f47-406468915fbmr1468993b6e.31.1748096766985; 
 Sat, 24 May 2025 07:26:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d980545asm3434121b6e.21.2025.05.24.07.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:26:05 -0700 (PDT)
Date: Sat, 24 May 2025 08:26:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH] tpm: Export the function to set up the TPM log
Message-ID: <20250524142603.GG100073@bill-the-cat>
References: <20250524141348.965322-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/LTWetJh8YohkpoY"
Content-Disposition: inline
In-Reply-To: <20250524141348.965322-1-sjg@chromium.org>
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


--/LTWetJh8YohkpoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 08:13:46AM -0600, Simon Glass wrote:

> In some cases, we may wish to set up the TPM log under full control of
> a driver in U-Boot. Export the required function to make this possible.
>=20
> This avoids calling the weak function tcg2_platform_get_log() when the
> caller already knows where the log is.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  include/tpm_tcg2.h | 9 +++++++++
>  lib/tpm_tcg2.c     | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
> index eb6afe49e77..189a93ee840 100644
> --- a/include/tpm_tcg2.h
> +++ b/include/tpm_tcg2.h
> @@ -345,4 +345,13 @@ void tcg2_platform_startup_error(struct udevice *dev=
, int rc);
>   */
>  u32 tcg2_algorithm_to_mask(enum tpm2_algorithms);
> =20
> +/**
> + * tcg2_log_init() - Set up the elog
> + *
> + * @dev: TPM device, used to find the number of PCRs
> + * @elog	Platform event log
> + * Return: zero on success, negative errno otherwise
> + */
> +int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog);
> +
>  #endif /* __TPM_TCG_V2_H */
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index c314b401d0b..9909d9e14d5 100644
> --- a/lib/tpm_tcg2.c
> +++ b/lib/tpm_tcg2.c
> @@ -220,7 +220,7 @@ static int tcg2_log_append_check(struct tcg2_event_lo=
g *elog, u32 pcr_index,
>  	return 0;
>  }
> =20
> -static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elo=
g)
> +int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
>  {
>  	struct tpm_chip_priv *priv =3D dev_get_uclass_priv(dev);
>  	struct tcg_efi_spec_id_event *ev;
> --=20
> 2.43.0
>=20
> base-commit: bab54f5942c428be698216224fd10b91d974d4da
> branch: tpma

This is based on mainline, but you forgot to CC the TPM maintainer.

--=20
Tom

--/LTWetJh8YohkpoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx1vsACgkQFHw5/5Y0
tywt8QwAp6aB868H1yK7q/bqLWOyR124VhAwF0I/ghGc2tHwxtuK87Y+7eCzdvwq
ByM99IiDkcZ1dDEJp8QYCpFfr6nlaJHAmq7INo1/jGLQTnBaaj7BQCgaHIOuhwvA
y1EZqwmwUloQTQKRGyUntjZu8pdahdDsxRnNKMyM5CcvU1RQQNEEVKAZMTOnNgRM
15zvJ/Q2WXC2ICNQnWR4aC4q+Imm4NbQ3z0xmCwY2shKdnW1Zb+dAah7P+zzezHJ
RCKDP478iI2dlJtAJGS0+Wf4cMsPGZk0CkA2cIVKRd8Dg0xUOMm84BjaPszpE4h8
UGxvlT3h2z0GukZ5JoENktUZPVmwI4eDUNB4DkFdSavTT0cI44AxFeQEKPVR63HD
X54HdaPs0mexDAXj7OzTXdskKHI3rspAut/kHnU2gH8bXFLROd3qU9N1h6V7xD2i
g/F9wBz6ugHxYkr1+ysLdJzN7ZNTRg0JPECLJPxg9E2EMELDjfDBz77Idpa8sa/j
sKf9SP3J
=MbgD
-----END PGP SIGNATURE-----

--/LTWetJh8YohkpoY--
