Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8613EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFF4586507;
	Tue, 22 Aug 2023 20:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="djOdrI92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC37864E3; Tue, 22 Aug 2023 20:58:04 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FED0864E7
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d72cf9156easo4426300276.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9/RDqT83wKM8Rdhdw3w4pny4UVEn8iTqzGKSC61bRUk=;
 b=djOdrI92ix72KQWJ/JtIZHyjxqt/kJWMoMrb3tSDqQABzu4pvt2T0HGl/f6UgdrEig
 2H3ZwPi8zzDVLRTpQEcHeb1W6qa9VKAEyFys6fuW3+OIIjMsu5aRnu0w0P1gr0a2Qr14
 m3hCiYToyWOL6e348qOpQtfSD6ABpO5O/xJZvkA1cYfxwY2U3DrsNuPMnlot1wWcdZEd
 BnTqi5iqksdfiKm8Ua+xKE8daZPswi/7Rp0DBIZ0e0GVR0bx6f+KaE7eyRGRWRSzkv3G
 iAyiGgRDSb2vxy1QGb3CzRSkjDqTmyu4UBVrBjLDfafaPz53stilGQf2WavU4K8nStn9
 H9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9/RDqT83wKM8Rdhdw3w4pny4UVEn8iTqzGKSC61bRUk=;
 b=dSQA8h7J2RXvj9Ee/cBOIaxQMVb4OUXmqE71KjVHwyAN/9rvI8pzl9xYe6qvU86l3U
 R3xHRgoR8ByCEtDdst20spaVl+9uwFZ5ScNpapqWbtrPT7sAvsx1f5mLvTEYohlR/pfl
 BwbEtfyBIYBFpNZFBYWMMmz3sQvVo14wEOtFWhEX4J0Q/8fDI0BCGPDuIochRirvHmOv
 oIXZ5q4AoFyoveu170oGgiw6xOCqCbjxSCoAyHxU6H6KzhsWwDqMLAE7zByxDtuh/Moc
 r/gWOS+1tQX2Nr2/KmNHAcNEehPm4BBKcXcdblRBDaVNq4k8YurMrytClS/XLqXMurZZ
 2FMw==
X-Gm-Message-State: AOJu0Yxe/ElULhW5RVDISpqExzeYllqh05psEWwsv1OpXXs+VG7IXjTA
 fG0Gd/mF/zrKcJpkBmBf0j6Cqpe2bf7xr2bS+Upb6g==
X-Google-Smtp-Source: AGHT+IEVLocGcfM+YFjiIe+yoNNOl3VUmTJfMN/TAht3Z60inXpy79GodypEsBypMyr6nxfklSErG2W+bt4Zy+1ukI4=
X-Received: by 2002:a25:d408:0:b0:d36:65ee:b1da with SMTP id
 m8-20020a25d408000000b00d3665eeb1damr10797348ybf.43.1692730678893; Tue, 22
 Aug 2023 11:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
 <20230822093614.4717-4-maxim.uvarov@linaro.org>
In-Reply-To: <20230822093614.4717-4-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@google.com>
Date: Tue, 22 Aug 2023 12:56:44 -0600
Message-ID: <CAPnjgZ0cjB__HHbMOvNvK--JyzDsRfzSAhsGmkhk9MkFoceVrA@mail.gmail.com>
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

On Tue, 22 Aug 2023 at 03:39, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> U-Boot recently got support for an alternative network stack using LWIP.
> Replace dns command with the LWIP variant while keeping the output and
> error messages identical.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  include/net/lwip.h           | 19 +++++++++++++++
>  net/lwip/Makefile            |  2 ++
>  net/lwip/apps/dns/lwip-dns.c | 46 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
>  create mode 100644 include/net/lwip.h
>  create mode 100644 net/lwip/apps/dns/lwip-dns.c
>
> diff --git a/include/net/lwip.h b/include/net/lwip.h
> new file mode 100644
> index 0000000000..cda896d062
> --- /dev/null
> +++ b/include/net/lwip.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
> +               char *const argv[]);

Please make sure you comment all exported functions, including the return value.

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
> + *         ERR_INPROGRESS(-5) success, can go to the polling loop
> + *         Other value < 0, if error
> + */
> +int ulwip_dns(char *name, char *varname);
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index d1161bea78..6d2c00605b 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -64,3 +64,5 @@ obj-$(CONFIG_NET) += $(LWIPDIR)/netif/ethernet.o
>
>  obj-$(CONFIG_NET) += port/if.o
>  obj-$(CONFIG_NET) += port/sys-arch.o
> +
> +obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
> diff --git a/net/lwip/apps/dns/lwip-dns.c b/net/lwip/apps/dns/lwip-dns.c
> new file mode 100644
> index 0000000000..6e205c1153
> --- /dev/null
> +++ b/net/lwip/apps/dns/lwip-dns.c
> @@ -0,0 +1,46 @@
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
> +       char *varname = (char *)callback_arg;
> +
> +       if (varname)
> +               env_set(varname, ip4addr_ntoa(ipaddr));
> +
> +       log_info("resolved %s to %s\n",  name, ip4addr_ntoa(ipaddr));
> +       ulwip_exit(0);
> +}
> +
> +int ulwip_dns(char *name, char *varname)
> +{
> +       int err;
> +       ip_addr_t ipaddr; /* not used */
> +       ip_addr_t dns1;
> +       ip_addr_t dns2;
> +
> +       ipaddr_aton(env_get("dnsip"), &dns1);
> +       ipaddr_aton(env_get("dnsip2"), &dns2);

What if the env_get() fails? Won't that return NULL?

> +
> +       dns_init();
> +       dns_setserver(0, &dns1);
> +       dns_setserver(1, &dns2);

Can either of these fail?

Please be very attentive to error-checking.

> +
> +       err = dns_gethostbyname(name, &ipaddr, dns_found_cb, varname);
> +       if (err == ERR_OK)

Is that 0? If so, then if (err) is better

> +               dns_found_cb(name, &ipaddr, varname);
> +
> +       return err;

I am not sure what that is, but will review it when you add the header comments.

> +}
> --
> 2.30.2
>

Regards,
Simon
