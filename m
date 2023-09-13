Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8D6EDEC51
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 13:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2273D86CC0;
	Wed, 13 Sep 2023 15:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KiqesnzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2073186583; Wed, 13 Sep 2023 15:47:09 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431C786CC0
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 15:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9ad8bba8125so241161266b.3
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 06:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694612826; x=1695217626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9kuXW29lW5fn9YIUCXbwR2Kc2MN3zsAVXuxw6slqgFg=;
 b=KiqesnzLUeSXLxX0ysFoEDYIBFH7fYES/ZLVpaEA58BctHzi9p/vHuBZXS1Vkd8VZb
 j+v7h2msPNTymszXqvetWUKvq+dKigsZb5z2Mq0UHKEhoo/deZuvdEJ4O3OEVeMasUEM
 AxEViwQ5wKxpOKPaYJO7cOy65Z9n1st3ujRQGBgzh6XgzhhiqKeIWaTa6QD+zJbhb5EA
 tg0cbX6WBNvLjvU1pJ0A0ChaaqEprOVo9FuWz5SlM9+7Y4JLq0RVuFMSE1tpqCh6QluF
 9rGs7BtdwPLZ4QZFDpy7+VoEuUPqlwcwF7MEU6eZliM/CCT3sHTVafoHu4qRHIexLHFd
 whNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694612826; x=1695217626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9kuXW29lW5fn9YIUCXbwR2Kc2MN3zsAVXuxw6slqgFg=;
 b=AzSKc+N+Z4Ysurlko0Rdjtp8KZ7VvRYWWZzy5ZZU8q6opKzCwHJmTpbGAGFvkMqCa1
 KRYFfynKzFVRkCU034YPHbOZopS/TfVSnCfa7d3yUJP/qs0pmzJU2prmDicUgR3Nx4gW
 IYCtRFpio4yqet/IhIwAI6y4ye7StEw+LEPFjvOlNMAvz+HRt5RoiRALAHAVirwhhPGw
 wtMZSUI08y0OHdYM7tx3e6EJxmryCknmvp8W8s2Ya/TOUS23OiYBFMAh++ain61MgRaQ
 DfJAXvsqjs+eSLJ+a8L4OzHixETevphZirDNP/mlhm5bFVKzpoTiGkwNRhNXZglJcHEE
 h5NA==
X-Gm-Message-State: AOJu0YxEMpAnzCLHypSFYoeolzs8nsIvKSrFrSuLphRrsq7Hg6QpXEs9
 RxV39de34VQ/eL+QRan0TD23U52k0nREJ9eIUSdewg==
X-Google-Smtp-Source: AGHT+IFWnaSc5QFrTe3+/Myg2TMten8HFZrL0pgYCPlVdhtMdyUsPZIBvRuvhurAW8pN8HCogd6GdEwOotzbdU+G4hM=
X-Received: by 2002:a17:906:221c:b0:9aa:e07:d421 with SMTP id
 s28-20020a170906221c00b009aa0e07d421mr1972610ejs.43.1694612825828; Wed, 13
 Sep 2023 06:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135320.7066-4-maxim.uvarov@linaro.org> <ZQFPEF85eOXtw8Qn@hera>
 <d3513631-2831-b761-9b18-63bb7d077b15@gmx.de>
In-Reply-To: <d3513631-2831-b761-9b18-63bb7d077b15@gmx.de>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 13 Sep 2023 19:46:53 +0600
Message-ID: <CAD8XO3ZEUzT1Wvs8WShrfxLE1sfKrpwg1C5SziFVW-z28POugw@mail.gmail.com>
Subject: Re: [PATCHv8 03/15] net/lwip: implement dns cmd
To: Simon Goldschmidt <goldsimon@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com
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

On Wed, 13 Sept 2023 at 14:32, Simon Goldschmidt <goldsimon@gmx.de> wrote:

>
>
> On 13.09.2023 07:56, Ilias Apalodimas wrote:
> > On Fri, Sep 08, 2023 at 07:53:08PM +0600, Maxim Uvarov wrote:
> >> U-Boot recently got support for an alternative network stack using LWIP.
> >> Replace dns command with the LWIP variant while keeping the output and
> >> error messages identical.
> >>
> >> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> >> ---
> >>   include/net/lwip.h           | 19 +++++++++++
> >>   net/lwip/Makefile            |  2 ++
> >>   net/lwip/apps/dns/lwip-dns.c | 63 ++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 84 insertions(+)
> >>   create mode 100644 include/net/lwip.h
> >>   create mode 100644 net/lwip/apps/dns/lwip-dns.c
> >>
> >> diff --git a/include/net/lwip.h b/include/net/lwip.h
> >> new file mode 100644
> >> index 0000000000..ab3db1a214
> >> --- /dev/null
> >> +++ b/include/net/lwip.h
> >> @@ -0,0 +1,19 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +
> >> +int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
> >> +            char *const argv[]);
> >> +
> >> +/**
> >> + * ulwip_dns() - creates the DNS request to resolve a domain host name
> >> + *
> >> + * This function creates the DNS request to resolve a domain host
> name. Function
> >> + * can return immediately if previous request was cached or it might
> require
> >> + * entering the polling loop for a request to a remote server.
> >> + *
> >> + * @name:    dns name to resolve
> >> + * @varname: (optional) U-Boot variable name to store the result
> >> + * Returns: ERR_OK(0) for fetching entry from the cache
> >> + *          -EINPROGRESS success, can go to the polling loop
> >> + *          Other value < 0, if error
> >> + */
> >> +int ulwip_dns(char *name, char *varname);
> >> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> >> index 3fd5d34564..5d8d5527c6 100644
> >> --- a/net/lwip/Makefile
> >> +++ b/net/lwip/Makefile
> >> @@ -62,3 +62,5 @@ obj-$(CONFIG_NET) +=
> lwip-external/src/netif/ethernet.o
> >>
> >>   obj-$(CONFIG_NET) += port/if.o
> >>   obj-$(CONFIG_NET) += port/sys-arch.o
> >> +
> >> +obj-y += apps/dns/lwip-dns.o
> >> diff --git a/net/lwip/apps/dns/lwip-dns.c b/net/lwip/apps/dns/lwip-dns.c
> >> new file mode 100644
> >> index 0000000000..b340302f2c
> >> --- /dev/null
> >> +++ b/net/lwip/apps/dns/lwip-dns.c
> >> @@ -0,0 +1,63 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +/*
> >> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> >> + */
> >> +
> >> +#include <common.h>
> >> +#include <command.h>
> >> +#include <console.h>
> >> +
> >> +#include <lwip/dns.h>
> >> +#include <lwip/ip_addr.h>
> >> +
> >> +#include <net/ulwip.h>
> >> +
> >> +static void dns_found_cb(const char *name, const ip_addr_t *ipaddr,
> void *callback_arg)
> >> +{
> >> +    char *varname = (char *)callback_arg;
> >> +    char *ipstr = ip4addr_ntoa(ipaddr);
> >> +
> >> +    if (varname)
> >> +            env_set(varname, ipstr);
> >> +    log_info("resolved %s to %s\n",  name, ipstr);
> >> +    ulwip_exit(0);
> >> +}
> >> +
> >> +int ulwip_dns(char *name, char *varname)
> >> +{
> >> +    int err;
> >> +    ip_addr_t ipaddr; /* not used */
> >> +    ip_addr_t dns1;
> >> +    ip_addr_t dns2;
> >> +    char *dnsenv = env_get("dnsip");
> >> +    char *dns2env = env_get("dnsip2");
> >> +
> >> +    if (!dnsenv && !dns2env) {
> >> +            log_err("nameserver is not set with dnsip and dnsip2
> vars\n");
> >> +            return -ENOENT;
> >> +    }
> >> +
> >> +    if (!dnsenv)
> >> +            log_warning("dnsip var is not set\n");
> >> +    if (!dns2env)
> >> +            log_warning("dnsip2 var is not set\n");
> >> +
> >> +    dns_init();
> >> +
> >> +    if (ipaddr_aton(dnsenv, &dns1))
> >> +            dns_setserver(0, &dns1);
> >> +
> >> +    if (ipaddr_aton(dns2env, &dns2))
> >> +            dns_setserver(1, &dns2);
> >
> > env_get will return NULL if any of these is not set.  Looking at
> > ipaddr_aton() of lwip that might lead to a NULL deref in ip_2_ip6()
>
> Looking at the NULL checks in ipaddr_aton(), you found a bug in lwIP.
> I'd vote to leave the above code as is and rely on the bug being fixed
> in lwIP before U-Boot enables IPv6 (this is only a bug in dual-stack
> mode where IPv4 and IPv6 is enabled).
>
> Regards,
> Simon
>
>
Yes, I looked for an ipv4 case with null check.  But I think here we can go
with:
if (dns2env && ipaddr_aton(dns2env, &dns2))



> >
> >> +
> >> +    err = dns_gethostbyname(name, &ipaddr, dns_found_cb, varname);
> >> +    if (err == ERR_OK)
> >> +            dns_found_cb(name, &ipaddr, varname);
> >> +
> >> +    /* convert lwIP ERR_INPROGRESS to U-Boot -EINPROGRESS */
> >> +    if (err == ERR_INPROGRESS)
> >> +            err = -EINPROGRESS;
> >> +
> >> +    return err;
> >> +}
> >> --
> >> 2.30.2
> >>
>
