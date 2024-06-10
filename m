Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB7DC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C106884C7;
	Mon, 10 Jun 2024 15:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E1A+epdq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05D5188532; Mon, 10 Jun 2024 15:53:17 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F2DC884C7
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b060f0f48aso14055806d6.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718027593; x=1718632393; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vKl1PhriwrkewtKj4zOcWPapEJ8z0xyX89xqFo/JqN4=;
 b=E1A+epdqexv41Vh2s+4ljSFUNh/eTZh+nycYnBhkcNrPdR2iG9cE/XsK3R5eN3Ycem
 dwFjKd2ZaXVG7DXItoW99w2uAtfrJug/JxnszcYeIJHh3fsXTWztxNZFx5vVLpT85zwB
 zlR90e8juU25Hr2P+dxuquu5/fx8dceY9d0SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718027593; x=1718632393;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vKl1PhriwrkewtKj4zOcWPapEJ8z0xyX89xqFo/JqN4=;
 b=JFrX15k+f0Kp9znB68PpNkKgmjSjP5sQA/IrdAzutnwC1pyJlQkoD6ltaTabQGTEHf
 hhV450x+1HhNRJcdzAeELNB/d+/yvNXt1BzBbkNwHZh7xJv36cuzcPSeWV91/2/lUK+n
 beMLj2QKjacwjZevKX88LKjM1XkeRYWJltljSABG8QiMUgOABK1gUEL68IOCaTW7cUuQ
 zOt9gIua6Yy7J9QWFSxnkW0sbAcICPJ+Ao5B42wDf8pavF9V82HrnSlAaLzZua4DglJ/
 pBS2w+PUffSQiS+JRCKwoVJDrv672na8VFz7J2nUHJLaJcQBk66gOuN5W6Hp7efCWRrq
 5D0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUflC1Kv3Rc8vA7GLwmrNbr/nsSmFt3Hj7TN2PhBW3FE32gEAuK17vfrF2OkgCqmkq3aagDf4rBAyr5czM3xyyy1upidw==
X-Gm-Message-State: AOJu0YxJToy8FuJD15FY3oc2gEU4zu3DIn7cuMUxVg7AQcFk/gd+3U0W
 8F6fXGxPkVb2bag26QTj4wf4R/eOB/EsMBcsrJygxMEKq7q/mAUZCpirF25xkHpd8pkSIsU3jRZ
 nV/buMfwl0dtd9Bnu4f5fJZOoZ+Y+kk61GOOD
X-Google-Smtp-Source: AGHT+IE1R1kAXABqVr3c8U2D1hcT7sOrJ+2r/GrGyKnAp72aDMlvvbBD87aV+1m1hCLfm6ULkzrg8QQVppkbN2SCG/k=
X-Received: by 2002:a05:6214:3c9e:b0:6af:2a4e:140e with SMTP id
 6a1803df08f44-6b059f2fa97mr127556876d6.65.1718027593280; Mon, 10 Jun 2024
 06:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Jun 2024 07:53:02 -0600
Message-ID: <CAFLszTgcnftK=GqZ0LGue2Y8-YkRhOKzPuc4Yf1CvhzAGO+MTg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] efi_loader: improve device-tree loading
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Mon, 10 Jun 2024 at 03:11, Heinrich Schuchardt
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
> v3:
>         Add missing '@' in EFI_LP_DP_PART_FDT description.
>         Use calloc() instead of malloc() in load_fdt_from_load_option().
>         Add missing '@' in load_fdt_from_load_option function description
>         Rename struct efi_initrd_dp to efi_lo_dp_prefix.
>
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

Somewhat related, what work has been done to support FIT, or to locate
a DT using the compatible string?

Regards,
Simon
