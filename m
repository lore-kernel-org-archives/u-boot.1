Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3905CD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 15:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF7F4847C5;
	Fri, 15 May 2026 17:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d7j8f+Zd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 551AB847C5; Fri, 15 May 2026 17:55:42 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8BE2846A5
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 17:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso8397275a34.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778860538; x=1779465338; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ySbsAWGnqQ5ssKrfmi88LU13SbKygFHNot0v9vgUJmY=;
 b=d7j8f+Zdw0v2SdxS10fiAUrteBvK+nnVRvr8RnAl7P4SCRbQm0r60G0yipB321z4hv
 On7Fz0orcW2EcZAVrk3F+5yzYN+yQKA/bOPgbgzocmmB2FDmfU/Othu2gPucthiooCf6
 lhFkuZiYneelfOQ2WJ1sH/bAP6X8avjsJ48vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778860538; x=1779465338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ySbsAWGnqQ5ssKrfmi88LU13SbKygFHNot0v9vgUJmY=;
 b=sA1fpkWsIslTK29phH8+MfM3m2ciN/IfvYg6lJKJfca29/JozV30+svAz2iFLLVFSi
 CklD4O2znXtX6i6G1VVM7ez6TnzQEMmw+Lhn1hWnV3A4YohmqYfc8Bs7fTAAWrrE1lyA
 z40b/LK5xCctuKTFwDv/en2fpzxXmqjg33B6y0HJYycDF1BID6cTFFcHbFF6bxCu3IU1
 48MJQemXfYvINiuthy0+YTblo5IwNfdwrc4SJ/9tqYX0vVPw7Ek6OgXeojPbr8dpZZuj
 p2A6x1B5leEhaMx6MXBB1JZEKBrBbU8CtZzeCCCZajNbjkdi2WFLB9Reb2j0lZoUjilv
 AMsg==
X-Gm-Message-State: AOJu0YyMCQ317HeMzjoTK0iS9GnvzGqEnJg7qKjbkhJKQ9TlobLJKNxK
 XXPUOo/wLuJmRWlT3JKYkOidsRItwLFLBB+O605jzY7OEY+7WMpCM3IWubb7UXIB5O9sXUOPUnn
 2HcFY/CaJ80yY4nE=
X-Gm-Gg: Acq92OG+eq0nO8QMRP0eal3/XdkzZpv/BcKZhfUkiQcW/tZL12N7QAZmIUK7TW9os/4
 omdqfk8SSQK81iWI70EP8CZz+B3vRwjm0qs4P3FS5ED7Lbr0QoPNruDDKqItXg/ZwClanMc2qra
 vrVMUqOod2M3SQWCRW3GPf1/+sx7v4oQiBpwD26/JOcCWMlQTND8LXRglaQ7xWtCRAoSLW/P6f6
 q/jivKSqj7kIBi2kZJU6SyXCi7eq5G/RTcsZTXdK4bv1zUzuU8Ozn04MedjVtUjixDb/Yu+GujE
 iLk1Gkk9ZQiPYgpiVearbOttK/2iwQWkkFgZkOd7MgxzyYkRt9ht8X28T8nx25yzurEVVt5rp1V
 qXK+55Z6JZLiGn5MxoWE2HrNtSKaNhBn4iLuoERBcpovjnGARP9OvndImwvBLwWzjC136ypnzv6
 FzihcBVj4ApWG56ivFZ5u1+c9eCFOZhxLScjc42udxESgNcy0Wxj+Jx+wq50TvA29GNy0nfk4R4
 6eRWsAJzt23pOtKW2KJpUfiHZB988E3XNmc6Crgws9W3dtvRWo=
X-Received: by 2002:a4a:e90e:0:b0:684:2b28:f9a6 with SMTP id
 006d021491bc7-69c9c013146mr3088987eaf.58.1778860538511; 
 Fri, 15 May 2026 08:55:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc54217esm4281730fac.13.2026.05.15.08.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 08:55:37 -0700 (PDT)
Date: Fri, 15 May 2026 09:55:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2026.07-rc2 released
Message-ID: <20260515155535.GD1858239@bill-the-cat>
References: <20260511220555.GM1858239@bill-the-cat>
 <CAFLszThULFjq_R4A1nWYjQcQ4Odw3aZ200RPmQ56Ecf3gO4UYA@mail.gmail.com>
 <20260515141043.GY1858239@bill-the-cat>
 <CAFLszTg8HQK-tkCnGkH_Reju6frdNzPZNF6d+ekwKtWvWTrLmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pvzfve8/mACjlokS"
Content-Disposition: inline
In-Reply-To: <CAFLszTg8HQK-tkCnGkH_Reju6frdNzPZNF6d+ekwKtWvWTrLmA@mail.gmail.com>
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


--Pvzfve8/mACjlokS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 09:05:37AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 15 May 2026 at 08:10, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 15, 2026 at 06:49:25AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 11 May 2026 at 16:06, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > Hey all,
> > > >
> > > > So it's release day and I have tagged and pushed things out.
> > > >
> > > > As I mentioned earlier today[1], I would like to again thank DENX (=
and
> > > > the Denk family) for supporting the project for so long, and we're
> > > > starting the process of moving our infrastructure to the OSU OSL la=
b and
> > > > the u-boot-project.org domain.
> > > >
> > > > The delta between -rc1 and -rc2 looks OK to me, and I do still think
> > > > there's a few outstanding PRs to come in and a few things I should =
pick
> > > > up as well. But, the next branch is now open and so bigger changes
> > > > should target that and I will be applying a few things there shortl=
y.
> > > >
> > > > To repeat what I said in rc2 (and will keep repeatint) is that it m=
ight
> > > > really be time to retire support for running our tools on Windows u=
nder
> > > > MSYS, rather than something like WSL. The move to support more mode=
rn
> > > > OpenSSL versions has hit a lack of support problem in MSYS[2].
> > >
> > > I'm not really the right person to answer this, since I'm not a
> > > Windows user. But as I understand it, this would mean not building
> > > Windows executables anymore. Is that right?
> > >
> > > Should we perhaps just build without the pkcs11-provider feature?
> >
> > In the age of WSL, I'm not sure the value of supporting MSYS. If someone
> > is using this, and steps up to resolve the problem, great. Otherwise we
> > should end up dropping it. Unlike the macOS side, we haven't had a
> > report of a user in well over a decade I think at this point.
>=20
> We were certainly using this when UPL was being worked on- 2023 I
> think. The Tianocore people use Windows and needed mkimage.
>=20
> I took a bit of a look at what is involved here. Basically with WSL
> you should be able to run 'wsl.exe mkimage ...' and things should
> work. I haven't actually tried it though.
>=20
> It would not be too hard to add the package to MSYS, but that just
> makes it build...it would not actually be useful without hooking into
> Windows APIs about which I have no knowledge.
>=20
> So I agree it is best to retire it, perhaps document WSL as the means
> to run mkimage - will we be able to have some CI tests for it?

WSL is just Linux userspace, I don't think there's a need to for us to
add a test on top there.

--=20
Tom

--Pvzfve8/mACjlokS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagdB8wAKCRAr4qD1Cr/k
CmyOAQCH90H+L6amH/ahfnrHj7aG6pc+MyszTijC0S43BRSoSwEAuO3XY74YOIsC
Ht5moNRxaLnSTkoA/be3yBFZgGzzZQ0=
=xPjR
-----END PGP SIGNATURE-----

--Pvzfve8/mACjlokS--
