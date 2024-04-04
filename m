Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D496CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 14:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A8A087F48;
	Thu,  4 Apr 2024 16:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lm5155Tw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C53587F6E; Thu,  4 Apr 2024 16:27:06 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2565A87F0E
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 16:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d47a92cfefso13453841fa.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 07:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712240823; x=1712845623; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=63wLIpzgR+xPCrD1szeqW++wlm1lMUZ2Mfu9qRa0FYE=;
 b=lm5155TwomhkqXsijfnC9W0raRZTG0YhGT3iwApoCsLDjiFBM8I/amjaGBu6qk/T+R
 IOp2Qv+iw+abdF5UlmRsFke71SNZUwGGFXz6MgTXWfQxUTZNaXOvBFaJssjGarJv4wsK
 uBCKUrItqfWzoG6TIU0S2uXdMuGScnOjmHxrAARSHDcockfe3hwMKsm3FlsD7r97yKvp
 eOt4EIRcZt4SBfFd28oiwokw2yaTaRuyvavLQxleaQhBy6IPfQ/qZ5cIPDfN577TKrJ6
 A+u27Zifw1ELQKFIhwKG3IS9SbbSzCQqvMm8VLZRy5K1uA+d5+wHrlojdhaEUXV8WXys
 tglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712240823; x=1712845623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=63wLIpzgR+xPCrD1szeqW++wlm1lMUZ2Mfu9qRa0FYE=;
 b=mxfdIGy05UhYrKzQ7gZve5wnLaN5rnz1WhMshUVWYytcX8Ao/BekF4JQ3oWCArjaBF
 eOJHroIyY8bpH0bSC3J/WrC1kiWd/5eV9/TxkCrRfRRqHflZBEzwotq1yenlZR9KI1s3
 W4ooBe+sE+PoHHk39jMRc6XVd61f27l9zrYoI2tfAVK12PzACJSjh0OdrJDWleOnvByn
 mNK5hoB+c4iCNAol01zfJtZ5lEVxkTtfbVleVLEXe5PKNx0ZyiZkkqRsWZ08HQiZtZUm
 BWQuqWyOcn5KyITuLn0qH0IahqCepuFbAAzlXwjs3a2OqkDgrf2geLHU1oRaKnUCkwkp
 C+jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMVe5yrXeX4aRTW1uzVDCEwmSqbCpKHAeV8gbOjlreGxATggOyH1CQ2D+4Kn/arSjeNrutUzkrOh0mOB2aN3sXx7Pfpg==
X-Gm-Message-State: AOJu0Yxdn+k3uLBs1LGciqk7U8qegdFqK1b2yTYlkrw/pyCyG3NaWtfP
 +4IVxT8dTbYuAP/fyS5F5d/VMlcME8ExNq0P/inLvrCcQweku/uc/f1g2AyUHO3juupx9GNFvDS
 4W/QF8qsDvi3y1vohtWHcfx9qEDsDuhYzCo5hWw==
X-Google-Smtp-Source: AGHT+IHbaOeQn7xs4VOudMVd40C7qKzSkIMpPcFzHIopHvfjWvEquMiCWwfIOy863tre6EIPdvn0nmkydFrG1LsOz34=
X-Received: by 2002:a2e:9495:0:b0:2d8:97f:451e with SMTP id
 c21-20020a2e9495000000b002d8097f451emr1958463ljh.37.1712240823250; Thu, 04
 Apr 2024 07:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
 <20240404114742.81187-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240404114742.81187-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Apr 2024 17:26:26 +0300
Message-ID: <CAC_iWjLEN-KhLhAzjW__93W8f9Gjnm48eiYucDsTAEvgjayLMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] boot: correct the default sequence of boot methods
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, 
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng@tinylab.org>, 
 Shantur Rathore <i@shantur.com>, Mark Kettenis <kettenis@openbsd.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 E Shattow <lucent@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 4 Apr 2024 at 14:49, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The default sequence of boot methods is determined by alphabetical sorting
> during linkage.
>
> * efi_mgr must run before efi to be UEFI compliant
> * pxe should run as last resort
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  boot/bootmeth_efi.c     | 2 +-
>  boot/bootmeth_efi_mgr.c | 2 +-
>  boot/bootmeth_pxe.c     | 2 +-
>  test/boot/bootflow.c    | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index c4eb331d69e..a46b6c9c805 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -489,7 +489,7 @@ static const struct udevice_id distro_efi_bootmeth_ids[] = {
>         { }
>  };
>
> -U_BOOT_DRIVER(bootmeth_efi) = {
> +U_BOOT_DRIVER(bootmeth_4efi) = {
>         .name           = "bootmeth_efi",
>         .id             = UCLASS_BOOTMETH,
>         .of_match       = distro_efi_bootmeth_ids,
> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> index ed29d7ef021..b7d429f2c3d 100644
> --- a/boot/bootmeth_efi_mgr.c
> +++ b/boot/bootmeth_efi_mgr.c
> @@ -114,7 +114,7 @@ static const struct udevice_id efi_mgr_bootmeth_ids[] = {
>         { }
>  };
>
> -U_BOOT_DRIVER(bootmeth_efi_mgr) = {
> +U_BOOT_DRIVER(bootmeth_3efi_mgr) = {
>         .name           = "bootmeth_efi_mgr",
>         .id             = UCLASS_BOOTMETH,
>         .of_match       = efi_mgr_bootmeth_ids,
> diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
> index 8d489a11aa4..70f693aa239 100644
> --- a/boot/bootmeth_pxe.c
> +++ b/boot/bootmeth_pxe.c
> @@ -184,7 +184,7 @@ static const struct udevice_id extlinux_bootmeth_pxe_ids[] = {
>         { }
>  };
>
> -U_BOOT_DRIVER(bootmeth_pxe) = {
> +U_BOOT_DRIVER(bootmeth_zpxe) = {
>         .name           = "bootmeth_pxe",
>         .id             = UCLASS_BOOTMETH,
>         .of_match       = extlinux_bootmeth_pxe_ids,
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 4845b7121c8..e60e9309fa9 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -377,7 +377,7 @@ static int bootflow_system(struct unit_test_state *uts)
>         if (!IS_ENABLED(CONFIG_EFI_BOOTMGR))
>                 return -EAGAIN;
>         ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
> -       ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_efi_mgr),
> +       ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_3efi_mgr),
>                                 "efi_mgr", 0, ofnode_null(), &dev));
>         ut_assertok(device_probe(dev));
>         sandbox_set_fake_efi_mgr_dev(dev, true);
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
