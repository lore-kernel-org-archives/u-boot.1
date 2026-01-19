Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2968DD29C43
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 16:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 844E8802C1;
	Mon, 19 Jan 2026 17:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gUPzOQj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C886A8313B; Mon, 19 Jan 2026 17:47:16 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A9048003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 17:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4044d3ff57bso1299828fac.0
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 08:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768841233; x=1769446033; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gA/OA9sjaP1w5wsFWanS1rbYqHz0sJb0zNPfQFKmXt8=;
 b=gUPzOQj3f8TOT/4a7AGEyZvLySZhOlisuyZuJxgw+oUt3M1v9pO23pz4PsksJi7Cqe
 2LcOa+xMTV0ewsSROmdMSYCLbDgg1MDbDBRC3fv/aydcSHG1PpQE568CLl87WUOq9Ezq
 wb/vNE1NlGxWboY1F06KPzNAOlGjSa98CApJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768841233; x=1769446033;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gA/OA9sjaP1w5wsFWanS1rbYqHz0sJb0zNPfQFKmXt8=;
 b=JUJCqTJ1Tk3bZj2mlJugTTS8W4uBXnFHtODrzZGccpiO45M0bdMl3c++pOy9vnXG35
 gS/87/wMY0ACfOyHR6crDDM/VyzZqs2lQDjM30mzXFWmht7rwInDtIjjAbB3EQFiKyny
 gU1J/U1zVveqHM0UYc7x5DfTt39im5AmyCsjD01pRzvOcRCa2mvv103ZsjccbNCW2Oh4
 NTUcHve7Bz6V5Y+IYVSGTz2V6YWxDgOqI+BN+zhnFMg78UoJtyn41PylOiUzdAItQEu+
 5iNsvSb9P33vqn7kt69T6niwC7e+uD443EBJgRmG89tjUvGr+5OsNRVw8bPQ6HEIcZk6
 +ONw==
X-Gm-Message-State: AOJu0YxZKoOiwxGtuHNdRr0m9XFTndImG1ljMSjyBeiqx7jVHCWyNPqW
 l9xWEKIGnZUoB6rYhst2GQDsuVSZhe7R5DHM72ItvjzjD8MZQ38O2r5cFB8zp2XrXOY=
X-Gm-Gg: AY/fxX6tGmjJEV8NPOg23D/1RqMxz4oaQhtM+SG1mh0s9nz4ivlAN8OCsjEQejr9pCp
 q8do8SAco2yRdLl70J/WAoX5LyMyDXwpTxLcGpXUNW6HIygl1RF9IiAOFr8bsavvfbXov8w2kQ3
 BHGWF2VbrWdOi6LasDMBy+Nu84u9SQXKhhqp+sDHqt1rpTeK+T1GGGsfwRJFzPDFquv2vV5t+WF
 DtIksRLGtNqPf2czTqZ+3hD+qucf1djbzdpAFgQIs1soar6Oanm7rX7lJ7qRyzU4ui5hI7a/PvL
 9Scr6rXABpS1rI+/0UzdxU65A4/Tty7v/A/3Azd4U6mrdhwMwCYMZndPDQFObrTgyhGYCkFPUcJ
 13d86DWxbjwffjQSlY481gZJq/CUEqGq0C61JlPTReSeCAo0AiTIjYz6AWThqQVR9Rxct5+92bN
 t48MX2phM3DSMtVI9bu1FChbt3eMX99xhCvzUYc9RBnHq9V06AfSmOm9wxDg3T5CPheoT9eDZTL
 6YSHEjF7X12yr23aXm9nz5N8kjsJVk5JXpz23g=
X-Received: by 2002:a05:6871:3849:b0:3e8:5248:2db7 with SMTP id
 586e51a60fabf-4044cfc0908mr5354246fac.27.1768841233219; 
 Mon, 19 Jan 2026 08:47:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd1488esm7373480fac.11.2026.01.19.08.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 08:47:12 -0800 (PST)
Date: Mon, 19 Jan 2026 10:47:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 1/3] doc: develop: process: Move the existing block
 about patch application
Message-ID: <20260119164710.GA3416603@bill-the-cat>
References: <20260116182335.4081828-1-trini@konsulko.com>
 <20260116182335.4081828-2-trini@konsulko.com>
 <eaf50435-53c8-4d40-b7cc-edd3551e1a25@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GSKKyQknTGh33NRD"
Content-Disposition: inline
In-Reply-To: <eaf50435-53c8-4d40-b7cc-edd3551e1a25@cherry.de>
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


--GSKKyQknTGh33NRD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 01:13:38PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 1/16/26 7:16 PM, Tom Rini wrote:
> > We have a long block about the expectations and feedback about a patch
> > applying, or not, as part of the Custodian workflow. Move this to the
> > Custodians section from the Workflow of a custodian section.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Changes in v2:
> > - New patch.
> > ---
> >   doc/develop/process.rst | 22 +++++++++++++---------
> >   1 file changed, 13 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> > index 4bfbf0eb9c63..81e1aa7e34db 100644
> > --- a/doc/develop/process.rst
> > +++ b/doc/develop/process.rst
> > @@ -143,6 +143,17 @@ reworked/resubmitted, or if it was rejected. Howev=
er, if a submitter
> >   feels it has been too long since posting their patch and not received
> >   any feedback, it is OK to follow-up and ask.
> > +Another form of feedback is about applying the patch itself to the
>=20
> The wording is odd to me, applying the patch isn't a form of feedback? I
> would assume feedback to be some interaction between the custodian and the
> submitter.
>=20
> Would
>=20
> """
> Another form of feedback can happen while applying the patch itself to the
> source tree.
> """
>=20
> help (since we specify later that the custodian can request a rebase if t=
hey
> feel like it)?
>=20
> > +source tree.  The custodian is expected to put in a "best effort" if a
>=20
> Unnecessary double whitespace before "The custodian".
>=20
> We could also add a label before this section so we can refer to it exact=
ly
> later in this patch. See ".. _dco:" in the current rST file. Not a blocke=
r.
>=20
> Looks ok to me. (Just moving text around after all :) )

To be clear, since you see in the next patch I remove the awkward line
(which I agree is awkward, but I needed to move the existing text with
minimal changes), and further clarify this section as well, I'm not
reworking this more in v3.

--=20
Tom

--GSKKyQknTGh33NRD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW5gCwAKCRAr4qD1Cr/k
CvhJAQDMorNg0qMrRCS+Cjz7OFcFE4YFPlXlsrhR9JCTCg04CgD8C5DETR80q4zD
zv2mLCmIT0ZudPuifBx/yhJ8pLonMQU=
=+vRr
-----END PGP SIGNATURE-----

--GSKKyQknTGh33NRD--
