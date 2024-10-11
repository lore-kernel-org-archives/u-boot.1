Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B41D0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 22:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62AC893BA;
	Sat, 12 Oct 2024 00:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JEQ2gPka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F6489402; Sat, 12 Oct 2024 00:32:35 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D97A488E74
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 00:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a9c3a4e809so189870785a.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 15:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728685952; x=1729290752; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BToncNPr8EW0DhvxJIp+f0LyfPT90zm+RurpEJ/XIB8=;
 b=JEQ2gPkae7MNv2oCrc8XaXgYYwiKVjePbSSi+lq1qn3SKKIVSdgwiuvq/PiBDKuyDy
 xKnE/wtRwLxiNUy1CxL25NrDF0j+Wm8FKuJhp5TWnYPcj8Jm43SkNXG0qFuYkSJ01jDB
 XtP6uwd6x/3m6+4OJonX70t58VLXhljHQd33Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728685952; x=1729290752;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BToncNPr8EW0DhvxJIp+f0LyfPT90zm+RurpEJ/XIB8=;
 b=OthHuScxALoV3ybViDvij+DloN7Ha7JD16b/b6ajZ9UqvK5/Y3s5Lv2C1kLvEF0CBE
 C1b6GPE6i9am20oVTs4wuzaqme4lVGlMwTXg0Scosfu0bUtvkZ+LpNdFqa1GgEs3vd/T
 WGy2WrsUWh2yx1zEpAfqFcgtf5ZF/5lkxm3w817QyVrhWUlEzY8pOgANo6M0wxEeXCXp
 nil2B8eejTdwZLSoHcnVGaEL2FZjHrQ+YhsCFWaBpeDU68ON/XVwDo4UKnM/WCQUfoxu
 0JFT55afNJ+V78s0KYtWRbgWaMWktglqeDO40fVFQw+mJ0wW1k+korMW+0/ODvHUbsr8
 LrXA==
X-Gm-Message-State: AOJu0Yzj0KEpUqMsbAqY1CvEF43Zh+DDslTYoiWcEQvbIj1Km63HTPxq
 th7UiscXEIWhz445dieUbLSeAPhsKcjjayJDCZ7A2whcPdqsFtSzHlDvG8m4KME=
X-Google-Smtp-Source: AGHT+IHtrBfzLmjqCL7DpDT2OS7X4O2O4//P5Y+5VaXl1aZW4bVT17BAGyw1GUMHJdeBsq9C1rIZJw==
X-Received: by 2002:a05:620a:178e:b0:7af:e995:7a67 with SMTP id
 af79cd13be357-7b1210342c9mr117026285a.66.1728685951695; 
 Fri, 11 Oct 2024 15:32:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460427897e4sm20126841cf.8.2024.10.11.15.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 15:32:30 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:32:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v6 12/12] test: efi: boot: Add a test for the efi bootmeth
Message-ID: <20241011223227.GA630742@bill-the-cat>
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-13-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eNSxdQ1PqFXy/fqE"
Content-Disposition: inline
In-Reply-To: <20240926220226.1265965-13-sjg@chromium.org>
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


--eNSxdQ1PqFXy/fqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:02:23AM +0200, Simon Glass wrote:

> Add a simple test of booting with the EFI bootmeth, which runs the app
> and checks that it can call 'exit boot-services' (to check that all the
> device-removal code doesn't break anything) and then exit back to
> U-Boot.
>=20
> This uses a disk image containing the testapp, ready for execution by
> sandbox when needed.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

So lets go to the problem point. What asserts here fail due to ANSI
escape codes being in the output and needing to be filtered out?

[snip]
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index e05103188b4..da2ee1ab345 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -13,6 +13,7 @@
>  #include <cli.h>
>  #include <dm.h>
>  #include <efi_default_filename.h>
> +#include <efi_loader.h>
>  #include <expo.h>
>  #ifdef CONFIG_SANDBOX
>  #include <asm/test.h>
> @@ -31,6 +32,9 @@ extern U_BOOT_DRIVER(bootmeth_android);
>  extern U_BOOT_DRIVER(bootmeth_cros);
>  extern U_BOOT_DRIVER(bootmeth_2script);
> =20
> +/* Use this as the vendor for EFI to tell the app to exit boot services =
*/
> +static u16 __efi_runtime_data test_vendor[] =3D u"U-Boot testing";
> +
>  static int inject_response(struct unit_test_state *uts)
>  {
>  	/*
> @@ -1205,3 +1209,62 @@ static int bootflow_android(struct unit_test_state=
 *uts)
>  	return 0;
>  }
>  BOOTSTD_TEST(bootflow_android, UTF_CONSOLE);
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
> +		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
> +
> +	ut_assertok(run_command("bootflow list", 0));
> +
> +	ut_assert_nextlinen("Showing all");
> +	ut_assert_nextlinen("Seq");
> +	ut_assert_nextlinen("---");
> +	ut_assert_nextlinen("  0  extlinux");
> +	ut_assert_nextlinen(
> +		"  1  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo /=
EFI/BOOT/BOOTSBOX.EFI");
> +	ut_assert_nextlinen("---");
> +	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
> +	ut_assert_console_end();
> +
> +	ut_assertok(run_command("bootflow select 1", 0));
> +	ut_assert_console_end();
> +
> +	systab.fw_vendor =3D test_vendor;
> +
> +	ut_asserteq(1, run_command("bootflow boot", 0));
> +	ut_assert_nextline(
> +		"** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi");
> +	if (IS_ENABLED(CONFIG_LOGF_FUNC))
> +		ut_assert_skip_to_line("       efi_run_image() Booting /\\EFI\\BOOT\\B=
OOTSBOX.EFI");
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

--=20
Tom

--eNSxdQ1PqFXy/fqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJp3sACgkQFHw5/5Y0
tyzILAv9Ht7nL0M5wmLQ1fxvWHET/fd5HQaA+w5xefvIiLyx/uLXFMJx4XYI3UfL
DZQz4qWg7c4Qn29y4ltkr69Ock35DFH/aXaTQlmH6dZZAyUV8/LyVN14byCTF0rK
/oNLiB92J89wr56X3edGpS0Zau6I5f6eZRt4I80TW+MWuUNaQKN38epWK1ULTtgb
WjJEujBsyq+nEWPKyxj+KD1bZsCoSMvFlsRiFe/EBbAiFtoK5YdV/wrvY2bQAKYY
1MF7JPCYnhfANqJlJyL39ZAgrhBuY+kqjHUZbBxxWLfF/A128nrqjHWqPk/7URwZ
VF4RTmAlXkM0dGuPuKWRFF0qTBJWbzhDxe+IDEJH4/2hxJfm6A4SC3CgKw63cbQE
iLJa3riGWVNIQsPLMmzi8nyYsjUdPFPFTcpiHbp5hTruN9yeGsPF7n7fMwjhluan
G0QGVdrHUfl/qF+crQlBDLCuYBfb1fJIIs7dTe11ZE74JuediQQ+aWT6D+IdQOWN
a/0mKuPm
=WbES
-----END PGP SIGNATURE-----

--eNSxdQ1PqFXy/fqE--
