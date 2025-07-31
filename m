Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C7FC87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 19:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C316183938;
	Thu, 31 Jul 2025 21:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aB75rlRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 310AC83937; Thu, 31 Jul 2025 21:19:26 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE4EF8349B
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 21:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-55502821bd2so818780e87.2
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 12:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753989563; x=1754594363; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sohLY0bE39ZQRDQr3jsj7/gTjPOyucnm1O1hSVcLZ3o=;
 b=aB75rlRfZrukjnkwiC2kdajwI95HKR8Bh03XvDRdY4m4tJGEKxmVbyXOhCqFzcHgUg
 fuFJ19ZhfvWpM/OSGaRPJNV+SbM37rCiNHbb+wF68nsPtauOJFCVLi2Zwhms8vDhQ5Ve
 b8KN/1qZrH47/e+/cL1YqFZWqs77CwXqb2GCxvgnKZjhZykmFwZh/uM5nqM85QazVaOx
 +/atWDhi9IL6NzBAYLVwW5J7VA7Rn7ycmkRZUdKG7qygEfhd0SGzXOe1lS/ilZxFqtoY
 5YN2yKfYEMjwVglBBdq9tHQKhT++i8ztS74cASQhdWYrMjZrjzK/zkX9nSWwdY331ieI
 xpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753989563; x=1754594363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sohLY0bE39ZQRDQr3jsj7/gTjPOyucnm1O1hSVcLZ3o=;
 b=bKVguDe1BpneobLqy4awmuZqnNhajyxRNzC/CbNekm3Rsk4EwKrufX5IZtz7SQt1Ag
 NqIkKLiPmG5N5QYj6h11U054vm33muRbEG30AdeyaK2HGRdh7vzFM2jBGnOremZtCyV6
 oLHV3AanEXlWU0O8fkRstOYXqzxU2aZRlf3WJHwA7hga1jGpndcELd5HL8yN44pEZs4Z
 ByjDO0TUn+9CegrlhSM+iX7xctxNdtgbB9tf/NUIQZccWkjkYEQOzMdpYT3LqUwkkyp7
 toxHkzdC4iIUL8FRqqSkn1FbYKC8MfPLU8O7FQ9/HnnwsjEfg3duSOTh0oki95MahkFh
 9VSg==
X-Gm-Message-State: AOJu0YyXXH+1ozUo2ThcURBbTFbQwV4KkokIBg5854IzzBlP4EuJ2Fu5
 IitMoz8vaWzDUS6M4covAVXTXd419N5yfGwGK4cg6cAvS08FecQb3QJ+ML/Ab+lx21Pqk+MqHnG
 IIxwgZLBaJL/C6FUUQQCD93QqkJgnW6w=
X-Gm-Gg: ASbGncu3uGU14wtMfgevq+fQmrGh1MctCcDBDbOIonbH0dWODlRPqOZg9PrzYcZuvu8
 KkXRrtbUYnSQI97eDwNNoMrLKrzg5AscNwU8Z0ua3V7of5X3rc4bjP6Tcps/X+rGWcnk2b48qRA
 BkjCoghh6wqrSBFoUUO7Q2qFpLPaZX2j2B9dKzZXhFpRUokyQGgiRddOPvQrGVHfe9YSarti0hX
 OZuOirduPAmQwbhFKk1VwDK7JQoZWmPwXyFwQc=
X-Google-Smtp-Source: AGHT+IHfjEHcWm54mwg5Hc8lwXiqQVPV/a/pLqdK9kfrE/ftpyQj+IDt/xO1lKtJy/t4F/S/fA4pJyH+jnV9ywM3Qg4=
X-Received: by 2002:a05:6512:3ca4:b0:553:abe9:c321 with SMTP id
 2adb3069b0e04-55b7c08ebdbmr3013018e87.44.1753989562633; Thu, 31 Jul 2025
 12:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250731115248.264837-1-mikko.rapeli@linaro.org>
In-Reply-To: <20250731115248.264837-1-mikko.rapeli@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 31 Jul 2025 16:19:10 -0300
X-Gm-Features: Ac12FXw-pp-X4i-VUZNsoAn_j18BhQzEDbHrTjAIbunHHy_XOM5_yWPkn-wCuQo
Message-ID: <CAOMZO5AR5MTzC_86TyOJ=a1NUfU1oyt1a+hjXhvJZkP0F6H_8g@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile: add dependency from lib to arch/$(ARCH)/lib
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Mikko,

On Thu, Jul 31, 2025 at 8:53=E2=80=AFAM Mikko Rapeli <mikko.rapeli@linaro.o=
rg> wrote:
>
> Top level Makefile starts separate "make" processes for each each
> subdirectory. lib/efi_loader apps now depend on lib.a from
> arch/$(ARCH)/lib if CONFIG_USE_PRIVATE_LIBGCC is enabled which creates
> a race conditions since dependency from lib/efi_loader EFI apps to
> arch/$(ARCH)/lib/lib.a is not explicit:
>
> arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such fi=
le or directory
> make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/testapp_efi.so] Er=
ror 1
>
> This error was seen on yocto/OE-core CI builds after u-boot 2025.07 updat=
e:
>
> https://lists.openembedded.org/g/openembedded-core/message/220004
>
> https://autobuilder.yoctoproject.org/valkyrie/api/v2/logs/2914600/raw_inl=
ine
>
>     |    rm -f lib/efi_loader/built-in.o; arm-poky-linux-gnueabi-ar cDPrs=
T lib/efi_loader/built-in.o lib/efi_loader/efi_bootmgr.o lib/efi_loader/efi=
_bootbin.o lib/efi_loader
> /efi_boottime.o lib/efi_loader/efi_helper.o lib/efi_loader/efi_console.o =
lib/efi_loader/efi_device_path.o lib/efi_loader/efi_device_path_to_text.o l=
ib/efi_loader/efi_device_
> path_utilities.o lib/efi_loader/efi_dt_fixup.o lib/efi_loader/efi_fdt.o l=
ib/efi_loader/efi_file.o lib/efi_loader/efi_hii.o lib/efi_loader/efi_hii_co=
nfig.o lib/efi_loader/efi
> _image_loader.o lib/efi_loader/efi_load_options.o lib/efi_loader/efi_memo=
ry.o lib/efi_loader/efi_root_node.o lib/efi_loader/efi_runtime.o lib/efi_lo=
ader/efi_setup.o lib/efi_
> loader/efi_string.o lib/efi_loader/efi_unicode_collation.o lib/efi_loader=
/efi_var_common.o lib/efi_loader/efi_var_mem.o lib/efi_loader/efi_variable.=
o lib/efi_loader/efi_var_
> file.o lib/efi_loader/efi_watchdog.o lib/efi_loader/efi_disk.o lib/efi_lo=
ader/efi_net.o lib/efi_loader/efi_smbios.o lib/efi_loader/efi_load_initrd.o=
 lib/efi_loader/efi_confo
> rmance.o
>     |   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc=
 -znorelro --no-warn-rwx-segments -L /srv/pokybuild/yocto-worker/oe-selftes=
t-armhost/build/build-st-
> 3119200/tmp/work/beaglebone_yocto-poky-linux-gnueabi/u-boot/2025.07/sourc=
es/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -shared -Bsymbolic -s lib=
/efi_loader/helloworld.o
> lib/efi_loader/efi_crt0.o lib/efi_loader/efi_reloc.o lib/efi_loader/efi_f=
reestanding.o arch/arm/lib/lib.a -o lib/efi_loader/helloworld_efi.so
>     | arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No s=
uch file or directory
>     | make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_e=
fi.so] Error 1
>
> The different "make" processes share common scripts/Makefile.build
> and scripts/Makefile.libs but since they are separate processes
> the Makefile rules can't add a dependency from lib/uefi_loader targets
> to arch/$(ARCH)/lib/lib.a. Or the file level dependency can be added but
> then "make" produces a too sparse error message which does not mention
> that one of the dependencies like arch/$(ARCH)/lib/lib.a was not found:
>
> make[3]: *** No rule to make target 'lib/efi_loader/helloworld.efi', need=
ed by '__build'.  Stop.
>
> Fix this dependency problem by building arch/$(ARCH)/lib before lib
> if CONFIG_USE_PRIVATE_LIBGCC was enabled.
>
> To reproduce the race condition more reliably, add a "sleep 10" delay
> before linker command cmd_link_l_target with 2025.07
> or to $(lib-target): target in scripts/Makefile.build with master branch
> after Kbuild update.
>
> Fixes: 43d43241d1c9 ("scripts/Makefile.lib: add PLATFORM_LIBGCC to efi li=
nking")
>
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>

Thanks for the fix:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
