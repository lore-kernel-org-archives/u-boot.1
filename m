Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720D4C001DF
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 08:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E3E867C7;
	Wed, 16 Aug 2023 10:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q6oFmzmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74207868D3; Wed, 16 Aug 2023 10:42:26 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2C8584702
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 10:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe24dd8898so58991645e9.2
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 01:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692175343; x=1692780143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SsuZZx+63ozEYuCaO6Er8vRwQLqNq1w4tWEIWSeEz60=;
 b=q6oFmzmie6ADwDKMCP7ESDP15pVxNLO+bi0/riev6AJqTjVIAZtdXcQ+qxI/nBfai0
 ARNWMCHwMKmgqMlwZx38XkJrYK0A9DaSOF1cylFoGkNqMNhKhajs5nmm3s5jh5noU3XA
 kDbm4vmJZQTKzNz/mm9JaKlW6jWX2AZNhzXbaiGjJ8Euy+fAGjUO5998P2ufe8WMVHqP
 uBcjd/g3bqPOfk5wEAR1UxeLicM44/wHUVc8+jpR6Ob8kzERwCW1c4obsyVtGdAyeq6T
 U2m6+pA0tBAXgg0o4yhRtEn0Pqc06Bv6+SjrBGxxAmE/AloaAMEkbnrMJxgorKyTIcNH
 SlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692175343; x=1692780143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsuZZx+63ozEYuCaO6Er8vRwQLqNq1w4tWEIWSeEz60=;
 b=OzbqW/0LqOfbAFtvBHsEdqgbkuBMW0wU0gxyThEYbRauKGbc8pyJ+n3HPiZrJmZwcB
 JaNLG1H+K4vDrGIJqBSacXrpvFQH6p6eXTu0PzN/9FPaH6PP2rKrzKAjUf53EzIpXUzX
 RZjhi2UvOUIQDYTA1XYWqBUgfbzZlAE7nbYQC9cGi3WnY9XpSewdbbQvnfHeAufSryJD
 CH6Gdco2SoDLTcb3GUDF0MBbrN/4H9BWSp4vkXxXm6i/UE3eoedzOEa6PRxhXg9VgVEb
 frHoGHMf8xWly3/7sS370hyAaH5km7XsR7RjPPbS2ZDUMooMuXfPekJ4/jBn8sRwy61z
 ufCA==
X-Gm-Message-State: AOJu0YxDojwFfl8cT/utaP9VYCWuiO6nzRzCflcZDnqqg7UJ8K6MC2Qv
 C93wZsaKEvPpbNr926wvUN8RXw==
X-Google-Smtp-Source: AGHT+IFZT71FN7TVbzIG0xYsOQkJa65aAnpCDnIKt1cYu1rzsPimf9mdG1txfKbgwT6z/qmqkOwXDg==
X-Received: by 2002:a1c:4b0b:0:b0:3fc:21:2c43 with SMTP id
 y11-20020a1c4b0b000000b003fc00212c43mr851871wma.13.1692175343154; 
 Wed, 16 Aug 2023 01:42:23 -0700 (PDT)
Received: from hades (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c228800b003fbcf032c55sm23432796wmf.7.2023.08.16.01.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 01:42:22 -0700 (PDT)
Date: Wed, 16 Aug 2023 11:42:20 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@redhat.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 lwip-devel@nongnu.org
Subject: Re: [PATCHv6 07/14] net/lwip: implement ping cmd
Message-ID: <ZNyL7ACbL1g8e4Cz@hades>
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-8-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814133253.4150-8-maxim.uvarov@linaro.org>
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

On Mon, Aug 14, 2023 at 07:32:46PM +0600, Maxim Uvarov wrote:
>  * can return immediately if previous request was cached or it might require
> @@ -38,3 +39,28 @@ int ulwip_dhcp(void);
>  *         !0 if error
>  */
>  int ulwip_wget(ulong addr, char *url);
> +
> +/**
> + * ulwip_tftp() - load file with tftp
> + *
> + * Load file with tftp to specific address
> + *
> + * @param addr - address to store downloaded file
> + * @param filename - file name on remote tftp server to download

Please fix function comments properly 

> + *
> + *
> + * @return 0 if success, !0 if error
> + */
> +int ulwip_tftp(ulong addr, const char *filename);
> +
> +/*
> +* This function creates the ping for  address provided in parameters.
> +* After this function you need to invoke the polling
> +* loop to process network communication.
> +*
> +*
> +* @ping_addr  start address to download result
> +* Return: 0 for success
> +*         !0 if error
> +*/
> +int ulwip_ping(char *ping_addr);
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index 4c6df94807..8b3e843426 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -67,5 +67,6 @@ obj-$(CONFIG_NET) += port/sys-arch.o
>  
>  obj-$(CONFIG_CMD_DHCP) += apps/dhcp/lwip-dhcp.o
>  obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
> +obj-$(CONFIG_CMD_PING) += apps/ping/
>  obj-$(CONFIG_CMD_TFTPBOOT) += apps/tftp/
>  obj-$(CONFIG_CMD_WGET) += apps/http/
> diff --git a/net/lwip/apps/ping/Makefile b/net/lwip/apps/ping/Makefile
> new file mode 100644
> index 0000000000..dc63feb7b5
> --- /dev/null
> +++ b/net/lwip/apps/ping/Makefile
> @@ -0,0 +1,11 @@
> +ccflags-y += -I$(srctree)/net/lwip/port/include
> +ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
> +ccflags-y += -I$(obj)
> +
> +.PHONY: $(obj)/ping.c
> +$(obj)/ping.o: $(obj)/ping.c
> +$(obj)/ping.c:
> +	cp $(srctree)/net/lwip/lwip-external/contrib/apps/ping/ping.c $(obj)/ping.c
> +
> +obj-$(CONFIG_CMD_PING) += ping.o
> +obj-$(CONFIG_CMD_PING) += lwip_ping.o
> diff --git a/net/lwip/apps/ping/lwip_ping.c b/net/lwip/apps/ping/lwip_ping.c
> new file mode 100644
> index 0000000000..611fcaf591
> --- /dev/null
> +++ b/net/lwip/apps/ping/lwip_ping.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> + */
> +
> +#include "lwip/opt.h"
> +#include "lwip/ip_addr.h"
> +#include "ping.h"
> +#include "lwip_ping.h"
> +
> +static ip_addr_t ip_target;
> +
> +static int ulwip_ping_tmo(void)
> +{
> +
> +	log_err("ping failed; host %s is not alive\n", ipaddr_ntoa(&ip_target));
> +	return 1;
> +}
> +
> +int ulwip_ping(char *ping_addr)
> +{
> +	int err;
> +
> +	err = ipaddr_aton(ping_addr, &ip_target);
> +	if (!err) {
> +		log_err("wrong ping addr string \"%s\" \n", ping_addr);

Invalid ip address is enough

> +		return -1;
> +	}
> +
> +	ulwip_set_tmo(ulwip_ping_tmo);
> +
> +	ping_init(&ip_target);
> +	ping_send_now();
> +
> +	return 0;
> +}
> diff --git a/net/lwip/apps/ping/lwip_ping.h b/net/lwip/apps/ping/lwip_ping.h
> new file mode 100644
> index 0000000000..0374f07d9e
> --- /dev/null
> +++ b/net/lwip/apps/ping/lwip_ping.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +/*
> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> + */
> +
> +#ifndef LWIP_PING_H
> +#define LWIP_PING_H
> +
> +#include <lwip/ip_addr.h>
> +
> +void ping_raw_init(void);
> +void ping_send_now(void);
> +
> +#endif /* LWIP_PING_H */
> diff --git a/net/lwip/apps/ping/ping.h b/net/lwip/apps/ping/ping.h
> new file mode 100644
> index 0000000000..006a18c658
> --- /dev/null
> +++ b/net/lwip/apps/ping/ping.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <net/ulwip.h>
> +#include "lwip/ip_addr.h"
> +
> +#define LWIP_DEBUG 1 /* ping_time is under ifdef*/
> +#define PING_RESULT(cond) { \
> +	if (cond == 1) { \
> +		printf("host %s a alive\n", ipaddr_ntoa(addr)); \
> +		printf(" %"U32_F" ms\n", (sys_now() - ping_time)); \
> +		ulwip_exit(0); \
> +	} else { \
> +		printf("ping failed; host %s in not alive\n",\
> +		       ipaddr_ntoa(addr)); \
> +		ulwip_exit(-1); \
> +	} \
> +     } while (0);

On the previous patch you are defining a function to do something similar
(httpc_result()).  We need to be consistent on this.  Can we define a
common function for all failures?  Certianly don't define a macro here and
a function elsewhere

> +
> +void ping_init(const ip_addr_t *ping_addr);
> -- 
> 2.30.2
> 

Thanks
/Ilias
