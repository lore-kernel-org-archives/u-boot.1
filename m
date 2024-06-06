Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE84C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 06:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ABCC87AD2;
	Thu,  6 Jun 2024 08:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Hm+Yu4kD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7F1C86F6E; Thu,  6 Jun 2024 08:29:52 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E176883CF
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 08:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-6da49fa2407so435680a12.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 23:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717655389; x=1718260189; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1YzvYjUejgtNEVmh1fEL99eRAcUHIAjqH1j2FlwqH7A=;
 b=Hm+Yu4kDOCGOoSZaGJyq6t+hkhWW05/ab0QxY+9pHB/OvTWHHkyt5X2vht/NAciDVH
 I0YuW4HlA4o7UDsE0wA1zbCzOw4JkjYKGKY+J+h2MP+TqxvhER1Vodw03etl0dJ6oSLl
 570tVCd0EOZ0C1fXz96BMPBECtvN+jeejQMk7CPqiQnTWkVa53uAaLIRsXDitm4kohI2
 ZVAdiUeoEFTy8VEYoJZ3RUXLq9tbB3kHPUyWMwmYI1UVziJgq+vl4cH7TrkJCuZHRwsp
 dSegXi6455qbNvfVk2B+F5e5tOH7W+l/z0gl+FmjBElfTFW1OaaxfJKMnkYGNFv2k7ax
 xsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717655389; x=1718260189;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YzvYjUejgtNEVmh1fEL99eRAcUHIAjqH1j2FlwqH7A=;
 b=aZIPYaRnSwluOXGG0hDXJkAHOzACdZWXsyMh6Xn/NKXcukwSf99+d3orrXCWIqcRKa
 Krm8+H0XyurP7Dw1vMtiZrqz/X/+U2X+z3J7M9dTCoJ1cPls4vHGJaXVb0ilYfE6P/X4
 /pS2dSwrzY1QGRP6osd4RlBCpgQtXKKJnTrlwuqO9zrb6vEfOEoKI3CKYaG5i/oMLfMj
 AXXVlJKzUCiZ5q4HK3D2i1X45jA5lFkwHtI81TD+f7raEfD7d84MJN+ryY69jMJCJmpY
 nlMKaw/Q857sabn1ad+X32PIdxiLnt6u1D1carvU/buAVdxnPtWFUeAoT9LCRBz09mim
 oLRw==
X-Gm-Message-State: AOJu0YwezH2MfdiXjQ4gKMG6dcQZlnky+sZckH63HVzr3xwZ0wqhZVfV
 P45f77HQw9WHdZB9Psitz9RjvjAVuqEVrK1/sUx2l1kVh2weLdi7YywJMLMai3oOurpdB8OdFMi
 rksVyboG/JY6yqkSo2ZE2M+dUBQSB9anmCabV7w==
X-Google-Smtp-Source: AGHT+IGAGEbJUD0N7RCEAIaqVzrIyjk7TMFO2lle3By6b8f++mvOMH92Ir8wd4x0F33oJQ0hWGnCTFKe1RNowxywlGg=
X-Received: by 2002:a05:6a20:7354:b0:1ad:9394:2d30 with SMTP id
 adf61e73a8af0-1b2b700dfafmr5593368637.37.1717655388777; Wed, 05 Jun 2024
 23:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <b77a239e1fb9a81744d1da9a000979aac298fd29.1716566960.git.jerome.forissier@linaro.org>
In-Reply-To: <b77a239e1fb9a81744d1da9a000979aac298fd29.1716566960.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Jun 2024 09:29:12 +0300
Message-ID: <CAC_iWjKrsG+fBNm3k__QtsiQSqH8OTyee6E-Oc7JFCmn8WhyPQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] net-lwip: add dns command
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

Hi Jerome,

[...]

> +
> +static ulong start;
> +static ip_addr_t host_ipaddr;
> +static bool done;
> +
> +static void do_dns_tmr(void *arg)
> +{
> +     dns_tmr();
> +}
> +
> +static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
> +{
> +     char *var = (char *)arg;

const char *


> +     char *ipstr = ip4addr_ntoa(ipaddr);
> +
> +     done = true;
> +
> +     if (!ipaddr) {
> +             printf("DNS: host not found\n");
> +             host_ipaddr.addr = 0;
> +             return;
> +     }
> +
> +     if (var)
> +             env_set(var, ipstr);
> +
> +     printf("%s\n", ipstr);
> +}
> +
> +int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +     bool has_server = false;
> +     ip_addr_t ipaddr;
> +     ip_addr_t ns;
> +     char *nsenv;
> +     char *name;
> +     char *var;
> +     int ret;
> +
> +     if (argc == 1 || argc > 3)
> +             return CMD_RET_USAGE;
> +
> +     if (argc >= 2)
> +             name = argv[1];
> +
> +     if (argc == 3)
> +             var = argv[2];
> +
> +     dns_init();
> +
> +     nsenv = env_get("dnsip");
> +     if (nsenv && ipaddr_aton(nsenv, &ns)) {
> +             dns_setserver(0, &ns);
> +             has_server = true;
> +     }
> +
> +     nsenv = env_get("dnsip2");
> +     if (nsenv && ipaddr_aton(nsenv, &ns)) {
> +             dns_setserver(1, &ns);
> +             has_server = true;
> +     }
> +
> +     if (!has_server) {
> +             log_err("No valid name server (dnsip/dnsip2)\n");
> +             return CMD_RET_FAILURE;
> +     }
> +
> +     done = false;
> +
> +     ret = dns_gethostbyname(name, &ipaddr, dns_cb, var);
> +
> +     if (ret == ERR_OK) {
> +             dns_cb(name, &ipaddr, var);
> +     } else if (ret == ERR_INPROGRESS) {
> +             start = get_timer(0);
> +             sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
> +             do {
> +                     eth_rx();
> +                     if (done)
> +                             break;
> +                     sys_check_timeouts();
> +                     if (ctrlc()) {
> +                             printf("\nAbort\n");
> +                             break;
> +                     }
> +             } while (get_timer(start) < DNS_TIMEOUT_MS);
> +             sys_untimeout(do_dns_tmr, NULL);
> +     }

Looking at the lwip code there are other ret values than just ERR_OK,
ERR_INPROGRESS. Should we have an 'else' handling the rest?

> +
> +     if (done && host_ipaddr.addr != 0)
> +             return CMD_RET_SUCCESS;
> +
> +     return CMD_RET_FAILURE;
> +}
> +
> --
> 2.40.1
>

Thanks
/Ilias
