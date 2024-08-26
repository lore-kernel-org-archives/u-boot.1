Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3BCC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6213A88A21;
	Mon, 26 Aug 2024 12:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wi5fDoUW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 834B088A2E; Mon, 26 Aug 2024 12:29:05 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CFF8831F
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20223b5c1c0so35003055ad.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 03:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724668141; x=1725272941; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YQpsWo2QDbonvprbv3KlaVSFCZ42casQ5c78pQA5XxM=;
 b=Wi5fDoUWHZR7nfAtP4kkPiQt900zQdEgMJsaUOcqU/K6yK5SJUQ04TDB/KyPGDVtMc
 J9vANaH+9wIGvdr52P8fAN2MypI4uL/jEQnRSzIFnCTgXnRBHXTyVAwH1/AcUadXg1iw
 a3/uS8asnV6WVkXW4TEDiND/WweDRVhMNKzct75jB2E39V0H/STDNDQ+5CYjtw7qssaS
 lJlDKlenk+xqNpx7FfyUCjfVHm4XaBiUnBi3m/lNL6Dj9z5bjnbU1NRUQIAXuPVHcS6v
 jjMBIT6Uz4lFOCcDQlX0xrm00r7JaPuQiN7SKd2Q8PbRnaNzPzd/J7qGUwNOGl5vrLCw
 Wj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724668141; x=1725272941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YQpsWo2QDbonvprbv3KlaVSFCZ42casQ5c78pQA5XxM=;
 b=xNkYkzFkUfz3G87jWIl9xw7eSpHlkBlZjIKNXnnSfjxBIVBSHPeKjc/98NYw4xoUsQ
 GnH4v8nQdbYgHs23FbRFqcCNrF3BT/OX+2g1BiWBBlbjXLYeZbcGP5ehnkpcmfJ2VFoc
 OdH4VpdU4MFJ8c3f+rMnEZOAvxh6NpREP8eKvcYG+eyZGa5ft9qijieeyXi34/Nc20l2
 xN0cyECilPx8bbjifO62Xhf645E0HhL48ql+YDY9O588Su/KfPbVdKV2Pg1PmeuhaJcE
 Z352ygjexWH+xU/v3F9oJmKXlWoiAP9P1xV6BB3MF4z20nCPOC900Z0g7+2BXm/5FmC1
 NQ0w==
X-Gm-Message-State: AOJu0YwWJN66dLbqyrGvHNLu1LcqZHHBYPDTuqr33uWIiURKsjPT9ItW
 +i7NcdlFO2oPXUR44ZaZHHgzKBWP6KOEDAsrmP1dQZIJ09ynpV2Xef4VSMytmilMwV8Bi1qKbS9
 R1eUv0v9v0eDfja2rzGZlrz4SwpjrSlqWy+hCbA==
X-Google-Smtp-Source: AGHT+IE9vcWcYllkWI3EinDWyIbJI0sBh3SbZhQSKCR9N9YHcaEjEJY6wjHcuJEDcQ9WdyKiqkxyeVmX/MhO+mtTLxE=
X-Received: by 2002:a17:903:234a:b0:202:ad1:8c84 with SMTP id
 d9443c01a7336-2039e67c9c1mr82441065ad.52.1724668141024; Mon, 26 Aug 2024
 03:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240809095430.3656-1-richard@nod.at>
 <20240809095430.3656-3-richard@nod.at>
In-Reply-To: <20240809095430.3656-3-richard@nod.at>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 13:28:24 +0300
Message-ID: <CAC_iWj+Jq5WrQT5W0Wkt6UnUijTyV3H=AZEyD5T+MZOQJ5k6UA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ext4: Fix zalloc()
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, sjg@chromium.org, Jixiong.Hu@mediatek.com, 
 marek.vasut+renesas@mailbox.org, patrick.delaunay@foss.st.com, 
 xypron.glpk@gmx.de, seanga2@gmail.com, trini@konsulko.com, 
 upstream+uboot@sigma-star.at
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

On Fri, 9 Aug 2024 at 12:55, Richard Weinberger <richard@nod.at> wrote:
>
> Currently, zalloc() calls uncondtionally memset(),
> if the allocation failes, memset() will write to a null pointer.
>
> Fix by using kzalloc().
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/ext4/ext4_common.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/ext4_common.h b/fs/ext4/ext4_common.h
> index 84500e990a..346752092b 100644
> --- a/fs/ext4/ext4_common.h
> +++ b/fs/ext4/ext4_common.h
> @@ -24,6 +24,7 @@
>  #include <ext4fs.h>
>  #include <malloc.h>
>  #include <asm/cache.h>
> +#include <linux/compat.h>
>  #include <linux/errno.h>
>  #if defined(CONFIG_EXT4_WRITE)
>  #include "ext4_journal.h"
> @@ -43,9 +44,7 @@
>
>  static inline void *zalloc(size_t size)
>  {
> -       void *p = memalign(ARCH_DMA_MINALIGN, size);
> -       memset(p, 0, size);
> -       return p;
> +       return kzalloc(size, 0);
>  }
>
>  int ext4fs_read_inode(struct ext2_data *data, int ino,
> --
> 2.35.3
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
