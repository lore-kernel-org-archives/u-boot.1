Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15431CFA45D
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 18:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B929A892F0;
	Wed, 23 Oct 2024 20:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sPjOz+tY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C5A892F0; Wed, 23 Oct 2024 20:41:33 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E76BD892E7
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 20:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbd12b38b4so886866d6.2
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729708887; x=1730313687; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5p94GF/70QPrE3nFK9K04hAMoAcs/1akcJaLRsoK6f0=;
 b=sPjOz+tYFZL6vSw0ZV+q5nCMixtQjjir6VHKJyjM2R2GBOvnyPQGHLSHPmGveA7W8V
 K8z5A8MsujRTt+IIREEeuV1BiSxwDZDbsrgLO5GyyRwDp0G+fLYR73vMBZy8Dr66zi9f
 7cQjgOQPsDXt86dbyPDv9a1w5daBZaAKRw/QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729708887; x=1730313687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5p94GF/70QPrE3nFK9K04hAMoAcs/1akcJaLRsoK6f0=;
 b=YNvh/Sk358Fl+oX9HxdhfI/rKF35IAZ6jOHwjMkCHQFfKTUpunVt7vmfit3Zzek0K9
 VKtPkoDADpaRAVEEX1qLG5HW57W55d8iI5lz+WsHY8pevzL3EdFTHRH2mI1mkBpp0mvj
 XqFKW/h6DwvaIvCqGO8uGzEn6dn2oxqD0EVdUODmJSvUzfYopqjDb1bAnqg+RnhNeaOA
 wqGGVsvHGbdbmF7/T2ENp6BGjnXV9O4iXB8+6xUWHjKWE1rMMxeqV99jCefp8vXwps1x
 BeeQHAw/y1p45pRVL0tM19XDDUj5KsRcP/WW4j+M1DdlpxLdQVMI6mnFXQtuuiwOJpb/
 nz3A==
X-Gm-Message-State: AOJu0YxAYzxHFVOjTvdXNizz2cfRNr64MXVg/+P4qOqM5fP89jggSI5H
 //vVO/RdP4/X5L2aJ+pN0cpPMMAc4zcNZg8uA9evVJAkQauTXfETybojKIR+SBs=
X-Google-Smtp-Source: AGHT+IE/b67SMtbGSboQYueMMaNP5BNOBEanuVNd6pjs8N8XqmrnMicBjAj071SjXJlTeXKJpliMaA==
X-Received: by 2002:a05:6214:3da0:b0:6c3:5a86:6a29 with SMTP id
 6a1803df08f44-6ce3426258cmr47248796d6.21.1729708886687; 
 Wed, 23 Oct 2024 11:41:26 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009e6653sm41831296d6.130.2024.10.23.11.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 11:41:25 -0700 (PDT)
Date: Wed, 23 Oct 2024 12:41:21 -0600
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
Message-ID: <20241023184121.GL4959@bill-the-cat>
References: <20241019152434.1017394-1-sjg@chromium.org>
 <20241019152434.1017394-7-sjg@chromium.org>
 <20241019175121.GA4959@bill-the-cat>
 <CAFLszTgBzr_nYtFKFEuHBLBUUF8qq92y+i=bzsVaKsHyt-990Q@mail.gmail.com>
 <20241021173253.GO4959@bill-the-cat>
 <CAFLszThgsF5BL8aSGozA3nAeox=g8bVARmSaBFedM=dbLT=UWA@mail.gmail.com>
 <20241022140246.GB4959@bill-the-cat>
 <CAFLszTg3pkZ3z7vH1j-Vafmw6OKhzvLQ4=X9vd+kDzmmUjOw_g@mail.gmail.com>
 <20241022175427.GH4959@bill-the-cat>
 <CAFLszTg=DJWnMf7Lun7ga0+_J4Vw6rpf32LMkdRLSy-WY+2U7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qWU3QJ8nNLBc1+Ew"
Content-Disposition: inline
In-Reply-To: <CAFLszTg=DJWnMf7Lun7ga0+_J4Vw6rpf32LMkdRLSy-WY+2U7g@mail.gmail.com>
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


--qWU3QJ8nNLBc1+Ew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 05:39:07AM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 22 Oct 2024 at 19:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 22, 2024 at 07:00:35PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 22 Oct 2024 at 16:02, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Oct 22, 2024 at 02:15:46PM +0200, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 21 Oct 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 21, 2024 at 08:31:10AM +0200, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Sat, 19 Oct 2024 at 11:51, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Sat, Oct 19, 2024 at 09:24:33AM -0600, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > Create a new disk for use with tests, which contains the =
new 'testapp'
> > > > > > > > > EFI app specifically intended for testing the EFI loader.
> > > > > > > > >
> > > > > > > > > Attach it to the USB device, since most testing is curren=
tly done with
> > > > > > > > > mmc.
> > > > > > > > >
> > > > > > > > > Initially this image will be used to test the EFI bootmet=
h.
> > > > > > > > >
> > > > > > > > > Fix a stale comment in prep_mmc_bootdev() while we are he=
re.
> > > > > > > > >
> > > > > > > > > For now this uses sudo and a compressed fallback file, li=
ke all the
> > > > > > > > > other bootstd tests. Once this series is in, the patch wh=
ich moves
> > > > > > > > > this to use user-space tools will be cleaned up and re-su=
bmitted.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > >
> > > > > > > > > ---
> > > > > > > > > Here is the patch to avoid sudo and CI fallback:
> > > > > > > > >
> > > > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/
> > > > > > > > > 20240802093322.15240-1-richard@nod.at/
> > > > > > > > >
> > > > > > > > > (no changes since v1)
> > > > > > > > >
> > > > > > > > >  arch/sandbox/dts/test.dts           |   2 +-
> > > > > > > > >  test/boot/bootdev.c                 |  18 +++++++++-
> > > > > > > > >  test/boot/bootflow.c                |   2 +-
> > > > > > > > >  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
> > > > > > > >
> > > > > > > > This I think best illustrates the problem with "BOOTSBOX.EF=
I". This
> > > > > > > > image will work for CI up until I can figure out how to get=
 access to
> > > > > > > > free arm64 servers to run some tests on and then it will fa=
il.
> > > > > > >
> > > > > > > I don't believe so. Why do you think that?
> > > > > >
> > > > > > Because it includes the BOOTSBOX.EFI x86 binary file, and execu=
tes it?
> > > > > > Or did I miss where we update the contents to include that file=
 as we
> > > > > > just built it (and so why have it included?) ?
> > > > >
> > > > > It works fine on x86 and I'm sure it will work fine on ARM as wel=
l.
> > > > > The file is built with the host compiler, just as U-Boot itself i=
s.
> > > >
> > > > Erm, are you saying the BOOT/EFI/BOOTSBOX.EFI file that's in
> > > > test/py/tests/bootstd/flash1.img.xz doesn't need to exist and the t=
est
> > > > replaces that, as it goes?
> > >
> > > No, I'm saying that sandbox uses that file, no matter the host
> > > architecture, and I don't need to create different versions of
> > > flash1.im.xz for each host architecture.
> > >
> > > I discussed this with Heinrich and he seems happy enough with the -N
> > > flag for his use case. I know how to replicate his use case and am
> > > going to try it soon.
> >
> > Yes, I'm just confused as to how the same BOOTSBOX.EFI binary file can
> > be executed as both x86-64 and aarch64. Because:
> > $ xz -k -d test/py/tests/bootstd/flash1.img.xz
> > $ sudo losetup -fP  test/py/tests/bootstd/flash1.img
> > $ sudo mount -o ro /dev/loop18p1 /mnt
> > $ file /mnt/EFI/BOOT/BOOTSBOX.EFI
> > /mnt/EFI/BOOT/BOOTSBOX.EFI: PE32+ executable (EFI application) x86-64 (=
stripped to external PDB), for MS Windows, 5 sections
> >
> > Seems unlikely to work on an aarch64 host. Which is why I asked if the
> > test actually replaced the contents of the file.
>=20
> Well, yes, for now the .xz is an x86_64 image, but I expect to be able
> to get rid of that fallback once my EFI test lands, so it should work
> fine on ARM.

So lets just re-work things to get this right from the start then
please.

--=20
Tom

--qWU3QJ8nNLBc1+Ew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcZQ1EACgkQFHw5/5Y0
tyz7tAwApBqSa9SqmR02WtmEJp0mwczRT3CQ46wL832a1N6q6WaBMI+mvitH2mVQ
Fa6pjl55m1uSX0GSANmU7i6ydD2m6N7OUSyECyKeob3McuGHxMN46Fl8oOTY5FzK
tntWoNYxM2wMEIxjB/MbMJi4wSx22YyZRJzeYdoD5NaTTg+eFFXxvD4ZlQeaHbzG
AqRMI9CrbBpVtjlBVm/dbelz5MqaA/9kzzTmVHVcRFMiVr0KO7TjrgsgVd5PpSve
gi0S5W5TVDZqcmMKIoK4xJFu7vV4r27Q6nOudxP491DvBp9TVCX1xQfdDhnJRxnd
FwtideAB72AwEAe1QsUXUNSu38Rhuy/RIJeRGh0lTn68ZKVyX6l+XOmxvDGvRZO3
OC7evzpFk8JoTMwL9Dr96ck3BK0g5YU4QIxUjwFIvCr2TL784GEMaIye07kJbpeP
V0gs8HvmRFmLk+0gC6AHTm4JDcxydcdF3/Fs2uX7DDJN24z4fTpXpt3Ct6uwrtXE
/mMFIfhv
=cgg3
-----END PGP SIGNATURE-----

--qWU3QJ8nNLBc1+Ew--
