Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F1DC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 14:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE73807D7;
	Fri, 28 Feb 2025 15:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ETYIAZAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA460809A5; Fri, 28 Feb 2025 15:11:38 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B20801FB
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 15:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2234e5347e2so44140475ad.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 06:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740751894; x=1741356694; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QQovj0ilEu2p393dN/AZTXssqAgTtSPgDS6egMLcJoo=;
 b=ETYIAZALbZC6Gautic9SuUJPp+cyfgSqgRsfYJ1NCoZGt+q5hLxVX1JbxPGVtOIdy2
 QVlz/6/4xb6KoYKlLkbYssKEkkBORgeVjY859cXBQm2OlBlfNv45KJBKr50dKjIQe+g8
 qhnFTwBL3ztp3HTlxt0lgWqIjjC71mFuuQn6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740751894; x=1741356694;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQovj0ilEu2p393dN/AZTXssqAgTtSPgDS6egMLcJoo=;
 b=oMWY4cAi89IxzzTpGA18vtgM0Wroibj/YrV5imoFW8DENLp2O1QkOOzJic6rQaTjH/
 iTsrLOPoEKCKPzFqU18b3XMYNo2LkFxSGgRmfTPmVnqxIyYIWfnUcCIvkVtH1a192d23
 xwF0ItRTDB6pIuZTyeDN4kEtjxqrdW2aUn/nyoMfejSZSA7/SZzNc/YCKkgDB5OTIoAT
 WlNquKRNAx73ZY3glMJWLAx1/J9qB9ZG4yUvA7CBs3mhYiIHMnUhA+RbVX1C6L9s9ENE
 dnQSBLrYdXWw8wkzkrQCwL+kVGir9l/WtX+Gq/kmRM621wk+jouioCkUiPu9TFz659nH
 1+TQ==
X-Gm-Message-State: AOJu0YxsFg/5surVWnfdUzR4coPt0Y1ohxXtq9fk7KMLFYZ0pEJO47b2
 QaBSNVJ9Fo7P+9Em0slnHH5TFvr+IU9bTwMzNefBU6fNrGM00BrDWWEVtOBSbdE=
X-Gm-Gg: ASbGncsCDmV9HeH2on9HqS/lXO8T95QhvEps9V2NxmbDHKyV0GT1EPjTOe30umv5WsG
 xiGLHi5goQOSTad6Dr5g541yFMDQt5S4mJ5LasIoYR6BGJFYd5qi8VSC57WbhFE5AK57Vh/RsRw
 0YdnFWmmd5aW5LeKulJE4McbwraRAucKfDwsTBPiWjcDRcvHVj1QmoqYk6AxM2Xqt2TaMGu8kDd
 2XMAo5D3YpQqgA4YR2rgJUP/gAqYn5h7sXQ6qQuFL45cgSdD+eEDsRLqvtoj3MwBUAbplrlZN7Y
 kG9Iuc/LOHFhDYaHmlDJ04l/
X-Google-Smtp-Source: AGHT+IESNZ009HGOmV3KFhdS15i+MT6cy8va/KvkR8RICbfYpQXLyOs1NR0MssmEkYYlf3yvawSOPQ==
X-Received: by 2002:a17:902:d506:b0:223:65a9:ab94 with SMTP id
 d9443c01a7336-2236920acbdmr53956495ad.46.1740751894406; 
 Fri, 28 Feb 2025 06:11:34 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504c5d91sm33385595ad.108.2025.02.28.06.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 06:11:33 -0800 (PST)
Date: Fri, 28 Feb 2025 08:11:30 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tien.fong.chee@altera.com" <tien.fong.chee@altera.com>
Subject: Re: [PATCH] MAINTAINERS, git-mailrc: socfpga: Update email to Altera
Message-ID: <20250228141130.GL2640854@bill-the-cat>
References: <20250227040904.18714-1-tien.fong.chee@intel.com>
 <20250227134809.GT2640854@bill-the-cat>
 <DM8PR11MB55926C2203261A2B86614029D2CC2@DM8PR11MB5592.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iMfu7Wt7fvJs3J/3"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB55926C2203261A2B86614029D2CC2@DM8PR11MB5592.namprd11.prod.outlook.com>
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


--iMfu7Wt7fvJs3J/3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 10:36:41AM +0000, Chee, Tien Fong wrote:
> Hi Tom,
>=20
> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>=20
> Sent: Thursday, February 27, 2025 9:48 PM
> To: Chee, Tien Fong <tien.fong.chee@intel.com>
> Cc: u-boot@lists.denx.de; tien.fong.chee@altera.com
> Subject: Re: [PATCH] MAINTAINERS, git-mailrc: socfpga: Update email to Al=
tera
>=20
> On Thu, Feb 27, 2025 at 12:09:04PM +0800, tien.fong.chee@intel.com wrote:
>=20
> > From: Tien Fong Chee <tien.fong.chee@intel.com>
> >=20
> > Altera officially split off from Intel, the email need be updated to=20
> > ensure uninterrupted support and communication
> >=20
> > Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
> > ---
> >  doc/git-mailrc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Similar to the xilinx.com -> amd.com transition, I think you should updat=
e .mailmap as well for everyone listed in MAINTAINERS files, thanks!
>=20
> I think the changes are already done at next branch https://github.com/u-=
boot/u-boot/commit/04ea9147d5bdab1370ced118acf35db7ac9e281c

The various board/ MAINTAINER files aren't updated, and we should update
these addresses in their own patch for master (and I'll deal with
merging to next). Thanks!

--=20
Tom

--iMfu7Wt7fvJs3J/3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfBxA8ACgkQFHw5/5Y0
tyw/Mwv/bEV4TfV+sbvcI5tt4ijmuV9XxXGXkPZ87fqpa4b4H7/DcV4f5yon67tG
Muv95mJ7q1428Uh+oPB18d0UA3gadBKT7X74lFcLr0pbmN2oOr7tjNZdqXlUxvc+
z95DNarmgYyMqg9k0hOUGAcpvhh6EPMZKAiqj+7yCj/l2ohnhZBLgn8Mjl4Ywu40
o90/CWBLdowMEn81yg0og/hlkfcfGq8qts/S1tRCF2f3s8ihHlRB0hVdVNBzQo7o
wXA4p1aSZG6xGQyGLMvOUt4VxFY6ftylT5HQDJ+yYToLcnujliKH/Kho2gQFv2YP
Axe65J1o1ubVpfYvFnzq3+EwZSVruJcTaeRwFGnOQVlQff+/Y1wMVbA9BNqMwCG7
beHx7h7doGnfO9y/9V97nYbatiEJNBUEU3mHoGwXE3ud5zvsKC6MNCe5VGuFRWMO
H2BI9uMVqM/S7sHEIAD/G0hTACHHmh+raJqdsG9g0CW1d/MW04lGquj/2xrGugSu
oHTEg3z3
=x/3g
-----END PGP SIGNATURE-----

--iMfu7Wt7fvJs3J/3--
