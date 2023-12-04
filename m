Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CBCC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA158790C;
	Mon,  4 Dec 2023 09:31:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vG2wG/pW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3629D8790F; Mon,  4 Dec 2023 09:31:11 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E04878AB
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c9f72176cfso14312861fa.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701678668; x=1702283468; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dSgnI4N4ECVRnP/s0BdWK/HoAy/woy+ZrI4vtl0qCKk=;
 b=vG2wG/pWNxbK27MWDD2Y8QYUTXf3v3WdwLsjbH8NDkEy60mNH6QQ8CqgnMRVnChHJm
 U4olMMLcrZMq5yv57N0cL0OGtbuWcSk/cXX+WWgRQD/eiq95YKPAtEelkDcuHCwXX20P
 XeF7Pw5+eZBljHZUe6kdxQnt9VUijImio9FWXWVqYxF8XDIZJqSwO1f//+AZvP+pTbbc
 Z62pnREGrQzRE94HJzT910aUhU3LDsPJxTzD8MikTtjid8Hw0QdDpcDg8pwQVMiqafgd
 fXofWOXsmL0k8PIWZuvn5dUaljkQLl0GGf9XzK2KVdeHwKpiOvuiYfURRVf1x5jMca0+
 C8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701678668; x=1702283468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dSgnI4N4ECVRnP/s0BdWK/HoAy/woy+ZrI4vtl0qCKk=;
 b=GXxnJWhf2hRAEwwbO6wHGiC+AATtAXH5d7J+6IDx6uC/3waTnK6tCS1Aj7G7eSWNP1
 wdHCYQHXcaFhvJY92CyWqrovV+3pxgFn2SlbYB3dn+bbjgPOaGZKsjBihX7go5cHrtWw
 j5KZr59HBaVwQ8yN8/OTC36ZrHaU/wQ347urpYaHDGcC1upQro8bKPo0L++t9R49/NQz
 slW7lfy1L4E8EF+r0EHplUnyUe14Yp/4SbfbhMPc0LaH7jHKXtQJGkxZv3AGkb7eZTET
 Vm3maNACnaIyxxORpJFWAYlE3xYTyvjnaLaIFKcjOXZnA7bsIv0kxCuvTSYyxRHKkZh6
 kFlQ==
X-Gm-Message-State: AOJu0YwpA8/hCQa5pWE90vYx4/7leBTDm2lNjGxGVJrrkIiyQ9WtPihF
 Y+5huqrDghm5JpC33QtE2+MfvkEnMsr4322emovHhA==
X-Google-Smtp-Source: AGHT+IHteTGAHGn3FpJ2NND46CTLPVfnUwxYpd1JBb8wS/8jVV6HFvfpCtAZ8hTCQ62/D804ZLd9+nMGUq2594pGnxI=
X-Received: by 2002:a05:651c:20a:b0:2ca:3b4:f513 with SMTP id
 y10-20020a05651c020a00b002ca03b4f513mr197982ljn.176.1701678668361; Mon, 04
 Dec 2023 00:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-6-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-6-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 Dec 2023 10:30:32 +0200
Message-ID: <CAC_iWjJyKkp2TAq3H=h0z0sC6S0tSZgvgusAiA9sYOzp_7cx=A@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] bloblist: Access record hdr_size and tag via a
 function
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, Bin Meng <bmeng.cn@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>, 
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sean Anderson <seanga2@gmail.com>
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

On Mon, 27 Nov 2023 at 21:52, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> These values currently use a simple field. With spec v0.9 they have moved
> to a packed format. Convert most accesses to use functions, so this change
> can be accommodated.

I don't really understand how the commit message is related to the changes.
What did the packed format affect that we need a function?

Thanks
/Ilias
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  common/bloblist.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index e744c2b0c0..f084a32cfc 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -82,13 +82,23 @@ static struct bloblist_rec *bloblist_first_blob(struct bloblist_hdr *hdr)
>         return (struct bloblist_rec *)((void *)hdr + hdr->hdr_size);
>  }
>
> +static inline uint rec_hdr_size(struct bloblist_rec *rec)
> +{
> +       return rec->hdr_size;
> +}
> +
> +static inline uint rec_tag(struct bloblist_rec *rec)
> +{
> +       return rec->tag;
> +}
> +
>  static ulong bloblist_blob_end_ofs(struct bloblist_hdr *hdr,
>                                    struct bloblist_rec *rec)
>  {
>         ulong offset;
>
>         offset = (void *)rec - (void *)hdr;
> -       offset += rec->hdr_size + ALIGN(rec->size, BLOBLIST_ALIGN);
> +       offset += rec_hdr_size(rec) + ALIGN(rec->size, BLOBLIST_ALIGN);
>
>         return offset;
>  }
> @@ -117,7 +127,7 @@ static struct bloblist_rec *bloblist_findrec(uint tag)
>                 return NULL;
>
>         foreach_rec(rec, hdr) {
> -               if (rec->tag == tag)
> +               if (rec_tag(rec) == tag)
>                         return rec;
>         }
>
> @@ -156,7 +166,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
>         rec->spare = 0;
>
>         /* Zero the record data */
> -       memset((void *)rec + rec->hdr_size, '\0', rec->size);
> +       memset((void *)rec + rec_hdr_size(rec), '\0', rec->size);
>
>         hdr->alloced = new_alloced;
>         *recp = rec;
> @@ -197,7 +207,7 @@ void *bloblist_find(uint tag, int size)
>         if (size && size != rec->size)
>                 return NULL;
>
> -       return (void *)rec + rec->hdr_size;
> +       return (void *)rec + rec_hdr_size(rec);
>  }
>
>  void *bloblist_add(uint tag, int size, int align_log2)
> @@ -207,7 +217,7 @@ void *bloblist_add(uint tag, int size, int align_log2)
>         if (bloblist_addrec(tag, size, align_log2, &rec))
>                 return NULL;
>
> -       return (void *)rec + rec->hdr_size;
> +       return (void *)rec + rec_hdr_size(rec);
>  }
>
>  int bloblist_ensure_size(uint tag, int size, int align_log2, void **blobp)
> @@ -218,7 +228,7 @@ int bloblist_ensure_size(uint tag, int size, int align_log2, void **blobp)
>         ret = bloblist_ensurerec(tag, &rec, size, align_log2);
>         if (ret)
>                 return ret;
> -       *blobp = (void *)rec + rec->hdr_size;
> +       *blobp = (void *)rec + rec_hdr_size(rec);
>
>         return 0;
>  }
> @@ -230,7 +240,7 @@ void *bloblist_ensure(uint tag, int size)
>         if (bloblist_ensurerec(tag, &rec, size, 0))
>                 return NULL;
>
> -       return (void *)rec + rec->hdr_size;
> +       return (void *)rec + rec_hdr_size(rec);
>  }
>
>  int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp)
> @@ -243,7 +253,7 @@ int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp)
>                 *sizep = rec->size;
>         else if (ret)
>                 return ret;
> -       *blobp = (void *)rec + rec->hdr_size;
> +       *blobp = (void *)rec + rec_hdr_size(rec);
>
>         return 0;
>  }
> @@ -279,7 +289,7 @@ static int bloblist_resize_rec(struct bloblist_hdr *hdr,
>
>         /* Zero the new part of the blob */
>         if (expand_by > 0) {
> -               memset((void *)rec + rec->hdr_size + rec->size, '\0',
> +               memset((void *)rec + rec_hdr_size(rec) + rec->size, '\0',
>                        new_size - rec->size);
>         }
>
> @@ -313,8 +323,9 @@ static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
>         chksum = crc32(0, (unsigned char *)hdr,
>                        offsetof(struct bloblist_hdr, chksum));
>         foreach_rec(rec, hdr) {
> -               chksum = crc32(chksum, (void *)rec, rec->hdr_size);
> -               chksum = crc32(chksum, (void *)rec + rec->hdr_size, rec->size);
> +               chksum = crc32(chksum, (void *)rec, rec_hdr_size(rec));
> +               chksum = crc32(chksum, (void *)rec + rec_hdr_size(rec),
> +                              rec->size);
>         }
>
>         return chksum;
> @@ -422,8 +433,9 @@ void bloblist_show_list(void)
>         for (rec = bloblist_first_blob(hdr); rec;
>              rec = bloblist_next_blob(hdr, rec)) {
>                 printf("%08lx  %8x  %4x %s\n",
> -                      (ulong)map_to_sysmem((void *)rec + rec->hdr_size),
> -                      rec->size, rec->tag, bloblist_tag_name(rec->tag));
> +                      (ulong)map_to_sysmem((void *)rec + rec_hdr_size(rec)),
> +                      rec->size, rec_tag(rec),
> +                      bloblist_tag_name(rec_tag(rec)));
>         }
>  }
>
> --
> 2.25.1
>
