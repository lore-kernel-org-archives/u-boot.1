Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F2BC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 15:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2092C881A1;
	Thu,  6 Jun 2024 17:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ch0EkglW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3521D88395; Thu,  6 Jun 2024 17:46:58 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5F2787F5C
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 17:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6818e31e5baso930057a12.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717688814; x=1718293614; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UVHOP2weoRHC6RGJuGyAuogWgphQIAwz08rmqXrzIyA=;
 b=Ch0EkglWVarCdou/ULRe/WVChQJvSxCSyEgW8xyaOiAbu+DzfvR2P4TPjlF2YfGQXo
 OjPjKgpwPMVrKkOJKqi7XkLLEA9jhlMZ+hmjPNwvF9tWm40RbuzjL/GnqAi3DZBtEnZL
 rCtHPmMcqC8hnXEJZbFe6qxYEczJcN8eBEvdKpAqBgDSKHzmbsHqzTsRI+rC5WAftt/v
 qfBXwhacoBeW4aoZFL/RGylsFAcKTwzdWsO5FATO7SfNJT1bYUmp/u5dzqvuK+RkpoHG
 j8d93cW5r27hnK3SvmWupLTfMgLOAW7l2kwi/QMORmS4bNdKjdn4g1SnRRyaBggBjqNa
 s++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717688814; x=1718293614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UVHOP2weoRHC6RGJuGyAuogWgphQIAwz08rmqXrzIyA=;
 b=YwL5MVaKJO9TdkQrkYU+KXu7Cs7Tn6Y3P6/tHDBNltc/Nttoq1VKL0ftm7x9yh5ycx
 KG6oveAwARfungg7k5C47x33/TsOVEo5VLs6Mn6DdDPie//Tk67vy/Yjefq3yUIUDp+H
 gwQ9WemBOU42A3U6AITgmKp1bO/qPVxmVbKrCMB8hex9V1Aydqno6EVLqeULgPjc/2Bx
 DI84DFSIYWG3CFl4rk5uEELlrr+Vhcotc2B9ezByU6ZNdzgzean3YX8GrKPx15RPofvy
 22F46S3Mack/5K4SflPMxL8EbxUCdONaxs0HIoa1Z8rNvBwYYexxbul/+gJT4EMR90lz
 Zzow==
X-Gm-Message-State: AOJu0YwHwECV6hYOUsaET0Jc9w4VeW4KBIr5c7AK/BhSVj1KQB9vd580
 GtdmUNjOATf834EDkci7QM5Viu51yuqVvdQ/ogZ9iUurZMJ9KA07S1S9tKATq2hJNZCf2ql9vHK
 7RVpQC/YEpm+f3V8vmYS8RS0bmlzpA6LD2KBmpw==
X-Google-Smtp-Source: AGHT+IGBspsI4WNH4/8TmjWs6FcV455KUgXsHq8O7uKiLgGEy+oG8tzfJyhLSs5yleKP2JN+QKp25LoJBgmwiI/9Es0=
X-Received: by 2002:a17:90a:ac0d:b0:2c1:c648:1c50 with SMTP id
 98e67ed59e1d1-2c27db16442mr5441479a91.17.1717688814299; Thu, 06 Jun 2024
 08:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1717680809.git.jerome.forissier@linaro.org>
 <a81309b7d6f3a5bbccc7a5ad45b11f071a3f50b1.1717680809.git.jerome.forissier@linaro.org>
In-Reply-To: <a81309b7d6f3a5bbccc7a5ad45b11f071a3f50b1.1717680809.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Jun 2024 18:46:18 +0300
Message-ID: <CAC_iWjJCGv+CCLQ5R8jH8248Pe-mAEihdd_YbUr_Eq2J4iTjMg@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] net-lwip: add dns command
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
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

> @@ -7,6 +7,7 @@ obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth_common.o
>  obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth-uclass.o
>  obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
>  obj-$(CONFIG_CMD_DHCP) += dhcp.o
> +obj-$(CONFIG_CMD_DNS) += dns.o
>  obj-$(CONFIG_CMD_PING) += ping.o
>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
>
> diff --git a/net-lwip/dns.c b/net-lwip/dns.c
> new file mode 100644
> index 00000000000..24a5149343a
> --- /dev/null
> +++ b/net-lwip/dns.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2024 Linaro Ltd. */
> +
> +#include <command.h>
> +#include <console.h>
> +#include <lwip/dns.h>
> +#include <lwip/timeouts.h>
> +#include <net-lwip.h>
> +#include <time.h>
> +
> +#define DNS_RESEND_MS 1000
> +#define DNS_TIMEOUT_MS 10000
> +
> +static ulong start;
> +static ip_addr_t host_ipaddr;
> +static bool done;
> +
> +static void do_dns_tmr(void *arg)
> +{
> +       dns_tmr();
> +}
> +
> +static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
> +{
> +       const char *var = arg;
> +       char *ipstr = ip4addr_ntoa(ipaddr);
> +
> +       done = true;
> +
> +       if (!ipaddr) {
> +               printf("DNS: host not found\n");
> +               host_ipaddr.addr = 0;
> +               return;
> +       }
> +
> +       if (var)
> +               env_set(var, ipstr);

Do we need this? Won't this set <dns_name> == ipaddr?
If we do not need it repurpose the void *arg and get rid of the global 'done'

> +
> +       printf("%s\n", ipstr);
> +}
> +
> +int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +       bool has_server = false;
> +       ip_addr_t ipaddr;
> +       ip_addr_t ns;
> +       char *nsenv;
> +       char *name;
> +       char *var;
> +       int ret;

[...]

Thanks
/Ilias
