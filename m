Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92723C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 16:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57BDD87A53;
	Thu, 28 Dec 2023 17:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RBef+GI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F18487A69; Thu, 28 Dec 2023 17:51:08 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7214F87A27
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 17:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50e4e3323a6so6916392e87.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703782265; x=1704387065; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3m3RkqCJKI5XFmbmV2Zk4iqcWfkQpI92IL1h1qYIwSc=;
 b=RBef+GI1jpD/NIukZSSe4I66G3EQnTJQthK3gJWKePrnU4fDCK/rcUhmhp4MhahGpn
 zCrmIyYF5/ruduTRa1B38s3brtN5Gu1r6DUf7bsdC1+VSHA+0zQgNWmqRpxUvRc/ZClp
 vWr4YfxEtwwXJuOtx3l0t1VYe7ESqBT7MKHzs48Wy/IO4QJkJ0r1t/BudSfxemJvx7eZ
 rqA4XMjL1y7SjC3jckGzgA0MPYiIrwIwRsOfbQ1zBcxO325T1C+TASS064ZHz6Q0C2XP
 gKZ51K2PsbnOCGLzG8WmcCZQSJX/n9XURBqeoBcbPe20K4dqenvsOnsyg3IDBQzmPd3g
 1p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703782265; x=1704387065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3m3RkqCJKI5XFmbmV2Zk4iqcWfkQpI92IL1h1qYIwSc=;
 b=v9h8WujRfh1ReRRjYqyqdyzoC8dzDG9NxWXn49oG+Mg1aL+qdH/mMUa4E02DOza3Fy
 wUQyPWgidVWZ90E9gNMWIFocJEb6whEJs3fhGAOm90SnDBlj2C7iKbL7nIzKkWMCmWW9
 pffLMsH+N9l9vXME0n/TJplET2hwfbiQ1tWpSz+gNM+JIimeOs6JZm0uqHf3JqoNSR5f
 tcWFpGSaYPmIGsCmxjgtKl+KnWSQ4SFFyMZ8wwHmTFb6/GQtJ+GlJSyACDbwWrpUAwD3
 eG3/XJGj9geAlYA4iVeQLkA4SGbrWsB26ffAwRmogG2Clv7pj1kxcmYzDAqHYuc0ree3
 nDTg==
X-Gm-Message-State: AOJu0YwVGe7K5iGe8fpfTY1yIs4ZsQh5CdwIQD/SeRPIHV6vtcOr1EVq
 +VvcvP+oBt7Y5ZF6mH4kE0LGwvms9IDFrgq5PUQ7mpNaf/nIrg==
X-Google-Smtp-Source: AGHT+IEItA+l0QIwXJ8MPIWKBtY7Jgqz19l/icRmr/zt9VVfjhbFtgjJudpgshCWBtsn2PbZ3yFnz8Q4WXPkJnpskZE=
X-Received: by 2002:a05:6512:220f:b0:50e:7e15:a9cd with SMTP id
 h15-20020a056512220f00b0050e7e15a9cdmr3656056lfu.18.1703782265301; Thu, 28
 Dec 2023 08:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-11-raymond.mao@linaro.org>
 <CAC_iWjJ4JA3yQ4NFG=NYMRQX7esqCfOYQaySjojgUyhjJTgXfw@mail.gmail.com>
 <CAFLszTgbpXY_9ZYbL2oG9sq9nGqtH-x_igqy_KRq=E8NKdFyDw@mail.gmail.com>
In-Reply-To: <CAFLszTgbpXY_9ZYbL2oG9sq9nGqtH-x_igqy_KRq=E8NKdFyDw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 18:50:29 +0200
Message-ID: <CAC_iWjJGU4RLiw34nksSKfZwWfgbUq3yw0VHE+c-5JEiiL-_iA@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] bloblist: Adjust the bloblist header
To: Simon Glass <sjg@chromium.org>
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

On Thu, 28 Dec 2023 at 15:37, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, Dec 28, 2023 at 7:37=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Raymond,
> >
> > [...]
> >
> > >
> > >  void bloblist_show_list(void)
> > > @@ -463,7 +477,7 @@ void bloblist_reloc(void *to, uint to_size, void =
*from, uint from_size)
> > >
> > >         memcpy(to, from, from_size);
> > >         hdr =3D to;
> > > -       hdr->size =3D to_size;
> > > +       hdr->total_size =3D to_size;
> > >  }
> > >
> > >  int bloblist_init(void)
> > > @@ -493,7 +507,7 @@ int bloblist_init(void)
> > >                                     addr, ret);
> > >                 } else {
> > >                         /* Get the real size, if it is not what we ex=
pected */
> > > -                       size =3D gd->bloblist->size;
> > > +                       size =3D gd->bloblist->total_size;
> > >                 }
> > >         }
> > >         if (ret) {
> > > diff --git a/include/bloblist.h b/include/bloblist.h
> > > index 7024d7bf9e..4ec4b3d449 100644
> > > --- a/include/bloblist.h
> > > +++ b/include/bloblist.h
> > > @@ -166,32 +166,33 @@ enum bloblist_tag_t {
> > >   * from the last.
> > >   *
> > >   * @magic: BLOBLIST_MAGIC
> > > + * @chksum: checksum for the entire bloblist allocated area. Since a=
ny of the
> > > + *     blobs can be altered after being created, this checksum is on=
ly valid
> > > + *     when the bloblist is finalized before jumping to the next sta=
ge of boot.
> > > + *     This is the value needed to make all checksummed bytes sum to=
 0
> > >   * @version: BLOBLIST_VERSION
> > >   * @hdr_size: Size of this header, normally sizeof(struct bloblist_h=
dr). The
> > >   *     first bloblist_rec starts at this offset from the start of th=
e header
> > > - * @flags: Space for BLOBLISTF... flags (none yet)
> > > - * @size: Total size of the bloblist (non-zero if valid) including t=
his header.
> > > - *     The bloblist extends for this many bytes from the start of th=
is header.
> > > - *     When adding new records, the bloblist can grow up to this siz=
e.
> > > - * @alloced: Total size allocated so far for this bloblist. This sta=
rts out as
> > > + * @align_log2: Power of two of the maximum alignment required by th=
is list
> > > + * @used_size: Size allocated so far for this bloblist. This starts =
out as
> > >   *     sizeof(bloblist_hdr) since we need at least that much space t=
o store a
> > >   *     valid bloblist
> > > + * @total_size: The number of total bytes that the bloblist can occu=
py.
> > > + *     Any blob producer must check if there is sufficient space bef=
ore adding
> > > + *     a record to the bloblist.
> > > + * @flags: Space for BLOBLISTF... flags (none yet)
> > >   * @spare: Spare space (for future use)
> > > - * @chksum: checksum for the entire bloblist allocated area. Since a=
ny of the
> > > - *     blobs can be altered after being created, this checksum is on=
ly valid
> > > - *     when the bloblist is finalised before jumping to the next sta=
ge of boot.
> > > - *     This is the value needed to make all checksummed bytes sum to=
 0
> > >   */
> > >  struct bloblist_hdr {
> > >         u32 magic;
> > > -       u32 version;
> > > -       u32 hdr_size;
> > > +       u8 chksum;
> > > +       u8 version;
> > > +       u8 hdr_size;
> > > +       u8 align_log2;
> > > +       u32 used_size;
> > > +       u32 total_size;
> > >         u32 flags;
> > > -
> > > -       u32 size;
> > > -       u32 alloced;
> > >         u32 spare;
> > > -       u32 chksum;
> > >  };
> >
> > The patch generally looks ok, but while we are renaming things, can't
> > we just copy what the spec says instead of slightly changing the
> > names?
> >
> > With this applied we end up with
> >   struct bloblist_hdr {
> >          u32 magic;
> >          u8 chksum;
> >          u8 version;
> >          u8 hdr_size;
> >          u8 align_log2;
> >          u32 used_size;
> >          u32 total_size;
> >          u32 flags;
> >          u32 spare;
> >   };
> >
> > Can you at least rename the ones you touch here properly?
> > - Drop the patch that renames spare to _spare
> > - used_size -> size
> > - total_size -> max_size (which btw mean different things)
> > - spare -> reserved
>
> Yes that would be good, but since the spec only recently changed the
> names, how about a 'rename' patch on top, if that is easier?
>

Sure I dont mind,

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> I was hoping that this series could be applied as is, or close to it.
> It looks like a good base to me.
>
> Regards,
> Simon
