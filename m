Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451A9C4452A
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 14:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A1F838D7;
	Mon, 20 Jul 2026 16:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GnaTgCoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50F98847AF; Mon, 20 Jul 2026 15:28:32 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE8480517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 15:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 176983FC03
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784554109;
 bh=fQHkgdEGNXh4L2EKvrnunJGZnADIOw6t8+TZdpmNSLI=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=GnaTgCoUly5Dwx+mO/bQi7wJWvbBUV7BRPGIEDljFg2xYg1GRxrI357kBsUKrQdMT
 tEmVKPRhmSUFW5sWDZENfHs69h1gkrEkM80/52XxSBydTzOhc6rbwlKFbWWNCMvIzT
 LBohCn9ht4d9IWc2Wen2kkrbya6FoWGB629L0JwWQn9hM2cdRM2hcudq7ZU03lDT9A
 XqdYEYIH9tqMWRCN0KfIdCPl5ZNvf4T809A/eTkJlu1mzjCx9zusMg97x9Mmd6LN1O
 dTfSmVeM3ZcosnkvXyAU7SaWvaMKSY3swV27MgFrOe0Ats67VZgmoCkoMtluWOwYfC
 iHW8aXXgvQ+6dCFfcZG6ZcD8LGmy8tZw4ipvDi3z4aldWQvcy9opZDQp549HP7se+H
 MlsUcQgGOdpf3GvcgFNTp6ncD5SaXcCn/z8US7iqeszlWiJB0WeL0knpCycPvs095O
 3b2rCn3oU8cTIUzERzqMKj8z5fZ8MRbPrmW7LqZgDo8Mjn2936EfTvJZx1lNcAO666
 to1CwkjfCrrR7jWOZY/xTB44fnOomXSCoA1q3U9dfW9fwY/Em8p9CtDOZjwKFIu7uV
 yljV/9AqalRZYWDkgb0ujaF8VfYRsxu029LbYtTHQP0vjv2P2JGLRnL7D6mCz3VpSx
 K3gRph8Py31Yk+rz8fQc0apI=
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c15e555a164so491067766b.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:28:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784554108; cv=none;
 d=google.com; s=arc-20260327;
 b=YdrggF0PeImcybA7j18UVAmThVlTJmJYMpA6vhhgqgnyHv1RsAeG1ZljQoQVv7hp2O
 bhFDEoc3rQ84LckbHfd87Q+kV3TNIk5I87mOwQAC+yIWs6sQE8Vdz0CY3nrPFklT26zQ
 PuaOKjO22tJeKGHCy/0mjLoaoheNW7qC2/AmMsrQljhq5N55hyXL0FUPVti5/a8UmNAO
 Zs9q5Oa0m/MgtsPOZAK3ao1+no1Nl1vov4xcolnxfGNFMCa6GNUb6RgNh3UtfaNerGOb
 TvNHTPNGs8gldUcAEOfLYkA+bXok92q8Z5xDKOvWs0fY7JIURglOVP2fT+vYdFew3UAN
 C3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=fQHkgdEGNXh4L2EKvrnunJGZnADIOw6t8+TZdpmNSLI=;
 fh=RAq+IAudwTxLlp7kUcaIcquwD/uMHo+xTAquyAMDXI4=;
 b=W/iLNZQuhR1zZLg05VKG3bbIVaijuedtrEmD0RnF32kFP23jtEpJvQakQk5kVpILx4
 hW4HSDak2qBnE8QHRYI4YKpzCvVShaypHgx5Ds6Dvsz5knUzryT5Yqw+V3H1BuJqYfsY
 S6NqD3KnxjAZwLo8gKhQr5ZcHK0whvQPRLDJp+PiRzGNJQPZUe+ZxWVYZhEBL7PHqRXq
 lMT5OaKaNzSXijnrjoyEzqHJsR2sk38t1TlfVtpyTIpSsagJQCgSNszTfipoacGFl+N6
 9AIzCt26vcaW4bny8hurgHvjOwRBw1pP2bowghkQhW4MWayYbjZqBcyo9ys1palyAjYV
 0wag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784554108; x=1785158908;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fQHkgdEGNXh4L2EKvrnunJGZnADIOw6t8+TZdpmNSLI=;
 b=HXY8RJ/8UMYd8/g6eApAMibanpvV33PUgoBMjqDrTQCWv6O6sL8lj1qIE1a8ONicLZ
 i5yvCkZeHwLcvbzKtZA8xAHY2Jyz8ihLAR+TJGqKHwVB2BiiXEiJbPZQyqnC3IFVrGRL
 V24gUA3rRIjT8QHzCHzJo3XxTQmgWIIf77W9B6xzACPy+/7MHm31llMnWRwTIE58da8h
 VsXttT6g8kBmQuMWpC2+N3hRt2PwYKe5pVgIDbba9d3bVyc8aHlUqQMblKWcoAEM8qOA
 0ObDywsYSS1MBXzt5LfHT6Rq+bbAUJM+9AGSifXlNqDoCpnBKI8eRmLqc/fKR0jUe6sO
 dRYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRO5Gs6wcPdnrggXqdWUcIZFYk+bDiN8B8UUIG+W5E1IdCBNDq/w7W/TTMVy81KNAxmDFnnFE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3U35L8olaCU5VK3YPRJu0zr+2uHhFE9faxtSsTTF1PjqD1nkM
 O79nUpghlRj4weMW7y6m904W8xul9+Q4s18PzaL4yrtRoPf1gFj0nmh6y+IzvWEahQ9maYAXQQ9
 dayD+VVqaCv/LeV+noKt1e7FbLkqQzeNOVWVNN/oxbFJc4eR7Vu8f6/gdciB3eZEk/+wvRTpvou
 7p5YOuS0/dxgKpMYl1j5PgGRj572eawdX9HpW5zUDAJIyTLA==
X-Gm-Gg: AfdE7cl+UGWMBPt4/1JffXDHKpeB+qYtXcE/mb+v/+5SeH2th9P0uV9+INdVpO/cQ72
 4xP2E83099mXKJHHg0ks6qlpoQBQv20p06wsOoTCXQq86NG6iJvBxzR2C+hjTNjCdV8fgq/pHlG
 JUW7oR9gHRiyrSBqlmoh+iQ3W7aTu/t4dEFF9IFvbAA9ZCvg7xcQ4zXJMnKA==
X-Received: by 2002:a17:907:9455:b0:c12:220a:e4a7 with SMTP id
 a640c23a62f3a-c1692499364mr816932766b.32.1784554108316; 
 Mon, 20 Jul 2026 06:28:28 -0700 (PDT)
X-Received: by 2002:a17:907:9455:b0:c12:220a:e4a7 with SMTP id
 a640c23a62f3a-c1692499364mr816930966b.32.1784554107813; Mon, 20 Jul 2026
 06:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260711091559.1842381-1-aristo.chen@canonical.com>
 <fea71de5-8572-4b4c-96da-1b201f72097b@gmx.de>
 <CAFLszTgJvA-hqcybb11JJhUMsi7qv3UqY_qEL1g7Hx5zQePv5A@mail.gmail.com>
In-Reply-To: <CAFLszTgJvA-hqcybb11JJhUMsi7qv3UqY_qEL1g7Hx5zQePv5A@mail.gmail.com>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Mon, 20 Jul 2026 21:28:15 +0800
X-Gm-Features: AUfX_myq9VmdB0WN4CzESko6n4R3EPLory6O5mh8CHkXAwQ9Wh2JUb90hnkOJnc
Message-ID: <CAA=k7=ktNo6q_oodb9U6kARdA7aROD0bN6a81sJ4B8zyBiwNiQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] efi: Unify memory map type and attribute names
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 20 Jul 2026 16:32:59 +0200
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

Hi Heinrich, Simon,

Thank you both for the review.

On Fri, Jul 17, 2026 at 9:20=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi,
>
> On Thu, 16 Jul 2026 at 13:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 7/11/26 11:15, Aristo Chen wrote:
> > > The efi and efidebug commands each carry their own table of EFI memor=
y
> > > type names and memory attribute names. The two copies have drifted:
> > > efidebug knows EFI_PERSISTENT_MEMORY_TYPE while 'efi mem' prints it a=
s
> > > '<invalid>', and neither table knows EFI_UNACCEPTED_MEMORY_TYPE.
> > >
> > > Move a single copy of both tables into efi_common.c, which is already
> > > linked into both commands, and provide efi_mem_type_name() and
> > > efi_print_mem_attrs() accessors. Add the two missing memory types.
> > >
> > > The output of 'efi mem' now uses the same names as efidebug, for
> > > example PAL instead of pal_code, and its attributes key now lists the
> > > attribute mnemonics instead of long names. The efidebug memmap name
> > > ACPI RECLAIM MEM becomes ACPI RECLAIM so that the shared name also fi=
ts
> > > the narrower column of 'efi mem'. Update the examples in the efi
> > > command documentation accordingly.
> > >
> > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > > ---
> > >   cmd/efi.c             |  53 +---------
> > >   cmd/efi_common.c      |  64 ++++++++++++
> > >   cmd/efidebug.c        |  69 +-----------
> > >   doc/usage/cmd/efi.rst | 238 +++++++++++++++++++++------------------=
---
> > >   include/efi.h         |  19 ++++
> > >   5 files changed, 207 insertions(+), 236 deletions(-)
> > >
>
> Firstly thanks for looking at this. I am just adding a few comments in
> response to Heinrich.
>
> > > diff --git a/cmd/efi.c b/cmd/efi.c
> > > index 687ccb52042..fc8f1d511c0 100644
> > > --- a/cmd/efi.c
> > > +++ b/cmd/efi.c
> > > @@ -16,42 +16,6 @@
> > >
> > >   DECLARE_GLOBAL_DATA_PTR;
> > >
> > > -static const char *const type_name[] =3D {
> > > -     "reserved",
> > > -     "loader_code",
> > > -     "loader_data",
> > > -     "bs_code",
> > > -     "bs_data",
> > > -     "rt_code",
> > > -     "rt_data",
> > > -     "conv",
> > > -     "unusable",
> > > -     "acpi_reclaim",
> > > -     "acpi_nvs",
> > > -     "io",
> > > -     "io_port",
> > > -     "pal_code",
> > > -};
> > > -
> > > -static struct attr_info {
> > > -     u64 val;
> > > -     const char *name;
> > > -} mem_attr[] =3D {
> > > -     { EFI_MEMORY_UC, "uncached" },
> > > -     { EFI_MEMORY_WC, "write-coalescing" },
> > > -     { EFI_MEMORY_WT, "write-through" },
> > > -     { EFI_MEMORY_WB, "write-back" },
> > > -     { EFI_MEMORY_UCE, "uncached & exported" },
> > > -     { EFI_MEMORY_WP, "write-protect" },
> > > -     { EFI_MEMORY_RP, "read-protect" },
> > > -     { EFI_MEMORY_XP, "execute-protect" },
> > > -     { EFI_MEMORY_NV, "non-volatile" },
> > > -     { EFI_MEMORY_MORE_RELIABLE, "higher reliability" },
> > > -     { EFI_MEMORY_RO, "read-only" },
> > > -     { EFI_MEMORY_SP, "specific purpose" },
> > > -     { EFI_MEMORY_RUNTIME, "needs runtime mapping" }
> > > -};
> > > -
> > >   /* Maximum different attribute values we can track */
> > >   #define ATTR_SEEN_MAX       30
> > >
> > > @@ -175,8 +139,7 @@ static void efi_print_mem_table(struct efi_mem_de=
sc *desc, int desc_size,
> > >               }
> > >               size =3D desc->num_pages << EFI_PAGE_SHIFT;
> > >
> > > -             name =3D desc->type < ARRAY_SIZE(type_name) ?
> > > -                             type_name[desc->type] : "<invalid>";
> > > +             name =3D efi_mem_type_name(desc->type) ?: "<invalid>";
> > >               printf("%2d  %x:%-12s  %010llx  %010llx  %010llx  ", up=
to,
> > >                      desc->type, name, desc->physical_start,
> > >                      desc->virtual_start, size);
> > > @@ -197,20 +160,10 @@ static void efi_print_mem_table(struct efi_mem_=
desc *desc, int desc_size,
> > >       printf("\nAttributes key:\n");
> > >       for (i =3D 0; i < attr_seen_count; i++) {
> > >               u64 attr =3D attr_seen[i];
> > > -             bool first;
> > > -             int j;
> > >
> > > -             printf("%c%llx: ", (attr & EFI_MEMORY_RUNTIME) ? 'r' : =
' ',
> > > +             printf("%c%llx:", (attr & EFI_MEMORY_RUNTIME) ? 'r' : '=
 ',
> > >                      attr & ~EFI_MEMORY_RUNTIME);
> > > -             for (j =3D 0, first =3D true; j < ARRAY_SIZE(mem_attr);=
 j++) {
> > > -                     if (attr & mem_attr[j].val) {
> > > -                             if (first)
> > > -                                     first =3D false;
> > > -                             else
> > > -                                     printf(", ");
> > > -                             printf("%s", mem_attr[j].name);
> > > -                     }
> > > -             }
> > > +             efi_print_mem_attrs(attr);
> > >               putc('\n');
> > >       }
> > >       if (skip_bs)
> > > diff --git a/cmd/efi_common.c b/cmd/efi_common.c
> > > index d2f2b59e9e3..8df2369add6 100644
> > > --- a/cmd/efi_common.c
> > > +++ b/cmd/efi_common.c
> > > @@ -10,6 +10,46 @@
> > >   #include <efi_api.h>
> > >   #include <u-boot/uuid.h>
> > >
> > > +static const char *const efi_mem_type_string[] =3D {
> > > +     [EFI_RESERVED_MEMORY_TYPE] =3D "RESERVED",
> > > +     [EFI_LOADER_CODE] =3D "LOADER CODE",
> > > +     [EFI_LOADER_DATA] =3D "LOADER DATA",
> > > +     [EFI_BOOT_SERVICES_CODE] =3D "BOOT CODE",
> > > +     [EFI_BOOT_SERVICES_DATA] =3D "BOOT DATA",
> > > +     [EFI_RUNTIME_SERVICES_CODE] =3D "RUNTIME CODE",
> > > +     [EFI_RUNTIME_SERVICES_DATA] =3D "RUNTIME DATA",
> > > +     [EFI_CONVENTIONAL_MEMORY] =3D "CONVENTIONAL",
> > > +     [EFI_UNUSABLE_MEMORY] =3D "UNUSABLE MEM",
> > > +     [EFI_ACPI_RECLAIM_MEMORY] =3D "ACPI RECLAIM",
> > > +     [EFI_ACPI_MEMORY_NVS] =3D "ACPI NVS",
> > > +     [EFI_MMAP_IO] =3D "IO",
> > > +     [EFI_MMAP_IO_PORT] =3D "IO PORT",
> > > +     [EFI_PAL_CODE] =3D "PAL",
> > > +     [EFI_PERSISTENT_MEMORY_TYPE] =3D "PERSISTENT",
> > > +     [EFI_UNACCEPTED_MEMORY_TYPE] =3D "UNACCEPTED",
> >
> > Thank you for looking into code deduplication.
> >
> > Do we want to keep the strict upper casing?
> >
> > These are the strings from the EFI spec:
> >
> > EfiReservedMemoryType
> > EfiLoaderCode
> > EfiLoaderData
> > EfiBootServicesCode
> > EfiBootServicesData
> > EfiRuntimeServicesCode
> > EfiRuntimeServicesData
> > EfiConventionalMemory
> > EfiUnusableMemory
> > EfiACPIReclaimMemory
> > EfiACPIMemoryNVS
> > EfiMemoryMappedIO
> > EfiMemoryMappedIOPortSpace
> > EfiPalCode
> > EfiPersistentMemory
> > EfiUnacceptedMemoryType
> >
> > Should we use excacly these strings after stripping the leading 'Efi'
> > and trailing 'Type'?
>
> I don't like capital letters for reading, nor saying memory in come
> cases and not in others. So I suggest 'runtime-data', 'persistent' and
> so on. But what you propose Heinrich could be a good compromise.

Got it, I will go with the spec names stripped of the leading 'Efi'
and the trailing 'Type' in v2:

ReservedMemory, LoaderCode, LoaderData, BootServicesCode,
BootServicesData, RuntimeServicesCode, RuntimeServicesData,
ConventionalMemory, UnusableMemory, ACPIReclaimMemory, ACPIMemoryNVS,
MemoryMappedIO, MemoryMappedIOPortSpace, PalCode, PersistentMemory,
UnacceptedMemory

>
> >
> > > +};
> > > +
> > > +static const struct efi_mem_attrs {
> > > +     const u64 bit;
> > > +     const char *text;
> > > +} efi_mem_attrs[] =3D {
> > > +     {EFI_MEMORY_UC, "UC"},
> > > +     {EFI_MEMORY_WC, "WC"},
> > > +     {EFI_MEMORY_WT, "WT"},
> > > +     {EFI_MEMORY_WB, "WB"},
> > > +     {EFI_MEMORY_UCE, "UCE"},
> > > +     {EFI_MEMORY_WP, "WP"},
> > > +     {EFI_MEMORY_RP, "RP"},
> > > +     {EFI_MEMORY_XP, "XP"},
> > > +     {EFI_MEMORY_NV, "NV"},
> > > +     {EFI_MEMORY_MORE_RELIABLE, "REL"},
> > > +     {EFI_MEMORY_RO, "RO"},
> > > +     {EFI_MEMORY_SP, "SP"},
> > > +     {EFI_MEMORY_CPU_CRYPTO, "CRYPT"},
> > > +     {EFI_MEMORY_HOT_PLUGGABLE, "HOTPL"},
> > > +     {EFI_MEMORY_RUNTIME, "RT"},
> > > +};
> > > +
> > >   void efi_show_tables(struct efi_system_table *systab)
> > >   {
> > >       int i;
> > > @@ -21,3 +61,27 @@ void efi_show_tables(struct efi_system_table *syst=
ab)
> > >                      uuid_guid_get_str(tab->guid.b) ?: "(unknown)");
> > >       }
> > >   }
> > > +
> > > +const char *efi_mem_type_name(u32 type)
> > > +{
> > > +     if (type >=3D ARRAY_SIZE(efi_mem_type_string))
> > > +             return NULL;
> > > +
> > > +     return efi_mem_type_string[type];
> > > +}
> > > +
> > > +void efi_print_mem_attrs(u64 attributes)
> > > +{
> > > +     int sep, i;
> > > +
> > > +     for (sep =3D 0, i =3D 0; i < ARRAY_SIZE(efi_mem_attrs); i++)
> > > +             if (attributes & efi_mem_attrs[i].bit) {
> >  > +                    if (sep) {> +                           putc('|=
');
> > > +                     } else {
> > > +                             putc(' ');
> > > +                             sep =3D 1;
> > > +                     }
> > > +                     puts(efi_mem_attrs[i].text);
> >
> > How should we handle invalid bits?
> > How about EFI_MEMORY_ISA_VALID?
> > How about the bits in EFI_MEMORY_ISA_MASK?

In v2 efi_print_mem_attrs() will:
* add EFI_MEMORY_ISA_VALID to the mnemonic table,
* when ISA_VALID is set, print the EFI_MEMORY_ISA_MASK field as
ISA=3D0x<value> instead of decoding bits U-Boot cannot interpret,
* print any remaining bits that match neither the table nor the ISA
field as a trailing hex value, so unknown or invalid attributes are
never silently dropped.

> >
> > > +             }
> > > +}
> > > diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> > > index a6faa36b500..7d0c56ce265 100644
> > > --- a/cmd/efidebug.c
> > > +++ b/cmd/efidebug.c
> > > @@ -574,68 +574,6 @@ static int do_efi_show_ecpt(struct cmd_tbl *cmdt=
p, int flag, int argc,
> > >   }
> > >   #endif /* CONFIG_IS_ENABLED(EFI_ECPT) */
> > >
> > > -static const char * const efi_mem_type_string[] =3D {
> > > -     [EFI_RESERVED_MEMORY_TYPE] =3D "RESERVED",
> > > -     [EFI_LOADER_CODE] =3D "LOADER CODE",
> > > -     [EFI_LOADER_DATA] =3D "LOADER DATA",
> > > -     [EFI_BOOT_SERVICES_CODE] =3D "BOOT CODE",
> > > -     [EFI_BOOT_SERVICES_DATA] =3D "BOOT DATA",
> > > -     [EFI_RUNTIME_SERVICES_CODE] =3D "RUNTIME CODE",
> > > -     [EFI_RUNTIME_SERVICES_DATA] =3D "RUNTIME DATA",
> > > -     [EFI_CONVENTIONAL_MEMORY] =3D "CONVENTIONAL",
> > > -     [EFI_UNUSABLE_MEMORY] =3D "UNUSABLE MEM",
> > > -     [EFI_ACPI_RECLAIM_MEMORY] =3D "ACPI RECLAIM MEM",
> > > -     [EFI_ACPI_MEMORY_NVS] =3D "ACPI NVS",
> > > -     [EFI_MMAP_IO] =3D "IO",
> > > -     [EFI_MMAP_IO_PORT] =3D "IO PORT",
> > > -     [EFI_PAL_CODE] =3D "PAL",
> > > -     [EFI_PERSISTENT_MEMORY_TYPE] =3D "PERSISTENT",
> > > -};
> > > -
> > > -static const struct efi_mem_attrs {
> > > -     const u64 bit;
> > > -     const char *text;
> > > -} efi_mem_attrs[] =3D {
> > > -     {EFI_MEMORY_UC, "UC"},
> > > -     {EFI_MEMORY_WC, "WC"},
> > > -     {EFI_MEMORY_WT, "WT"},
> > > -     {EFI_MEMORY_WB, "WB"},
> > > -     {EFI_MEMORY_UCE, "UCE"},
> > > -     {EFI_MEMORY_WP, "WP"},
> > > -     {EFI_MEMORY_RP, "RP"},
> > > -     {EFI_MEMORY_XP, "XP"},
> > > -     {EFI_MEMORY_NV, "NV"},
> > > -     {EFI_MEMORY_MORE_RELIABLE, "REL"},
> > > -     {EFI_MEMORY_RO, "RO"},
> > > -     {EFI_MEMORY_SP, "SP"},
> > > -     {EFI_MEMORY_CPU_CRYPTO, "CRYPT"},
> > > -     {EFI_MEMORY_HOT_PLUGGABLE, "HOTPL"},
> > > -     {EFI_MEMORY_RUNTIME, "RT"},
> > > -};
> > > -
> > > -/**
> > > - * print_memory_attributes() - print memory map attributes
> > > - *
> > > - * @attributes:      Attribute value
> > > - *
> > > - * Print memory map attributes
> > > - */
> > > -static void print_memory_attributes(u64 attributes)
> > > -{
> > > -     int sep, i;
> > > -
> > > -     for (sep =3D 0, i =3D 0; i < ARRAY_SIZE(efi_mem_attrs); i++)
> > > -             if (attributes & efi_mem_attrs[i].bit) {
> > > -                     if (sep) {
> > > -                             putc('|');
> > > -                     } else {
> > > -                             putc(' ');
> > > -                             sep =3D 1;
> > > -                     }
> > > -                     puts(efi_mem_attrs[i].text);
> > > -             }
> > > -}
> > > -
> > >   #define EFI_PHYS_ADDR_WIDTH (int)(sizeof(efi_physical_addr_t) * 2)
> > >
> > >   /**
> > > @@ -673,10 +611,7 @@ static int do_efi_show_memmap(struct cmd_tbl *cm=
dtp, int flag,
> > >        * populated by allocate_pool() above.
> > >        */
> > >       for (i =3D 0, map =3D memmap; i < map_size / sizeof(*map); map+=
+, i++) {
> > > -             if (map->type < ARRAY_SIZE(efi_mem_type_string))
> > > -                     type =3D efi_mem_type_string[map->type];
> > > -             else
> > > -                     type =3D "(unknown)";
> > > +             type =3D efi_mem_type_name(map->type) ?: "(unknown)";
> > >
> > >               printf("%-16s %.*llx-%.*llx", type,
> > >                      EFI_PHYS_ADDR_WIDTH,
> > > @@ -687,7 +622,7 @@ static int do_efi_show_memmap(struct cmd_tbl *cmd=
tp, int flag,
> > >                                         (map->physical_start +
> > >                                          map->num_pages * EFI_PAGE_SI=
ZE)));
> >
> >
> > Why do we keep both efi_show_memmap() and efi_print_mem_table()?
> > They seem both to be printing the same type of information but in
> > different format.
> >
> > efi_print_mem_table() seems to have bugs as described below. Let's
> > replace it by a common efi_show_memmap() version.

Agreed. I will fix it in v2.

> >
> > >
> > > -             print_memory_attributes(map->attribute);
> > > +             efi_print_mem_attrs(map->attribute);
> > >               putc('\n');
> > >       }
> > >
> > > diff --git a/doc/usage/cmd/efi.rst b/doc/usage/cmd/efi.rst
> > > index b19d36188a9..b8b029f4dd2 100644
> > > --- a/doc/usage/cmd/efi.rst
> > > +++ b/doc/usage/cmd/efi.rst
> > > @@ -74,139 +74,139 @@ Example
> > >       =3D> efi mem
> > >       EFI table at 0, memory map 000000001ad38b60, size 1260, key a79=
, version 1, descr. size 0x30
> > >        #  Type              Physical     Virtual        Size  Attribu=
tes
> > > -     0  7:conv          0000000000  0000000000  00000a0000  f
> > > +     0  7:CONVENTIONAL  0000000000  0000000000  00000a0000  f
> > >           <gap>           00000a0000              0000060000
> > > -     1  7:conv          0000100000  0000000000  0000700000  f
> > > -     2  a:acpi_nvs      0000800000  0000000000  0000008000  f
> > > -     3  7:conv          0000808000  0000000000  0000008000  f
> > > -     4  a:acpi_nvs      0000810000  0000000000  00000f0000  f
> > > -     5  7:conv          0000900000  0000000000  001efef000  f
> > > -     6  6:rt_data       001f8ef000  0000000000  0000100000  rf
> > > -     7  5:rt_code       001f9ef000  0000000000  0000100000  rf
> > > -     8  0:reserved      001faef000  0000000000  0000080000  f
> > > -     9  9:acpi_reclaim  001fb6f000  0000000000  0000010000  f
> > > -    10  a:acpi_nvs      001fb7f000  0000000000  0000080000  f
> > > -    11  7:conv          001fbff000  0000000000  0000359000  f
> > > -    12  6:rt_data       001ff58000  0000000000  0000020000  rf
> > > -    13  a:acpi_nvs      001ff78000  0000000000  0000088000  f
> > > +     1  7:CONVENTIONAL  0000100000  0000000000  0000700000  f
> > > +     2  a:ACPI NVS      0000800000  0000000000  0000008000  f
> > > +     3  7:CONVENTIONAL  0000808000  0000000000  0000008000  f
> > > +     4  a:ACPI NVS      0000810000  0000000000  00000f0000  f
> > > +     5  7:CONVENTIONAL  0000900000  0000000000  001efef000  f
> > > +     6  6:RUNTIME DATA  001f8ef000  0000000000  0000100000  rf
> > > +     7  5:RUNTIME CODE  001f9ef000  0000000000  0000100000  rf
> > > +     8  0:RESERVED      001faef000  0000000000  0000080000  f
> > > +     9  9:ACPI RECLAIM  001fb6f000  0000000000  0000010000  f
> > > +    10  a:ACPI NVS      001fb7f000  0000000000  0000080000  f
> > > +    11  7:CONVENTIONAL  001fbff000  0000000000  0000359000  f
> > > +    12  6:RUNTIME DATA  001ff58000  0000000000  0000020000  rf
> > > +    13  a:ACPI NVS      001ff78000  0000000000  0000088000  f
> > >           <gap>           0020000000              0090000000
> > > -    14  0:reserved      00b0000000  0000000000  0010000000  1
> > > +    14  0:RESERVED      00b0000000  0000000000  0010000000  1
> > >
> > >       Attributes key:
> > > -     f: uncached, write-coalescing, write-through, write-back
> > > -    rf: uncached, write-coalescing, write-through, write-back, needs=
 runtime mapping
> > > -     1: uncached
> > > +     f: UC|WC|WT|WB
> > > +    rf: UC|WC|WT|WB|RT
> > > +     1: UC
> > >       *Some areas are merged (use 'all' to see)
> > >
> > >
> > >       =3D> efi mem  all
> > >       EFI table at 0, memory map 000000001ad38bb0, size 1260, key a79=
, version 1, descr. size 0x30
> > >        #  Type              Physical     Virtual        Size  Attribu=
tes
> >
> > @Simon
> >
> > Here are some issues I see with the output of `efi mem all`. Using the
> > same output as `efidebug memmap` should be adequate.
> >
> > Some headers are right aligned though the values all have the same widt=
h.
> > he header is not even properly aligned to the columns.
> >
>
> Yes it would be good to fix that.
>
> > > -     0  3:bs_code       0000000000  0000000000  0000001000  f
> >
> > Memory is 1:1 mapped before SetVirtualAddressMap().
> > The column for VirtualAddress seems to be superfluous in this output.
>
> True...but if we omit it, we should add something to the docs for the
> command so that people know this.
>
> >
> > EDK II sets the virtual address value to 0 in function CoreAddRange()
> > and asserts that it is 0 in CoreGetMemoryMap().
> >
> > In U-Boot we set VirtualStart =3D=3D PhysicalStart.
> >
> > The UEFI specification provides no guidance here.
> > The value of this field should be ignored before SetVirtualAddress().
> >
> > > -     1  7:conv          0000001000  0000000000  000009f000  f
> > > +     0  3:BOOT CODE     0000000000  0000000000  0000001000  f
> > > +     1  7:CONVENTIONAL  0000001000  0000000000  000009f000  f
> > >           <gap>           00000a0000              0000060000
> >
> > On 64bit systems using 16 digit numbers would be adequate.
>
> 16 hex digits are really hard to read, particularly when the first 6
> or 7 are 0. I wonder if we should invent a printf() formatter to put
> an _ between the two lots of 8 digits? I also tend to prefer no
> leading 0, again due to readability, but this is a matter of taste.
>
> >
> > There seems to be formatting issue with the '<gap>' line.
> >
> > Best regards
> >
> > Heinrich
> >
> >
> > > -     2  7:conv          0000100000  0000000000  0000700000  f
> > > -     3  a:acpi_nvs      0000800000  0000000000  0000008000  f
> > > -     4  7:conv          0000808000  0000000000  0000008000  f
> > > -     5  a:acpi_nvs      0000810000  0000000000  00000f0000  f
> > > -     6  4:bs_data       0000900000  0000000000  0000c00000  f
> > > -     7  7:conv          0001500000  0000000000  000aa36000  f
> > > -     8  2:loader_data   000bf36000  0000000000  0010000000  f
> > > -     9  4:bs_data       001bf36000  0000000000  0000020000  f
> > > -    10  7:conv          001bf56000  0000000000  00021e1000  f
> > > -    11  1:loader_code   001e137000  0000000000  00000c4000  f
> > > -    12  7:conv          001e1fb000  0000000000  000009b000  f
> > > -    13  1:loader_code   001e296000  0000000000  00000e2000  f
> > > -    14  7:conv          001e378000  0000000000  000005b000  f
> > > -    15  4:bs_data       001e3d3000  0000000000  000001e000  f
> > > -    16  7:conv          001e3f1000  0000000000  0000016000  f
> > > -    17  4:bs_data       001e407000  0000000000  0000016000  f
> > > -    18  2:loader_data   001e41d000  0000000000  0000002000  f
> > > -    19  4:bs_data       001e41f000  0000000000  0000828000  f
> > > -    20  3:bs_code       001ec47000  0000000000  0000045000  f
> > > -    21  4:bs_data       001ec8c000  0000000000  0000001000  f
> > > -    22  3:bs_code       001ec8d000  0000000000  000000e000  f
> > > -    23  4:bs_data       001ec9b000  0000000000  0000001000  f
> > > -    24  3:bs_code       001ec9c000  0000000000  000002c000  f
> > > -    25  4:bs_data       001ecc8000  0000000000  0000001000  f
> > > -    26  3:bs_code       001ecc9000  0000000000  000000c000  f
> > > -    27  4:bs_data       001ecd5000  0000000000  0000006000  f
> > > -    28  3:bs_code       001ecdb000  0000000000  0000014000  f
> > > -    29  4:bs_data       001ecef000  0000000000  0000001000  f
> > > -    30  3:bs_code       001ecf0000  0000000000  000005b000  f
> > > -    31  4:bs_data       001ed4b000  0000000000  000000b000  f
> > > -    32  3:bs_code       001ed56000  0000000000  0000024000  f
> > > -    33  4:bs_data       001ed7a000  0000000000  0000006000  f
> > > -    34  3:bs_code       001ed80000  0000000000  0000010000  f
> > > -    35  4:bs_data       001ed90000  0000000000  0000002000  f
> > > -    36  3:bs_code       001ed92000  0000000000  0000025000  f
> > > -    37  4:bs_data       001edb7000  0000000000  0000003000  f
> > > -    38  3:bs_code       001edba000  0000000000  0000011000  f
> > > -    39  4:bs_data       001edcb000  0000000000  0000008000  f
> > > -    40  3:bs_code       001edd3000  0000000000  000002d000  f
> > > -    41  4:bs_data       001ee00000  0000000000  0000201000  f
> > > -    42  3:bs_code       001f001000  0000000000  0000024000  f
> > > -    43  4:bs_data       001f025000  0000000000  0000002000  f
> > > -    44  3:bs_code       001f027000  0000000000  0000009000  f
> > > -    45  4:bs_data       001f030000  0000000000  0000005000  f
> > > -    46  3:bs_code       001f035000  0000000000  000002f000  f
> > > -    47  4:bs_data       001f064000  0000000000  0000001000  f
> > > -    48  3:bs_code       001f065000  0000000000  0000005000  f
> > > -    49  4:bs_data       001f06a000  0000000000  0000005000  f
> > > -    50  3:bs_code       001f06f000  0000000000  0000007000  f
> > > -    51  4:bs_data       001f076000  0000000000  0000007000  f
> > > -    52  3:bs_code       001f07d000  0000000000  000000d000  f
> > > -    53  4:bs_data       001f08a000  0000000000  0000001000  f
> > > -    54  3:bs_code       001f08b000  0000000000  0000006000  f
> > > -    55  4:bs_data       001f091000  0000000000  0000004000  f
> > > -    56  3:bs_code       001f095000  0000000000  000000d000  f
> > > -    57  4:bs_data       001f0a2000  0000000000  0000003000  f
> > > -    58  3:bs_code       001f0a5000  0000000000  0000026000  f
> > > -    59  4:bs_data       001f0cb000  0000000000  0000005000  f
> > > -    60  3:bs_code       001f0d0000  0000000000  0000019000  f
> > > -    61  4:bs_data       001f0e9000  0000000000  0000004000  f
> > > -    62  3:bs_code       001f0ed000  0000000000  0000024000  f
> > > -    63  4:bs_data       001f111000  0000000000  0000008000  f
> > > -    64  3:bs_code       001f119000  0000000000  000000b000  f
> > > -    65  4:bs_data       001f124000  0000000000  0000001000  f
> > > -    66  3:bs_code       001f125000  0000000000  0000002000  f
> > > -    67  4:bs_data       001f127000  0000000000  0000002000  f
> > > -    68  3:bs_code       001f129000  0000000000  0000009000  f
> > > -    69  4:bs_data       001f132000  0000000000  0000003000  f
> > > -    70  3:bs_code       001f135000  0000000000  0000005000  f
> > > -    71  4:bs_data       001f13a000  0000000000  0000003000  f
> > > -    72  3:bs_code       001f13d000  0000000000  0000005000  f
> > > -    73  4:bs_data       001f142000  0000000000  0000003000  f
> > > -    74  3:bs_code       001f145000  0000000000  0000011000  f
> > > -    75  4:bs_data       001f156000  0000000000  000000b000  f
> > > -    76  3:bs_code       001f161000  0000000000  0000009000  f
> > > -    77  4:bs_data       001f16a000  0000000000  0000400000  f
> > > -    78  3:bs_code       001f56a000  0000000000  0000006000  f
> > > -    79  4:bs_data       001f570000  0000000000  0000001000  f
> > > -    80  3:bs_code       001f571000  0000000000  0000001000  f
> > > -    81  4:bs_data       001f572000  0000000000  0000002000  f
> > > -    82  3:bs_code       001f574000  0000000000  0000017000  f
> > > -    83  4:bs_data       001f58b000  0000000000  0000364000  f
> > > -    84  6:rt_data       001f8ef000  0000000000  0000100000  rf
> > > -    85  5:rt_code       001f9ef000  0000000000  0000100000  rf
> > > -    86  0:reserved      001faef000  0000000000  0000080000  f
> > > -    87  9:acpi_reclaim  001fb6f000  0000000000  0000010000  f
> > > -    88  a:acpi_nvs      001fb7f000  0000000000  0000080000  f
> > > -    89  4:bs_data       001fbff000  0000000000  0000201000  f
> > > -    90  7:conv          001fe00000  0000000000  00000e8000  f
> > > -    91  4:bs_data       001fee8000  0000000000  0000020000  f
> > > -    92  3:bs_code       001ff08000  0000000000  0000026000  f
> > > -    93  4:bs_data       001ff2e000  0000000000  0000009000  f
> > > -    94  3:bs_code       001ff37000  0000000000  0000021000  f
> > > -    95  6:rt_data       001ff58000  0000000000  0000020000  rf
> > > -    96  a:acpi_nvs      001ff78000  0000000000  0000088000  f
> > > +     2  7:CONVENTIONAL  0000100000  0000000000  0000700000  f
> > > +     3  a:ACPI NVS      0000800000  0000000000  0000008000  f
> > > +     4  7:CONVENTIONAL  0000808000  0000000000  0000008000  f
> > > +     5  a:ACPI NVS      0000810000  0000000000  00000f0000  f
> > > +     6  4:BOOT DATA     0000900000  0000000000  0000c00000  f
> > > +     7  7:CONVENTIONAL  0001500000  0000000000  000aa36000  f
> > > +     8  2:LOADER DATA   000bf36000  0000000000  0010000000  f
> > > +     9  4:BOOT DATA     001bf36000  0000000000  0000020000  f
> > > +    10  7:CONVENTIONAL  001bf56000  0000000000  00021e1000  f
> > > +    11  1:LOADER CODE   001e137000  0000000000  00000c4000  f
> > > +    12  7:CONVENTIONAL  001e1fb000  0000000000  000009b000  f
> > > +    13  1:LOADER CODE   001e296000  0000000000  00000e2000  f
> > > +    14  7:CONVENTIONAL  001e378000  0000000000  000005b000  f
> > > +    15  4:BOOT DATA     001e3d3000  0000000000  000001e000  f
> > > +    16  7:CONVENTIONAL  001e3f1000  0000000000  0000016000  f
> > > +    17  4:BOOT DATA     001e407000  0000000000  0000016000  f
> > > +    18  2:LOADER DATA   001e41d000  0000000000  0000002000  f
> > > +    19  4:BOOT DATA     001e41f000  0000000000  0000828000  f
> > > +    20  3:BOOT CODE     001ec47000  0000000000  0000045000  f
> > > +    21  4:BOOT DATA     001ec8c000  0000000000  0000001000  f
> > > +    22  3:BOOT CODE     001ec8d000  0000000000  000000e000  f
> > > +    23  4:BOOT DATA     001ec9b000  0000000000  0000001000  f
> > > +    24  3:BOOT CODE     001ec9c000  0000000000  000002c000  f
> > > +    25  4:BOOT DATA     001ecc8000  0000000000  0000001000  f
> > > +    26  3:BOOT CODE     001ecc9000  0000000000  000000c000  f
> > > +    27  4:BOOT DATA     001ecd5000  0000000000  0000006000  f
> > > +    28  3:BOOT CODE     001ecdb000  0000000000  0000014000  f
> > > +    29  4:BOOT DATA     001ecef000  0000000000  0000001000  f
> > > +    30  3:BOOT CODE     001ecf0000  0000000000  000005b000  f
> > > +    31  4:BOOT DATA     001ed4b000  0000000000  000000b000  f
> > > +    32  3:BOOT CODE     001ed56000  0000000000  0000024000  f
> > > +    33  4:BOOT DATA     001ed7a000  0000000000  0000006000  f
> > > +    34  3:BOOT CODE     001ed80000  0000000000  0000010000  f
> > > +    35  4:BOOT DATA     001ed90000  0000000000  0000002000  f
> > > +    36  3:BOOT CODE     001ed92000  0000000000  0000025000  f
> > > +    37  4:BOOT DATA     001edb7000  0000000000  0000003000  f
> > > +    38  3:BOOT CODE     001edba000  0000000000  0000011000  f
> > > +    39  4:BOOT DATA     001edcb000  0000000000  0000008000  f
> > > +    40  3:BOOT CODE     001edd3000  0000000000  000002d000  f
> > > +    41  4:BOOT DATA     001ee00000  0000000000  0000201000  f
> > > +    42  3:BOOT CODE     001f001000  0000000000  0000024000  f
> > > +    43  4:BOOT DATA     001f025000  0000000000  0000002000  f
> > > +    44  3:BOOT CODE     001f027000  0000000000  0000009000  f
> > > +    45  4:BOOT DATA     001f030000  0000000000  0000005000  f
> > > +    46  3:BOOT CODE     001f035000  0000000000  000002f000  f
> > > +    47  4:BOOT DATA     001f064000  0000000000  0000001000  f
> > > +    48  3:BOOT CODE     001f065000  0000000000  0000005000  f
> > > +    49  4:BOOT DATA     001f06a000  0000000000  0000005000  f
> > > +    50  3:BOOT CODE     001f06f000  0000000000  0000007000  f
> > > +    51  4:BOOT DATA     001f076000  0000000000  0000007000  f
> > > +    52  3:BOOT CODE     001f07d000  0000000000  000000d000  f
> > > +    53  4:BOOT DATA     001f08a000  0000000000  0000001000  f
> > > +    54  3:BOOT CODE     001f08b000  0000000000  0000006000  f
> > > +    55  4:BOOT DATA     001f091000  0000000000  0000004000  f
> > > +    56  3:BOOT CODE     001f095000  0000000000  000000d000  f
> > > +    57  4:BOOT DATA     001f0a2000  0000000000  0000003000  f
> > > +    58  3:BOOT CODE     001f0a5000  0000000000  0000026000  f
> > > +    59  4:BOOT DATA     001f0cb000  0000000000  0000005000  f
> > > +    60  3:BOOT CODE     001f0d0000  0000000000  0000019000  f
> > > +    61  4:BOOT DATA     001f0e9000  0000000000  0000004000  f
> > > +    62  3:BOOT CODE     001f0ed000  0000000000  0000024000  f
> > > +    63  4:BOOT DATA     001f111000  0000000000  0000008000  f
> > > +    64  3:BOOT CODE     001f119000  0000000000  000000b000  f
> > > +    65  4:BOOT DATA     001f124000  0000000000  0000001000  f
> > > +    66  3:BOOT CODE     001f125000  0000000000  0000002000  f
> > > +    67  4:BOOT DATA     001f127000  0000000000  0000002000  f
> > > +    68  3:BOOT CODE     001f129000  0000000000  0000009000  f
> > > +    69  4:BOOT DATA     001f132000  0000000000  0000003000  f
> > > +    70  3:BOOT CODE     001f135000  0000000000  0000005000  f
> > > +    71  4:BOOT DATA     001f13a000  0000000000  0000003000  f
> > > +    72  3:BOOT CODE     001f13d000  0000000000  0000005000  f
> > > +    73  4:BOOT DATA     001f142000  0000000000  0000003000  f
> > > +    74  3:BOOT CODE     001f145000  0000000000  0000011000  f
> > > +    75  4:BOOT DATA     001f156000  0000000000  000000b000  f
> > > +    76  3:BOOT CODE     001f161000  0000000000  0000009000  f
> > > +    77  4:BOOT DATA     001f16a000  0000000000  0000400000  f
> > > +    78  3:BOOT CODE     001f56a000  0000000000  0000006000  f
> > > +    79  4:BOOT DATA     001f570000  0000000000  0000001000  f
> > > +    80  3:BOOT CODE     001f571000  0000000000  0000001000  f
> > > +    81  4:BOOT DATA     001f572000  0000000000  0000002000  f
> > > +    82  3:BOOT CODE     001f574000  0000000000  0000017000  f
> > > +    83  4:BOOT DATA     001f58b000  0000000000  0000364000  f
> > > +    84  6:RUNTIME DATA  001f8ef000  0000000000  0000100000  rf
> > > +    85  5:RUNTIME CODE  001f9ef000  0000000000  0000100000  rf
> > > +    86  0:RESERVED      001faef000  0000000000  0000080000  f
> > > +    87  9:ACPI RECLAIM  001fb6f000  0000000000  0000010000  f
> > > +    88  a:ACPI NVS      001fb7f000  0000000000  0000080000  f
> > > +    89  4:BOOT DATA     001fbff000  0000000000  0000201000  f
> > > +    90  7:CONVENTIONAL  001fe00000  0000000000  00000e8000  f
> > > +    91  4:BOOT DATA     001fee8000  0000000000  0000020000  f
> > > +    92  3:BOOT CODE     001ff08000  0000000000  0000026000  f
> > > +    93  4:BOOT DATA     001ff2e000  0000000000  0000009000  f
> > > +    94  3:BOOT CODE     001ff37000  0000000000  0000021000  f
> > > +    95  6:RUNTIME DATA  001ff58000  0000000000  0000020000  rf
> > > +    96  a:ACPI NVS      001ff78000  0000000000  0000088000  f
> > >           <gap>           0020000000              0090000000
> > > -    97  0:reserved      00b0000000  0000000000  0010000000  1
> > > +    97  0:RESERVED      00b0000000  0000000000  0010000000  1
> > >
> > >       Attributes key:
> > > -     f: uncached, write-coalescing, write-through, write-back
> > > -    rf: uncached, write-coalescing, write-through, write-back, needs=
 runtime mapping
> > > -     1: uncached
> > > +     f: UC|WC|WT|WB
> > > +    rf: UC|WC|WT|WB|RT
> > > +     1: UC
> > >
> > >
> > >       =3D> efi tables
> > > diff --git a/include/efi.h b/include/efi.h
> > > index b98871fedad..079ceae1eb1 100644
> > > --- a/include/efi.h
> > > +++ b/include/efi.h
> > > @@ -681,6 +681,25 @@ int efi_get_mmap(struct efi_mem_desc **descp, in=
t *sizep, uint *keyp,
> > >    */
> > >   void efi_show_tables(struct efi_system_table *systab);
> > >
> > > +/**
> > > + * efi_mem_type_name() - get the name of an EFI memory type
> > > + *
> > > + * @type: memory type (enum efi_memory_type)
> > > + * Return: name of the memory type, or NULL if @type is unknown
> > > + */
> > > +const char *efi_mem_type_name(u32 type);
> > > +
> > > +/**
> > > + * efi_print_mem_attrs() - print the names of set EFI memory attribu=
tes
> > > + *
> > > + * Prints the set attribute bits as a '|'-separated list of names, e=
.g.
> > > + * ' UC|WB|RT', preceded by a space. Prints nothing if no known attr=
ibute
> > > + * bit is set.
> > > + *
> > > + * @attributes: memory attributes (EFI_MEMORY_...)
> > > + */
> > > +void efi_print_mem_attrs(u64 attributes);
> > > +
> > >   /**
> > >    * efi_get_basename() - Get the default filename to use when loadin=
g
> > >    *
> >

Best regards,
Aristo
