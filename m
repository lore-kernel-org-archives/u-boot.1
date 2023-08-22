Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804A2EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B19864EA;
	Tue, 22 Aug 2023 20:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ESNr/0eg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE557864F0; Tue, 22 Aug 2023 20:58:06 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58EE1864EA
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d72cf9156easo4426301276.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=srEiJMsOcBbQ7IHhEtyB5DRiVE7OMeU7+DhNzPyI2XM=;
 b=ESNr/0egAzS6m6qmSpFrdIFfRTdfNAVQfkFEfDtB8uroKIZQvTYInSq8Ml981v6C5H
 IRK7lOllAj83aedbY1jGZHc2GuOId3+4NEGUIO4mhWrLhGAK2q98eM0L+bROoXLEr679
 kEd3NbS7zbYuOVlsOsy5EYb5MJnkiSnLXuM+gtu5Mt6SyOWnFggcfDhlg3iw6F92yavy
 vat8KpyFoTxi28ZFefED/aQ95rV/kP7dRsB0UtQ2OWPhGRnBEsOa21izO7Q3uep3oDP2
 /oOAqBrN0i1CEw7Ru4wMnjaaJsIz4kGCLyvjiD58GKMcB5OAijuYtNS4hNDc+vXcKHKB
 QLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=srEiJMsOcBbQ7IHhEtyB5DRiVE7OMeU7+DhNzPyI2XM=;
 b=Dyy2OmTaxBbHgE3huowoSdC9iv0PzjcKq6dNg6p2VvFe5EyYzoX7skm+XXtOgT88mI
 I82uVHKtKTKv8shNXfJMrYTj/UTt1EhtV1QXsNNu3cGcpLXZHSHxub1iA11PiTTbsC4u
 QszOdAZCOiF2YFSCZU2Qe/CMf5FMGiVmEWQ0sdLC9dVS27aY1BG8vLNgD5tSTozwuaCZ
 h2pGkSGmrRR5LH+lC36TlOuyCgnskB27+TPNwR2gAE/F9XeLIiLpRUwUvbll/6355iO2
 z/FnsV7I9nHGW/1andUi+UhKM2xbJq93oPWuVT1hjmVjmjWQwu9HsFntQQq1skp7XrO1
 jYtw==
X-Gm-Message-State: AOJu0YwNktW1xO4hkxXk5Bd4wQx/d7TeUSWkOpajd0QqPXXZ2OOYa6d+
 NBXtiz9mH3HMHC1/821r5CMjk7NnpOh2AklNW95eEQ==
X-Google-Smtp-Source: AGHT+IGV4K2E99wtovpif+AQvEu5D8WmW2E+HqX7e5Eh2Add0LbvpWMyMbRtlTnLoqnSmmXho2zAtjTdx4OuIcY08gw=
X-Received: by 2002:a25:ef4c:0:b0:d55:cf49:9144 with SMTP id
 w12-20020a25ef4c000000b00d55cf499144mr9654873ybm.15.1692730678868; Tue, 22
 Aug 2023 11:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
 <20230822093614.4717-5-maxim.uvarov@linaro.org>
In-Reply-To: <20230822093614.4717-5-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@google.com>
Date: Tue, 22 Aug 2023 12:56:45 -0600
Message-ID: <CAPnjgZ0TA_ZBDntxdVDEscdECz-=oh9cRHFnT=hCm8V_0=V2LA@mail.gmail.com>
Subject: Re: [PATCHv7 04/15] net/lwip: implement dhcp cmd
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

On Tue, 22 Aug 2023 at 03:39, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> U-Boot recently got support for an alternative network stack using LWIP.
> Replace dhcp command with the LWIP variant while keeping the output and
> error messages identical.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  include/net/lwip.h             | 12 +++++++
>  net/lwip/Makefile              |  1 +
>  net/lwip/apps/dhcp/lwip-dhcp.c | 62 ++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
>  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
>
> diff --git a/include/net/lwip.h b/include/net/lwip.h
> index cda896d062..240ebba354 100644
> --- a/include/net/lwip.h
> +++ b/include/net/lwip.h
> @@ -17,3 +17,15 @@ int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
>   *         Other value < 0, if error
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

So this is an errno value from errno.h ?

> +*/
> +int ulwip_dhcp(void);
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index 6d2c00605b..59323fb325 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -65,4 +65,5 @@ obj-$(CONFIG_NET) += $(LWIPDIR)/netif/ethernet.o
>  obj-$(CONFIG_NET) += port/if.o
>  obj-$(CONFIG_NET) += port/sys-arch.o
>
> +obj-$(CONFIG_CMD_DHCP) += apps/dhcp/lwip-dhcp.o
>  obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
> diff --git a/net/lwip/apps/dhcp/lwip-dhcp.c b/net/lwip/apps/dhcp/lwip-dhcp.c
> new file mode 100644
> index 0000000000..cce1e367f9
> --- /dev/null
> +++ b/net/lwip/apps/dhcp/lwip-dhcp.c
> @@ -0,0 +1,62 @@
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
> +
> +#include <net/eth.h>
> +#include <net/ulwip.h>
> +
> +static struct dhcp dhcp;

Can we keep the state in the uclass?

> +
> +static int ulwip_dhcp_tmo(void)
> +{
> +       switch (dhcp.state) {
> +       case DHCP_STATE_BOUND:
> +               env_set("bootfile", dhcp.boot_file_name);
> +               env_set("ipaddr", ip4addr_ntoa(&dhcp.offered_ip_addr));
> +               env_set("netmask", ip4addr_ntoa(&dhcp.offered_sn_mask));
> +               env_set("serverip", ip4addr_ntoa(&dhcp.server_ip_addr));

Please check errors throughout your patches.

> +               printf("DHCP client bound to address %s\n", ip4addr_ntoa(&dhcp.offered_ip_addr));
> +               break;
> +       default:
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +int ulwip_dhcp(void)
> +{
> +       int err;
> +       struct netif *netif;
> +       int eth_idx;
> +
> +       eth_idx = eth_get_dev_index();
> +       if (eth_idx < 0) {
> +               log_err("no eth idx\n");
> +               return -1;

That is -EPERM...please use a suitable error, perhaps -ENOENT?

> +       }
> +
> +       netif = netif_get_by_index(eth_idx + 1);
> +       if (!netif)
> +               return -1;
> +
> +       ulwip_set_tmo(ulwip_dhcp_tmo);
> +
> +       if (!netif_get_client_data(netif, LWIP_NETIF_CLIENT_DATA_INDEX_DHCP))
> +               dhcp_set_struct(netif, &dhcp);
> +
> +       err = dhcp_start(netif);
> +       if (err)
> +               log_err("dhcp_start error %d\n", err);

Ideally the caller would print the errors. We try to have commands do
that, since then it allows silent running for things which want it. It
also helps with code size.

> +
> +       return err;
> +}
> --
> 2.30.2
>

Regards,
Simon
