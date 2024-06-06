Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C1EC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 15:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16938881A1;
	Thu,  6 Jun 2024 17:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="quMPCXS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F44188247; Thu,  6 Jun 2024 17:59:31 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3389087AD2
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 17:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42163fed884so2905785e9.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717689568; x=1718294368; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vqjsaBYP33JOtG4VXs1gN1LngS1TOfdbEBdOZzdr4M8=;
 b=quMPCXS3m3KBLSc6ZwvH1IWXVUlzhZw6VYmHZy3m+weN3h3c0tuP76GvdSWEt/FAHB
 ePCI8l3U1TB9BN513havVFDEkSnJXlXSc78clNDt8/UFPkw3FKDopl0CJENneGvuudyp
 l8bskrbXYPp6t2oufqGMo3j699RybT6PbLzyqk/SNmUAyx4fdqmAy/w8PucoXLH2MGJw
 +9ZjQgeNJNQyK0otdUKXJtQ+AV0R3mpXaVAx5C/pWyJtvgsNpxcwvkimMejzNDRsVa0h
 zURL9kQi8tLLiCXfcHGduOnh8WsvTGYevpPWy1qvwpltlwORaaQD2s/uWESqD8Xo2QAE
 8vKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717689568; x=1718294368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vqjsaBYP33JOtG4VXs1gN1LngS1TOfdbEBdOZzdr4M8=;
 b=uSUcqrHrlKbTleMpO44qvYbGsxkqK6yp54QDszORLzYFAXIR0BlUXrdu5auJNttM38
 0T2Eoa+CcviksDGL3rIrSLPK+5N839nnS1F7XfFqaJBflu5ldCAy5i/p8mK+r4Cl5R6i
 qbJ3mnLgCN23sX6J2Z0JKVtyIezYDYXRZtB6ZG9AOI7jck53se57L0UVPRoik81ax45t
 pRQBtpso25e6ne3l0csNUHs9f0H+5NX5ub4k8Z76XxvFU8ac5/S/LCxKWTOBN5Syzy9L
 NRqndfHIDGAzcwl0vd4duTY95jdli3JgOeGJHPKcV3ZVo5YpfhoNiHP1gBdAeZ3HT1Z7
 ctRQ==
X-Gm-Message-State: AOJu0Yyb8914CByK0xR5APMvBgCtTs3cJmHUXfyiabZF/sykQhSKAWFI
 b7sm3uGQqBsM8zsx2kRyUWddY3yx2YAiEo0QprkCfZtaldMLzCHmRIbGuu52cKU=
X-Google-Smtp-Source: AGHT+IEdpVjRy0JZVFGn7KOe8sr8WWnoEoUGnAx8EHS3WwbBGaHR6TXFzyEhsfS8VQc5/Pco53Vprg==
X-Received: by 2002:a05:600c:1c01:b0:421:2abe:54e3 with SMTP id
 5b1f17b1804b1-421649ea7bamr1295865e9.2.1717689568476; 
 Thu, 06 Jun 2024 08:59:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d4a582sm1872021f8f.35.2024.06.06.08.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 08:59:28 -0700 (PDT)
Message-ID: <590d8389-defe-4297-91f3-f5dcfef5595d@linaro.org>
Date: Thu, 6 Jun 2024 17:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] net-lwip: add dns command
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
 <a81309b7d6f3a5bbccc7a5ad45b11f071a3f50b1.1717680809.git.jerome.forissier@linaro.org>
 <CAC_iWjJCGv+CCLQ5R8jH8248Pe-mAEihdd_YbUr_Eq2J4iTjMg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjJCGv+CCLQ5R8jH8248Pe-mAEihdd_YbUr_Eq2J4iTjMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/6/24 17:46, Ilias Apalodimas wrote:
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth_common.o
>>  obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth-uclass.o
>>  obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
>>  obj-$(CONFIG_CMD_DHCP) += dhcp.o
>> +obj-$(CONFIG_CMD_DNS) += dns.o
>>  obj-$(CONFIG_CMD_PING) += ping.o
>>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
>>
>> diff --git a/net-lwip/dns.c b/net-lwip/dns.c
>> new file mode 100644
>> index 00000000000..24a5149343a
>> --- /dev/null
>> +++ b/net-lwip/dns.c
>> @@ -0,0 +1,107 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/* Copyright (C) 2024 Linaro Ltd. */
>> +
>> +#include <command.h>
>> +#include <console.h>
>> +#include <lwip/dns.h>
>> +#include <lwip/timeouts.h>
>> +#include <net-lwip.h>
>> +#include <time.h>
>> +
>> +#define DNS_RESEND_MS 1000
>> +#define DNS_TIMEOUT_MS 10000
>> +
>> +static ulong start;
>> +static ip_addr_t host_ipaddr;
>> +static bool done;
>> +
>> +static void do_dns_tmr(void *arg)
>> +{
>> +       dns_tmr();
>> +}
>> +
>> +static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
>> +{
>> +       const char *var = arg;
>> +       char *ipstr = ip4addr_ntoa(ipaddr);
>> +
>> +       done = true;
>> +
>> +       if (!ipaddr) {
>> +               printf("DNS: host not found\n");
>> +               host_ipaddr.addr = 0;
>> +               return;
>> +       }
>> +
>> +       if (var)
>> +               env_set(var, ipstr);
> 
> Do we need this? Won't this set <dns_name> == ipaddr?

No, the syntax of the dns command is: 'dns hostname [env_var]' so one can
pretty much give any variable name to receive the IP address.

> If we do not need it repurpose the void *arg and get rid of the global 'done'

I could probably use a struct to get rid of the globals. Let me see what I can do.
 
>> +
>> +       printf("%s\n", ipstr);
>> +}
>> +
>> +int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>> +{
>> +       bool has_server = false;
>> +       ip_addr_t ipaddr;
>> +       ip_addr_t ns;
>> +       char *nsenv;
>> +       char *name;
>> +       char *var;
>> +       int ret;
> 
> [...]
> 
> Thanks
> /Ilias
