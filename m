Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6112FCCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 15:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C090081D6A;
	Tue, 30 Sep 2025 17:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VDVgT8fo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0708B828A2; Tue, 30 Sep 2025 17:26:31 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07828800D7
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 17:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-4256f0fac67so57782525ab.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759245987; x=1759850787; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=alGarZWuDMLtcai34ZKxkI49E7qNRL/yeKPkoSFtwfc=;
 b=VDVgT8fojucprwjgwYBsihuwEknmKp2dy0QkJJr2I0lh+tP6Em6R40R3aVoRUiYpGl
 QFZkn12nCuk9Y/BbXmjgipgfVYhkFLLv8XcApKtgWNtMt9byJmIN1GsgUFF/Q1d/Pk8j
 y6f3eKtdhfXzfnLLnspAwUiCpGReLwG8nf6mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759245987; x=1759850787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=alGarZWuDMLtcai34ZKxkI49E7qNRL/yeKPkoSFtwfc=;
 b=TT8lHe6z/elAsLMpijQXHW/Ip6IpZfiovdQDrVFMRLhG82gIP4NPBruQ7Z+MAnVPcy
 H9k5s0ReJ3YV8xPa/T5H18GdNnLsTcg+YsULZy/l86gxvlE9UxRk7jbKoRWI5ZjM7sN0
 BOXsvyRKF52YqLu6mdAG3yJieZnuZXbtpEHbKI3W7s/S06KwfV0dJ+i5e9cSAv6p2bgu
 Xs8K5gIsK6N8hVSBgg7CMeH6UzHkF/uQQM0TAetKPjOv6ke8m9xEte6FU9xJz4196ILU
 6RGZOFzEsrtBcnTkho/eYO01WImHlozCw+Cfi+xUQ+FdgQ/5W0Kko+jFk+drtqn3fVSW
 mw6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNKy8I5u/MKzWqWnO9eXRbxguEqB5xug5sq0B9qhJ6BykgfGELu3MUiXLdTpqvFbcjklegz88=@lists.denx.de
X-Gm-Message-State: AOJu0YwntAk71jqyrzX2EOjlSeUMS2GajxhNdwDS9STsW2kIfiNMgCCy
 FsGAeKegcENDufL1CC3v5DVRnjGOH5VDNG1Z5rT8aVpenEadEO3FNyEknkxwKaPHYbc=
X-Gm-Gg: ASbGncsYFgXchsdK1scxt3dDjERTpiHaW88PDfKgiJf2HMkcpzKtHwcdTDyPgwTvrqE
 FE27RB56fSeN/Ig3RbxXpX6cJeYHbFaIpx3gpVNdmUCtAMIBh0jTsFE2vFznE3Mk8z45R+dhzGu
 T2EBiUH7c6GTDatSzWhKqSzk5VbuJIm4bs/4ye1Om+6uqlW7rKwGaeLi0JTVhH8cy1T8dP3632d
 nzWBhv94EMmYxQ61khWvcFqaaW52VTIbgLa0cqd/1Cbh8kp2SWXkGAVX20jb0Tt3osfpqmQWmpX
 Ykh4pR37OvJB2paA2NTmUOLo/WCiFrtvLwqa6wvmoWm5hW3HLABYmQro7c8dQ3k1021KyDaRXu7
 niix0kLh80nYc7lBsaHh6R80iL4Rpq8MmTfLhLXSxkiUKOtoHstn66XbGBuVekO07SDS17SomkE
 RxIVj5
X-Google-Smtp-Source: AGHT+IFY6U2o89gQfcScBJOX+puTML17x5zNNVm2h22uwC2hSxcJu3HPWMVbzyAt4fksci+HOeUkUA==
X-Received: by 2002:a05:6e02:1d8e:b0:426:790e:5cfc with SMTP id
 e9e14a558f8ab-42d815c6315mr5189595ab.13.1759245986613; 
 Tue, 30 Sep 2025 08:26:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42781e5eb90sm53207795ab.6.2025.09.30.08.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 08:26:25 -0700 (PDT)
Date: Tue, 30 Sep 2025 09:26:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 thomas.petazzoni@bootlin.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] Revert "board: st: stm32mp1: Clean env_get_location()"
Message-ID: <20250930152623.GA6093@bill-the-cat>
References: <20250917141736.59732-1-kory.maincent@bootlin.com>
 <55d0805b-dcb2-4277-a4da-f4c26b48a2dd@foss.st.com>
 <20250929170912.3bee3f9d@kmaincent-XPS-13-7390>
 <fd32f45e-a3c9-4170-8886-5a31dda0e4c9@foss.st.com>
 <20250930143732.GU6093@bill-the-cat>
 <0b7c0f03-37ec-4aec-80e7-e26de4091560@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2YU+vvlERECRjbnT"
Content-Disposition: inline
In-Reply-To: <0b7c0f03-37ec-4aec-80e7-e26de4091560@foss.st.com>
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


--2YU+vvlERECRjbnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 05:09:26PM +0200, Patrice CHOTARD wrote:
>=20
>=20
> On 9/30/25 16:37, Tom Rini wrote:
> > On Tue, Sep 30, 2025 at 09:45:08AM +0200, Patrice CHOTARD wrote:
> >>
> >>
> >> On 9/29/25 17:09, Kory Maincent wrote:
> >>> On Thu, 18 Sep 2025 16:16:35 +0200
> >>> Patrice CHOTARD <patrice.chotard@foss.st.com> wrote:
> >>>
> >>>> On 9/17/25 16:17, Kory Maincent wrote:
> >>>>> This reverts commit d37641c61ba212241c38e3fd22f0335fc0bebc96.
> >>>>>
> >>>>> Restore support for environment storage in EXT4 filesystem on eMMC =
boot.
> >>>>> The previous cleanup incorrectly removed this fallback option which=
 is
> >>>>> needed for boards that store their environment in an EXT4 partition.
> >>>>>
> >>>>> This configuration is OS-specific rather than board-dependent and s=
hould
> >>>>> remain as it is configurable via menuconfig. Even if it is not desc=
ribed
> >>>>> in ST defconfigs people may have enabled it in their defconfig.
> >>>>>
> >>>>> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> >>>
> >>>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> >>>
> >>> Hello,
> >>>
> >>> Any news from the maintainers? Is there a reason for not being merge?
> >>>
> >>> Regards,
> >>
> >> Hi Kory
> >>
> >> I expect to send a pull request before end of this week for master bra=
nch including your patch.
> >=20
> > Since the release is Monday, I'd really prefer sooner this week to later
> > this week if possible, thanks!
> >=20
> Hi Tom
>=20
> I am preparing the PR, it will be send today.

Great, thanks, I appreciate it.

--=20
Tom

--2YU+vvlERECRjbnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNv2mwAKCRAr4qD1Cr/k
Cqo6AP9Y57qXKwHwsm2+S+6/kuWMSsUoGJepwWE8nlxPed7RdwEA1+B/ihqA+ECO
85kZZTzJ+UlW+jKytXuWyWKJD3RZiQ4=
=X/lv
-----END PGP SIGNATURE-----

--2YU+vvlERECRjbnT--
