Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A16C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 06:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D637C868C0;
	Mon,  4 Sep 2023 08:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RlwhblIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DAEE868B8; Mon,  4 Sep 2023 08:58:44 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 589BB86415
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 08:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so156385266b.2
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 23:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693810721; x=1694415521; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GSSc2SkgAspHKz8UVC8ifEiyj86JxEfr/z6ZOODWY2A=;
 b=RlwhblIj8DXX2mBGHVf0T+enV9tR1SAlBdoDOQZ4LgQ+ahbGlJJRwoXhqdUKkb9agB
 xfTxuCfE7oENIQRvU6H3EB1GIriGbBI8mlXBjFPo0hNc1ebvf3hGcoXdB0XgGxEzY0Bc
 6HqXASqYNGaylxOcjyDbkG0cTHquY+vJJGA3L7AwA/ZxiyQyP3LGpDNthlX87XlGc0Vj
 tj8hBQ77ibky7rWJeVkYOcg0hac6NXyQ1hh9rBYYwEAmNV6/62FTBvTqGQgBoJaqMWCo
 R6jXVcv/hn0pxxPPRW7YDt4QFw4cZl7216AJiJTyf60vb8LfPuMl7rHryLtvQAjwaXPP
 NoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693810721; x=1694415521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GSSc2SkgAspHKz8UVC8ifEiyj86JxEfr/z6ZOODWY2A=;
 b=C2Cf540rOK+GsywagQPnUmCEXWOQyfwHqzV+SlYmz2MYQZvJs8nnQ5t1P9EIAcSdiB
 IXhr1INzGPdpg1bEcVamUKF1FZPffoDBaZ0/4NX9r+m7+xpvZn09pqTqn6WVbc/u8TiD
 ShiVV4rc/nPUYSmEMqZcFnZf9OZwkVsDde8kM+AeIsXPUYjsrsYyl6jFGTBY2wtUvWeN
 0Jwo+SiM2+JBbpMROqHrfEMiRWfxwqT7uaPf5YROXB7RKoqMQPR/ZegCYY928+rLtoZY
 0GlDQiwXww4ra5h4jvEnVWDKE7Oxk5AEeDikcYbLvBHHBCLusOVctrnK8UQyecHDrTnU
 ibJw==
X-Gm-Message-State: AOJu0YzCZkD6JG92gjv59ZCQ9wZkF42rsJvjn2lYV7oF8n9sQqe9Jen9
 X7kXPapXKKf7GAubXVu4rAjAyG5/nDkNmR4ZBfujHw==
X-Google-Smtp-Source: AGHT+IG48AJZiLEmJ8ljCpafSKAURUREff2BInbKyQGi9lWJOlw/k1nTDVXnaHwsYh1bluvjFAEFWVdP844ZZevK9Yo=
X-Received: by 2002:a17:906:a18b:b0:9a6:1560:42da with SMTP id
 s11-20020a170906a18b00b009a6156042damr5649575ejy.15.1693810720670; Sun, 03
 Sep 2023 23:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
 <20230822093614.4717-4-maxim.uvarov@linaro.org>
 <CAPnjgZ0cjB__HHbMOvNvK--JyzDsRfzSAhsGmkhk9MkFoceVrA@mail.gmail.com>
 <CAD8XO3bBH+1APi9an4pB-7t2_O2tgjhFsGypC68Didg5AaTn_A@mail.gmail.com>
 <CAPnjgZ271E7Te3JyumjU7kSGs4Qmnp8RSC5Y7YqDnYHuVKxG6w@mail.gmail.com>
In-Reply-To: <CAPnjgZ271E7Te3JyumjU7kSGs4Qmnp8RSC5Y7YqDnYHuVKxG6w@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Mon, 4 Sep 2023 12:58:28 +0600
Message-ID: <CAD8XO3b_gtbdvpwQSraQFePY9Mc9kDpYpfJoEQpQ-AP796rjbg@mail.gmail.com>
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

On Sat, 2 Sept 2023 at 06:09, Simon Glass <sjg@google.com> wrote:

> Hi Maxim,
>
> On Fri, 1 Sept 2023 at 08:49, Maxim Uvarov <maxim.uvarov@linaro.org>
> wrote:
> >
> >
> >
> > On Wed, 23 Aug 2023 at 00:58, Simon Glass <sjg@google.com> wrote:
> >>
> >> Hi Maxim,
> >>
> >> On Tue, 22 Aug 2023 at 03:39, Maxim Uvarov <maxim.uvarov@linaro.org>
> wrote:
> >> >
> >> > U-Boot recently got support for an alternative network stack using
> LWIP.
> >> > Replace dns command with the LWIP variant while keeping the output and
> >> > error messages identical.
> >> >
> >> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> >> > ---
> >> >  include/net/lwip.h           | 19 +++++++++++++++
> >> >  net/lwip/Makefile            |  2 ++
> >> >  net/lwip/apps/dns/lwip-dns.c | 46
> ++++++++++++++++++++++++++++++++++++
> >> >  3 files changed, 67 insertions(+)
> >> >  create mode 100644 include/net/lwip.h
> >> >  create mode 100644 net/lwip/apps/dns/lwip-dns.c
> >> >
> >> > diff --git a/include/net/lwip.h b/include/net/lwip.h
> >> > new file mode 100644
> >> > index 0000000000..cda896d062
> >> > --- /dev/null
> >> > +++ b/include/net/lwip.h
> >> > @@ -0,0 +1,19 @@
> >> > +/* SPDX-License-Identifier: GPL-2.0 */
> >> > +
> >> > +int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
> >> > +               char *const argv[]);
> >>
> >> Please make sure you comment all exported functions, including the
> return value.
> >>
> >> > +
> >> > +/**
> >> > + * ulwip_dns() - creates the DNS request to resolve a domain host
> name
> >> > + *
> >> > + * This function creates the DNS request to resolve a domain host
> name. Function
> >> > + * can return immediately if previous request was cached or it might
> require
> >> > + * entering the polling loop for a request to a remote server.
> >> > + *
> >> > + * @name:    dns name to resolve
> >> > + * @varname: (optional) U-Boot variable name to store the result
> >> > + * Returns: ERR_OK(0) for fetching entry from the cache
> >> > + *         ERR_INPROGRESS(-5) success, can go to the polling loop
> >> > + *         Other value < 0, if error
> >> > + */
> >
> >
> > here.
>
> That seems to be a different function?
>
> >
> >>
> >> > +int ulwip_dns(char *name, char *varname);
>
> This one has no comment?
>
> >> > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> >> > index d1161bea78..6d2c00605b 100644
> >> > --- a/net/lwip/Makefile
> >> > +++ b/net/lwip/Makefile
> >> > @@ -64,3 +64,5 @@ obj-$(CONFIG_NET) += $(LWIPDIR)/netif/ethernet.o
> >> >
> >> >  obj-$(CONFIG_NET) += port/if.o
> >> >  obj-$(CONFIG_NET) += port/sys-arch.o
> >> > +
> >> > +obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
> >> > diff --git a/net/lwip/apps/dns/lwip-dns.c
> b/net/lwip/apps/dns/lwip-dns.c
> >> > new file mode 100644
> >> > index 0000000000..6e205c1153
> >> > --- /dev/null
> >> > +++ b/net/lwip/apps/dns/lwip-dns.c
> >> > @@ -0,0 +1,46 @@
> >> > +// SPDX-License-Identifier: GPL-2.0
> >> > +
> >> > +/*
> >> > + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> >> > + */
> >> > +
> >> > +#include <common.h>
> >> > +#include <command.h>
> >> > +#include <console.h>
> >> > +
> >> > +#include <lwip/dns.h>
> >> > +#include <lwip/ip_addr.h>
> >> > +
> >> > +#include <net/ulwip.h>
> >> > +
> >> > +static void dns_found_cb(const char *name, const ip_addr_t *ipaddr,
> void *callback_arg)
> >> > +{
> >> > +       char *varname = (char *)callback_arg;
> >> > +
> >> > +       if (varname)
> >> > +               env_set(varname, ip4addr_ntoa(ipaddr));
>
> That can fail
>
>
yea, will add a check.


> >> > +
> >> > +       log_info("resolved %s to %s\n",  name, ip4addr_ntoa(ipaddr));
> >> > +       ulwip_exit(0);
> >> > +}
> >> > +
> >> > +int ulwip_dns(char *name, char *varname)
> >> > +{
> >> > +       int err;
> >> > +       ip_addr_t ipaddr; /* not used */
> >> > +       ip_addr_t dns1;
> >> > +       ip_addr_t dns2;
> >> > +
> >> > +       ipaddr_aton(env_get("dnsip"), &dns1);
> >> > +       ipaddr_aton(env_get("dnsip2"), &dns2);
> >>
> >> What if the env_get() fails? Won't that return NULL?
> >>
> >
> > all of these functions will not crash, they have null check. You can set
> dnsip or dnsip2 or both. If both are not set then dns cmd will not look up
> anything.
> > We can exit earlier here, but that is a common case and nothing bad if
> we make code simpler and exit a little bit later.
>
> OK but I cannot see where the error is returned?
>
>
I will add more checks.  dns_gethostbyname() will return an error if dns
were set wrongly. But I will also add more checks here to be clear for
other people also.


> >
> >
> >>
> >> > +
> >> > +       dns_init();
> >> > +       dns_setserver(0, &dns1);
> >> > +       dns_setserver(1, &dns2);
> >>
> >> Can either of these fail?
> >>
> >> Please be very attentive to error-checking.
> >
> >
> > All  above functions are void. But they have LWIP_ASSERT() for sanity
> checks in some places.
> >
> >>
> >>
> >> > +
> >> > +       err = dns_gethostbyname(name, &ipaddr, dns_found_cb, varname);
> >> > +       if (err == ERR_OK)
> >>
> >> Is that 0? If so, then if (err) is better
> >>
> >
> > dns_gethostbyname() returns ERR_OK which is defined
> net/lwip/lwip-external/src/include/lwip/err.h.
> > Yes it's defined to 0 and maybe always will be defined to 0. But  that
> may change. And I would keep
> > the check against the same return macro that the function does.
>
> I cannot imagine it changing.
>
> >
> >
> >>
> >> > +               dns_found_cb(name, &ipaddr, varname);
> >> > +
> >> > +       return err;
> >>
> >> I am not sure what that is, but will review it when you add the header
> comments.
> >>
> > In the header file of this function is an explanation. It's above in
> this patch:
> > + * Returns: ERR_OK(0) for fetching entry from the cache
> > + *         ERR_INPROGRESS(-5) success, can go to the polling loop
> > + *         Other value < 0, if error
> > + */
>
> OK, so what I am getting at is trying to understand the error
> conversion. It seems that lwip uses different numbering from
> U-Boot/Linux, so we need to do a conversion somewhere?
>
> Regards,
> Simon
>

Yes, that is exactly what happens here. Lwip  ERR_INPROGRESS(-5) might be
U-boot:
#define EINPROGRESS     115     /* Operation now in progress */

I can do a conversion here with some comments to make it more clear.
