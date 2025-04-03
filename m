Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D203C36018
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 00:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BADB9810E8;
	Thu,  3 Apr 2025 02:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nEgNwLZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B2E81DE3; Thu,  3 Apr 2025 02:28:01 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C40448035B
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 02:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c173211feso139034a34.1
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 17:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743640077; x=1744244877; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lOQoo8wA372IL7qKotTqCK31aevlT97+uu2avhP6eAA=;
 b=nEgNwLZwPSFiB6nnFBxrRog6nps9gwkkU2RDWDVAnYztlX+QAun0OgIKpz9d5lXpBt
 vNQzhvlxsXU04ctPXPDreP3G5jIL+tvDvSIEaa/dTUXzl6JOLJXViRdombHEaVPGQHuL
 lv/rIJepC1EXz6F1PgHvDeeK1OlnbXkfkUk44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743640077; x=1744244877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOQoo8wA372IL7qKotTqCK31aevlT97+uu2avhP6eAA=;
 b=aEALANn2SMwAwv8by2FF1urRVUqjMbg+rO7RVFUBUIIxwBrFOHSCgCrdS87RUCKZ5I
 nrHT50ESD/SJ6hlAdCrfQGV21EPs51gEPNHvZYTyap+5XL7LP0PrkGNQgbZnPcne0XaS
 9DCEVl9c74DwZPBac5Dc/OSWhovBOMFMMSrdZUdjh6GRQivUNJv3yffB8OpshAlzqXG+
 Fzf7+kTxn/zBPscClQYSavsXwyA8zZbwXHorVlUwWapfsE6zLNgdnxEevHRdNmVRxn0R
 FOeD4HEy/jFjzEuHLSA3+GxITFIdP9ny4rAFgHeVi3+4unXWlmiE9cExVC08ylg3PxVb
 qONA==
X-Gm-Message-State: AOJu0YxgAiwfCUeEnnRwqOpk5KmdagQDJT5+Tx0IXVtEsR7UW/MDDY+0
 zWXMKDQch/MLoGyD3pd6a0CC8SeDOIugD6qza68R3Q9U2577zm39sS798miJFEA=
X-Gm-Gg: ASbGncsFg7976KqFlhUVIOzBmkht91OoAPaz/gNznGFPnk6SFNvd4YH6xmQFd84ilNA
 8qF++RQFNSY6oDFpRlFEYtxBDePbdwuyZl6yuvNX+Oe8DQQPcuModHqMXDO9831F7Rx8hJRTSgZ
 fV2gaMNtD+vhBIIkbAclc9aIrFy+7CJ1SITDIVOxY/fmOzpsrr1k4pwOuVy3184vtEbQnFR8MB+
 /FrzKH597i4ZbLxzjX8GKILEYZQ1U7Cmpn+Ij0vu632JAejKJJ4kiLA8ImhWtZmgaAtatVhyP0U
 dfcadDed8b8jDzZi3MN3mwabyYHEQuxKlTfrnceMUsXEPaYIEz+IPctRJEJW26hsu1w7iOrigex
 dUXDSwQ==
X-Google-Smtp-Source: AGHT+IGLZ6aWJ6erm3zvqMDu/+skFUSy+/cmHXLX9GvZzM4d17ryZFOYSyOSmEC/9GdfemWnrKJD8Q==
X-Received: by 2002:a05:6830:6992:b0:72b:9e3b:82bc with SMTP id
 46e09a7af769-72e2ee7507amr511729a34.11.1743640077431; 
 Wed, 02 Apr 2025 17:27:57 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e30500de7sm36802a34.8.2025.04.02.17.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 17:27:56 -0700 (PDT)
Date: Wed, 2 Apr 2025 18:27:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 00/13] video: Enhancements related to truetype and console
Message-ID: <20250403002754.GH5495@bill-the-cat>
References: <20250401172948.1236000-1-sjg@chromium.org>
 <20250401214113.GP5495@bill-the-cat>
 <CAFLszTjJuY9pQDerNuFcmkRuZbJU+EfPSBTrDyhjFMZg+usPnA@mail.gmail.com>
 <20250402150024.GU5495@bill-the-cat>
 <CAFLszTh-N2PSKPV_OHa63mEi1ar6Y9+p+A4UTfTbf329wOiN9w@mail.gmail.com>
 <20250402211100.GD5495@bill-the-cat>
 <CAFLszThRQi2o5g5S+=eciOS8+XC8TV9AyBpYf9LQKmH-2kkmvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9HXG6LatkBcLBTQx"
Content-Disposition: inline
In-Reply-To: <CAFLszThRQi2o5g5S+=eciOS8+XC8TV9AyBpYf9LQKmH-2kkmvw@mail.gmail.com>
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


--9HXG6LatkBcLBTQx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 12:54:55PM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 3 Apr 2025 at 10:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Apr 03, 2025 at 08:19:03AM +1300, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 3 Apr 2025 at 04:00, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Apr 02, 2025 at 01:08:56PM +1300, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 2 Apr 2025 at 10:41, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 02, 2025 at 06:29:31AM +1300, Simon Glass wrote:
> > > > > >
> > > > > > > This series includes some precursor patches needed for forthc=
oming expo
> > > > > > > enhancements.
> > > > > > >
> > > > > > > - truetype support for multiple lines
> > > > > > > - make white-on-black a runtime option
> > > > > > > - support drawing a rectangle
> > > > > > >
> > > > > > > This series was split out from schd2
> > > > > > [snip]
> > > > > > > base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
> > > > > > > branch: schg
> > > > > >
> > > > > > I get as far as patch 4 before it doesn't apply to -next.
> > > > >
> > > > > Your tree is missing the video-damage series which adds some more
> > > > > tests. It is here if you want to pick it up:
> > > > >
> > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D369663&=
state=3D*
> > > > >
> > > > > I can rebase and send a PR if you prefer.
> > > >
> > > > Reading the cover letter again, that doesn't seem ready to merge ei=
ther.
> > >
> > > It seems OK to me. What are your concerns?
> >
> > The cover letter read to me like it should be further reworked to
> > address some of the problems it still has / exposed. That's likely why I
> > marked it as Changes Requested a year and a half ago.
>=20
> Which bit of it? Are you talking about my conversation with Alex, or
> the actual cover letter?

Yes, I'm talking about the lengthy discussion in the cover letter which
sounds to me as a summary of "changes requested".

--=20
Tom

--9HXG6LatkBcLBTQx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmft1goACgkQFHw5/5Y0
tyxqOgv8DMfmiypxOrIKSyfl9XN122AE8gekzo22H2dowSVk1IWDTJLuz/dXS/5Q
GPvvucCfflV4GAtnvjn3/qXtolNrZqIA6wL9L+zDM+gHBy2WvkDkY1eMFBcalpWP
ozBa1T6+d/dw0bWb0zMD/qNabSILrVcreNy/Oo4edfD6lYxF11bslu8ZTe6I8fkU
v2otErM6bodISbjFd2VQ3WVcFaophvdYsTiGxxqhNUfSLAvpTFlPTfBmiYfolu1P
EThYS/2jrWbbfBWQ8BM3BRVpQKZdQbdERtPS2mLPw2KY2jXn0S6DDSgTRmJDnzmM
vrkS9DJXoODTKUM0XUgaBajwoEWeHw+uRGHpX1AHKmtvK/qJrM25Ilhakmn0SaFz
ZFJwBhOhCR9DkLMnXRcB6L14TbFpgyofuykhW31ndiaNcleCHJI5pUkemgwe9vRY
X/hefmbaRAnKBv8whTgjmVshABaFkcJGSULqDj/Ub80j0utNvnkUVur+lzN2bA0n
LziaVbwc
=0fiu
-----END PGP SIGNATURE-----

--9HXG6LatkBcLBTQx--
