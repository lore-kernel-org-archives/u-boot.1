Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213CED4920F
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 12:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7071788E61;
	Mon, 18 Nov 2024 13:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fdZzbRor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 189F989433; Mon, 18 Nov 2024 13:24:13 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89EED88E61
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ea7e2ff5ceso3047559a12.2
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 04:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731932649; x=1732537449; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=65Cgc0LOKz77zBNxb7tSN7QUdMIVkjS9r/2lc04UCl8=;
 b=fdZzbRoror1jv7cnMCgXm+4Z9kLVPgzhdj+VJ7ZUINJgYfhf7iNWQAYqPwmVqdyq6c
 KKk3iFmQBz1IFaqwQuYZ71GTKTPBq+xF2nB62t8vDy10UxZ7oQ+NSwTE7JsfvPGS7GKr
 8Ylj6xLLhYyG/F3s1lBe7lO2vGmeRc36NWquDngijmGVY7z0+s/sPl7Xpoyyu6/YwYko
 dVJ/yl10FKcFw/PA9mK1Qq1OFJtnkitm8z1zLnuSYoIGbPLc36pGsqhnZnMqW8l/6ify
 SkjzioWqD7uzQ/wZdhvRlUF3lgdjmES1LMAxgndN1izYctOpMNYJnBBR1YQyZp1V56To
 Uu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731932649; x=1732537449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=65Cgc0LOKz77zBNxb7tSN7QUdMIVkjS9r/2lc04UCl8=;
 b=SCjjbd4K/zYz+yiL0Q7HNmX8it9OoYuBC2wbidZt6z7ShfOTdixaGfpucxTYf+yMsD
 D8Uu8lOZH/ENCcsVJEFhfsN2ijte9LOb7BmNOuTpCYSlgaQVrsK+Y+yIa/4damgzR/Zm
 1EGlPG4b/nowcTAPn+K6f9gp3zQK4pL6AuK29ThZSTYSmww/UJNIxg2QqyfnHpNTct/7
 PFOFgDH6Y+/Gv86V6yX67TPlIXZfzLGmZfGsP5AHJKiytmxFsIT6K0DxTdhJ+vjgS4HE
 U6sMjOM37+2XBveSsGgJUItmmSoOBoXHrh8zYd2o9ymYvIfQOcVa3e63wNcG999nMcgf
 2PJg==
X-Gm-Message-State: AOJu0YzPXJ5wTDn+UN5W8rsvUvQk7TbHE4rcX6RUka01m2NjPtVo8t2P
 wDGdLf89e8J6FCUsFd2b2Lq788SIwuIpCpdDL8G9ssPgpU6TKRUl0zzGoAfh3UkYmos5d/c4bHb
 6iMigxgJ0NV4B2wARGZjDQ1PpGs0IOzAcvhnHRA==
X-Google-Smtp-Source: AGHT+IEbByXIMuY/Nqzz89vaVFr4FcB0jqN3DR5pG5rsRIKEdRI+CytDEz+SR4Ou0wmNN75l3j86OUJyrv1M+JVSsok=
X-Received: by 2002:a17:90b:4a8e:b0:2ea:6ad7:8f39 with SMTP id
 98e67ed59e1d1-2ea6ad7917dmr4923799a91.29.1731932649025; Mon, 18 Nov 2024
 04:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-10-adrianox@gmail.com>
In-Reply-To: <20241111210959.560738-10-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 18 Nov 2024 14:23:31 +0200
Message-ID: <CAC_iWjLPO-vq6OzZMOYqcE4J+fDH589v7R1z9Dfzjs9=xx5SUQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] efi_loader: net: set EFI bootdevice device path
 to HTTP when loaded from wget
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de
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

On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Set the device path of the efi boot device to an HTTP device path
> (as formed by efi_dp_from_http) when the next boot stage is loaded
> using wget (i.e., when wget is used with wget_info.set_bootdev=1).

We want the reasoning of why you need the change in the commit log,
instead of what the code does.

>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> (no changes since v2)
>
>  include/efi_loader.h             |  6 ++++++
>  lib/efi_loader/efi_device_path.c |  2 +-
>  lib/efi_loader/efi_net.c         | 22 +++++++++++++++++++++-
>  net/lwip/wget.c                  |  1 +
>  net/wget.c                       |  1 +
>  5 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 96b204dfc3..f49f8e6be0 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -126,6 +126,10 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
>  #endif
>
>  #if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
> +/* Call this to update the current device path of the efi net device */
> +void efi_net_set_dp(const char *dev, const char *server);
> +/* Call this to get the current device path of the efi net device */
> +void efi_net_get_dp(void **dp);
>  void efi_net_get_addr(struct efi_ipv4_address *ip,
>                       struct efi_ipv4_address *mask,
>                       struct efi_ipv4_address *gw);
> @@ -133,6 +137,8 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
>                       struct efi_ipv4_address *mask,
>                       struct efi_ipv4_address *gw);
>  #else
> +static inline void efi_net_set_dp(const char *dev, const char *server) { }
> +static inline void efi_net_get_dp(void **dp) { }
>  static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
>                                      struct efi_ipv4_address *mask,
>                                      struct efi_ipv4_address *gw) { }
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index 158f08b9e5..afb4abc3ff 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1168,7 +1168,7 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
>                 dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
>                                      (uintptr_t)image_addr, image_size);
>         } else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
> -               dp = efi_dp_from_eth();
> +               efi_net_get_dp((void **)&dp);
>         } else if (!strcmp(dev, "Uart")) {
>                 dp = efi_dp_from_uart();
>         } else {
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index dd84b3f18d..d4570d4d7c 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -16,6 +16,7 @@
>   */
>
>  #include <efi_loader.h>
> +#include <dm.h>
>  #include <malloc.h>
>  #include <vsprintf.h>
>  #include <net.h>
> @@ -31,6 +32,7 @@ static size_t *receive_lengths;
>  static int rx_packet_idx;
>  static int rx_packet_num;
>  static struct efi_net_obj *netobj;
> +static struct efi_device_path *net_dp;
>
>  /*
>   * The notification function of this event is called in every timer cycle
> @@ -902,8 +904,10 @@ efi_status_t efi_net_register(void)
>                              &netobj->net);
>         if (r != EFI_SUCCESS)
>                 goto failure_to_add_protocol;
> +       if (!net_dp)
> +               efi_net_set_dp("Net", NULL);
>         r = efi_add_protocol(&netobj->header, &efi_guid_device_path,
> -                            efi_dp_from_eth());
> +                            net_dp);
>         if (r != EFI_SUCCESS)
>                 goto failure_to_add_protocol;
>         r = efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_guid,
> @@ -999,6 +1003,22 @@ out_of_resources:
>         return EFI_OUT_OF_RESOURCES;
>  }
>
> +void efi_net_set_dp(const char *dev, const char *server)
> +{
> +       if (!strcmp(dev, "Net"))
> +               net_dp = efi_dp_from_eth();
> +       else if (!strcmp(dev, "Http"))
> +               net_dp = efi_dp_from_http(server);
> +}
> +
> +void efi_net_get_dp(void **dp)
> +{
> +       if (!net_dp)
> +               efi_net_set_dp("Net", NULL);
> +       if (dp && net_dp)
> +               *dp = efi_dp_dup(net_dp);
> +}
> +
>  void efi_net_get_addr(struct efi_ipv4_address *ip,
>                       struct efi_ipv4_address *mask,
>                       struct efi_ipv4_address *gw)
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 53c3b169e0..5c44e324be 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -217,6 +217,7 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>         print_size(rx_content_len / elapsed * 1000, "/s)\n");
>         printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
>         if (wget_info->set_bootdev) {
> +               efi_net_set_dp("Http", ctx->server_name);
>                 efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0),
>                                 rx_content_len);
>         }
> diff --git a/net/wget.c b/net/wget.c
> index 36158e0a9c..676d4db759 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -442,6 +442,7 @@ static void wget_handler(uchar *pkt, u16 dport,
>                 net_set_state(wget_loop_state);
>                 wget_info->file_size = net_boot_file_size;
>                 if (wget_info->method == WGET_HTTP_METHOD_GET && wget_info->set_bootdev) {
> +                       efi_net_set_dp("Http", NULL);
>                         efi_set_bootdev("Net", "", image_url,
>                                         map_sysmem(image_load_addr, 0),
>                                         net_boot_file_size);
> --
> 2.43.0
>
