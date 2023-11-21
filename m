Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83466C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F61875F4;
	Tue, 21 Nov 2023 03:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HG+gxkTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D46FD869F6; Tue, 21 Nov 2023 03:17:30 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EC03875EA
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5b383b4184fso55875687b3.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700533043; x=1701137843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hVn2JLmIEwvSWyOhDrTuvpKhn19gqc24bWJ9f3b8YS4=;
 b=HG+gxkTcAR2MaQM/6RILJHMJlUPbpywexUCnOoraX3NfBjeaWD3B/EwPv+rIeOYt9i
 NGIX5BoDb2K680W1VTsSz6hQmIU8tydeT8NlYkm/dlu/0ou9vEnycvsBNIK4w8lSY2hE
 jll7zwCFclxbgjhe7rQUxbqcQ/uPlDeKzbLAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700533043; x=1701137843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hVn2JLmIEwvSWyOhDrTuvpKhn19gqc24bWJ9f3b8YS4=;
 b=AKwwmE8MFfDXs3QtQf5KwA2Fjza08EiQYCfSnrZyJwJq1K2tkOtujib7AS8KqL4HeI
 luackntis0OXyvqq8Fjmwt9rvExGql7Ur5vXytAF0P/XIQ8NrAr/r/GLEy6vTUO0utf0
 LMgWcc7s46mf9SCh8q7YXkCE++hp1i/PFA3YY4ZHsEsEy3PVv+G5HH3LoyGBVz1XTPRG
 cJPwZQQrZZ++Nt5S0IY5uKJrQjgA29WJQDLjm40wyxDtQY5sfdNM/l6lmpUbHd0/uvKx
 xrCtAtBhpv6WttGOAtOzQIL9J7p1eAKYP1ODq1wAmwLgRspnVgDFTfysPgvrTZDfnzuT
 KaBg==
X-Gm-Message-State: AOJu0Ywleb3tU03x5c7e7rds5oko3g/lntbIFvi9GYr23Rqk8W/Vbtjl
 Zb2ZN+yGv/WG9icMa4+wtiCW4HIFf+1+0rMGYnX3Qg==
X-Google-Smtp-Source: AGHT+IEQHjm2VtbIxRNHeb1Ff1o/SA4GhDggP9DHPoBZOTaBNwMb7rIKxDEJFTR3CX9mI1P7xHYW/+FCBrrV7bgQCyo=
X-Received: by 2002:a25:2fc2:0:b0:d78:26a0:ab8b with SMTP id
 v185-20020a252fc2000000b00d7826a0ab8bmr8664947ybv.55.1700533042962; Mon, 20
 Nov 2023 18:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-4-sjg@chromium.org>
 <4ba6fd96-d4aa-45bc-be9d-cb8689606596@gmx.de>
In-Reply-To: <4ba6fd96-d4aa-45bc-be9d-cb8689606596@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Nov 2023 19:16:28 -0700
Message-ID: <CAPnjgZ2QWbVm-=8+E5Yv2ekdWjZ2E1VeS1TJD9rnNUfa+dhrYA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] smbios: Use SMBIOS 3.0 to support an address above
 4GB
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Mon, 20 Nov 2023 at 19:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/15/23 04:45, Simon Glass wrote:
> > When the SMBIOS table is written to an address above 4GB a 32-bit table
> > address is not large enough.
> >
> > Use an SMBIOS3 table in that case.
> >
> > Note that we cannot use efi_allocate_pages() since this function has
> > nothing to do with EFI. There is no equivalent function to allocate
> > memory below 4GB in U-Boot. One solution would be to create a separate
> > malloc() pool, or just always put the malloc() pool below 4GB.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Check the end of the table rather than the start.
> >
> >   include/smbios.h | 22 +++++++++++++++++++++-
> >   lib/smbios.c     | 24 +++++++++++++++++++-----
> >   2 files changed, 40 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/smbios.h b/include/smbios.h
> > index c9df2706f5a6..ddabb558299e 100644
> > --- a/include/smbios.h
> > +++ b/include/smbios.h
> > @@ -12,7 +12,8 @@
> >
> >   /* SMBIOS spec version implemented */
> >   #define SMBIOS_MAJOR_VER    3
> > -#define SMBIOS_MINOR_VER     0
> > +#define SMBIOS_MINOR_VER     7
> > +
> >
> >   enum {
> >       SMBIOS_STR_MAX  = 64,   /* Maximum length allowed for a string */
> > @@ -54,6 +55,25 @@ struct __packed smbios_entry {
> >       u8 bcd_rev;
> >   };
> >
> > +struct __packed smbios3_entry {
> > +     u8 anchor[5];
> > +     u8 checksum;
> > +     u8 length;
> > +     u8 major_ver;
> > +
> > +     u8 minor_ver;
> > +     u8 docrev;
> > +     u8 entry_point_rev;
> > +     u8 reserved;
> > +     u32 max_struct_size;
> > +
> > +     u64 struct_table_address;
> > +};
> > +
> > +/* These two structures should use the same amount of 16-byte-aligned space */
> > +static_assert(ALIGN(16, sizeof(struct smbios_entry)) ==
> > +           ALIGN(16, sizeof(struct smbios3_entry)));
> > +
> >   /* BIOS characteristics */
> >   #define BIOS_CHARACTERISTICS_PCI_SUPPORTED  (1 << 7)
> >   #define BIOS_CHARACTERISTICS_UPGRADEABLE    (1 << 11)
> > diff --git a/lib/smbios.c b/lib/smbios.c
> > index c7a557bc9b7b..92e98388084f 100644
> > --- a/lib/smbios.c
> > +++ b/lib/smbios.c
> > @@ -487,7 +487,11 @@ ulong write_smbios_table(ulong addr)
> >       addr = ALIGN(addr, 16);
> >       start_addr = addr;
> >
> > -     addr += sizeof(struct smbios_entry);
> > +     /*
> > +      * So far we don't know which struct will be used, but they both end
> > +      * up using the same amount of 16-bit-aligned space
> > +      */
> > +     addr += max(sizeof(struct smbios_entry), sizeof(struct smbios3_entry));
> >       addr = ALIGN(addr, 16);
> >       tables = addr;
> >
> > @@ -512,14 +516,24 @@ ulong write_smbios_table(ulong addr)
> >        * sandbox's DRAM buffer.
> >        */
> >       table_addr = (ulong)map_sysmem(tables, 0);
> > -     if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulong)UINT_MAX) {
> > +     if (sizeof(table_addr) > sizeof(u32) && addr >= (ulong)UINT_MAX) {
>
> You have to check the end of the the last SMBIOS structure not the start
> of the first SMBIOS structure against UINT_MAX.
>
> > +             struct smbios3_entry *se;
> >               /*
> >                * We need to put this >32-bit pointer into the table but the
> >                * field is only 32 bits wide.
> >                */
> > -             printf("WARNING: SMBIOS table_address overflow %llx\n",
> > -                    (unsigned long long)table_addr);
> > -             addr = 0;
> > +             printf("WARNING: Using SMBIOS3.0 due to table-address overflow %lx\n",
> > +                    table_addr);
>
> This should be log_debug().
>
> > +             se = map_sysmem(start_addr, sizeof(struct smbios_entry));
> > +             memset(se, '\0', sizeof(struct smbios_entry));
> > +             memcpy(se->anchor, "_SM3_", 5);
> > +             se->length = sizeof(struct smbios3_entry);
> > +             se->major_ver = SMBIOS_MAJOR_VER;
> > +             se->minor_ver = SMBIOS_MINOR_VER;
> > +             se->docrev = 0;
> > +             se->entry_point_rev = 1;
> > +             se->max_struct_size = len;
> > +             se->struct_table_address = table_addr;
>
> You must fill the checksum:
>
> se->checksum = table_compute_checksum(se, sizeof(struct smbios3_entry));
>
> With the checksum filled I can use dmidecode in Linux based on the
> SMBIOS3 table:
>
> ubuntu@ubuntu:~$ sudo dmidecode
> # dmidecode 3.5
> # SMBIOS3 entry point at 0x27ef53000
> Found SMBIOS entry point in EFI, reading table from /dev/mem.
> SMBIOS 3.7.0 present.
> # SMBIOS implementations newer than version 3.5.0 are not
> # fully supported by this version of dmidecode.
> Table at 0x27EF53020.
>
> Handle 0x0000, DMI type 0, 24 bytes
> BIOS Information
>          Vendor: U-Boot

OK, great, thank you for figuring this out. Do you think this might be
a reasonable solution for -next ?

Regards,
Simon
