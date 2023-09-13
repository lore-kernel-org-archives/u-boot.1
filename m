Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B0DEEB596
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 06:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ADC586C47;
	Wed, 13 Sep 2023 08:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pv6MWZA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DACA986EEB; Wed, 13 Sep 2023 08:28:51 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 347128676C
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 08:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so3198491f8f.2
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 23:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694586528; x=1695191328; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dK24ispo9SXjrXmcy8NeOlKsQTxLT0y7LUTIRwilDTI=;
 b=pv6MWZA90ZXR9HlbRP5YwXlzXTrjMmxRPDQDMSiFiqzuBqUwmVakpKSKCiVUVD6EK9
 cbGDVATeG+cQGjAzrATaPqnWTDGe4Sv0n8V8VPr19oBrMcNCsxFGe91hhKyJXih4mxGr
 E/ViWG3KN8meYpkZdvh4sZBfK8WY6u9RPWN14VaIEkNRcGuV0/XlAL+toW7RIP++AkHY
 II9qqG/1ADeezTJNRsyHnCHW3NcEy2zEaUH9Ww5IRxShHJ93uXFtAgX7qbutf86kVxj/
 B9tEt+kwl5LeZmGe76kvjNLcdAn6XoE4hYVKSaZdbKqka+BI6u8xpTF38BhzB2HJIAsf
 JCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694586528; x=1695191328;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dK24ispo9SXjrXmcy8NeOlKsQTxLT0y7LUTIRwilDTI=;
 b=Bg451Pc8zgIak/ZYqqx6/5h8ixNZqnQn7yANUOpYOSxrWrXcuh60P/6T3JW9DDwneR
 Szr1+BdeBwZOLTNZ1wmFN4mSl1uCkm0TXIMKfMFVqsXsKBRU0tRdOJutUDAGsSvRo+8K
 6GPvtjIVApjU/rjxNH+ZfElX+y6C3dMNfu3tOeJ4N3vAaK0Heg32y+1Z5QISdRs0IKYx
 9rADUL1WvqtbVTS+R2XhHR6T9blR9phBRSnmtaLOtwClFupulYAxg+B1pIRQkJj37wyo
 JbgPmEYIDUYRTvJ0fxmDBxZTyWMHwcciE6Dqt2O5kub7lDb5svQloxsfucrQtw/e6y2R
 67CA==
X-Gm-Message-State: AOJu0Yyjhn66Z0ilG48c0AWas5MDi08HZ/0Q95fzg7gVMf8AnvQK+J6V
 4mgdzLvb5Fef3URnwAsNzQQdnQ==
X-Google-Smtp-Source: AGHT+IEJ6QI1TOqhIp0hGEr/MoeGu7dksKJrgyNPvE8masFYY+pY5MX3wJwSEHM01Oql5q1z9f9HGg==
X-Received: by 2002:adf:fe8f:0:b0:31c:6420:fff with SMTP id
 l15-20020adffe8f000000b0031c64200fffmr1218197wrr.62.1694586528555; 
 Tue, 12 Sep 2023 23:28:48 -0700 (PDT)
Received: from hera (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a1c7718000000b003fefcbe7fa8sm1007720wmi.28.2023.09.12.23.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 23:28:48 -0700 (PDT)
Date: Wed, 13 Sep 2023 09:28:46 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de
Subject: Re: [PATCHv8 07/15] net/lwip: implement ping cmd
Message-ID: <ZQFWniubZjEPfAp+@hera>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135320.7066-8-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908135320.7066-8-maxim.uvarov@linaro.org>
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

On Fri, Sep 08, 2023 at 07:53:12PM +0600, Maxim Uvarov wrote:
> U-Boot recently got support for an alternative network stack using LWIP.
> Replace ping command with the LWIP variant while keeping the output and
> error messages identical. ping uses lwIP contrib/apps/ping/ping.c code.
> Custom timeout is used to get an error message on not modified example.
> lwIP timeouts are not yet implemented in U-Boot (#define LWIP_TIMERS 1)
> so that for now ping can not rechange itself for continuous pings and
> stops after the first request (the same behavior as the original ping.)
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  include/net/lwip.h             | 15 +++++++++++++
>  net/lwip/Makefile              |  1 +
>  net/lwip/apps/ping/Makefile    | 12 ++++++++++
>  net/lwip/apps/ping/lwip_ping.c | 40 ++++++++++++++++++++++++++++++++++
>  net/lwip/apps/ping/lwip_ping.h | 15 +++++++++++++
>  net/lwip/apps/ping/ping.h      | 19 ++++++++++++++++
>  6 files changed, 102 insertions(+)
>  create mode 100644 net/lwip/apps/ping/Makefile
>  create mode 100644 net/lwip/apps/ping/lwip_ping.c
>  create mode 100644 net/lwip/apps/ping/lwip_ping.h
>  create mode 100644 net/lwip/apps/ping/ping.h
>
> diff --git a/include/net/lwip.h b/include/net/lwip.h
> index 85f08343fd..1e92f9871c 100644
> --- a/include/net/lwip.h
> +++ b/include/net/lwip.h
> @@ -2,6 +2,8 @@
>
>  int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
>  		char *const argv[]);
> +int do_lwip_ping(struct cmd_tbl *cmdtp, int flag, int argc,
> +		 char *const argv[]);
>
>  /**
>   * ulwip_dns() - creates the DNS request to resolve a domain host name
> @@ -56,3 +58,16 @@ int ulwip_tftp(ulong addr, const char *filename);
>   * Returns: 0 for success, !0 if error
>   */
>  int ulwip_wget(ulong addr, char *url);
> +
> +/**
> + * ulwip_ping - create the ping request
> + *
> + * This function creates the ping for  address provided in parameters.
> + * After this function you need to invoke the polling
> + * loop to process network communication.
> + *
> + *
> + * @ping_addr: IP address to ping
> + * Returns: 0 for success, !0 if error
> +*/
> +int ulwip_ping(char *ping_addr);
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index 61042862e1..5839d125c2 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -67,3 +67,4 @@ obj-y += apps/dhcp/lwip-dhcp.o
>  obj-y += apps/dns/lwip-dns.o
>  obj-y += apps/tftp/
>  obj-y += apps/http/
> +obj-y += apps/ping/
> diff --git a/net/lwip/apps/ping/Makefile b/net/lwip/apps/ping/Makefile
> new file mode 100644
> index 0000000000..e567c0dc3e
> --- /dev/null
> +++ b/net/lwip/apps/ping/Makefile
> @@ -0,0 +1,12 @@
> +ccflags-y += -I$(srctree)/net/lwip/port/include
> +ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
> +ccflags-y += -I$(obj)
> +
> +# ping.c includes "ping.h", copy it to local directory, to override ping.h
> +.PHONY: $(obj)/ping.c
> +$(obj)/ping.o: $(obj)/ping.c
> +$(obj)/ping.c:
> +	cp $(srctree)/net/lwip/lwip-external/contrib/apps/ping/ping.c $(obj)/ping.c
> +
> +obj-y += ping.o
> +obj-y += lwip_ping.o
> diff --git a/net/lwip/apps/ping/lwip_ping.c b/net/lwip/apps/ping/lwip_ping.c
> new file mode 100644
> index 0000000000..231ea6473a
> --- /dev/null
> +++ b/net/lwip/apps/ping/lwip_ping.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> + */
> +
> +#include "lwip/opt.h"
> +#include "lwip/ip_addr.h"
> +#include "lwip/timeouts.h"
> +#include <linux/errno.h>
> +#include "ping.h"
> +#include "lwip_ping.h"
> +
> +#define PING_WAIT_MS 1000
> +
> +static ip_addr_t ip_target;
> +
> +static void ping_tmo(void *arg)
> +{
> +	char *ping_addr = (char *)arg;
> +
> +	log_err("ping failed; host %s is not alive\n", ping_addr);

just cast (char *)arg directly on log_err

> +	ulwip_exit(1);
> +}
> +

[...]

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
> +
> +void ping_init(const ip_addr_t *ping_addr);
> --
> 2.30.2
>

Thanks
/Ilias
