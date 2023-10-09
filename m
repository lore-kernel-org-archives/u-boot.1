Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B341E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 14:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20B3A86D80;
	Mon,  9 Oct 2023 16:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tDPv9ENT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88BA186D2E; Mon,  9 Oct 2023 16:36:21 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CCBD82BBF
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 16:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59f6492b415so39540187b3.0
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696862178; x=1697466978; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=97Db99ZHVca0mm5uLKXtcJwrUe6Zmr0t2NRsjmtmXmA=;
 b=tDPv9ENTClP9osnuoauOzq2TdR8u7xcf/hYK4vzHQbU2yRHJmAjNasDV3UYIDGPcyl
 HCTrDXhCo9mQGKMVpp3d8gKrclaeswaYFywjKvyA3fSUl/e/ddSlHfOz0r58VUVkxKnU
 j4jOnZqMs6AFjinVyI+/AZFi7q6UzdAsf8OBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862178; x=1697466978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97Db99ZHVca0mm5uLKXtcJwrUe6Zmr0t2NRsjmtmXmA=;
 b=UnA+yzv7OU7s9ERPcvS4UccRhm+6PM+4Ce5tsUDXVjjLm2IbLzIWcDCVy9RM4z6Au9
 DPpHfqeTInQ1fkJBc6XFBjqZAz+w3N9R72eTMxMq2SsXhyWusltzGd2atq8Ac+qYCRFz
 H4GiOZdOHNO/d/CXyE+OFhjYgZGHwxtnLm1RUL2MFEvNw04zl9lwu0AmZ6NJAC/X9Iib
 15Fk6Vzpw0NPqRSZS93D4SsdybLUr+N/65MaE7VPBCUdb41g6r7voZ2823n7v4Aa3XHL
 OxiST2yfDUMi2ucTqakMsG20icH9XV/bGogXHKdIUCnJHY+odOoFBptOfgMzXc0F8Z4N
 SE0g==
X-Gm-Message-State: AOJu0YxJbZ0fgXrMJbjDUp4e3/WXPWDTMT1tBn2crpHRIZzLudImgrcc
 auoB3vbaM7yUydw5Z5ugSN0NhL1hrLwOnMsfTZjDHw==
X-Google-Smtp-Source: AGHT+IFsUBV/jz8GtNBs8ntruJr4dD+zxATVXO3HXTzS5cFbgqSFUOmurQVZey48vnccZJgkovDmQA==
X-Received: by 2002:a81:9297:0:b0:59f:7c95:a0cc with SMTP id
 j145-20020a819297000000b0059f7c95a0ccmr7346118ywg.17.1696862178259; 
 Mon, 09 Oct 2023 07:36:18 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fae2-bb7a-3833-e7d0.res6.spectrum.com.
 [2603:6081:7b00:6400:fae2:bb7a:3833:e7d0])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a81ab52000000b005a4da74b869sm3723362ywk.139.2023.10.09.07.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 07:36:17 -0700 (PDT)
Date: Mon, 9 Oct 2023 10:36:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v2 08/27] sifive: Change #ifdef for nop
Message-ID: <20231009143615.GN2227687@bill-the-cat>
References: <20231007231255.277623-1-sjg@chromium.org>
 <20231007231255.277623-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hRLb0wwYJNHN7fmo"
Content-Disposition: inline
In-Reply-To: <20231007231255.277623-9-sjg@chromium.org>
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


--hRLb0wwYJNHN7fmo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 05:12:27PM -0600, Simon Glass wrote:

> This code is normally compiled for sifive, but sandbox can also compile
> it. We should not use UNIT_TEST as a synonym for SANDBOX, since it is
> possible to disable UNIT_TEST for sandbox.
>=20
> Correct the condition.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  include/k210/pll.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/k210/pll.h b/include/k210/pll.h
> index fd16a89cb203..6dd60b2eb4fc 100644
> --- a/include/k210/pll.h
> +++ b/include/k210/pll.h
> @@ -13,7 +13,7 @@ struct k210_pll_config {
>  	u8 od;
>  };
> =20
> -#ifdef CONFIG_UNIT_TEST
> +#ifdef CONFIG_SANDBOX
>  TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
>  				     struct k210_pll_config *best);
>  #ifndef nop

Sean just explained that this is wrong.

--=20
Tom

--hRLb0wwYJNHN7fmo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUkD98ACgkQFHw5/5Y0
tywr3Qv7BRfBn6+qrEOdXZ/HqfiaFGYrbUcxVcLAWtFAv7znKUw03nMO36cE1rxy
y7YfS86p27kWBj1MzEBQUpJV7gVoVzvg21CQFKK0ZsxpTe5Jp1UZ/3gCz3Be3Wkr
JLas19FrPiywu+Pe9KdobC8MIgbyhE93j/fZGcmr4mJiRTtsvGM5fct2Z1UPQOju
2pj28YgbwnP+6wX3MZ42jOMvLipjAsCnQ7ajAH8fMcf1rTql9zKw6vMndqgR7jnd
yfmWjV9bhw2KKyqhiyGyG7rEVPGH2yG76cR03HSxu9JvX6b5ngGv4OmBUuhS2Xti
EMpMR4PGM6AlTU6wsixX3VWMnU5OPXovMuLkGUkbcC64/AviMy74eIdBZ4yVfaYO
dFN6Hdl5sxLS3tZ0LZBhFmI6Si4pvWXPRdKGMfYRLwsQBu9ZGNRH/0zDN9ppAaIO
mukQAtNMQrCfA75m9KZnUYSqw6BG1zEiTQma6pMwxT3g7e7L9sEIqngyOySbfmqB
3+FDMXLM
=B4BS
-----END PGP SIGNATURE-----

--hRLb0wwYJNHN7fmo--
