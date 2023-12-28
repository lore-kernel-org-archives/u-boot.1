Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2F7C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 16:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B892487ACD;
	Thu, 28 Dec 2023 17:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hRFpBhnO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 127D587ACD; Thu, 28 Dec 2023 17:04:53 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA10587A84
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 17:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-28c17b6f91bso1520854a91.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703779489; x=1704384289; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R7oYFXIf/ND9F86BZ4HVg9BqeukEVZiXMqPi/63CRFI=;
 b=hRFpBhnO3n2u6oUBYsCXtO3Wr57is2wQU48KPkk6wVwcTIgrpv+VI5OLahIkJO3GgP
 AXnRz4Kmokl95864OY/GyUdMNVZdNl7xxZE3OjHaQg5SpTKkDF76O33ctfk0a3dx/xRM
 PdKiClUaagrG5zuuoawZxWWk3W3JlmaEx8g8JLxOYt1nD+6tjMLqLTtaKDVsF3tw2e3x
 r5AXGwOl+mLCHVp7SzNzQ3Kw4iokSd5bisw3YdVTTMMN1qZk3l3QpMkPuXPoDKR3x8t7
 gDKxOgsVtfDruMh7dxgA9xUEndhLCQLhFHqWcD1d5+kn9uT+MkZE0S0E//sKXa8B1e9W
 KTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703779489; x=1704384289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R7oYFXIf/ND9F86BZ4HVg9BqeukEVZiXMqPi/63CRFI=;
 b=uYRD8KZxRThhaMS3c51bSSj1AUzAs46VD7As1S6UKKmsAwseK6ACWzpeUOYio/Dfuh
 iJuz+Mxn0FlPt5H4PZY7fqNeD6TVKCqZF0JmhUz44bNFLI3579p9kdMSsp1WrXCQYvJ1
 +qbsvdzIVG6b9EtZd/6+TUeUFCtK8umr6DXlrqk3pBllYACqboPTN0zBohO5nIJei0CY
 dhRYwEnKVssx3/q97IJ9rDTL4fxB61If5qZhrlsJxM1Qi0+cSOziepqljLUA4KjyYfXm
 /ir9T6uyEzM61gtd/gZeEiJKIQuICTh9YtGKbHJXEPMsza7RJOrxjiCGonmG5JCJ27cv
 mJ9g==
X-Gm-Message-State: AOJu0Yx0JItvcf996Zu3X/16sCKpQsw1LiL5gqkZrpzDJ28JCidOUZ1a
 C6uEw6/cas+gId6EvyQwgY/pl2k0peJkibnTFV3SCKJMy9pIPQ==
X-Google-Smtp-Source: AGHT+IGWWjy6U6Kk4N7G7J+hi9KR1xt/blnsodNCkEcu2yU3etJoQmiYArRhTsWOcWBRe0mlZE1KIdDsI9tHtKekC7k=
X-Received: by 2002:a17:90a:d56:b0:28c:10b:82 with SMTP id
 22-20020a17090a0d5600b0028c010b0082mr3376755pju.89.1703779488957; 
 Thu, 28 Dec 2023 08:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-9-raymond.mao@linaro.org>
 <CAC_iWjJ2GAOU93x1gHPYKXyiU0j6Tp0yHqeCtsctY3mOdz+9VA@mail.gmail.com>
In-Reply-To: <CAC_iWjJ2GAOU93x1gHPYKXyiU0j6Tp0yHqeCtsctY3mOdz+9VA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 28 Dec 2023 11:04:37 -0500
Message-ID: <CAEfUkU+wUZJ2cb98sHAcbF-4HbN5-G2NVCSjX3ehpAkHNKUgUw@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] bloblist: Handle alignment with a void entry
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

On Thu, 28 Dec 2023 at 06:32, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Wed, 27 Dec 2023 at 23:08, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > Rather than setting the alignment using the header size, add an entirely
> > new entry to cover the gap left by the alignment.
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
>
> I just noticed the 'BLOBLISTT'. Is that on purpose? or a typo?
>
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
>
> So, wouldn't it make more sense to add the dummy record and align the
> whole thing *after* we've added the entry?
> Doing it like this might leave the last entry on an unaligned boundary, no?
>
> The spec just cares about the TE *data* starts at an aligned address but
not the TE header.
Not sure if I fully understand your question but each TE *data* will start
at an aligned address
after calling `bloblist_addrec()`.
And each TE is allowed to have its own alignment value, so we have to do
the padding when
a TE is being added but cannot predict the alignment value for the next TE
- that means we
cannot do the padding after each TE is added.

[...]

Thanks and regards,
Raymond
