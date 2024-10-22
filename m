Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830BAD2CE12
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 17:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E155E88D94;
	Tue, 22 Oct 2024 19:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZquyIn4V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E0388F47; Tue, 22 Oct 2024 19:54:36 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC9488D91
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 19:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b14077ec5aso6429685a.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729619672; x=1730224472; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fP/GsqGBQS5c7UCNO5uwPn92ugv1pYJngsEVM9v9UC8=;
 b=ZquyIn4VC6OUl7iP7tw1oFT6jbkWcBVVHi0UevZfJSBG2HCCkyCA5XdK5Xmy51cdEw
 BEsJJo9KFXqX8IIS0v9rdQxEtv1jCX1OFPRrmkoS9EElvdjOfiet/AYlg9XPRX051KSR
 WAPbAoGeZNGSjirh9ybDvgOZo3eyUiVUYAr3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729619672; x=1730224472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fP/GsqGBQS5c7UCNO5uwPn92ugv1pYJngsEVM9v9UC8=;
 b=LOJZAv1FVxRgIsBlCXgedTrEHGfzjX+l9JwLJpmI1esDfEThtiSaKYne9YE+2BOkYD
 P8Vul18MZ2GjiTAEbDpyVeneFxUbZMuRexhRR0JCX1Yev2/fKIxq/U1ppU0gfwmw+txF
 HUMQUI3bxia2HzPC9KkkQMtx6tagnw9J0IPNXTcYMHOuiM0+UqZKbNpJcb/1ZqXVuxuK
 pQ7GpNHFtrKgWZyQnNc0cO4ITiwgiLzU8RdQoBKTzjj+Q/EBNa5A2Mkrsm+6Fm1ITUDm
 Xc8mwuhsBlS2UKbzfhkWRd7XUAAvKQt3HeE6fbRhkOr9RuQnSiVv2GWrKjsJZGHh8iiu
 3NMw==
X-Gm-Message-State: AOJu0YzWxLm85blK/VyHy5Htor+eU/acgKs47j61//Jbmkn66IOUiG9/
 BnMkbjdYBziJcb64sAqovKundTZYl9Os+LuKnnSvXCFgnaNbUMsfVCJ/hJwec0M=
X-Google-Smtp-Source: AGHT+IF17R7QCiszMjkP/YY1W0g1PxHWjav6NpeYcl4zelf8prtv+X8Ezh1lpFyFVkSeTpIXgYneNw==
X-Received: by 2002:a05:620a:2405:b0:7a9:b4d2:9d68 with SMTP id
 af79cd13be357-7b1755db6a3mr630816385a.22.1729619672516; 
 Tue, 22 Oct 2024 10:54:32 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a86f43sm301534285a.126.2024.10.22.10.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 10:54:31 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:54:27 -0600
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
Message-ID: <20241022175427.GH4959@bill-the-cat>
References: <20241019152434.1017394-1-sjg@chromium.org>
 <20241019152434.1017394-7-sjg@chromium.org>
 <20241019175121.GA4959@bill-the-cat>
 <CAFLszTgBzr_nYtFKFEuHBLBUUF8qq92y+i=bzsVaKsHyt-990Q@mail.gmail.com>
 <20241021173253.GO4959@bill-the-cat>
 <CAFLszThgsF5BL8aSGozA3nAeox=g8bVARmSaBFedM=dbLT=UWA@mail.gmail.com>
 <20241022140246.GB4959@bill-the-cat>
 <CAFLszTg3pkZ3z7vH1j-Vafmw6OKhzvLQ4=X9vd+kDzmmUjOw_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TziJ74ZFDxL44nNA"
Content-Disposition: inline
In-Reply-To: <CAFLszTg3pkZ3z7vH1j-Vafmw6OKhzvLQ4=X9vd+kDzmmUjOw_g@mail.gmail.com>
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


--TziJ74ZFDxL44nNA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 07:00:35PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 22 Oct 2024 at 16:02, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 22, 2024 at 02:15:46PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 21 Oct 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 21, 2024 at 08:31:10AM +0200, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 19 Oct 2024 at 11:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Oct 19, 2024 at 09:24:33AM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > Create a new disk for use with tests, which contains the new =
'testapp'
> > > > > > > EFI app specifically intended for testing the EFI loader.
> > > > > > >
> > > > > > > Attach it to the USB device, since most testing is currently =
done with
> > > > > > > mmc.
> > > > > > >
> > > > > > > Initially this image will be used to test the EFI bootmeth.
> > > > > > >
> > > > > > > Fix a stale comment in prep_mmc_bootdev() while we are here.
> > > > > > >
> > > > > > > For now this uses sudo and a compressed fallback file, like a=
ll the
> > > > > > > other bootstd tests. Once this series is in, the patch which =
moves
> > > > > > > this to use user-space tools will be cleaned up and re-submit=
ted.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > >
> > > > > > > ---
> > > > > > > Here is the patch to avoid sudo and CI fallback:
> > > > > > >
> > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/
> > > > > > > 20240802093322.15240-1-richard@nod.at/
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >  arch/sandbox/dts/test.dts           |   2 +-
> > > > > > >  test/boot/bootdev.c                 |  18 +++++++++-
> > > > > > >  test/boot/bootflow.c                |   2 +-
> > > > > > >  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
> > > > > >
> > > > > > This I think best illustrates the problem with "BOOTSBOX.EFI". =
This
> > > > > > image will work for CI up until I can figure out how to get acc=
ess to
> > > > > > free arm64 servers to run some tests on and then it will fail.
> > > > >
> > > > > I don't believe so. Why do you think that?
> > > >
> > > > Because it includes the BOOTSBOX.EFI x86 binary file, and executes =
it?
> > > > Or did I miss where we update the contents to include that file as =
we
> > > > just built it (and so why have it included?) ?
> > >
> > > It works fine on x86 and I'm sure it will work fine on ARM as well.
> > > The file is built with the host compiler, just as U-Boot itself is.
> >
> > Erm, are you saying the BOOT/EFI/BOOTSBOX.EFI file that's in
> > test/py/tests/bootstd/flash1.img.xz doesn't need to exist and the test
> > replaces that, as it goes?
>=20
> No, I'm saying that sandbox uses that file, no matter the host
> architecture, and I don't need to create different versions of
> flash1.im.xz for each host architecture.
>=20
> I discussed this with Heinrich and he seems happy enough with the -N
> flag for his use case. I know how to replicate his use case and am
> going to try it soon.

Yes, I'm just confused as to how the same BOOTSBOX.EFI binary file can
be executed as both x86-64 and aarch64. Because:
$ xz -k -d test/py/tests/bootstd/flash1.img.xz
$ sudo losetup -fP  test/py/tests/bootstd/flash1.img
$ sudo mount -o ro /dev/loop18p1 /mnt
$ file /mnt/EFI/BOOT/BOOTSBOX.EFI
/mnt/EFI/BOOT/BOOTSBOX.EFI: PE32+ executable (EFI application) x86-64 (stri=
pped to external PDB), for MS Windows, 5 sections

Seems unlikely to work on an aarch64 host. Which is why I asked if the
test actually replaced the contents of the file.

--=20
Tom

--TziJ74ZFDxL44nNA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcX5tAACgkQFHw5/5Y0
tyxJNAwAobXzh2OhQNNKa5626lyEY54YLCia8O7sZPzUKdz44wHCbIhe6gx2PUEz
NPI6qcl5aX/P77wPqwZJUFq7lMjcvgHF5rgoc0/w4JBoRhco/+GwoJQvCJnb0aTG
wC9wv8toR1F7ENQWdzQFR5C+pDDxfB/cL845+qJZLWNNdGZdY2w5wowAHsBZkR/o
s/w+2zBz5svcw8h+KSUKHS7GFdv3EWmBw/8nv47MHHq9auZKpkwgbB3xGrCSLYhW
NymaraNYtWhE0iOvRVN7OwOeCiUux/H+xyGOScnOioeNCRxParoYf0uLO7tkt+PJ
094LMvManCEAfVNRDy4cydk6yeKWEQET+4osCFUro/pkMj2Y+vJ822IyEuXei1Vs
FJYtuDFhhT6vURXIhrjUmsMhNNgC0sRb7U/QrxcTQ56lNn1TE6dLwVwn1ow5BGLx
FuP95N/xRuTz1CKAqsW2fVsbwMSKOb617H16p+VW7GpuY8jAtm3ZRdkw/4b+kcNv
WtMeEW8F
=s54y
-----END PGP SIGNATURE-----

--TziJ74ZFDxL44nNA--
