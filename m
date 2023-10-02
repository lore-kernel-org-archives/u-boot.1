Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15BDE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA1E58711F;
	Mon,  2 Oct 2023 03:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="vSp6ehIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E888717F; Mon,  2 Oct 2023 03:22:15 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B721871B7
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9a645e54806so2155075366b.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696209724; x=1696814524; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P423Ozr4RRTBoakTzmjK/DhlQrXyycV9LuPj4keduAM=;
 b=vSp6ehIWHT3EhoEbQm2IfJGXaDOWstNiIJGQDuun4JWYjM/3rZkoyF92755+WPeIo1
 7dSg+otwBlvrPnioAMQ3UpKb3GjB+B7/MtCV5s8e+g8kRvW3PDv+J99AxIRMS+YQzGQF
 kZHFqzFf3ch1mDJwm/olhJQ30DV5tabAbcYLO52pTcyQ4WEdcTMWgAf8i9pA9n3kdOnU
 teY9DrzFDNca2XVRzaPKGPhhN7rMTx5mM+uDJB3a09lpMuXnC94awcl8/hZqt8+5iLs1
 eUR9//h9eaj1oQ3ldaVNUW+aDSvJD/bEYVI56vuRq10KzHYtcIw8twHZNOYRPAWmlpz4
 4Mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209724; x=1696814524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P423Ozr4RRTBoakTzmjK/DhlQrXyycV9LuPj4keduAM=;
 b=NJu8nfC3m+xZZlRZCeEtxn0q89Fhie9WLtEstpFyxQlfrTAxkeQfp4yLZyQfYPi7+0
 VL2kRqA5K8YCa56RmZO7I+pGYG4C7Xa6BLCxxOMonVFvdZuBR4outA4KfCRpYz2qw0eH
 N02LKQDPt5sQ4xQDUfFwK9f7YA7Bi15oO4akgHUp5gdFG6HIJHHZZguo9YUXhbslFqkI
 KNGo4omxDISDD3KrmZG39kC5MDm/ZTe9xUxVG5c03ZyDmrmzao9M3Nav6fEogG9lv3S3
 9IU+ttbRv2ooDd6P756MaSk8M6WjieKJGfjbdwlqk5Svm20tUUrRk0c/pVtGvBiiLsmG
 YoeQ==
X-Gm-Message-State: AOJu0Yz+3Pbmbx4s3A0DjfJxuLm0g99FhpBuv+usDMGhiwvIdqtkwN8W
 3LLHMrQFJ5d3GVJWa0aqNIkcIbVbA9yBrimYX47BcQQNM34B4vjlAMA=
X-Google-Smtp-Source: AGHT+IFAYr0hl6JXFGLN6UwSPDQo/JuM1VXLcBkm0kNcbj3AWZmtheJKg079Ds7eOZMTyC3a1d4O1eNpeHCeOr/rCVE=
X-Received: by 2002:a17:906:f15:b0:9b2:a078:4461 with SMTP id
 z21-20020a1709060f1500b009b2a0784461mr8730504eji.44.1696209724295; Sun, 01
 Oct 2023 18:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-7-maxim.uvarov@linaro.org>
In-Reply-To: <20230926094124.7024-7-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@google.com>
Date: Sun, 1 Oct 2023 19:17:37 -0600
Message-ID: <CAPnjgZ0vzVsTZDYbmTdYeVLDXU-jEuiYoWfKSHpX7ZmDODE10A@mail.gmail.com>
Subject: Re: [PATCHv10 06/15] net/lwip: implement dhcp cmd
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
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

Hi Maxim,

On Tue, 26 Sept 2023 at 03:44, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> U-Boot recently got support for an alternative network stack using LWIP.
> Replace dhcp command with the LWIP variant while keeping the output and
> error messages identical.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  include/net/lwip.h             | 12 +++++
>  net/lwip/Makefile              |  1 +
>  net/lwip/apps/dhcp/lwip-dhcp.c | 85 ++++++++++++++++++++++++++++++++++
>  3 files changed, 98 insertions(+)
>  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c

Reviewed-by: Simon Glass <sjg@chromium.org>
with nits

>
> diff --git a/include/net/lwip.h b/include/net/lwip.h
> index ab3db1a214..6a8fcef392 100644
> --- a/include/net/lwip.h
> +++ b/include/net/lwip.h
> @@ -17,3 +17,15 @@ int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
>   *          Other value < 0, if error
>   */
>  int ulwip_dns(char *name, char *varname);
> +
> +/**
> + * ulwip_dhcp() -  create the DHCP request to obtain IP address.
> + *
> + * This function creates the DHCP request to obtain IP address. If DHCP server
> + * returns file name, this file will be downloaded with tftp.  After this
> + * function you need to invoke the polling loop to process network communication.
> + *
> + * Returns: 0 if success
> + *         Other value < 0, if error
> +*/
> +int ulwip_dhcp(void);
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index 5d8d5527c6..a3a33b7f71 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -63,4 +63,5 @@ obj-$(CONFIG_NET) += lwip-external/src/netif/ethernet.o
>  obj-$(CONFIG_NET) += port/if.o
>  obj-$(CONFIG_NET) += port/sys-arch.o
>
> +obj-y += apps/dhcp/lwip-dhcp.o
>  obj-y += apps/dns/lwip-dns.o
> diff --git a/net/lwip/apps/dhcp/lwip-dhcp.c b/net/lwip/apps/dhcp/lwip-dhcp.c
> new file mode 100644
> index 0000000000..f0b0e26f6e
> --- /dev/null
> +++ b/net/lwip/apps/dhcp/lwip-dhcp.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> + */
> +
> +#include <common.h>
> +#include <command.h>
> +#include <console.h>
> +
> +#include <lwip/dhcp.h>
> +#include <lwip/prot/dhcp.h>
> +#include "lwip/timeouts.h"
> +
> +#include <net/eth.h>
> +#include <net/ulwip.h>
> +
> +#define DHCP_TMO_TIME 500 /* poll for DHCP state change */
> +#define DHCP_TMO_NUM  10  /* number of tries */
> +
> +typedef struct dhcp_priv {

can you drop typedef?

> +       int num_tries;
> +       struct netif *netif;
> +} dhcp_priv;
> +
> +static void dhcp_tmo(void *arg)
> +{
> +       struct dhcp_priv *dpriv = (struct dhcp_priv *)arg;
> +       struct netif *netif = dpriv->netif;
> +       struct dhcp *dhcp;
> +
> +       dhcp = netif_get_client_data(netif, LWIP_NETIF_CLIENT_DATA_INDEX_DHCP);
> +       if (!dhcp)
> +               return;
> +
> +       if (dhcp->state == DHCP_STATE_BOUND) {
> +               int err = 0;
> +
> +               err -= env_set("bootfile", dhcp->boot_file_name);
> +               err -= env_set("ipaddr", ip4addr_ntoa(&dhcp->offered_ip_addr));
> +               err -= env_set("netmask", ip4addr_ntoa(&dhcp->offered_sn_mask));
> +               err -= env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
> +               if (err)
> +                       log_err("error update envs\n");

but don't you need to return the effort? How does a script know it failed?

I think this function need an error return...if that is not possible
then you need to stash the error somehow so you can report it when
needed.

> +               log_info("DHCP client bound to address %s\n", ip4addr_ntoa(&dhcp->offered_ip_addr));
> +               free(dpriv);
> +               ulwip_exit(err);
> +               return;
> +       }
> +
> +       dpriv->num_tries--;
> +       if (dpriv->num_tries < 0) {
> +               log_err("DHCP client timeout\n");
> +               free(dpriv);
> +               ulwip_exit(-1);
> +               return;
> +       }
> +
> +       sys_timeout(DHCP_TMO_TIME, dhcp_tmo, dpriv);
> +}
> +
> +int ulwip_dhcp(void)
> +{
> +       struct netif *netif;
> +       int eth_idx;
> +       struct dhcp_priv *dpriv;
> +
> +       dpriv = malloc(sizeof(struct dhcp_priv));
> +       if (!dpriv)
> +               return -EPERM;

-ENOMEM

> +
> +       eth_idx = eth_get_dev_index();
> +       if (eth_idx < 0)
> +               return -EPERM;
> +
> +       netif = netif_get_by_index(eth_idx + 1);
> +       if (!netif)
> +               return -ENOENT;
> +
> +       dpriv->num_tries = DHCP_TMO_NUM;
> +       dpriv->netif = netif;
> +       sys_timeout(DHCP_TMO_TIME, dhcp_tmo, dpriv);
> +
> +       return dhcp_start(netif) ? 0 : -EPERM;

Why -EPERM? Is it a permission error? Can we not get a real error number?

> +}
> --
> 2.30.2
>

Regards,
SImon
