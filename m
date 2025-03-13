Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B81C35FF3
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 16:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 418F580F9C;
	Thu, 13 Mar 2025 17:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cqs1pQVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A62B80540; Thu, 13 Mar 2025 17:03:17 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1154081870
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 17:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7c0155af484so149317185a.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 09:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741881784; x=1742486584; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6cQhcOO5DFdeeVS9r5MXep+a+EVlCjhbG9v2LtSnpDM=;
 b=Cqs1pQVyWvWcK4gtq0JIkGsODJt6l7vKfx67pKPTpbxo6RDEFWBRj86DEWMKEG+4xN
 qeJC7FjuZTOmuvqLxjxaLMDlyyBdyU/ecRcIgNiVN8NBBCvl4OH29NmQPFXU6LVzQJ2G
 uEsedeJJcUlN3yvD7OiHBfsMr79LQMwmiwX0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741881784; x=1742486584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cQhcOO5DFdeeVS9r5MXep+a+EVlCjhbG9v2LtSnpDM=;
 b=phIfsutfziJjaYOaGkNTbrWJuohP6LwgqsZ/u9ENjOXc/zhfXhkUde7vnj2P4AVGN+
 FuIOb8+F6oJmAtI2Lrptu+b9dxdr4vgZ5YiUzeyExc26ORnxUTRczh9BsANgbIQAXaLx
 VvKp85PZ/KhH+7AyzfjFOHkbnKdv/niDTIuiHXj5hgnj+Rz46Bg4Lu3zO2V6p5Qdoa3Z
 eQptM05XcKMLjGOJ/1xGc5cdPB/EThUyjEWpJeLOOg6Tg8J28mYUkU91WDCNFtr7ArcC
 q3ioymghGJMi+fwwOdAN4//CIhsExF8YJOLuBB0yILQ3OctnLjDayKkUO8nxjo6a2/e+
 1JLQ==
X-Gm-Message-State: AOJu0YyJGR5nbKNVlf4dPRL8xJ4jwDo2Mluf/UdWx81tSx0zBIFC46a/
 wYZCUfdYRkzDM5GhkXkFR+1dyRLAcsYE1fdEAuohMIEhRFzDBwldn8PUD6qhRVRd6SdPuiSQd8I
 A
X-Gm-Gg: ASbGncvk4oYCIuUEU5vZjy3g0W2paxK6omXddmgLzw3GoKUQ54nuCWp2XaKRZoCwQHv
 wnAYNZagpAOw20tE9SIIs3aGiCsL4GbMuhwlEVH5qfiz5DVP4Eb81I2rfW+wgz06r2KGqQBOsP5
 5ZWzukfzekzqsa+aM1H9qSxKMwEVk6PhVUib8CKuU3JSm4P+C/OX465vp7IslUW9k3/zNXvYBLZ
 IZjVud5O0QVSXZadIhf87Vi4UJ3P4KDqVqu8hFYoV2HuXYZF4X7/GUBL6pqSX+UL++j6x04N03G
 AY6vj/fvvvGbjUHpFGXEgvr7AGMtUFFsC6cypS6X7umwrg==
X-Google-Smtp-Source: AGHT+IGvcRwTkeyMltIH1apAnmehjee/sAYgrPK2eF01rjO6HQV8Pu29uFXz7l92SPCC3vPOM51eTQ==
X-Received: by 2002:a05:620a:84c4:b0:7c5:5e16:cbeb with SMTP id
 af79cd13be357-7c579ea93femr39480685a.3.1741881783743; 
 Thu, 13 Mar 2025 09:03:03 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c4e8b9sm115520885a.2.2025.03.13.09.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:03:03 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:03:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/3] doc/develop/codingstyle.rst: Expand to include
 CONFIG_IS_ENABLED and PHASE_
Message-ID: <20250313160300.GC2640854@bill-the-cat>
References: <20250312010021.1671010-1-trini@konsulko.com>
 <20250312010021.1671010-3-trini@konsulko.com>
 <33389606-0c16-4d26-b7e6-44e4f973d29e@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8UZd0KOMBB80C7YJ"
Content-Disposition: inline
In-Reply-To: <33389606-0c16-4d26-b7e6-44e4f973d29e@cherry.de>
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


--8UZd0KOMBB80C7YJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 11:20:09AM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 3/12/25 2:00 AM, Tom Rini wrote:
> > Expand the conditional compilation section to explain when to use
> > CONFIG_IS_ENABLED rather than IS_ENABLED and provide an example. Next,
> > note what the PHASE_ macro is supposed to be used for as well.
> >=20
>=20
> Ah! Then ignore my comment on Patch 2/3 about the missing CONFIG_IS_ENABL=
ED
> :)
>=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Changes in v2:
> > - New patch.
> > ---
> >   doc/develop/codingstyle.rst | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> >=20
> > diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
> > index 7211e4e4eed1..3303fff165de 100644
> > --- a/doc/develop/codingstyle.rst
> > +++ b/doc/develop/codingstyle.rst
> > @@ -192,6 +192,23 @@ inside the block, and check it for correctness (sy=
ntax, types, symbol
> >   references, etc).  Thus, you still have to use an #ifdef if the code =
inside the
> >   block references symbols that will not exist if the condition is not =
met.
> > +In the case where a symbol may be referenced with an xPL-specific Kcon=
fig
>=20
> Please provide some information about what xPL means (maybe a link to
> somewhere it's already explained? doc/develop/init.rst:Board Initialisati=
on
> Flow could be a start? Or maybe rather doc/develop/spl.rst which seems to
> better match what this is referring to?

A problem is that, ah yes, doc/develop/spl.rst exists but needs to be
renamed to xpl.rst and expanded on too. How about for this patch I
change this to something like:

When working with xPL (see :doc:`spl` for more information) we need to
take further care to use the right macro. In the case where a symbol may
be referenced with an xPL-specific Kconfig...

And in a follow-up patch start addressing spl.rst. And that may get
slightly blocked on splitting out the patch that allows the HTML code to
have redirects automatically. I figured that out for the pytest docs
RFC, so it's just a matter of making that part standalone and posting
it, I know how to do it.

> > +symbol, use the CONFIG_IS_ENABLED macro instead, in a similar manner:
> > +
> > +.. code-block:: c
> > +
> > +	if (CONIG_IS_ENABLED(SOMETHING)) {
> > +		...
> > +	}
> > +
> > +When dealing with a Kconfig symbol that has both a normal name and one=
 or more
> > +xPL-prefixed names, the Makefile needs special consideration as well. =
The
> > +PHASE\_ macro helps us in this situation thusly:
> > +
> > +.. code-block:: make
> > +
> > +        obj-$(CONFIG_$(PHASE_)SOMETHING) +=3D something.o
> > +
>=20
> Please highlight non-English words with double tick quotes, that also rem=
ove
> the need to escape special characters like _, e.g.
>=20
> ``PHASE_``
>=20
> Looks good to me otherwise,

OK, will do.

--=20
Tom

--8UZd0KOMBB80C7YJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfTAbQACgkQFHw5/5Y0
tywUSgwAgp0+CDuvpMDk1E5bbL3Lsk1EgXlGpXfuRcpdMbeL/FaeYHdcQ7Wo2Iep
ymKqsO11xzOIpoYqxb0X6ACGo9YPiFEcz948X4c6kGFnTEbVkjleZdjsZzvnm9IJ
eV7ycHovX/rRf2r5vQdFV1Nrj7E7hOER/M8YLxOfPNJ/WSLohGg7DxKJmv91mxuq
dJh5LlIppckQylrRY7OGnXOzQ4IqQFyGnKcKuu5Vr5jL5ou7n1E23y2KHRAPYpls
9ws3iHX1sbJ0sGIY2AfORRECJrxvD9T+ahUxVLLon5I4JwPkhN7qQB/5+KsH7iOp
weckTMy4uKn+xpY/mekJ0bjzASVeDKoLyox8r/eM+6ostBWD3qVgFrWKMBrXOz/t
yQbaubkUHzvpnWDCbfbIy2eIr5ozV/5lDqwwUcPQYqhWw8rcVTXESQaNfUMEKNjx
RdXxsFJAzhQd8Qtj3+oGl3OwNj1nB8TNjy7PVhwWlIKpTEaPGo7gV2hOULQ2tAM0
ARg95+4D
=lbwt
-----END PGP SIGNATURE-----

--8UZd0KOMBB80C7YJ--
