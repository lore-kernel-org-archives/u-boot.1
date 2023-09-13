Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF08AEEB595
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 05:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2ED186B33;
	Wed, 13 Sep 2023 07:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P2LywzOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78CD886B50; Wed, 13 Sep 2023 07:56:38 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBA1286963
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 07:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31dca134c83so6489228f8f.3
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 22:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694584595; x=1695189395; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1pYJjGlsXmy9hCyhMqfPqD0UeBUzS1vQ3KTROt4NhaM=;
 b=P2LywzOuWrHBw/hB+cx9Vb1AWlkQywXpHVIumPHb/B+meKItScUnSggtAc7E+L+tam
 XQB+000Gqcd3roZTKrH/068KITKPJbly3QE/MtSp55z1DpCthIzzwqyTs3HcPvkbjou9
 drJtjUQVPXi8W8E5oqs/Ml1hKBs1rGrIwUtl7nN3kqoXVnagyjG/TFo9T0wE1pIjYhBx
 ANO20sL0uSYG5AkzxZdFm4sL13SotlflkAxp+FTTdi1ilCOiZ5RFGU5ldZdZuY+mvIZf
 K8dHiJDVWPntvNz6ECC3AHmE7i+iZAuXcZSd2Q6ZoWIkE+PmahGQvnkC55BCRnEfOOwO
 4HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694584595; x=1695189395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1pYJjGlsXmy9hCyhMqfPqD0UeBUzS1vQ3KTROt4NhaM=;
 b=LH6nOkMny0PzQ86iEe++cF6/WBHKRZUhR3LUVKpL74EgZlcE1uNipy3HD3bagV/YcU
 VT/tSKTSUNHKgDeLxfix42F/jsF5wmaJBI3Qsa79ZVNirtWPhjr76s6uVI6TyCKQKhhD
 PN0MpG7/116/+mdwyviTaDAQhrqqXecyz38QiQYLzhBIU1npwyXh03kDQKkVE6HiIHc6
 afGp2QrokkhqH2Hxn2/5k1S2qHGWqF6e/oapikBy3AQ8eFhxsgBtV94NyEs9QitbHbue
 rkc/DAo9zCRv4Pzp91KXC/Axd9Hw15gq+9AwLD11DDaSNKsWeaZEOOkOTmeUnz8pTasH
 yLuA==
X-Gm-Message-State: AOJu0Yw/uSyNFTiDQqgGKXzGRNCW5/9gTaJyCIPy6lpk0D/2IK0/ded5
 oEDCf+pWBkn2yooqtKdVmt8efQ==
X-Google-Smtp-Source: AGHT+IF3bEfwjP7Cm9EryLt+CbQGx9hcLlbAw2K4PgFB+F+qulK6BVbxvLn5w5UJ45c3D7xXcT+5yA==
X-Received: by 2002:a5d:58ca:0:b0:31f:bd75:698a with SMTP id
 o10-20020a5d58ca000000b0031fbd75698amr1077424wrf.39.1694584595220; 
 Tue, 12 Sep 2023 22:56:35 -0700 (PDT)
Received: from hera (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a5d554d000000b0031f3ad17b2csm14425887wrw.52.2023.09.12.22.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 22:56:34 -0700 (PDT)
Date: Wed, 13 Sep 2023 08:56:32 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de
Subject: Re: [PATCHv8 03/15] net/lwip: implement dns cmd
Message-ID: <ZQFPEF85eOXtw8Qn@hera>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135320.7066-4-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908135320.7066-4-maxim.uvarov@linaro.org>
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

On Fri, Sep 08, 2023 at 07:53:08PM +0600, Maxim Uvarov wrote:
> U-Boot recently got support for an alternative network stack using LWIP.
> Replace dns command with the LWIP variant while keeping the output and
> error messages identical.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  include/net/lwip.h           | 19 +++++++++++
>  net/lwip/Makefile            |  2 ++
>  net/lwip/apps/dns/lwip-dns.c | 63 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+)
>  create mode 100644 include/net/lwip.h
>  create mode 100644 net/lwip/apps/dns/lwip-dns.c
>
> diff --git a/include/net/lwip.h b/include/net/lwip.h
> new file mode 100644
> index 0000000000..ab3db1a214
> --- /dev/null
> +++ b/include/net/lwip.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
> +		char *const argv[]);
> +
> +/**
> + * ulwip_dns() - creates the DNS request to resolve a domain host name
> + *
> + * This function creates the DNS request to resolve a domain host name. Function
> + * can return immediately if previous request was cached or it might require
> + * entering the polling loop for a request to a remote server.
> + *
> + * @name:    dns name to resolve
> + * @varname: (optional) U-Boot variable name to store the result
> + * Returns: ERR_OK(0) for fetching entry from the cache
> + *          -EINPROGRESS success, can go to the polling loop
> + *          Other value < 0, if error
> + */
> +int ulwip_dns(char *name, char *varname);
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index 3fd5d34564..5d8d5527c6 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -62,3 +62,5 @@ obj-$(CONFIG_NET) += lwip-external/src/netif/ethernet.o
>
>  obj-$(CONFIG_NET) += port/if.o
>  obj-$(CONFIG_NET) += port/sys-arch.o
> +
> +obj-y += apps/dns/lwip-dns.o
> diff --git a/net/lwip/apps/dns/lwip-dns.c b/net/lwip/apps/dns/lwip-dns.c
> new file mode 100644
> index 0000000000..b340302f2c
> --- /dev/null
> +++ b/net/lwip/apps/dns/lwip-dns.c
> @@ -0,0 +1,63 @@
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
> +#include <lwip/dns.h>
> +#include <lwip/ip_addr.h>
> +
> +#include <net/ulwip.h>
> +
> +static void dns_found_cb(const char *name, const ip_addr_t *ipaddr, void *callback_arg)
> +{
> +	char *varname = (char *)callback_arg;
> +	char *ipstr = ip4addr_ntoa(ipaddr);
> +
> +	if (varname)
> +		env_set(varname, ipstr);
> +	log_info("resolved %s to %s\n",  name, ipstr);
> +	ulwip_exit(0);
> +}
> +
> +int ulwip_dns(char *name, char *varname)
> +{
> +	int err;
> +	ip_addr_t ipaddr; /* not used */
> +	ip_addr_t dns1;
> +	ip_addr_t dns2;
> +	char *dnsenv = env_get("dnsip");
> +	char *dns2env = env_get("dnsip2");
> +
> +	if (!dnsenv && !dns2env) {
> +		log_err("nameserver is not set with dnsip and dnsip2 vars\n");
> +		return -ENOENT;
> +	}
> +
> +	if (!dnsenv)
> +		log_warning("dnsip var is not set\n");
> +	if (!dns2env)
> +		log_warning("dnsip2 var is not set\n");
> +
> +	dns_init();
> +
> +	if (ipaddr_aton(dnsenv, &dns1))
> +		dns_setserver(0, &dns1);
> +
> +	if (ipaddr_aton(dns2env, &dns2))
> +		dns_setserver(1, &dns2);

env_get will return NULL if any of these is not set.  Looking at
ipaddr_aton() of lwip that might lead to a NULL deref in ip_2_ip6()

> +
> +	err = dns_gethostbyname(name, &ipaddr, dns_found_cb, varname);
> +	if (err == ERR_OK)
> +		dns_found_cb(name, &ipaddr, varname);
> +
> +	/* convert lwIP ERR_INPROGRESS to U-Boot -EINPROGRESS */
> +	if (err == ERR_INPROGRESS)
> +		err = -EINPROGRESS;
> +
> +	return err;
> +}
> --
> 2.30.2
>
