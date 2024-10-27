Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2517CD13572
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 18:32:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC09C88C10;
	Sun, 27 Oct 2024 19:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tBYH2QBc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5821188C10; Sun, 27 Oct 2024 19:32:16 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32AAF88278
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 19:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbe9914487so23134756d6.1
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730053924; x=1730658724; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pdP1hXxD2oZT5PcYI/ACXAbJ+9R3AXUDi61DC6zrwLg=;
 b=tBYH2QBcs3YQElCKymXcZR6VPaoQfEBRNKogBcCQEZYzLgNRnIH+d44JLwvjCzj6wM
 JLfdFuXU7S6Jtt1I+/iDGl2SVJSk2ds/b6tPR8z89BNZO9ZIp16daBrgrEOSApZP5S0j
 zyfB/vCCQQ0hC5rGRcMq2O4IFG8ACbl5JdHR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730053924; x=1730658724;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdP1hXxD2oZT5PcYI/ACXAbJ+9R3AXUDi61DC6zrwLg=;
 b=VxESiEzjcYmlTk4JR0arq9Vvj5S5qlotqkjb/fbdQRWMdbtIhlx7/7bvx+XGrFp96o
 PEcZQ90mBRaOKeSAGIlFDOJGdPcQ9eKGmM14Wbt9YCENaFFLBJgvzpKWX5if4spxkKMW
 87LjYz/lI/XfiwBPq547h9sZe2dFKsWMpR4RaA1RmLIC78bR3qh+mFrHTeKW72w4VgWB
 kjrgOevA8FfSpYjCTO0NV4C2F7lAzXvv52v/7o0x1ZaUQxGBEnWQ3YLJu47XInCUZyH8
 JhCQtCDn4CKiuZ+bTiuWltqmxI/fBkG/1PhT0kvaPM8YMfnCfiz5YsUUkTPsaLcEuHwg
 NX/A==
X-Gm-Message-State: AOJu0YyPNdkRi3yPF4VqrDcL1Cuqg3ZkW6NSsPLwuFFjyyqtvdUkHVxf
 jQ8gEshrjJe8//ppK3RnC0mmvYXOPV+4FFhvJgIjRI2Q4n+u+U1gIdPueLYexWg=
X-Google-Smtp-Source: AGHT+IH8MCDZKyh8QU9Bzy4/YgCUTJMT9M+K4wr9KaGJ/u2i0gzAWUYRbJdUe6bs8+2IIn7ADmQ93g==
X-Received: by 2002:a05:6214:5d8f:b0:6d1:7989:fc2b with SMTP id
 6a1803df08f44-6d185840b27mr99995206d6.32.1730053923934; 
 Sun, 27 Oct 2024 11:32:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17991c8cesm25616326d6.69.2024.10.27.11.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 11:32:02 -0700 (PDT)
Date: Sun, 27 Oct 2024 12:31:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: Re: [PATCH v7 6/7] test: efi: boot: Set up an image suitable for EFI
 testing
Message-ID: <20241027183158.GL4959@bill-the-cat>
References: <20241021173253.GO4959@bill-the-cat>
 <CAFLszThgsF5BL8aSGozA3nAeox=g8bVARmSaBFedM=dbLT=UWA@mail.gmail.com>
 <20241022140246.GB4959@bill-the-cat>
 <CAFLszTg3pkZ3z7vH1j-Vafmw6OKhzvLQ4=X9vd+kDzmmUjOw_g@mail.gmail.com>
 <20241022175427.GH4959@bill-the-cat>
 <CAFLszTg=DJWnMf7Lun7ga0+_J4Vw6rpf32LMkdRLSy-WY+2U7g@mail.gmail.com>
 <20241023184121.GL4959@bill-the-cat>
 <CAFLszTgQB3Axj_FQwUURG0+u+z3SM5ypo88CfBntq+xUrzfOGw@mail.gmail.com>
 <20241024173706.GU4959@bill-the-cat>
 <CAFLszThr_LSfF1JGOe8gPnkwN9amxsQ-t8mnzDV92LMuxh4esA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hjXn+KUL+QKdbB2K"
Content-Disposition: inline
In-Reply-To: <CAFLszThr_LSfF1JGOe8gPnkwN9amxsQ-t8mnzDV92LMuxh4esA@mail.gmail.com>
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


--hjXn+KUL+QKdbB2K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 06:16:25PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 24 Oct 2024 at 19:37, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Oct 24, 2024 at 06:39:00PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, Oct 23, 2024, 20:41 Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Oct 23, 2024 at 05:39:07AM +0200, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 22 Oct 2024 at 19:54, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 22, 2024 at 07:00:35PM +0200, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 22 Oct 2024 at 16:02, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Tue, Oct 22, 2024 at 02:15:46PM +0200, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 21 Oct 2024 at 19:32, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Oct 21, 2024 at 08:31:10AM +0200, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Sat, 19 Oct 2024 at 11:51, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Sat, Oct 19, 2024 at 09:24:33AM -0600, Simon Gla=
ss wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > > Create a new disk for use with tests, which conta=
ins the new 'testapp'
> > > > > > > > > > > > > EFI app specifically intended for testing the EFI=
 loader.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Attach it to the USB device, since most testing i=
s currently done with
> > > > > > > > > > > > > mmc.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Initially this image will be used to test the EFI=
 bootmeth.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Fix a stale comment in prep_mmc_bootdev() while w=
e are here.
> > > > > > > > > > > > >
> > > > > > > > > > > > > For now this uses sudo and a compressed fallback =
file, like all the
> > > > > > > > > > > > > other bootstd tests. Once this series is in, the =
patch which moves
> > > > > > > > > > > > > this to use user-space tools will be cleaned up a=
nd re-submitted.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > >
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > Here is the patch to avoid sudo and CI fallback:
> > > > > > > > > > > > >
> > > > > > > > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/pa=
tch/
> > > > > > > > > > > > > 20240802093322.15240-1-richard@nod.at/
> > > > > > > > > > > > >
> > > > > > > > > > > > > (no changes since v1)
> > > > > > > > > > > > >
> > > > > > > > > > > > >  arch/sandbox/dts/test.dts           |   2 +-
> > > > > > > > > > > > >  test/boot/bootdev.c                 |  18 ++++++=
+++-
> > > > > > > > > > > > >  test/boot/bootflow.c                |   2 +-
> > > > > > > > > > > > >  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5=
016 bytes
> > > > > > > > > > > >
> > > > > > > > > > > > This I think best illustrates the problem with "BOO=
TSBOX.EFI". This
> > > > > > > > > > > > image will work for CI up until I can figure out ho=
w to get access to
> > > > > > > > > > > > free arm64 servers to run some tests on and then it=
 will fail.
> > > > > > > > > > >
> > > > > > > > > > > I don't believe so. Why do you think that?
> > > > > > > > > >
> > > > > > > > > > Because it includes the BOOTSBOX.EFI x86 binary file, a=
nd executes it?
> > > > > > > > > > Or did I miss where we update the contents to include t=
hat file as we
> > > > > > > > > > just built it (and so why have it included?) ?
> > > > > > > > >
> > > > > > > > > It works fine on x86 and I'm sure it will work fine on AR=
M as well.
> > > > > > > > > The file is built with the host compiler, just as U-Boot =
itself is.
> > > > > > > >
> > > > > > > > Erm, are you saying the BOOT/EFI/BOOTSBOX.EFI file that's in
> > > > > > > > test/py/tests/bootstd/flash1.img.xz doesn't need to exist a=
nd the test
> > > > > > > > replaces that, as it goes?
> > > > > > >
> > > > > > > No, I'm saying that sandbox uses that file, no matter the host
> > > > > > > architecture, and I don't need to create different versions of
> > > > > > > flash1.im.xz for each host architecture.
> > > > > > >
> > > > > > > I discussed this with Heinrich and he seems happy enough with=
 the -N
> > > > > > > flag for his use case. I know how to replicate his use case a=
nd am
> > > > > > > going to try it soon.
> > > > > >
> > > > > > Yes, I'm just confused as to how the same BOOTSBOX.EFI binary f=
ile can
> > > > > > be executed as both x86-64 and aarch64. Because:
> > > > > > $ xz -k -d test/py/tests/bootstd/flash1.img.xz
> > > > > > $ sudo losetup -fP  test/py/tests/bootstd/flash1.img
> > > > > > $ sudo mount -o ro /dev/loop18p1 /mnt
> > > > > > $ file /mnt/EFI/BOOT/BOOTSBOX.EFI
> > > > > > /mnt/EFI/BOOT/BOOTSBOX.EFI: PE32+ executable (EFI application) =
x86-64 (stripped to external PDB), for MS Windows, 5 sections
> > > > > >
> > > > > > Seems unlikely to work on an aarch64 host. Which is why I asked=
 if the
> > > > > > test actually replaced the contents of the file.
> > > > >
> > > > > Well, yes, for now the .xz is an x86_64 image, but I expect to be=
 able
> > > > > to get rid of that fallback once my EFI test lands, so it should =
work
> > > > > fine on ARM.
> > > >
> > > > So lets just re-work things to get this right from the start then
> > > > please.
> > >
> > > My understanding was that I offered to tidy up and send [1] after this
> > > series lands?
> >
> > Oh, so replacing the file is blocked on not having sudo in use on these
> > tests. That wasn't clear, sorry.
>=20
> OK, good, thanks. It's just CI that has this problem, since sudo doesn't =
work.

To be clear, the push for no-sudo is because of developers who
(understandably!) don't want sudo running random things on their machine
in order to run U-Boot tests. That it makes CI more consistent is good,
too.

--=20
Tom

--hjXn+KUL+QKdbB2K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcehx4ACgkQFHw5/5Y0
tyxC7Av/VLcgKA4qRpeDei6FP/VIQtsSQMq6ifuKN2ACk0bq9LNoLYlw8vDidpn+
D5weW8yJ4CWoPiJ+v/OvEkm/eHlgx1rSkV+4pmc1vg3rkwSWc5W3RlnYT4iFoDa4
iu6DiAkiwM6bFiaWVwYRuve5nIwYmoz+9NqqXRMv3Stco+cRNnIghu9iTi7gdPYm
2L4vI5QCxk4g/v1YEZBukSAAv36iKWXeRrcfCquDBLMyvYsj3UAdfauXDUUb+/tg
5pjFD9ufqIQ+irliY5L+KTT33eIbU7CloiukSLw3vu+M0u5R+uf0FjP9v8YRDdNS
ccKWL5FLxpISrCIs8LaknNia54lBSZOvIxvAw+WjLQpm3futYagdXm3rjRm3aD+C
4RRNF3aO+RPybaMWXHxzk91KeEKuk6YSqztu/PA6mOx9Y3su5Ph8Re6a7k3V2kIO
/xBr8BYXDdlwRltMm0tOJyM7CR0wrvR/BxKNxXfAiwT2uJh3MrSOsj4HXBJel7tz
4jjtVDGn
=6y95
-----END PGP SIGNATURE-----

--hjXn+KUL+QKdbB2K--
