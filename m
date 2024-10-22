Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97505D2C559
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 14:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3261088F31;
	Tue, 22 Oct 2024 16:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zoacugsn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D5DC88F31; Tue, 22 Oct 2024 16:02:56 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDCA988F8E
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 16:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b1467af9dbso414417485a.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729605773; x=1730210573; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VnCD3MM0uvDA4v0r9yn03byqJ5DwLiS5isMUrNyBJZU=;
 b=Zoacugsnbt8PS+qMym+nFBZV/1UgkzniCGbsblaBbr21mSSYvqLDmeJf30bcZ5jsZe
 xY6ATL8rVAE5JOocK3JlTBf1JwRcDC/XQ7RHsuYcSl4ZjsFfFwXh1oEjBGaZLF2bMno1
 jcqsaj2m05omxGoPNcZzBs0K4QG7fYx1nLjBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729605773; x=1730210573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnCD3MM0uvDA4v0r9yn03byqJ5DwLiS5isMUrNyBJZU=;
 b=aTQYb/b468T1Wq3Jep6Tn2RSHM2ZUubva0V1t8VRZXsTlSxzYxTHcmnabdZ1V6fsh8
 gwq+OHc7vZSY/Vfn+od9P62/Z8P0ADyuiZcApea4/fvQy5bz4E8zTswLt6ZR8vnbqZTt
 lltcHpbmTiizY/PpUT+YRGfDMT2AGXbx6oK+i0avXvuAznD4OyIlEhv5gXZEfkDCdYzG
 6xwLldeKCXSR0tC0VbOurbl0Jqcg1KHlCJD4PjpKuiPB7JmAw9HRbMWrA3/GkGnzgfD4
 H3Q1B+8YnCBnA+f0FV6SDfBD/S+zNnzJV/9OHm3JkPpstqPJN8Occ4GHfK+Q6+1ZSm9w
 G+lQ==
X-Gm-Message-State: AOJu0Yyd+9tZr5WdJsftRB7Nx4Yz3mau/NcoYBa2fSMDxswp/BcuzdOI
 H/CZSHnXfxbfFuJ76GCevJgeTINNgdAqKHTqlwbxPg98GvnegeEnmfNt8aeX7JQ=
X-Google-Smtp-Source: AGHT+IELviy9XsBYHWup/I8Nr4n/1F3zhDX6tEyTDeag6e/FwlwT+ZOhVnJiOa6YcW9ZRubPKTD5gQ==
X-Received: by 2002:a05:620a:4543:b0:7b1:45be:2e80 with SMTP id
 af79cd13be357-7b175146c26mr506148085a.0.1729605772539; 
 Tue, 22 Oct 2024 07:02:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659e5c62sm282014385a.40.2024.10.22.07.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 07:02:51 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:02:46 -0600
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
Message-ID: <20241022140246.GB4959@bill-the-cat>
References: <20241019152434.1017394-1-sjg@chromium.org>
 <20241019152434.1017394-7-sjg@chromium.org>
 <20241019175121.GA4959@bill-the-cat>
 <CAFLszTgBzr_nYtFKFEuHBLBUUF8qq92y+i=bzsVaKsHyt-990Q@mail.gmail.com>
 <20241021173253.GO4959@bill-the-cat>
 <CAFLszThgsF5BL8aSGozA3nAeox=g8bVARmSaBFedM=dbLT=UWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="693nWLq2DjbHJB7t"
Content-Disposition: inline
In-Reply-To: <CAFLszThgsF5BL8aSGozA3nAeox=g8bVARmSaBFedM=dbLT=UWA@mail.gmail.com>
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


--693nWLq2DjbHJB7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 02:15:46PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 21 Oct 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 08:31:10AM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 19 Oct 2024 at 11:51, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Oct 19, 2024 at 09:24:33AM -0600, Simon Glass wrote:
> > > >
> > > > > Create a new disk for use with tests, which contains the new 'tes=
tapp'
> > > > > EFI app specifically intended for testing the EFI loader.
> > > > >
> > > > > Attach it to the USB device, since most testing is currently done=
 with
> > > > > mmc.
> > > > >
> > > > > Initially this image will be used to test the EFI bootmeth.
> > > > >
> > > > > Fix a stale comment in prep_mmc_bootdev() while we are here.
> > > > >
> > > > > For now this uses sudo and a compressed fallback file, like all t=
he
> > > > > other bootstd tests. Once this series is in, the patch which moves
> > > > > this to use user-space tools will be cleaned up and re-submitted.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > ---
> > > > > Here is the patch to avoid sudo and CI fallback:
> > > > >
> > > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/
> > > > > 20240802093322.15240-1-richard@nod.at/
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  arch/sandbox/dts/test.dts           |   2 +-
> > > > >  test/boot/bootdev.c                 |  18 +++++++++-
> > > > >  test/boot/bootflow.c                |   2 +-
> > > > >  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
> > > >
> > > > This I think best illustrates the problem with "BOOTSBOX.EFI". This
> > > > image will work for CI up until I can figure out how to get access =
to
> > > > free arm64 servers to run some tests on and then it will fail.
> > >
> > > I don't believe so. Why do you think that?
> >
> > Because it includes the BOOTSBOX.EFI x86 binary file, and executes it?
> > Or did I miss where we update the contents to include that file as we
> > just built it (and so why have it included?) ?
>=20
> It works fine on x86 and I'm sure it will work fine on ARM as well.
> The file is built with the host compiler, just as U-Boot itself is.

Erm, are you saying the BOOT/EFI/BOOTSBOX.EFI file that's in
test/py/tests/bootstd/flash1.img.xz doesn't need to exist and the test
replaces that, as it goes?

--=20
Tom

--693nWLq2DjbHJB7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcXsIYACgkQFHw5/5Y0
tyzAnAwAq2pmDox4aqoVNsr6HvSCBVBjtXuiboMwyRvHrnsMtI8+2Mi32ZRoS+cK
TZBECnfyuhOb4vJAHvzVbfa5Yecf6HEEuXmk8M9r6lKAgg4/EeJjVau8O9JZOxyg
dn1EkiDpm6qK+78BWFXo06a8iuF3AXuVNcoAB9a0pcsNPjtiBBdFmVykSaB+CyBk
Lal3sU7OEKBX/GV7/5uLpxizjIw8VuBbq7bBllll7p+kUsre/dZ174AYvNIhwdHa
RjBCDWS5qSNFX/A/8otyMhpjLLZA/i/8/AMijJkM/fwNGL6P5LXGcfOoKn60D1Xd
40l15NDu1m70U3LjFg0OsYSyGxmdBNIRAqI1bekDLE3ltMSOaFDoxzynTQxPxlzl
dlDRYRE1LHpvEct+e0gjpszmYLgRxiO7AE04BPEaYEHCw0xJoDvHg3zJjHBhQAwh
zKbD6UoEg+7lTDLb2fwb5rsGLZIbnKdMG1xxqEsluQbUdV04pzicsDi9ecEEFD7J
LrDJKjge
=ZyhF
-----END PGP SIGNATURE-----

--693nWLq2DjbHJB7t--
