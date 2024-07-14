Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCF0C3DA49
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 07:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5C60883BB;
	Sun, 14 Jul 2024 09:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fulyv6nU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FB98839A; Sun, 14 Jul 2024 09:45:06 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C5F8839A
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 09:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r.stratiienko@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ec61eeed8eso43487581fa.0
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 00:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720943103; x=1721547903; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWplzqXPPNWVBbcNTxGChiA9VfMNoXFY1mchZOsUKC4=;
 b=Fulyv6nU7RnsCmwdDYyn3K8jUesrxl2DSlDyvr+glC7hDSW9ymYv27op/Go1c4Xblr
 d6H6F/RyML8GeM7y+FmAVx9/hFQ9wZBvI1WNuKSJjF+BsdilINiJakBcTydE7DlMIrNC
 msgutSoTRhdiUPvKyXAD0s5NIOztyooswWi4AnPMfVmMDqQlQQOFZE/YRVhOvwPBMjC8
 gz4eubH1lpKWagz3ZyBJLLmVbAlE1g7lamuWRlaKxfgD2ey9OrnrB9RBccCjX/g3gnh+
 19qXTGIjd1763c3XtyJ9A71F4kO6jmrOerKkQrjBhv1GFEO+A8P5EVqQkWVQrzkEeKc5
 rtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720943103; x=1721547903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWplzqXPPNWVBbcNTxGChiA9VfMNoXFY1mchZOsUKC4=;
 b=qxW6+8Zz2iLMmmapzPfBiPmXkKPS9ctRM4tOtBVFDpUA+5VHOgdLIi9GZ3BtMx2X+Y
 2dhjUB6g0kR2MfbZ3sOQwOxRw+g1ZCrECbq8Sanixr68QLz7LfixF3pip2WsXQHskHZk
 /YSxC0fPxismkf3bh/HU7UP8MQJGVJMqrThrl3z+yfAgdiOoxEGBxCDylJdw9hCiKyXN
 nKxiHpOSlEove6kErAlsMIHPa9HLgMrQdBEXCPDJCdqMp1Tgp0F0oQIYihfCBb0E5SmH
 FMfDaxK9QIA9z3lmijIA6E3NkfF4fx1ZyzlBkfJnAE8U/DnLOKSh+CzZxjBfqgmdOSTi
 lmtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3ji+24Lr9fQl+RTALV5PC7L5B3XKjVgnqFOBxAatDCx/4MKjMpWn4X6tT/Coe3jlm1vQJXyVVSH8cqwDdzwuOhIqGmQ==
X-Gm-Message-State: AOJu0Yx3AdVJsa21cIr+DQM8R6wtFo8r7fWUYRkKt3zZ8zbLO7IQ5mp/
 TR2b/7jCDIrw7sniI70qvvmzzsvE1KeFOR8BvEEZreihKM6x24sLZYITg1rHAl6hkEE8a9JoX9y
 BtvpypZYPV1bGNTirAfU+xNutclw=
X-Google-Smtp-Source: AGHT+IFMUmN4vRB6IeB8VGMPB+czM4J8WvxKjgz+0Ac9wElEZoJ6jTpYbBW8X1NRi4ccsIKnuOTRyDSQIBeCz+D38SQ=
X-Received: by 2002:a05:6512:2247:b0:52c:dec1:4578 with SMTP id
 2adb3069b0e04-52eb99d3d82mr9717771e87.60.1720943103117; Sun, 14 Jul 2024
 00:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240519153542.2572014-1-r.stratiienko@gmail.com>
 <b4549859-022e-4992-8a44-9dc9a21d943b@gmx.de>
 <CAGphcdnTFZvxdZf+ZT1aAmbh6t9=nAa+gWmW_PQD+7t2EQy29g@mail.gmail.com>
 <fce841a3-b44b-4653-8e47-1246c359ed54@gmx.de>
In-Reply-To: <fce841a3-b44b-4653-8e47-1246c359ed54@gmx.de>
From: Roman Stratiienko <r.stratiienko@gmail.com>
Date: Sun, 14 Jul 2024 10:44:51 +0300
Message-ID: <CAGphcd=gizw3104px367YFq-_NgphpJh8YHUes9JEuBpJpoxZQ@mail.gmail.com>
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

Sorry, I'm having a hard time answering your questions.

> When writing the partition table shouldn't the offset be reflected in
the protective MBR fields StartingCHS and StartingLBA? See Table 5.4
"Protective MBR Partition Record protecting the entire disk*" of the
UEFI 2.10 specification.
> Does Linux support this?

Linux doesn't follow the protective MBR to find the GPT location if
that was your question.

> For testing remove the backup partition table!

Testing what? The backup partition table is always restored by Linux
if missing or corrupted.
I tested it previously and it worked.

That was the only question I could find. If your other statements
intended to ask the question, please let me know.

BR,
Roman

=D0=BD=D0=B4, 14 =D0=BB=D0=B8=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 09:39 Hein=
rich Schuchardt <xypron.glpk@gmx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 7/13/24 23:16, Roman Stratiienko wrote:
> > Hello Heinrich,
> >
> > Thank you for your comments.
> >
> > Just a few thoughts about this patch.
> >
> > 1. I was also sending this patch as a noninvasive, semi-cosmetic
> > change. Relying on hardcoded values is usually not a good practice.
> > 2. Shifting of primary GPT works in u-boot and Linux kernel with minor
> > tweaks. See patches [1] and [2] for more context. I'm not going to
> > upstream them.
> > 3. Accepting this patch upstream helps me to reduce the dependency
> > chain and potential conflicts during the rebase.
>
> Hello Roman,
>
> could you, please, answer my questions below.
>
> Best regards
>
> Heinrich
>
> >
> > BR, Roman.
> >
> > [1]: https://github.com/GloDroidCommunity/amlogic-series/blob/8cc5ee7df=
1358092f77f43aa0c9661883473e5af/patches-aosp/glodroid/bootloader/u-boot/000=
5-GLODROID-Shift-GPT-position-to-support-Amlogic-platf.patch
> > [2]: https://github.com/GloDroidCommunity/amlogic-series/blob/8cc5ee7df=
1358092f77f43aa0c9661883473e5af/patches-aosp/glodroid/kernel/common-android=
14-6.1-lts/0001-GLODROID-Allow-placing-primary-GPT-to-2MiB-offset-to.patch
> >
> > =D0=BF=D0=BD, 10 =D1=87=D0=B5=D1=80=D0=B2. 2024=E2=80=AF=D1=80. =D0=BE =
15:22 Heinrich Schuchardt <xypron.glpk@gmx.de> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On 19.05.24 17:35, Roman Stratiienko wrote:
> >>> Use GPT_PRIMARY_PARTITION_TABLE_LBA as the only source for a primary =
GPT
> >>> location instead of hardcoding it every time.
> >>>
> >>> Sometimes, we need to shift the primary GPT location.
> >>> Having the location in the single place simplifies such shifting.
> >>
> >> In gdisk there is an expert command "j - move the main partition table=
".
> >> This corresponds to CONFIG_EFI_PARTITION_ENTRIES_OFF. It does not move
> >> the GPT primary header but only the partition entries. So sector 1 is
> >> still occupied.
> >>
> >> If I read you correctly, CONFIG_EFI_PARTITION_ENTRIES_OFF is not doing
> >> what you need. Instead of only moving the partition entries of the
> >> primary partition table, you want to move the complete primary GPT tab=
le.
> >>
> >> Somehow the operating system must find the primary GPT table.
> >>
> >> When writing the partition table shouldn't the offset be reflected in
> >> the protective MBR fields StartingCHS and StartingLBA? See Table 5.4
> >> "Protective MBR Partition Record protecting the entire disk*" of the
> >> UEFI 2.10 specification.
> >>
> >> Does Linux support this? For testing remove the backup partition table=
!
> >>
> >> GPT_PRIMARY_PARTITION_TABLE_LBA should be made configurable in this ca=
se.
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>>
> >>> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> >>> ---
> >>>    disk/part_efi.c | 10 +++++-----
> >>>    1 file changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/disk/part_efi.c b/disk/part_efi.c
> >>> index 4ce9243ef2..b55e251ea1 100644
> >>> --- a/disk/part_efi.c
> >>> +++ b/disk/part_efi.c
> >>> @@ -387,7 +387,7 @@ int write_gpt_table(struct blk_desc *desc, gpt_he=
ader *gpt_h, gpt_entry *gpt_e)
> >>>        gpt_h->header_crc32 =3D cpu_to_le32(calc_crc32);
> >>>
> >>>        /* Write the First GPT to the block right after the Legacy MBR=
 */
> >>> -     if (blk_dwrite(desc, 1, 1, gpt_h) !=3D 1)
> >>> +     if (blk_dwrite(desc, (lbaint_t)le64_to_cpu(gpt_h->my_lba), 1, g=
pt_h) !=3D 1)
> >>>                goto err;
> >>>
> >>>        if (blk_dwrite(desc, le64_to_cpu(gpt_h->partition_entry_lba),
> >>> @@ -534,7 +534,7 @@ int gpt_fill_pte(struct blk_desc *desc,
> >>>
> >>>    static uint32_t partition_entries_offset(struct blk_desc *desc)
> >>>    {
> >>> -     uint32_t offset_blks =3D 2;
> >>> +     uint32_t offset_blks =3D GPT_PRIMARY_PARTITION_TABLE_LBA + 1;
> >>>        uint32_t __maybe_unused offset_bytes;
> >>>        int __maybe_unused config_offset;
> >>>
> >>> @@ -572,8 +572,8 @@ static uint32_t partition_entries_offset(struct b=
lk_desc *desc)
> >>>         * The earliest LBA this can be at is LBA#2 (i.e. right behind
> >>>         * the (protective) MBR and the GPT header.
> >>>         */
> >>> -     if (offset_blks < 2)
> >>> -             offset_blks =3D 2;
> >>> +     if (offset_blks < (GPT_PRIMARY_PARTITION_TABLE_LBA + 1))
> >>> +             offset_blks =3D GPT_PRIMARY_PARTITION_TABLE_LBA + 1;
> >>>
> >>>        return offset_blks;
> >>>    }
> >>> @@ -584,7 +584,7 @@ int gpt_fill_header(struct blk_desc *desc, gpt_he=
ader *gpt_h, char *str_guid,
> >>>        gpt_h->signature =3D cpu_to_le64(GPT_HEADER_SIGNATURE_UBOOT);
> >>>        gpt_h->revision =3D cpu_to_le32(GPT_HEADER_REVISION_V1);
> >>>        gpt_h->header_size =3D cpu_to_le32(sizeof(gpt_header));
> >>> -     gpt_h->my_lba =3D cpu_to_le64(1);
> >>> +     gpt_h->my_lba =3D cpu_to_le64(GPT_PRIMARY_PARTITION_TABLE_LBA);
> >>>        gpt_h->alternate_lba =3D cpu_to_le64(desc->lba - 1);
> >>>        gpt_h->last_usable_lba =3D cpu_to_le64(desc->lba - 34);
> >>>        gpt_h->partition_entry_lba =3D
> >>
>
