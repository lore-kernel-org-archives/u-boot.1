Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0639C001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 03:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D5E86C78;
	Fri, 18 Aug 2023 05:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="wsARhJLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089D986C71; Fri, 18 Aug 2023 05:10:24 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03E6C86C5E
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 05:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5255da974c4so502219a12.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 20:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692328220; x=1692933020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EOXIWdpPOVnprmpQ8h2rWyOkDNrT5IeIRERr4NJQdsc=;
 b=wsARhJLgOXJy9gaNVAf3r4lna4mDynvEOXIbLK9kgpl4OzDd1m5KTLQIp/May5c7nK
 XzbUvSKJiv8+hPrIGFbFEC7dy65m51PP8MRWRlef0+sZKdsznyWC9IKS5P8Ffq2HOvP/
 kUZvCmG0ycKEI+vZ+VVtYwavSThZK81Ss+QeJvjIVj6rCMz5PHxgQPC7Ar+iKmUn1kw6
 aJHoMCYpuzv52JFDHCI759IOyGiwG5JpcrfbQQT+M7CMjpMnkYfvFHwy9iRRFEGUYkH7
 h6mdPMW1BU1HB0MklmbHHxRg1ACLcPAu93EThG6Gjp5GgYph/HdHRrGlhw7lrMksmaCm
 u/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692328220; x=1692933020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EOXIWdpPOVnprmpQ8h2rWyOkDNrT5IeIRERr4NJQdsc=;
 b=M9GZdJTeshMW/D7vrbTFt4Yxfv8BFxmbvcWkLEbsAfahWvsJuFO20Qbb2e7ioU3rqG
 f0/rUaX9ErqgOYHFJitDxY9TX4zxnRKrzPaT6MBfUNzmoINeEMcbV+OGzUzL5NUe+O0n
 uuovd1i93FmgnyP1/chSOsgnZXNWCCCjBu4bx5TOnqXnslCCgpsHWKa030zZAIg2xvXS
 vkYZGISRb8H2UUo79L5jF+KR5nPuTLFR9h4MepSuyp4I2XDTjlJqfQyxR0/LKESIigBA
 3kiYd9XVMZcrnDg+b10DCt9SKaoftMP1hWkfKtNvZqLLQTy8qjBlFht8brLz6MFUNJTn
 8eBw==
X-Gm-Message-State: AOJu0YySOGKTKKiNIK6U2Stu/4CP9QJaoONCEQ5iTmvVBT3WCUzIGEkY
 AUL0lZx3HQFjV1ATsozaaVraFu8KtMYO0pky9aJEwQ==
X-Google-Smtp-Source: AGHT+IG8j9uAmYuLzqpdkyXHgrx0tT25ZsMV0+R9V8c+NbN85TUTpB+Bd8Y9q6pXni0dF4YrA6sKLs0UWj++W6R0W8M=
X-Received: by 2002:aa7:d80d:0:b0:523:38eb:395f with SMTP id
 v13-20020aa7d80d000000b0052338eb395fmr1143631edq.2.1692328220406; Thu, 17 Aug
 2023 20:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-8-maxim.uvarov@linaro.org> <ZNyL7ACbL1g8e4Cz@hades>
 <CAD8XO3bH2oBK2z3ZyW50mDJBGF2K+Lq-X+gBjg1pdE8p_BDZdw@mail.gmail.com>
 <CAPnjgZ24Qon9NnBsAukevwTeGwCMrr1+fVbOU-r68k3MdNmoCw@mail.gmail.com>
 <CAD8XO3Y-ik3oi1pR+N3+9VeSFP70b_aBZsR=7irHYtosFsMgMQ@mail.gmail.com>
In-Reply-To: <CAD8XO3Y-ik3oi1pR+N3+9VeSFP70b_aBZsR=7irHYtosFsMgMQ@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Thu, 17 Aug 2023 21:10:11 -0600
Message-ID: <CAPnjgZ0CzqFPpQ6Gz39-60E5n8a4FpioBGyWmXjMQg6yWwemSA@mail.gmail.com>
Subject: Re: [PATCHv6 07/14] net/lwip: implement ping cmd
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Simon Goldschmidt <goldsimon@gmx.de>, 
 lwip-devel <lwip-devel@nongnu.org>, Peter Robinson <pbrobinson@gmail.com>
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

Hi Maxim,

On Wed, 16 Aug 2023 at 14:15, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
>
>
> On Wed, 16 Aug 2023 at 20:39, Simon Glass <sjg@google.com> wrote:
>>
>> Hi Maxim,
>>
>> On Wed, 16 Aug 2023 at 03:09, Maxim Uvarov <maxim.uvarov@linaro.org>
wrote:
>> >
>> > On Wed, 16 Aug 2023 at 14:42, Ilias Apalodimas <
ilias.apalodimas@linaro.org>
>> > wrote:
>> >
>> > > On Mon, Aug 14, 2023 at 07:32:46PM +0600, Maxim Uvarov wrote:
>> > > >  * can return immediately if previous request was cached or it
might
>> > > require
>> > > > @@ -38,3 +39,28 @@ int ulwip_dhcp(void);
>> > > >  *         !0 if error
>> > > >  */
>> > > >  int ulwip_wget(ulong addr, char *url);
>> > > > +
>> > > > +/**
>> > > > + * ulwip_tftp() - load file with tftp
>> > > > + *
>> > > > + * Load file with tftp to specific address
>> > > > + *
>> > > > + * @param addr - address to store downloaded file
>> > > > + * @param filename - file name on remote tftp server to download
>> > >
>> > > Please fix function comments properly
>> > >
>> > > > + *
>> > > > + *
>> > > > + * @return 0 if success, !0 if error
>> > > > + */
>> > > > +int ulwip_tftp(ulong addr, const char *filename);
>> > > > +
>> > > > +/*
>> > > > +* This function creates the ping for  address provided in
parameters.
>> > > > +* After this function you need to invoke the polling
>> > > > +* loop to process network communication.
>> > > > +*
>> > > > +*
>> > > > +* @ping_addr  start address to download result
>> > > > +* Return: 0 for success
>> > > > +*         !0 if error
>> > > > +*/
>> > > > +int ulwip_ping(char *ping_addr);
>> > > > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
>> > > > index 4c6df94807..8b3e843426 100644
>> > > > --- a/net/lwip/Makefile
>> > > > +++ b/net/lwip/Makefile
>> > > > @@ -67,5 +67,6 @@ obj-$(CONFIG_NET) += port/sys-arch.o
>> > > >
>> > > >  obj-$(CONFIG_CMD_DHCP) += apps/dhcp/lwip-dhcp.o
>> > > >  obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
>> > > > +obj-$(CONFIG_CMD_PING) += apps/ping/
>> > > >  obj-$(CONFIG_CMD_TFTPBOOT) += apps/tftp/
>> > > >  obj-$(CONFIG_CMD_WGET) += apps/http/
>> > > > diff --git a/net/lwip/apps/ping/Makefile
b/net/lwip/apps/ping/Makefile
>> > > > new file mode 100644
>> > > > index 0000000000..dc63feb7b5
>> > > > --- /dev/null
>> > > > +++ b/net/lwip/apps/ping/Makefile
>> > > > @@ -0,0 +1,11 @@
>> > > > +ccflags-y += -I$(srctree)/net/lwip/port/include
>> > > > +ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include
>> > > -I$(srctree)/net/lwip
>> > > > +ccflags-y += -I$(obj)
>> > > > +
>> > > > +.PHONY: $(obj)/ping.c
>> > > > +$(obj)/ping.o: $(obj)/ping.c
>> > > > +$(obj)/ping.c:
>> > > > +     cp $(srctree)/net/lwip/lwip-external/contrib/apps/ping/ping.c
>> > > $(obj)/ping.c
>> > > > +
>> > > > +obj-$(CONFIG_CMD_PING) += ping.o
>> > > > +obj-$(CONFIG_CMD_PING) += lwip_ping.o
>> > > > diff --git a/net/lwip/apps/ping/lwip_ping.c
>> > > b/net/lwip/apps/ping/lwip_ping.c
>> > > > new file mode 100644
>> > > > index 0000000000..611fcaf591
>> > > > --- /dev/null
>> > > > +++ b/net/lwip/apps/ping/lwip_ping.c
>> > > > @@ -0,0 +1,37 @@
>> > > > +// SPDX-License-Identifier: GPL-2.0
>> > > > +
>> > > > +/*
>> > > > + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
>> > > > + */
>> > > > +
>> > > > +#include "lwip/opt.h"
>> > > > +#include "lwip/ip_addr.h"
>> > > > +#include "ping.h"
>> > > > +#include "lwip_ping.h"
>> > > > +
>> > > > +static ip_addr_t ip_target;
>> > > > +
>> > > > +static int ulwip_ping_tmo(void)
>> > > > +{
>> > > > +
>> > > > +     log_err("ping failed; host %s is not alive\n",
>> > > ipaddr_ntoa(&ip_target));
>> > > > +     return 1;
>> > > > +}
>> > > > +
>> > > > +int ulwip_ping(char *ping_addr)
>> > > > +{
>> > > > +     int err;
>> > > > +
>> > > > +     err = ipaddr_aton(ping_addr, &ip_target);
>> > > > +     if (!err) {
>> > > > +             log_err("wrong ping addr string \"%s\" \n",
ping_addr);
>> > >
>> > > Invalid ip address is enough
>> > >
>> > > > +             return -1;
>> > > > +     }
>> > > > +
>> > > > +     ulwip_set_tmo(ulwip_ping_tmo);
>> > > > +
>> > > > +     ping_init(&ip_target);
>> > > > +     ping_send_now();
>> > > > +
>> > > > +     return 0;
>> > > > +}
>> > > > diff --git a/net/lwip/apps/ping/lwip_ping.h
>> > > b/net/lwip/apps/ping/lwip_ping.h
>> > > > new file mode 100644
>> > > > index 0000000000..0374f07d9e
>> > > > --- /dev/null
>> > > > +++ b/net/lwip/apps/ping/lwip_ping.h
>> > > > @@ -0,0 +1,15 @@
>> > > > +/* SPDX-License-Identifier: GPL-2.0+ */
>> > > > +
>> > > > +/*
>> > > > + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
>> > > > + */
>> > > > +
>> > > > +#ifndef LWIP_PING_H
>> > > > +#define LWIP_PING_H
>> > > > +
>> > > > +#include <lwip/ip_addr.h>
>> > > > +
>> > > > +void ping_raw_init(void);
>> > > > +void ping_send_now(void);
>> > > > +
>> > > > +#endif /* LWIP_PING_H */
>> > > > diff --git a/net/lwip/apps/ping/ping.h b/net/lwip/apps/ping/ping.h
>> > > > new file mode 100644
>> > > > index 0000000000..006a18c658
>> > > > --- /dev/null
>> > > > +++ b/net/lwip/apps/ping/ping.h
>> > > > @@ -0,0 +1,19 @@
>> > > > +/* SPDX-License-Identifier: GPL-2.0 */
>> > > > +
>> > > > +#include <net/ulwip.h>
>> > > > +#include "lwip/ip_addr.h"
>> > > > +
>> > > > +#define LWIP_DEBUG 1 /* ping_time is under ifdef*/
>> > > > +#define PING_RESULT(cond) { \
>> > > > +     if (cond == 1) { \
>> > > > +             printf("host %s a alive\n", ipaddr_ntoa(addr)); \
>> > > > +             printf(" %"U32_F" ms\n", (sys_now() - ping_time)); \
>> > > > +             ulwip_exit(0); \
>> > > > +     } else { \
>> > > > +             printf("ping failed; host %s in not alive\n",\
>> > > > +                    ipaddr_ntoa(addr)); \
>> > > > +             ulwip_exit(-1); \
>> > > > +     } \
>> > > > +     } while (0);
>> > >
>> > > On the previous patch you are defining a function to do something
similar
>> > > (httpc_result()).  We need to be consistent on this.  Can we define a
>> > > common function for all failures?  Certianly don't define a macro
here and
>> > > a function elsewhere
>> > >
>> >
>> > Ilias, there I reuse lwip example ping.c. It has PING_RESULT which can
be
>> > redefined by the application.
>> > This is a way to not modify this original ping.c example code.
>> > The common part of this function and httpc_result() is ulwip_exit(err)
with
>> > some additional print (print is differ).
>>
>> I'll reply on this patch, although it is a general comment.
>>
>> I would like to see if we can use the cyclic feature to allow network
>> operations to happen in the background. This would involve splitting
>> each operation into:
>>
>> - setup start and kick off, e.g. ping_sttart()
>> - checking what needs doing, e.g. ping_poll()
>> - finish and clean-up, e.g. ping_finish()
>>
>> So something like:
>>
>> ping -B 1.2.3.4
>>
>> (-B is background)
>>
>> That would fire off the packet but immediately return with a prompt.
>> When the pings are received they would show on the console, with a new
>> prompt displayed. The same for tftp -B...it would start the transfer
>> but allow other commands to be sent while it is in progress.
>>
>> Part of the reason for this is that when booting there are a lot of
>> operations which take a long time and nothing happens until everything
>> is done. For example, with standard boot, mmc devices can be shown
>> right away, but USB and network ones take a lot longer, so having OS's
>> on those devices appear later on the slower devices is desirable for
>> the user.
>>
>> Is this something that lwip can support? It is one reason why I have
>> advocating putting the state in a struct instead of having a lot of
>> separate vars.
>>
>> Regards,
>> Simon
>
>
> This functionality can be added. I do not see any restrictions
implementing that.
> Added I mean to U-Boot. lwip will definitely work with it.
>
> There is no specific poll() for application. Application just do init()
and request
> the needed packets (port, type etc, like sockets) and then common lwip
poll()
> function is called.
>
> To implement background we need to periodically call eth_rx() and
ulwip_poll() to feed lwip
> stack with rx packets when we are in the cmd shell. I see in some places
we call schedule()
> to reprogram wdt, if we call rx polling loop in the similar way the app
will work in the background.
>
> We might also want to support 2 applications at the same time. Like a
telnet server
> and ping. Multiply applications also work with lwip.
>
> Even parallel download can save some time:
> wget -B http://url1/zImage
> wget -B http//url2/dtb
> (-B = background)
>
> But I'm thinking if we can implement background  in a more generic way in
U-Boot cmd. Things like
> mount UBI fs, or download from SPI flash is slow. Or probably we can also
do some loading while
> verifying the zImage checksum.

Yes, perhaps we can keep a record of the command that is running, with a
little bit of state there. But does the stack support two wgets at once?

Regards,
Simon
