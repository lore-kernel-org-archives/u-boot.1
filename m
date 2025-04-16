Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16461C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 10:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D44782C96;
	Wed, 16 Apr 2025 12:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XXEqJMpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F3D82CBC; Wed, 16 Apr 2025 12:22:18 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 151B782B44
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 12:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-523f721bc63so570563e0c.0
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 03:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744798935; x=1745403735; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t8+HVMT2Dp1Nu8P3i1Q6wRbQRuHfOsAlcRKEWQc+QY0=;
 b=XXEqJMpJ5dGRCPGSK9g9eYDG/1HzTUCaiROBkF0q5MA+roxP8eTksu1Bk5Nhrqtmh5
 yxuyN5PLQramtE7q5CrK0Ec+SXsBfAThxteqgKU6aAjwd+RzFz+OnFdye6dEbJCwEIM7
 gDixqdCKAMs6d8PRbFSPZt8fV0ZzNssqneSAsFZ4EzmjK2nsxFEdsInNKTD7caS5Fg2Z
 aC0fP5V/MJzkViRW+7rqZKIBW99hI7/Jq4AwMWpLrCfE47sMgRPmYVLTJMFiLAvk7Edb
 QjkokzSRT9jVJkVXZeekbPg4pnut7qAhQFMFBch83leeaxBS6AOFXLJ6jdRM1B2JuXUK
 gZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744798935; x=1745403735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t8+HVMT2Dp1Nu8P3i1Q6wRbQRuHfOsAlcRKEWQc+QY0=;
 b=DkDKrAG+giB2cjB4YfFE6pKuDbteTbA1xbdWKr5tdrQ3rRV66P24t+hf9T3gc5DTAY
 GEMt9URXAkNPnKSn8j1N5oy7a6AuIjYxh+zb8UasK0cI/w8skP1uIjKk2ksGh15ET1DZ
 e4O6XkKMqAXruqLUnADDOEw9CBF6ibpNdP8j+2n0T2ERlbT28CEj5PeSQU+FvlbEdyOl
 J9sPC7lc1afvtvpBd0CRWjZYsKyQbQ9X1SG1Xo7wSHp5ptt0A1Xpl97BWWYrFDkRAKSM
 gosPd2KixoqrjlywsAekJ5kKaDhpURXNu1G42EAepN9sD6MrjOOW1AwNYCGxfEhkZjiO
 TMjg==
X-Gm-Message-State: AOJu0YyO+SEXAb8OXluIGNQJW8b26nbbVxBO9epkSOyOJIWI5EtDXVB9
 /XHE+SzakdbnjeghOagjwtU5LzI14nNe5swfNudJjM9FgsWZTnp23Ec1l4P1wOFtDbRzN5hEGQY
 Bg2wXLKCZGTOHRNUrRSP5zkVcamZb/8+DlvDmWw==
X-Gm-Gg: ASbGncsw/wOIJ7Cv10O2NilQV9JI2TXJSlp2bfgj24vNWfgf5TDYoYxudQuP0EUZj/G
 mUuC5V/lKvqCoJUvZVqZ84FNIGGKu6LNpPs5g5sMw7ikBjF75tKf53OExTk12IUo/ZhxDS+r1hb
 d1qwUR07LQBLctcj5GBFG9jO4=
X-Google-Smtp-Source: AGHT+IFrQGRugn7i0HKlvnRbaHjJxjla+H8pTA3SkkKjlk8KEilGIERM13VYAYrDDQknRZVUGyKMd1vC+SiHk6eaPWo=
X-Received: by 2002:a67:ff97:0:b0:4c2:ff6c:6043 with SMTP id
 ada2fe7eead31-4cb59498c7bmr324189137.0.1744798934813; Wed, 16 Apr 2025
 03:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250415193436.1240804-1-jerome.forissier@linaro.org>
 <20250415193436.1240804-3-jerome.forissier@linaro.org>
In-Reply-To: <20250415193436.1240804-3-jerome.forissier@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 16 Apr 2025 15:52:03 +0530
X-Gm-Features: ATxdqUH_J5u8OG3m4RvHLNJaD689gjXgXQVu_bAqc8F3KkuwdieElPVPnZzdtnI
Message-ID: <CADg8p94L3tNj=FbBHn8h2DetWd7qeKPRMMbS0c4y6ccCaDm70g@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] net, net-lwip: wget: suppress console output when
 called by EFI
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, 
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

On Wed, 16 Apr 2025 at 01:04, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Functions called from EFI applications should not do console output.
> Refactor the wget code to implement this requirement. The wget_http_info
> struct is used to hold the boolean that signifies whether the output is
> allowed or not.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> Changes in v4:
> - Patch renamed, deals with NET in addition to NET_LWIP
>
> Changes in v3:
> - New patch
>
>  include/net-common.h     |  2 ++
>  lib/efi_loader/efi_net.c |  2 +-
>  net/lwip/wget.c          | 33 +++++++++++++++++++++++----------
>  net/wget.c               | 23 +++++++++++++++++------
>  4 files changed, 43 insertions(+), 17 deletions(-)
>
> diff --git a/include/net-common.h b/include/net-common.h
> index 30860f5975a..1043b24d0b9 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -555,6 +555,7 @@ enum wget_http_method {
>   *                     Filled by client.
>   * @hdr_cont_len:      content length according to headers. Filled by wget
>   * @headers:           buffer for headers. Filled by wget.
> + * @silent:            do not print anything to the console. Filled by client.
>   */
>  struct wget_http_info {
>         enum wget_http_method method;
> @@ -565,6 +566,7 @@ struct wget_http_info {
>         bool check_buffer_size;
>         u32 hdr_cont_len;
>         char *headers;
> +       bool silent;
>  };
>
>  extern struct wget_http_info default_wget_info;
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index b3291b4f1d5..9ff0b691ee1 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -51,7 +51,7 @@ static int next_dp_entry;
>  static struct wget_http_info efi_wget_info = {
>         .set_bootdev = false,
>         .check_buffer_size = true,
> -
> +       .silent = true,
>  };
>  #endif
>
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 2b512a1bc84..3529768eb06 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -217,7 +217,8 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
>                 memcpy((void *)ctx->daddr, buf->payload, buf->len);
>                 ctx->daddr += buf->len;
>                 ctx->size += buf->len;
> -               if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
> +               if (!wget_info->silent &&
> +                   ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
>                         printf("#");
>                         ctx->prevsize = ctx->size;
>                 }
> @@ -255,11 +256,15 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>         elapsed = get_timer(ctx->start_time);
>         if (!elapsed)
>                 elapsed = 1;
> -       if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
> -               printf("\n");
> -       printf("%u bytes transferred in %lu ms (", rx_content_len, elapsed);
> -       print_size(rx_content_len / elapsed * 1000, "/s)\n");
> -       printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
> +       if (!wget_info->silent) {
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
> @@ -339,7 +344,8 @@ static int _set_cacert(const void *addr, size_t sz)
>         mbedtls_x509_crt_init(&crt);
>         ret = mbedtls_x509_crt_parse(&crt, cacert, cacert_size);
>         if (ret) {
> -               printf("Could not parse certificates (%d)\n", ret);
> +               if (!wget_info->silent)
> +                       printf("Could not parse certificates (%d)\n", ret);
>                 free(cacert);
>                 cacert = NULL;
>                 cacert_size = 0;
> @@ -392,6 +398,12 @@ int wget_do_request(ulong dst_addr, char *uri)
>         ctx.prevsize = 0;
>         ctx.start_time = 0;
>
> +       if (!wget_info)
> +               wget_info = &default_wget_info;
> +
> +       net_lwip_set_current();
> +       udev = eth_get_dev();
> +

Wasn't this already done in the first patch? Looks like this hunk is
superfluous. Apart from that, it looks fine to me. Thanks for taking
up this change.

-sughosh

>         if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
>                 return CMD_RET_USAGE;
>
> @@ -421,9 +433,10 @@ int wget_do_request(ulong dst_addr, char *uri)
>
>                 if (cacert_auth_mode == AUTH_REQUIRED) {
>                         if (!ca || !ca_sz) {
> -                               printf("Error: cacert authentication mode is "
> -                                      "'required' but no CA certificates "
> -                                      "given\n");
> +                               if (!wget_info->silent)
> +                                       printf("Error: cacert authentication "
> +                                              "mode is 'required' but no CA "
> +                                              "certificates given\n");
>                                 return CMD_RET_FAILURE;
>                        }
>                 } else if (cacert_auth_mode == AUTH_NONE) {
> diff --git a/net/wget.c b/net/wget.c
> index c73836cbc9d..3c0fff488eb 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -59,8 +59,10 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
>         if (CONFIG_IS_ENABLED(LMB) && wget_info->set_bootdev) {
>                 if (store_addr < image_load_addr ||
>                     lmb_read_check(store_addr, len)) {
> -                       printf("\nwget error: ");
> -                       printf("trying to overwrite reserved memory...\n");
> +                       if (!wget_info->silent) {
> +                               printf("\nwget error: ");
> +                               printf("trying to overwrite reserved memory\n");
> +                       }
>                         return -1;
>                 }
>         }
> @@ -76,6 +78,9 @@ static void show_block_marker(u32 packets)
>  {
>         int cnt;
>
> +       if (wget_info->silent)
> +               return;
> +
>         if (content_length != -1) {
>                 if (net_boot_file_size > content_length)
>                         content_length = net_boot_file_size;
> @@ -101,11 +106,15 @@ static void tcp_stream_on_closed(struct tcp_stream *tcp)
>         net_set_state(wget_loop_state);
>         if (wget_loop_state != NETLOOP_SUCCESS) {
>                 net_boot_file_size = 0;
> -               printf("\nwget: Transfer Fail, TCP status - %d\n", tcp->status);
> +               if (!wget_info->silent)
> +                       printf("\nwget: Transfer Fail, TCP status - %d\n",
> +                              tcp->status);
>                 return;
>         }
>
> -       printf("\nPackets received %d, Transfer Successful\n", tcp->rx_packets);
> +       if (!wget_info->silent)
> +               printf("\nPackets received %d, Transfer Successful\n",
> +                      tcp->rx_packets);
>         wget_info->file_size = net_boot_file_size;
>         if (wget_info->method == WGET_HTTP_METHOD_GET && wget_info->set_bootdev) {
>                 efi_set_bootdev("Http", NULL, image_url,
> @@ -139,7 +148,8 @@ static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
>                     tcp->state == TCP_ESTABLISHED)
>                         goto end;
>
> -               printf("ERROR: misssed HTTP header\n");
> +               if (!wget_info->silent)
> +                       printf("ERROR: misssed HTTP header\n");
>                 tcp_stream_close(tcp);
>                 goto end;
>         }
> @@ -346,7 +356,8 @@ void wget_start(void)
>         tcp_stream_set_on_create_handler(tcp_stream_on_create);
>         tcp = tcp_stream_connect(web_server_ip, server_port);
>         if (!tcp) {
> -               printf("No free tcp streams\n");
> +               if (!wget_info->silent)
> +                       printf("No free tcp streams\n");
>                 net_set_state(NETLOOP_FAIL);
>                 return;
>         }
> --
> 2.43.0
>
