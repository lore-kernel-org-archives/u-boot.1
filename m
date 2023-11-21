Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502ABC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B813C875C9;
	Tue, 21 Nov 2023 18:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NOtnCrH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF78C87545; Tue, 21 Nov 2023 18:32:05 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 940F387250
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700587922; x=1701192722; i=xypron.glpk@gmx.de;
 bh=YKdKPGf2NITUbkhUdUHu3XJaWzuqr9LRh5BDrb3hyE4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=NOtnCrH8VOAffWeBXFe7KLneR1r8gYzGlg86sy9VUnjBNwEHAPBZ9oz21bEz38Cx
 aCOdXaJlcQyBDeMLUKHXyfvY1aOJtVzr1owSVvWUhKOFlvBFOVLHmGSokqAmegyia
 31lhRYZyGWUtA+VDc4DCPaUt3OEnAumpdiPH0eQUVdn97gSzVJsT0wkRcQvrykcCu
 w395w4ZKDvq5J6uJL5odZ9Fc2relm5tUj76glnbpe1g1k4Jae1r8Zm1uvGHHujV0X
 UnsKBrgedE2vFabUgDeyco6i8G93B/n1nOww0GjdqIRq52Z6O7iSR5MuRsX3DSu6C
 qLA88xFSvs6Kd2Vuzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ7v-1qrO0C42In-00WBIW; Tue, 21
 Nov 2023 18:32:02 +0100
Message-ID: <539b4abc-be46-45c5-98d0-71f2b289540c@gmx.de>
Date: Tue, 21 Nov 2023 18:32:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] efi: test: Create a disk image with and EFI app in it
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231121113557.800353-1-sjg@chromium.org>
 <20231121113557.800353-4-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231121113557.800353-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x5T93VPLjBjg8RNWLetMSpQEHaqXnUiKUUwEd7TkzhflmMPStau
 knvEVebzQYhL4G+djlKWID/0xYKbebu4ZAB+3LKgcJjSFF5zWblU2+nL0QFBVC21KFxeLGE
 ZSjGMnYTC/R2R+HU5jwH6KXWaUcRXOY06NBtn1x2CA7ClcaPWUkqSYoIomQMcxas64yok8r
 EohxeBIzKrPIVefNKSgiQ==
UI-OutboundReport: notjunk:1;M01:P0:rmtA0EGsJNo=;bGJAs4zg+fGZl6BxfF7CCUohqoc
 QEiob4SEPfhzfyZSN2D3iJvt4qr+ci0qk2U8ODdDTEU/6tUjitgLJDl86dFKVWGt0QNZ4KWZ+
 rE0nOYDedMIe08nHvlX5k4s69J5VnSW7qzCVQtTfnJvxA8xODeGL+HZYPSwy6FJq8QdjfCZoh
 elLDBNaYE2u5pmhk7gqhI0b1W9Gs/50EEHDkcDHGqR1Im1jn2fIqsFlFbt7Ahg/E7X42VwrU1
 YEK9sw0wIC6oDCQAuV0UzL7Rm2hFpwEq1h6q94IN+bDFdJCWkhvFdr4F2Trsu6923KbCvdzpr
 Z7cl6BMxhEsGrAtitvurZBCdaeGkLZPLD+vl/fRd5gMjhdkXPreV1mRJE/ug3PbulQwusOUGa
 l6tpEh9Pfn+ZjIZftGCxGIebXIjbtR0P/hP9ZzfZgU8YUOKRs8Bp1PMUv7gbyTAewaNV7Fg6U
 TR2x60uy2Qefjbmi53sCmyh8CcAz5ju2wA3pVdeQJI2OlaR9JdmLfX7JTUVUFFHL15/JE8tQp
 T65XVTmm/8bXSHlsA/3rzn0pzIassv16EbglqsRSxo6jyjmyuPEJRyLPFtoySltBJOEMUjeDj
 czgu9L3lS/Dlld4in1qavB/nurl3SA+xBXydkbjIngBAy92o4RriDcXmOMZRzqiuV+LycmDfC
 ff21UYAvW3lG/qqIrNl7CSGcMH73OMoqeRT51cuAHpP6nluiMh74K22VoDYL0P/9GLeSaGsUu
 hGtZCW0CKjcOVP0UnvHzqxitEnLOW72J5I1R3zdHlC5dJn9c2qL0NMcZrWaWE+qYpVB0wvlwa
 dQD2PM835gdTes48OZ/0y5t0evFhjO8rhVLk9c+hqBn49AVmhJkb9NPJaImsaxoA+MP/memNF
 AzvgKEbOAAEiK+lE5ji1cOXgpGWhBG8Ej0BGF2gtHaj+cqEQ7ga9icnot8UmbRFb8KaKRh/eA
 7I3xmgltSrmL9u5uIsqHjKJ89Gs=
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

On 11/21/23 12:35, Simon Glass wrote:
> Create a new disk for use with test, which contains the sandbox
> helloworld app. This will be used to test the EFI boot bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   test/py/tests/test_ut.py | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> index 1d9149a3f683..f6220c05238a 100644
> --- a/test/py/tests/test_ut.py
> +++ b/test/py/tests/test_ut.py
> @@ -468,6 +468,37 @@ def test_ut_dm_init(u_boot_console):
>       with open(fn, 'wb') as fh:
>           fh.write(data)
>
> +
> +def setup_efi_image(cons):
> +    """Create a 20MB disk image with an EFI app on it"""
> +    mmc_dev =3D 7
> +    fname, mnt =3D setup_image(cons, mmc_dev, 0xc, second_part=3DTrue)

If you would set the partition type GUID to ESP, U-Boot would stop to
complain about EFI variable that cannot be persisted.

There is a pending patch that wants to make the failure to persist EFI
variable fatal.

[RESEND,v2] efi_loader: Fix UEFI variable error handling
https://patchwork.ozlabs.org/project/uboot/patch/20231113161031.138304-1-o=
451686892@gmail.com/

Best regards

Heinrich

> +
> +    loop =3D None
> +    mounted =3D False
> +    try:
> +        loop =3D mount_image(cons, fname, mnt, 'ext4')
> +        mounted =3D True
> +        efi_dir =3D os.path.join(mnt, 'efi')
> +        mkdir_cond(efi_dir)
> +        bootdir =3D os.path.join(efi_dir, 'boot')
> +        mkdir_cond(bootdir)
> +        efi_src =3D os.path.join(cons.config.build_dir,
> +                               f'lib/efi_loader/helloworld.efi')
> +        efi_dst =3D os.path.join(bootdir, 'bootsbox.efi')
> +        with open(efi_src, 'rb') as inf:
> +            with open(efi_dst, 'wb') as outf:
> +                outf.write(inf.read())
> +
> +    finally:
> +        if mounted:
> +            u_boot_utils.run_and_log(cons, 'sudo umount --lazy %s' % mn=
t)
> +        if loop:
> +            u_boot_utils.run_and_log(cons, 'sudo losetup -d %s' % loop)
> +
> +
> +
> +
>   @pytest.mark.buildconfigspec('cmd_bootflow')
>   def test_ut_dm_init_bootstd(u_boot_console):
>       """Initialise data for bootflow tests"""
> @@ -476,6 +507,7 @@ def test_ut_dm_init_bootstd(u_boot_console):
>       setup_bootmenu_image(u_boot_console)
>       setup_cedit_file(u_boot_console)
>       setup_cros_image(u_boot_console)
> +    setup_efi_image(u_boot_console)
>
>       # Restart so that the new mmc1.img is picked up
>       u_boot_console.restart_uboot()

