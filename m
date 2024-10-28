Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D19D3E2C0
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8A8890BF;
	Mon, 28 Oct 2024 20:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NsRqJaM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8774D890CE; Mon, 28 Oct 2024 20:53:13 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C92ED8909F
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-460e6d331d6so27365871cf.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730145189; x=1730749989; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uZDEgfeCvbbgWWHndygyjMGPs+kODgY7k26drujQsjI=;
 b=NsRqJaM/+XyLLSEvVCBH/9tEX+iO62R9adqc4pJUKOWAHXRbteG/rjbprpdPvtHwLt
 NxaQyJ419mLxC8qrC+7h1YzVKGikbLF4MdOulFcJU2UI5PM2wgLPrND87BH3VB07SMvk
 v2IiZsz/3++EoIEpT/bPFsjWTs4FWOfnoB6Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730145189; x=1730749989;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZDEgfeCvbbgWWHndygyjMGPs+kODgY7k26drujQsjI=;
 b=dVVo3aPRCDqSs+mUNwZ3DiVffj5zLiL6SwP2rkhCSEBCQeTh27yMb5cPj86W9+Jeli
 5ZueQZJUcZTymoB0a7xds5HlJMKOJDGKg+ESU50a2L0y3A3GdEd5sBaST0UJwGCgK3ED
 dbiwbD+HGHS84ziQys/hIT+3i7N9ZkPRpS7C8Or+Fiydm3kYNTPs5hSZCgvORt4dJmyp
 /l62m3yF3BZxxT8qLAwbpcHNIiUbi8Yq3W98m2VCG0uCZmgbjlCPpB+EP6vqiQoWShtn
 oi7IhjjNtSDNRrnNd7HKg78mQSfkk3WubyDWdM5iRgs5ebQxY6Gst256IN9X04DuA7hJ
 7uSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXox1oJ2mAlOD1QHTDuh5gTrW3qQr6ZjAW8M6RPgN9UWd8nlUnY60Mm+7/DSsX9HI007sJX1t8=@lists.denx.de
X-Gm-Message-State: AOJu0YzjqjPZpTDvvTlc4h8FyRSYYFuOqT5fTv6XYten4fMqIYNftfKc
 KQCj2G0RD1D+h+qst4GhUYackUFhuAvrYofBuRnHDCoorcqUjHdydqwIu5PBRSQ=
X-Google-Smtp-Source: AGHT+IFWKOKDTk7RT8PdldLlJWOVWkdlpXRyRzD9ixQAlg4qykvwC5kFlfA5jwrAxe3LfzoCaxrXVQ==
X-Received: by 2002:ac8:57d5:0:b0:461:2150:d59f with SMTP id
 d75a77b69052e-4613bfddbfamr138619751cf.8.1730145189502; 
 Mon, 28 Oct 2024 12:53:09 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-461323a1fbesm37669701cf.82.2024.10.28.12.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 12:53:08 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:53:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v8 7/8] test: efi: boot: Set up an image suitable for EFI
 testing
Message-ID: <20241028195305.GT4959@bill-the-cat>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-8-sjg@chromium.org>
 <e29d4360-87c0-478c-be50-f9af99e6c2b9@gmx.de>
 <67974fc5-0aee-4160-a29e-61a29e383f2c@gmx.de>
 <CAFLszTh+z6y8xcYFS_UOyn1aqipBCujs0WaivQAtoo7+BkrxKA@mail.gmail.com>
 <195d624a-507a-4008-b576-4fb017ad1e64@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VbAeO+XbS17icnh5"
Content-Disposition: inline
In-Reply-To: <195d624a-507a-4008-b576-4fb017ad1e64@gmx.de>
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


--VbAeO+XbS17icnh5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 08:33:04PM +0100, Heinrich Schuchardt wrote:
> On 10/28/24 18:02, Simon Glass wrote:
> > Hi Heinrich,
> >=20
> > On Mon, 28 Oct 2024 at 11:25, Heinrich Schuchardt <xypron.glpk@gmx.de
> > <mailto:xypron.glpk@gmx.de>> wrote:
> >  >
> >  > On 10/28/24 07:08, Heinrich Schuchardt wrote:
> >  > > On 10/22/24 14:00, Simon Glass wrote:
> >  > >> Create a new disk for use with tests, which contains the new 'tes=
tapp'
> >  > >> EFI app specifically intended for testing the EFI loader.
> >  > >>
> >  > >> Attach it to the USB device, since most testing is currently done=
 with
> >  > >> mmc.
> >  > >>
> >  > >> Initially this image will be used to test the EFI bootmeth.
> >  > >>
> >  > >> Fix a stale comment in prep_mmc_bootdev() while we are here.
> >  > >>
> >  > >> For now this uses sudo and a compressed fallback file, like all t=
he
> >  > >> other bootstd tests. Once this series is in, the patch which moves
> >  > >> this to use user-space tools will be cleaned up and re-submitted.
> >  > >>
> >  > >> Signed-off-by: Simon Glass <sjg@chromium.org
> > <mailto:sjg@chromium.org>>
> >  > >>
> >  > >> ---
> >  > >> Here is the patch to avoid sudo and CI fallback:
> >  > >>
> >  > >> [1] https://patchwork.ozlabs.org/project/uboot/patch/ <https://
> > patchwork.ozlabs.org/project/uboot/patch/>
> >  > >> 20240802093322.15240-1-richard@nod.at/
> > <http://20240802093322.15240-1-richard@nod.at/>
> >  > >>
> >  > >> (no changes since v1)
> >  > >>
> >  > >>=A0 =A0arch/sandbox/dts/test.dts=A0 =A0 =A0 =A0 =A0 =A0|=A0 =A02 +-
> >  > >>=A0 =A0test/boot/bootdev.c=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=A0 =
18 +++++++++-
> >  > >>=A0 =A0test/boot/bootflow.c=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=A0 =
=A02 +-
> >  > >>=A0 =A0test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
> >  > >>=A0 =A0test/py/tests/test_ut.py=A0 =A0 =A0 =A0 =A0 =A0 |=A0 52 +++=
+++++++++++++++++++
> > ++----
> >  > >>=A0 =A05 files changed, 65 insertions(+), 9 deletions(-)
> >  > >>=A0 =A0create mode 100644 test/py/tests/bootstd/flash1.img.xz
> >  > >>
> >  > >> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> >  > >> index 9bf44ae3b0b..f40fd5a2b16 100644
> >  > >> --- a/arch/sandbox/dts/test.dts
> >  > >> +++ b/arch/sandbox/dts/test.dts
> >  > >> @@ -1512,7 +1512,7 @@
> >  > >>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flash-stick@1 {
> >  > >>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <1>;
> >  > >>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "san=
dbox,usb-flash";
> >  > >> -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sandbox,filepath =3D "te=
stflash1.bin";
> >  > >> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sandbox,filepath =3D "fl=
ash1.img";
> >  > >>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> >  > >>
> >  > >>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flash-stick@2 {
> >  > >> diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
> >  > >> index 369105ca4cf..c892854b227 100644
> >  > >> --- a/test/boot/bootdev.c
> >  > >> +++ b/test/boot/bootdev.c
> >  > >> @@ -221,6 +221,10 @@ static int bootdev_test_order(struct
> >  > >> unit_test_state *uts)
> >  > >>=A0 =A0 =A0 =A0/* Use the environment variable to override it */
> >  > >>=A0 =A0 =A0 =A0ut_assertok(env_set("boot_targets", "mmc1 mmc2 usb"=
));
> >  > >>=A0 =A0 =A0 =A0ut_assertok(bootflow_scan_first(NULL, NULL, &iter, =
0, &bflow));
> >  > >> +
> >  > >> +=A0 =A0 /* get the usb device which has a backing file (flash1.i=
mg) */
> >  > >> +=A0 =A0 ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> >  > >> +
> >  > >>=A0 =A0 =A0 =A0ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bfl=
ow));
> >  > >>=A0 =A0 =A0 =A0ut_asserteq(5, iter.num_devs);
> >  > >>=A0 =A0 =A0 =A0ut_asserteq_str("mmc1.bootdev", iter.dev_used[0]->n=
ame);
> >  > >> @@ -260,7 +264,11 @@ static int bootdev_test_order(struct
> >  > >> unit_test_state *uts)
> >  > >>=A0 =A0 =A0 =A0ut_assertok(bootflow_scan_first(NULL, NULL, &iter, =
0, &bflow));
> >  > >>=A0 =A0 =A0 =A0ut_asserteq(2, iter.num_devs);
> >  > >>
> >  > >> -=A0 =A0 /* Now scan past mmc1 and make sure that the 3 USB devic=
es show
> >  > >> up */
> >  > >> +=A0 =A0 /*
> >  > >> +=A0 =A0 =A0* Now scan past mmc1 and make sure that the 3 USB dev=
ices show
> >  > >> up. The
> >  > >> +=A0 =A0 =A0* first one has a backing file so returns success
> >  > >> +=A0 =A0 =A0*/
> >  > >> +=A0 =A0 ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> >  > >>=A0 =A0 =A0 =A0ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bfl=
ow));
> >  > >>=A0 =A0 =A0 =A0ut_asserteq(6, iter.num_devs);
> >  > >>=A0 =A0 =A0 =A0ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->n=
ame);
> >  > >> @@ -322,6 +330,10 @@ static int bootdev_test_prio(struct
> >  > >> unit_test_state *uts)
> >  > >>
> >  > >>=A0 =A0 =A0 =A0/* 3 MMC and 3 USB bootdevs: MMC should come before=
 USB */
> >  > >>=A0 =A0 =A0 =A0ut_assertok(bootflow_scan_first(NULL, NULL, &iter, =
0, &bflow));
> >  > >> +
> >  > >> +=A0 =A0 /* get the usb device which has a backing file (flash1.i=
mg) */
> >  > >> +=A0 =A0 ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> >  > >> +
> >  > >>=A0 =A0 =A0 =A0ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bfl=
ow));
> >  > >>=A0 =A0 =A0 =A0ut_asserteq(6, iter.num_devs);
> >  > >>=A0 =A0 =A0 =A0ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->n=
ame);
> >  > >> @@ -339,6 +351,10 @@ static int bootdev_test_prio(struct
> >  > >> unit_test_state *uts)
> >  > >>=A0 =A0 =A0 =A0bootflow_iter_uninit(&iter);
> >  > >>=A0 =A0 =A0 =A0ut_assertok(bootflow_scan_first(NULL, NULL, &iter,
> > BOOTFLOWIF_HUNT,
> >  > >>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&bflow));
> >  > >> +
> >  > >> +=A0 =A0 /* get the usb device which has a backing file (flash1.i=
mg) */
> >  > >> +=A0 =A0 ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> >  > >> +
> >  > >>=A0 =A0 =A0 =A0ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bfl=
ow));
> >  > >>=A0 =A0 =A0 =A0ut_asserteq(7, iter.num_devs);
> >  > >>=A0 =A0 =A0 =A0ut_asserteq_str("usb_mass_storage.lun0.bootdev",
> >  > >> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> >  > >> index 539abe63ebe..d94c07963d5 100644
> >  > >> --- a/test/boot/bootflow.c
> >  > >> +++ b/test/boot/bootflow.c
> >  > >> @@ -533,7 +533,7 @@ static int prep_mmc_bootdev(struct unit_test_=
state
> >  > >> *uts, const char *mmc_dev,
> >  > >>
> >  > >>=A0 =A0 =A0 =A0order[2] =3D mmc_dev;
> >  > >>
> >  > >> -=A0 =A0 /* Enable the mmc4 node since we need a second bootflow =
*/
> >  > >> +=A0 =A0 /* Enable the requested mmc node since we need a second
> > bootflow */
> >  > >>=A0 =A0 =A0 =A0root =3D oftree_root(oftree_default());
> >  > >>=A0 =A0 =A0 =A0node =3D ofnode_find_subnode(root, mmc_dev);
> >  > >>=A0 =A0 =A0 =A0ut_assert(ofnode_valid(node));
> >  > >> diff --git a/test/py/tests/bootstd/flash1.img.xz b/test/py/tests/
> >  > >> bootstd/flash1.img.xz
> >  > >> new file mode 100644
> >  > >> index
> >  > >>
> > 0000000000000000000000000000000000000000..9148b91a20c1f0acb54449b124d14=
08961e92507
> >  > >
> >  > > We should not accept such binaries. This was just how xz was hacked
> >  > > (https://en.wikipedia.org/wiki/XZ_Utils_backdoor <https://
> > en.wikipedia.org/wiki/XZ_Utils_backdoor>).
> >  > >
> >  > > This binary wouldn't conform to the GPL 2.0 license either.
> >=20
> > Yes, I've offered to tidy up the patch and drop this binary (and the
> > others) once this test lands.
> >=20
> > [..]
> >=20
> >  > >> +def setup_efi_image(cons):
> >  > >> +=A0 =A0 """Create a 20MB disk image with an EFI app on it"""
> >  > >> +=A0 =A0 devnum =3D 1
> >  > >> +=A0 =A0 basename =3D 'flash'
> >  > >> +=A0 =A0 fname, mnt =3D setup_image(cons, devnum, 0xc, second_par=
t=3DTrue,
> >  > >> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0basen=
ame=3Dbasename)
> >  > >> +
> >  > >> +=A0 =A0 loop =3D None
> >  > >> +=A0 =A0 mounted =3D False
> >  > >> +=A0 =A0 complete =3D False
> >  > >> +=A0 =A0 try:
> >  > >> +=A0 =A0 =A0 =A0 loop =3D mount_image(cons, fname, mnt, 'ext4')
> >  > >> +=A0 =A0 =A0 =A0 mounted =3D True
> >  > >> +=A0 =A0 =A0 =A0 efi_dir =3D os.path.join(mnt, 'EFI')
> >  > >> +=A0 =A0 =A0 =A0 mkdir_cond(efi_dir)
> >  > >> +=A0 =A0 =A0 =A0 bootdir =3D os.path.join(efi_dir, 'BOOT')
> >  > >> +=A0 =A0 =A0 =A0 mkdir_cond(bootdir)
> >  > >> +=A0 =A0 =A0 =A0 efi_src =3D os.path.join(cons.config.build_dir,
> >  > >> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0f=
'lib/efi_loader/testapp.efi')
> >  > >> +=A0 =A0 =A0 =A0 efi_dst =3D os.path.join(bootdir, 'BOOTSBOX.EFI')
> >  >
> >  > As said I can live with the -n switch though that standards defying
> >  > bootsbox.efi name provides no benefit whatsoever. But, please, do not
> >  > ignore the switch.
> >=20
> > The -N flag is provided for allowing sandbox to use the correct, default
> > name for the underlying host. It is not intended for use in CI, where
> > 'sandbox is sandbox'. So far, CI calls sandbox without that flag, so the
> > code above is actually correct.
> >=20
> > Regards,
> > Simon
>=20
> Hello Simon,
>=20
> We are in round 8 of this patch series and it is still broken:
>=20
> You supply an xz image which we should never accept for security reasons.
>=20
> That xz image contains an EFI/BOOT/BOOTSBOX.EFI blob. This does not
> comply to the GPLv2 license.
>=20
> That blob is an amd64 binary. So nobody will be able it to run it in the
> sandbox built on the riscv64 or arm64 machines.
>=20
> * Please, remove the blob.
> * Do the same for all blobs in test/py/tests/bootstd/.
> * Provide a test test runs on all EFI architectures.
> * Make sure that we can run the test both on QEMU and on real hardware.
> * Please, comply in your test to the UEFI specification.

Simon has said he will pick up and finish off the series that removes
requiring sudo for tests, and I'm OK with that being a follow-up cleanup
to this series. It's not a new problem, and since he's said he'll fix
it, I'm OK with that.

--=20
Tom

--VbAeO+XbS17icnh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcf650ACgkQFHw5/5Y0
tyykQAv9HFCzSZ+va5KtrMe2X9RYsgXFtP8M1NKYCcaL9vfL+Z6YiRIsuSJRq73j
iQNX+U5GPGAi3a0HzGoDbvqwPhdc991cWOuTnM3QaIWzJeBnAOpoLLT1TvQ15ES+
000TsRTiI7DN9vtg6XFJ+uFtpIRw5yAM4RhdUYRvDJuXeCxZkDNuC6MzwKL+XdsU
HlWL+xdExRGSj7k8MgnQohmKqvyx3CzxMWOXT+XHgqYx+iBzCIiJ+GsgpUdfzpvK
HwyAI4NEgQ/5DFShCsVjINekiJmEO4im0z7Clvg6iSeBuT6w+G8xoPbE7FH69iIr
6dPa95VrUpollvfRqbODZBMQ6yYXl3TI1V69NmpHGkNp74i1QR/UdBWPMOpbQhWn
Hr5UyMkx4/6W6xi/AZrk63yULqx8zD94/uFuc1fhYamq6LlOBfeeDrP/cMqIpG+l
Jsnd2eS7rzE7iAeqvd26XHn9vjmTSA1zI5EY9q3LCSrmiX7aHxs11pxJK8C6EIob
mgzfqwZj
=Jq3d
-----END PGP SIGNATURE-----

--VbAeO+XbS17icnh5--
