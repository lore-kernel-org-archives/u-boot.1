Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACF8CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 07:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A990F83EF9;
	Wed, 13 May 2026 09:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MdXne/x/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A55DC83FB0; Wed, 13 May 2026 09:58:44 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559E48056B
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65dead17c24so1388087d50.2
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 00:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778659120; cv=none;
 d=google.com; s=arc-20240605;
 b=GvxUUMkpN1oyIbk8r/bjSnUenqzaWEaDrsHK6R1s65bHOtdBLKAxIxtOUTgQJ/B7Em
 M9MYqifUntUhGDI3oQqAUF0WdBKc+Zjl6fR0yyHi01Zw8wz0SuMD9d8//0VmHOz4/g0E
 Vytxu524ZH6uYVYVmJD5J0FDfySLloS+J1RjzSPhJlpHREBl7wGDiZS2br6phJPe47Sa
 PEMUS62FodWWABxGlDSqjE/72O7ZMh95a+cX1MWdgp/USDVsfj8V4Yr6FIRvxfkUWRam
 iTwgU1eVkh0gYuHALpwqdpQYWKFIrh8DJqSso6pDF3CQcqnggJYczDyIwvXD3GNX0b3f
 7wQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rUeYYUf2Tibgep2ddgBj3mIvtyuQ9gJv3ypDastQTpg=;
 fh=IsalMz2FY5JWz2oFhaOZj3PTm0hegIlUglxu4NRuALY=;
 b=eNlrYE18Vc1KCJZDcSZZzKuE5ArSWYdOeFhdBfLu2dL6sQM18XaPY5tk5WAvvxnQd7
 zVwSJULnn9jILWe17H9o1CtuNVK0fP7rqgJLC7wJXX94ClahaNFzURGVqYswFg0+NsBC
 6OzVV1XKvd/kzkrY8pFF+UlyruxsdPLvirEKtIFo4LQAEAzLu6SEnb1PIU+vYGdwJpfH
 9EnnCwFUF4Runo+Jqe8xHShLY0QDROT8Oeug1ZvimS0D+2AIHp5MCbHC8PlfJwHF63RR
 mKvCKCijF5yICZ0qmIntd97tzKYOc1mtej1DXJXxT1d9IDtmpSwuIiOUfu4u/DznL7I9
 xSpQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778659120; x=1779263920; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rUeYYUf2Tibgep2ddgBj3mIvtyuQ9gJv3ypDastQTpg=;
 b=MdXne/x/q+ta8dpEWXj8I7y8Ow55iwngTtioseY0Lq3I5kYVYcfjxnimsoFxDzvdpp
 R2Eg/2l/iHWwrsjvkK3ohS4e3vY/0YaAHvveXOkp8atJbqfuNJILMj+2sAF4A0NlRDjf
 QCiX9UJ9QAc9pbGK00X0PUl8TTNJlTvoWZmrYX68s+an5A0G2EV0ebryBrjE6m0qmhpr
 9a436kJn+qtUKF+h1wH1wLTMNYU+Dp82ne5TIBpCgByPNuhs5FCVjphgkkl16wqpOpPH
 5XjqDwmrU1jPzmjVwkpyaLc2z4Vz8+l+yiSLWZy4V8z5jfkAzstldPp8Bxc7dDhodaQk
 vNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778659120; x=1779263920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUeYYUf2Tibgep2ddgBj3mIvtyuQ9gJv3ypDastQTpg=;
 b=PLWtDtFu0QM6vMvb1YXF0pRcB4EUbbbrq2/iJxsGGYV4fhmI+B0eQWVdN73FuGut8t
 OesVamS075CeL3OKH5HVkgllbizb3wW0YkEyfqy7lyzwn/hCh8NTggOSzcFbtGhTZ6ie
 +tNdLJ7jz7olGWmtfsbaZ/vHYXYKms8gCe8oyHyctMIl7yss+r7lC71v/R+/GZqOolhB
 ccql09qNu0h2h6M1qpmXtidWFwFhiuqSiZMXVPpuDB0f91KH13owoSguKEiAqoCoWwjl
 76tDJpmUPE5bWt4DHQqPvh/nhQWji4zgnul+pfKp/EivZX56uJIKZB4y6v+gpcLl2ZiT
 BpDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bJryhebs8ZOmdDUSoOzBEMK3fM5vBzH0+S5EK6MuYeKsJn5qzRFFVKiPguRJA9m1IsEuthoU=@lists.denx.de
X-Gm-Message-State: AOJu0YwhvrzEhJx20FCe09oSibV3iSB5Ran2d7ceVCBW8p00DYovSx5a
 Rf92m07ljf9HyEr+FTpHFsarkYNoxZpdluEbuzDsmYOyQwvTqh1X9+nl0lGoZFb4nOJRCyQpp0p
 nYeqy/BTcaJmHTgthot9rUG5T/IdZQ3HlMXN97heZTQ==
X-Gm-Gg: Acq92OGUvxe/U7V61oMXjsSq1cvy3krYUuFuT3MImToRrcHWNfnrhz/GeT6RhIjcksd
 1C8kbLRrMYHzmE6OJxlwcwloJrqmMuTzPAZAPPLAxfiEHv4K0Bq23mjR+F0n3v3d96vD9qgBWDf
 8PU+rGvXqB0Do+qEzlxySU5B4gz2nFAfNQJFT2g2cNxwgKgrvmPmXYXpAe+4M0YPR5kG3DQT2Gj
 7Ol2w+tV4FtOW6ySuWfSVIjWoBRp7sZ5BKqFCmjtFJKWqHugRxXrzDPVkMHLw3zSBEOx9ATTqxp
 uznrm+RXLaJzl/peaB3oSJuaHPni27pAazKti963e6qQe1qFkAgc298x7euKNlrYW3oqSZma2C3
 h6mtAcmS80bUBA9IOdrC7zcbv5kTXn7mCrPufBLJLFBTZhD70WBTA+XeBzq7mpx/n1t8a86uD8v
 jr2wqFj5smy/IzpJYvUb4aTRy80qb0U21+aCPJPB1fufZe249eU7wGnuVPaa+zbyO5Ft9cG5H3M
 E/Ld2o3O5R86OnPAlJmHgGwrW+X2gz2wE4UGWmCWW+hNye8SICPixbrLbKrP8DiVyPmblXrKqfe
 Ks2Iu8+IvK/ZmM3rYfUb30PkZqlSxGEUpdjEj9/HGjPw/2SvhkMTrDcEaEhUd5Kh1PojhvJN/ta
 SeVZaVA==
X-Received: by 2002:a05:690e:4185:b0:651:c782:6a8 with SMTP id
 956f58d0204a3-65df621374dmr1895699d50.15.1778659119880; Wed, 13 May 2026
 00:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com>
 <20260512-net-lwip-add-stop-function-v2-1-85146da317dd@baylibre.com>
In-Reply-To: <20260512-net-lwip-add-stop-function-v2-1-85146da317dd@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 May 2026 10:58:02 +0300
X-Gm-Features: AVHnY4Kvj-IkMUJVvbRVS5FqTQFnxn9rFkMSE68GSRNi4NTSXRqD0aAzQHmoqwU
Message-ID: <CAC_iWjJvR__Ud8Zc3V7LEc34Lwj0UgozQuw7Tj794dEWbGMepg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: lwip: wget: fix error handling in
 wget_do_request()
To: David Lechner <dlechner@baylibre.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
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

Hi David,

On Wed, 13 May 2026 at 00:48, David Lechner <dlechner@baylibre.com> wrote:
>
> Split wget_do_request() into two functions to make error handling less
> error-prone.
>
> After a successful call to net_lwip_new_netif(), net_lwip_remove_netif()
> must always be called to leaks.

prevent leaks*

> This was missed in the HTTPS section of
> the code where we returned on error without cleaning up.

I'd prefer making this a bit more explicit. net_lwip_remove_netif()
was called in case of a failure afaict. The only place that wasn's
called is when checking the cacert_auth_mode, right?

Anyway, I think Jerome can fix them up during the PR

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks
/Ilias

>
> Instead of adding more calls to net_lwip_remove_netif(), refactor the
> code into two functions. The outer function handles managing the netif
> lifecycle. The inner function no longer has to worry about cleaning up
> before returning on error.
>
> To keep things simple, the `path` local variable is removed during the
> refactoring. Instead, ctx.path is used directly everywhere.
>
> Fixes: 3c656c928bd7 ("net: lwip: add wget command")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  net/lwip/wget.c | 88 ++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 47 insertions(+), 41 deletions(-)
>
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 502c0faebb2..f89a6580b41 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -292,45 +292,17 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
>  #if CONFIG_IS_ENABLED(WGET_CACERT)
>  #endif
>
> -int wget_do_request(ulong dst_addr, char *uri)
> +static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
> +                              struct udevice *udev, struct netif *netif)
>  {
>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>         altcp_allocator_t tls_allocator;
>  #endif
>         httpc_connection_t conn;
>         httpc_state_t *state;
> -       struct udevice *udev;
> -       struct netif *netif;
> -       struct wget_ctx ctx;
> -       char *path;
> -       bool is_https;
> -
> -       ctx.daddr = dst_addr;
> -       ctx.saved_daddr = dst_addr;
> -       ctx.done = NOT_DONE;
> -       ctx.size = 0;
> -       ctx.prevsize = 0;
> -       ctx.start_time = 0;
> -       ctx.content_len = 0;
> -       ctx.hash_count = 0;
> -
> -       if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
> -               return CMD_RET_USAGE;
> -
> -       if (net_lwip_eth_start() < 0)
> -               return CMD_RET_FAILURE;
> -
> -       if (!wget_info)
> -               wget_info = &default_wget_info;
> -
> -       udev = eth_get_dev();
> -
> -       netif = net_lwip_new_netif(udev);
> -       if (!netif)
> -               return -1;
>
>         /* if URL with hostname init dns */
> -       if (!ipaddr_aton(ctx.server_name, NULL) && net_lwip_dns_init())
> +       if (!ipaddr_aton(ctx->server_name, NULL) && net_lwip_dns_init())
>                 return CMD_RET_FAILURE;
>
>         memset(&conn, 0, sizeof(conn));
> @@ -374,11 +346,10 @@ int wget_do_request(ulong dst_addr, char *uri)
>                 tls_allocator.alloc = &altcp_tls_alloc;
>                 tls_allocator.arg =
>                         altcp_tls_create_config_client(ca, ca_sz,
> -                                                      ctx.server_name);
> +                                                      ctx->server_name);
>
>                 if (!tls_allocator.arg) {
>                         log_err("error: Cannot create a TLS connection\n");
> -                       net_lwip_remove_netif(netif);
>                         return -1;
>                 }
>
> @@ -388,24 +359,20 @@ int wget_do_request(ulong dst_addr, char *uri)
>
>         conn.result_fn = httpc_result_cb;
>         conn.headers_done_fn = httpc_headers_done_cb;
> -       ctx.path = path;
> -       if (httpc_get_file_dns(ctx.server_name, ctx.port, path, &conn, httpc_recv_cb,
> -                              &ctx, &state)) {
> -               net_lwip_remove_netif(netif);
> +       if (httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &conn,
> +                              httpc_recv_cb, ctx, &state)) {
>                 return CMD_RET_FAILURE;
>         }
>
>         errno = 0;
>
> -       while (!ctx.done) {
> +       while (!ctx->done) {
>                 net_lwip_rx(udev, netif);
>                 if (ctrlc())
>                         break;
>         }
>
> -       net_lwip_remove_netif(netif);
> -
> -       if (ctx.done == SUCCESS)
> +       if (ctx->done == SUCCESS)
>                 return 0;
>
>         if (errno == EPERM && !wget_info->silent)
> @@ -414,6 +381,45 @@ int wget_do_request(ulong dst_addr, char *uri)
>         return -1;
>  }
>
> +int wget_do_request(ulong dst_addr, char *uri)
> +{
> +       struct udevice *udev;
> +       struct wget_ctx ctx;
> +       struct netif *netif;
> +       bool is_https;
> +       int ret;
> +
> +       ctx.daddr = dst_addr;
> +       ctx.saved_daddr = dst_addr;
> +       ctx.done = NOT_DONE;
> +       ctx.size = 0;
> +       ctx.prevsize = 0;
> +       ctx.start_time = 0;
> +       ctx.content_len = 0;
> +       ctx.hash_count = 0;
> +
> +       if (parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https))
> +               return CMD_RET_USAGE;
> +
> +       if (net_lwip_eth_start() < 0)
> +               return CMD_RET_FAILURE;
> +
> +       if (!wget_info)
> +               wget_info = &default_wget_info;
> +
> +       udev = eth_get_dev();
> +
> +       netif = net_lwip_new_netif(udev);
> +       if (!netif)
> +               return -1;
> +
> +       ret = wget_handle_request(&ctx, is_https, udev, netif);
> +
> +       net_lwip_remove_netif(netif);
> +
> +       return ret;
> +}
> +
>  /**
>   * wget_validate_uri() - validate the uri for wget
>   *
>
> --
> 2.43.0
>
