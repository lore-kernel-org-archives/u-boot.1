Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26C1CA0FF9
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 00:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6405867C7;
	Sat,  2 Sep 2023 02:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="BEHYCuyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFDD586453; Sat,  2 Sep 2023 02:09:37 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A0738657B
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 02:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so3450863a12.0
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693613374; x=1694218174; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QhEGMvGUfIB4gAcEvz/7I8u5OVzHKiqTmOVJ7CkTBIg=;
 b=BEHYCuyp0JKcg0iUIZpNVgzoW146a7H2X4lf+LoYgERPsWxmS4cdDO4i+0vhvFn7xR
 bev2UDJ65EAG5B4LmsUKqKyOxqIOaFu3b9I59kn2/qIcjwBNNe+aE3/WKulVV7QvjGYk
 RWF3VhIaVhPqjkk+G+R9t/2j5zO/3c1F4Bz1hLVOHtabenlA3WSi8mRyfUjajqUFuwd4
 EvraR3V02XKq4FVIeX07gu1BMysolME9oN/PxxyJtisd6GIOIfL9/HsvPn9CWJd033mt
 ER8nnSZd0aUcwNDf1s7Vre2NrF/I9dBtfTWJ5J4rgxeX41rquw8u+3nPWkmDxcD+/v8U
 lfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693613374; x=1694218174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QhEGMvGUfIB4gAcEvz/7I8u5OVzHKiqTmOVJ7CkTBIg=;
 b=BLrY82XGQ/aWutKAG8zj235O+ihkcM8saBH5kpuoS8wLfvIj115MArN1m7sjBmGi+R
 /IcH+rR0fIXp/KgrMm4a7ExIwPj6kZjx8WkXG5WoeL+tdix7QrnadXgZfqxaSdmOSyWq
 OJvB6QRNXQXkuvtnQB/c58Xl9xEn9fXSt/h5Tl6IVOSB38O+T7vu7CdFlzkqYos+AxQD
 ucKIN9XzixB+0SOIJ8azxVo/T4XZ00f1r0Ybkj4AistqPcrYJFbF5tsOrGkUERKbB8PP
 Oc+1jZMihYWU6OB5cs39aZSaPwMNrWpNS9lOmjCoSuRHkCoD0kuqDpPnxzRM4beHw9/3
 wHXA==
X-Gm-Message-State: AOJu0YxKKePJdHj1KGrdGzjB8hDtUhEATffb6t3/UJ85zJwzPeRvqH0z
 Z0bSk9FRDRWUeLkD6ga/ZiU4jRhd6PFUY9/TPpjP5w==
X-Google-Smtp-Source: AGHT+IE2fhnsbQidcVZJZllaksXcb+7HFy95Y8/5Ru3p9B2lutzhBg+idDCz47ik77HAq/qvhiSRHCvarYCRbixqgSk=
X-Received: by 2002:a05:6402:b11:b0:523:3853:e01a with SMTP id
 bm17-20020a0564020b1100b005233853e01amr2914786edb.36.1693613374532; Fri, 01
 Sep 2023 17:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
 <20230822093614.4717-4-maxim.uvarov@linaro.org>
 <CAPnjgZ0cjB__HHbMOvNvK--JyzDsRfzSAhsGmkhk9MkFoceVrA@mail.gmail.com>
 <CAD8XO3bBH+1APi9an4pB-7t2_O2tgjhFsGypC68Didg5AaTn_A@mail.gmail.com>
In-Reply-To: <CAD8XO3bBH+1APi9an4pB-7t2_O2tgjhFsGypC68Didg5AaTn_A@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Fri, 1 Sep 2023 18:09:11 -0600
Message-ID: <CAPnjgZ271E7Te3JyumjU7kSGs4Qmnp8RSC5Y7YqDnYHuVKxG6w@mail.gmail.com>
Subject: Re: [PATCHv7 03/15] net/lwip: implement dns cmd
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

On Fri, 1 Sept 2023 at 08:49, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
>
>
> On Wed, 23 Aug 2023 at 00:58, Simon Glass <sjg@google.com> wrote:
>>
>> Hi Maxim,
>>
>> On Tue, 22 Aug 2023 at 03:39, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>> >
>> > U-Boot recently got support for an alternative network stack using LWIP.
>> > Replace dns command with the LWIP variant while keeping the output and
>> > error messages identical.
>> >
>> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>> > ---
>> >  include/net/lwip.h           | 19 +++++++++++++++
>> >  net/lwip/Makefile            |  2 ++
>> >  net/lwip/apps/dns/lwip-dns.c | 46 ++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 67 insertions(+)
>> >  create mode 100644 include/net/lwip.h
>> >  create mode 100644 net/lwip/apps/dns/lwip-dns.c
>> >
>> > diff --git a/include/net/lwip.h b/include/net/lwip.h
>> > new file mode 100644
>> > index 0000000000..cda896d062
>> > --- /dev/null
>> > +++ b/include/net/lwip.h
>> > @@ -0,0 +1,19 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> > +
>> > +int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
>> > +               char *const argv[]);
>>
>> Please make sure you comment all exported functions, including the return value.
>>
>> > +
>> > +/**
>> > + * ulwip_dns() - creates the DNS request to resolve a domain host name
>> > + *
>> > + * This function creates the DNS request to resolve a domain host name. Function
>> > + * can return immediately if previous request was cached or it might require
>> > + * entering the polling loop for a request to a remote server.
>> > + *
>> > + * @name:    dns name to resolve
>> > + * @varname: (optional) U-Boot variable name to store the result
>> > + * Returns: ERR_OK(0) for fetching entry from the cache
>> > + *         ERR_INPROGRESS(-5) success, can go to the polling loop
>> > + *         Other value < 0, if error
>> > + */
>
>
> here.

That seems to be a different function?

>
>>
>> > +int ulwip_dns(char *name, char *varname);

This one has no comment?

>> > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
>> > index d1161bea78..6d2c00605b 100644
>> > --- a/net/lwip/Makefile
>> > +++ b/net/lwip/Makefile
>> > @@ -64,3 +64,5 @@ obj-$(CONFIG_NET) += $(LWIPDIR)/netif/ethernet.o
>> >
>> >  obj-$(CONFIG_NET) += port/if.o
>> >  obj-$(CONFIG_NET) += port/sys-arch.o
>> > +
>> > +obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
>> > diff --git a/net/lwip/apps/dns/lwip-dns.c b/net/lwip/apps/dns/lwip-dns.c
>> > new file mode 100644
>> > index 0000000000..6e205c1153
>> > --- /dev/null
>> > +++ b/net/lwip/apps/dns/lwip-dns.c
>> > @@ -0,0 +1,46 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +
>> > +/*
>> > + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
>> > + */
>> > +
>> > +#include <common.h>
>> > +#include <command.h>
>> > +#include <console.h>
>> > +
>> > +#include <lwip/dns.h>
>> > +#include <lwip/ip_addr.h>
>> > +
>> > +#include <net/ulwip.h>
>> > +
>> > +static void dns_found_cb(const char *name, const ip_addr_t *ipaddr, void *callback_arg)
>> > +{
>> > +       char *varname = (char *)callback_arg;
>> > +
>> > +       if (varname)
>> > +               env_set(varname, ip4addr_ntoa(ipaddr));

That can fail

>> > +
>> > +       log_info("resolved %s to %s\n",  name, ip4addr_ntoa(ipaddr));
>> > +       ulwip_exit(0);
>> > +}
>> > +
>> > +int ulwip_dns(char *name, char *varname)
>> > +{
>> > +       int err;
>> > +       ip_addr_t ipaddr; /* not used */
>> > +       ip_addr_t dns1;
>> > +       ip_addr_t dns2;
>> > +
>> > +       ipaddr_aton(env_get("dnsip"), &dns1);
>> > +       ipaddr_aton(env_get("dnsip2"), &dns2);
>>
>> What if the env_get() fails? Won't that return NULL?
>>
>
> all of these functions will not crash, they have null check. You can set dnsip or dnsip2 or both. If both are not set then dns cmd will not look up anything.
> We can exit earlier here, but that is a common case and nothing bad if we make code simpler and exit a little bit later.

OK but I cannot see where the error is returned?

>
>
>>
>> > +
>> > +       dns_init();
>> > +       dns_setserver(0, &dns1);
>> > +       dns_setserver(1, &dns2);
>>
>> Can either of these fail?
>>
>> Please be very attentive to error-checking.
>
>
> All  above functions are void. But they have LWIP_ASSERT() for sanity checks in some places.
>
>>
>>
>> > +
>> > +       err = dns_gethostbyname(name, &ipaddr, dns_found_cb, varname);
>> > +       if (err == ERR_OK)
>>
>> Is that 0? If so, then if (err) is better
>>
>
> dns_gethostbyname() returns ERR_OK which is defined net/lwip/lwip-external/src/include/lwip/err.h.
> Yes it's defined to 0 and maybe always will be defined to 0. But  that may change. And I would keep
> the check against the same return macro that the function does.

I cannot imagine it changing.

>
>
>>
>> > +               dns_found_cb(name, &ipaddr, varname);
>> > +
>> > +       return err;
>>
>> I am not sure what that is, but will review it when you add the header comments.
>>
> In the header file of this function is an explanation. It's above in this patch:
> + * Returns: ERR_OK(0) for fetching entry from the cache
> + *         ERR_INPROGRESS(-5) success, can go to the polling loop
> + *         Other value < 0, if error
> + */

OK, so what I am getting at is trying to understand the error
conversion. It seems that lwip uses different numbering from
U-Boot/Linux, so we need to do a conversion somewhere?

Regards,
Simon
