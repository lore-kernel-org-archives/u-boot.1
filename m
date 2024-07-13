Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE645C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 21:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0124188676;
	Sat, 13 Jul 2024 23:16:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cpe3fAM5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA42886AF; Sat, 13 Jul 2024 23:16:26 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50EB98863E
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 23:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r.stratiienko@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52ea33671ffso3109318e87.3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 14:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720905383; x=1721510183; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdbIxscFS3sI5KMNf5PN4Da+CTMouRPkWZyyzMXa7xE=;
 b=Cpe3fAM5PFnfeeeq+OL/5XaFFxKpKUDe8fRwqBmZNsNjYm3L7dky7qEqE+UkwboQsP
 333clAHG/MNNBE8dzJHFiHMaIUg+Nbg2qJmHFzOOsiB+YR2iy56hRmKkteLP9aKaIjen
 9syPZHB7dbfQsHaoisLcQ/9x+Solg2nuq00A62GSz36pK6hXIW97JPpB4J7GEfWWCoYq
 Ha9xGCC3QpICtWmdok9g1Ffwucd4p7+xDPjNtzVP3SpNhfa1Q249JrQfFykxIcliczwD
 DZBcjcPJl2zveVGMbzMhBIGXmJ49O5nvDuFGdNRAvv4UdXsOwkftEYecoFgsrOK96D4E
 1GPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720905383; x=1721510183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SdbIxscFS3sI5KMNf5PN4Da+CTMouRPkWZyyzMXa7xE=;
 b=sYBAZviTDHvxXzTbxYk1+PngRDOzsS0880WUrAyglysVY07xYTOa+CmTZyM6LHG/BW
 lZY8te/Nb2mOnfrgT6kcJ5UvP3efTjdKY84z6KNR6Jlf0IXDebBJ8mrie0+DNbWC0Ref
 1W20ppuB5Lg+FIdMw8J4BVL8dnyHA2QP79rHjMBsegfWE6skDUjfH1aH+T0T7/uJLKXr
 pXgd1eLKSCUj5xpVKaTYFzhiOm5af5I7o1eD8Mur3vNymxQU20oXO6uCI1r8Yxrcy7e3
 iPDvc/l+09Tybk7qdcgadQb9+TV6lTMCFR5DJKrUyM7XEnKQsBXfi9pb2T6MDnUZkt6q
 5lPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLlmzHS/4H7/plJeduh8Zjv3HGZDT90AVzLi9dsN4KlZvhbiheE72i21j3SZ9BbiFL/BHlrjHKYX4kkDgKRvoo1zfVhQ==
X-Gm-Message-State: AOJu0Yyh/7Lr3kyCttGlWjtWaGQT6BrzSh98sqr0X/0l0+Bad0L5Xh++
 UZnNs8+8VKVurumGdXwH9dZcho8b+LK+ZvmcxXhRhcUdoXpHaxcK+8DiNRO4hiWYt0ravHh3ds1
 9YLDwB4R2UD3CUt5kqyNoiBkIqBdXZloE
X-Google-Smtp-Source: AGHT+IGTVLKicYaeKHMqwqmA01Oo2GUAwJFOn59SZO0M65jfbVdpZkF1LtCdsX2l3Po5EX0s5gZPh9jujRU/UfFJkuI=
X-Received: by 2002:a05:6512:74b:b0:52c:e393:6634 with SMTP id
 2adb3069b0e04-52eb99a325dmr7821837e87.33.1720905383209; Sat, 13 Jul 2024
 14:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240519153542.2572014-1-r.stratiienko@gmail.com>
 <b4549859-022e-4992-8a44-9dc9a21d943b@gmx.de>
In-Reply-To: <b4549859-022e-4992-8a44-9dc9a21d943b@gmx.de>
From: Roman Stratiienko <r.stratiienko@gmail.com>
Date: Sun, 14 Jul 2024 00:16:12 +0300
Message-ID: <CAGphcdnTFZvxdZf+ZT1aAmbh6t9=nAa+gWmW_PQD+7t2EQy29g@mail.gmail.com>
Subject: Re: [PATCH] part: efi: Rely on a definition to specify the primary
 GPT position
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: sjg@chromium.org, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hello Heinrich,

Thank you for your comments.

Just a few thoughts about this patch.

1. I was also sending this patch as a noninvasive, semi-cosmetic
change. Relying on hardcoded values is usually not a good practice.
2. Shifting of primary GPT works in u-boot and Linux kernel with minor
tweaks. See patches [1] and [2] for more context. I'm not going to
upstream them.
3. Accepting this patch upstream helps me to reduce the dependency
chain and potential conflicts during the rebase.

BR, Roman.

[1]: https://github.com/GloDroidCommunity/amlogic-series/blob/8cc5ee7df1358=
092f77f43aa0c9661883473e5af/patches-aosp/glodroid/bootloader/u-boot/0005-GL=
ODROID-Shift-GPT-position-to-support-Amlogic-platf.patch
[2]: https://github.com/GloDroidCommunity/amlogic-series/blob/8cc5ee7df1358=
092f77f43aa0c9661883473e5af/patches-aosp/glodroid/kernel/common-android14-6=
.1-lts/0001-GLODROID-Allow-placing-primary-GPT-to-2MiB-offset-to.patch

=D0=BF=D0=BD, 10 =D1=87=D0=B5=D1=80=D0=B2. 2024=E2=80=AF=D1=80. =D0=BE 15:2=
2 Heinrich Schuchardt <xypron.glpk@gmx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 19.05.24 17:35, Roman Stratiienko wrote:
> > Use GPT_PRIMARY_PARTITION_TABLE_LBA as the only source for a primary GP=
T
> > location instead of hardcoding it every time.
> >
> > Sometimes, we need to shift the primary GPT location.
> > Having the location in the single place simplifies such shifting.
>
> In gdisk there is an expert command "j - move the main partition table".
> This corresponds to CONFIG_EFI_PARTITION_ENTRIES_OFF. It does not move
> the GPT primary header but only the partition entries. So sector 1 is
> still occupied.
>
> If I read you correctly, CONFIG_EFI_PARTITION_ENTRIES_OFF is not doing
> what you need. Instead of only moving the partition entries of the
> primary partition table, you want to move the complete primary GPT table.
>
> Somehow the operating system must find the primary GPT table.
>
> When writing the partition table shouldn't the offset be reflected in
> the protective MBR fields StartingCHS and StartingLBA? See Table 5.4
> "Protective MBR Partition Record protecting the entire disk*" of the
> UEFI 2.10 specification.
>
> Does Linux support this? For testing remove the backup partition table!
>
> GPT_PRIMARY_PARTITION_TABLE_LBA should be made configurable in this case.
>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> > ---
> >   disk/part_efi.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/disk/part_efi.c b/disk/part_efi.c
> > index 4ce9243ef2..b55e251ea1 100644
> > --- a/disk/part_efi.c
> > +++ b/disk/part_efi.c
> > @@ -387,7 +387,7 @@ int write_gpt_table(struct blk_desc *desc, gpt_head=
er *gpt_h, gpt_entry *gpt_e)
> >       gpt_h->header_crc32 =3D cpu_to_le32(calc_crc32);
> >
> >       /* Write the First GPT to the block right after the Legacy MBR */
> > -     if (blk_dwrite(desc, 1, 1, gpt_h) !=3D 1)
> > +     if (blk_dwrite(desc, (lbaint_t)le64_to_cpu(gpt_h->my_lba), 1, gpt=
_h) !=3D 1)
> >               goto err;
> >
> >       if (blk_dwrite(desc, le64_to_cpu(gpt_h->partition_entry_lba),
> > @@ -534,7 +534,7 @@ int gpt_fill_pte(struct blk_desc *desc,
> >
> >   static uint32_t partition_entries_offset(struct blk_desc *desc)
> >   {
> > -     uint32_t offset_blks =3D 2;
> > +     uint32_t offset_blks =3D GPT_PRIMARY_PARTITION_TABLE_LBA + 1;
> >       uint32_t __maybe_unused offset_bytes;
> >       int __maybe_unused config_offset;
> >
> > @@ -572,8 +572,8 @@ static uint32_t partition_entries_offset(struct blk=
_desc *desc)
> >        * The earliest LBA this can be at is LBA#2 (i.e. right behind
> >        * the (protective) MBR and the GPT header.
> >        */
> > -     if (offset_blks < 2)
> > -             offset_blks =3D 2;
> > +     if (offset_blks < (GPT_PRIMARY_PARTITION_TABLE_LBA + 1))
> > +             offset_blks =3D GPT_PRIMARY_PARTITION_TABLE_LBA + 1;
> >
> >       return offset_blks;
> >   }
> > @@ -584,7 +584,7 @@ int gpt_fill_header(struct blk_desc *desc, gpt_head=
er *gpt_h, char *str_guid,
> >       gpt_h->signature =3D cpu_to_le64(GPT_HEADER_SIGNATURE_UBOOT);
> >       gpt_h->revision =3D cpu_to_le32(GPT_HEADER_REVISION_V1);
> >       gpt_h->header_size =3D cpu_to_le32(sizeof(gpt_header));
> > -     gpt_h->my_lba =3D cpu_to_le64(1);
> > +     gpt_h->my_lba =3D cpu_to_le64(GPT_PRIMARY_PARTITION_TABLE_LBA);
> >       gpt_h->alternate_lba =3D cpu_to_le64(desc->lba - 1);
> >       gpt_h->last_usable_lba =3D cpu_to_le64(desc->lba - 34);
> >       gpt_h->partition_entry_lba =3D
>
