Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F222CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 20:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42CA783FAD;
	Fri, 10 Oct 2025 22:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KPRPUOYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AAE183FB0; Fri, 10 Oct 2025 22:07:32 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF3C83F8E
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 22:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7bc147fd11bso1736716a34.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760126848; x=1760731648; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tynS2UmLPjY0Nzf8uDBY0W/ISeaaZXclGwZ7Gm4c3z4=;
 b=KPRPUOYdWqYgaCmYf1E5INuj7ptj1lfp9zcVPnyiLIc10/buOuxZW1oQMYDgzCdMfe
 yJ9uakD+HjFMPdsqWQrYMuj5f2CUSqUHVPbswHssggvZmfuedXO3qIg8w3OeCTJps+pD
 GEWmTf22PyebwaMBgvFb05ISZxAGkDx42Jdu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760126848; x=1760731648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tynS2UmLPjY0Nzf8uDBY0W/ISeaaZXclGwZ7Gm4c3z4=;
 b=pWDAcp+fw2I0IbR7HJPFZBfsWfsDMVvkixUXZYYsa4MD0Cn11pNGmVDw+tJiAJUH1z
 zIhD+IfjHzlwpqLGmDXgxkpwZVtxYBAEDJll3QoGUtJdVet1JFPHSE9DVMTwAYVz92yp
 BU2gimdzWXHUv4iJ44BqL2ULlsWl3JDSP55dhEr532pApliFC4cK0DXgEM+I4pq/FsRy
 yfDzY4uF9Xm4WGS1huwGiz1XlKu5XwZTcYwzEFHuerkK+epj7m6I19SsGeDBMUMpT0af
 TQ65t2bPPIrofkUjoe3nxtdY9kwQsIg8CneJn1Aq360CbdAlc/kfNXYY1FvjejW1Szh0
 KW7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTSexsWXStUkrYyhUzN9AFA6Z/SPeBqzk98ytsQ+a1B1luoFvC98anWXqQZ8PUG/VEWmBWnMM=@lists.denx.de
X-Gm-Message-State: AOJu0YxPhNn5Pwo3etmiui2xxZc9SYTtgjvhBFKxBOGg7KMu40s2I3pF
 vhb0VeA0+KSfqdFeUvF0pOnQXn8rAUne2prwQw0+y22tATFE6j+MN7cyKeJ8NckfnvQ=
X-Gm-Gg: ASbGnctuZd0vJeMqHNqKNaYq1goH2LXXPCXwI69R7uGXqPFCqPptbbGsmseXuWdT4IW
 HH1bdTOwGNmUPnwIcPr1bU2ctpYGVc1gBBFdx4/YBM9mMRDDXkBN5BFbJOSjUr6XXFIfyv6conI
 rRd44kwm3JnNyHW3rVJcAD6w6BMSsWZw09tEe1hnN5nVLMxuv5kWlHEVWrsoEv+FU1Jguu6wgrB
 x0whDMwzsnwRdixqscP46QUy0NVADZK5W4iIAsY6MShljYnIDUQC1U1Bg2ObmXkKzvO/kN0CqnT
 bQgX/kDI5ZxlgU/uwVAzQLcX6nyraNxTzNmAGFr/7pU1qBRt6Wm+V41WoZU8je1/72BQZeo5qFE
 1+wRTerv8eVY5P8wcdmEUZW3bxjBHHgYEuFRDAIS0OPXskQtPfbgrQ9F7Fn1Tx0TB9ZPngm5HuY
 Ruzr+C
X-Google-Smtp-Source: AGHT+IF0aThdClQxRHnREFpyTGotZpi5O2eP3zj1QtTg5xlSLkoiKOKtlPgtXnsmrzM0oQqsvjVU2A==
X-Received: by 2002:a05:6830:6b07:b0:7ba:6165:43a3 with SMTP id
 46e09a7af769-7c0df7bf6f5mr7981024a34.31.1760126848334; 
 Fri, 10 Oct 2025 13:07:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f90fb75fsm1147628a34.24.2025.10.10.13.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 13:07:27 -0700 (PDT)
Date: Fri, 10 Oct 2025 14:07:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH] bootstd: Allow PXE boot to be disabled
Message-ID: <20251010200724.GF298503@bill-the-cat>
References: <20251010053056.32495-1-mibodhi@gmail.com>
 <20251010142835.GY298503@bill-the-cat>
 <CAJaLiFyYGJjO=BjvL3HXAfbE1V2bwB_CSkcOTC6tQTJAR_DMVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y2L+bGXoyIN6aqAT"
Content-Disposition: inline
In-Reply-To: <CAJaLiFyYGJjO=BjvL3HXAfbE1V2bwB_CSkcOTC6tQTJAR_DMVA@mail.gmail.com>
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


--Y2L+bGXoyIN6aqAT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 12:38:58PM -0700, Tony Dinh wrote:
> Hi Tom & Simon,
>=20
> On Fri, Oct 10, 2025 at 7:28=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Oct 09, 2025 at 10:29:17PM -0700, Tony Dinh wrote:
> >
> > > Make it possible to disable CMD_PXE.
> > > Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTLINUX config.
> > > In extlinux_boot(), invoke pxe utils only when
> > > CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.
> > >
> > > This patch results in about 9K reduction in image size when
> > > PXE boot is disabled.
> > >
> > > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > > ---
> > >
> > >  boot/Kconfig             |  3 +--
> > >  boot/bootmeth_extlinux.c | 18 ++++++++++--------
> > >  2 files changed, 11 insertions(+), 10 deletions(-)
> >
> > Is some part of the symbol logic here wrong? A challenge is that "PXE"
> > is also where the logic to parse extlinux.conf style files came from,
> > and I thought we had split those two out. And then there's this:
> >
> > >
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > index 2993cd7f9ba..403ce4c3d46 100644
> > > --- a/boot/Kconfig
> > > +++ b/boot/Kconfig
> > > @@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
> > >       select CMD_PART if PARTITIONS
> > >       select CMD_DHCP if CMD_NET
> > >       select CMD_PING if CMD_NET
> > > -     select CMD_PXE if CMD_NET
> > >       select CMD_BOOTI if ARM64
> > >       select CMD_BOOTZ if ARM && !ARM64
> > >       imply CMD_MII if NET
> > > +     imply CMD_PXE if CMD_NET
> >
> > This is one of the things where defaults isn't supposed to be so easy to
> > get out of. How many platforms are you wanting to then disable CMD_PXE
> > on to save space?
>=20
> I'm simply trying to compile out PXE for a board that I'm working on!
> The only thing I need is booting with scripts on a block device. And
> it looks like we have to include everything in bootstd to use it. It
> seems wrong to make the image a lot larger than needed for boards that
> never use a specific feature.
>=20
> I would agree about  "defaults isn't supposed to be so easy to get out
> of". But in this case (and similarly in other CMD_x), CMD_PXE brings
> in all dependencies for PXE including pxe_utils.

So, as a preface, it's quite likely that we do need to tweak some of the
Kconfig logic here. To help better understand the use case:
- Does this platform have networking devices in U-Boot?
- Are you wanting to support arbitrary off the shelf OS distributions?

Because if you don't have networking at all, then we should indeed be
able to bring the library part of PXE (parse extlinux.conf style files)
without bringing in all of PXE.

If you don't want to allow arbitrary OS distributions then it should be
possible to turn off the CONFIG that brings in everything an arbitrary
OS might want (for example, install via network) and still have
standard boot available for block devices and scripts and extlinux
support.

--=20
Tom

--Y2L+bGXoyIN6aqAT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOlneAAKCRAr4qD1Cr/k
CvH6AQDuN0XLiFt7MMtXpAbF7EPLkZXuCILZBNy2S7UejJl/PQD+NERfC8TD+NEL
jSwFX24Phncwr6ZoKGOVFk785y1UQQg=
=BESF
-----END PGP SIGNATURE-----

--Y2L+bGXoyIN6aqAT--
