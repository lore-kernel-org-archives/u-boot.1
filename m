Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AA5CDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 12:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA64986F61;
	Wed, 18 Oct 2023 14:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tQEENHxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DBAD86F92; Wed, 18 Oct 2023 14:56:30 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C6AE86940
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 14:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d9ad90e1038so7334284276.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697633786; x=1698238586; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IJfGpAXvjNthyNVg94AQpA6nJU9l9qjqL3qE34IYAZY=;
 b=tQEENHxWiQX0XxG9YjqMwAiu30TrALIsaLgxDQSxSL+REvwVM2phOteE9cT//KfoA4
 c0LRZ5UNec53XhDF0Ke63yDswvigSfxmfFD4bUALC5CYwHRVazRt4KMXB+ib69I69hqf
 yp0PndeqGNJsxeXTnJMLutsRoGx5TUjz1/SUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697633786; x=1698238586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJfGpAXvjNthyNVg94AQpA6nJU9l9qjqL3qE34IYAZY=;
 b=uKTbDiYBkALn+bsDXoI9Ld8nBhjRC51hZKI1RVsmZV54+c4OrClRMlrlQ0bLmSUNKY
 7x3RfLymIRxlJJec6C+/s49cKkxfVWtrtYMOsleqpcvPbtHCK5A4U/OuuPXSvjA2Os3m
 4SlLSAWj+4sGk7y0VWoWBlEDTF+YeKS05X0ivpvpeMoub/ma7r19c5apXFgAE/OW+1I3
 ZkFfZ26AoE0eY8r+5fXSZRXqgHCuKm2339DVWmX0FVMT//sKgdxe81uDEeRBCscWo7B/
 P2OvjrWMrItyN3cos3AEoZ8BlA38XI6+cZhqYN3ewtVH13W79s0/XZLIYjFdddv1LbRs
 pl5g==
X-Gm-Message-State: AOJu0YydKKdlhNtr71eSn6hPSi0bFPqXQ0lSQ4ARSGZH4vmA0pkRtlAJ
 usw60Zfuac+vH0z2gcQiPygbfycVU+a7gxnz3Dy0Ig==
X-Google-Smtp-Source: AGHT+IEkiwbPo/Lmzjaict1af3etgG9UKPmBK6Czp/z9MxNt4v4JZINzPfsntfyi+NZFJVSq+jhfpw==
X-Received: by 2002:a25:dcc4:0:b0:d9a:c61e:4466 with SMTP id
 y187-20020a25dcc4000000b00d9ac61e4466mr4636442ybe.61.1697633786392; 
 Wed, 18 Oct 2023 05:56:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 m8-20020a258c88000000b00d20d4ffbbdbsm1256051ybl.0.2023.10.18.05.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 05:56:25 -0700 (PDT)
Date: Wed, 18 Oct 2023 08:56:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 04/32] cmd: Add a few more dependencies on CMDLINE
Message-ID: <20231018125624.GR3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-5-sjg@chromium.org>
 <20231017133231.GT3119521@bill-the-cat>
 <CAPnjgZ3VWAfma9E19OSydhvKGXDk4mBA7KWL=uqVXZzD7Uxt+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a/m8ROzrHTV8XcoN"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3VWAfma9E19OSydhvKGXDk4mBA7KWL=uqVXZzD7Uxt+g@mail.gmail.com>
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


--a/m8ROzrHTV8XcoN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 09:30:46PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 17 Oct 2023 at 07:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 16, 2023 at 04:27:55PM -0600, Simon Glass wrote:
> >
> > > Add this to some more commands to avoid build errors with sandbox.
> > >
> > > Note that this is a temporary solution to expose more problems. A lat=
er
> > > patch puts these behind an 'if CMDLINE'
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > We're doing a bunch of churn here that I'd rather just get done at once,
> > make the current #27 which guards all commands with if CMDLINE happen
> > earlier in the series instead.
>=20
> Yes I did consider this when reviewing this patch for v3, but got
> build-bisect failures. I cannot move #27 earlier, since all the builds
> fail. Allowing #27 to pass is the point of this series, in fact.

Yes, I suspect a number of the other patches need to be shuffled around
as well.

> If we can make progress on the thrust of this series then I will see
> if I can somehow reorder some other patches to drop this patch, or
> move it later, or cut it down, or something else...
>=20
> I also don't agree with 'bunch of'. This is 6 lines, which enables
> another 20 patches which clean everything up. Are there other patches
> with churn?

Other patches in the series also added if CMDLINE or similar sets of
dependencies that then get pulled out in #27.

--=20
Tom

--a/m8ROzrHTV8XcoN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUv1fEACgkQFHw5/5Y0
tywF9Av/StKdxHBcxQRYG1DZY8uBEtI/mK/NiIhYSBsLcDSKZbx7LVc77ONbKF3E
mnVgMAVrA3WLs18n8aXx6fatkscY+eT1W0zyBoBVKoK3qkU1AkWGDM3TPWKafHeX
uNc+RGOIvvZB4dKx+9C64vXEFouJf0dwgeLMq+4RULP/eduiN6pX0zPPZ+MbSSgb
kQD9e3pldfiRD1LVhWWLtrRky3lEyyq2JU4NEkxfJ4+uAbgXzswAiD3QpoKLdZzA
tjgBOqq5wxyfCFuj1to83vl1ZNM/be1kF4lK65eyQhPxTKZuUFi1+uGXTJmsh/lq
ymG+cWFCZkLq3wTrNLCP3Db+RpsJ6wzaSkMDLx102v0kJMtBImxwxqa4bCignycX
G4ZS+nYmUW4H6cbLHx+/yEmnnqYVwG5CfK1F7ejMfdwn3ZjNQ2nuwL4e524LjPLW
3oWR2ZKur64NlXMtueH7C9Ne/q+ZzCji8wxOGTYKaVZrMRJSBCcD6B5AYw0hyQTV
PQBHrcP8
=Kjnr
-----END PGP SIGNATURE-----

--a/m8ROzrHTV8XcoN--
