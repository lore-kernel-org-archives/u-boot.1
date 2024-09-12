Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DB3EED611
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D837588FEB;
	Thu, 12 Sep 2024 17:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mje+M2s5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA2E88FF7; Thu, 12 Sep 2024 17:07:30 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DDD88FC4
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726153647; x=1726758447; i=xypron.glpk@gmx.de;
 bh=AV5fp/spIB7U3r3l/mGth33dSJbkk/ZLlTInGPfryxk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mje+M2s5Hzg36XQT3VNK8m2J7gX2D4CM1dUWhvplwL+YqSmNvs5mDo50dXVFL4ye
 bbvqKqu4H205fgonX/PKl4RPS/P8vgy9qkHdT1qyMbIG9ac4IiIj+TnvlwRPiKk9l
 R1/+TzMSV4Fu1ST50lF87p0lXGwYMWN+KIY29xgDk8cb0erw/4Tj5nMe7xqscgxC1
 fJlPLibL9jsGzJYOBtxQFjzq5yNo6mMUOSveMfSK8qCthPvVYfKOsHeamnUkVBqCu
 GbrG1HEHgVVdqOXZY5LzQWpuE/Trf6P2qakgmfRNzWbsdCMAHtv4PM5y50dyWSAwz
 4xOwPhmiIxBLIqvEng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWih0-1sV5te3Y08-00MKUk; Thu, 12
 Sep 2024 17:07:26 +0200
Message-ID: <18f3b613-5191-4bfb-b6d1-f10d9c790853@gmx.de>
Date: Thu, 12 Sep 2024 17:07:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/14] test: efi: boot: Add a test for the efi bootmeth
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-15-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240902011825.746421-15-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sbTs4oBWB720zrIRaZ2wPUn0vczRHwjSYaj0q5LiR1WOSV3KEBH
 jeU48WPRubEAPiExaAto1NeUL0vVc5t5B7QSLS6c3htxOLVMiTmTHqLWwa5KUouRUs4oHZ9
 fCEZdz/mcL3fb92lzASU9zUuf/gkGJOWeBaMZVqAdRUbpwPIr93oyNf+Y0JAnnDbCD3e0IV
 gj3wzwoIK4yvcKnfdlvOA==
UI-OutboundReport: notjunk:1;M01:P0:W+fTmxZsCtw=;ONY+Js9T34UBWBFUeIUaXWEzxFY
 TKmqcmxn4w3t7XisFYuevzaknUzmBYDeXfkidhYMcpDsvKApgvx/GRpZkxrfyLt1P8Q5P4vio
 eZ7mhjz19eQn5zBS0IC4jdlvh5nNsu75ZpvHNZVMpFyjBAn34ph9eva2VO4n6PRhZbA3x7ta6
 ThaIB59o9latLB2kJmUx+aUJ7YGW7e2LcBiJATmTJu2ilFyu+3BdIKmBnK3rvzQVdex9aQJLZ
 5sUDvhKtan19BPu4mqLOudZcc3hP83f0G5tiGzbApa9a9BInZr3ypyd9pZ5PX2YqkLdKQvRBA
 IU/adSm8XROh5T8s5NLBRask7tRWMIbxaLuli+q39F5MV7FysguB8h0woqGVgheulZ6Cmo2VW
 iwg0w8TdNLM5j+EoVXt3ny8L8Hl0zFWta0BlDJO09m5Fkt5ZYcdefa3sHv1AFYxWPmfNVLO3F
 RKFdBjloCtgN60jlRfukv/5rWItg/SbPo7WSR76LKHQOBkJAA8E+GA38BiQiweBALcNMCMoyj
 9YWwU1ZZxw+zYBequiZ8l2+/xLvbZKhqKvyMwh1RSdaL2uE+I6uLH5EVYFrUVxR53MYpfoF1B
 Q9fk0RP2kvc4bkttNZxpV0wCUsVZ7QuXcS0YIggkKO4FlZepmULcj7J0k72Rj/u/oZr//0L1b
 55kx8ZZYZcuxq5xYleGJMlYcgH1mdbZpP4oxk4W+ZljT+fOdJtZrm0svhSEtVZBNcRFYt08n/
 vU7PZpmoVk7iacnildnAf66loQAMr/+SSxP9iO/vg5muxLXB2Tb35VnGajLvgRZirEJg/eTa8
 XyoNgpeEMm7A3s8lYSvyuMxw==
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

On 02.09.24 03:18, Simon Glass wrote:
> Add a simple test of booting with the EFI bootmeth, which runs the app
> and checks that it can call 'exit boot-services' (to check that all the
> device-removal code doesn't break anything) and then exit back to
> U-Boot.
>
> This uses a disk image containing the testapp, ready for execution by
> sandbox when needed.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
>
> ---
>
> Changes in v5:
> - Rebase on updated efif series
> - Deal with sandbox CONFIG_LOGF_FUNC
>
> Changes in v4:
> - Add efi_loader tag to some patches
> - Split out non-EFI patches into a different series
>
> Changes in v2:
> - Add many new patches to resolve all the outstanding test issues
>
>   test/boot/bootflow.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 64 insertions(+)
>
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 37884dbd441..d8da3aac493 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -13,6 +13,7 @@
>   #include <cli.h>
>   #include <dm.h>
>   #include <efi_default_filename.h>
> +#include <efi_loader.h>
>   #include <expo.h>
>   #ifdef CONFIG_SANDBOX
>   #include <asm/test.h>
> @@ -31,6 +32,9 @@ extern U_BOOT_DRIVER(bootmeth_android);
>   extern U_BOOT_DRIVER(bootmeth_cros);
>   extern U_BOOT_DRIVER(bootmeth_2script);
>
> +/* Use this as the vendor for EFI to tell the app to exit boot services=
 */
> +static u16 __efi_runtime_data test_vendor[] =3D u"U-Boot testing";
> +
>   static int inject_response(struct unit_test_state *uts)
>   {
>   	/*
> @@ -1205,3 +1209,63 @@ static int bootflow_android(struct unit_test_stat=
e *uts)
>   	return 0;
>   }
>   BOOTSTD_TEST(bootflow_android, UTF_CONSOLE);
> +
> +/* Test EFI bootmeth */
> +static int bootflow_efi(struct unit_test_state *uts)
> +{
> +	/* disable ethernet since the hunter will run dhcp */
> +	test_set_eth_enable(false);
> +
> +	/* make USB scan without delays */
> +	test_set_skip_delays(true);
> +
> +	bootstd_reset_usb();
> +
> +	/* Avoid outputting ANSI characters which mess with our asserts */
> +	efi_console_set_ansi(false);
> +
> +	ut_assertok(bootstd_test_drop_bootdev_order(uts));
> +	ut_assertok(run_command("bootflow scan", 0));
> +	ut_assert_skip_to_line(
> +		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found")=
;
> +
> +	ut_assertok(run_command("bootflow list", 0));
> +
> +	ut_assert_nextlinen("Showing all");
> +	ut_assert_nextlinen("Seq");
> +	ut_assert_nextlinen("---");
> +	ut_assert_nextlinen("  0  extlinux");
> +	ut_assert_nextlinen(
> +		"  1  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo =
/EFI/BOOT/BOOTSBOX.EFI");
> +	ut_assert_nextlinen("---");
> +	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
> +	ut_assert_console_end();
> +
> +	ut_assertok(run_command("bootflow select 1", 0));
> +	ut_assert_console_end();
> +
> +	/* signal to helloworld to exit boot services */


What 'helloworld' are you relating to?

Best regards

Heinrich

> +	systab.fw_vendor =3D test_vendor;
> +
> +	ut_asserteq(1, run_command("bootflow boot", 0));
> +	ut_assert_nextline(
> +		"** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi"=
);
> +	if (IS_ENABLED(CONFIG_LOGF_FUNC))
> +		ut_assert_skip_to_line("       efi_run_image() Booting /\\EFI\\BOOT\\=
BOOTSBOX.EFI");
> +	else
> +		ut_assert_skip_to_line("Booting /\\EFI\\BOOT\\BOOTSBOX.EFI");
> +
> +	/* TODO: Why the \r ? */
> +	ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
> +	ut_assert_nextline("Exiting boot sevices");
> +	if (IS_ENABLED(CONFIG_LOGF_FUNC))
> +		ut_assert_nextline("     do_bootefi_exec() ## Application failed, r =
=3D 5");
> +	else
> +		ut_assert_nextline("## Application failed, r =3D 5");
> +	ut_assert_nextline("Boot failed (err=3D-22)");
> +
> +	ut_assert_console_end();
> +
> +	return 0;
> +}
> +BOOTSTD_TEST(bootflow_efi, UTF_CONSOLE);

