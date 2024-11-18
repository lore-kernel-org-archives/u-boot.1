Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98284D4920F
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 12:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D03A988E5C;
	Mon, 18 Nov 2024 13:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="admGVIsR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E5BE89432; Mon, 18 Nov 2024 13:22:25 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE02C88DEA
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7240fa50694so2426916b3a.1
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 04:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731932541; x=1732537341; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e/tAsYewNEDewORNxkbftOZPmRTxXXZfAt6t+S27L90=;
 b=admGVIsR9SLv3EKrAZcT82hH4WGWgL8hA4I5KpA4MlufZ7rty8RtO7+gH9xPR069Pc
 QK/ERje+lIlUfmxgRNrj2KtvphOvEqnz447R2D+384qiKrWM8eJ0eTj7gnpsJyxjalJl
 PyRm3Uu/NazodMZhTKhqnfy1YSkUtmWzkPxhk2bCXM2iOC5s4n6mlERHuXpS0/xH0a/J
 8nC5DqMSSQkn0EH/kxCoCB0FJfDi9xq8iqSnCCzPIByVyD520dV1tC6nL58n3gI/q70N
 syIEBdM76icMgs1S4VQzWTbabciCLdrdVYG4Hib70w+XWRK0icKl8IAIAWV6xewJdcWG
 XyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731932541; x=1732537341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e/tAsYewNEDewORNxkbftOZPmRTxXXZfAt6t+S27L90=;
 b=jvECIhFQzkRrb0U3vrZVR6tQpdEW4hiwLisFy8Jw7ThP5xA69WmgI8tq2ibizjl57b
 L36KCVdb+M/xcKA1ax2Z4GjPnsU4LyKOzii9JE637TrtoqEBonCRohHAlRokM6jwAZ/g
 JxFczM7a99XB3sIkiOuI8oZEDCRJhd2dIAP4t580atCoqvIjMQGbwDrvTkJHzgRzvCJ6
 wjvEQy5YIVKVKdJSkh7jd88R7n8X0oYbHMf5xCBf9SKO5myxHh9CIGWLo7qAPt8xtXYI
 bYFh0GOcrs2wHW5m1YoaEeJ57K9UE0Qc2jiZ5WqsWd0dh8yj0JZDrdkbyqL6T1jxQ0bd
 GFow==
X-Gm-Message-State: AOJu0Yw7fI1BE4IAJSwIKaCNSkDNE56p4EtxGYTEqbJoJwnboreLBga1
 o73KrBE2qCU8fgQlulglTy+o8rRrkxskvty/qPXrClHjaLp9vfQyDlYO5s+8HK72/vKjUzTDnhL
 ar48qRyoMeT6wtUxmShYCbYEPMJavVVxopoShGh3Eticf+810
X-Google-Smtp-Source: AGHT+IGSWIeo+In0Xkkp+VzwilwSSRPLDOhYx2o8B2iQDD7T0+LdMshg7d4rAyBVIDO+OY8/cEfzxJ/xAs5C7SH/nzk=
X-Received: by 2002:a17:90a:da84:b0:2ea:8d1e:a870 with SMTP id
 98e67ed59e1d1-2ea8d1eaa22mr1749698a91.11.1731932541244; Mon, 18 Nov 2024
 04:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-8-adrianox@gmail.com>
In-Reply-To: <20241111210959.560738-8-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 18 Nov 2024 14:21:44 +0200
Message-ID: <CAC_iWjJ19963N20Y52hVpQ8=-n8ifziyTcXdCNFkKR5+9nm3Ug@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] efi_loader: efi_net: add efi_net_set_addr,
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

Hi Adriano,

On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add the functions efi_net_set_addr and  efi_net_get_addr to set
> and get the ip address from efi code in a network agnostic way.
> This could also go in net_common, or be compiled conditionally
> for each network stack.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> (no changes since v2)
>
>  include/efi_loader.h     |  16 +++++++
>  lib/efi_loader/efi_net.c | 100 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
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
> index 7cd536705f..dd84b3f18d 100644
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
> @@ -997,3 +998,102 @@ out_of_resources:
>         printf("ERROR: Out of memory\n");
>         return EFI_OUT_OF_RESOURCES;
>  }
> +
> +void efi_net_get_addr(struct efi_ipv4_address *ip,
> +                     struct efi_ipv4_address *mask,
> +                     struct efi_ipv4_address *gw)
> +{
> +#ifdef CONFIG_NET_LWIP
> +       char *ipstr = "ipaddr\0\0";
> +       char *maskstr = "netmask\0\0";
> +       char *gwstr = "gatewayip\0\0";

You generally can't define strings like that and expect to change
them. The compiler places the string literal somewhere in memory which
is immutable.
If you want to keep the code as is, you need to define these as ipstr[].

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

Is 0 not legal here?
And why is the behavior differnt with and without LWIP?


> +               sprintf(ipstr, "ipaddr%d", idx);
> +               sprintf(maskstr, "netmask%d", idx);
> +               sprintf(gwstr, "gatewayip%d", idx);
> +       }
> +
> +       env = env_get(ipstr);
> +       if (env && ip) {
> +               tmp = string_to_ip(env);
> +               memcpy((void *)ip, (void *)&tmp, 4);
> +       }
> +
> +       env = env_get(maskstr);
> +       if (env && mask) {
> +               tmp = string_to_ip(env);
> +               memcpy((void *)mask, (void *)&tmp, 4);
> +       }
> +       env = env_get(gwstr);
> +       if (env && gw) {
> +               tmp = string_to_ip(env);
> +               memcpy((void *)gw, (void *)&tmp, 4);
> +       }
> +#else
> +       if (ip)
> +               memcpy((void *)ip, (void *)&net_ip, 4);
> +       if (mask)
> +               memcpy((void *)mask, (void *)&net_netmask, 4);

Get rid of casts etc.

> +#endif
> +}
> +
> +void efi_net_set_addr(struct efi_ipv4_address *ip,
> +                     struct efi_ipv4_address *mask,
> +                     struct efi_ipv4_address *gw)
> +{
> +#ifdef CONFIG_NET_LWIP
> +       char *ipstr = "ipaddr\0\0";
> +       char *maskstr = "netmask\0\0";
> +       char *gwstr = "gatewayip\0\0";
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
> +               memcpy((void *)&net_ip, (void *)ip, 4);
> +       if (mask)
> +               memcpy((void *)&net_netmask, (void *)mask, 4);
> +#endif
> +}
> --
> 2.43.0
>

Cheers
/Ilias
