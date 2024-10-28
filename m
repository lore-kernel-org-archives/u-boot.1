Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815D7D1358C
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 06:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 104698901F;
	Mon, 28 Oct 2024 07:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jwpudtfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FCCD8901F; Mon, 28 Oct 2024 07:08:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD33688360
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 07:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730095691; x=1730700491; i=xypron.glpk@gmx.de;
 bh=RpPuIv+B2h9bjpN/+7u1690h8EthlPUM+v2pjaYfJ1k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jwpudtfjjoDFvzW5Tu5G6U41iLJm73V8kYs2Tl8TjA8ac8M6dQePuIBtI5/X5Ft0
 l6KiKqSyYMQjZka9/nmYa4XhUEWGvKM27awyjywe9OWHa2b1B+1tDMSBqb0/Glffk
 oNb0xjRr2ceMkc3drdofmTUixKmpfHRJDbI3DV0p8K5HWn5ZaD0l3V1Hik6PTfQqG
 4nTajCivmLsTo/r3CFPUg9Kfc870aAgZT2eNi3hoX8G0wEjVDGo3IDteKZ/E7p0s/
 u1UZNGzj+JwXRUNB4qFG1OVvXwFt29q0CsObIhRKpKHeZKyq93aMx7nF20bjWaGjX
 mv+nb4bktfk3bOnQnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvqW-1tcza11FLy-00gSnV; Mon, 28
 Oct 2024 07:08:11 +0100
Message-ID: <e29d4360-87c0-478c-be50-f9af99e6c2b9@gmx.de>
Date: Mon, 28 Oct 2024 07:08:09 +0100
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
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241022120032.196311-8-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K3kvZ2LqCimgEiYVqYYY1G3nFKSUjIFC6vUeDonB/r9BWYtB+WS
 F40ddY3nmaAERRzToA2BJqsrZWoPn539l9KtCEvnQIlzidHjXiw6jwmxU4DdJDXl6PEzoZv
 G4dK7jsUxupfeKmg03K8pvWhDdvhtMIOQN7khkBxsGCDtOqofY6wnCOd6YZ3Dn+Y7flLIfY
 ypwmLiLiqB0u+ZHY2NGsg==
UI-OutboundReport: notjunk:1;M01:P0:rTE0EcNZKqo=;/Q1wdRERrPKqayVowOQecLMGiJ3
 tWRX1/gY/3+Yl6j2blZqajTUfMRnhocQ7IjAr+jJGBqh5TmeRzny1aT3CymZkCmdk0VZQcElD
 RnTYwMS0/LeOYMWHMzVwS0SfbwkecEFUJvwrnLrjBu/zvSgcK+yCOrHyMPm6qeX9SCkJxbZTw
 c5qlTvRoE0KG1hsIaK1LSHYZ050z7dHAA9vPilnmks0lCkwFTtDFXFTECFwqbFoJV0aptE4U+
 ctbvLSqwH89If6k+o0ykq1a1sjOoWRJ4yjlK7dsRFDDjflm/d8DracPpbslhWZj6F9FQGc+pR
 PxIeTDhAhM1kdgBHMost7FZundzIGorTlSHRn7YMdbOiu/FyWbTtH+UjcdgCqBvR9Wf6qiiFX
 yBBmp0cCT0MdFjJ5lIsIMwLmqA0ohm0pteVjLxMmqhkIgKhhppoi3dIcaWgUmssLhXNzTPz5m
 2UP9bLQx+Hc1J9QSnJ1fd9fa+nVtD0A61x/1N81OnMKbO6ZY4bYcCOx1AxrDC1mAIxVd+gtNy
 FEdjZZZxG0aVGhy1gAIXHuVUJPp4vd0oW9FLGu6zBaC2UpgX4WFWSqEFUCBPDQ6NPgv8jGFyH
 vKvPeqH9yWR9YXTvIKPQn09AEjk4Q7iGuj+Jr7wrAYvJh+iBC+c8gR5Lp7OjNlFdAVd5tYXEL
 DyBTsyH2Bc33/9Sua1vy8+e1RzTKwszZ6XM01c+95Mt50/O/fGwRkoXjNduKY9Rp9z0dHL6wG
 p5JlVsM/uEBh4UYTDV2pZhiEUTCb0SaA70DJPmZgKykP3Teaepwfwh73Nr+Nq6J3NIYzL5g9+
 cuEzBvW8se4oHsEbeAhn/4cUuM2TxK3CodecNwd8KIzvw=
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

On 10/22/24 14:00, Simon Glass wrote:
> Create a new disk for use with tests, which contains the new 'testapp'
> EFI app specifically intended for testing the EFI loader.
>
> Attach it to the USB device, since most testing is currently done with
> mmc.
>
> Initially this image will be used to test the EFI bootmeth.
>
> Fix a stale comment in prep_mmc_bootdev() while we are here.
>
> For now this uses sudo and a compressed fallback file, like all the
> other bootstd tests. Once this series is in, the patch which moves
> this to use user-space tools will be cleaned up and re-submitted.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
>
> ---
> Here is the patch to avoid sudo and CI fallback:
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/
> 20240802093322.15240-1-richard@nod.at/
>
> (no changes since v1)
>
>   arch/sandbox/dts/test.dts           |   2 +-
>   test/boot/bootdev.c                 |  18 +++++++++-
>   test/boot/bootflow.c                |   2 +-
>   test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
>   test/py/tests/test_ut.py            |  52 ++++++++++++++++++++++++----
>   5 files changed, 65 insertions(+), 9 deletions(-)
>   create mode 100644 test/py/tests/bootstd/flash1.img.xz
>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 9bf44ae3b0b..f40fd5a2b16 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -1512,7 +1512,7 @@
>   				flash-stick@1 {
>   					reg =3D <1>;
>   					compatible =3D "sandbox,usb-flash";
> -					sandbox,filepath =3D "testflash1.bin";
> +					sandbox,filepath =3D "flash1.img";
>   				};
>
>   				flash-stick@2 {
> diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
> index 369105ca4cf..c892854b227 100644
> --- a/test/boot/bootdev.c
> +++ b/test/boot/bootdev.c
> @@ -221,6 +221,10 @@ static int bootdev_test_order(struct unit_test_stat=
e *uts)
>   	/* Use the environment variable to override it */
>   	ut_assertok(env_set("boot_targets", "mmc1 mmc2 usb"));
>   	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
> +
> +	/* get the usb device which has a backing file (flash1.img) */
> +	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> +
>   	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
>   	ut_asserteq(5, iter.num_devs);
>   	ut_asserteq_str("mmc1.bootdev", iter.dev_used[0]->name);
> @@ -260,7 +264,11 @@ static int bootdev_test_order(struct unit_test_stat=
e *uts)
>   	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
>   	ut_asserteq(2, iter.num_devs);
>
> -	/* Now scan past mmc1 and make sure that the 3 USB devices show up */
> +	/*
> +	 * Now scan past mmc1 and make sure that the 3 USB devices show up. Th=
e
> +	 * first one has a backing file so returns success
> +	 */
> +	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
>   	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
>   	ut_asserteq(6, iter.num_devs);
>   	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
> @@ -322,6 +330,10 @@ static int bootdev_test_prio(struct unit_test_state=
 *uts)
>
>   	/* 3 MMC and 3 USB bootdevs: MMC should come before USB */
>   	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
> +
> +	/* get the usb device which has a backing file (flash1.img) */
> +	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> +
>   	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
>   	ut_asserteq(6, iter.num_devs);
>   	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
> @@ -339,6 +351,10 @@ static int bootdev_test_prio(struct unit_test_state=
 *uts)
>   	bootflow_iter_uninit(&iter);
>   	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_HUNT,
>   					&bflow));
> +
> +	/* get the usb device which has a backing file (flash1.img) */
> +	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> +
>   	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
>   	ut_asserteq(7, iter.num_devs);
>   	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 539abe63ebe..d94c07963d5 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -533,7 +533,7 @@ static int prep_mmc_bootdev(struct unit_test_state *=
uts, const char *mmc_dev,
>
>   	order[2] =3D mmc_dev;
>
> -	/* Enable the mmc4 node since we need a second bootflow */
> +	/* Enable the requested mmc node since we need a second bootflow */
>   	root =3D oftree_root(oftree_default());
>   	node =3D ofnode_find_subnode(root, mmc_dev);
>   	ut_assert(ofnode_valid(node));
> diff --git a/test/py/tests/bootstd/flash1.img.xz b/test/py/tests/bootstd=
/flash1.img.xz
> new file mode 100644
> index 0000000000000000000000000000000000000000..9148b91a20c1f0acb54449b1=
24d1408961e92507

We should not accept such binaries. This was just how xz was hacked
(https://en.wikipedia.org/wiki/XZ_Utils_backdoor).

This binary wouldn't conform to the GPL 2.0 license either.

Best regards

Heinrich

> GIT binary patch
> literal 5016
> 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
p9
> z9<Ke9SBS3!ukGU#4CI-@!yY10$Hu`~TkU;%B9<w_?}51x8UCnvkWast$>!$S*si%Y
> z#K@3yE)2HKtuQf<(p%-MP;{u#ln=3DwpQ1YA#gF=3DREU4Ysw)eE4nJR61Dj5RfBZ~dM*
> zSMp96hovw!v!`3u@q#5n+3D*c)52Q{z19NhVU|dnO=3D-{cW*eIX_2Q97jaK23vWBG7
> z@m-4+V3|8nS|8n5(7fuqxU~m1hiT=3D)sP4+=3DFIXUT1|kn%EzpMCxRuaG>(_h94n9E@
> z^-0~gvKr&93iu$m=3DJxNvH`Z>5eVq0gWqPV|6Dd^9zrpc%XLqFfRKYs#OhX;3>Jm;b
> zh)!B^-RF<)Tr}SWQrPsyLGNqxRRqOIG#PiTgwEoM7^!y@5qBOR-Cf%U)jHUm7=3Dx1n
> zabX0NS!nxd?gq)JryA$B@Ibw^qlg)E=3DDN@e$6aC^s8+O<N*T+sZtE3VJS6CHR;Hfb
> zj6!OYV>_{x@AiR~<_W*A<j@8rZy})!cUSg4dNp5pXk>_j#gJdl-^e|Hn)_#5WHWmA
> z*>1210pl<x|1SJEm1hL6rCToRBa2%(;ktp6=3D{I?DPoB?_h#?1Y%pMU_Pnn5X#zFHB
> zkD8>k_~Sa)Oa|ASTX<>*J$=3DfQh1r%Sk4yV+%E8c2*ol{zZAGEORz}_=3DpJYbILT?~9
> zx@Ww_ZY!Phs9}DZ;|(-K7u0?|<x*!^Q((Pp0U@L0j5%*kym>tedsc3u1!ajplM14D
> z?)FvVYF1EAD}VwEmh!>y)l!<B_<wT8$jHNU{OnXe*r~#qv;d5N2DZJiLI6N8ou4Vd
> g!6FL)+!7BD4?iLFVyT<d=3D5|Q;_y0ElgRR})0MlW=3DWB>pF
>
> literal 0
> HcmV?d00001
>
> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> index 39aa1035e34..f647e2f0af2 100644
> --- a/test/py/tests/test_ut.py
> +++ b/test/py/tests/test_ut.py
> @@ -28,21 +28,22 @@ def mkdir_cond(dirname):
>       if not os.path.exists(dirname):
>           os.mkdir(dirname)
>
> -def setup_image(cons, mmc_dev, part_type, second_part=3DFalse):
> +def setup_image(cons, devnum, part_type, second_part=3DFalse, basename=
=3D'mmc'):
>       """Create a 20MB disk image with a single partition
>
>       Args:
>           cons (ConsoleBase): Console to use
> -        mmc_dev (int): MMC device number to use, e.g. 1
> +        devnum (int): Device number to use, e.g. 1
>           part_type (int): Partition type, e.g. 0xc for FAT32
>           second_part (bool): True to contain a small second partition
> +        basename (str): Base name to use in the filename, e.g. 'mmc'
>
>       Returns:
>           tuple:
>               str: Filename of MMC image
>               str: Directory name of 'mnt' directory
>       """
> -    fname =3D os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
> +    fname =3D os.path.join(cons.config.source_dir, f'{basename}{devnum}=
.img')
>       mnt =3D os.path.join(cons.config.persistent_data_dir, 'mnt')
>       mkdir_cond(mnt)
>
> @@ -78,16 +79,17 @@ def mount_image(cons, fname, mnt, fstype):
>       u_boot_utils.run_and_log(cons, f'sudo chown {getpass.getuser()} {m=
nt}')
>       return loop
>
> -def copy_prepared_image(cons, mmc_dev, fname):
> +def copy_prepared_image(cons, devnum, fname, basename=3D'mmc'):
>       """Use a prepared image since we cannot create one
>
>       Args:
>           cons (ConsoleBase): Console touse
> -        mmc_dev (int): MMC device number
> +        devnum (int): device number
>           fname (str): Filename of MMC image
> +        basename (str): Base name to use in the filename, e.g. 'mmc'
>       """
>       infname =3D os.path.join(cons.config.source_dir,
> -                           f'test/py/tests/bootstd/mmc{mmc_dev}.img.xz'=
)
> +                           f'test/py/tests/bootstd/{basename}{devnum}.i=
mg.xz')
>       u_boot_utils.run_and_log(cons, ['sh', '-c', f'xz -dc {infname} >{f=
name}'])
>
>   def setup_bootmenu_image(cons):
> @@ -549,6 +551,43 @@ def test_ut_dm_init(u_boot_console):
>       with open(fn, 'wb') as fh:
>           fh.write(data)
>
> +
> +def setup_efi_image(cons):
> +    """Create a 20MB disk image with an EFI app on it"""
> +    devnum =3D 1
> +    basename =3D 'flash'
> +    fname, mnt =3D setup_image(cons, devnum, 0xc, second_part=3DTrue,
> +                             basename=3Dbasename)
> +
> +    loop =3D None
> +    mounted =3D False
> +    complete =3D False
> +    try:
> +        loop =3D mount_image(cons, fname, mnt, 'ext4')
> +        mounted =3D True
> +        efi_dir =3D os.path.join(mnt, 'EFI')
> +        mkdir_cond(efi_dir)
> +        bootdir =3D os.path.join(efi_dir, 'BOOT')
> +        mkdir_cond(bootdir)
> +        efi_src =3D os.path.join(cons.config.build_dir,
> +                               f'lib/efi_loader/testapp.efi')
> +        efi_dst =3D os.path.join(bootdir, 'BOOTSBOX.EFI')
> +        with open(efi_src, 'rb') as inf:
> +            with open(efi_dst, 'wb') as outf:
> +                outf.write(inf.read())
> +    except ValueError as exc:
> +        print(f'Falled to create image, failing back to prepared copy: =
{exc}')
> +
> +    finally:
> +        if mounted:
> +            u_boot_utils.run_and_log(cons, 'sudo umount --lazy %s' % mn=
t)
> +        if loop:
> +            u_boot_utils.run_and_log(cons, 'sudo losetup -d %s' % loop)
> +
> +    if not complete:
> +        copy_prepared_image(cons, devnum, fname, basename)
> +
> +
>   @pytest.mark.buildconfigspec('cmd_bootflow')
>   @pytest.mark.buildconfigspec('sandbox')
>   def test_ut_dm_init_bootstd(u_boot_console):
> @@ -559,6 +598,7 @@ def test_ut_dm_init_bootstd(u_boot_console):
>       setup_cedit_file(u_boot_console)
>       setup_cros_image(u_boot_console)
>       setup_android_image(u_boot_console)
> +    setup_efi_image(u_boot_console)
>
>       # Restart so that the new mmc1.img is picked up
>       u_boot_console.restart_uboot()

