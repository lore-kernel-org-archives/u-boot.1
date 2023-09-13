Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12EFEE020A
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 19:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D780486AE1;
	Wed, 13 Sep 2023 21:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eyQKpqBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA3E686A82; Wed, 13 Sep 2023 21:24:34 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1931086A61
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 21:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5922380064bso1895397b3.2
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 12:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694633071; x=1695237871; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R8/j4NwfSuBG88zftYSZebupgQ8GVhpp8BZlaxD4gW8=;
 b=eyQKpqBFf/SNPn9ZjfIay7sBjuOmZkMusjdNxh1nkp8nII2XIif2lQ+q/1wZT1xw3x
 DYwWR9qic0bAVF7eqT54kGgtihTnOltL7dk0JELbTlyskf/c8y85aFLyuOZI+MvE1zRQ
 whMmd7AhCzZ4HDHQ6so+V46jF1WSgZP8f9Cs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694633071; x=1695237871;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8/j4NwfSuBG88zftYSZebupgQ8GVhpp8BZlaxD4gW8=;
 b=URZmIVELNsrwE1bo6Lx7xymz6OJuEPctMfKsHUPFKtknXuOr67dKtSVTJdi7Bt0R30
 r/8g8UzfsQSjA5ss4oJG9OLxipUNq+1/YTL39LqXoDZhLfuX5lCP+Uz5SxRhf3MWpdNO
 5CcJF5AnBAXncXK5/vtw4sLCpyZsKeZt0W7psdhoJaLSie9C44FVrOg/kJkII4n1vCTm
 nvbL9xQ+se3eQvtRpSNf1wh2dLQpIpSLqjKRNXFnq6UmhcuHLIZT+pDjsAk9OyJBc1dI
 ccTx+dmjtfq2BSzpG7fTSKBl6+AiFZtd/Q7Bxlh3PaU49g62+1nAaD2dxB5UwS0Wxx0U
 ymvw==
X-Gm-Message-State: AOJu0YyvxhbL5EtOuKJH8VjjkdGsp64mkbTn0rMMBQRM4K+rnGwdAtDb
 qG1elw8JoRAi38jLu2gOXM4MdA==
X-Google-Smtp-Source: AGHT+IFAdTZCA2u1mt39/NACKUfVoNpGuSQvKB6b0EylDeyYheyz6rNWmZbdeT2nqHT9yEqo9PG2dw==
X-Received: by 2002:a0d:cb06:0:b0:589:f603:4b9b with SMTP id
 n6-20020a0dcb06000000b00589f6034b9bmr3664610ywd.7.1694633070869; 
 Wed, 13 Sep 2023 12:24:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2580-cbcf-c7bd-45ce.res6.spectrum.com.
 [2603:6081:7b00:6400:2580:cbcf:c7bd:45ce])
 by smtp.gmail.com with ESMTPSA id
 h62-20020a0dde41000000b0057a918d6644sm3281326ywe.128.2023.09.13.12.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 12:24:30 -0700 (PDT)
Date: Wed, 13 Sep 2023 15:24:28 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>
Subject: Re: [PATCH 1/8] tools: mkeficapsule: Add support for parsing capsule
 params from config file
Message-ID: <20230913192428.GQ305624@bill-the-cat>
References: <20230908120002.29851-1-sughosh.ganu@linaro.org>
 <20230908120002.29851-2-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mVSS6fEv6dHfILDC"
Content-Disposition: inline
In-Reply-To: <20230908120002.29851-2-sughosh.ganu@linaro.org>
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


--mVSS6fEv6dHfILDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 05:29:55PM +0530, Sughosh Ganu wrote:

> Add support for specifying the parameters needed for capsule
> generation through a config file, instead of passing them through
> command-line. Parameters for more than a single capsule file can be
> specified, resulting in generation of multiple capsules through a
> single invocation of the command.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Is this config file format used in any other project / form?

[snip]
> +config EFI_CAPSULE_CFG_FILE
> +	string "Path to the EFI Capsule Config File"
> +	default ""

No empty defaults.

--=20
Tom

--mVSS6fEv6dHfILDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUCDGwACgkQFHw5/5Y0
tyxfZwv/QvjxG60zBeXQ/JRCzNFYiT5VHQwy+WRtELvQuShOyCA6Ye6mWKCXpcPX
9VAWvfJlAvR6AhJFGoBdyBeh5rdcXqmD5kAOEX+yNyH/xaNHV5mmbi+py2NkDgMU
LWKbB5qCTt1gHOs0kWyQJRfHk3ixN8Bh2xmY/G99LzGmxyOneHaNuHV8HpHRjnHt
kIoc/XTmqcWviCDiKk0/W7K6PDllodT/ZDJ3KdyfeQOtDZZfY2hMrbDK14ldGh3E
edyQFEcLDvvQ1s8Jb9suAWHk7YbSvsJ42KI5xsmofhKpujBPsIL8/UDQ+JuAZ7UY
dwoVUwJK1F+Uy9RbPEgEJBSNK1mMGZMjn4iPIrL4W56a4T2ssL1Ul/6SB90pus7s
k2SYuJ91C6pW70o+utL24Iyzeu/5oSaRUwln0mYwCz0V4cM5TVkdql5EUg01cCP/
QIe+D/4U1sK/nrhgYAUOqumF0h4nDW2ADVUMLaZmcLGGZOKCZrdfloGoBGUAEFrQ
Fy15eQHR
=orjv
-----END PGP SIGNATURE-----

--mVSS6fEv6dHfILDC--
