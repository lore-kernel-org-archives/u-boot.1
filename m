Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4507ACD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 18:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91FBC848A9;
	Fri, 22 May 2026 20:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FJKy+2Ti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ED49846D0; Fri, 22 May 2026 20:35:44 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19C82848A9
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 20:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4856128f670so191564b6e.0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779474941; x=1780079741; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8XpxUqJM3QyV1w5bjpPPZqOGyKdGFEh4Gt9C4LtAM4U=;
 b=FJKy+2TiTB2BS+kIK18eenmZlC29VXelZoJfcRVhUbE1vIS1iQiiAIwt0vvcW+zm0x
 jN87ouBgbzaKfLxUF4ZDzkqu9fAFBnF2xYg7w7LY6xnUaxuD6pobbFBbx2vdHg6s3Pu8
 0VzSqSgOwzCfh3z1bKiQ1Q7WdM134gZtHfugA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474941; x=1780079741;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8XpxUqJM3QyV1w5bjpPPZqOGyKdGFEh4Gt9C4LtAM4U=;
 b=f/mMt22Esksgo/hkguzAJEwOwTr4tnO+hdIui+/VtV3rNmMmZqsG/eRKRVA0LqkIFl
 U9Ipz0XDbIjW5t3OAsAkMrA48IOEuyCiIK3gEWQV61waUJv23MS3mEi6/h7XosSl9I+8
 LnOyZRMLKKyav9cf2dD3Pe4e1qR28fYaCMO5360rThJCL7Bg1i8BVHdv1YS4dtXkkApc
 2KP2WSaKQpRRFHbnPDNc4ihuJxgWgwoRHMTRnlS2Nszgq+Y1wy0VKUQgVKz49+/C8wkP
 3uDpNAhOh2kGX3+u76Nxh4KexuWw8PFgnxqZcP01P2Uj9SwF4LOBUzPKzMRjM8+jENdf
 J+Iw==
X-Gm-Message-State: AOJu0YyLzgKpxYLYnTZ4/QAESyiefTbZRiqF70UVQQL70Eu8DlaCsIRJ
 5pl240ZRXDJ/klASo+fHwnO8xeRo1zJVBimzxRtRajHwUd80A6NXggjl/r+AUNXEccg=
X-Gm-Gg: Acq92OFZCZ8lwvxzy8OlPZVBniRahgKyojDx/SvfRDJi/gpnQNNQcUw1PLDB+ujyeUM
 QTpyZ32GTjV5eT5J1vZIuHUgc2vwCgM1ynQ2I8xAV/AxE0JHvtVQuvVF15OczCrb2WaOdi8Ocoh
 ljcc+vycGvS0LT2KGvGNHVhhofmolquC6LVKExcqt+i+lJjNRUomt8QC0IprmxMz0aEgAskSuJo
 +GHaBvxYAJvrMB8SBqaV4biWFbcixfukaQ4cFY5a7uKfEayPjVuNB+UG9IR6gcvxJawYYR5NZXL
 qdNcyB9wjIQxZojGzrCLT73T7QH2DwVpnNr3SQvw2rY/n1NeaRD3aH76pZGKKKiUY5xpH4OCtVQ
 DYVdfnt+JwmywiuW965q/419DsldUlCsB+0xnuIxZHeqTlIfWMg8gER5mAtWiou/c238lr4V1Os
 cadjQ/d9EYSuSdx1CSmvpyLdWA8/poC0NVKxg6GeokJ7kmIOn6PCpgyK/tPomD1D0cBr+FH93Cy
 QPgzIfxBV4yWKyErx7ou40zT5KryZp6I/Mr2VsbawBCkJBgFtwPqEZZ
X-Received: by 2002:a05:6808:640f:b0:485:3a28:a83f with SMTP id
 5614622812f47-4854a28ec27mr2867059b6e.32.1779474940686; 
 Fri, 22 May 2026 11:35:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554724baasm912074b6e.13.2026.05.22.11.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:35:39 -0700 (PDT)
Date: Fri, 22 May 2026 12:35:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Josh Law <josh2@disroot.org>
Cc: u-boot@lists.denx.de, mkorpershoek@kernel.org, igor.opaniuk@gmail.com
Subject: Re: [PATCH 1/1] libavb: fix avb_replace() OOM handling
Message-ID: <20260522183537.GA1858239@bill-the-cat>
References: <20260521163248.15866-1-josh2@disroot.org>
 <20260521163248.15866-2-josh2@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zG77+sB0iZIefj+X"
Content-Disposition: inline
In-Reply-To: <20260521163248.15866-2-josh2@disroot.org>
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


--zG77+sB0iZIefj+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 04:32:48PM +0000, Josh Law wrote:
> avb_replace() promises NULL on OOM. Once it had built the first
> replacement, a later allocation failure returned that partial buffer.
> Callers treat any result as success, so AVB could keep booting with
> truncated bootargs.
>=20
> Free the partial result and return NULL. The existing callers can then
> take their OOM path.
>=20
> Signed-off-by: Josh Law <josh2@disroot.org>
> ---
>  lib/libavb/avb_util.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/libavb/avb_util.c b/lib/libavb/avb_util.c
> index 8719ede15a7..9e2e6ea3495 100644
> --- a/lib/libavb/avb_util.c
> +++ b/lib/libavb/avb_util.c
> @@ -272,7 +272,7 @@ char* avb_replace(const char* str, const char* search=
, const char* replace) {
>        num_new =3D num_before + replace_len + 1;
>        ret =3D avb_malloc(num_new);
>        if (ret =3D=3D NULL) {
> -        goto out;
> +        goto fail;
>        }
>        avb_memcpy(ret, str, num_before);
>        avb_memcpy(ret + num_before, replace, replace_len);
> @@ -283,7 +283,7 @@ char* avb_replace(const char* str, const char* search=
, const char* replace) {
>        num_new =3D ret_len + num_before + replace_len + 1;
>        new_str =3D avb_malloc(num_new);
>        if (new_str =3D=3D NULL) {
> -        goto out;
> +        goto fail;
>        }
>        avb_memcpy(new_str, ret, ret_len);
>        avb_memcpy(new_str + ret_len, str, num_before);
> @@ -308,7 +308,7 @@ char* avb_replace(const char* str, const char* search=
, const char* replace) {
>      size_t num_new =3D ret_len + num_remaining + 1;
>      char* new_str =3D avb_malloc(num_new);
>      if (new_str =3D=3D NULL) {
> -      goto out;
> +      goto fail;
>      }
>      avb_memcpy(new_str, ret, ret_len);
>      avb_memcpy(new_str + ret_len, str_after_last_replace, num_remaining);
> @@ -320,6 +320,10 @@ char* avb_replace(const char* str, const char* searc=
h, const char* replace) {
> =20
>  out:
>    return ret;
> +
> +fail:
> +  avb_free(ret);
> +  return NULL;
>  }
> =20
>  /* We only support a limited amount of strings in avb_strdupv(). */

Thanks for the explanation and patch. This seems fine but I'll defer to
Mattijs as it's his area.

--=20
Tom

--zG77+sB0iZIefj+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahCh+QAKCRAr4qD1Cr/k
CkVfAP0Zq45iRAo7MhV0+p4IzRVm+JqrlF6gTT6LYnKhJw5jwgD/e/Gfr4Nbk8UO
i9z6Q/jIjabIOX+pm5U3OLNRjw912Qc=
=klW1
-----END PGP SIGNATURE-----

--zG77+sB0iZIefj+X--
