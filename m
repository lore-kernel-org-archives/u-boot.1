Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404D5C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 15:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95A93829E7;
	Mon, 28 Apr 2025 17:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W5G3KcNL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 557EC829E7; Mon, 28 Apr 2025 17:40:06 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A0B828BC
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 17:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72a4793d4e2so3744970a34.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745854802; x=1746459602; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vaLXVCTQUXx+S3L82F4uAUyi+45x/vBpLIzm8bY5WsA=;
 b=W5G3KcNLc0UJtIM1ZkjnKrQtpmIGWj2pYUataKAz+RtVJ6GOUZCZTBA9jNXZhgvLSp
 Z6bJFufyeGCnTw7q+qXu6FUXXUiSeyxFoWNfB1reu0vgNrRKiLHW3VNG+jdxGq6fhBrg
 79isAs3ALraiqM9j5j1x3+tk/WUtuy62wivFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745854802; x=1746459602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaLXVCTQUXx+S3L82F4uAUyi+45x/vBpLIzm8bY5WsA=;
 b=kjZk1hBMGjI/DSHiW22Ml7yjMvYv6WocQs/JPL1IG/wK7E1mgRuDyNnyh54Qx0BO9F
 ObI/S9sNgFTIPKOYEGE/JHy2CsLmM556T0uK8vilbJo32FSqYasiNVYoDzS8EBlElKmk
 dqGpATCpfy+CuT7N3RCwrfCe/kjlm5nzQ04erSeagYtYyz2mOaOS3v+1pAxyVZy0r0MX
 vd6vQi3j2VP0PLuexK75QdVaO3Gr673cmpeCMj99MvBFhFTTsoxhMSANX7nHcD9aqgA1
 8dXkIMdnHxbuyK4QMy2f3N45DXfgCjknve65LyEkITkX6zDZJoFkwUphTFTt8ucTIvOO
 VE0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0MDurYB+Yrw3IbEO1JWC2ueU8ZM4B7J7y53a5q6vq3eeIfsdh6hzoP6a88uZAO56pE/8cGqo=@lists.denx.de
X-Gm-Message-State: AOJu0YxvDeLSu93I4/Y0Zwp6iHiHDiBOcN4OS6B5Q1wNHlf2bGtxxkTC
 mCs+4VJEv6pHyiIrUmFhoQ12ep5ATpe4TKLjLOdWvxY9bDXajF9F5kYbLBIpf49vO+a+dP8FkHn
 p
X-Gm-Gg: ASbGncs6xmXcWagn0eaL2Y/rJPRzxhSn9xBdma7w5kb/640XI7Ym2IqwbC6fyzxwmsc
 m8iPDR7wTT8ceiXMHFUASw/novsgtdjieGSi1ueSU36yqstmEXkAEorGtFKn1R6lgjGOEpT8kEi
 U4EcvKjTmrTB9FHzHsxfl/qRiUXM8h2hQNhN1o8KeK+FMEp+wQ3mkX/gwMEVDAHMCGostRqh9sM
 dxnXtbEKP7o+00M2um4svotT0z8YrUfge9Lu5XAqKqLq/O36de3gIoKjWsWXZzorJPJJFi9LjZE
 214Ei8IpxP60fwXBI99b9iYsVAGcyrN+G10L3pxgxh+4WX8LOxyyR6Wo+QMK2HpM+ZBkfm08xpn
 YQA==
X-Google-Smtp-Source: AGHT+IGb7GA9tyl3dubnCO5/ljASI/M8Dfua48+sPwfoRRMHhsCChhg+dXw/61N1WAfsMJdztfbwrw==
X-Received: by 2002:a05:6830:698d:b0:72a:1ec6:d47b with SMTP id
 46e09a7af769-7305c9f9f6fmr7922126a34.22.1745854802057; 
 Mon, 28 Apr 2025 08:40:02 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f1890ccsm1820506a34.12.2025.04.28.08.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 08:40:01 -0700 (PDT)
Date: Mon, 28 Apr 2025 09:39:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Martin Schwan <M.Schwan@phytec.de>
Cc: Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
Message-ID: <20250428153959.GB5495@bill-the-cat>
References: <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
 <CAFLszTinU=6v+3OyaH0pp8snYm9BgfVrU_+35x2Az7fVs_CfYw@mail.gmail.com>
 <4aef8b9ffd41d4e36550806f4688fc18dbddc500.camel@phytec.de>
 <CAFLszTjPHBw-F0EkQJnT4TOsxdYzGH5EtRBaeRCoKGxQQ_cw4g@mail.gmail.com>
 <20250424184923.GM5495@bill-the-cat>
 <CAFLszThPcJjhBVLvz=EkdeEP1K948cC=LyZhBk_Upk3iSWXCig@mail.gmail.com>
 <20250425143752.GU5495@bill-the-cat>
 <CAFLszTiYCObeLy+HPnpXSE3yQ20ZN-+hptoi_nYT4DXimjHFYA@mail.gmail.com>
 <20250425161935.GV5495@bill-the-cat>
 <bae7beea84e9854b1f9cd6141eedbdd6d16f8026.camel@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PenpoWZBtRk5HLm1"
Content-Disposition: inline
In-Reply-To: <bae7beea84e9854b1f9cd6141eedbdd6d16f8026.camel@phytec.de>
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


--PenpoWZBtRk5HLm1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 08:25:37AM +0000, Martin Schwan wrote:
> Hi Simon,
> Hi Tom,
>=20
> On Fri, 2025-04-25 at 10:19 -0600, Tom Rini wrote:
> > On Fri, Apr 25, 2025 at 09:03:17AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >=20
> > > On Fri, 25 Apr 2025 at 08:37, Tom Rini <trini@konsulko.com> wrote:
> > > >=20
> > > > On Fri, Apr 25, 2025 at 08:35:52AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >=20
> > > > > On Thu, 24 Apr 2025 at 12:49, Tom Rini <trini@konsulko.com>
> > > > > wrote:
> > > > > >=20
> > > > > > On Thu, Apr 24, 2025 at 12:31:38PM -0600, Simon Glass wrote:
> > > > > > > Hi Martin,
> > > > > > >=20
> > > > > > > On Thu, 24 Apr 2025 at 06:43, Martin Schwan
> > > > > > > <M.Schwan@phytec.de> wrote:
> > > > > > > >=20
> > > > > > > > Hi Simon,
> > > > > > > >=20
> > > > > > > > thanks for the review and sorry for my delayed reply.
> > > > > > > >=20
> > > > > > > > On Mon, 2025-04-14 at 05:32 -0600, Simon Glass wrote:
> > > > > > > > > Hi Martin,
> > > > > > > > >=20
> > > > > > > > > On Wed, 29 Jan 2025 at 07:25, Martin Schwan
> > > > > > > > > <m.schwan@phytec.de>
> > > > > > > > > wrote:
> > > > > > > > > >=20
> > > > > > > > > > Add a bootmeth driver which supports booting A/B
> > > > > > > > > > system with RAUC
> > > > > > > > > > as
> > > > > > > > > > their update client.
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> > > > > > > > > > ---
> > > > > > > > > > =A0boot/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 11 ++
> > > > > > > > > > =A0boot/Makefile=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
> > > > > > > > > > =A0boot/bootmeth_rauc.c | 408
> > > > > > > > > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > > > > > > > =A03 files changed, 420 insertions(+)
> > > > > > > > >=20
> > > > > > > > > This looks fine to me. Just some nits below.
> > > > > > > > >=20
> > > > > > >=20
> > > > > > > [..]
> > > > > > >=20
> > > > > > > > > > +
> > > > > > > > > > +=A0=A0=A0=A0=A0=A0 partitions =3D env_get("rauc_partit=
ions");
> > > > > > > > > > +=A0=A0=A0=A0=A0=A0 if (!partitions)
> > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return log_=
msg_ret("env", -ENOENT);
> > > > > > > > > > +=A0=A0=A0=A0=A0=A0 partitions_list =3D str_to_list(par=
titions);
> > > > > > > > > > +
> > > > > > > > > > +=A0=A0=A0=A0=A0=A0 slots =3D env_get("rauc_slots");
> > > > > > > > > > +=A0=A0=A0=A0=A0=A0 if (!slots)
> > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return log_=
msg_ret("env", -ENOENT);
> > > > > > > > > > +=A0=A0=A0=A0=A0=A0 slots_list =3D str_to_list(slots);
> > > > > > > > > > +
> > > > > > > > > > +=A0=A0=A0=A0=A0=A0 boot_order =3D env_get("BOOT_ORDER"=
);
> > > > > > > > >=20
> > > > > > > > > Environment variables should be in lower case.
> > > > > > > >=20
> > > > > > > > Unfortunately, we are bound to the naming RAUC uses for
> > > > > > > > these
> > > > > > > > environment variables, which is upper case. See
> > > > > > > > https://rauc.readthedocs.io/en/latest/integration.html#set-=
up-u-boot-boot-script-for-rauc
> > > > > > >=20
> > > > > > > Can't you change it, since you are introducing new support
> > > > > > > here?
> > > > > > >=20
> > > > > > > If not, then you could perhaps set the env variables to
> > > > > > > lowercase when
> > > > > > > you find uppercase variables? I suppose that would require
> > > > > > > updating
> > > > > > > the client to do the same thing too?
> > > > > > >=20
> > > > > > > It would be very confusing for a user to have upper-case
> > > > > > > variables for
> > > > > > > some things.
> > > > > >=20
> > > > > > Simon, this is an unreasonable request. This is how RAUC has
> > > > > > been
> > > > > > working and deployed for years and years. It would be a
> > > > > > nightmare trying
> > > > > > to handle migration of existing deployments for an aesthetic
> > > > > > change.
> > > > >=20
> > > > > Yes, I figured. Perhaps it could support lower case in future?
> > > > > This is
> > > > > the first I have seen on RAUC in U-Boot, although I do see this
> > > > > file
> > > > > which has both lower and upper case:
> > > > >=20
> > > > > include/env/phytec/rauc.env
> > > >=20
> > > > I don't think there's any need to complicate RAUC support here
> > > > (nor
> > > > in the future Mender nor swupdate nor any other long standing OTA
> > > > mechanism that might be more easily integrated via bootstd than
> > > > environment patching).
> > >=20
> > > Let's see what the author says. I assume that U-Boot has its own
> > > code
> > > in RAUC so it might not be too bad.
> >=20
> > I mean, sure? But "should" is not "must" and I have zero desire to
> > make supporting existing use cases harder. That will make migration
> > to
> > bootstd less attractive, not more. We don't want people to decide
> > that
> > can't upstream platform X or feature Y because they've already
> > developed
> > and deployed it using capitals or camel case in their environment.
>=20
> I am not a core RAUC developer, but it should be theoretically possible
> to change it to lower-case variable names. The problem is that this
> creates incompatibilities with at least older versions of RAUC, which
> only use upper-case. And that's something I honestly don't want to deal
> with, as it makes the U-Boot and RAUC codebase bloated. After all,
> changing the variable naming now wouldn't be very *robust* for the
> update client. It is a key feature of such update clients to update
> without complicated migration precedures and I don't want to break
> that.
>=20
> So yes, it would be nice to keep the naming in line with the existing
> U-Boot convention, but no, I also see too many serious downsides that
> would justify such a change.

Thanks. It's really fine to not worry about changing the environment
variable names at this point.

--=20
Tom

--PenpoWZBtRk5HLm1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgPoUcACgkQFHw5/5Y0
tyyMRQv/ZNR//Ebux6R8ak9bG/WUOdAtJNZVFSnVSMWuUHDfeQ84DypinnqxzQUM
q6WgYOF3F52+5C0KO3mAph1iBP8KzuGIqNQDNg7yrUilsPTBUHMFIrg5eM2iusZG
87aHG6vU6T5qltWQpOqjwEPZqOhfnA9+Uqt8rkMOb7yc33nepMnYhDHUVBxtQydD
ojZzwkjWtPzjy/B8oTpkyc69ZJF1Od9Y4PTKZVw1Om/iMgTdtMc3EmT5R0CvnTvF
ejA5KNB6XA6lkGB4SSLbuxWV4R6mZ1XF5uKgxSWjc106M1K3aeuFQxoTzX5JVCMW
ySIPS5D8gQrpdib+f1MxMj6hPnerk4napO+L0DsGeyTE1KHr8HfALhqNW4yjPM4t
uWpwsoPaCIhls+Cca/9w3ji+jy/WUsMVnrV2ZUwinDUPFThX2bQ93MPzCNjnBqeG
uzYhwdIdLfaOJiGyQFsSAcBFFCV0ix4mhwkVvuqm7lZxmwAepCB0K5xQOQkBmPjj
pJxm8dvs
=KKLK
-----END PGP SIGNATURE-----

--PenpoWZBtRk5HLm1--
