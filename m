Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D18DCA0FE4
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 14:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CCA68477A;
	Fri,  1 Sep 2023 16:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bgeYTWUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01596847C8; Fri,  1 Sep 2023 16:49:47 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D83884698
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 16:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52a069edca6so2702800a12.3
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693579780; x=1694184580; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jc7wKlxb8JEEWX/ir9Y5mcqU1JP3P/pPLwjl46tm7dY=;
 b=bgeYTWUDpMLnj0xlxXTlTTJlvdmgMXu1d/jz3j9G1U50LiFlaab3/E/gdI50We6niE
 feUN26G/8FTd3ik6K7izUxga9ebCNkJw7a8vAeqiIMGAt01eA0eduUu6W6qX1x2P4qT5
 HozKUFDuV+sLK2Kc+kGQi5k4hJh77pOXXoE+nfdxqmeS003qpyslR8DSwTba/Q7WlQLz
 02TS4z/05YPp3zSn/FigLxhcWMCeQZka74lKVIEhalLjRN2mCrXyMrTm5CJHq+apz50c
 lFhyPvr9jOKNq4TQ83KUqx8OYtmS2VIIJ1hbrjqZ/UZL1u9nRVUq23j33iuIihD8pCMQ
 wpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693579780; x=1694184580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jc7wKlxb8JEEWX/ir9Y5mcqU1JP3P/pPLwjl46tm7dY=;
 b=R6jzBDiL/CXkEJskuZfUZnA8P3a0qTHqRfUSIQ4iCIdaxp5tf3AE+drNr9FGxlV5ev
 t1ie1Cz3YaOefZ87DJViWrT6AHc0OAMB4tX+4ym9ZWb8KQsYbqviaundFv38sdUagftN
 mxvzuZXZ7HsQPco3CP3z66QmaaoY63qiAmjUhoKxwFxjIk+l0DKrZfI2wvZ6DSZJZxAP
 XfTG59rbUn6oasNVJxAUYXxBrC8cEWNXVUbqrugfrI9bpBU+8mA5/oRS3/skN+q5legx
 wGfyrUyIQmbrRfINRUgNitjcVoLKLwtn3nxodaD8wpJ4ShEf8mG3up8bkK3sS7z7zUw9
 hobg==
X-Gm-Message-State: AOJu0YykfUyoLS5SzHFU5rwk3keaOt/w5SV+so21LSVN5JChoDRt6SEN
 UEjcaovSKMdJw3J2tClJUDzbt44Cn2PJIyTmdNyklA==
X-Google-Smtp-Source: AGHT+IHW+FDxTYFnY33llixLheyUBA/9+fVD/2DqIS+WK4O31te8XNK5lcBcvTsmPIQwUNp4eTA9wEIJKyzxjyb5eNU=
X-Received: by 2002:a17:907:9724:b0:9a1:ff3f:aa18 with SMTP id
 jg36-20020a170907972400b009a1ff3faa18mr2276339ejc.75.1693579780532; Fri, 01
 Sep 2023 07:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
 <20230822093614.4717-4-maxim.uvarov@linaro.org>
 <CAPnjgZ0cjB__HHbMOvNvK--JyzDsRfzSAhsGmkhk9MkFoceVrA@mail.gmail.com>
In-Reply-To: <CAPnjgZ0cjB__HHbMOvNvK--JyzDsRfzSAhsGmkhk9MkFoceVrA@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Fri, 1 Sep 2023 20:49:28 +0600
Message-ID: <CAD8XO3bBH+1APi9an4pB-7t2_O2tgjhFsGypC68Didg5AaTn_A@mail.gmail.com>
Subject: Re: [PATCHv7 03/15] net/lwip: implement dns cmd
To: Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
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

On Wed, 23 Aug 2023 at 00:58, Simon Glass <sjg@google.com> wrote:

> Hi Maxim,
>
> On Tue, 22 Aug 2023 at 03:39, Maxim Uvarov <maxim.uvarov@linaro.org>
> wrote:
> >
> > U-Boot recently got support for an alternative network stack using LWIP.
> > Replace dns command with the LWIP variant while keeping the output and
> > error messages identical.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > ---
> >  include/net/lwip.h           | 19 +++++++++++++++
> >  net/lwip/Makefile            |  2 ++
> >  net/lwip/apps/dns/lwip-dns.c | 46 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 67 insertions(+)
> >  create mode 100644 include/net/lwip.h
> >  create mode 100644 net/lwip/apps/dns/lwip-dns.c
> >
> > diff --git a/include/net/lwip.h b/include/net/lwip.h
> > new file mode 100644
> > index 0000000000..cda896d062
> > --- /dev/null
> > +++ b/include/net/lwip.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
> > +               char *const argv[]);
>
> Please make sure you comment all exported functions, including the return
> value.
>
> > +
> > +/**
> > + * ulwip_dns() - creates the DNS request to resolve a domain host name
> > + *
> > + * This function creates the DNS request to resolve a domain host name.
> Function
> > + * can return immediately if previous request was cached or it might
> require
> > + * entering the polling loop for a request to a remote server.
> > + *
> > + * @name:    dns name to resolve
> > + * @varname: (optional) U-Boot variable name to store the result
> > + * Returns: ERR_OK(0) for fetching entry from the cache
> > + *         ERR_INPROGRESS(-5) success, can go to the polling loop
> > + *         Other value < 0, if error
> > + */
>

here.


> > +int ulwip_dns(char *name, char *varname);
> > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> > index d1161bea78..6d2c00605b 100644
> > --- a/net/lwip/Makefile
> > +++ b/net/lwip/Makefile
> > @@ -64,3 +64,5 @@ obj-$(CONFIG_NET) += $(LWIPDIR)/netif/ethernet.o
> >
> >  obj-$(CONFIG_NET) += port/if.o
> >  obj-$(CONFIG_NET) += port/sys-arch.o
> > +
> > +obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
> > diff --git a/net/lwip/apps/dns/lwip-dns.c b/net/lwip/apps/dns/lwip-dns.c
> > new file mode 100644
> > index 0000000000..6e205c1153
> > --- /dev/null
> > +++ b/net/lwip/apps/dns/lwip-dns.c
> > @@ -0,0 +1,46 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> > + */
> > +
> > +#include <common.h>
> > +#include <command.h>
> > +#include <console.h>
> > +
> > +#include <lwip/dns.h>
> > +#include <lwip/ip_addr.h>
> > +
> > +#include <net/ulwip.h>
> > +
> > +static void dns_found_cb(const char *name, const ip_addr_t *ipaddr,
> void *callback_arg)
> > +{
> > +       char *varname = (char *)callback_arg;
> > +
> > +       if (varname)
> > +               env_set(varname, ip4addr_ntoa(ipaddr));
> > +
> > +       log_info("resolved %s to %s\n",  name, ip4addr_ntoa(ipaddr));
> > +       ulwip_exit(0);
> > +}
> > +
> > +int ulwip_dns(char *name, char *varname)
> > +{
> > +       int err;
> > +       ip_addr_t ipaddr; /* not used */
> > +       ip_addr_t dns1;
> > +       ip_addr_t dns2;
> > +
> > +       ipaddr_aton(env_get("dnsip"), &dns1);
> > +       ipaddr_aton(env_get("dnsip2"), &dns2);
>
> What if the env_get() fails? Won't that return NULL?
>
>
all of these functions will not crash, they have null check. You can set
dnsip or dnsip2 or both. If both are not set then dns cmd will not look up
anything.
We can exit earlier here, but that is a common case and nothing bad if we
make code simpler and exit a little bit later.



> > +
> > +       dns_init();
> > +       dns_setserver(0, &dns1);
> > +       dns_setserver(1, &dns2);
>
> Can either of these fail?
>
> Please be very attentive to error-checking.
>

All  above functions are void. But they have LWIP_ASSERT() for sanity
checks in some places.


>
> > +
> > +       err = dns_gethostbyname(name, &ipaddr, dns_found_cb, varname);
> > +       if (err == ERR_OK)
>
> Is that 0? If so, then if (err) is better
>
>
dns_gethostbyname() returns ERR_OK which is defined
net/lwip/lwip-external/src/include/lwip/err.h.
Yes it's defined to 0 and maybe always will be defined to 0. But  that may
change. And I would keep
the check against the same return macro that the function does.



> > +               dns_found_cb(name, &ipaddr, varname);
> > +
> > +       return err;
>
> I am not sure what that is, but will review it when you add the header
> comments.
>
> In the header file of this function is an explanation. It's above in this
patch:
+ * Returns: ERR_OK(0) for fetching entry from the cache
+ *         ERR_INPROGRESS(-5) success, can go to the polling loop
+ *         Other value < 0, if error
+ */


> > +}
> > --
> > 2.30.2
> >
>
> Regards,
> Simon
>
