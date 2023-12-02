Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F2CC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8730B87766;
	Sat,  2 Dec 2023 19:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PHfdrK9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB60C876F8; Sat,  2 Dec 2023 19:28:52 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 884B5876B2
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-54c5ed26cf6so2221078a12.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541728; x=1702146528; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4bHima4txpVBFmOB2/cH67MdV3wmjmFLf9cQYDf5/sA=;
 b=PHfdrK9GfaoKkCuexWk9mX1JN59AcA3TLtNJ450xkfuEmduLPeXPV27Pv1Zs5Cs7UC
 9sIhnPqujjz90CptIrN1cz/Nsjy/hmZN4BifucZzGSkqn4thTajUOFvgUrI5itXZJNS6
 A55W7gBl5U8B3e1DR5cDoRLGAkYjlgaXi+4tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541728; x=1702146528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4bHima4txpVBFmOB2/cH67MdV3wmjmFLf9cQYDf5/sA=;
 b=PPBlnnzY+ZFciJ+l3PnZVqnMU8/Phxg9Q7hujfBWtGq5wAYtpgzCs8SsT8koODfLvc
 QwJOtsg8/pwXc6ELMwtuHnBwm5biPVV/Gq62WNYbze+2ciXre/BQ/SKr91rEQFIqRtUf
 RfP6JT7oNAM+53x8gFaIU/c1KiwR2U3OhY7gS05hh6D/e9iADWLoyPc8q+115VGGZdJQ
 w/rz2Dzf90+w0+sUDPDs0UASKbWhjGBopjfx32BPUDA3Yxf3fgpUAqECLh9UxVmb2Mdq
 iuKdAwsVlJvxYgUbOMtF2B2QU5dh1zwFE8fr57VTKjMSaszSdBOXY4NduOT6/Sh43nEN
 aJ5w==
X-Gm-Message-State: AOJu0YwVCtI4NC6HW2OEehD+dhfWyLVmfKwQUOonkzb75f568O9LoLDV
 xjsYuXjGLl+oRX7e5jN/JoESkEEbLH3BnSkoDRHujQ==
X-Google-Smtp-Source: AGHT+IGdW7myCdSKHjzdmcDdyvNFelOq5+smg7n/yvNHNsCI+TAdFO0mHFHDq04Ahfp0K6WbD+IIpVGMR3Kev4hNvLE=
X-Received: by 2002:a17:906:fa0d:b0:a19:a19b:55d1 with SMTP id
 lo13-20020a170906fa0d00b00a19a19b55d1mr1802788ejb.97.1701541727718; Sat, 02
 Dec 2023 10:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-4-sjg@chromium.org>
 <4ba6fd96-d4aa-45bc-be9d-cb8689606596@gmx.de>
 <CAPnjgZ2QWbVm-=8+E5Yv2ekdWjZ2E1VeS1TJD9rnNUfa+dhrYA@mail.gmail.com>
 <CAC_iWj+7FCrAYt1z1=9o8+6uxYiqG++nc72-XHYiHDtP6Uag0w@mail.gmail.com>
 <20231121204906.GL2513409@bill-the-cat>
In-Reply-To: <20231121204906.GL2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:27:15 -0700
Message-ID: <CAPnjgZ0hXjoxiiQwv8_fF0brYTWpFS3baWVn4H3hoOGAOnPC3w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] smbios: Use SMBIOS 3.0 to support an address above
 4GB
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

On Tue, 21 Nov 2023 at 13:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 21, 2023 at 10:40:39PM +0200, Ilias Apalodimas wrote:
> > Hi Simon
> >
> > On Tue, 21 Nov 2023 at 04:17, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Heinrich,
> > >
> > > On Mon, 20 Nov 2023 at 19:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > On 10/15/23 04:45, Simon Glass wrote:
> > > > > When the SMBIOS table is written to an address above 4GB a 32-bit table
> > > > > address is not large enough.
> > > > >
> > > > > Use an SMBIOS3 table in that case.
> > > > >
> > > > > Note that we cannot use efi_allocate_pages() since this function has
> > > > > nothing to do with EFI. There is no equivalent function to allocate
> > > > > memory below 4GB in U-Boot. One solution would be to create a separate
> > > > > malloc() pool, or just always put the malloc() pool below 4GB.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Check the end of the table rather than the start.
> > > > >
> > > > >   include/smbios.h | 22 +++++++++++++++++++++-
> > > > >   lib/smbios.c     | 24 +++++++++++++++++++-----
> > > > >   2 files changed, 40 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/include/smbios.h b/include/smbios.h
> > > > > index c9df2706f5a6..ddabb558299e 100644
> > > > > --- a/include/smbios.h
> > > > > +++ b/include/smbios.h
> > > > > @@ -12,7 +12,8 @@
> > > > >
> > > > >   /* SMBIOS spec version implemented */
> > > > >   #define SMBIOS_MAJOR_VER    3
> > > > > -#define SMBIOS_MINOR_VER     0
> > > > > +#define SMBIOS_MINOR_VER     7
> > > > > +
> > > > >
> > > > >   enum {
> > > > >       SMBIOS_STR_MAX  = 64,   /* Maximum length allowed for a string */
> > > > > @@ -54,6 +55,25 @@ struct __packed smbios_entry {
> > > > >       u8 bcd_rev;
> > > > >   };
> > > > >
> > > > > +struct __packed smbios3_entry {
> > > > > +     u8 anchor[5];
> > > > > +     u8 checksum;
> > > > > +     u8 length;
> > > > > +     u8 major_ver;
> > > > > +
> > > > > +     u8 minor_ver;
> > > > > +     u8 docrev;
> > > > > +     u8 entry_point_rev;
> > > > > +     u8 reserved;
> > > > > +     u32 max_struct_size;
> > > > > +
> > > > > +     u64 struct_table_address;
> > > > > +};
> > > > > +
> > > > > +/* These two structures should use the same amount of 16-byte-aligned space */
> > > > > +static_assert(ALIGN(16, sizeof(struct smbios_entry)) ==
> > > > > +           ALIGN(16, sizeof(struct smbios3_entry)));
> > > > > +
> > > > >   /* BIOS characteristics */
> > > > >   #define BIOS_CHARACTERISTICS_PCI_SUPPORTED  (1 << 7)
> > > > >   #define BIOS_CHARACTERISTICS_UPGRADEABLE    (1 << 11)
> > > > > diff --git a/lib/smbios.c b/lib/smbios.c
> > > > > index c7a557bc9b7b..92e98388084f 100644
> > > > > --- a/lib/smbios.c
> > > > > +++ b/lib/smbios.c
> > > > > @@ -487,7 +487,11 @@ ulong write_smbios_table(ulong addr)
> > > > >       addr = ALIGN(addr, 16);
> > > > >       start_addr = addr;
> > > > >
> > > > > -     addr += sizeof(struct smbios_entry);
> > > > > +     /*
> > > > > +      * So far we don't know which struct will be used, but they both end
> > > > > +      * up using the same amount of 16-bit-aligned space
> > > > > +      */
> > > > > +     addr += max(sizeof(struct smbios_entry), sizeof(struct smbios3_entry));
> > > > >       addr = ALIGN(addr, 16);
> > > > >       tables = addr;
> > > > >
> > > > > @@ -512,14 +516,24 @@ ulong write_smbios_table(ulong addr)
> > > > >        * sandbox's DRAM buffer.
> > > > >        */
> > > > >       table_addr = (ulong)map_sysmem(tables, 0);
> > > > > -     if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulong)UINT_MAX) {
> > > > > +     if (sizeof(table_addr) > sizeof(u32) && addr >= (ulong)UINT_MAX) {
> > > >
> > > > You have to check the end of the the last SMBIOS structure not the start
> > > > of the first SMBIOS structure against UINT_MAX.
> > > >
> > > > > +             struct smbios3_entry *se;
> > > > >               /*
> > > > >                * We need to put this >32-bit pointer into the table but the
> > > > >                * field is only 32 bits wide.
> > > > >                */
> > > > > -             printf("WARNING: SMBIOS table_address overflow %llx\n",
> > > > > -                    (unsigned long long)table_addr);
> > > > > -             addr = 0;
> > > > > +             printf("WARNING: Using SMBIOS3.0 due to table-address overflow %lx\n",
> > > > > +                    table_addr);
> > > >
> > > > This should be log_debug().
> > > >
> > > > > +             se = map_sysmem(start_addr, sizeof(struct smbios_entry));
> > > > > +             memset(se, '\0', sizeof(struct smbios_entry));
> > > > > +             memcpy(se->anchor, "_SM3_", 5);
> > > > > +             se->length = sizeof(struct smbios3_entry);
> > > > > +             se->major_ver = SMBIOS_MAJOR_VER;
> > > > > +             se->minor_ver = SMBIOS_MINOR_VER;
> > > > > +             se->docrev = 0;
> > > > > +             se->entry_point_rev = 1;
> > > > > +             se->max_struct_size = len;
> > > > > +             se->struct_table_address = table_addr;
> > > >
> > > > You must fill the checksum:
> > > >
> > > > se->checksum = table_compute_checksum(se, sizeof(struct smbios3_entry));
> > > >
> > > > With the checksum filled I can use dmidecode in Linux based on the
> > > > SMBIOS3 table:
> > > >
> > > > ubuntu@ubuntu:~$ sudo dmidecode
> > > > # dmidecode 3.5
> > > > # SMBIOS3 entry point at 0x27ef53000
> > > > Found SMBIOS entry point in EFI, reading table from /dev/mem.
> > > > SMBIOS 3.7.0 present.
> > > > # SMBIOS implementations newer than version 3.5.0 are not
> > > > # fully supported by this version of dmidecode.
> > > > Table at 0x27EF53020.
> > > >
> > > > Handle 0x0000, DMI type 0, 24 bytes
> > > > BIOS Information
> > > >          Vendor: U-Boot
> > >
> > > OK, great, thank you for figuring this out. Do you think this might be
> > > a reasonable solution for -next ?
> >
> > What about [0] ? Do you expect this to land for 2024.01?
> > I think we should one or the other, unless this is a hotfix for the
> > upcoming release
> >
> > [0] https://lore.kernel.org/u-boot/20231121025818.741258-1-sjg@chromium.org/
>
> I would like one of the two smaller changes to be agreed on for v2024.01
> and we look at the bigger problems for v2024.04 (and heck, that
> can/should start now) around SMBIOS and memory allocation / reservation.

Is this still pending?

From my side:

- we should not use EFI memory allocation to allocate an SMBIOS table
- we should create the table on startup, like other tables

I believe that [0] is a reasonable fix, given the circumstances.

For -next perhaps we should go back to the SMBIOS3 series? I believe
someone found a bug in it which is why it didn't work properly. We can
still use SMBIOS2 when <4GB, in case there is a compatibility problem.

Regards,
Simon
