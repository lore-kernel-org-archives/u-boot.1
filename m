Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEDDC001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 15:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE6A8696C;
	Mon, 14 Aug 2023 17:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TDwausuO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9FA986966; Mon, 14 Aug 2023 17:15:32 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC89F8692C
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 17:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-991c786369cso598282666b.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692026130; x=1692630930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f84jrRIA6ushXxBZEQcoPwZGH1mPNWsO2GMnylr12qE=;
 b=TDwausuOawwxQkKNaOPIEq2EsQSJpls8bKWmBjXVmlODR4rD6AMrhpjSnIvRkUE90D
 0/5E0oO53HhNs0uPpulwB4F2ZwCP/FgWBOnv0uHxT4gxOqY1SWSeYNFvGeBciXmEOev7
 B0Ks+hmkOL3b0vUI5H81SK/7vYMCnMgqmGYXuuGKPIPLvNY4+6SV5ecOkalPxWGwJ+0r
 UcNgQaEzG01rN5nI7VvlCmQ/hXR4D7syirtoCS1ofEKpt4glTClSoMV0xNisYw2miMN5
 WCkjgXKRQ0456RBTFZiVcKHaUGjcgFlc5kwk0kzYmzN7q+jr+rxcDKZPjxKurKyC5R0v
 uQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692026130; x=1692630930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f84jrRIA6ushXxBZEQcoPwZGH1mPNWsO2GMnylr12qE=;
 b=eu2pHqgr4H7sSu0Aebj19Vov3RXBAQTKq6LA7oGgTBPaCOaGXnwwjayUPQllKSLuB4
 AJ2ZAG+JQ9u99BEVkypx6FakmcuMXA68nRtKNFpeqfFyDzMZmAfexBBfyVrps85uGZfY
 VSNExgIfaL1BpE03kDnh8MDDfek3e1rQ+XWqAY0cnM3KbvdJ/CbOYqgfbZuap1NVnVMs
 sZ15adGKCgAOVsfMy00jXltWSqS3PWK0z3o04Kh8qGMM36KlkHMPWH0PtHrwDxdBXbTE
 XaeunIYHqCCtWezagn6FSwuhrF/vI2OQ9Kep7SdsB/coW7adO6VleUz1t7wSuHDVDalC
 qiaw==
X-Gm-Message-State: AOJu0Yy088Cctv7BtmpdZEJk/KfRkyfCvqmhJLAfa9pD7VC9AKdJLn4v
 +uGxvpzbaJfJLGDzFqbRtOKwzqVNOcsveCjMOQJbQg==
X-Google-Smtp-Source: AGHT+IHWewjS6a4dsmv4YyvzD8avLNKJ4J8KLsOMVMIHKU4zUJc+SNTyaEdcs+CZSZbzj23pf/fN/lcMm7rJtCek2F4=
X-Received: by 2002:a17:906:3cb2:b0:98e:2b01:ab97 with SMTP id
 b18-20020a1709063cb200b0098e2b01ab97mr6826988ejh.68.1692026130217; Mon, 14
 Aug 2023 08:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-4-maxim.uvarov@linaro.org> <ZNo3+qhKIEqmdMTh@hades>
In-Reply-To: <ZNo3+qhKIEqmdMTh@hades>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Mon, 14 Aug 2023 21:15:18 +0600
Message-ID: <CAD8XO3ZK2GwOxc=wodp7M+9Qgh_Ugd7nNNTi58OXqq9X3SAa7g@mail.gmail.com>
Subject: Re: [PATCHv6 03/14] net/lwip: implement dns cmd
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

On Mon, 14 Aug 2023 at 20:19, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Mon, Aug 14, 2023 at 07:32:42PM +0600, Maxim Uvarov wrote:
> > Implement function for dns command with lwIP variant. Usage and output is
> > the same as the original command. This code called by compatibility code
> > between U-Boot and lwIP.
>
> What's compatibility code?
> I think something along the lines of
>
> 'U-Boot recently got support for an alternative network stack using LWIP.
> Replace XXXX command with the LWIP variant while keeping the output and
> error messages identical"
>

ok, that message is a good one. By 'compatibility code' I meant code to
merge lwip applications and other U-Boot code.

So in general all net/lwip/apps/{dns,ping,wget} and etc. These applications
do not have U-Boot headers and can be compiled with
any other lwIP port. I.e. for example, you can take the linux userland port
with a tap device and directly compile these apps, run and debug.
This might be named lwIP apps code.

And code which does lwIP init, calls application initialization, then goes
to net polling loop - I named here 'a compatibility code'. Might be not the
base naming, but that was an idea.



>
> > +
> > +int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
> > +             char *const argv[]);
> > +
> > +/*
> > +* This function creates the DNS request to resolve a domain host name.
> Function
>
> You need the name of the function as well.  Please have a look at how the
> rest of the code is documented.
>
> > +* can return immediately if previous request was cached or it might
> require
> > +* entering the polling loop for a request to a remote server.
> > +*
> > +* @name  dns name to resolve
>
> @name: etc
>
> > +* @varname (optional) U-Boot variable name to store the result
> > +* Return: ERR_OK(0) for fetching entry from the cache
> > +*         ERR_INPROGRESS(-5) success, can go to the polling loop
> > +*         Other value < 0, if error
> > +*/
> > +int ulwip_dns(char *name, char *varname);
> > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> > index d1161bea78..6d2c00605b 100644
> > --- a/net/lwip/Makefile
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
> > +     char *varname = (char *)callback_arg;
> > +
> > +     if (varname)
> > +             env_set(varname, ip4addr_ntoa(ipaddr));
>
> Why do we have to set the varname to the resolved address?  Is this
> something the dns command already does?
>
> Exactly, original  command is:

U_BOOT_CMD(
dns, 3, 1, do_dns,
"lookup the IP of a hostname",
"hostname [envvar]"
);



> > +
> > +     log_info("resolved %s to %s\n",  name, ip4addr_ntoa(ipaddr));
> > +     ulwip_exit(0);
> > +}
> > +
> > +int ulwip_dns(char *name, char *varname)
> > +{
> > +     int err;
> > +     ip_addr_t ipaddr; /* not used */
> > +     ip_addr_t dns1;
> > +     ip_addr_t dns2;
> > +
> > +     ipaddr_aton(env_get("dnsip"), &dns1);
> > +     ipaddr_aton(env_get("dnsip2"), &dns2);
> > +
> > +     dns_init();
> > +     dns_setserver(0, &dns1);
> > +     dns_setserver(1, &dns2);
> > +
> > +     err = dns_gethostbyname(name, &ipaddr, dns_found_cb, varname);
> > +     if (err == ERR_OK)
> > +             dns_found_cb(name, &ipaddr, varname);
> > +
> > +     return err;
> > +}
> > --
> > 2.30.2
> >
>
> Thanks
> /Ilias
>
