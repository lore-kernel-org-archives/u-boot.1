Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB9DE7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 15:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1B9C89383;
	Wed,  4 Dec 2024 16:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G57XKceS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526618967E; Wed,  4 Dec 2024 16:13:06 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC0AA89346
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 16:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa543c4db92so991111666b.0
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 07:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733325183; x=1733929983; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBoY33Eh/ssgbr22Q85o392u5SFWZn6cVQjOoE8TkE4=;
 b=G57XKceS5RTtTx1XtDxg+k0H25DHUfYdHs5Ptj0fYoY6BeDohvduJYEn25sR1/+G6x
 g394ij18pn91iwRjWoLTbvtoN2iItxgMLIjKQr2ovJC6LYmvjHH4umhrsqUOHTJDnoj7
 oMgZp+TGGPIq9Q33ZV6+89mOMqYhJlDVnEG7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733325183; x=1733929983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBoY33Eh/ssgbr22Q85o392u5SFWZn6cVQjOoE8TkE4=;
 b=oDHQWzEnhDxUp6Z6CLVWHM1NXp3sQAxy6XxIxR+jXbwRG8xU1aOWqmg4q/Cc0u2533
 Zg052Clp5N+9Rqm9AUBBiAUCczCu7p/HOohBNpaBb0hrgRNVqMbcBfGXPasHgpuj6IuN
 ZZnhBt1nkoy/5gpQXDw24p5bIxncmMP5WsAIIgzpLv9duontUKsXdTqRcWySkJ3EorBJ
 qJygCLPWGZn/NeaaGaflkuxqyzAlHjysSuS81x04NwJxjwdmb63YkgBZvVYLN6yRplBl
 KdE8Se63GFGsk3xJScs/EewrOntGxu5QI4QvzsfzaA4gher0jCcH7ZX0oMdfviKimEFr
 O4GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz7737JCOmNm9hwvmT1xOPhULglCA/7rYHenUFqPQNuFV97eZjkCwbjqWphSaftsB+BBAjSRY=@lists.denx.de
X-Gm-Message-State: AOJu0YwLkk7f2Fa2sbnuXcSkP5IIFmVa1Fl1p6a5G60c/cxndFn0EJ9V
 D6rLTTKUoiV/LXPpgXUC2XtGdmYxK6m4FkOPPk7MJg9UJ3/ymWSpUEI59fB3nn6pgIq834ixwmV
 tHXfKtapoOn7acYVa2A2zAf87oK8MF7Z3Gfl5
X-Gm-Gg: ASbGncs1XQbHfC0ALP1cg8bXBL1GyxBis17RvNOz78nQ0E3ooe3C71SCPLJAej2l5r4
 60Um5SKKRKtAtsaESqywxnSTPYDoMFptL
X-Google-Smtp-Source: AGHT+IGhHST/1kmZqkPVduYHc0gIBaQG09dRRaT3IMvqsDgq86Dyjhf+ajCjoQao+vagsadcIFdDAwy5GT4gUuW6uKo=
X-Received: by 2002:a17:907:75e6:b0:aa5:50b6:a612 with SMTP id
 a640c23a62f3a-aa5f7f5c36cmr530846366b.61.1733325183270; Wed, 04 Dec 2024
 07:13:03 -0800 (PST)
MIME-Version: 1.0
References: <8910d434-2d77-425f-aa81-8eb803078aef@gmx.de>
 <2cca538b-c568-464e-b4f0-4c0bba553d58@kwiboo.se>
In-Reply-To: <2cca538b-c568-464e-b4f0-4c0bba553d58@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Dec 2024 08:12:51 -0700
Message-ID: <CAFLszTjyu3nWKqTn_9GDmWtSwNKsX5F+Q56ACsUrFPe1bSG6Eg@mail.gmail.com>
Subject: Re: [MASTER] Pull-request efi-2025-01-rc4
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andy Yan <andyshrk@163.com>, =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi,

On Wed, 4 Dec 2024 at 08:01, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Heinrich,
>
> On 2024-12-04 13:10, Heinrich Schuchardt wrote:
> > Dear Tom,
> >
> > The following changes since commit f96e5133184aac377b54bd61f8abf78710f2=
ee56:
> >
> >    Merge branch 'master' of
> > https://gitlab.denx.de/u-boot/custodians/u-boot-samsung (2024-12-03
> > 12:37:20 -0600)
> >
> > are available in the Git repository at:
> >
> >    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> > tags/efi-2025-01-rc4
> >
> > for you to fetch changes up to 657310322e5893d0b1bbba002fbe59b318062192=
:
> >
> >    doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatewayip=
N
> > (2024-12-04 11:26:34 +0100)
> >
> > Gitlab CI showed no issues:
> > https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23706
> >
> > ----------------------------------------------------------------
> > Pull-request efi-2025-01-rc4
> >
> > With the move to bootstd booting via the EFI boot manager stopped to
> > consider all block devices due to missing probing.
> >
> > With this pull request probing of all bootdevs before running the boot
> > manager is achieved. Prerequisite changes are needed to pass the CI.
> >
> >        efi_loader: simplify efi_disk_rw_blocks()
> >        test: fix test_extension.py
> >        configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
> >        CI: xilinx_versal_virt: disable USB_DWC3
> >        net: eth_bootdev_hunt() should not run DHCP
> >        cmd: bootmenu: add parameter -e for UEFI boot options
> >        efi_loader: run bootdev_hunt() to find ESP
>
> As pointed out in v1 of this patch, this cause a serious slowed down
> boot for bootstd boards using scripts and extlinux boot due to usb and
> pci being initialized before boot_targets order is considered.
>
> With this merged we probably need to disable BOOTMETH_EFI_BOOTMGR for
> bootstd/Rockchip. Seem very late in release to merge this big change!
>
> Regards,
> Jonas
>
> >
> > Further UEFI changes:
> >
> >        Avoid writing message in Exit() boot service
> >        Update startimage_exit self-test to check error
> >        Don't warn if the TCG2 FinalEvents table is not installed
> >
> > Documentation changes:
> >
> >        cmd: bootmenu typo 'read'
> >        clk: mpc83xx: Fix typo in "Coherent System Bus"
> >        efi_loader: Fix typos in enum efi_allocate_type
> >        doc: sending_patches: Fix spelling of "its"
> >        doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatew=
ayipN
> >        doc: board: theobroma-systems: fix feature list in introductions
> >
> > ----------------------------------------------------------------
> > Andy Yan (1):
> >        doc: coolpi: Fix document style
> >
> > Heinrich Schuchardt (9):
> >        efi_loader: simplify efi_disk_rw_blocks()
> >        test: fix test_extension.py
> >        configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
> >        CI: xilinx_versal_virt: disable USB_DWC3
> >        net: eth_bootdev_hunt() should not run DHCP
> >        cmd: bootmenu: add parameter -e for UEFI boot options
> >        efi_loader: run bootdev_hunt() to find ESP
> >        cmd: bootmenu typo 'read'
> >        efi_loader: avoid writing message in Exit() boot service
> >
> > Ilias Apalodimas (1):
> >        efi_loader: Don't warn if the TCG2 FinalEvents table is not inst=
alled
> >
> > J. Neusch=C3=A4fer (2):
> >        clk: mpc83xx: Fix typo in "Coherent System Bus"
> >        doc: sending_patches: Fix spelling of "its"
> >
> > Jerome Forissier (1):
> >        doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatew=
ayipN
> >
> > Quentin Schulz (1):
> >        doc: board: theobroma-systems: fix feature list in introductions
> >
> > Simon Glass (2):
> >        efi_loader: Fix typos in enum efi_allocate_type
> >        efi_loader: Update startimage_exit self-test to check error
> >
> >   .azure-pipelines.yml                            |  1 +
> >   .gitlab-ci.yml                                  |  1 +
> >   cmd/bootmenu.c                                  | 41
> > +++++++++++++++++++------
> >   configs/sandbox_defconfig                       |  1 -
> >   doc/board/coolpi/genbook_cm5_rk3588.rst         | 11 ++++---
> >   doc/board/theobroma-systems/puma_rk3399.rst     |  1 +
> >   doc/board/theobroma-systems/tiger_rk3588.rst    |  7 +++++
> >   doc/develop/sending_patches.rst                 |  2 +-
> >   doc/usage/cmd/bootmenu.rst                      | 13 ++++++--
> >   doc/usage/environment.rst                       | 31 ++++++++++------=
---
> >   drivers/clk/mpc83xx_clk.h                       |  2 +-
> >   include/efi.h                                   |  2 +-
> >   lib/efi_loader/efi_boottime.c                   |  7 ++---
> >   lib/efi_loader/efi_disk.c                       |  8 ++---
> >   lib/efi_loader/efi_setup.c                      |  8 +++++
> >   lib/efi_loader/efi_tcg2.c                       |  2 +-
> >   lib/efi_selftest/efi_selftest_startimage_exit.c |  6 ++--
> >   net/eth_bootdev.c                               | 30 ++++++++++------=
--
> >   test/py/tests/test_extension.py                 |  4 ++-
> >   19 files changed, 116 insertions(+), 62 deletions(-)
> >
>

Yes, this change[1] looks innocuous but since the bootmgr problem has
not been solved. This definitely should not go into master, sorry.

So NAK from me

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241127070631.16412-7=
-heinrich.schuchardt@canonical.com/
