Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077E2C27C43
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 00:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01473885B5;
	Wed, 29 May 2024 02:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gUVzDjEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66D9A885BC; Wed, 29 May 2024 02:38:26 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57BC3884E5
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 02:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-529682e013dso1778266e87.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 17:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716943103; x=1717547903; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEiNQj+D7OMYLHH1j9mBYCwOEu7lmNXcqbIZr0Y4KA0=;
 b=gUVzDjEFABhpmY/7VLacw+wAtncC0qQOsOj0g6QQqR9NILoIuMEae00O8kr6eAuEtw
 eE/2lo9WGbD5312INC9P3TgL9t6iDlniA+XlBNiqhkxaekVAPhMlbZ6fub6Lt3hLiQq5
 sALMDJ0pq+Y913Ku0Y1mM1iUnZGc2VrD8cCt3m/Z3tOew4pu3E4TU3/7BPayuTj+o3Hp
 d5+/sVKJDKkv3X66FCdfLcYA/A/f61Z5lZYuTgEze8zSC9FUsYWtVnxJUqNhbsDovgdr
 wZ+UGYPYEnkxIB5z1emzsjCwQ8BVfW10ctqV92oKyHfaHAqeo1IoB+B1Z2bZn6CGGMg6
 YK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716943103; x=1717547903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEiNQj+D7OMYLHH1j9mBYCwOEu7lmNXcqbIZr0Y4KA0=;
 b=hnnRHu64aJKFlR0kwCNfNBgBtMNe1t5TIzeNvR0nibvfQSoA058OxnnNRO9Pr5ZCti
 9syAc/RwAC8KpIV291/KRL2cDmAzOfbcM7OEANeJlWxF+RKXEsW3jjKBZL/NKBBv6tz9
 A24vWdL3fvo8e3hY+IpAbcmgkZ1HiwilQfSAfTcP6chrJMtt5npN8XhvX1yzvjRXXXZD
 PEGy24XMA+fE20UCJCgeev7pwKtkFkZaypSu9+wqH0ncv1pDTvQcM4Tgr4yHTEQkmSEm
 Dn62lzAu6p85vjE4DwwTPr53/Vak3pn7ke3RXosIH0iAv+PpI7G4NqzwBmBU7GJcgSfQ
 KCAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKQuGCeC8v6F5xMcg5KKdaAT0WNOcK4LT/nJx9jihZnpX03djlIjesRFEvYRxhnLylKJ9PxzU/0b5rvuAm3TtzwqJm/A==
X-Gm-Message-State: AOJu0Yy0ZcVwxq3daa8cGLgLKbWlJEus/3LY2awzEtnuwhljkkH4+eDh
 LiAwQzIP5TUM/6l4SwCD9qdKxIiYl8STmZjitX9Hvxssiz0A6iOry2FPxJT5wt7ZrXCj7GshMtT
 DMu3sHEipfZMbeMi5WtZUQ2jZIBo=
X-Google-Smtp-Source: AGHT+IEzVfAVnl/82aWu4wNpL8VhmoOEOm5X63vbAxi+xJ1J5FwjUXx1Y8TU/gfMdvulzzgaRZ/oEJS1qspnqa0ZvsQ=
X-Received: by 2002:ac2:47f9:0:b0:51b:6ed6:af3f with SMTP id
 2adb3069b0e04-529649c5dbdmr7859144e87.16.1716943103411; Tue, 28 May 2024
 17:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 28 May 2024 17:38:11 -0700
Message-ID: <CANV2PTOAc50sXtz2V6s7bgnEk02TV_7+VArxBpHhF_tCGNjsmA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] efi_loader: improve device-tree loading
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Shantur Rathore <i@shantur.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Bin Meng <bmeng@tinylab.org>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Tue, May 28, 2024 at 7:43=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In U-Boot EFI boot options can already specify both an EFI binary and
> an initrd. With this series we can additionally define the matching
> device-tree to be loaded in the boot option.
>
> With the last patch the boot manager will fall back the device-tree
> specified by $fdtfile in directories '/dtb/', '/', or '/dtb/current/'
> on the boot device if no device-tree is specified in the boot
> option or via a bootefi command parameter.
>

As tested the $fdtfile environment variable has no effect on
global EFI boot when i.e. EFI/BOOT/BOOTRISCV64.EFI
on EFI System Partition and no user-added boot option;
$fdtfile env variable is not used with "mmc 0" or whichever
global boot option is enabled by default in the boot order.

Adding a boot option for EFI/BOOT/BOOTRISCV64.EFI
and giving this priority in the boot order allows $fdtfile to
be effective here. This is consistent with what is described
by the series. Would the global EFI boot also get support
for $fdtfile either with this or a later series?

> v2:
>         Update efi_dp_concat() instead of new function efi_dp_merge().
>         Carve out a function efi_load_option_dp_join() which we can
>         use both for the eficonfig and the efidebug command.
>         Rename variables id_dp, final_dp_size.
>         Rename create_initrd_dp() to create_lo_dp_part().
>         Use enum as parameter for create_lo_dp_part().
>         Put all related changes into one patch.
>
> Heinrich Schuchardt (8):
>   efi_loader: allow concatenation with contained end node
>   cmd: eficonfig: add support for setting fdt
>   cmd: efidebug: add support for setting fdt
>   efi_loader: load device-tree specified in boot option
>   efi_loader: move distro_efi_get_fdt_name()
>   efi_loader: return binary from efi_dp_from_lo()
>   efi_loader: export efi_load_image_from_path
>   efi_loader: load distro dtb in bootmgr
>
>  boot/bootmeth_efi.c                        |  60 +---------
>  cmd/eficonfig.c                            |  83 +++++++++----
>  cmd/efidebug.c                             | 130 +++++++++++++++------
>  include/efi_loader.h                       |  24 +++-
>  lib/efi_loader/Makefile                    |   1 +
>  lib/efi_loader/efi_bootbin.c               |   2 +-
>  lib/efi_loader/efi_bootmgr.c               |  75 +++++++++++-
>  lib/efi_loader/efi_boottime.c              |   3 +-
>  lib/efi_loader/efi_device_path.c           |  40 ++++---
>  lib/efi_loader/efi_device_path_utilities.c |   2 +-
>  lib/efi_loader/efi_fdt.c                   | 117 +++++++++++++++++++
>  lib/efi_loader/efi_helper.c                |  44 +++++++
>  12 files changed, 445 insertions(+), 136 deletions(-)
>  create mode 100644 lib/efi_loader/efi_fdt.c
>
> --
> 2.43.0
>

Tested-by: E Shattow <lucent@gmail.com>
