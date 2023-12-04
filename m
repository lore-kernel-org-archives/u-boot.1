Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBA3C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 16:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85F4587717;
	Mon,  4 Dec 2023 17:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uq/hIqM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD1FE876DA; Mon,  4 Dec 2023 17:39:06 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57943874F2
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 17:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d0bb7ff86cso3302505ad.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 08:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701707942; x=1702312742; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3a+oML8v5w7ub68ksQPRxY8AGXaDxqfr/8YKFITedY=;
 b=uq/hIqM8QIFSHcNv08/oTfAFTJXHqNO3pAKtPBLln9Pp7TcbIWFvkYw2iosONw5Z6Q
 MRHa8WpT9S6Ae7F1W37FqWZnT4qiY3TCfrijMQwxFFnk0Ko/HZeMD6wMoSy88RGQeexa
 u9OUfWSFB44YpJFd0nCliBszw2uki1ItelqAxnRmA1WnaYQO2tono4a98pcpkjtS7UFN
 2vp6fydzuO1IrBV3Cg1zqKturvdwGZNgwbFNi85z3rnUyJwEAwcqdWCCud4P0TdZna0n
 LfqH+fis0LXLmfxd9U5nsVM5lLPBGrTI+ZsyZlEykU+BfrdQF55kgVoT3nQmzTmd++7N
 5b/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701707942; x=1702312742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y3a+oML8v5w7ub68ksQPRxY8AGXaDxqfr/8YKFITedY=;
 b=ENdgSfX6flK/liLFR/hBCHkz3DNKLPJHbM9OIMpzXnVpbUcPXwB/1H+Y5uRBc2NEN0
 MKRuxFUzalmjaU8Uctw5UDY3qv8GmaeEDt7l+9RdHhl9FT/zKW3J3eEBU1H2B8Ov0IqK
 yHpqJ2JqKFgb/m2IQxCkaE7GLhbGx50Vv57QXchBl1VTMwc7SkY6tTVhhgRchxKyGhjn
 9/wg1JoU/2DRAUDtn1SgaBwpsTlHjVE+ZMqb67mqdN+oosdB4AQpZgwb+Jtlp4o6z80y
 EVn08Pf6SEeFr9DHRroV4tS0ve2SXtMpFXucHyTAx+zPLTYpm/HmQoyFTQ1GE1d4QJkE
 upsQ==
X-Gm-Message-State: AOJu0YxKSz+7qDrRqgNiwflrAAzut+w6dxstdHcF9sNE0ZiNf4q59tgJ
 dygDSoNt7j5O6lm4laFdb0HmllQLI/PcR13nx4JkCA==
X-Google-Smtp-Source: AGHT+IEjT8aVYZEYUTa0UYtV9TT/voA5DQSZzN1cnq02hyqlgzISKio+uPJKawN3v54w6kmTWmWBpVjqS2Dek8Xkv0I=
X-Received: by 2002:a17:90b:1a91:b0:286:9b50:b98 with SMTP id
 ng17-20020a17090b1a9100b002869b500b98mr2857099pjb.5.1701707942545; Mon, 04
 Dec 2023 08:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-6-raymond.mao@linaro.org>
 <CAC_iWjJyKkp2TAq3H=h0z0sC6S0tSZgvgusAiA9sYOzp_7cx=A@mail.gmail.com>
In-Reply-To: <CAC_iWjJyKkp2TAq3H=h0z0sC6S0tSZgvgusAiA9sYOzp_7cx=A@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 4 Dec 2023 11:38:52 -0500
Message-ID: <CAEfUkUKN0KkfNae7s=vWWi=O8o4DV0VhX=iLU=cSrR_7iq392Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] bloblist: Access record hdr_size and tag via a
 function
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, Bin Meng <bmeng.cn@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>, 
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sean Anderson <seanga2@gmail.com>
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

This patch is for later grouping the tag and hdr_size in
'0011-bloblist-Reduce-blob-header-size.patch'.
I can update the commit message.

Thanks and regards,
Raymond

On Mon, 4 Dec 2023 at 03:31, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Mon, 27 Nov 2023 at 21:52, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > These values currently use a simple field. With spec v0.9 they have moved
> > to a packed format. Convert most accesses to use functions, so this
> change
> > can be accommodated.
>
> I don't really understand how the commit message is related to the changes.
> What did the packed format affect that we need a function?
>
> Thanks
> /Ilias
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  common/bloblist.c | 38 +++++++++++++++++++++++++-------------
> >  1 file changed, 25 insertions(+), 13 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index e744c2b0c0..f084a32cfc 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -82,13 +82,23 @@ static struct bloblist_rec
> *bloblist_first_blob(struct bloblist_hdr *hdr)
> >         return (struct bloblist_rec *)((void *)hdr + hdr->hdr_size);
> >  }
> >
> > +static inline uint rec_hdr_size(struct bloblist_rec *rec)
> > +{
> > +       return rec->hdr_size;
> > +}
> > +
> > +static inline uint rec_tag(struct bloblist_rec *rec)
> > +{
> > +       return rec->tag;
> > +}
> > +
> >  static ulong bloblist_blob_end_ofs(struct bloblist_hdr *hdr,
> >                                    struct bloblist_rec *rec)
> >  {
> >         ulong offset;
> >
> >         offset = (void *)rec - (void *)hdr;
> > -       offset += rec->hdr_size + ALIGN(rec->size, BLOBLIST_ALIGN);
> > +       offset += rec_hdr_size(rec) + ALIGN(rec->size, BLOBLIST_ALIGN);
> >
> >         return offset;
> >  }
> > @@ -117,7 +127,7 @@ static struct bloblist_rec *bloblist_findrec(uint
> tag)
> >                 return NULL;
> >
> >         foreach_rec(rec, hdr) {
> > -               if (rec->tag == tag)
> > +               if (rec_tag(rec) == tag)
> >                         return rec;
> >         }
> >
> > @@ -156,7 +166,7 @@ static int bloblist_addrec(uint tag, int size, int
> align_log2,
> >         rec->spare = 0;
> >
> >         /* Zero the record data */
> > -       memset((void *)rec + rec->hdr_size, '\0', rec->size);
> > +       memset((void *)rec + rec_hdr_size(rec), '\0', rec->size);
> >
> >         hdr->alloced = new_alloced;
> >         *recp = rec;
> > @@ -197,7 +207,7 @@ void *bloblist_find(uint tag, int size)
> >         if (size && size != rec->size)
> >                 return NULL;
> >
> > -       return (void *)rec + rec->hdr_size;
> > +       return (void *)rec + rec_hdr_size(rec);
> >  }
> >
> >  void *bloblist_add(uint tag, int size, int align_log2)
> > @@ -207,7 +217,7 @@ void *bloblist_add(uint tag, int size, int
> align_log2)
> >         if (bloblist_addrec(tag, size, align_log2, &rec))
> >                 return NULL;
> >
> > -       return (void *)rec + rec->hdr_size;
> > +       return (void *)rec + rec_hdr_size(rec);
> >  }
> >
> >  int bloblist_ensure_size(uint tag, int size, int align_log2, void
> **blobp)
> > @@ -218,7 +228,7 @@ int bloblist_ensure_size(uint tag, int size, int
> align_log2, void **blobp)
> >         ret = bloblist_ensurerec(tag, &rec, size, align_log2);
> >         if (ret)
> >                 return ret;
> > -       *blobp = (void *)rec + rec->hdr_size;
> > +       *blobp = (void *)rec + rec_hdr_size(rec);
> >
> >         return 0;
> >  }
> > @@ -230,7 +240,7 @@ void *bloblist_ensure(uint tag, int size)
> >         if (bloblist_ensurerec(tag, &rec, size, 0))
> >                 return NULL;
> >
> > -       return (void *)rec + rec->hdr_size;
> > +       return (void *)rec + rec_hdr_size(rec);
> >  }
> >
> >  int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp)
> > @@ -243,7 +253,7 @@ int bloblist_ensure_size_ret(uint tag, int *sizep,
> void **blobp)
> >                 *sizep = rec->size;
> >         else if (ret)
> >                 return ret;
> > -       *blobp = (void *)rec + rec->hdr_size;
> > +       *blobp = (void *)rec + rec_hdr_size(rec);
> >
> >         return 0;
> >  }
> > @@ -279,7 +289,7 @@ static int bloblist_resize_rec(struct bloblist_hdr
> *hdr,
> >
> >         /* Zero the new part of the blob */
> >         if (expand_by > 0) {
> > -               memset((void *)rec + rec->hdr_size + rec->size, '\0',
> > +               memset((void *)rec + rec_hdr_size(rec) + rec->size, '\0',
> >                        new_size - rec->size);
> >         }
> >
> > @@ -313,8 +323,9 @@ static u32 bloblist_calc_chksum(struct bloblist_hdr
> *hdr)
> >         chksum = crc32(0, (unsigned char *)hdr,
> >                        offsetof(struct bloblist_hdr, chksum));
> >         foreach_rec(rec, hdr) {
> > -               chksum = crc32(chksum, (void *)rec, rec->hdr_size);
> > -               chksum = crc32(chksum, (void *)rec + rec->hdr_size,
> rec->size);
> > +               chksum = crc32(chksum, (void *)rec, rec_hdr_size(rec));
> > +               chksum = crc32(chksum, (void *)rec + rec_hdr_size(rec),
> > +                              rec->size);
> >         }
> >
> >         return chksum;
> > @@ -422,8 +433,9 @@ void bloblist_show_list(void)
> >         for (rec = bloblist_first_blob(hdr); rec;
> >              rec = bloblist_next_blob(hdr, rec)) {
> >                 printf("%08lx  %8x  %4x %s\n",
> > -                      (ulong)map_to_sysmem((void *)rec + rec->hdr_size),
> > -                      rec->size, rec->tag, bloblist_tag_name(rec->tag));
> > +                      (ulong)map_to_sysmem((void *)rec +
> rec_hdr_size(rec)),
> > +                      rec->size, rec_tag(rec),
> > +                      bloblist_tag_name(rec_tag(rec)));
> >         }
> >  }
> >
> > --
> > 2.25.1
> >
>
