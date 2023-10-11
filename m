Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9FECDB47E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC98086E2C;
	Wed, 11 Oct 2023 21:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qLmBPHFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A46486DD9; Wed, 11 Oct 2023 20:39:53 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B00F86DF6
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a4c073cc06so11245327b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049481; x=1697654281; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sxMSoK4RZXo4dXd/1Lumkt584bobu1G1kjcV3Rc8bcc=;
 b=qLmBPHFpXZXYv0WmjoYyEysmSzI3bFAJ1lXMVeCekKEv5TI/pmXj3W6Qkpnnn/2E5p
 T78SEUoFgHNvuuGvidHib67D/QDQh+Iy1+W7cmwDFtxTmOVfD0y9A1fhF4n1REOWsYfs
 rO89wtzfeEPO/WNdJRUMGy9h8u+k4LQpxk9TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049481; x=1697654281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxMSoK4RZXo4dXd/1Lumkt584bobu1G1kjcV3Rc8bcc=;
 b=fmJtG/usZ8Sr8SD9BKtgnPMHGkQX/eHCU6m7eZu+fr5hnv2UsSjNq5SLNuf7NFi+pI
 dVqTYxuLRQfCAWKscn/WCwgxIvDBITVPN0qElET9VADWUmsD41ydrnH1UN+qud3gxv2C
 F0lvrdVOlFv+5WPx8gr9L6D9zz5cTQXpWr6WIwGTk/0T6H8ph0PPtDZDuigzCC1z7VRC
 6PDsVzziuvQ8d3dtgfB9qUYQKHa1vBRMZ2lctXRWPYwmtK4vpUr+O6rTV9veqyNtcPZ+
 oY+SznsZnly4skXZX82lI54eUvGBRjYl4qq3A5up5Y5YTAJweVSy9Uil9P1mcun+XQui
 wtbw==
X-Gm-Message-State: AOJu0Yw1dUGnXnacTk8Z/SIUIn0ynqkZlBYa6r72m8WURn1h/dlimnFy
 swkIS8Q1e2sxD7BRpXUN2a8JAg==
X-Google-Smtp-Source: AGHT+IFpPCzVi83378hlXvxJVFt7qrbmo3gS2kuRBv9wRVvmpf5G9OR1T5gkBubn91ESlOR7ECJVNw==
X-Received: by 2002:a81:4e10:0:b0:56c:e480:2b2b with SMTP id
 c16-20020a814e10000000b0056ce4802b2bmr12772818ywb.12.1697049481084; 
 Wed, 11 Oct 2023 11:38:01 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a81df04000000b0059b1e1b6e5dsm5257562ywn.91.2023.10.11.11.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:38:00 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:37:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH] env: Improve ENV_OFFSET help message
Message-ID: <20231011183758.GA3119521@bill-the-cat>
References: <20230901142859.1569900-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y5HjIKXktV/q62QQ"
Content-Disposition: inline
In-Reply-To: <20230901142859.1569900-1-paul.barker.ct@bp.renesas.com>
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


--Y5HjIKXktV/q62QQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 03:28:59PM +0100, Paul Barker wrote:

> When reading Kconfig help messages to understand ENV_OFFSET and
> ENV_OFFSET_REDUND, developers may not realise that they need to also
> look at the chosen ENV_IS_IN_* options to see how the offsets will be
> interpreted.
>=20
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--Y5HjIKXktV/q62QQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm64YACgkQFHw5/5Y0
tyyrsQv/Z4q29OlBZj6vk/lNfTNuE5s+WbgzUKEPbf5tuBpm664TLtFJUxdNsWrj
NrTuzDOwvDbAm2oSNAFihGbIWEiC1uXZUoaHSzfYSNisJWDUr3bTo/ilat4Yx3mD
TmhHcIZlQs2nhz/zdbglKSyyy5T0Y807Knxalt+8THK9/sJtbSRoDqmoX1DcHJKz
qQolAwRFAwEj5cmti3aGo9yWjgkoAVXwklT4FmTKYDHJ1THZy3r8K8VYiDfrMTGJ
fqJKH2pvhq/Vt/FQm07NWaigrD1Y2cXC4yBXHJavc1JJG0EWY9wyxJ7BX6DBxsMa
Gph+A2xco0tVDJ9re9CumMpoVzkS1Yoe5zdYXFS/SYug8uR9+i5GNxVTWXWgowgG
F/mt/YPIs2FlpMjRybUu1BkweFwNwMnNbyAvRf7lkA2tnoJiJN6gGHdrFvhT/3/6
ccmcCZrmgFRC0MK7xcLXR3AR6SbKG4oTmBcisbtdCQSTVUVZdnbpF08noUL/SFCr
FSKnxoQh
=JPSm
-----END PGP SIGNATURE-----

--Y5HjIKXktV/q62QQ--
