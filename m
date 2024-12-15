Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A8BE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 15:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C7A8004F;
	Sun, 15 Dec 2024 16:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HDK03Dq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC93B80050; Sun, 15 Dec 2024 16:50:03 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4346780040
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 16:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa66ead88b3so621032266b.0
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734277800; x=1734882600; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Efi7SLeOxNEy2G2Hb76XPzb3CzrbdKoujSYkvgScS0=;
 b=HDK03Dq4+Bdsc5kodnMDBYArUdWheHv11Ogv5qj1XvWtCAOyq9mfu5pBC498SLao9U
 M4/Cop8M6ZYZ3FZai5Mm0uM9cS5BSF0mjcAcw8LN8EdSIFmL/mjsyOiGiXpSCRiLx1Z/
 9SgwlvmtJfilmkO/xebIH0cfQ7c88DtRlshzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734277800; x=1734882600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Efi7SLeOxNEy2G2Hb76XPzb3CzrbdKoujSYkvgScS0=;
 b=jtXmgIYQqTHSIvna6lWN2CirMX/Het07lCtTC+KauiiCaSxbz82TYPOWMiE5iRGzwG
 EdfPEd1/o682puJdk8NCzjTODsjJy2mjq1DFJnC8pFHmCbOfjnPGCzKSkSOCsPzB1v4H
 +gOXcl8QTwGf1Meudq41Aj7SjzMNMZLxl6soYbvQT3KT/nt3tQAiPo8cZTTmiTU2dPbl
 J6CKIu/bm7nMyzxqoRkUxIYTdoDo/Ueq4JhVEjoFeyvWeuF219vc+Z2PTlPIvTp3mDMl
 3TyhpcBsZu4WX397+ZdSeNDtJVXRRqvEf3yIRV4/COj5BNgF06+P/k3NBHQyd0+R6cfD
 WFKQ==
X-Gm-Message-State: AOJu0YzFK4Rv2pvw9fWaaZY0t8iSYtGsYxDJv7kQINilS4hJ2yKc5VVI
 Y7SMDBpZ3fX5BfigAoaGnKjPDtQEnGeRMgV6Us2x7Ukym9KFw0PX64M7fAgCh4SyWeRkz+oNS50
 JBrdCyhYE7KyQghim5fqRNFW6zMsAJcttRUrv
X-Gm-Gg: ASbGnct/Md5BdCni3IrQBI7gAnExjSEXQ1wxnQ9HqqeHhBrp6420sHT5glSagjwzlOd
 /6u0Hhx8H30YeBlCp5uenYtXD3jrdYoNHeAi4
X-Google-Smtp-Source: AGHT+IHqsJ06nmgf96+wddxKmTJzApeY3kt6g16v3kzDZ773ZufRhS2tV4BF6Uam1wotnkP7iXeG3ZUctpY7UXgPjOQ=
X-Received: by 2002:a17:907:3e91:b0:aa6:6331:936c with SMTP id
 a640c23a62f3a-aab77eb0085mr937425966b.59.1734277800457; Sun, 15 Dec 2024
 07:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20241213225543.392282-1-raymond.mao@linaro.org>
In-Reply-To: <20241213225543.392282-1-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 15 Dec 2024 08:49:48 -0700
Message-ID: <CAFLszTjSGqmk8yYYbXFEaFZWFhF8uhj_rNxZz7ship1-Fb8p3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: add api to get blob with size
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>
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

Hi Raymond,

On Fri, 13 Dec 2024 at 15:55, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> bloblist_find function only returns the pointer of blob data,
> which is fine for those self-describing data like FDT.
> But as a common scenario, an interface is needed to retrieve both
> the pointer and the size of the blob data.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  common/bloblist.c  | 17 +++++++++++++++--
>  include/bloblist.h | 18 ++++++++++++++++++
>  2 files changed, 33 insertions(+), 2 deletions(-)
>

Please could you add a test? Otherwise looks good.

> diff --git a/common/bloblist.c b/common/bloblist.c
> index ec6ff7a5a9..efc1905da3 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -222,14 +222,27 @@ static int bloblist_ensurerec(uint tag, struct
bloblist_rec **recp, int size,
>  }
>
>  void *bloblist_find(uint tag, int size)
> +{
> +       void *blob = NULL;
> +       int blob_size;
> +
> +       blob = bloblist_get_blob(tag, &blob_size);
> +
> +       if (size && size != blob_size)
> +               return NULL;
> +
> +       return blob;
> +}
> +
> +void *bloblist_get_blob(uint tag, int *size)

Can you use sizep instead, like the other functions, so it is clear within
the function that it is a pointer?

>  {
>         struct bloblist_rec *rec;
>
>         rec = bloblist_findrec(tag);
>         if (!rec)
>                 return NULL;
> -       if (size && size != rec->size)
> -               return NULL;
> +
> +       *size = rec->size;
>
>         return (void *)rec + rec_hdr_size(rec);
>  }
> diff --git a/include/bloblist.h b/include/bloblist.h
> index ff32d3fecf..a04c7c80be 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -250,6 +250,24 @@ static inline void *bloblist_check_magic(ulong addr)
>         return ptr;
>  }
>
> +#if CONFIG_IS_ENABLED(BLOBLIST)
> +/**
> + * bloblist_get_blob() - Find a blob and get the size of it
> + *
> + * Searches the bloblist and returns the blob with the matching tag
> + *
> + * @tag:       Tag to search for (enum bloblist_tag_t)
> + * @size:      Size of the blob found
> + * Return: pointer to bloblist if found, or NULL if not found
> + */
> +void *bloblist_get_blob(uint tag, int *size);
> +#else
> +static inline void *bloblist_get_blob(uint tag, int *size)
> +{
> +       return NULL;
> +}
> +#endif
> +
>  /**
>   * bloblist_find() - Find a blob
>   *
> --
> 2.25.1
>

Regards,
Simon
