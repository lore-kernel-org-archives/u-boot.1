Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0554C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BC7087A13;
	Thu, 28 Dec 2023 14:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="chvYwrIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E5C4879A7; Thu, 28 Dec 2023 14:37:20 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4528E8774E
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b9f727d94cso2102933b6e.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770637; x=1704375437; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5YYTirAnNtXnKXp6arC7jkHo6esLZWis8R9ROsTDII=;
 b=chvYwrIopg+sT6QY1oKdQfZo8eLFU2+yrwZJXR0RHtnXeDOkFMrXLkqodhbXH0j5eR
 R2uAPkHkOrFcp4PoyRcnMx78IGisJN1y/3jzxPcDvpmlqilvcYESFHqDksjl3jt1Fcpx
 EnAzsu3eLOXo3Z6B53l2DLaEk3rjWv8acxu4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770637; x=1704375437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5YYTirAnNtXnKXp6arC7jkHo6esLZWis8R9ROsTDII=;
 b=rtWWCmaxHs0wyqa2nZZlvqV/fQei0VutDI1MdhNGC0TnaYmJKKvEX1URPqo+V23GRd
 RuGc2qwBx9gRGXXpBwZJDDTGmsx/7B+ch2bapoVD+UuZzUSBRlIkacBPf2HQWBvr5O0r
 4bAV+NVDH+8iKxu44t1sStKXX1CsAgNVhaJNCebPwxWidK9dECU0C+7MVPCPTclI1kvZ
 GlZwMrA3fNPlAwhJBX+hCoPv44c6zvskxZVdkgE36bwD9e36Hjhh3RIBqBCk86XqD7g3
 z16QtqsiHD/lxIykiapGRdeL884L3IdXmIBqy+AxDrN2jN50xZVn6Xaa6ULvfdDiUyHU
 yjrA==
X-Gm-Message-State: AOJu0Ywq/pjpyjL82gj31FrkfiGn84Kn0Gv6UbvHvXXucr5Gaq+xCNlc
 fqQT+kDcbGSfdWkigFA0OUwpDEK91rg7BlIX+k3qivKBpwPC
X-Google-Smtp-Source: AGHT+IFQShbleGBgHXJWzpEYc4/8yRtmB8l6mOEJnlIpGfLTOYNDzOuy1Nw1cxMd1OLlNYCASwgk6vtZvMNNrrOioIA=
X-Received: by 2002:a05:6808:215:b0:3bb:bd2b:4ee9 with SMTP id
 l21-20020a056808021500b003bbbd2b4ee9mr2415631oie.19.1703770636850; Thu, 28
 Dec 2023 05:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-11-raymond.mao@linaro.org>
 <CAC_iWjJ4JA3yQ4NFG=NYMRQX7esqCfOYQaySjojgUyhjJTgXfw@mail.gmail.com>
In-Reply-To: <CAC_iWjJ4JA3yQ4NFG=NYMRQX7esqCfOYQaySjojgUyhjJTgXfw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:05 +0000
Message-ID: <CAFLszTgbpXY_9ZYbL2oG9sq9nGqtH-x_igqy_KRq=E8NKdFyDw@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] bloblist: Adjust the bloblist header
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

Hi Ilias,

On Thu, Dec 28, 2023 at 7:37=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Raymond,
>
> [...]
>
> >
> >  void bloblist_show_list(void)
> > @@ -463,7 +477,7 @@ void bloblist_reloc(void *to, uint to_size, void *f=
rom, uint from_size)
> >
> >         memcpy(to, from, from_size);
> >         hdr =3D to;
> > -       hdr->size =3D to_size;
> > +       hdr->total_size =3D to_size;
> >  }
> >
> >  int bloblist_init(void)
> > @@ -493,7 +507,7 @@ int bloblist_init(void)
> >                                     addr, ret);
> >                 } else {
> >                         /* Get the real size, if it is not what we expe=
cted */
> > -                       size =3D gd->bloblist->size;
> > +                       size =3D gd->bloblist->total_size;
> >                 }
> >         }
> >         if (ret) {
> > diff --git a/include/bloblist.h b/include/bloblist.h
> > index 7024d7bf9e..4ec4b3d449 100644
> > --- a/include/bloblist.h
> > +++ b/include/bloblist.h
> > @@ -166,32 +166,33 @@ enum bloblist_tag_t {
> >   * from the last.
> >   *
> >   * @magic: BLOBLIST_MAGIC
> > + * @chksum: checksum for the entire bloblist allocated area. Since any=
 of the
> > + *     blobs can be altered after being created, this checksum is only=
 valid
> > + *     when the bloblist is finalized before jumping to the next stage=
 of boot.
> > + *     This is the value needed to make all checksummed bytes sum to 0
> >   * @version: BLOBLIST_VERSION
> >   * @hdr_size: Size of this header, normally sizeof(struct bloblist_hdr=
). The
> >   *     first bloblist_rec starts at this offset from the start of the =
header
> > - * @flags: Space for BLOBLISTF... flags (none yet)
> > - * @size: Total size of the bloblist (non-zero if valid) including thi=
s header.
> > - *     The bloblist extends for this many bytes from the start of this=
 header.
> > - *     When adding new records, the bloblist can grow up to this size.
> > - * @alloced: Total size allocated so far for this bloblist. This start=
s out as
> > + * @align_log2: Power of two of the maximum alignment required by this=
 list
> > + * @used_size: Size allocated so far for this bloblist. This starts ou=
t as
> >   *     sizeof(bloblist_hdr) since we need at least that much space to =
store a
> >   *     valid bloblist
> > + * @total_size: The number of total bytes that the bloblist can occupy=
.
> > + *     Any blob producer must check if there is sufficient space befor=
e adding
> > + *     a record to the bloblist.
> > + * @flags: Space for BLOBLISTF... flags (none yet)
> >   * @spare: Spare space (for future use)
> > - * @chksum: checksum for the entire bloblist allocated area. Since any=
 of the
> > - *     blobs can be altered after being created, this checksum is only=
 valid
> > - *     when the bloblist is finalised before jumping to the next stage=
 of boot.
> > - *     This is the value needed to make all checksummed bytes sum to 0
> >   */
> >  struct bloblist_hdr {
> >         u32 magic;
> > -       u32 version;
> > -       u32 hdr_size;
> > +       u8 chksum;
> > +       u8 version;
> > +       u8 hdr_size;
> > +       u8 align_log2;
> > +       u32 used_size;
> > +       u32 total_size;
> >         u32 flags;
> > -
> > -       u32 size;
> > -       u32 alloced;
> >         u32 spare;
> > -       u32 chksum;
> >  };
>
> The patch generally looks ok, but while we are renaming things, can't
> we just copy what the spec says instead of slightly changing the
> names?
>
> With this applied we end up with
>   struct bloblist_hdr {
>          u32 magic;
>          u8 chksum;
>          u8 version;
>          u8 hdr_size;
>          u8 align_log2;
>          u32 used_size;
>          u32 total_size;
>          u32 flags;
>          u32 spare;
>   };
>
> Can you at least rename the ones you touch here properly?
> - Drop the patch that renames spare to _spare
> - used_size -> size
> - total_size -> max_size (which btw mean different things)
> - spare -> reserved

Yes that would be good, but since the spec only recently changed the
names, how about a 'rename' patch on top, if that is easier?

I was hoping that this series could be applied as is, or close to it.
It looks like a good base to me.

Regards,
Simon
