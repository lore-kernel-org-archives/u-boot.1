Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65944C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 09:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A87FF81F6B;
	Mon, 14 Apr 2025 11:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zyNesDjT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC93381F7B; Mon, 14 Apr 2025 11:10:46 +0200 (CEST)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D1D28197F
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 11:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-86d75f4e9a1so1592286241.3
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 02:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744621843; x=1745226643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NBf40b6J2FlVZC6YKvCYldgTJMmz70NhV0D3eZZHhJU=;
 b=zyNesDjTLTiIEw101nggDW5baH5IntH1pvdS/kFEo9zCdaYFt7uew2xRV6lrye0ENC
 OuB8zMbqBN+EmXyLs95eOprRBNIIvxZIK7rDSbUQeT492snr3R01ocWy/FTdy87R+ewv
 3R7ydRyhvFcU26F2oAP4AA3d9YHjOAi2tHGlobPzqCOQXn8TGwZWAJlf520b+9AjEv29
 2QyhaXfbd4m1sMpUeXIF8PrVnc2kAvDJjnVwp5LfUEF3Cd2jbCwO3kucsMv5Y6qZCjnt
 NyBKg1p7N5E+KvqHrmhmKl3C6Meazo5sBZ+z58ouKEsa7N2Tgnr325gqXegUMsiXgBaL
 P1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744621843; x=1745226643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NBf40b6J2FlVZC6YKvCYldgTJMmz70NhV0D3eZZHhJU=;
 b=wcwH+vAsxiASK143E73eHoavC69GL2iDKeZemIS+JwPHB4wI5Cgta5t0khe3T/2ajk
 HOERpZjNjuOR5A+XkqeRLwzTG1K836rI6XTYp82ATyEYBsMNcvqoWJCPGYW+T8YZkBB9
 IARolf2PspvjmJkb4m0ilJX3s4JPNN2JyYCrkadppAWhON6Sjl0ECZu7IYai8H1fJynH
 TDIdMSmnQp+r1oNlgOL4rV7dgR4LO6r8mIOikkMeFRk6+WeWG4Ua/64aLLsYhnLH7k0A
 +REk6iUiFKZ0evet0DEiKa2AwkcopikhugWFeMrzkx4M0opepoQUrrBsPGRsLfEl1xj5
 wUeA==
X-Gm-Message-State: AOJu0Yxgf7EqwgVKatUhiuEixK5ddXTr0YNnbK0H3MgFPAUGh9QyLWwp
 +9oyEbzZBrQ/ladtqFRLy+sZiVCuFQw+GJ6bT4WluHkV9Aim1ADsVHWCRUIpT1pWH4WagUYvQWH
 mlkgvgn+jwT2XcZnqibioHRkSdzH/oNCkKt4rFQ==
X-Gm-Gg: ASbGncsSU/PpQJ3oLVv942Gs8y3QjTmlheCd1ZNOx92CQoICCWM+eJ793jPYtPiUApr
 dshNxrPZuKVWTeT+EPeTVfMHfCHBG1GEj7zWEIPtE5+Z0ZUSZeyW3MW2JNyqR1AIRMUNNdHnQQW
 d3mLrnNxX3ZM98HL56LlYIAjk=
X-Google-Smtp-Source: AGHT+IHaMItvrTELCTxSdrC+JCoZwIdquPunVRRylW0YQjW+chQZL9bA1/Qt2YQ72Umfs1Yx+YVcr+VKn2e/Unz50gU=
X-Received: by 2002:a05:6102:1512:b0:4bb:cf34:374d with SMTP id
 ada2fe7eead31-4c9e4fff4f3mr7460715137.20.1744621842935; Mon, 14 Apr 2025
 02:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250410151600.3370247-1-jerome.forissier@linaro.org>
 <20250410151600.3370247-2-jerome.forissier@linaro.org>
In-Reply-To: <20250410151600.3370247-2-jerome.forissier@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 14 Apr 2025 14:40:31 +0530
X-Gm-Features: ATxdqUEiMWeVpS4WLhnrpYY1NdyH-DaKMybMgSA95EjK9YvoziH81Zu0xtwqXoI
Message-ID: <CADg8p96TQB5r76Ws6k_J6TF4wKNHUj6nW63LZ+DAbctTUbhLsg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] net-lwip: wget_do_request(): do not print anything
 to the console
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Thu, 10 Apr 2025 at 20:46, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Functions called from EFI applications should not call printf().
> Refactor wget_do_request() to implement this requirement.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> Changes in v3:
> - New patch: net-lwip: wget_do_request(): do not print anything to the
>   console
>
>  net/lwip/wget.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index ec098148835..d3628cf72de 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -36,6 +36,7 @@ struct wget_ctx {
>         ulong prevsize;
>         ulong start_time;
>         enum done_state done;
> +       bool silent;
>  };
>
>  static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_len)
> @@ -217,7 +218,8 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
>                 memcpy((void *)ctx->daddr, buf->payload, buf->len);
>                 ctx->daddr += buf->len;
>                 ctx->size += buf->len;
> -               if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
> +               if (!ctx->silent &&
> +                   ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
>                         printf("#");
>                         ctx->prevsize = ctx->size;
>                 }
> @@ -255,11 +257,15 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>         elapsed = get_timer(ctx->start_time);
>         if (!elapsed)
>                 elapsed = 1;
> -       if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
> -               printf("\n");
> -       printf("%u bytes transferred in %lu ms (", rx_content_len, elapsed);
> -       print_size(rx_content_len / elapsed * 1000, "/s)\n");
> -       printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
> +       if (!ctx->silent) {
> +               if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
> +                       printf("\n");
> +               printf("%u bytes transferred in %lu ms (", rx_content_len,
> +                      elapsed);
> +               print_size(rx_content_len / elapsed * 1000, "/s)\n");
> +               printf("Bytes transferred = %lu (%lx hex)\n", ctx->size,
> +                      ctx->size);
> +       }
>         if (wget_info->set_bootdev)
>                 efi_set_bootdev("Http", ctx->server_name, ctx->path, map_sysmem(ctx->saved_daddr, 0),
>                                 rx_content_len);
> @@ -372,13 +378,14 @@ static int set_cacert(char * const saddr, char * const ssz)
>  #endif
>  #endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
>
> -static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> +static int wget_loop(ulong dst_addr, char *uri, bool silent)

Can we expand the scope to include the non-lwip functions as well? The
wget_request() API can then be modified to include the bool, and the
prints can be made silent only when calling from the EFI API -- we can
still get the error message when calling from within U-Boot. This
version does not print what the issue is, but just errors out, which
can be a bit confusing. I do see that the non-lwip wget.c module does
not work with a context. Maybe the bool can instead be in the
wget_http_info struct so that it can be used for both lwip and
non-lwip cases.

-sughosh

>  {
>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>         altcp_allocator_t tls_allocator;
>  #endif
>         httpc_connection_t conn;
>         httpc_state_t *state;
> +       struct udevice *udev;
>         struct netif *netif;
>         struct wget_ctx ctx;
>         char *path;
> @@ -390,6 +397,13 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>         ctx.size = 0;
>         ctx.prevsize = 0;
>         ctx.start_time = 0;
> +       ctx.silent = silent;
> +
> +       if (!wget_info)
> +               wget_info = &default_wget_info;
> +
> +       net_lwip_set_current();
> +       udev = eth_get_dev();
>
>         if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
>                 return CMD_RET_USAGE;
> @@ -471,12 +485,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>
>  int wget_do_request(ulong dst_addr, char *uri)
>  {
> -       net_lwip_set_current();
> -
> -       if (!wget_info)
> -               wget_info = &default_wget_info;
> -
> -       return wget_loop(eth_get_dev(), dst_addr, uri);
> +       return wget_loop(dst_addr, uri, true);
>  }
>
>  int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
> @@ -521,7 +530,7 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>                 return CMD_RET_FAILURE;
>
>         wget_info = &default_wget_info;
> -       if (wget_do_request(dst_addr, nurl))
> +       if (wget_loop(dst_addr, nurl, false))
>                 return CMD_RET_FAILURE;
>
>         return CMD_RET_SUCCESS;
> --
> 2.43.0
>
