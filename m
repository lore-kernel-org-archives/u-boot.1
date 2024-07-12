Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CD1C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3F388791;
	Fri, 12 Jul 2024 18:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ISofLIRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C29A8875D; Fri, 12 Jul 2024 18:48:01 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B7988791
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-25e3d8d9f70so1242339fac.2
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720802878; x=1721407678; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ybUb+Ps36Aupz/gHp+kxcdcvYk6censMYfEt1odRbKM=;
 b=ISofLIRNB0rp253onlrH5eE1qmUFuLpD+6s8m86np87oJtnWPtYBSFBnDfW9Xj+pN2
 yZbKomc/t7+2cLjsC2nf815TYKVsIuk9bkAaFzXEIR9xR7gvzJVpZbr8POFhwuxne6oF
 AhZZMHaxECfiXx8PET6RINC39VkMKhIWEwGZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720802878; x=1721407678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybUb+Ps36Aupz/gHp+kxcdcvYk6censMYfEt1odRbKM=;
 b=dPiOU81DOTpREtEJwarxfO0Kuyr1VmqJ74kTjOas1kI4Pw7NdRD5w6TDdn9t1EdAI9
 78fBgQH3iuQnArDhG9hogWZjAG5O0BrDtHyLBzwApDceTLE84f0AN3l+dH0ytfMJQQMY
 HezpfaqDrlI7ibjh7LtsM4HQWvjwuJQGGW7TpikLXQsHd0W4ib+RUaYBYu+19S/KXxiw
 uAgk5gUsUGLeDD8ncR51nSJO156Mqb2//1lWR9iMvl4I4tXs5NGhUbQfJysalldvcEWF
 x3Ps0Z3VXNksV8akWS4en7aqQFukwq42Bj+TBXHoPs/tMRi1TvuJt6o5uSCmx8mKFuBN
 3P8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW66laNWVuF3Kn1WAbd41xE9XjJmXatPCGhhDh2P7v5zonSOIOsvAoBJTXvmX1q/IksI+140P/Dl59lO5Kn20F/DO2b8Q==
X-Gm-Message-State: AOJu0YwSDKYcir2VGCGmBxzOfXe5pw1g5y6tJHcNdqaxLqC1evUiCRal
 mWb5W29wDmI+BMVG57CE+1RQKZdhO1lDG0v0v6kNbSL7qhQAfqlEz0aLCyXv8CU=
X-Google-Smtp-Source: AGHT+IET5VY3Ig6RZTzspM8qC2Qu0TKeGwZxr4MXbDG0Tj/x+SUOTzlRlNCpARnrw2gRYINv8+Wenw==
X-Received: by 2002:a05:6870:470c:b0:254:a753:d1bc with SMTP id
 586e51a60fabf-25eaebe4676mr10504378fac.37.1720802877769; 
 Fri, 12 Jul 2024 09:47:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-26041911498sm866468fac.20.2024.07.12.09.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 09:47:57 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:47:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC 1/3] drop unused kallsyms support
Message-ID: <20240712164754.GS38804@bill-the-cat>
References: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
 <20240710-arm64-backtrace-v1-1-5a2ba50485dd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IA4sKXCAupnFMMhr"
Content-Disposition: inline
In-Reply-To: <20240710-arm64-backtrace-v1-1-5a2ba50485dd@linaro.org>
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


--IA4sKXCAupnFMMhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 06:26:18PM +0200, Caleb Connolly wrote:
> There was some very old code floating around for decoding symbols, it's

> incomplete and is never built. Remove it so we can add a new
> implementation.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--IA4sKXCAupnFMMhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaRXjIACgkQFHw5/5Y0
tyxVXQv/U842c6GxNxS/s47f5mCqXn+EII0UBddugR2PqKsxON1SgoEYApD5Td4v
DNqxT7WeDDjEBIKQk36R7YAE9n3R2YYOgB2gMdbKjpurxWzeH87aa+7cHC87ryt0
zHLd6NnofHGFEjuzlrWoopsRURXQCIZo+pVvGwwsB7HATFWQ1j2ijmv2b+zPAUBp
k/+W8J7q8kY3gSFtXl7GHc0aNCkVzPNfbkLQ2F8DnbihWfjVlmIvDgoLRbTBuoKj
0cOITmaW2Ib7bC6azNS+WYgUkWtnDkyeSAYQQSUc+kB7zexX/IzRh1YIW6nftMNZ
0+88+YEhcuYqfjWeJUS9zEPsNz3Lf5NrXDJOr0yHGWEKrtmmWfmAh/3Fkekn1Jnc
MTa2BKdnky8dfIj1N6OZ3eE8WL/JpeTzuqqCbEv7TKGDpdagzvJKSx0rG+6EWYMC
SAGXmZZpIU3XIAL8Df8wZBzru2sxQu01zlj1Ev0Vk2WskVHDvI2gaI/REMuk1eOS
oAfyP0W0
=CnHb
-----END PGP SIGNATURE-----

--IA4sKXCAupnFMMhr--
