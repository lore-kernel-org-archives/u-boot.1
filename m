Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A47C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62CC981A0C;
	Wed, 19 Mar 2025 13:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WwTeixcg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C5981CFD; Wed, 19 Mar 2025 13:13:00 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D1118141E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff6a98c638so8243452a91.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 05:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742386376; x=1742991176; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lT1IWHuPYMJaR/IegM5vH9UZirVz2XhseMU3KiSwIzw=;
 b=WwTeixcgnP4w0lTb84LXxM9KFjfZ+NjAPzeC7Tr10BWaHPJ61KMDY4jlSO7ILkBS/R
 NeoQT3ROO3wBR3E7PI5QD7oVGRAo9bw9JGo0l2yGVelugqYUUMWCukomiEbFEwBoYM11
 SW6mOf8tjtQgITnuwiHyO0EFtJEpxaWZ3bLkMkUIROrlVqnNuC88L3qlri3h9VowlX/i
 vmrEgtIxbWPcH/ixDgplorTZqC4ziPP7zSRGe6f2GZnS02r9M1toJFS6XY/dR8JFbcwI
 JcKsJYYIzxJEs4ZBFjs6TnPdm9gfEdPVk9SiHpSVlGaD21tijV+VOxRKy3TRwwJCwb4L
 AfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742386376; x=1742991176;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lT1IWHuPYMJaR/IegM5vH9UZirVz2XhseMU3KiSwIzw=;
 b=dZp4wJenasJtRbBr8NSSzTZF1sTlH3VLh7AhLXwCIXXwsqHaHvENIJGKNDH0RS5jIz
 2kaDVromRoyJIHjYHaYv0j5mKD/hoX4de0kkjyWiiHXa+Q/fa8nkz+oYHQA1Np3LNfoA
 so8+sSUVjYwi9Zk7Vt1xK2bb0c6n0dn+88drg3Z407Sdtsz3yVXpKsSYLanPbzRKIZbG
 /e9hU3HDO1LLV2/nppQumwcrs4L1+kC0KRSFaApQGY1winr2sYe0IzAwz/6Z/gKRAY6r
 /aIyfuEQYxT9VuOBDSwM5fHQNhXw6opxGRolg3PoOnVfDTu/gyiglTkgFDID48xl0QDz
 uVzQ==
X-Gm-Message-State: AOJu0YyCZFOIBXStYnOxKKvCsbV/plSY1PaJ3q+DRnVUtMo+4twzcmZQ
 JwQBxEKkwdtEwWHO8Fxw54hUSf/IqsZLdccRBbUxd4sjEu58Pb+ZIHNwvygbvY6z//Rw2ybWViR
 W9tMwjeXdz51pfqGSQrch7rRT3OsPV3OpKEQ=
X-Gm-Gg: ASbGncs4ROHv1zv6NM7bDLnKJ44DW6voYJ9D0uFWbLLBed9S2pxxOi6AAK+WwDsvaBT
 LK082nvZjmOgt3QLPjZstjouVBnQCCvuiiLm3PiME7rDw0OYh3fuWUChnSCzrslAZG5zWWEQ1HZ
 k+uAEHM2Ummifuaahyb2omWeywQK8=
X-Google-Smtp-Source: AGHT+IFAiqpUUcYyy4pZ4nrQ9juSFxZ8/QqnAddZFu0zP9BBK/TFmmufihTC4phZWklLhhiNnfgH9mt/L8BR3g6v3Pk=
X-Received: by 2002:a17:90b:3f44:b0:2ff:4f04:4261 with SMTP id
 98e67ed59e1d1-301be2188efmr3259178a91.34.1742386376574; Wed, 19 Mar 2025
 05:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
 <CAC_iWjJgS2oudWw7DTDW4uPtaGvw8MSdzo1VyswX8CLYD9dL0g@mail.gmail.com>
In-Reply-To: <CAC_iWjJgS2oudWw7DTDW4uPtaGvw8MSdzo1VyswX8CLYD9dL0g@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Wed, 19 Mar 2025 09:13:07 -0300
X-Gm-Features: AQ5f1JoyePmpVxBRUfOaAihoCsKNYCfoKPk28KX0ErmcgcUvQsJb3gkswAfFkAw
Message-ID: <CAMGU2hW4Axz3vkqcDFFNYMxW2JQxNRoNxvAZ2mrMrQGC78NQYw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add initrd support to bootm EFI payloads
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

El mi=C3=A9, 19 mar 2025 a las 5:48, Ilias Apalodimas (<
ilias.apalodimas@linaro.org>) escribi=C3=B3:

> Hi Adriano,
>
> On Tue, 18 Mar 2025 at 15:23, Adriano Cordova <adrianox@gmail.com> wrote:
> >
> > Next boot stages can acces an initrd via a handle with a specific devic=
e
> > path and an EFI_LOAD_FILE2_PROTOCOL installed on it. In U-Boot, this
> functionality
> > is currently only implemented when booting with the EFI boot manager.
> This series
> > implements this functionality also for the bootm command when the os is
> of EFI type,
> > e.g. when booting FIT images with an EFI kernel.
>
> I'll have a look at the patches shortly. I have a question about the
> entire series though.
>
> The initrd was plugged into the efi boot manager because it's easy to
> configure entries of
> kernel-initrd-dtb. The initrd can also be loaded by passing a kernel
> command line parameter.
>
> That parameter can either be initrd=3D<file> with the limitation that
> the initrd needs to be on the same filesystem as the kernel image.
> On newer kernels you can also pass initrd=3D<device path>. I am not sure
> what's the best option when loading the initrd for a FIT image.
>
> Thanks
> /Ilias
>

Currently the initrd in FIT images with EFI os is completely ignored. It
can't be passed as initrd=3D<file>
because it is not a file, it is just memory mapped, and I am not sure if it
can be passed as initrd=3D<device path>
as I am not sure if the kernel expects a file system device path or if a
memory device path would be picked
up. In this series the functionality is added following what bootmgr
already does, which also works for passing
the initrd to a boot stage that understands EFI but not command line, but
investigating the other way is also an option.

Thanks,
Adriano

>
>
> >
> > Adriano Cordova (3):
> >   efi_loader: efi_load_initrd: provide a memory mapped initrd
> >   efi_loader: binary_run: register an initrd
> >   bootm: add support for initrd in do_bootm_efi
> >
> >  boot/bootm_os.c                  |  4 +-
> >  cmd/bootefi.c                    |  2 +-
> >  include/efi_loader.h             |  4 +-
> >  lib/efi_loader/efi_bootbin.c     | 20 +++++++--
> >  lib/efi_loader/efi_bootmgr.c     |  2 +-
> >  lib/efi_loader/efi_load_initrd.c | 71 +++++++++++++++++++++++++++-----
> >  6 files changed, 84 insertions(+), 19 deletions(-)
> >
> > --
> > 2.48.1
> >
>
