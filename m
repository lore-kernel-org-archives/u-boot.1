Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A73FC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 20:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C35986FB2;
	Tue, 21 Nov 2023 21:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QvNRqTgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 445AD8718E; Tue, 21 Nov 2023 21:41:18 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEE1285E44
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c88b7e69dfso12844141fa.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700599275; x=1701204075; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8uTPV2mK3AZfswfv1KI1COhvSYvrHsc3ZikN1thEnPw=;
 b=QvNRqTgndmKMfzyQGvVP3SUqbtIJSWsiZdu13YEOi1+mfJ4JbvCduZnyqO+N1m/QHK
 D7P6JT4h0wkP2Z6z61XBLT4Gkk9JpRGaCPSFHjRaOCTixo4nFOaKPal4RN7laNX3NkwE
 0hgPu8aHZftyHAp28HKPe3mxFwD/n7ANshQdwWzQ790GzR+JeecDQWrEPUODM2/g75re
 9kiuDwhPUuwjgLnvkPM50qKc2/vGKYv8Naye8JBcZwqGHE01rdcn7U/BjayrBlfGlF1p
 FyP35BZB/YPeHEhklYcw8cqaX1ZP5XXavFxUB9gX+21lVNh/oBd4VTiZ6w03HDGaTFFx
 QpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700599275; x=1701204075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8uTPV2mK3AZfswfv1KI1COhvSYvrHsc3ZikN1thEnPw=;
 b=gHXcwyD3QpU10iElLGOeRKs+cijgpFaWgcn5APgFlrfvPUym2CeCSRfzOhDBTK6Vym
 LPX6fch5NW1lP59Ay5hryW7SGnUZFs1VcXSI9ysqybcKnfNjQLYp/HNnaKQpHcgMLGn4
 uZnsbClKgvfmMKKiOnmpaCZD210sMAy35N2FE+cLNBfULiuJ3YzxBVuS5cfv7ggbkbbD
 u7E8iFSfYeujQ9ULBGsG17UIHebogEPf1WeoU5SVbOubOvGBoHDLhbqVKAzgLCeOorGi
 SMnwELDhvCpwy8tceQeBRPa0d+sHiSS69Xmm7SF2AK61Pqgl6zhFag+VYMTtRxYY2lng
 KbeA==
X-Gm-Message-State: AOJu0YwoF9qvRafdC0if9Rp3AILMHQF7G4bymfYNQL3EPk+U1sJzdeLo
 MIMcURzIPIU21TBwzbYHkBr39fq7qbD0nmWgATc8Yw==
X-Google-Smtp-Source: AGHT+IGGT7t8t8N5hvSBqvFlxYhKPNfRf3QXGTTI3otOlafPpUJvmDndfTDHiPCyfrN6uZF0QZBcNHpkxOnuVlU7fiU=
X-Received: by 2002:a2e:95ce:0:b0:2bc:eceb:6a4b with SMTP id
 y14-20020a2e95ce000000b002bceceb6a4bmr16074ljh.28.1700599275015; Tue, 21 Nov
 2023 12:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-4-sjg@chromium.org>
 <4ba6fd96-d4aa-45bc-be9d-cb8689606596@gmx.de>
 <CAPnjgZ2QWbVm-=8+E5Yv2ekdWjZ2E1VeS1TJD9rnNUfa+dhrYA@mail.gmail.com>
In-Reply-To: <CAPnjgZ2QWbVm-=8+E5Yv2ekdWjZ2E1VeS1TJD9rnNUfa+dhrYA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 Nov 2023 22:40:39 +0200
Message-ID: <CAC_iWj+7FCrAYt1z1=9o8+6uxYiqG++nc72-XHYiHDtP6Uag0w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] smbios: Use SMBIOS 3.0 to support an address above
 4GB
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Hi Simon

On Tue, 21 Nov 2023 at 04:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Mon, 20 Nov 2023 at 19:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 10/15/23 04:45, Simon Glass wrote:
> > > When the SMBIOS table is written to an address above 4GB a 32-bit table
> > > address is not large enough.
> > >
> > > Use an SMBIOS3 table in that case.
> > >
> > > Note that we cannot use efi_allocate_pages() since this function has
> > > nothing to do with EFI. There is no equivalent function to allocate
> > > memory below 4GB in U-Boot. One solution would be to create a separate
> > > malloc() pool, or just always put the malloc() pool below 4GB.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Check the end of the table rather than the start.
> > >
> > >   include/smbios.h | 22 +++++++++++++++++++++-
> > >   lib/smbios.c     | 24 +++++++++++++++++++-----
> > >   2 files changed, 40 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/smbios.h b/include/smbios.h
> > > index c9df2706f5a6..ddabb558299e 100644
> > > --- a/include/smbios.h
> > > +++ b/include/smbios.h
> > > @@ -12,7 +12,8 @@
> > >
> > >   /* SMBIOS spec version implemented */
> > >   #define SMBIOS_MAJOR_VER    3
> > > -#define SMBIOS_MINOR_VER     0
> > > +#define SMBIOS_MINOR_VER     7
> > > +
> > >
> > >   enum {
> > >       SMBIOS_STR_MAX  = 64,   /* Maximum length allowed for a string */
> > > @@ -54,6 +55,25 @@ struct __packed smbios_entry {
> > >       u8 bcd_rev;
> > >   };
> > >
> > > +struct __packed smbios3_entry {
> > > +     u8 anchor[5];
> > > +     u8 checksum;
> > > +     u8 length;
> > > +     u8 major_ver;
> > > +
> > > +     u8 minor_ver;
> > > +     u8 docrev;
> > > +     u8 entry_point_rev;
> > > +     u8 reserved;
> > > +     u32 max_struct_size;
> > > +
> > > +     u64 struct_table_address;
> > > +};
> > > +
> > > +/* These two structures should use the same amount of 16-byte-aligned space */
> > > +static_assert(ALIGN(16, sizeof(struct smbios_entry)) ==
> > > +           ALIGN(16, sizeof(struct smbios3_entry)));
> > > +
> > >   /* BIOS characteristics */
> > >   #define BIOS_CHARACTERISTICS_PCI_SUPPORTED  (1 << 7)
> > >   #define BIOS_CHARACTERISTICS_UPGRADEABLE    (1 << 11)
> > > diff --git a/lib/smbios.c b/lib/smbios.c
> > > index c7a557bc9b7b..92e98388084f 100644
> > > --- a/lib/smbios.c
> > > +++ b/lib/smbios.c
> > > @@ -487,7 +487,11 @@ ulong write_smbios_table(ulong addr)
> > >       addr = ALIGN(addr, 16);
> > >       start_addr = addr;
> > >
> > > -     addr += sizeof(struct smbios_entry);
> > > +     /*
> > > +      * So far we don't know which struct will be used, but they both end
> > > +      * up using the same amount of 16-bit-aligned space
> > > +      */
> > > +     addr += max(sizeof(struct smbios_entry), sizeof(struct smbios3_entry));
> > >       addr = ALIGN(addr, 16);
> > >       tables = addr;
> > >
> > > @@ -512,14 +516,24 @@ ulong write_smbios_table(ulong addr)
> > >        * sandbox's DRAM buffer.
> > >        */
> > >       table_addr = (ulong)map_sysmem(tables, 0);
> > > -     if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulong)UINT_MAX) {
> > > +     if (sizeof(table_addr) > sizeof(u32) && addr >= (ulong)UINT_MAX) {
> >
> > You have to check the end of the the last SMBIOS structure not the start
> > of the first SMBIOS structure against UINT_MAX.
> >
> > > +             struct smbios3_entry *se;
> > >               /*
> > >                * We need to put this >32-bit pointer into the table but the
> > >                * field is only 32 bits wide.
> > >                */
> > > -             printf("WARNING: SMBIOS table_address overflow %llx\n",
> > > -                    (unsigned long long)table_addr);
> > > -             addr = 0;
> > > +             printf("WARNING: Using SMBIOS3.0 due to table-address overflow %lx\n",
> > > +                    table_addr);
> >
> > This should be log_debug().
> >
> > > +             se = map_sysmem(start_addr, sizeof(struct smbios_entry));
> > > +             memset(se, '\0', sizeof(struct smbios_entry));
> > > +             memcpy(se->anchor, "_SM3_", 5);
> > > +             se->length = sizeof(struct smbios3_entry);
> > > +             se->major_ver = SMBIOS_MAJOR_VER;
> > > +             se->minor_ver = SMBIOS_MINOR_VER;
> > > +             se->docrev = 0;
> > > +             se->entry_point_rev = 1;
> > > +             se->max_struct_size = len;
> > > +             se->struct_table_address = table_addr;
> >
> > You must fill the checksum:
> >
> > se->checksum = table_compute_checksum(se, sizeof(struct smbios3_entry));
> >
> > With the checksum filled I can use dmidecode in Linux based on the
> > SMBIOS3 table:
> >
> > ubuntu@ubuntu:~$ sudo dmidecode
> > # dmidecode 3.5
> > # SMBIOS3 entry point at 0x27ef53000
> > Found SMBIOS entry point in EFI, reading table from /dev/mem.
> > SMBIOS 3.7.0 present.
> > # SMBIOS implementations newer than version 3.5.0 are not
> > # fully supported by this version of dmidecode.
> > Table at 0x27EF53020.
> >
> > Handle 0x0000, DMI type 0, 24 bytes
> > BIOS Information
> >          Vendor: U-Boot
>
> OK, great, thank you for figuring this out. Do you think this might be
> a reasonable solution for -next ?

What about [0] ? Do you expect this to land for 2024.01?
I think we should one or the other, unless this is a hotfix for the
upcoming release

[0] https://lore.kernel.org/u-boot/20231121025818.741258-1-sjg@chromium.org/

Thanks
/Ilias
>
> Regards,
> Simon
