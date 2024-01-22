Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8B0C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 09:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8543E875E9;
	Mon, 22 Jan 2024 10:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NXrNa3aa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59E1087214; Mon, 22 Jan 2024 10:15:49 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8844875E9
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 10:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-42a032cf012so27380011cf.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 01:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705914945; x=1706519745; darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aOf0AVj1cqNhHrUNMd9M6PtkVLDRNIf+qCXdl+s9i0s=;
 b=NXrNa3aaOQRM8fyHF2Q1c5x5Of1Fc+g/gizKJ5hY4S9n9lFzMbaLP/HJzvd+12aZH8
 irmP8p2ZOOc59CO7j926ZSslUSEOYkhw0hZFdoHpekNKXwxNFORqYu/OklNEQHgDEjID
 gr+2ABXqZuiQlNG1imb9w6gxuqHMNKgC6XNLoc81ZXrW4SCwhxoppX6oBAmTpwhUg04t
 8ub5t+3lqUMNFk+Lwiwv2lxBNV6cTpU0FA7vs85t5IcUPqPnS5lCeXbxleUjNZmUaDW0
 X6KobyzqQvfut6QKNkz3B08qhXwRSUkdYtozYDV6K1w7pYXThPanwIGtIOdjoZ5srM7w
 Alww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705914945; x=1706519745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aOf0AVj1cqNhHrUNMd9M6PtkVLDRNIf+qCXdl+s9i0s=;
 b=wwawW36SYMAAuDDznZ0NNWyI1LqzB67nUCOiTySBYXTf9hXijK2hNE+7R7QKtg+f34
 eFACGTUFBe3ZYNG4lhS2Wb3sHU7QpSdFnVZh23VWHBbHn28e8eBdtbIc19avtXk8CQXZ
 1YK29XS+mmSL0YKLt71Mv8eduPct7JuVAYlwYXZn0cCVC2yo249J+ZT4cZLkhwtTlKWv
 vvYvrgM8Gwj29MiQ1cHmTAqazAVXxcgSLma2+Vc+MK6d6MikHfZYd7I+gQagD2/NWqZ8
 itMcsdo8JIiQo4rh3tAlAS6xnFDJTPW8qUnv5c125xA3H2EIy/l7PtH4u5f8wlulnRNy
 FVlw==
X-Gm-Message-State: AOJu0YyUb6yP1Ck0NNkAsZ+SX8ESnizoWpJ4ODsFQ05f6qi88ldjYjCk
 T4Jj7dZUaeejcnDLYA2ehUk/YtdIm1HWmyiROqZk6pSpFv82m5E/jDsFJPthZ0dxVh1gfhQkz0s
 Min6Q6d+1n9XxPqz/JyhrBz4EiiiPUVX9gLol0Q==
X-Google-Smtp-Source: AGHT+IHRwD9J3N4KoQ9r+jOxXP4+RC/UmZ1mMci0IcrwRdWzD2u4jd96JO1q7nQZyojGfm3z2IkbAH9PoibDIoM2Ino=
X-Received: by 2002:a05:6214:529a:b0:685:ac1d:8066 with SMTP id
 kj26-20020a056214529a00b00685ac1d8066mr4220363qvb.86.1705914945560; Mon, 22
 Jan 2024 01:15:45 -0800 (PST)
MIME-Version: 1.0
References: <20240116123643.563412-1-mchitale@ventanamicro.com>
 <20240116123643.563412-2-mchitale@ventanamicro.com>
 <d3d71b07-9636-42e9-b29b-31ae84d8e4b4@canonical.com>
In-Reply-To: <d3d71b07-9636-42e9-b29b-31ae84d8e4b4@canonical.com>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Mon, 22 Jan 2024 14:45:09 +0530
Message-ID: <CAN37VV5qGy=iEVgYE8ignm1=xz8c2m9r4b0hd9PVSFTLeHtK0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] part: Add a function to find ESP partition
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng@tinylab.org>, 
 Tobias Waldekranz <tobias@waldekranz.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>
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

On Tue, Jan 16, 2024 at 7:15=E2=80=AFPM Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> On 16.01.24 13:36, Mayuresh Chitale wrote:
> > If a disk has an EFI system partition (ESP) then it can be used to
> > locate the boot files. Add a function to find the ESP.
> >
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >   disk/part.c    | 16 ++++++++++++++++
> >   include/part.h | 11 +++++++++++
> >   2 files changed, 27 insertions(+)
> >
> > diff --git a/disk/part.c b/disk/part.c
> > index 36b88205eca..6b1fbc18637 100644
> > --- a/disk/part.c
> > +++ b/disk/part.c
> > @@ -848,3 +848,19 @@ int part_get_bootable(struct blk_desc *desc)
> >
> >       return 0;
> >   }
> > +
> > +int part_get_esp(struct blk_desc *desc)
> > +{
> > +     struct disk_partition info;
> > +     int p;
> > +
> > +     for (p =3D 1; p <=3D MAX_SEARCH_PARTITIONS; p++) {
> > +             int ret;
> > +
> > +             ret =3D part_get_info(desc, p, &info);
> > +             if (!ret && (info.bootable & PART_EFI_SYSTEM_PARTITION))
> > +                     return p;
> > +     }
> > +
> > +     return 0;
> > +}
> > diff --git a/include/part.h b/include/part.h
> > index db34bc6bb7d..30e049c8f19 100644
> > --- a/include/part.h
> > +++ b/include/part.h
> > @@ -690,6 +690,14 @@ int part_get_type_by_name(const char *name);
> >    */
> >   int part_get_bootable(struct blk_desc *desc);
> >
> > +/**
> > + * part_get_esp() - Find the EFI system partition
> > + *
> > + * @desc: Block-device descriptor
> > + * @Return the EFI system partition, or 0 if there is none
>
> We want to be able to add the include to our API documentation. This
> requires adhering to the Sphinx documentation style.
>
> %s/@Return the/Return:/
>
> Ok.

> Cf.
>
> https://www.kernel.org/doc/html/v6.7/doc-guide/kernel-doc.html#function-d=
ocumentation
>
> Best regards
>
> Heinrich
>
> > + */
> > +int part_get_esp(struct blk_desc *desc);
> > +
> >   #else
> >   static inline int part_driver_get_count(void)
> >   { return 0; }
> > @@ -700,6 +708,9 @@ static inline struct part_driver
> *part_driver_get_first(void)
> >   static inline bool part_get_bootable(struct blk_desc *desc)
> >   { return false; }
> >
> > +static inline bool part_get_esp(struct blk_desc *desc)
> > +{ return false; }
> > +
> >   #endif /* CONFIG_PARTITIONS */
> >
> >   #endif /* _PART_H */
>
>
