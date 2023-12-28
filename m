Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B61C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 16:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7CE287A32;
	Thu, 28 Dec 2023 17:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HMENYOks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD2C987A84; Thu, 28 Dec 2023 17:19:04 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E730876B2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 17:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-28c7e30c83fso1252516a91.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703780338; x=1704385138; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/tmDIZqlDvR4en5lBsPuCfuWLN/4TecwcBB4fpsOgmE=;
 b=HMENYOksTAwpersg4UYteRDteybbiFcE9RoS2cThr7PnagkEKboDCS3KLN9UU7Z+r3
 8cAcdkl6OfbEtQKRVaq3nqKTpFpjYURW1yWvJtZ/qjBFXRDGzGyrM3Td9ngxU6SsYYky
 LyBlWJOPC60OBpSaMEm7AfU0uOla/lI51pAjeLl+fxTPHnVJ07GcP1oMkwo2hmQfBQ/2
 IUaEYvCn+r6LfYwCF/aBXjgtNSojAvtfO49HPPBDLR8syYWPxZpIhsosdtDzzCTClxuW
 6y9DbrG7MjxCQkwrsI7EqXOu0WM/j9dlWCLUm3IKUWuCwOBZ4tak6dPQmgMrcyw4utwb
 u/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703780338; x=1704385138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/tmDIZqlDvR4en5lBsPuCfuWLN/4TecwcBB4fpsOgmE=;
 b=J8Jwfzu1GJwDqJY4eqKZWajO5cd0WfsNc3KpIVG3paxaNmcTbYolj4guDQLiETBKXy
 RK1GKEiNwjZZ3Ah45D5D/1Q58WcrvfO/cqaeoim21qSWUpCbP4nWpQCsNvCVBV11UUIV
 No8q+uGyJ69iWy+kQILKiBMoYDLVomvEigrQUcCTiTcURboOxoYhqDh9AScrNH/DvJTF
 Q9P9FAEGQ/HbEP3EYEOGKM+xI8FxZVf/LmmfnuK/dd0BOGCMh9zgE0TQpNo9wNQZEX8t
 hCn0WH++mEOECB3cOAWUmmJilnuIQE6c5hmLq8/q8NPpGwc4U0pttM38eOoD7iXcSYbx
 RSHQ==
X-Gm-Message-State: AOJu0YwD6BVNn57/x3lFms979CLevKd3EJ4cz7ej1Ti/APezwSgVunaD
 0mjXVlRsuxq/RmdiKuEh8HwRRwLSooZixaNx/uxdkBtaCEPekw==
X-Google-Smtp-Source: AGHT+IGMjLVuoLhiUU8mi629rSrLimjdLD+oMOYx6jf8Op9LZN+QcqOneNWeE2tIYwk8ShPAxwiAeFP6GXZGztHMxvg=
X-Received: by 2002:a17:90a:ce8f:b0:28c:9355:d09e with SMTP id
 g15-20020a17090ace8f00b0028c9355d09emr1164316pju.83.1703780338447; Thu, 28
 Dec 2023 08:18:58 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-11-raymond.mao@linaro.org>
 <CAC_iWjJ4JA3yQ4NFG=NYMRQX7esqCfOYQaySjojgUyhjJTgXfw@mail.gmail.com>
In-Reply-To: <CAC_iWjJ4JA3yQ4NFG=NYMRQX7esqCfOYQaySjojgUyhjJTgXfw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 28 Dec 2023 11:18:47 -0500
Message-ID: <CAEfUkULYyRpL8K71t8Tb9EdJHOeLtNa3cTU-HVYzhMv0dK9dUA@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] bloblist: Adjust the bloblist header
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Ilias,

On Thu, 28 Dec 2023 at 02:37, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> [...]
>
> >
> >  void bloblist_show_list(void)
> > @@ -463,7 +477,7 @@ void bloblist_reloc(void *to, uint to_size, void
> *from, uint from_size)
> >
> >         memcpy(to, from, from_size);
> >         hdr = to;
> > -       hdr->size = to_size;
> > +       hdr->total_size = to_size;
> >  }
> >
> >  int bloblist_init(void)
> > @@ -493,7 +507,7 @@ int bloblist_init(void)
> >                                     addr, ret);
> >                 } else {
> >                         /* Get the real size, if it is not what we
> expected */
> > -                       size = gd->bloblist->size;
> > +                       size = gd->bloblist->total_size;
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
> > + * @chksum: checksum for the entire bloblist allocated area. Since any
> of the
> > + *     blobs can be altered after being created, this checksum is only
> valid
> > + *     when the bloblist is finalized before jumping to the next stage
> of boot.
> > + *     This is the value needed to make all checksummed bytes sum to 0
> >   * @version: BLOBLIST_VERSION
> >   * @hdr_size: Size of this header, normally sizeof(struct
> bloblist_hdr). The
> >   *     first bloblist_rec starts at this offset from the start of the
> header
> > - * @flags: Space for BLOBLISTF... flags (none yet)
> > - * @size: Total size of the bloblist (non-zero if valid) including this
> header.
> > - *     The bloblist extends for this many bytes from the start of this
> header.
> > - *     When adding new records, the bloblist can grow up to this size.
> > - * @alloced: Total size allocated so far for this bloblist. This starts
> out as
> > + * @align_log2: Power of two of the maximum alignment required by this
> list
> > + * @used_size: Size allocated so far for this bloblist. This starts out
> as
> >   *     sizeof(bloblist_hdr) since we need at least that much space to
> store a
> >   *     valid bloblist
> > + * @total_size: The number of total bytes that the bloblist can occupy.
> > + *     Any blob producer must check if there is sufficient space before
> adding
> > + *     a record to the bloblist.
> > + * @flags: Space for BLOBLISTF... flags (none yet)
> >   * @spare: Spare space (for future use)
> > - * @chksum: checksum for the entire bloblist allocated area. Since any
> of the
> > - *     blobs can be altered after being created, this checksum is only
> valid
> > - *     when the bloblist is finalised before jumping to the next stage
> of boot.
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
>
> I was been told by Simon for the naming changes of `used_size` and
`total_size` at:
https://github.com/FirmwareHandoff/firmware_handoff/pull/25
I will prefer to keep this minor fix until spec v1.0 is released since the
spec
is still continuously being updated without upgrading the revision number.
When a v1.0 spec is released I will update the TF-A, OP-TEE and U-Boot
together.

[...]

Thanks and regards,
Raymond
