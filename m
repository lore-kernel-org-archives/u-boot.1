Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5AFC27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A3286412;
	Wed, 23 Aug 2023 22:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FA7y4H4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1F8E864C7; Wed, 23 Aug 2023 22:27:59 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B09186414
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 22:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d6fcffce486so5766696276.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692822476; x=1693427276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LphW74+7BFr+DSGC7KWR8TMRQY3fhX6yDP54fKUMqWA=;
 b=FA7y4H4ru0Q+XSdFraBABRgmUX6HNOg57fKv3BiM8XB1nDrZD04M8LiZVy528xBNLS
 sT4qKQNLPEkQ6vpESP8wWWbsh3MS9sZX0L+NlVyGHGbXEh/LsaP9q/45Usm+EW7RlLFk
 1cNai02zdSJk+Pl83hzm13nFySelLiqm5XcOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822476; x=1693427276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LphW74+7BFr+DSGC7KWR8TMRQY3fhX6yDP54fKUMqWA=;
 b=fVzCEf7FN2LaWVrQP1dZSsE2pH+zUu4JlIf1rdCMsC2S3hZCjO1CQtAbGIdThj/L8/
 GU0sACuNVDSxikpAy3DVKYQmKak5EfIyhcPR1eazOiq4IDC3XZ0qfm0xJ+DzXDDyoMb/
 WiqjvQefjIHHhRVjrMk6y4UUr05UJA0JEuHsagI+kW2V6Vdo7W0X1cZ3eWHfLNmOK47v
 C9VMM473/PuvuOAJwGiCCj3CTI3H5McJ0Le+uNuWrxVQG4hyYeQtpfHLj6egAivZDOoH
 Sif2xntUQQLxnYTA84mGBpL7YHhbHzOL3gSoaKj5KI1reoRwe9AH5d1AN4cY0bYEdGxA
 /YjA==
X-Gm-Message-State: AOJu0YyzibRiPchWnIjPfj1YCl0G6Ioqd5ZyuGhgH1HT3H9TT9RulgMP
 pbh/tc+EM9vVLEnvV+MprKnQZQ==
X-Google-Smtp-Source: AGHT+IF/57Rw4y0HpqRkNJ3D4COAlN4eLNyVC+eQqlpSZPqPFJqHMvGV8g0wlu/1SFsE3plr0MptWA==
X-Received: by 2002:a25:dc03:0:b0:c5d:f2af:5a24 with SMTP id
 y3-20020a25dc03000000b00c5df2af5a24mr13811103ybe.14.1692822475874; 
 Wed, 23 Aug 2023 13:27:55 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a25ae89000000b00d1dffdd7a97sm3007623ybj.57.2023.08.23.13.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:27:55 -0700 (PDT)
Date: Wed, 23 Aug 2023 16:27:53 -0400
From: Tom Rini <trini@konsulko.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: describe TPL/VPL/SPL boot
Message-ID: <20230823202753.GD3953269@bill-the-cat>
References: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
 <20230823201400.m4l6hl7zy6x6srzd@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="boEVjMCF1iC7gXJv"
Content-Disposition: inline
In-Reply-To: <20230823201400.m4l6hl7zy6x6srzd@pali>
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


--boEVjMCF1iC7gXJv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:14:00PM +0200, Pali Roh=E1r wrote:
> On Wednesday 23 August 2023 21:57:28 Heinrich Schuchardt wrote:
> > +Booting from TPL/SPL
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The main U-Boot binary may be to large to be loaded directly by the Bo=
ot ROM.
> > +This was the main driver for splitting up U-Boot into multiple boot st=
ages with
> > +successively larger binaries.
> > +
> > +U-Boot typically goes through the following boot phases where TPL, VPL=
, and SPL
> > +are optional. While many boards use SPL only few use TPL.
> > +
> > +TPL
> > +   Very early init, as tiny as possible. This loads SPL (or VPL if ena=
bled).
>=20
> This is not truth. SPL loads TPL. Or at least it was about year ago for p=
owerpc plat.
>=20
> > +VPL
> > +   Optional verification step, which can select one of several SPL bin=
aries,
> > +   if A/B verified boot is enabled. Implementation of the VPL logic is
> > +   work-in-progress. For now it just boots into SPL.
> > +
> > +SPL
> > +   Secondary program loader. Sets up SDRAM and loads U-Boot proper. It=
 may also
> > +   load other firmware components.
>=20
> SPL initializes NAND then loads TPL from NAND, TPL initialize DDR and the=
n loads U-Boot.

One of the long standing issues here is that PowerPC is different from
everyone else, in terms of terminology here.

--=20
Tom

--boEVjMCF1iC7gXJv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTma78ACgkQFHw5/5Y0
tyyQcwwAkiMVv6SJ44aK8fbV5hAQzz0ZWwBOiA++VqVSJm/YuUXA6UL/UgTbwqTg
QXbsVUSTNXP334yo9gR3ZzSFigvLEeCQui5aVT6dEY2me/prtN6fbuB2OBJwUeoR
d8zRWCcyPpj76ohY8OWf+LQ0Tc+SV9grhlIoM5Rverzxao5tLTwLcg3hZX6tylHE
eXzn9DTGG/ozqoMNquSCUT4ZjBM/LG+AtNCGOUJyyRrGxKeMK+dSQNYG/LO7sqtr
iH6EQFX78+SEn0fE8LsKjrEvgkqWeeCTvtJwD+PjKNeymbaUy8EGIsjjSYwTIQV1
Bo6w9dVNGSalMI9tMTYxrrtzTHY0nU2qbxd9Po0a91jDsLOhxJs6cuD9AidvLS7o
HGyiDt1kdF3fXqrLYSc/+JawjYdJjbMVkFQMzRJOkNIEDNqinSi8Bj0NfEInDmg6
SNs2NNKOr4mRXXSydsh2tpTPlyNhS4ceu+3pBgpFRdI6rL4izISLwD9qwVWLFXfY
IoWfP7k3
=IzA9
-----END PGP SIGNATURE-----

--boEVjMCF1iC7gXJv--
