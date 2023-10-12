Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A01CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E54586F36;
	Thu, 12 Oct 2023 05:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A7NNr1f0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C33786E0F; Thu, 12 Oct 2023 05:46:21 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BBDD86E81
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d9a5adc8cefso592911276.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082368; x=1697687168; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U46/NCeR/m8GfSqllz3+3aNCHJe7W1oqN0SLnvDz9f4=;
 b=A7NNr1f0g6QUZjHxDFOBv9Oqoyw2KVzOGiyF5n2bHrHrv7/CujoohPk/KcKh4HqNl1
 SupDlBxkRruJnCW1CFwKpqEqqf6EtZpyRlzK8kz4COHItPBCm2HZi3YeS2YlR04qYbYr
 7I10Llg2Nj3FTVpeKpFpXVfzdPnzIjMb+3YSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082368; x=1697687168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U46/NCeR/m8GfSqllz3+3aNCHJe7W1oqN0SLnvDz9f4=;
 b=djKIVPw/vfAT3GGA+B3L7w4PirsQJJrgD/LvhIfSaFAqm1XBVRxPstXJy5wVRKNQe4
 pHuBfl6lXlNzKUolyASOsOp0V6EBuW1i4CZlewzmWjmp+N3HcsYCsIramqdmWLp2kgqQ
 qtod62psztjTG6XxGdU5YGmLe0j+PfFjIGqq+IYZlrrcCPgj40qAGbvSXV0bsRrfeVsc
 FxRnRcFWFJD5XvNST8dY9eL9q0clcR6cetSf1K0DZPctGO6mrRjQswno1b7nvyXUTuiI
 95T6a8kngAT3CL/e8+0DLKCdMpdGw5bZCbVTtr3LuZn21IlG8KJDvoozhVhliJngvDS7
 QoFw==
X-Gm-Message-State: AOJu0YzM2mGvKOHoUwHdrKXFgV37CkefcRu/YVSbrxjxN7x60BX5QorS
 PFwiN0HEAfZ+YWhcIVzPCWhl9Np/7xSxjXB85HX8pNZErI1TXrB5/8k=
X-Google-Smtp-Source: AGHT+IGCiBIB3qATbPwO61yXab9Pp6K2xFOcpr67/oMH5hGSZHFPw1BJQqvqgcZJnqitKNiHwqipZUn55AjEOJFiC9M=
X-Received: by 2002:a25:a2cc:0:b0:d9a:560a:fbaa with SMTP id
 c12-20020a25a2cc000000b00d9a560afbaamr6115234ybn.0.1697082367522; Wed, 11 Oct
 2023 20:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231008213646.622002-1-sjg@chromium.org>
 <20231008213646.622002-4-sjg@chromium.org>
 <4295df86-0a0b-420f-b8d2-ed5c930ea9ee@gmx.de>
In-Reply-To: <4295df86-0a0b-420f-b8d2-ed5c930ea9ee@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:45:24 -0700
Message-ID: <CAPnjgZ2Tt-=Botwz7QotJYJ9SxKBvS7Tx=C35+j+CRWOLD9ZbA@mail.gmail.com>
Subject: Re: [PATCH 3/5] smbios: Use SMBIOS 3.0 to support an address above 4GB
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Sun, 8 Oct 2023 at 19:48, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/8/23 23:36, Simon Glass wrote:
> > When the SMBIOS table is written to an address above 4GB a 32-bit table
> > address is not large enough.
> >
> > Use an SMBIOS3 table in that case.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   include/smbios.h | 22 +++++++++++++++++++++-
> >   lib/smbios.c     | 22 ++++++++++++++++++----
> >   2 files changed, 39 insertions(+), 5 deletions(-)
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
> > index c7a557bc9b7b..82e259f31791 100644
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
> > @@ -513,13 +517,23 @@ ulong write_smbios_table(ulong addr)
> >        */
> >       table_addr = (ulong)map_sysmem(tables, 0);
> >       if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulong)UINT_MAX) {
>
> You have to check the end address of the table not the start address here.
>
> The SMBIOS specification says that you should always supply a 32bit
> SMBIOS entry point. Of course this is not possible on boards that don't
> have low memory.
>
> In install_smbios_table() this can be achieved by calling
> efi_allocate_pages() with EFI_MAX_ALLOCATE_TYPE and a maximum address of
> 4 GiB - 1. Only if this fails use high memory.

Hmm perhaps we need a way to allocate memory below 4GB in U-Boot? How
does this EFI function work?

I don't think EFI has been set up by the time this function is called.

Regards,
Simon
