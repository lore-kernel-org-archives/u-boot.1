Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BBED3CCA3
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 02:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 263BD80325;
	Thu, 15 Jan 2026 03:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bd0CLzQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29991803F5; Thu, 15 Jan 2026 03:41:03 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7EF980077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 03:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-653781de668so556761a12.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 18:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768444860; x=1769049660; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I0X7Bcfjbb7cjoMLgHgvS6Sf5y2xJEfFGeqt8IlLyQQ=;
 b=bd0CLzQcDS5ItuOWAQz98P75wMV881cqraohjx5HifCocIXaYyomEw9iCAMMCf6+K5
 LSDjggidGCFNT4Ceb9QkFZdBOdg0CTCHHKJpP3XmvpYABq6rBRUXahNxH71egyEIiuoA
 8gnz5EfhzL/APiT6tXTX+B+BfP+A6OilZVUY/X/APfvWWVlqbQzmftjEysJ/lA9hS+rS
 mh5hoKI0693skF6EUllnhObLrTQ14whsgz03cii0EEG/yOKXACWyUxYyLEPAO8zzsCsX
 gT3cRiN0lvoD2Gy+pcsuC4KwJnQw3S8gGuUDaI1nBwQ4VdedBnFKj9Kefej2lPjjDXn2
 0L9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768444860; x=1769049660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0X7Bcfjbb7cjoMLgHgvS6Sf5y2xJEfFGeqt8IlLyQQ=;
 b=izWFlOKf7fnrXlqf1+oqjb9W42Jsy5QN2vN92BjLrLtBgY1Fv/MqdStZx7eKkas5ey
 dI4TMuKU2zU1bzB21kbqME6Y+rFrvte0cQlTApXLGRprix/NstqlQhEjkzWEqOJulI67
 QA7f3luPGyC0JMesZYuvTJHBFqwPD/U7LrxSy9qJKA+sAIoHPiHeCF7Y4uzhR5EQVw/d
 +pXCJsXGSNcTfHH5Dcrej26iNYcbEcYwOgmoYt493q6kLkTD1RN10ZbBppz/LMaOr27h
 BSvXVo4r/QYbtdSa0AVgJBDWmUd/dIM079jSGF7wk8YECiC7DeN2oT8eMBRvE2r2DnYW
 ugeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/v9vYln8zqzDpIYb120wrB2Q1kBigOueRrdXW60qvgIWAyCYjEbZLLlc2nQ7nTW8g6JKssK0=@lists.denx.de
X-Gm-Message-State: AOJu0YyPdKH8R8/45nTW0hrUoLfDlIeCcJe699+aeByQFQQcrxxy72DY
 ailtXI4x50TCukjYbPJU0OZLXs4nPT3bvR23YPwabUB52o4Qf56pOZlcf1KkA5ItqK+VJlAOus7
 qZGtpytxQseSPRtKVWEj5aiKKHYV3Wts=
X-Gm-Gg: AY/fxX6/AmNryqYyZUEuPaOXJJ1AqudMgfdhXnzEnuFKEAN0bi9H/aShxrZKcTK1c0/
 cw+4QrkpQMAGe+AeYKqlcop4BOxwD6vKvtV0bR8IHbUOOosQe+HppvHI4ZnMTpmLp6CTqMhVyzc
 2WIfA46IhJMPBbtPXdvwcs4kTdapLAejaUpAPfFWPJPUGvopT0VsGiDCesEekGTX44exDCkpsih
 Mwc0Sq9SzPhaUQuT46DqttMZOP3j1wegDvFL1PbkNgBLioZd+aZroiKX4bC5sotFto+85aAGt99
 1rn3zTKSZw4baMA+b8z+1WfwTx6mzOfymbgWEIcVIBC5TPpUr4lCf5oEdNCjBOSGeXu18TLZxKt
 7aJi5ZSm90lyOh4PFeOIj30PVOkXIHIHBwJHqJg==
X-Received: by 2002:a05:6402:268a:b0:64b:6e20:c92e with SMTP id
 4fb4d7f45d1cf-653ee15f0ebmr3368240a12.10.1768444859905; Wed, 14 Jan 2026
 18:40:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1768403729.git.michal.simek@amd.com>
 <6e18320e-d481-4871-87d2-1debd8a104af@freeshell.de>
In-Reply-To: <6e18320e-d481-4871-87d2-1debd8a104af@freeshell.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 15 Jan 2026 02:40:48 +0000
X-Gm-Features: AZwV_Qjr1GgLIhd3P1djUbK3RokJ4wsRsEveD0f_yk6eTiYogePnAzEOB3Ku3xY
Message-ID: <CALeDE9MV36Oq7q_Lo=EW1jVrC2Foe68WHtvkLC+TjhkQgeXk5Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] efi_vars: Implement SPI Flash storage for EFI
To: E Shattow <e@freeshell.de>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com, 
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Wed, 14 Jan 2026 at 18:35, E Shattow <e@freeshell.de> wrote:
>
> Hi Michal I have some user-facing questions about this concept.
>
> On 1/14/26 07:15, Michal Simek wrote:
> >
> > This is updated series based on v3 version sent here
> > https://lore.kernel.org/all/20231126220836.374956-1-i@shantur.com/
> >
> > that's why I am continuing on v4 instead of starting from scratch.
> >
> > Tested on kv260 with saving variables to location where User MTD partition
> > is.
> > CONFIG_EFI_VARIABLE_SF_STORE=y
> > CONFIG_EFI_RT_VOLATILE_STORE=y
> > CONFIG_EFI_VARIABLE_SF_OFFSET=0x22a0000
> >
> > Thanks,
> > Michal
> >
> > Changes in v4:
> > - New patch based on review comments from v3
> > - use unify methods for reading/writing variable
> >
> > Changes in v3:
> > - Fixed compiler warnings.
> >
> > Changes in v2:
> > - Refactored efi_var_file to move common parts out as requested
> > - Changed ifdefs to use CONFIG_IS_DEFINED
> > - Fixed typos
> >
> > Michal Simek (1):
> >   efi_var: Unify read/write access helper function
> >
> > Shantur Rathore (2):
> >   efi_var_file: refactor to move buffer functions
> >   efi_vars: Implement SPI Flash store
> >
> >  include/efi_variable.h          | 18 +++----
> >  lib/efi_loader/Kconfig          | 26 +++++++++-
> >  lib/efi_loader/Makefile         |  3 +-
> >  lib/efi_loader/efi_var_common.c | 44 ++++++++++++++++
> >  lib/efi_loader/efi_var_file.c   | 65 ++---------------------
> >  lib/efi_loader/efi_var_sf.c     | 91 +++++++++++++++++++++++++++++++++
> >  lib/efi_loader/efi_variable.c   | 16 ++++--
> >  7 files changed, 187 insertions(+), 76 deletions(-)
> >  create mode 100644 lib/efi_loader/efi_var_sf.c
> >
>
> So far as I'm aware support for EFI variable storage is always integral
> to a filesystem as the EFI System Partition, even in the case of the
> specially-handled MMC boot partition facility. With presence of many
> possible ESP is there then only one active ESP, or do all ESP become
> part of a pool of available locations?  I'm not understanding this
> clearly what is the purpose of selecting an ESP if the variable storage
> is not integral to the ESP.

EFI variables have nothing to do with ESP filesystems. Most
implementations of EFI variables don't use ESP partitions to write
variables, U-Boot did that basically as a work around. If you look at
the average UEFI implementation on a Intel device the EFI vars are
written to the flash storage where they can be signed and validated to
ensure they're not changed without the firmware knowing.

> Does having EFI variable storage in SPI Flash always take priority over
> other ESP presence that might have additional variable storage as a file?

That would presumably depend on the U-Boot build options.

> Can (or should?) there be a runtime configurable setting to decide two
> preferences; does one depend on the other or are these independent?:

No. It would be a device decision.

> 1. Preferred ESP
> 2. Preferred EFI variable storage strategy
>
> Consider not wanting to have a perceived ABI breakage as the SPI Flash
> layout is previously codified by user expectations of what the vendor
> initially shipped with the product and having been codified in upstream
> Linux kernel devicetree definition. For the example where this would be
> useful for boards where there is a well-known SPI Flash layout, I am
> thinking of StarFive VisionFive 2 where there is {U-Boot SPL, U-Boot env
> storage, U-Boot Main at 1MiB offset}; does your implementation of EFI
> variable storage in SPI Flash have a suggested co-existence with the
> "gap" in the area that is currently U-Boot env storage?

The board maintainer would decide that, or the vendor, or if the user
wants to building their own.

> The use situations I am thinking of:
>
> A. Installing a new OS or booting purpose-built image, where it is
> intended that having (for example) a USB mass storage class or SD Card
> of the all-in-one image depends on U-Boot in SPI Flash deciding both
> that the EFI System Partition on the removable media is a priority over
> other similar media (other different USB boot devices that may be
> present, existing eMMC storage module possibly with ESP in addition to
> the inserted removable SD Card).

Well by storing the EFI vars on the SPI flash the user can erase one
of the storage options without necessarily impacting the EFI vars
without knowing.

The storage of EFI vars on the flash of the firmware is what you get
on x86 devices.

> B. Preventing the ambiguous selection of any additional removable
> storage containing an EFI System Partition from breaking the desired
> boot strategy. In many situations a user wants assurance that the board
> will boot exactly the same every time regardless of what additional
> removable media containing EFI System Partition might be connected.
>
> C. Corrupt or unusable selected EFI System Partition prevents any
> recovery and there is no runtime mechanism to attempt an alternative

No it doesn't there's EFI fall back options or you could erase the
vars from the u-boot cmd line etc.

> Is there a possible mechanism for adding a runtime check (GPIO state,
> key press, network event) to make the decision between some immutable
> boot preference, or a user-configured boot preference?
>
> Overall I want to get an understanding of how it might be recommended to
> make use of this for StarFive VisionFive 2 board target(s). Many hours
> of troubleshooting headache have been the result of EFI System Partition
> confusion on board that have a wide variety of storage subsystems (MMC,
> USB, NVMe, ...) which result in some really strange outcomes with
> installers of GNU/Linux OS distros;  particularly as the devicetree dtb
> search path currently points to storage subsystems that are typically
> removable media, or the failure mode where an OS installer is using the
> selected EFI System Partition that "leads on a path to nowhere" and is
> not the intended installation target.
>
> -E
