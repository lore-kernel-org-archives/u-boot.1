Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88773C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 08:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E05B887516;
	Thu, 28 Dec 2023 09:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fFpOH3oa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0160876B2; Thu, 28 Dec 2023 09:41:48 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ECF787250
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 09:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e77a2805fso2857096e87.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 00:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703752904; x=1704357704; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zS/xGOvwID/Hg8ZVNP/zzxztuGk9N6HW6RtjjhVpa0c=;
 b=fFpOH3oaICz8qI1PxwlxLzMznzKR0W1ZeGcsGiNTluJkFQyue9pSgrye6wI0D026Il
 o1RL1KUFapVRHfz4AUWRWOE9cGqw7g0/138MUgyRVh1aufVT0haLVUtgI/XDXMqoKlUX
 QSrhEWwa6dJI6cjAdcd3xFgR76IrzZ0GinHdCQ+fQTyQPXL9wq7GGGPnwZrP4YrO/kPW
 48rURWKXpAg9nytFOBqj0QJgmPR62URhcf5fUmxxhTFELo2bMdsVC4/Dh5eOkEkoS0B5
 WZK+QuoY+313IYvay/GfL7m+Sn0Ysl06thio/ciFHWE7yBqeOQ0ICsIXUoldeS6c67YS
 hKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703752904; x=1704357704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zS/xGOvwID/Hg8ZVNP/zzxztuGk9N6HW6RtjjhVpa0c=;
 b=S+YrHll4e22zm9sAGuFSJk3z9P/AT49see0kISeZpAYVcJnWVjMzuJ4So1sB775xe/
 ABux3nr6aSB79+DWpkPr1HJEy91B7sgWEVhzbI5PK/Fxuyukzeggxn32TXnP/GMnmVnc
 kRiW2k5m+TcbKIAoX60dSW0Q30D4TVHleRNE4TIIg/9xtW98KcCuzLeTlkcCSRIdQj/4
 gYB/5RSsKhEa53aB7XkMLQok/pIPiItK495nroW2ClhYdEBL3MEVnmmUGbfvfxUGYbEG
 nV5hodtpi4Vs3dlaTauotqwVS8/EI4jzc94ot+gKmITaeiF/w+uMqG9jJYInQE5HEnpt
 UhjA==
X-Gm-Message-State: AOJu0YzrLwDb/IIHeOmCPCuJoUzH0ypoIZe6X7iyVA2cPqsE4GJ1Zn8R
 MXUwiYoe3Cd//8ULoWeq/T3jsLDbog59MON1NPBH5JOzh59yYQ==
X-Google-Smtp-Source: AGHT+IEOGrxSl5q8mn0lO3o6tNkygFL9oiizrz5aT0sh3Jhcw6HW1MmxOc/zkxmVr4OCn4C6AHzeBBM153qgDHC5958=
X-Received: by 2002:a05:6512:1328:b0:50e:82e7:912b with SMTP id
 x40-20020a056512132800b0050e82e7912bmr1304474lfu.138.1703752904478; Thu, 28
 Dec 2023 00:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-6-raymond.mao@linaro.org>
In-Reply-To: <20231227210712.712937-6-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 10:41:08 +0200
Message-ID: <CAC_iWjJ0OD4=LB632s2gXp3EG5E8JKLMVqUOranj999__RFKJg@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] bloblist: Access record hdr_size and tag via a
 function
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 27 Dec 2023 at 23:07, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Convert accesses to tag and hdr_size via function for grouping tag and
> hdr_size together later.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v3
> - Update commit message.
>
>  common/bloblist.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 1e78a3d4b3..168993e0a7 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -84,13 +84,23 @@ static struct bloblist_rec *bloblist_first_blob(struct bloblist_hdr *hdr)
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
> @@ -119,7 +129,7 @@ static struct bloblist_rec *bloblist_findrec(uint tag)
>                 return NULL;
>
>         foreach_rec(rec, hdr) {
> -               if (rec->tag == tag)
> +               if (rec_tag(rec) == tag)
>                         return rec;
>         }
>
> @@ -158,7 +168,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
>         rec->spare = 0;
>
>         /* Zero the record data */
> -       memset((void *)rec + rec->hdr_size, '\0', rec->size);
> +       memset((void *)rec + rec_hdr_size(rec), '\0', rec->size);
>
>         hdr->alloced = new_alloced;
>         *recp = rec;
> @@ -199,7 +209,7 @@ void *bloblist_find(uint tag, int size)
>         if (size && size != rec->size)
>                 return NULL;
>
> -       return (void *)rec + rec->hdr_size;
> +       return (void *)rec + rec_hdr_size(rec);
>  }
>
>  void *bloblist_add(uint tag, int size, int align_log2)
> @@ -209,7 +219,7 @@ void *bloblist_add(uint tag, int size, int align_log2)
>         if (bloblist_addrec(tag, size, align_log2, &rec))
>                 return NULL;
>
> -       return (void *)rec + rec->hdr_size;
> +       return (void *)rec + rec_hdr_size(rec);
>  }
>
>  int bloblist_ensure_size(uint tag, int size, int align_log2, void **blobp)
> @@ -220,7 +230,7 @@ int bloblist_ensure_size(uint tag, int size, int align_log2, void **blobp)
>         ret = bloblist_ensurerec(tag, &rec, size, align_log2);
>         if (ret)
>                 return ret;
> -       *blobp = (void *)rec + rec->hdr_size;
> +       *blobp = (void *)rec + rec_hdr_size(rec);
>
>         return 0;
>  }
> @@ -232,7 +242,7 @@ void *bloblist_ensure(uint tag, int size)
>         if (bloblist_ensurerec(tag, &rec, size, 0))
>                 return NULL;
>
> -       return (void *)rec + rec->hdr_size;
> +       return (void *)rec + rec_hdr_size(rec);
>  }
>
>  int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp)
> @@ -245,7 +255,7 @@ int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp)
>                 *sizep = rec->size;
>         else if (ret)
>                 return ret;
> -       *blobp = (void *)rec + rec->hdr_size;
> +       *blobp = (void *)rec + rec_hdr_size(rec);
>
>         return 0;
>  }
> @@ -281,7 +291,7 @@ static int bloblist_resize_rec(struct bloblist_hdr *hdr,
>
>         /* Zero the new part of the blob */
>         if (expand_by > 0) {
> -               memset((void *)rec + rec->hdr_size + rec->size, '\0',
> +               memset((void *)rec + rec_hdr_size(rec) + rec->size, '\0',
>                        new_size - rec->size);
>         }
>
> @@ -315,8 +325,9 @@ static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
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
> @@ -424,8 +435,9 @@ void bloblist_show_list(void)
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
