Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507D6C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 18:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADD7C80243;
	Thu, 23 Jan 2025 19:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jYjJ2kYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5158680214; Thu, 23 Jan 2025 18:17:17 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18DD280137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 18:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-46c7855df10so18222951cf.3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 09:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737652634; x=1738257434; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qe13KPQhioQeHld+CYpcZTovt5JvXGs5eh5IkNRHs/k=;
 b=jYjJ2kYrIODnaeUqnpSEHWyx6CZePHYNcSYQaO69jgwdOSDA0CfvL/XEBd5lriBQ/9
 pDN/YozsNWWQRQBeh8CQRtOrfthMCJIvpcMum3v1jXY5lBm66p9MZCiCgucrUpTHPF9G
 66taYE+RN0CWU1wqEeExgRUFDdaPpZmlGjW5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737652634; x=1738257434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qe13KPQhioQeHld+CYpcZTovt5JvXGs5eh5IkNRHs/k=;
 b=UVXIiLILpa7qoHNroRBPaxaqtLWrpS151q+NKjWKt9gfopxNkFAwhw5OWxguU8PfwW
 Wh/X+dWsqFXRHaRnpEGdtnNL81kVkhe9pAgMD0rQCQomWYaxyPdSfKvkgi9M2coG/etA
 +RBPn0g4eLQS6up2BVfzDkiM75rrJKaE9NhemBAPSQcOZOx7OYgnJoHx5rHNZy9ntMzY
 2mxfzdM9AW2Oh2BP+BwiAoAD+ywQrEbBmAvl4ulRKyXGgDnL+K0N4gec9DQ+kmUaOwhN
 6QvM3Rgvf18t6K6J8BW90Wl8ypQEVolqDm31L1XC784U7lH3a2GwACfqGTj9+g+4XUU/
 Acnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk8cZ5flEbef1rIHs9COkeFf1xueeOyrh735YTiEF/YlNafsi+RJ2qwxLHA9VzWoDy7C69QN0=@lists.denx.de
X-Gm-Message-State: AOJu0YxNR2dmtuTcldwbGQHfMeKza1r29yYv7ciRcOLle9zSgBuIY0ii
 LsEhpoyoqF1ahYEmu90Gudx5rk2ron80IaqCTMy83yrHqd/KGMoqKpKUaIylAtY=
X-Gm-Gg: ASbGncu4lN7TmBZnibZBXcdyxmnHtc8EKTGu3z64oHd8fLqrfBvtivj+r0IlMWcA642
 xGe0vGk35b4NC6bPCsgsj7Vz0QjQdda2eXP/6KgXs+uZArA9dxo5mACRHvjIm6rC+sxbEmhejuA
 a5F2SjOsctcUOBjq2t33sHnGlareY7Xlt3dKzIV8LJT4AKbVnFeWvWJNeWFVIax1y0BfkrmGYeb
 zw84M1TB1Zt6HJufPhyV+W2llP3oz2pCrQjeAbWDWW78LrlEgwihgO4It/+9eXX6bbbfxIo+XXY
 9cPR
X-Google-Smtp-Source: AGHT+IH+Rd91Pj/oc9O7yWVzyYZb9GmMC0qLjSM5B+t2OjYnAvHM/PVmOHZOM58WIVRGbwcqfhLinA==
X-Received: by 2002:a05:622a:38b:b0:46c:7646:4a1e with SMTP id
 d75a77b69052e-46e12a62966mr438527051cf.13.1737652633877; 
 Thu, 23 Jan 2025 09:17:13 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6689d9e1sm906211cf.35.2025.01.23.09.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 09:17:13 -0800 (PST)
Date: Thu, 23 Jan 2025 11:17:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v3 00/19] bootstd: Support recording images
Message-ID: <20250123171708.GN60249@bill-the-cat>
References: <CAFLszTgFdNrRev+7n6j+NqCM+em_p-ONAc=+sztoYaP50HUivw@mail.gmail.com>
 <20250115212439.GD3476@bill-the-cat>
 <CAFLszTiSSq-+cSxVgxLJ8atAAjjxRP2AEQmXMbrf+c3FOepnFQ@mail.gmail.com>
 <20250115233157.GE3476@bill-the-cat>
 <CAFLszTga3RD95M2ujLfuXQor39sfcQrEUe3hwRKABiWx04PiZg@mail.gmail.com>
 <20250116172159.GH3476@bill-the-cat>
 <CAFLszTigN+s1T0hjJXnkE4ucYafHCtabPFHh=gCFpro2WrLnpg@mail.gmail.com>
 <CAJaLiFw3j1FTT25mNd_5Pk-UTCaNL=R2GmK0+m_VoCc7Yc2PRQ@mail.gmail.com>
 <20250118144132.GW3476@bill-the-cat>
 <CAFLszTi_5s9L9zYz-EZpdM9YVdV7TdhrnxPm9K8VeZEa0tHpag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qmotElmfbC+rg5Ve"
Content-Disposition: inline
In-Reply-To: <CAFLszTi_5s9L9zYz-EZpdM9YVdV7TdhrnxPm9K8VeZEa0tHpag@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 23 Jan 2025 19:42:05 +0100
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


--qmotElmfbC+rg5Ve
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 07:38:04AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 18 Jan 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jan 17, 2025 at 09:49:43PM -0800, Tony Dinh wrote:
> > > On Fri, Jan 17, 2025 at 8:32=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Tom,
> > > >
> > > > On Thu, 16 Jan 2025 at 10:22, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Jan 16, 2025 at 08:52:38AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 15 Jan 2025 at 16:32, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > [snip]
> > > > > > > I'm referring to the whole bootmeth/bootflow/etc thing. Is th=
is going to
> > > > > > > be put to use by anyone / anywhere on PowerPC? M68K? MIPS? 32=
bit ARM is
> > > > > > > a harder question there, which is also where this particular =
overflow
> > > > > > > was.
> > > > > >
> > > > > > I'm still not sure what you are saying. Are you wanting to disa=
ble
> > > > > > bootstd by default / go back to distro scripts / force everyone=
 to use
> > > > > > EFI_LOADER / ?
> > > > >
> > > > > Yes, I'm asking where it's appropriate to enable this new functio=
nality
> > > > > by default.  It certainly should be enabled on arm64 (there's new
> > > > > designs) and riscv (there's new designs). It still ought to be en=
abled
> > > > > on arm32 because we otherwise lack a easy way to say "new" arm32 =
(say
> > > > > i.MX7) and not "old" arm32 (say i.MX23). What is the point of ena=
bling
> > > > > this on PowerPC for example? The active users there are (generall=
y)
> > > > > supporting legacy hardware and I have no idea how much they want =
to
> > > > > change their boot process, once bootstd supports flash for exampl=
e.
> > > > > There's similar questions for everything else under arch/ as well.
> > > >
> > > > To me this is in fact two different questions.
> > > >
> > > > 1. For PowerPC, m68k, MIPS, I suppose we can just disable BOOTSTD a=
nd wait for them to go away, if you are saying that they are behind on migr=
ations will never catch up
> >
> > On what migrations? A board that has a boot command is not some legacy
> > non-migrated case. That's a valid regular use case.
>=20
> I'm referring to a board that uses distro scripts.

OK. Just FYI, "distro scripts" weren't a thing outside of ARM (and maybe
RISC-V, and just turris_1x_sdcard on PPC?).

--=20
Tom

--qmotElmfbC+rg5Ve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeSeZQACgkQFHw5/5Y0
tyzbXwv/VdGmXMDo35ExjCoyuQCsuONIGIeS8/HlXQ+kfVnR6ezzb70ueAZ17ZJ8
GwAeOhNtraqHJc3w6gMub+5Qvy3duM67YarcvQ/+MlHMNhEpgIC1rMWy4owjeBDJ
IMYPF0e5YK3eAoGoFNQFI0mX8YJ1E1A3UrYmFLmWa8HW1ftUMoHn23v3NIg1EXlN
hiXXKwQh2Eq0bbwu3SRFVPTnBO+oLNVQfOErA8JwL5loFZEcGkKCsAIPVQGZmK5F
xCzolDUCurlvCnxXRgHh9pvlfO5jcZ+bmLiPQUvIDgkWk/BPNiGfI4uLh8fTIkkd
+8erfT1Iqihms2AdUvcH32BFRigDTe0GpF5ZEVycsqCwcWNAZglpuKJ8Cij0VsXJ
bgiBVtI+YRmzEZt3/UULvP8j5iyEoHpri/KBxd6NxP0Tyqmhry08XT+zzE7feEOP
SyySj17R+W25OTU4KGkWJqJAxgtjm+8X8Vv+k3MUT2gJ9T83clyh7br8gArrAd1J
3u/g6F+r
=Wrif
-----END PGP SIGNATURE-----

--qmotElmfbC+rg5Ve--
