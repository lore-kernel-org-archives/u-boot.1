Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E09EC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 15:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82418877E2;
	Wed, 27 Dec 2023 16:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XEhgk8o7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BAE58793E; Wed, 27 Dec 2023 16:02:15 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC6DA877B1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-28b400f08a4so4025910a91.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703689331; x=1704294131; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rH7l7TIf5MgdmLCNfRFjUeP1OudkNbQMt2ND7uvuTJM=;
 b=XEhgk8o7AhvGHo+L3kPitP9N59Rnyfbib6B/dbvZ7cE/c/bMxk4NNZjM+IH4B42kjg
 NkXzTxklFGQ9+rga/kIAN3Cx+BjfMUvudJ5f9k9XSfLwHcZpjUdHeEDmfePYpNVkAqh1
 antCzdLLjE32g4vPZdaK/HHb3j9Js0zQrqPrFjqOHP6NyiHShpNjRCP3kWkOLygKLXkt
 T4xL3y/W/EPWuzfEPjgRy5dipMUc4rAbJC/RIvvZ4Dwm/1Nw3v4RpCkV2gGMugBJwPau
 ErfaJ0BmzzYEN3oVZuzpb/+c5WDO9wD1NJ6KnJa93x+9so3kAinnKKSQSb5QZR7SUaQB
 mNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703689331; x=1704294131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rH7l7TIf5MgdmLCNfRFjUeP1OudkNbQMt2ND7uvuTJM=;
 b=B8pd4dOO+4G9lS1xlM4y7BSdqEDsSDGf0dpEHro+2x6Md/ZqPa8lP6ffRHwj+SaNGi
 Jf1+p9vVLZnu4PcsSuTzMHCmYZqg5TM8JPbtnf3CpDtN4U7yRIShdImXXMAjdHKXUgZ1
 VTo7ljPp73N0HQxgjCqun+iWDpeeZhiseW66ZDaFMQpG0LtH+H53WYGPjNqQeDZQGZjJ
 aybeiZGhfxglmwVhXxxOIoKIv2RWfgqeglh/gnL+bzdC3pnkm+qaKxTic1dhm4qQ6aAn
 C9pcJrYCZ+//vCCnbvPpVJDkQe9D5/VUW45uS3VjZUkhWwrUrFKMJAwYRPVNqE+YSq+/
 xwxA==
X-Gm-Message-State: AOJu0YxPTP2EFnPNJRLmT8racUhuh+EZSvXODcmn8+gmya1FafU4sEC4
 +e7WmhoosG/OzQLBON2Cdc8NTyElyiAjTO0t2vd4mqE+TELhQQ==
X-Google-Smtp-Source: AGHT+IHLrSHWnMWre1Z/6gHJESQMaqNuFeUPP/5upSgcYxEr45jg9OHMdb3CrQ7/wPgcLU+wf02w3J6txMdTZxjExAc=
X-Received: by 2002:a17:90a:b002:b0:28b:cdfd:42d6 with SMTP id
 x2-20020a17090ab00200b0028bcdfd42d6mr4068989pjq.50.1703689331181; Wed, 27 Dec
 2023 07:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-10-raymond.mao@linaro.org>
 <CAC_iWj+a=kTUm5Kp+tgtea6tG1XgkDC+V2JeZ3zjqTS-9T6-uw@mail.gmail.com>
In-Reply-To: <CAC_iWj+a=kTUm5Kp+tgtea6tG1XgkDC+V2JeZ3zjqTS-9T6-uw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 10:02:00 -0500
Message-ID: <CAEfUkUKEAxiH-sxOSQ8Ds8nvJQ_Tjey0SU1tAbEGaWpD39z2wA@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] bloblist: Handle alignment with a void entry
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

On Wed, 27 Dec 2023 at 04:58, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Mon, 18 Dec 2023 at 20:20, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > Rather than setting the alignment using the header size, add an entirely
> > new entry to cover the gap left by the alignment.
>
> Hmm, why? Does it make out life easier somehow if new entries get added?
>
> Yes, currently we just mark the unused or removed areas with a void tag.
But I think this is beneficial because later on we can support the
fragments management
by using this tag to collect, merge and re-use the fragmented spaces.

Regards,
Raymond

>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >  common/bloblist.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index 705d9c6ae9..73dbbc01c0 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -142,7 +142,7 @@ static int bloblist_addrec(uint tag, int size, int
> align_log2,
> >  {
> >         struct bloblist_hdr *hdr = gd->bloblist;
> >         struct bloblist_rec *rec;
> > -       int data_start, new_alloced;
> > +       int data_start, aligned_start, new_alloced;
> >
> >         if (!align_log2)
> >                 align_log2 = BLOBLIST_ALIGN_LOG2;
> > @@ -151,10 +151,25 @@ static int bloblist_addrec(uint tag, int size, int
> align_log2,
> >         data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*rec);
> >
> >         /* Align the address and then calculate the offset from
> ->alloced */
> > -       data_start = ALIGN(data_start, 1U << align_log2) -
> map_to_sysmem(hdr);
> > +       aligned_start = ALIGN(data_start, 1U << align_log2) - data_start;
> > +
> > +       /* If we need to create a dummy record, create it */
> > +       if (aligned_start) {
> > +               int void_size = aligned_start - sizeof(*rec);
> > +               struct bloblist_rec *vrec;
> > +               int ret;
> > +
> > +               ret = bloblist_addrec(BLOBLISTT_VOID, void_size, 0,
> &vrec);
> > +               if (ret)
> > +                       return log_msg_ret("void", ret);
> > +
> > +               /* start the record after that */
> > +               data_start = map_to_sysmem(hdr) + hdr->alloced +
> sizeof(*vrec);
> > +       }
> >
> >         /* Calculate the new allocated total */
> > -       new_alloced = data_start + ALIGN(size, 1U << align_log2);
> > +       new_alloced = data_start - map_to_sysmem(hdr) +
> > +               ALIGN(size, 1U << align_log2);
> >
> >         if (new_alloced > hdr->size) {
> >                 log_err("Failed to allocate %x bytes size=%x, need
> size=%x\n",
> > @@ -164,7 +179,7 @@ static int bloblist_addrec(uint tag, int size, int
> align_log2,
> >         rec = (void *)hdr + hdr->alloced;
> >
> >         rec->tag = tag;
> > -       rec->hdr_size = data_start - hdr->alloced;
> > +       rec->hdr_size = sizeof(struct bloblist_rec);
> >         rec->size = size;
> >
> >         /* Zero the record data */
> > --
> > 2.25.1
> >
>
