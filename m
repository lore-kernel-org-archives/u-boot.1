Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90629C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 09:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F56868D3;
	Wed, 16 Aug 2023 11:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a0h7knNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B2B7867E2; Wed, 16 Aug 2023 11:09:31 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64EDC86954
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 11:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4ff9121fd29so624138e87.3
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 02:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692176967; x=1692781767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pkTlSX0hVkei020CujtiGvkXo2PY2ublzcWqeKnkMdE=;
 b=a0h7knNYCTqZjZHTHzkOMn8noborSh1w09+PChzKEz8NrwwJNYIaRNFv4nKPvqTRGd
 DOq09cGKKfiCktoWXP0gXrAej6TVSV1ufXx1sVeEfCfibqWUyVhxdEHt5Oz4r3BSH6t2
 Hvnb5xH+mISb6DrIndMiwvehOvaWXjdxNqpQlGJvlj1AohZc5jDr1XerdcHyxCoeBqdz
 8RAwJvm7l99MhDdor2uxtUmzIKVqn24mVoDfSPLpp+7YX4ZkjNPn2qzKTLpvFme9GnG/
 kv6Mbb7IUQgEZMy70cRq1mrSjkqzV/GR8oE+xNNF3vuKRfPB8oXCzhFlsiHPGv7B+6e2
 Le+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692176967; x=1692781767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pkTlSX0hVkei020CujtiGvkXo2PY2ublzcWqeKnkMdE=;
 b=YJHzvI7z3062OWC1Ei6TCDW6ddeJPTfJDeA9kAsDvRVXMgoJwcXMdJ03VCcJauhZBY
 O+PjCj9t/xpcP+lKroaeyuZcGiRcYxl7E3ahVgWVeS0EeQ4GlMWQoCg6iNZFaCFZiPdV
 aDfEhIGTU0EhwVhmZCT3h3OcT7SQ3sf7/qj+Y15kQ3eGqr8b5Td8KA/gugQ/fb9csYgM
 D0rEKfuGxTjrDOu3Y9+bzqUYf6mxM0XCxfVqeRHr92xBT39zN+S/bV2Yat64qMkYdLAK
 CnQgVrOe17qHqaDeVJ4XuqksxJImH6jxhCGqOW29q/fum7AD4ttU1Dc8EDFXSDU+BjbX
 wKVQ==
X-Gm-Message-State: AOJu0YwAsa/NnhndqUpQNHLs7Yar5DfesJrpzVXJis4Z/YVIosusFrLh
 4lllI9e9lqRUyeCha4KxGKsuWnQ2PUh7D3reWHebTA==
X-Google-Smtp-Source: AGHT+IGt2x4NCbQm/t+GxY0zf+vC9C0XkxZrWy0ABQLE6FK2k9+PTopYmAtgxpZVCZ6yeqf5HAsyX9FO8UYg0P0MLuA=
X-Received: by 2002:a05:6512:2024:b0:4fb:99c6:8533 with SMTP id
 s4-20020a056512202400b004fb99c68533mr971866lfs.33.1692176967537; Wed, 16 Aug
 2023 02:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-8-maxim.uvarov@linaro.org> <ZNyL7ACbL1g8e4Cz@hades>
In-Reply-To: <ZNyL7ACbL1g8e4Cz@hades>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 16 Aug 2023 15:09:14 +0600
Message-ID: <CAD8XO3bH2oBK2z3ZyW50mDJBGF2K+Lq-X+gBjg1pdE8p_BDZdw@mail.gmail.com>
Subject: Re: [PATCHv6 07/14] net/lwip: implement ping cmd
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@redhat.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de, 
 lwip-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 16 Aug 2023 at 14:42, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Mon, Aug 14, 2023 at 07:32:46PM +0600, Maxim Uvarov wrote:
> >  * can return immediately if previous request was cached or it might
> require
> > @@ -38,3 +39,28 @@ int ulwip_dhcp(void);
> >  *         !0 if error
> >  */
> >  int ulwip_wget(ulong addr, char *url);
> > +
> > +/**
> > + * ulwip_tftp() - load file with tftp
> > + *
> > + * Load file with tftp to specific address
> > + *
> > + * @param addr - address to store downloaded file
> > + * @param filename - file name on remote tftp server to download
>
> Please fix function comments properly
>
> > + *
> > + *
> > + * @return 0 if success, !0 if error
> > + */
> > +int ulwip_tftp(ulong addr, const char *filename);
> > +
> > +/*
> > +* This function creates the ping for  address provided in parameters.
> > +* After this function you need to invoke the polling
> > +* loop to process network communication.
> > +*
> > +*
> > +* @ping_addr  start address to download result
> > +* Return: 0 for success
> > +*         !0 if error
> > +*/
> > +int ulwip_ping(char *ping_addr);
> > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> > index 4c6df94807..8b3e843426 100644
> > --- a/net/lwip/Makefile
> > +++ b/net/lwip/Makefile
> > @@ -67,5 +67,6 @@ obj-$(CONFIG_NET) += port/sys-arch.o
> >
> >  obj-$(CONFIG_CMD_DHCP) += apps/dhcp/lwip-dhcp.o
> >  obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
> > +obj-$(CONFIG_CMD_PING) += apps/ping/
> >  obj-$(CONFIG_CMD_TFTPBOOT) += apps/tftp/
> >  obj-$(CONFIG_CMD_WGET) += apps/http/
> > diff --git a/net/lwip/apps/ping/Makefile b/net/lwip/apps/ping/Makefile
> > new file mode 100644
> > index 0000000000..dc63feb7b5
> > --- /dev/null
> > +++ b/net/lwip/apps/ping/Makefile
> > @@ -0,0 +1,11 @@
> > +ccflags-y += -I$(srctree)/net/lwip/port/include
> > +ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include
> -I$(srctree)/net/lwip
> > +ccflags-y += -I$(obj)
> > +
> > +.PHONY: $(obj)/ping.c
> > +$(obj)/ping.o: $(obj)/ping.c
> > +$(obj)/ping.c:
> > +     cp $(srctree)/net/lwip/lwip-external/contrib/apps/ping/ping.c
> $(obj)/ping.c
> > +
> > +obj-$(CONFIG_CMD_PING) += ping.o
> > +obj-$(CONFIG_CMD_PING) += lwip_ping.o
> > diff --git a/net/lwip/apps/ping/lwip_ping.c
> b/net/lwip/apps/ping/lwip_ping.c
> > new file mode 100644
> > index 0000000000..611fcaf591
> > --- /dev/null
> > +++ b/net/lwip/apps/ping/lwip_ping.c
> > @@ -0,0 +1,37 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> > + */
> > +
> > +#include "lwip/opt.h"
> > +#include "lwip/ip_addr.h"
> > +#include "ping.h"
> > +#include "lwip_ping.h"
> > +
> > +static ip_addr_t ip_target;
> > +
> > +static int ulwip_ping_tmo(void)
> > +{
> > +
> > +     log_err("ping failed; host %s is not alive\n",
> ipaddr_ntoa(&ip_target));
> > +     return 1;
> > +}
> > +
> > +int ulwip_ping(char *ping_addr)
> > +{
> > +     int err;
> > +
> > +     err = ipaddr_aton(ping_addr, &ip_target);
> > +     if (!err) {
> > +             log_err("wrong ping addr string \"%s\" \n", ping_addr);
>
> Invalid ip address is enough
>
> > +             return -1;
> > +     }
> > +
> > +     ulwip_set_tmo(ulwip_ping_tmo);
> > +
> > +     ping_init(&ip_target);
> > +     ping_send_now();
> > +
> > +     return 0;
> > +}
> > diff --git a/net/lwip/apps/ping/lwip_ping.h
> b/net/lwip/apps/ping/lwip_ping.h
> > new file mode 100644
> > index 0000000000..0374f07d9e
> > --- /dev/null
> > +++ b/net/lwip/apps/ping/lwip_ping.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +/*
> > + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> > + */
> > +
> > +#ifndef LWIP_PING_H
> > +#define LWIP_PING_H
> > +
> > +#include <lwip/ip_addr.h>
> > +
> > +void ping_raw_init(void);
> > +void ping_send_now(void);
> > +
> > +#endif /* LWIP_PING_H */
> > diff --git a/net/lwip/apps/ping/ping.h b/net/lwip/apps/ping/ping.h
> > new file mode 100644
> > index 0000000000..006a18c658
> > --- /dev/null
> > +++ b/net/lwip/apps/ping/ping.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#include <net/ulwip.h>
> > +#include "lwip/ip_addr.h"
> > +
> > +#define LWIP_DEBUG 1 /* ping_time is under ifdef*/
> > +#define PING_RESULT(cond) { \
> > +     if (cond == 1) { \
> > +             printf("host %s a alive\n", ipaddr_ntoa(addr)); \
> > +             printf(" %"U32_F" ms\n", (sys_now() - ping_time)); \
> > +             ulwip_exit(0); \
> > +     } else { \
> > +             printf("ping failed; host %s in not alive\n",\
> > +                    ipaddr_ntoa(addr)); \
> > +             ulwip_exit(-1); \
> > +     } \
> > +     } while (0);
>
> On the previous patch you are defining a function to do something similar
> (httpc_result()).  We need to be consistent on this.  Can we define a
> common function for all failures?  Certianly don't define a macro here and
> a function elsewhere
>

Ilias, there I reuse lwip example ping.c. It has PING_RESULT which can be
redefined by the application.
This is a way to not modify this original ping.c example code.
The common part of this function and httpc_result() is ulwip_exit(err) with
some additional print (print is differ).

BR,
Maxim.


>
> > +
> > +void ping_init(const ip_addr_t *ping_addr);
> > --
> > 2.30.2
> >
>
> Thanks
> /Ilias
>
