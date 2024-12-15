Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186E2E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 07:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A6608006E;
	Sun, 15 Dec 2024 08:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IomHKhJ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF698006F; Sun, 15 Dec 2024 08:34:23 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3715B8006C
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 08:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6f00da6232bso28036407b3.2
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 23:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734248060; x=1734852860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YCRneLGjcLQLuqxOJ68n3Gwxf+giwbl17Q57nOPrSrY=;
 b=IomHKhJ7pzb70vcso+qupQZEGy9+Fy6eZNCMFh26QIvQNMBLCm/GrQ0KYIP//EBRim
 0PGm/35f+koNJaeFojSpHS4MIGeDAsCLsQ00wRJguSu6BSkDMVBYcbsIxh05IcKjXxy7
 SY//cq3ikURfk/+8mX1jj4reVI8HC+JoJVPaUa1voxmfXgJdqfzjylTkhrVvEitBbio3
 7PJBiY6sVt1T7/mMKAxKT+hDWA6gNiOTFOTLIB61CIEO5s+eq4CiFTwCEmMNRrBkuaKH
 J+5twFDb1wpt5CkuOUWWCKGeSwu77k29I7DMHmI8ujabF7zRVfkHd2ces4CQCVQrOCCH
 vYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734248060; x=1734852860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YCRneLGjcLQLuqxOJ68n3Gwxf+giwbl17Q57nOPrSrY=;
 b=edTLwiKYtxpRVw6loEAusp2vVLnjlVazdnEZK2YgIQPPCIULQHU7XesJgmuEyDIEYX
 a7Rp+S4IyB80y5KzQlBAYwKk4cbvEHtY5N77JKSJz1O5TY2RSHiMC8fHlz+K0Kek9IP3
 FeU4KoAtBcbwa5kyAjcQ4tboFP9a0TBkBcV1CbE6GzDReYMdmkAPFzUasy5q82+Gwobh
 UR9f8t4sSMeuQOBkJ8culiaZ8kYWkdmvmkn134q3gX1u4/4GTepwgtvrWK650HPKfXnV
 MxJw9WMY/mI4JM3DdGUfOx4x2SF+1PyOfsn1PLZo+WasWnURJuAjf1OHt49VprknDv7Z
 /ErQ==
X-Gm-Message-State: AOJu0YxvDL+opU2oq3tfIuMZs/lmbcYK4IF+0TDBXmOB3V4DyUYHDPqU
 b9AplB3fVnDhOOit+gVpq5E3fRjIaZQyItsaoQbagTgND9FNy/a04MSPo7ZqmTYfEEZ81E0Gfkh
 cdB6uqmz556Hwc6BUOIGxpMQNTXkGTaLJ/Gx2PQ==
X-Gm-Gg: ASbGncuBBBKDiTGAQko4TDdSmCOhqy3Kf+e+ILwaTTz++fKf+JXdQhXTQknDTZjjpLS
 4mq0mUXDnvWIEE5rS/ob0TjtbxHU47jBS0V1Z/g==
X-Google-Smtp-Source: AGHT+IEQiiRJfQdnx0od/Jp6TZxy4apGURkAJ9ocjTcdfS/PdHpJi//lBiDO4JK/8ABtpzUWX1Vq/cZ1mZ88CvTIJ4g=
X-Received: by 2002:a05:690c:601:b0:6ef:62c7:cedb with SMTP id
 00721157ae682-6f279b22225mr78802707b3.17.1734248060116; Sat, 14 Dec 2024
 23:34:20 -0800 (PST)
MIME-Version: 1.0
References: <20241213225543.392282-1-raymond.mao@linaro.org>
In-Reply-To: <20241213225543.392282-1-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 15 Dec 2024 09:33:44 +0200
Message-ID: <CAC_iWj+Ohu8yi_ECZfWJxEXa7Yy4QHDyZxCMscm_O_ReF4qf2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: add api to get blob with size
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>
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

On Sat, 14 Dec 2024 at 00:55, Raymond Mao <raymond.mao@linaro.org> wrote:
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
> diff --git a/common/bloblist.c b/common/bloblist.c
> index ec6ff7a5a9..efc1905da3 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -222,14 +222,27 @@ static int bloblist_ensurerec(uint tag, struct bloblist_rec **recp, int size,
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
