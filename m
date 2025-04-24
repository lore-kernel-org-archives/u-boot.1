Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E0BC369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94E948056A;
	Thu, 24 Apr 2025 14:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YN98A+mt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F069806FC; Thu, 24 Apr 2025 14:51:53 +0200 (CEST)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2341803CC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-523ee30e0d4so476339e0c.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745499110; x=1746103910; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EuaagvJZB+pPHFy8Ots/6uRFV1jOocpfLYi2VIVEM6w=;
 b=YN98A+mtNy+/7rN6GDyDAGG29SU01rMuEyNjfxeGZmVzRyhtEbSpDyEaqLM9Tdj4Xt
 P+Of5EoVXuBCAUFa0KmYrXA09VHtZQp9P7FQhrRPIYEZvOr76uoH499vMNaGHP1cX5n7
 M+Qfkpz7+lYUleUoUDZic1uH5Vc2ql0GAWPQ0B9K1EpklathOFXGVR9Q3aDluk1L7pLG
 CJft41F+US+UqzF/y5SM7ApcyLaYE6bTx5zPeyAbLoedQUSnTPaK1eCXJXQinjAXDRhA
 XEvijTm97nZAJv4hfrvr66XEuUM5MajrtajDf0bufYfz53x/JKQzqO7eNYp7CKMdoj8C
 cP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745499110; x=1746103910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EuaagvJZB+pPHFy8Ots/6uRFV1jOocpfLYi2VIVEM6w=;
 b=SLJ3xxAkw6eVZc6n14AwwmaRo+/JeiimweEA4fW5rbhEwoQC/3/VVXyLFJCCQMuSHq
 vjei97Zt/+dNTmCBZcByDu76Ir91zMkpYA7CZJaKpP7/vdOPnfby2MZ9+ZJ1YVfd+vHA
 aKSZngWL2uJ8F5QdCcPcy9MJsXwN7ObkLJPbkLVU5R52LcGNQg9/YhO3Ef52gs2pO6AR
 RL/cr2nQM2+NI7E/GAChqlW2qNa5fTFiJ3wIg1exrTMU2mIABwjTrjvC/FMNBrgiXcKI
 n3UGvjSX7sgISanhpjvkXuzx4G37G1Yrlh/EwMA7Hs9WK/+nTrPxZDCcx9WC+P+qtLLm
 L+UQ==
X-Gm-Message-State: AOJu0YzDORpO62ZAshRSfpTIeBFCcL4uMd+IVT6Vnw+rCzen9F8a2BVC
 DFvNbY+vnaIPnbnPgdOCLcnYjBq7iz/KK67+Qmy7YULRFAo/Lko8aDJkpvBHJfOOi8h5e7NMh3k
 RfWyxAlxOXlMMzD7scspWsiY7eIEvSNLxRBWv2/MSUg/0eVvqmZIyBw==
X-Gm-Gg: ASbGnctBlVL04RD/UDyRG+bC+CNNwi9lPyJGhCoZwcQ2qycUDbD8XXsThVEnKTC8r3R
 TRSWp4QYrgysO/Q3GyU5fhmrQQ+Wy9VXHcyXB+xyLM7f6sbhIoWpqyTeIq78eM4bUQLCR6LSwsu
 mAG6gKDzCE23iLjrPJkgrHnf4=
X-Google-Smtp-Source: AGHT+IGMblpQCSLR6eU4AGv6gVLBtzzhEHQh2aXLnJGe6Po7FKBBfjsVtPQqmIaDPYr9L19qe+f2jd8Qdj/hrm4c9z8=
X-Received: by 2002:a05:6102:32d2:b0:4cb:6019:8e7e with SMTP id
 ada2fe7eead31-4d38eef1378mr1791534137.17.1745499109704; Thu, 24 Apr 2025
 05:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250417132718.2023555-1-jerome.forissier@linaro.org>
 <20250417132718.2023555-4-jerome.forissier@linaro.org>
In-Reply-To: <20250417132718.2023555-4-jerome.forissier@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 24 Apr 2025 18:21:37 +0530
X-Gm-Features: ATxdqUELAemtlVpgHWNUdH_-LcPLmLq1-Y0FsF7P-6y1X6v8bj6D61IFlx2HhR8
Message-ID: <CADg8p95T3rXAJXyLuyRV52sd0CbTu77ToaGSNUnkSXPziavFDQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] net-lwip: wget: add LMB and buffer checks
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On Thu, 17 Apr 2025 at 18:57, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Legacy NET wget invokes a store_block() function which performs buffer
> validation (LMB, address wrapping). Do the same with NET_LWIP.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---

Tested that the LMB checks are performed and wget/tftp commands do not
overwrite on an existing LMB reservation.

Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>

-sughosh

>
> (no changes since v4)
>
> Changes in v4:
> - The 'silent' boolean in stored in struct wget_http_info (same as NET)
>
> Changes in v3:
> - store_block(): add Sphinx-like documentation
> - store_block(): do not print to the console if ctx->silent
>
> Changes in v2:
> - httpc_recv_cb(): add a call to altcp_abort(). Otherwise the transfer
> continues and we try to write later blocks which makes no sense if one
> has been rejected already. Thanks Sughosh G. for testing and reporting.
>
>  net/lwip/wget.c | 64 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 55 insertions(+), 9 deletions(-)
>
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 63583e4c6e7..4ec00de96b2 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -6,6 +6,7 @@
>  #include <display_options.h>
>  #include <efi_loader.h>
>  #include <image.h>
> +#include <linux/kconfig.h>
>  #include <lwip/apps/http_client.h>
>  #include "lwip/altcp_tls.h"
>  #include <lwip/errno.h>
> @@ -202,11 +203,58 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
>         return 0;
>  }
>
> +/**
> + * store_block() - copy received data
> + *
> + * This function is called by the receive callback to copy a block of data
> + * into its final location (ctx->daddr). Before doing so, it checks if the copy
> + * is allowed.
> + *
> + * @ctx: the context for the current transfer
> + * @src: the data received from the TCP stack
> + * @len: the length of the data
> + */
> +static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
> +{
> +       ulong store_addr = ctx->daddr;
> +       uchar *ptr;
> +
> +       /* Avoid overflow */
> +       if (wget_info->buffer_size && wget_info->buffer_size < ctx->size + len)
> +               return -1;
> +
> +       if (CONFIG_IS_ENABLED(LMB) && wget_info->set_bootdev) {
> +               if (store_addr + len < store_addr ||
> +                   lmb_read_check(store_addr, len)) {
> +                       if (!wget_info->silent) {
> +                               printf("\nwget error: ");
> +                               printf("trying to overwrite reserved memory\n");
> +                       }
> +                       return -1;
> +               }
> +       }
> +
> +       ptr = map_sysmem(store_addr, len);
> +       memcpy(ptr, src, len);
> +       unmap_sysmem(ptr);
> +
> +       ctx->daddr += len;
> +       ctx->size += len;
> +       if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
> +               if (!wget_info->silent)
> +                       printf("#");
> +               ctx->prevsize = ctx->size;
> +       }
> +
> +       return 0;
> +}
> +
>  static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
>                            err_t err)
>  {
>         struct wget_ctx *ctx = arg;
>         struct pbuf *buf;
> +       err_t ret;
>
>         if (!pbuf)
>                 return ERR_BUF;
> @@ -215,19 +263,17 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
>                 ctx->start_time = get_timer(0);
>
>         for (buf = pbuf; buf; buf = buf->next) {
> -               memcpy((void *)ctx->daddr, buf->payload, buf->len);
> -               ctx->daddr += buf->len;
> -               ctx->size += buf->len;
> -               if (!wget_info->silent &&
> -                   ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
> -                       printf("#");
> -                       ctx->prevsize = ctx->size;
> +               if (store_block(ctx, buf->payload, buf->len) < 0) {
> +                       altcp_abort(pcb);
> +                       ret = ERR_BUF;
> +                       goto out;
>                 }
>         }
> -
>         altcp_recved(pcb, pbuf->tot_len);
> +       ret = ERR_OK;
> +out:
>         pbuf_free(pbuf);
> -       return ERR_OK;
> +       return ret;
>  }
>
>  static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
> --
> 2.43.0
>
