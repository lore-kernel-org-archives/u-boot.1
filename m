Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35971D339A1
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B93E689099;
	Mon, 28 Oct 2024 18:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hA52mjKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 709428907D; Mon, 28 Oct 2024 18:02:41 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA300890B3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c97c7852e8so6538054a12.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730134958; x=1730739758; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RPhm3T/XjDL6aFomrata+x1dgzWUWC+AEJnvrV03O/4=;
 b=hA52mjKLfwR0X6kCl0BJv3dAYw9GUTdcqvHz51FReyKacDe4towU6HR/Be665mEQQV
 JAW2hENt9T7Rru4GriVJWbisCrIkZDj0wKc5yDiZ247/5KUNRc+rmRe3dwUTv5xiLAsj
 QvMu+P4vP/cNofsHVKQaHZMLcl6o+qyBZ0PhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730134958; x=1730739758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RPhm3T/XjDL6aFomrata+x1dgzWUWC+AEJnvrV03O/4=;
 b=vcip5IbjgXn4LVb22gWlQzUVsBfENIZxyhmpPfM9mBv6M4FfGae0MQuHTKpY7pzwbP
 ioGNrhD86QzbK2dOZzv9F+kslx8+HAAt7NmUnHtpH0hBc6C3+cek0468Ok73BvK9PeQl
 ZDHY96y4SfurGXBIKwTwjXObnxrBu+H0fiarWtYEQp9R381jIAnMZpsd8LLbdP1EDmNL
 lVf6EWrrXsMjWc8gaWeCNwmAbrbFOL+X2MtlCVnjWiWDh9rOdzDcjKRjv9i350ZQ3nwb
 2JAsKYcEhKofMMH8A87c+ZOO3aY5l8Z8o46Vy+dAO7+rYz0kP4W7wmOgm0DOoV4a31vH
 UXqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO3kCePhLWxlc43k8Kk4GRq7HPZ8GM3F2t8Uk+iJiSzQEzd7ucMzY+V1zVjRK4n7tzh/I5xqg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyjyl36F9351BpHAjkWGvZ99cFz76cuMPNNBUClx8XHh62SEnU/
 fP9eDnq/biPae0bgD/iG1VTtWbcWmkTs7RqmU2Rs53Ujbh+6P2hP0kMTVl16kVfKy8qjB5g+9EU
 k9S5pnVO+raoBe5YT45KVIuGicIPKSHu3QYn7
X-Google-Smtp-Source: AGHT+IGhIpy5rgNvxPa5WWqMzWx9C8pmnFSiURUV73bxRDCckVfUlz4Ld6meYBVkIDPy9/ZjDi9A3ITy7MWpBMV+3VQ=
X-Received: by 2002:a17:907:7ea0:b0:a9a:17fb:4c40 with SMTP id
 a640c23a62f3a-a9de5d6e1e7mr794918166b.26.1730134957981; Mon, 28 Oct 2024
 10:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-8-sjg@chromium.org>
 <e29d4360-87c0-478c-be50-f9af99e6c2b9@gmx.de>
 <67974fc5-0aee-4160-a29e-61a29e383f2c@gmx.de>
In-Reply-To: <67974fc5-0aee-4160-a29e-61a29e383f2c@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:02:25 +0100
Message-ID: <CAFLszTh+z6y8xcYFS_UOyn1aqipBCujs0WaivQAtoo7+BkrxKA@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] test: efi: boot: Set up an image suitable for EFI
 testing
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Yang Xiwen <forbidden405@outlook.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich,

On Mon, 28 Oct 2024 at 11:25, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:
>
> On 10/28/24 07:08, Heinrich Schuchardt wrote:
> > On 10/22/24 14:00, Simon Glass wrote:
> >> Create a new disk for use with tests, which contains the new 'testapp'
> >> EFI app specifically intended for testing the EFI loader.
> >>
> >> Attach it to the USB device, since most testing is currently done with
> >> mmc.
> >>
> >> Initially this image will be used to test the EFI bootmeth.
> >>
> >> Fix a stale comment in prep_mmc_bootdev() while we are here.
> >>
> >> For now this uses sudo and a compressed fallback file, like all the
> >> other bootstd tests. Once this series is in, the patch which moves
> >> this to use user-space tools will be cleaned up and re-submitted.
> >>
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>
> >> ---
> >> Here is the patch to avoid sudo and CI fallback:
> >>
> >> [1] https://patchwork.ozlabs.org/project/uboot/patch/
> >> 20240802093322.15240-1-richard@nod.at/
> >>
> >> (no changes since v1)
> >>
> >>   arch/sandbox/dts/test.dts           |   2 +-
> >>   test/boot/bootdev.c                 |  18 +++++++++-
> >>   test/boot/bootflow.c                |   2 +-
> >>   test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
> >>   test/py/tests/test_ut.py            |  52
++++++++++++++++++++++++----
> >>   5 files changed, 65 insertions(+), 9 deletions(-)
> >>   create mode 100644 test/py/tests/bootstd/flash1.img.xz
> >>
> >> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> >> index 9bf44ae3b0b..f40fd5a2b16 100644
> >> --- a/arch/sandbox/dts/test.dts
> >> +++ b/arch/sandbox/dts/test.dts
> >> @@ -1512,7 +1512,7 @@
> >>                   flash-stick@1 {
> >>                       reg = <1>;
> >>                       compatible = "sandbox,usb-flash";
> >> -                    sandbox,filepath = "testflash1.bin";
> >> +                    sandbox,filepath = "flash1.img";
> >>                   };
> >>
> >>                   flash-stick@2 {
> >> diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
> >> index 369105ca4cf..c892854b227 100644
> >> --- a/test/boot/bootdev.c
> >> +++ b/test/boot/bootdev.c
> >> @@ -221,6 +221,10 @@ static int bootdev_test_order(struct
> >> unit_test_state *uts)
> >>       /* Use the environment variable to override it */
> >>       ut_assertok(env_set("boot_targets", "mmc1 mmc2 usb"));
> >>       ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
> >> +
> >> +    /* get the usb device which has a backing file (flash1.img) */
> >> +    ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> >> +
> >>       ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
> >>       ut_asserteq(5, iter.num_devs);
> >>       ut_asserteq_str("mmc1.bootdev", iter.dev_used[0]->name);
> >> @@ -260,7 +264,11 @@ static int bootdev_test_order(struct
> >> unit_test_state *uts)
> >>       ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
> >>       ut_asserteq(2, iter.num_devs);
> >>
> >> -    /* Now scan past mmc1 and make sure that the 3 USB devices show
> >> up */
> >> +    /*
> >> +     * Now scan past mmc1 and make sure that the 3 USB devices show
> >> up. The
> >> +     * first one has a backing file so returns success
> >> +     */
> >> +    ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> >>       ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
> >>       ut_asserteq(6, iter.num_devs);
> >>       ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
> >> @@ -322,6 +330,10 @@ static int bootdev_test_prio(struct
> >> unit_test_state *uts)
> >>
> >>       /* 3 MMC and 3 USB bootdevs: MMC should come before USB */
> >>       ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
> >> +
> >> +    /* get the usb device which has a backing file (flash1.img) */
> >> +    ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> >> +
> >>       ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
> >>       ut_asserteq(6, iter.num_devs);
> >>       ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
> >> @@ -339,6 +351,10 @@ static int bootdev_test_prio(struct
> >> unit_test_state *uts)
> >>       bootflow_iter_uninit(&iter);
> >>       ut_assertok(bootflow_scan_first(NULL, NULL, &iter,
BOOTFLOWIF_HUNT,
> >>                       &bflow));
> >> +
> >> +    /* get the usb device which has a backing file (flash1.img) */
> >> +    ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> >> +
> >>       ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
> >>       ut_asserteq(7, iter.num_devs);
> >>       ut_asserteq_str("usb_mass_storage.lun0.bootdev",
> >> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> >> index 539abe63ebe..d94c07963d5 100644
> >> --- a/test/boot/bootflow.c
> >> +++ b/test/boot/bootflow.c
> >> @@ -533,7 +533,7 @@ static int prep_mmc_bootdev(struct unit_test_state
> >> *uts, const char *mmc_dev,
> >>
> >>       order[2] = mmc_dev;
> >>
> >> -    /* Enable the mmc4 node since we need a second bootflow */
> >> +    /* Enable the requested mmc node since we need a second bootflow
*/
> >>       root = oftree_root(oftree_default());
> >>       node = ofnode_find_subnode(root, mmc_dev);
> >>       ut_assert(ofnode_valid(node));
> >> diff --git a/test/py/tests/bootstd/flash1.img.xz b/test/py/tests/
> >> bootstd/flash1.img.xz
> >> new file mode 100644
> >> index
> >>
0000000000000000000000000000000000000000..9148b91a20c1f0acb54449b124d1408961e92507
> >
> > We should not accept such binaries. This was just how xz was hacked
> > (https://en.wikipedia.org/wiki/XZ_Utils_backdoor).
> >
> > This binary wouldn't conform to the GPL 2.0 license either.

Yes, I've offered to tidy up the patch and drop this binary (and the
others) once this test lands.

[..]

> >> +def setup_efi_image(cons):
> >> +    """Create a 20MB disk image with an EFI app on it"""
> >> +    devnum = 1
> >> +    basename = 'flash'
> >> +    fname, mnt = setup_image(cons, devnum, 0xc, second_part=True,
> >> +                             basename=basename)
> >> +
> >> +    loop = None
> >> +    mounted = False
> >> +    complete = False
> >> +    try:
> >> +        loop = mount_image(cons, fname, mnt, 'ext4')
> >> +        mounted = True
> >> +        efi_dir = os.path.join(mnt, 'EFI')
> >> +        mkdir_cond(efi_dir)
> >> +        bootdir = os.path.join(efi_dir, 'BOOT')
> >> +        mkdir_cond(bootdir)
> >> +        efi_src = os.path.join(cons.config.build_dir,
> >> +                               f'lib/efi_loader/testapp.efi')
> >> +        efi_dst = os.path.join(bootdir, 'BOOTSBOX.EFI')
>
> As said I can live with the -n switch though that standards defying
> bootsbox.efi name provides no benefit whatsoever. But, please, do not
> ignore the switch.

The -N flag is provided for allowing sandbox to use the correct, default
name for the underlying host. It is not intended for use in CI, where
'sandbox is sandbox'. So far, CI calls sandbox without that flag, so the
code above is actually correct.

Regards,
Simon
