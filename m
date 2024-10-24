Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732FCCE8E9A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 17:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D0C88BBE;
	Thu, 24 Oct 2024 19:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GSLQfF5v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B99988E63; Thu, 24 Oct 2024 19:37:21 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5684588995
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 19:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e2908e8d45eso1249011276.2
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729791431; x=1730396231; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nGzQy4Ae8mU7qsbGAvSibgDtNMyQKYO6Qxa6pQnFNBs=;
 b=GSLQfF5vN3eUxSUO/PSXCPFyDFaTuMG28biNNzaGpy28045DnUsKEYUcMqjt7w8HZ+
 8St/k0Qo/tM/KqwH6yj5fM1SDb9r45YuQIPE/Fj5yzAbI0q9fLr/gtjx8pQTGrmiYKO7
 jc11or4zixHZEJWwflMu5ZUdE3PNln8laWY8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729791431; x=1730396231;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGzQy4Ae8mU7qsbGAvSibgDtNMyQKYO6Qxa6pQnFNBs=;
 b=vlpxBllrmnIsfaP8Tw4T+MonXoCtxITNae3tLoRqVhN/tP+UPYyM0sTfb71ErfCYHg
 t2pJSSwt+geBC2yT16X/T2S4sKQU2D0PLmMAxPMNfkjW/KpJDDQiGIBcRIA7ePe7/BGM
 pm6W+MMY+i9MeDOpxzadWjO+/dOW2NwcfW5qkiLWgiNdBpW/u7/wStlNi5+QL1qiUr7L
 wE7L69fmFw8kIaF3iCgMSoxPR1n0TMQdNDhHUk4q6QciAP6HzxIgqKs+pX/UA/qR3SUq
 Ft/Ei7/gAWh8+uPzTQVyCpgCFwsQu3uX21yetPDS0dAR3IpR1Pik06nQo6EfLzBTcmFP
 98Ag==
X-Gm-Message-State: AOJu0Yw/nohVBJVZFWcbeUTQhLYVzqw0pjaHXBy4oK7Yuf7hMlcPtG32
 L/rzLjsHUZZDSaRTXFAxE66XqcrMgNSfAPHqxeoo8ClhELTGR6Uiqm9d7aEFNlc=
X-Google-Smtp-Source: AGHT+IEmsFlGGyNRleL/qMU0cbdCpTGGgK/L6nbJhcCFrWwg0m4lG454tSpGwMeXjpfqRkgM87qepg==
X-Received: by 2002:a05:6902:200b:b0:e28:f31f:5f72 with SMTP id
 3f1490d57ef6-e2f2302a3ebmr2870333276.19.1729791431019; 
 Thu, 24 Oct 2024 10:37:11 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3d70a6bsm53397941cf.63.2024.10.24.10.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 10:37:10 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:37:06 -0600
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
Message-ID: <20241024173706.GU4959@bill-the-cat>
References: <20241019175121.GA4959@bill-the-cat>
 <CAFLszTgBzr_nYtFKFEuHBLBUUF8qq92y+i=bzsVaKsHyt-990Q@mail.gmail.com>
 <20241021173253.GO4959@bill-the-cat>
 <CAFLszThgsF5BL8aSGozA3nAeox=g8bVARmSaBFedM=dbLT=UWA@mail.gmail.com>
 <20241022140246.GB4959@bill-the-cat>
 <CAFLszTg3pkZ3z7vH1j-Vafmw6OKhzvLQ4=X9vd+kDzmmUjOw_g@mail.gmail.com>
 <20241022175427.GH4959@bill-the-cat>
 <CAFLszTg=DJWnMf7Lun7ga0+_J4Vw6rpf32LMkdRLSy-WY+2U7g@mail.gmail.com>
 <20241023184121.GL4959@bill-the-cat>
 <CAFLszTgQB3Axj_FQwUURG0+u+z3SM5ypo88CfBntq+xUrzfOGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="67Yip/jtixnHAm++"
Content-Disposition: inline
In-Reply-To: <CAFLszTgQB3Axj_FQwUURG0+u+z3SM5ypo88CfBntq+xUrzfOGw@mail.gmail.com>
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


--67Yip/jtixnHAm++
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 06:39:00PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, Oct 23, 2024, 20:41 Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 23, 2024 at 05:39:07AM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 22 Oct 2024 at 19:54, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Oct 22, 2024 at 07:00:35PM +0200, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 22 Oct 2024 at 16:02, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 22, 2024 at 02:15:46PM +0200, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 21 Oct 2024 at 19:32, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Mon, Oct 21, 2024 at 08:31:10AM +0200, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Sat, 19 Oct 2024 at 11:51, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sat, Oct 19, 2024 at 09:24:33AM -0600, Simon Glass w=
rote:
> > > > > > > > > >
> > > > > > > > > > > Create a new disk for use with tests, which contains =
the new 'testapp'
> > > > > > > > > > > EFI app specifically intended for testing the EFI loa=
der.
> > > > > > > > > > >
> > > > > > > > > > > Attach it to the USB device, since most testing is cu=
rrently done with
> > > > > > > > > > > mmc.
> > > > > > > > > > >
> > > > > > > > > > > Initially this image will be used to test the EFI boo=
tmeth.
> > > > > > > > > > >
> > > > > > > > > > > Fix a stale comment in prep_mmc_bootdev() while we ar=
e here.
> > > > > > > > > > >
> > > > > > > > > > > For now this uses sudo and a compressed fallback file=
, like all the
> > > > > > > > > > > other bootstd tests. Once this series is in, the patc=
h which moves
> > > > > > > > > > > this to use user-space tools will be cleaned up and r=
e-submitted.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > >
> > > > > > > > > > > ---
> > > > > > > > > > > Here is the patch to avoid sudo and CI fallback:
> > > > > > > > > > >
> > > > > > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/
> > > > > > > > > > > 20240802093322.15240-1-richard@nod.at/
> > > > > > > > > > >
> > > > > > > > > > > (no changes since v1)
> > > > > > > > > > >
> > > > > > > > > > >  arch/sandbox/dts/test.dts           |   2 +-
> > > > > > > > > > >  test/boot/bootdev.c                 |  18 +++++++++-
> > > > > > > > > > >  test/boot/bootflow.c                |   2 +-
> > > > > > > > > > >  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 =
bytes
> > > > > > > > > >
> > > > > > > > > > This I think best illustrates the problem with "BOOTSBO=
X.EFI". This
> > > > > > > > > > image will work for CI up until I can figure out how to=
 get access to
> > > > > > > > > > free arm64 servers to run some tests on and then it wil=
l fail.
> > > > > > > > >
> > > > > > > > > I don't believe so. Why do you think that?
> > > > > > > >
> > > > > > > > Because it includes the BOOTSBOX.EFI x86 binary file, and e=
xecutes it?
> > > > > > > > Or did I miss where we update the contents to include that =
file as we
> > > > > > > > just built it (and so why have it included?) ?
> > > > > > >
> > > > > > > It works fine on x86 and I'm sure it will work fine on ARM as=
 well.
> > > > > > > The file is built with the host compiler, just as U-Boot itse=
lf is.
> > > > > >
> > > > > > Erm, are you saying the BOOT/EFI/BOOTSBOX.EFI file that's in
> > > > > > test/py/tests/bootstd/flash1.img.xz doesn't need to exist and t=
he test
> > > > > > replaces that, as it goes?
> > > > >
> > > > > No, I'm saying that sandbox uses that file, no matter the host
> > > > > architecture, and I don't need to create different versions of
> > > > > flash1.im.xz for each host architecture.
> > > > >
> > > > > I discussed this with Heinrich and he seems happy enough with the=
 -N
> > > > > flag for his use case. I know how to replicate his use case and am
> > > > > going to try it soon.
> > > >
> > > > Yes, I'm just confused as to how the same BOOTSBOX.EFI binary file =
can
> > > > be executed as both x86-64 and aarch64. Because:
> > > > $ xz -k -d test/py/tests/bootstd/flash1.img.xz
> > > > $ sudo losetup -fP  test/py/tests/bootstd/flash1.img
> > > > $ sudo mount -o ro /dev/loop18p1 /mnt
> > > > $ file /mnt/EFI/BOOT/BOOTSBOX.EFI
> > > > /mnt/EFI/BOOT/BOOTSBOX.EFI: PE32+ executable (EFI application) x86-=
64 (stripped to external PDB), for MS Windows, 5 sections
> > > >
> > > > Seems unlikely to work on an aarch64 host. Which is why I asked if =
the
> > > > test actually replaced the contents of the file.
> > >
> > > Well, yes, for now the .xz is an x86_64 image, but I expect to be able
> > > to get rid of that fallback once my EFI test lands, so it should work
> > > fine on ARM.
> >
> > So lets just re-work things to get this right from the start then
> > please.
>=20
> My understanding was that I offered to tidy up and send [1] after this
> series lands?

Oh, so replacing the file is blocked on not having sudo in use on these
tests. That wasn't clear, sorry.

--=20
Tom

--67Yip/jtixnHAm++
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcahb4ACgkQFHw5/5Y0
tyw2eQv/bOwqYLU9JhbuhQ+Y7dpW0y8cfnhKaOA4CmOE/+zcGiL8yET5+yQ5jfC9
zLtMfwoEotUtwoIIhCFF5xTz+exKPlfFfVitcEm8Q/Jkwsi59pWW3sgqRON7AeTC
YvSspzG8neYcFM43xaP6iA21+JwyOu/gNFbC51jyFGa8qgqQUm6p5oZsAAEsAKTK
caYAFzsSo3iv5w/jUe6vx4lkB5eX8w9RZ7U9PCyd8nkLjyZpFSZYsuAmtBxN6mxg
Q0eu+kkVhSHxX0EMjOLSwG1DVzwEo1PUvxTSm1ByzynasAcQQNoGa/7y1yzhGx7x
6ZnrLP2GGMkRpMl/bIWR/mHHvBTOLMRzvO0AWy6jEH+u13aMTaSkse5R7yWArNF2
JjX0wBSjhk4l+uZ0b25CFYLvhUf0vZPvMX93hQkUP3tY3JQwAMA73/LU26EG/59o
2U0p2G5a5R+03+TPwCUVG1Zzd8r0F7ytMIad6uaY93RX30iRWP6FjA5aSUba0Nnt
B/21jwOa
=Gi6o
-----END PGP SIGNATURE-----

--67Yip/jtixnHAm++--
