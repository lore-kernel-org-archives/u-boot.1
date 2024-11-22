Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42756D75E30
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 12:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B336488A3C;
	Fri, 22 Nov 2024 13:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X1K44fJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AFD788EAB; Fri, 22 Nov 2024 13:19:15 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83ABC884D2
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 13:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-720d5ada03cso1905942b3a.1
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 04:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732277951; x=1732882751; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bMDC9gQ2wzWTpMewuOxBvWMONwhGNKjnFvLQ78jof8c=;
 b=X1K44fJDjAiRczVWDSVhQ0uFZBZ3oYn2d/Oajk4jR7hjjgBJCARzqmLKG1IIMulumd
 d3Pj2lPgTXpeDWtMBd2vuhuuRW3empoi7u2xHoaWF8KQ8jkVBcosgpCQF2XS3MCDbKla
 nl2rzmc+/MXqDYGCD+xafi+AdZr+Nn9Ke+3FhGz97dfhaCRG/fMNAUn7IVOUCVN7mvAq
 aWxpA/8Gpyj1hyoSDUinrDhYJk0FkTXwW3ii+UF6KUZ5uV0nCNcc/9L64Vl5kM2MDZ4q
 GYlUigEb1yylU4bbWHaoSCKzwPuiNfdspNd9jT/GHw6IdzaNrKvP/Y8xVI56x7QmGqop
 nKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732277951; x=1732882751;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bMDC9gQ2wzWTpMewuOxBvWMONwhGNKjnFvLQ78jof8c=;
 b=TQJxZ1/HR16SS0GydfC4iLzemqZ68JnH6G8nEgkpQ75za/UHAMGe+UiSzqcWRdYr60
 ppTF0EykM7O4wKFVfxO+NLrRs7GQSo7OGklvY0Sc46+/ncn9Vr7PSQ+vqPZQl6Z13AOY
 IT7FsQkF8kt9LWu7yrGDZe1LDXHqArwqGo4BOiZ8wStFj6nk4Z1F1Jelmwh4wDzx+fNP
 ur7mmJC/Mur5h0BdiD3zhCX3DUF2xxsUB/tjojr1WMpk0UpUMKB8gCXV0mioo6M3Oxf8
 o59xIPvAYAjOIdZwH74w4FHvI06WM+2n0dTFdi3+80P65SnT2j5sjmlicToYsHc7cZQ1
 38Dg==
X-Gm-Message-State: AOJu0YwpdXEeeO/gIR79u/gFshklLQPuyFqIkUByTLJK1rFc1AU0qTcA
 D5S8O9t/2/hrDazzDfZh9rvUYZG5bAz8TsakbfKRNN/Li6vsqSX+j6ZTGSxRDhL7CzvYPeZq55q
 IpgdFghXnj0k4iY5PDjgCIoicp6F67h/Q6oufHg==
X-Gm-Gg: ASbGncvTUSGSHHOyrrR8S4btqjwt8I5yh2GUJ3m87q0BPZDj0eTNTkt/EfaAuyd1PYV
 8E8esYZLciiuUFt4bH0yObBZTiUfKYA==
X-Google-Smtp-Source: AGHT+IF2nGRJyh/I/s5Jx2gOxoZodt1rHk7T11AmY79N156Ld2g2w0Z7cLwDTcceC5jpGESfB/Zd+rIEhBe+xLr9OO0=
X-Received: by 2002:a17:90b:3b44:b0:2ea:7755:a0ee with SMTP id
 98e67ed59e1d1-2eb0e02030cmr2875133a91.4.1732277950979; Fri, 22 Nov 2024
 04:19:10 -0800 (PST)
MIME-Version: 1.0
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-7-adrianox@gmail.com>
In-Reply-To: <20241118210908.51196-7-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Nov 2024 14:18:35 +0200
Message-ID: <CAC_iWjKqv4vkfVQfjes3AXzW6JN0XVFNYeOeoLdyHZituUEWfQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] efi_loader: efi_net: add efi_net_set_addr,
 efi_net_get_addr
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

On Mon, 18 Nov 2024 at 23:09, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add the functions efi_net_set_addr and  efi_net_get_addr to set
> and get the ip address from efi code in a network agnostic way.
> This could also go in net_common, or be compiled conditionally
> for each network stack.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> Changes in v4:
>  - Removed unnecessary casts
>  - Changed char *ipstr by char ipstr[].
>
> (no changes since v2)
>  include/efi_loader.h     |  16 +++++
>  lib/efi_loader/efi_net.c | 125 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 141 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 39809eac1b..612bc42816 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -125,6 +125,22 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
>                                    size_t buffer_size) { }
>  #endif
>
> +#if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
> +void efi_net_get_addr(struct efi_ipv4_address *ip,
> +                     struct efi_ipv4_address *mask,
> +                     struct efi_ipv4_address *gw);
> +void efi_net_set_addr(struct efi_ipv4_address *ip,
> +                     struct efi_ipv4_address *mask,
> +                     struct efi_ipv4_address *gw);
> +#else
> +static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
> +                                    struct efi_ipv4_address *mask,
> +                                    struct efi_ipv4_address *gw) { }
> +static inline void efi_net_set_addr(struct efi_ipv4_address *ip,
> +                                    struct efi_ipv4_address *mask,
> +                                    struct efi_ipv4_address *gw) { }
> +#endif
> +
>  /* Maximum number of configuration tables */
>  #define EFI_MAX_CONFIGURATION_TABLES 16
>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 7cd536705f..3f0b571cc6 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -17,6 +17,7 @@
>
>  #include <efi_loader.h>
>  #include <malloc.h>
> +#include <vsprintf.h>
>  #include <net.h>
>
>  static const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
> @@ -997,3 +998,127 @@ out_of_resources:
>         printf("ERROR: Out of memory\n");
>         return EFI_OUT_OF_RESOURCES;
>  }
> +
> +/**
> + * efi_net_get_addr() - get IP address information
> + *
> + * Copy the current IP address, mask, and gateway into the
> + * efi_ipv4_address structs pointed to by ip, mask and gw,
> + * respectively.
> + *
> + * @ip:                pointer to an efi_ipv4_address struct to
> + *             be filled with the current IP address
> + * @mask:      pointer to an efi_ipv4_address struct to
> + *             be filled with the current network mask
> + * @gw:                pointer to an efi_ipv4_address struct to be
> + *             filled with the current network gateway
> + */
> +void efi_net_get_addr(struct efi_ipv4_address *ip,
> +                     struct efi_ipv4_address *mask,
> +                     struct efi_ipv4_address *gw)
> +{
> +#ifdef CONFIG_NET_LWIP
> +       char ipstr[] = "ipaddr\0\0";
> +       char maskstr[] = "netmask\0\0";
> +       char gwstr[] = "gatewayip\0\0";
> +       int idx;
> +       struct in_addr tmp;
> +       char *env;
> +
> +       idx = dev_seq(eth_get_dev());
> +
> +       if (idx < 0 || idx > 99) {
> +               log_err("unexpected idx %d\n", idx);
> +               return;
> +       }
> +
> +       if (idx) {
> +               sprintf(ipstr, "ipaddr%d", idx);
> +               sprintf(maskstr, "netmask%d", idx);
> +               sprintf(gwstr, "gatewayip%d", idx);
> +       }
> +
> +       env = env_get(ipstr);
> +       if (env && ip) {
> +               tmp = string_to_ip(env);
> +               memcpy(ip, &tmp, 4);
> +       }
> +
> +       env = env_get(maskstr);
> +       if (env && mask) {
> +               tmp = string_to_ip(env);
> +               memcpy(mask, &tmp, 4);

Using sizeof(*ip), sizeof(*mask) etc is better than just hardcoding 4 here


Cheers
/Ilias
> +       }
> +       env = env_get(gwstr);
> +       if (env && gw) {
> +               tmp = string_to_ip(env);
> +               memcpy(gw, &tmp, 4);
> +       }
> +#else
> +       if (ip)
> +               memcpy(ip, &net_ip, 4);
> +       if (mask)
> +               memcpy(mask, &net_netmask, 4);
> +#endif
> +}
> +
> +/**
> + * efi_net_set_addr() - set IP address information
> + *
> + * Set the current IP address, mask, and gateway to the
> + * efi_ipv4_address structs pointed to by ip, mask and gw,
> + * respectively.
> + *
> + * @ip:                pointer to new IP address
> + * @mask:      pointer to new network mask to set
> + * @gw:                pointer to new network gateway
> + */
> +void efi_net_set_addr(struct efi_ipv4_address *ip,
> +                     struct efi_ipv4_address *mask,
> +                     struct efi_ipv4_address *gw)
> +{
> +#ifdef CONFIG_NET_LWIP
> +       char ipstr[] = "ipaddr\0\0";
> +       char maskstr[] = "netmask\0\0";
> +       char gwstr[] = "gatewayip\0\0";
> +       int idx;
> +       struct in_addr *addr;
> +       char tmp[46];
> +
> +       idx = dev_seq(eth_get_dev());
> +
> +       if (idx < 0 || idx > 99) {
> +               log_err("unexpected idx %d\n", idx);
> +               return;
> +       }
> +
> +       if (idx) {
> +               sprintf(ipstr, "ipaddr%d", idx);
> +               sprintf(maskstr, "netmask%d", idx);
> +               sprintf(gwstr, "gatewayip%d", idx);
> +       }
> +
> +       if (ip) {
> +               addr = (struct in_addr *)ip;
> +               ip_to_string(*addr, tmp);
> +               env_set(ipstr, tmp);
> +       }
> +
> +       if (mask) {
> +               addr = (struct in_addr *)mask;
> +               ip_to_string(*addr, tmp);
> +               env_set(maskstr, tmp);
> +       }
> +
> +       if (gw) {
> +               addr = (struct in_addr *)gw;
> +               ip_to_string(*addr, tmp);
> +               env_set(gwstr, tmp);
> +       }
> +#else
> +       if (ip)
> +               memcpy(&net_ip, ip, 4);
> +       if (mask)
> +               memcpy(&net_netmask, mask, 4);
> +#endif
> +}
> --
> 2.43.0
>
