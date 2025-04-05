Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340F5C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 23:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B9D782ABA;
	Sun,  6 Apr 2025 01:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ps8t1D6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF2C82ACF; Sun,  6 Apr 2025 01:23:55 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A861F82AB2
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 01:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c13802133so884000a34.3
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 16:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743895431; x=1744500231; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+muveRE3ZqkypnhPcqkMyM1LXyIqIdYkxcne6FbpLC4=;
 b=ps8t1D6CtWJPq7VGTmO9unYPJqtazJmoBKKbWpcjOBCfBnjn5SKad2+84TfbvvApX/
 Fof3P0Vl4WolUCivyFkYP75qy4QgbsdamTgaMVIO+1lg8zi5YO8sH+Wc3M27KvKcDlzl
 tDqqQBRkH8wk3u51X4j5cXluPjmA00ZozaE6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743895431; x=1744500231;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+muveRE3ZqkypnhPcqkMyM1LXyIqIdYkxcne6FbpLC4=;
 b=Q6s7TWQn1LS+nkpwcxl6kX1H/GyrhVz3R0TRDmnriC6byVmTkdSqA/KOkYPwWKHJuD
 7UwyaePmBxwKs7EPByNtBR9QT0sjRuj7uQsn9N61Oz4eIPdlHwUMRP0PBP6IqJvD/wPL
 GL/RFLDA1+YTB2GFjP7vwZVOpsPozSPQWbwlFWdKlkQ6Rq7MbpStPUrP7SJ5A1lyux5q
 1beXZMBARgWkPLhB3czIqp5NAZq+LnZEt/Vnrg1zp11bRrTmf1TurBQjiQ32LfeiPtSi
 eXJbH7cxknY+vqnudy1cSVj00Ng2Jd+bu2JUlsIPm53HXHnX8FCC8ClWTdcaRXqIB/t5
 +3tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJYfGjWSY7TtN+6F/DV9guZE98Khgroe+EnqxqwOHwx3StQ8ft4+cYweJWP1EOIWBicfcpLTI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3LLGoPiubCcLUqSygjM4v7goTNwaahlBfnF7LhlsEPiKqjbrF
 wC67K65LGSb1Y1CKvnu6SKc5p4Lecf/h2jOm0k43qzNGmYECtRpKjIeUBd7E8sM=
X-Gm-Gg: ASbGncsYwOlGHb/2IuHb8vTApZqAv1n4ucFNs6clb4LBu0lOdMCtE4t0urxGBmFIGSl
 NYfbk+sLxSiS8PN+yuce7oVTQ2BxnaZMDSJYaaSEbeutMZ92O9rj7Fos/hQTZLempF58he01dZ3
 TWb4E+QVmYTl1ZU3C0fP0PIvjknksOV8LStbD6GsrLS1hf1zRC4Cgaiq+mVY3Pt6nMAHUwJpdmX
 QGWgfWfTPvKOiZp4jdIKxYXoFRZ4E4xbrj9NoyLP/g2YEmYJMAvO+ds2pvmdN+P8rMRz1scVq5u
 39DSd3eH1i/OOIjIddWmTAQMpZQTIjPIMhUany4rjIIz2IE2F2oGhxt6bA/XnL240IHsxYFi81t
 u2071Xq0u27c8P6oC
X-Google-Smtp-Source: AGHT+IGY82SejTZgNBufEbD4ZnqkA8cehf/GtcBorC8vSpNUJu7x4vJPW9oL7MhIE6/IVd9emCKkaQ==
X-Received: by 2002:a05:6870:d88f:b0:2b7:7abf:df6b with SMTP id
 586e51a60fabf-2cc9e80823emr5060656fac.26.1743895431169; 
 Sat, 05 Apr 2025 16:23:51 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc845469ccsm1393573fac.6.2025.04.05.16.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 16:23:49 -0700 (PDT)
Date: Sat, 5 Apr 2025 17:23:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v5 00/29] pxe: Precursor series for supporting read_all()
 in extlinux / PXE
Message-ID: <20250405232346.GB5495@bill-the-cat>
References: <20250306002533.2380866-1-sjg@chromium.org>
 <174234008117.1788726.14383009154862416750.b4-ty@konsulko.com>
 <10a57d25-d484-4903-8f25-e373c451bc21@kwiboo.se>
 <CAFLszThrij_kGPdFcdJLoxJLpoZru=_M_vG4eVKwdPAqDfQJyg@mail.gmail.com>
 <2ad3b1c5-b6e7-47e2-b225-834b821cc5c4@kwiboo.se>
 <20250404224801.GV5495@bill-the-cat>
 <20250405144008.GY5495@bill-the-cat>
 <20250405144823.GZ5495@bill-the-cat>
 <CAFLszTiJct7mhx5_7iPzt_4m1BZL72pp1QML62b=7R3AgBn3fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vS1OHPfcQ9qBE/yw"
Content-Disposition: inline
In-Reply-To: <CAFLszTiJct7mhx5_7iPzt_4m1BZL72pp1QML62b=7R3AgBn3fw@mail.gmail.com>
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


--vS1OHPfcQ9qBE/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 06, 2025 at 08:46:31AM +1200, Simon Glass wrote:
> (question for Heinrich below)
>=20
> Hi Tom,
>=20
> On Sun, 6 Apr 2025 at 02:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Apr 05, 2025 at 08:40:08AM -0600, Tom Rini wrote:
> > > On Fri, Apr 04, 2025 at 04:48:01PM -0600, Tom Rini wrote:
> > > > On Fri, Apr 04, 2025 at 11:32:12PM +0200, Jonas Karlman wrote:
> > > > > Hi Simon,
> > > > >
> > > > > On 2025-04-04 00:30, Simon Glass wrote:
> > > > > > Hi Jonas,
> > > > > >
> > > > > > On Fri, 4 Apr 2025 at 09:57, Jonas Karlman <jonas@kwiboo.se> wr=
ote:
> > > > > >>
> > > > > >> Hi Tom and Simon,
> > > > > >>
> > > > > >> On 2025-03-19 00:21, Tom Rini wrote:
> > > > > >>> On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:
> > > > > >>>
> > > > > >>>> This series includes some patches related to allowing read_a=
ll() to be
> > > > > >>>> used with the extlinux / PXE bootmeths.
> > > > > >>>>
> > > > > >>>> These patches were split out from the stb4 series, since it =
will need to
> > > > > >>>> have additional patches for LWIP, to avoid breaking PXE boot=
ing when
> > > > > >>>> LWIP is used.
> > > > > >>>>
> > > > > >>>> [...]
> > > > > >>>
> > > > > >>> Applied to u-boot/next, thanks!
> > > > > >>
> > > > > >> This series broke booting a compressed arm64 defconfig Linux k=
ernel
> > > > > >> (without module loading) due to changes in decompression buffe=
r length.
> > > > > >>
> > > > > >> My arm64 defconfig kernel (Image.gz) is ~24 MiB compressed and=
 ~85 MiB
> > > > > >> uncompressed.
> > > > > >>
> > > > > >> Before this series the decompression buffer was 10x the kernel=
_comp_size
> > > > > >> and now it is instead limited by the SYS_BOOTM_LEN Kconfig sym=
bol.
> > > > > >>
> > > > > >> A broken boot using current next branch:
> > > > > >>
> > > > > >>   Retrieving file: /Image.gz
> > > > > >>   Retrieving file: /initramfs.cpio.gz
> > > > > >>   append: earlycon
> > > > > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '=
0x06000000:394d3c' conf_fdt '3df16350' images 000000003ffe53a0
> > > > > >>      kernel data at 0x02080000, len =3D 0x00000000 (0)
> > > > > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > > > > >>   find_other type 2 os 5
> > > > > >>   ## Flattened Device Tree blob at 3df16350
> > > > > >>      Booting using the fdt blob at 0x3df16350
> > > > > >>   Working FDT set to 3df16350
> > > > > >>   load_os load 8000000 image_start 2080000 image_len 2000000
> > > > > >>      Uncompressing Kernel Image to 8000000
> > > > > >>   Error: inflate() returned -5
> > > > > >>   Image too large: increase CONFIG_SYS_BOOTM_LEN
> > > > > >>   Must RESET board to recover
> > > > > >>   Resetting the board...
> > > > > >>
> > > > > >> Changing SYS_BOOTM_LEN from default 64 MiB to 128 MiB fixed th=
e boot:
> > > > > >>
> > > > > >>   Retrieving file: /Image.gz
> > > > > >>   Retrieving file: /initramfs.cpio.gz
> > > > > >>   append: earlycon
> > > > > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '=
0x06000000:394d3c' conf_fdt '3df16430' images 000000003ffe5480
> > > > > >>      kernel data at 0x02080000, len =3D 0x00000000 (0)
> > > > > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > > > > >>   find_other type 2 os 5
> > > > > >>   ## Flattened Device Tree blob at 3df16430
> > > > > >>      Booting using the fdt blob at 0x3df16430
> > > > > >>   Working FDT set to 3df16430
> > > > > >>   load_os load 8000000 image_start 2080000 image_len 2000000
> > > > > >>      Uncompressing Kernel Image to 8000000
> > > > > >>      kernel loaded at 0x08000000, end =3D 0x0d3b5a00
> > > > > >>      Loading Ramdisk to 3cb51000, end 3cee5d3c ... OK
> > > > > >>      Loading Device Tree to 000000003cb3f000, end 000000003cb5=
09df ... OK
> > > > > >>   Working FDT set to 3cb3f000
> > > > > >>
> > > > > >>   Starting kernel ...
> > > > > >>
> > > > > >> Do we need to increase the default SYS_BOOTM_LEN for ARM64 now?
> > > > > >
> > > > > > Are you using the 'booti' command? Can you post a bit more cons=
ole
> > > > > > output or a script here as it isn't clear what boot command you=
 are
> > > > > > using? For now I'm going to assume booti
> > > > >
> > > > > Above was using an extlinux.conf with bootstd, not using the boot=
i cmd.
> > > > >
> > > > > Use of booti cmd is not affected as it continue to use a 10x mult=
iple
> > > > > of the kernel_comp_size env var for buffer size.
> > > > >
> > > > > The change this series introduced was instead of the 10x multiple=
 of
> > > > > kernel_comp_size now use SYS_BOOTM_LEN for buffer size (320 vs 32=
 MiB).
> > > > >
> > > > > And because cmd/booti.c was not converted there is now two differ=
ent
> > > > > handling of this decompression buffer size.
> > > > >
> > > > > If the change to now use SYS_BOOTM_LEN was intended this need to =
be
> > > > > changed as it has mostly been irrelevant for booting Linux on AAr=
ch64
> > > > > boards prior to this series.
> > > >
> > > > We need to clean things up such that the path which is using 10x
> > > > multiple (and we lmb_alloc an area iirc) is used in all cases.
> > >
> > > Looking at the code this morning, I was confusing this with what we do
> > > for compressed FIT images, oops.
> >
> > Ugh. Simon, can you go and fix this whole problem? Both do_bootz and
> > do_booti have non-trivial amounts of code that's missed by changing from
> > calling do_bootX() to bootX_run().
>=20
> For do_bootz() I believe the current code is correct. It does call
> bootz_start() and then doesn't call it again when bootz_run() starts.
> It looks like you have taken my Ubuntu test so perhaps I can add a
> bootz test for another board in my lab.
>=20
> For do_booti(), the code in booti_start() is used for the
> non-compressed case, so I believe it is still needed and that bootm
> doesn't currently honour 'Image' relocation when using an uncompressed
> image. But then there is the issue of SYS_BOOTM_LEN, below.
>=20
> bootm_load_os() has code for ARM at the end, which I suspect needs to
> run on RISC-V too, in case the image needs to be relocated. Marek
> added this 7 years ago[1] so it predates RISC-V and Heinrich perhaps
> didn't notice it when adding his support , if it is actually needed.
>=20
> SYS_BOOTM_LEN is a 'last bastion' security feature to avoid people
> loading images that wrap around memory, etc. I could put bootm_len
> into struct bootm_info so that a 10x value can be used for the booti
> case.
>=20
> Tom, we also have the issue that you haven't taken the rest of the PXE
> series (due to the lwip case), so our trees are out of sync in this
> area. It would really help if you could take that series, and again, I
> am happy to do the lwip case once it is landed.
>=20
> So for now, if people agree, I can do a small series to use a
> different SYS_BOOTM_LEN for the booti command and perhaps add RISC-V
> as above.
>=20
> Later, I could continue the boot-unification effort, e.g. delete the
> booti_start() function. and incorporate the uncompressed case into
> bootm code.

I'm not sure your reading of the situation is right. I'm more inclined
to revert this merge rather than take on more rework in the area.

--=20
Tom

--vS1OHPfcQ9qBE/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfxu38ACgkQFHw5/5Y0
tyxtfAv+KB6od1iBFpygoxNO6QaH3q21B04X7LgENLeujRm6XfUTsj2ozZyUO9Iu
/z4NYBNUKIy1DqMrqA707chYa9HFpxddLJkSFRQaJIz6PNooUFOxnIk59f9G0LR7
onlTRf1mYxjnjq5SX4eAk7a2IeyzihJ8JgoCvkwnQkDBagIMs/BrjLY1dFNIsbJ1
o5ZgzoajDbk7HBCwpbwUhFmES8LFF+g8As++rtG+Z2gawUIOwdlLnzVr1UAp3hT2
g0pV7a36TpPpWrkUFdUC0p8vze+ZaC3IfrBIMzT8qtWu2qHZJp5M2Go5mUhF2NSd
Fbw5Gb7Dg4u5cicjHr5fwr4sEVraRukp0NmVZHEDSpoF15U6bwQBHE9qDsOJXv6n
oJiPmh+6U5WhX7ZdZVQ753JDcJob/eBsvSeXuySvsoL1CnvZNwH66OW+LWpkdRaT
mUXb5NloMGXKqOFr+pibW+V4H1ezVPwWjOnbQLp2U2c9+BmP+SgVEmOTC67q0ayG
IXClbhFr
=Rz+B
-----END PGP SIGNATURE-----

--vS1OHPfcQ9qBE/yw--
