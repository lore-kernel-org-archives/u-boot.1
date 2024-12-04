Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8B0E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 12:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BAB3896E6;
	Wed,  4 Dec 2024 13:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lx4djYJw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236F5893C8; Wed,  4 Dec 2024 13:38:17 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52AAF893DB
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 13:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6ef7f8d4f30so42325617b3.1
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 04:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733315892; x=1733920692; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TGbOP2Wfiumbfny48XHEFJyvmnVv/dI3wLUKx4eT1c=;
 b=Lx4djYJw/aDDZPNayx5woqLDGVW2JTIRAMcRfANP8uLqWG1gk9YsTqxnSXsUyaGyAL
 6+dBVvT/P29pzIA6kzSBdEYmlinXcrfhKbn8U/qa8I3cuWoVap7kcl5lqS84RkUccpup
 eVEFMdRZxRKlJCfkBoC4BbMCCmukXI3FeWK9JkS2hiKJFn1ZQ5Br3DISKybVgEFABDYt
 tZwovbjK0GpUHBYNZcFKsfmvb3QJhhzrB3slbdZmHI6Q1O3LU/GpxaIuALsss6gtsXoM
 qL7gzcJkBV/UEKxmJeFVTpHTadjM01fm3rZvbbI0vjwlZyGA/rhX9EwTZT+Va2aTDJBS
 /wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733315892; x=1733920692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1TGbOP2Wfiumbfny48XHEFJyvmnVv/dI3wLUKx4eT1c=;
 b=L/fta0//T/VlofSKCLd8Y526TO2wMuuen1WOzOqZ1wPv09BqKD3VO3t9v7B950O5Oz
 qxzZYXsJmwMpv00mHdKR70Rgq2uc3fjgLHK+mZ+Y25O0q3C1tZnv6nYHp/NR2ZTRP8X4
 cerWAEPXtQ3T6ibsZdyCxiSbmkMwqXSjEjGMgyucZMkLEPnFb6YtU2zkVCK01Wzb4wiO
 tmdUAlOpkI4w8eVd3jrtc/m0pUpc0wHnrOjXW7Qtdk2j1j7k09phykptvLn3Ja/0kGty
 b72cbSeI5xBwGkozSVHYTmHboK+j9OqdcIEOgCYRU00Uvj+SPDVhnSFpyvsSkf4B6uX6
 k4Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUHQkilnW3xoqEvIymgOYzJrXQbR7tolPiHVunkvWZ/WMCyywF+iE0yBBuVW1hS+UCmlllcRE=@lists.denx.de
X-Gm-Message-State: AOJu0YwlpDwSFf1gRwhLvWfvF/WzDUMwppDoWxzEPBUJ3wgdDR5+cF5c
 dr4iB21tXy1bs1ws0neZkNYbBJx3Uaox2UFWs0Timf6q6kL6N1FQCwlaiQA8824Ot3THqQvJ6cH
 uNu9AjIiHo4nWidwihDzMHV9q33AEtKjzXdSrzQ==
X-Gm-Gg: ASbGncuZujURJexx33qypGd9/wS8dK7SzQu/QgjT3kvROXfqNzHnUOGN1ly+21oLDRY
 maKmuZrKi2nq/jjoaQ8QuONaguxhfSRI=
X-Google-Smtp-Source: AGHT+IHCufD5W/g/7oX9+BAlKuuh7PJd/6C68+MSVxsCy9OrKQPz8zf64nHAdOq6eCcLODSPpA5TshF3cLVwTW4ZgRY=
X-Received: by 2002:a05:690c:2f83:b0:6ef:c24e:5f8 with SMTP id
 00721157ae682-6efc24e077fmr22374917b3.19.1733315892181; Wed, 04 Dec 2024
 04:38:12 -0800 (PST)
MIME-Version: 1.0
References: <8910d434-2d77-425f-aa81-8eb803078aef@gmx.de>
In-Reply-To: <8910d434-2d77-425f-aa81-8eb803078aef@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 4 Dec 2024 14:37:36 +0200
Message-ID: <CAC_iWjLPp+gFOJV2pOG6DTBif0RbRFit6aFR=CCZxaVzD==7Fw@mail.gmail.com>
Subject: Re: [MASTER] Pull-request efi-2025-01-rc4
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Andy Yan <andyshrk@163.com>,
 =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
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

Hi Heinrich,

Thank you for the PR!
Just a reminder that for EFI we want [0] and [1] in -master. I can
carry them via the EFI tree or the TPM tree once they are reviewed.
Just let me know!

[0] https://lore.kernel.org/u-boot/20241202144246.877105-1-ilias.apalodimas=
@linaro.org/
[1] https://lore.kernel.org/u-boot/20241203161338.1814537-1-ilias.apalodima=
s@linaro.org/

Thanks


/Ilias

On Wed, 4 Dec 2024 at 14:15, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote=
:
>
> Dear Tom,
>
> The following changes since commit f96e5133184aac377b54bd61f8abf78710f2ee=
56:
>
>    Merge branch 'master' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-samsung (2024-12-03
> 12:37:20 -0600)
>
> are available in the Git repository at:
>
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-01-rc4
>
> for you to fetch changes up to 657310322e5893d0b1bbba002fbe59b318062192:
>
>    doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatewayipN
> (2024-12-04 11:26:34 +0100)
>
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23706
>
> ----------------------------------------------------------------
> Pull-request efi-2025-01-rc4
>
> With the move to bootstd booting via the EFI boot manager stopped to
> consider all block devices due to missing probing.
>
> With this pull request probing of all bootdevs before running the boot
> manager is achieved. Prerequisite changes are needed to pass the CI.
>
>        efi_loader: simplify efi_disk_rw_blocks()
>        test: fix test_extension.py
>        configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
>        CI: xilinx_versal_virt: disable USB_DWC3
>        net: eth_bootdev_hunt() should not run DHCP
>        cmd: bootmenu: add parameter -e for UEFI boot options
>        efi_loader: run bootdev_hunt() to find ESP
>
> Further UEFI changes:
>
>        Avoid writing message in Exit() boot service
>        Update startimage_exit self-test to check error
>        Don't warn if the TCG2 FinalEvents table is not installed
>
> Documentation changes:
>
>        cmd: bootmenu typo 'read'
>        clk: mpc83xx: Fix typo in "Coherent System Bus"
>        efi_loader: Fix typos in enum efi_allocate_type
>        doc: sending_patches: Fix spelling of "its"
>        doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gateway=
ipN
>        doc: board: theobroma-systems: fix feature list in introductions
>
> ----------------------------------------------------------------
> Andy Yan (1):
>        doc: coolpi: Fix document style
>
> Heinrich Schuchardt (9):
>        efi_loader: simplify efi_disk_rw_blocks()
>        test: fix test_extension.py
>        configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
>        CI: xilinx_versal_virt: disable USB_DWC3
>        net: eth_bootdev_hunt() should not run DHCP
>        cmd: bootmenu: add parameter -e for UEFI boot options
>        efi_loader: run bootdev_hunt() to find ESP
>        cmd: bootmenu typo 'read'
>        efi_loader: avoid writing message in Exit() boot service
>
> Ilias Apalodimas (1):
>        efi_loader: Don't warn if the TCG2 FinalEvents table is not instal=
led
>
> J. Neusch=C3=A4fer (2):
>        clk: mpc83xx: Fix typo in "Coherent System Bus"
>        doc: sending_patches: Fix spelling of "its"
>
> Jerome Forissier (1):
>        doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gateway=
ipN
>
> Quentin Schulz (1):
>        doc: board: theobroma-systems: fix feature list in introductions
>
> Simon Glass (2):
>        efi_loader: Fix typos in enum efi_allocate_type
>        efi_loader: Update startimage_exit self-test to check error
>
>   .azure-pipelines.yml                            |  1 +
>   .gitlab-ci.yml                                  |  1 +
>   cmd/bootmenu.c                                  | 41
> +++++++++++++++++++------
>   configs/sandbox_defconfig                       |  1 -
>   doc/board/coolpi/genbook_cm5_rk3588.rst         | 11 ++++---
>   doc/board/theobroma-systems/puma_rk3399.rst     |  1 +
>   doc/board/theobroma-systems/tiger_rk3588.rst    |  7 +++++
>   doc/develop/sending_patches.rst                 |  2 +-
>   doc/usage/cmd/bootmenu.rst                      | 13 ++++++--
>   doc/usage/environment.rst                       | 31 ++++++++++--------=
-
>   drivers/clk/mpc83xx_clk.h                       |  2 +-
>   include/efi.h                                   |  2 +-
>   lib/efi_loader/efi_boottime.c                   |  7 ++---
>   lib/efi_loader/efi_disk.c                       |  8 ++---
>   lib/efi_loader/efi_setup.c                      |  8 +++++
>   lib/efi_loader/efi_tcg2.c                       |  2 +-
>   lib/efi_selftest/efi_selftest_startimage_exit.c |  6 ++--
>   net/eth_bootdev.c                               | 30 ++++++++++--------
>   test/py/tests/test_extension.py                 |  4 ++-
>   19 files changed, 116 insertions(+), 62 deletions(-)
>
