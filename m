Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432A3D3E2BA
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3EFB890D1;
	Mon, 28 Oct 2024 20:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="knHxhQTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A18D0890D1; Mon, 28 Oct 2024 20:33:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C69868913A
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730143985; x=1730748785; i=xypron.glpk@gmx.de;
 bh=1vPb1bBanrjB4gwtNauXrejOIyGHh0nWhmXMVi3PLuc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=knHxhQTmn/ouJ93AMKCiu36JBLfG6M5UNxbfRYhdqmgpLuLAjYg1M9GRJtVTbJAY
 tyc6gnE2E7Jw+kcXOWhb6c+2St3LL0JZEubD2fDv7lVVIx7uP0oQS8b0oNacR7pIt
 lrSxWDCOqIVgkdtdvxP+YH+JZ7CsBFMQPABTB8zXj6IHm63yabnTauuRUU/1UVqt3
 ji5el3u8wVtu9KA+ihjqXCBbj9lHGusnXshVkMVR7T6ztjF+Y/i8FAcYYYnphH61V
 Uxo1nVhyuIgQvaC/ui9gfFDVMtovQ5Lb97Hpar8nmq0yqpDkD4r/3NsFcl2CTzJ7l
 0Uubmn2Zl9CvXS0T9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvcA-1tRQ2b1zQu-00TroK; Mon, 28
 Oct 2024 20:33:05 +0100
Message-ID: <195d624a-507a-4008-b576-4fb017ad1e64@gmx.de>
Date: Mon, 28 Oct 2024 20:33:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] test: efi: boot: Set up an image suitable for EFI
 testing
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Eddie James
 <eajames@linux.ibm.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-8-sjg@chromium.org>
 <e29d4360-87c0-478c-be50-f9af99e6c2b9@gmx.de>
 <67974fc5-0aee-4160-a29e-61a29e383f2c@gmx.de>
 <CAFLszTh+z6y8xcYFS_UOyn1aqipBCujs0WaivQAtoo7+BkrxKA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTh+z6y8xcYFS_UOyn1aqipBCujs0WaivQAtoo7+BkrxKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+8UtgvNl/U0tgZ/cCj47II7M7V3Eqr68EcUIGRgqMCxgmxclNBO
 gwx8FirdbBedPv0+vTmfkdIHzlvCMmhfFpxrRd+uLDbR0DsAA2Br0mUiro/b5XdYuEZXO09
 xphTr+/qko5k3i4PXHZRqEgtnqfrnvtg5frnje5sDr+iVwhz9GxBcKsroRi5l4gTVD15x/h
 c+cVAdICW1n8I6F1PJGSg==
UI-OutboundReport: notjunk:1;M01:P0:0U460pPscE4=;1ScDMdDoQ4bolp31AvxQNCPAqnB
 vXQ7Nkl/smnFLHw08W/VmduNv7HksNDB3F3+Wn7+2bvy88bgfIHGMzh5BOCNJWAN7XuPUfKKE
 lIeCrhLi2eK2EnkVTW5N5tQwWosvOdNlUMKacU5lwchfNAWlPVOOULPhIdOO1cbe/aQ6RSX5A
 EM8rLVz4jawrAbxwO7eFhhWJhmUukI+A4mjmOBqvzYeUajAxS7NjLjBeOdVrVru7/RrWj3BNN
 fe0Tr67IY4ZEpt7H6g9EHuu1C/TYmecCcaSmvgVi/+sbBARA+7SNiwQ+u01+mPBow/bBAj58s
 59Cnhr3IeDlAZ+UaxFrEoCll/W5Y6Rxpf5Ni1gERsBCLnK8arElaetS0JIfIvlP6e86nlMGl5
 s4VVRgppE0g0x64JApED7zZd0X8aFbO1TxwJ2nkQtLCqJWa6hPH67ExVb9XiwpXCQuOBk3tvV
 g8If13Pl2F/f31NvQrVRNH57NkTVo9CDdCBrJApkXzkOX4MzKiQYiGISq5sTWrSDaOzZzKluv
 CksL3FAkBllRNmpasP/Y3K6PoI4GItOkIgZsEVuaj1ImJkM557QUHorzvtJ9yNgsZxuV57V6n
 6mOp1DuTYZ5SxqDeDpew1PMwCKW+Z+vXfDMsb77j+vtlpRUHWgYd+q6vtKNIsa1a1WATFchjP
 Pc639DHTJ+0637hQyNpkzAuE9oTKSvjs/DqBX13XojSAaqs9yhbwUmm5of1GNaFWQC1F+aUqV
 pfooD8JAavRPJ/7kjZA+7we+6BXYEpo1tMupm9TYo8QMRwiNRC84JHWPO3yofyX+ENdQrqAPM
 6k1UGHov68pG8DXF+CWWK8lj9SJcPhYJqws9vzLQyNRN0=
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

On 10/28/24 18:02, Simon Glass wrote:
> Hi Heinrich,
>
> On Mon, 28 Oct 2024 at 11:25, Heinrich Schuchardt <xypron.glpk@gmx.de
> <mailto:xypron.glpk@gmx.de>> wrote:
>  >
>  > On 10/28/24 07:08, Heinrich Schuchardt wrote:
>  > > On 10/22/24 14:00, Simon Glass wrote:
>  > >> Create a new disk for use with tests, which contains the new 'test=
app'
>  > >> EFI app specifically intended for testing the EFI loader.
>  > >>
>  > >> Attach it to the USB device, since most testing is currently done =
with
>  > >> mmc.
>  > >>
>  > >> Initially this image will be used to test the EFI bootmeth.
>  > >>
>  > >> Fix a stale comment in prep_mmc_bootdev() while we are here.
>  > >>
>  > >> For now this uses sudo and a compressed fallback file, like all th=
e
>  > >> other bootstd tests. Once this series is in, the patch which moves
>  > >> this to use user-space tools will be cleaned up and re-submitted.
>  > >>
>  > >> Signed-off-by: Simon Glass <sjg@chromium.org
> <mailto:sjg@chromium.org>>
>  > >>
>  > >> ---
>  > >> Here is the patch to avoid sudo and CI fallback:
>  > >>
>  > >> [1] https://patchwork.ozlabs.org/project/uboot/patch/ <https://
> patchwork.ozlabs.org/project/uboot/patch/>
>  > >> 20240802093322.15240-1-richard@nod.at/
> <http://20240802093322.15240-1-richard@nod.at/>
>  > >>
>  > >> (no changes since v1)
>  > >>
>  > >>=C2=A0 =C2=A0arch/sandbox/dts/test.dts=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +-
>  > >>=C2=A0 =C2=A0test/boot/bootdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 18 +++++++++-
>  > >>=C2=A0 =C2=A0test/boot/bootflow.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-
>  > >>=C2=A0 =C2=A0test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 by=
tes
>  > >>=C2=A0 =C2=A0test/py/tests/test_ut.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 52 ++++++++++++++++++++++
> ++----
>  > >>=C2=A0 =C2=A05 files changed, 65 insertions(+), 9 deletions(-)
>  > >>=C2=A0 =C2=A0create mode 100644 test/py/tests/bootstd/flash1.img.xz
>  > >>
>  > >> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
>  > >> index 9bf44ae3b0b..f40fd5a2b16 100644
>  > >> --- a/arch/sandbox/dts/test.dts
>  > >> +++ b/arch/sandbox/dts/test.dts
>  > >> @@ -1512,7 +1512,7 @@
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0flash-stick@1 {
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0reg =3D <1>;
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0compatible =3D "sandbox,usb-flash";
>  > >> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 sandbox,filepath =3D "testflash1.bin";
>  > >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 sandbox,filepath =3D "flash1.img";
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0};
>  > >>
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0flash-stick@2 {
>  > >> diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
>  > >> index 369105ca4cf..c892854b227 100644
>  > >> --- a/test/boot/bootdev.c
>  > >> +++ b/test/boot/bootdev.c
>  > >> @@ -221,6 +221,10 @@ static int bootdev_test_order(struct
>  > >> unit_test_state *uts)
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Use the environment variable to overr=
ide it */
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_assertok(env_set("boot_targets", "mmc=
1 mmc2 usb"));
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_assertok(bootflow_scan_first(NULL, NU=
LL, &iter, 0, &bflow));
>  > >> +
>  > >> +=C2=A0 =C2=A0 /* get the usb device which has a backing file (fla=
sh1.img) */
>  > >> +=C2=A0 =C2=A0 ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
>  > >> +
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq(-ENODEV, bootflow_scan_next(=
&iter, &bflow));
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq(5, iter.num_devs);
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq_str("mmc1.bootdev", iter.dev=
_used[0]->name);
>  > >> @@ -260,7 +264,11 @@ static int bootdev_test_order(struct
>  > >> unit_test_state *uts)
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_assertok(bootflow_scan_first(NULL, NU=
LL, &iter, 0, &bflow));
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq(2, iter.num_devs);
>  > >>
>  > >> -=C2=A0 =C2=A0 /* Now scan past mmc1 and make sure that the 3 USB =
devices show
>  > >> up */
>  > >> +=C2=A0 =C2=A0 /*
>  > >> +=C2=A0 =C2=A0 =C2=A0* Now scan past mmc1 and make sure that the 3=
 USB devices show
>  > >> up. The
>  > >> +=C2=A0 =C2=A0 =C2=A0* first one has a backing file so returns suc=
cess
>  > >> +=C2=A0 =C2=A0 =C2=A0*/
>  > >> +=C2=A0 =C2=A0 ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq(-ENODEV, bootflow_scan_next(=
&iter, &bflow));
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq(6, iter.num_devs);
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq_str("mmc2.bootdev", iter.dev=
_used[0]->name);
>  > >> @@ -322,6 +330,10 @@ static int bootdev_test_prio(struct
>  > >> unit_test_state *uts)
>  > >>
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 3 MMC and 3 USB bootdevs: MMC should =
come before USB */
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_assertok(bootflow_scan_first(NULL, NU=
LL, &iter, 0, &bflow));
>  > >> +
>  > >> +=C2=A0 =C2=A0 /* get the usb device which has a backing file (fla=
sh1.img) */
>  > >> +=C2=A0 =C2=A0 ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
>  > >> +
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq(-ENODEV, bootflow_scan_next(=
&iter, &bflow));
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq(6, iter.num_devs);
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq_str("mmc2.bootdev", iter.dev=
_used[0]->name);
>  > >> @@ -339,6 +351,10 @@ static int bootdev_test_prio(struct
>  > >> unit_test_state *uts)
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0bootflow_iter_uninit(&iter);
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_assertok(bootflow_scan_first(NULL, NU=
LL, &iter,
> BOOTFLOWIF_HUNT,
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&bflow));
>  > >> +
>  > >> +=C2=A0 =C2=A0 /* get the usb device which has a backing file (fla=
sh1.img) */
>  > >> +=C2=A0 =C2=A0 ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
>  > >> +
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq(-ENODEV, bootflow_scan_next(=
&iter, &bflow));
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq(7, iter.num_devs);
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq_str("usb_mass_storage.lun0.b=
ootdev",
>  > >> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
>  > >> index 539abe63ebe..d94c07963d5 100644
>  > >> --- a/test/boot/bootflow.c
>  > >> +++ b/test/boot/bootflow.c
>  > >> @@ -533,7 +533,7 @@ static int prep_mmc_bootdev(struct unit_test_s=
tate
>  > >> *uts, const char *mmc_dev,
>  > >>
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0order[2] =3D mmc_dev;
>  > >>
>  > >> -=C2=A0 =C2=A0 /* Enable the mmc4 node since we need a second boot=
flow */
>  > >> +=C2=A0 =C2=A0 /* Enable the requested mmc node since we need a se=
cond
> bootflow */
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0root =3D oftree_root(oftree_default());
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D ofnode_find_subnode(root, mmc_d=
ev);
>  > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_assert(ofnode_valid(node));
>  > >> diff --git a/test/py/tests/bootstd/flash1.img.xz b/test/py/tests/
>  > >> bootstd/flash1.img.xz
>  > >> new file mode 100644
>  > >> index
>  > >>
> 0000000000000000000000000000000000000000..9148b91a20c1f0acb54449b124d140=
8961e92507
>  > >
>  > > We should not accept such binaries. This was just how xz was hacked
>  > > (https://en.wikipedia.org/wiki/XZ_Utils_backdoor <https://
> en.wikipedia.org/wiki/XZ_Utils_backdoor>).
>  > >
>  > > This binary wouldn't conform to the GPL 2.0 license either.
>
> Yes, I've offered to tidy up the patch and drop this binary (and the
> others) once this test lands.
>
> [..]
>
>  > >> +def setup_efi_image(cons):
>  > >> +=C2=A0 =C2=A0 """Create a 20MB disk image with an EFI app on it""=
"
>  > >> +=C2=A0 =C2=A0 devnum =3D 1
>  > >> +=C2=A0 =C2=A0 basename =3D 'flash'
>  > >> +=C2=A0 =C2=A0 fname, mnt =3D setup_image(cons, devnum, 0xc, secon=
d_part=3DTrue,
>  > >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0basename=3Dbasename)
>  > >> +
>  > >> +=C2=A0 =C2=A0 loop =3D None
>  > >> +=C2=A0 =C2=A0 mounted =3D False
>  > >> +=C2=A0 =C2=A0 complete =3D False
>  > >> +=C2=A0 =C2=A0 try:
>  > >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 loop =3D mount_image(cons, fname, mnt=
, 'ext4')
>  > >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mounted =3D True
>  > >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 efi_dir =3D os.path.join(mnt, 'EFI')
>  > >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mkdir_cond(efi_dir)
>  > >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bootdir =3D os.path.join(efi_dir, 'BO=
OT')
>  > >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mkdir_cond(bootdir)
>  > >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 efi_src =3D os.path.join(cons.config.=
build_dir,
>  > >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f'lib/efi_loader/testapp.e=
fi')
>  > >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 efi_dst =3D os.path.join(bootdir, 'BO=
OTSBOX.EFI')
>  >
>  > As said I can live with the -n switch though that standards defying
>  > bootsbox.efi name provides no benefit whatsoever. But, please, do not
>  > ignore the switch.
>
> The -N flag is provided for allowing sandbox to use the correct, default
> name for the underlying host. It is not intended for use in CI, where
> 'sandbox is sandbox'. So far, CI calls sandbox without that flag, so the
> code above is actually correct.
>
> Regards,
> Simon

Hello Simon,

We are in round 8 of this patch series and it is still broken:

You supply an xz image which we should never accept for security reasons.

That xz image contains an EFI/BOOT/BOOTSBOX.EFI blob. This does not
comply to the GPLv2 license.

That blob is an amd64 binary. So nobody will be able it to run it in the
sandbox built on the riscv64 or arm64 machines.

* Please, remove the blob.
* Do the same for all blobs in test/py/tests/bootstd/.
* Provide a test test runs on all EFI architectures.
* Make sure that we can run the test both on QEMU and on real hardware.
* Please, comply in your test to the UEFI specification.

Best regards

Heinrich
