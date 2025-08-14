Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E84CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 14:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A5A183980;
	Thu, 14 Aug 2025 16:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M+Ill0NZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9AA983987; Thu, 14 Aug 2025 16:58:08 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D448393F
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 16:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3e57376f5abso7230205ab.0
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755183485; x=1755788285; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d8szUuV0SLPlcrNt+7TlPoyB7eYxlekz4dtQeuFkALI=;
 b=M+Ill0NZoZZyjzMLdjFRaHpWzdhGQgcALnTYcg3vlqRxmkiiq5ETBLR/P2+xhw8Lgv
 9DmGk935kK4RJrPpNZIkMgN1YUE7b2Wn2/E3sV0eV13dfY0Yd0q4D+HvBRKKc3Cy04sE
 FRBTWVqHq4PeVg6AVkLb6pDlOGBMHf6wI415s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755183485; x=1755788285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8szUuV0SLPlcrNt+7TlPoyB7eYxlekz4dtQeuFkALI=;
 b=gwndvUNtJ92iQJJApqWsWlZP5kRZPpv3YAD/nxsHv1crTz9oiUJBF30W61is4t6Wk+
 lHd7AEhluCH/BnkqoxQzp8AhPtt3htURz3JNR2l81ssbDyaZ9rZGkLNzCOPKb05WQKSZ
 21fmMQPLOAW3GXUef6EvAtSiV5xzOZ/Wz7OZyNpiYXitdQIIUgUScdz3mgcRTL6RLJyx
 uxpZVjOW8H/7j2iDdqgwzfVVF4SewBymmRa5inP2WqPPux3CJJkSG2Bo8YOHuv25/xg6
 390DyFOwGwYXrXYSgt0/xJL689/7c7H+ir4SEml2cxHFKKi8qVutkQ2YmNdD1D0q1jPB
 rEEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfEIfm6kpabDGNsUujGNPjM7J71WZeZur9VRy3qGxCHF4YWMjN1aeJolJHi07ooj/F7Y1Xkik=@lists.denx.de
X-Gm-Message-State: AOJu0YzXHYdgX+FQyCOgWUTr4o2gSO2lVhYcRiBtci7pN/SkOaGOryr1
 qMRXbLSrfETwL1P2TkBn8QZeOeyTRv7Ki7UHkwLcuu8ez8bhVvEyzLzVCTBb7hFRBb4=
X-Gm-Gg: ASbGncuPryJF2zCVMrgIg6vU/DqFb/iABJnNVeIQ2dAxFM/AgmlkrmtuABBq99pah16
 DN/UJtkX0YDeKBqhL2THZtC0EpbIgAq4vTwpuDwQKWLQ3XkRg9+UV9tXS/RDK7Th6/toPPFcMdY
 sLlRm6WXGLmo/66s0jIXEJfUvYWoeIQHIAruwg44750sdQ1dM5Ad65EKGxa4eS2MKkYOHz1nZ9v
 dtxHBMWzZSw9dwpFuwyqK64KAN3piKFiBJeWhm/ur4UVCb+eMmXr9BJ3Sc5IItu6qz7KvYTfta/
 1cBK4SpesA66+lPBC9rxnzppKSv8G1LQ8LTRf4shAgNi6cjzpXQsBhPvJlx/AO9NidyyTcCuZTP
 j5sk5Lh+eK+CjdcKUN84LhuANLch7TVdq9YzcE02s+agh2dTDgmmkSquD
X-Google-Smtp-Source: AGHT+IEEXdzidY+qwqaWBtfBV2+dVSKp32Uk+qz4DMDEtEdGSNq4gXNBhfvOSkWSQqXyBdMoSW47lQ==
X-Received: by 2002:a05:6e02:3bc7:b0:3e5:3a99:97d6 with SMTP id
 e9e14a558f8ab-3e57078c27fmr69705585ab.8.1755183484648; 
 Thu, 14 Aug 2025 07:58:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e54824c1b9sm48225125ab.19.2025.08.14.07.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 07:58:03 -0700 (PDT)
Date: Thu, 14 Aug 2025 08:58:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Fabio Estevam <festevam@gmail.com>, jan.kiszka@siemens.com,
 u-boot@lists.denx.de, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: CONFIG_SYS_EARLY_PCI_INIT for PCI-attached eMMC
Message-ID: <20250814145801.GJ124814@bill-the-cat>
References: <cdfbaad3-e9ed-4678-9a65-c3561537d600@siemens.com>
 <CAOMZO5D+1v-721g5nE3NFQ4igrBHvF0rWs6Jkvm-Jo+R0QXKwA@mail.gmail.com>
 <87h5yakqug.fsf@bloch.sibelius.xs4all.nl>
 <CAOMZO5Cmgs3zUxdy_PRtE85pJLzG5=_1kReezFfKX6Xv05vHdg@mail.gmail.com>
 <8adf6ea6-e1c6-4dc2-b692-222381a02eb9@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VBUn7gpV4uBDcqFX"
Content-Disposition: inline
In-Reply-To: <8adf6ea6-e1c6-4dc2-b692-222381a02eb9@gmx.de>
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


--VBUn7gpV4uBDcqFX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 04:10:13PM +0200, Heinrich Schuchardt wrote:
> On 14.08.25 15:27, Fabio Estevam wrote:
> > On Thu, Aug 14, 2025 at 9:52=E2=80=AFAM Mark Kettenis <mark.kettenis@xs=
4all.nl> wrote:
> >=20
> > > Not without removing the 2nd pci_init_r() that is conditionalized on
> > > !CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT).
> > >=20
> > > That would require some thorough testing though; I certainly wouldn't
> > > be sure calling pci_init_r() is safe at that point on the boards I
> > > maintain.
> >=20
> > You're right.
> >=20
> > Maybe we could solve it with two patches:
> >=20
> > 1. Convert EARLY_PCI_INIT to a Kconfig symbol:
> >=20
> > diff --git a/common/Kconfig b/common/Kconfig
> > index a2f653f7e722..9119a1c0869f 100644
> > --- a/common/Kconfig
> > +++ b/common/Kconfig
> > @@ -824,6 +824,13 @@ config SYS_I2C_EEPROM_NXID
> >=20
> >   endchoice
> >=20
> > +config EARLY_PCI_INIT
>=20
> Please, do not rename the symbol.
>=20
> %s/EARLY_PCI_INIT/SYS_EARLY_PCI_INIT/
>=20
> All configuration symbols starting on CONFIG_ should be defined in Kconfi=
g.
> Only CFG_* are not Kconfig. Something must have gone wrong in the convers=
ion
> work some years ago.

FWIW, this symbol is one of the cases where nothing enabled the CONFIG
option. So yes, it needs to be added to Kconfig now in order to enable
it, now that something want it. But that's how it was missed, and there
may be other symbols beyond this and CONFIG_SYS_FAULT_MII_ADDR that I
tripped on when doing allyesconfig.

--=20
Tom

--VBUn7gpV4uBDcqFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ35dQAKCRAr4qD1Cr/k
ClzDAPwP3ftIUJEnnKz/hjG4F8+/F2K7bDtPKXCDkQPSsa4XswD+N6ZDIOccbCSL
DaaMPzNCfw93zKJDS5QCyYr8L5DRKAQ=
=+toj
-----END PGP SIGNATURE-----

--VBUn7gpV4uBDcqFX--
