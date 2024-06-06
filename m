Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19F0C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBFD288266;
	Thu,  6 Jun 2024 14:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RjpxfDqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C38B88395; Thu,  6 Jun 2024 14:19:10 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 086BC8823C
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 14:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35dc36b107fso869644f8f.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717676347; x=1718281147; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+nMCdid9xwGoNdxKNLUk7aUl0EMb4TUly8MlGeLQQ2Q=;
 b=RjpxfDqZA96bVH83opwNBFNXaMpURFwtlr7IMndXCdR4nns4IiLrHY7H6ErMhDQvIz
 jidaCgpO0iazj1CHRRMvVzB3qFyyNjAZm/wmcoa7PKmF5VRHaMzZg89GkqZ4HkRPGDa2
 yiu7x/yrNYLkRIFQFVYSm1wsNA7TdHT4pXckLO5yaIR92rPb/WxIgZvKmZ2yF40C/pg0
 fuRfpvYd50gv58iz2QpuzT8sjZGXCZknC/UUI08aKxAmEna1ulRmK+enYsd9y/BEWvd3
 eVMeOQ4cbQYHiatdMHhSkG46XIgzJ9iXsvkVo5e6+sWi/Dm/+P63kslyMUtm0KZ45KCT
 Yuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717676347; x=1718281147;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+nMCdid9xwGoNdxKNLUk7aUl0EMb4TUly8MlGeLQQ2Q=;
 b=dVwciA725eH76UiArBRAQjEiRGdYjdDAegFvfQ+xZDsCuBHe2JcCLoM02q7M7zSNHW
 eE4A+/HImBkiW6gKMJydm4nwt+Nv6oxWC7J15BkMRm+YwSFBmzsBOGyVs9aqLjdGKPEj
 +oraCAuCIVJq+ZQ2FBLpsjrGTuZqijKiM/K0zhzoaB8yU2/TVTdr9hMBmDcK8VFoi9qs
 tXDLyPKvo0Vej09DWGgexDL3m58fberb3OS48l154DCUwNdxvGcuXYbALD/fYaYfNmiZ
 AQ1s8PFJv0beVFw0SkqBGkSrKQXsmR64vpTDhlZbSEfZsn25cci7Gc6pAq5OwnoBS0Yg
 DDig==
X-Gm-Message-State: AOJu0YzLo26GHTO2oi82FmIu4AprOsPnAZPqqzuBeYlNSu5WRkEUCTyl
 RJDqLVo3cx9WNew63Zx49SwMh5SYscA1+gsH0ZOXsXx1SnSqaKC3BA3ErDx0XS8=
X-Google-Smtp-Source: AGHT+IHZaP7Sdq+KWt4teeQs7xzFVS1tEOfSpRfl2as+TJJVMCVo3n7zj8FOBUgezS/YLW6SBwXEWw==
X-Received: by 2002:adf:b34a:0:b0:355:2ad:cca4 with SMTP id
 ffacd0b85a97d-35e8ef7e048mr3837442f8f.55.1717676347408; 
 Thu, 06 Jun 2024 05:19:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d29a5fsm1421439f8f.1.2024.06.06.05.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 05:19:07 -0700 (PDT)
Message-ID: <be5f2ad5-cc98-4e36-bd31-2a42d0790ff4@linaro.org>
Date: Thu, 6 Jun 2024 14:19:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] net-lwip: add dns command
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <b77a239e1fb9a81744d1da9a000979aac298fd29.1716566960.git.jerome.forissier@linaro.org>
 <CAC_iWjKrsG+fBNm3k__QtsiQSqH8OTyee6E-Oc7JFCmn8WhyPQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjKrsG+fBNm3k__QtsiQSqH8OTyee6E-Oc7JFCmn8WhyPQ@mail.gmail.com>
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



On 6/6/24 08:29, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> [...]
> 
>> +
>> +static ulong start;
>> +static ip_addr_t host_ipaddr;
>> +static bool done;
>> +
>> +static void do_dns_tmr(void *arg)
>> +{
>> +     dns_tmr();
>> +}
>> +
>> +static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
>> +{
>> +     char *var = (char *)arg;
> 
> const char *

Fixed in v3.

> 
>> +     char *ipstr = ip4addr_ntoa(ipaddr);
>> +
>> +     done = true;
>> +
>> +     if (!ipaddr) {
>> +             printf("DNS: host not found\n");
>> +             host_ipaddr.addr = 0;
>> +             return;
>> +     }
>> +
>> +     if (var)
>> +             env_set(var, ipstr);
>> +
>> +     printf("%s\n", ipstr);
>> +}
>> +
>> +int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>> +{
>> +     bool has_server = false;
>> +     ip_addr_t ipaddr;
>> +     ip_addr_t ns;
>> +     char *nsenv;
>> +     char *name;
>> +     char *var;
>> +     int ret;
>> +
>> +     if (argc == 1 || argc > 3)
>> +             return CMD_RET_USAGE;
>> +
>> +     if (argc >= 2)
>> +             name = argv[1];
>> +
>> +     if (argc == 3)
>> +             var = argv[2];
>> +
>> +     dns_init();
>> +
>> +     nsenv = env_get("dnsip");
>> +     if (nsenv && ipaddr_aton(nsenv, &ns)) {
>> +             dns_setserver(0, &ns);
>> +             has_server = true;
>> +     }
>> +
>> +     nsenv = env_get("dnsip2");
>> +     if (nsenv && ipaddr_aton(nsenv, &ns)) {
>> +             dns_setserver(1, &ns);
>> +             has_server = true;
>> +     }
>> +
>> +     if (!has_server) {
>> +             log_err("No valid name server (dnsip/dnsip2)\n");
>> +             return CMD_RET_FAILURE;
>> +     }
>> +
>> +     done = false;
>> +
>> +     ret = dns_gethostbyname(name, &ipaddr, dns_cb, var);
>> +
>> +     if (ret == ERR_OK) {
>> +             dns_cb(name, &ipaddr, var);
>> +     } else if (ret == ERR_INPROGRESS) {
>> +             start = get_timer(0);
>> +             sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
>> +             do {
>> +                     eth_rx();
>> +                     if (done)
>> +                             break;
>> +                     sys_check_timeouts();
>> +                     if (ctrlc()) {
>> +                             printf("\nAbort\n");
>> +                             break;
>> +                     }
>> +             } while (get_timer(start) < DNS_TIMEOUT_MS);
>> +             sys_untimeout(do_dns_tmr, NULL);
>> +     }
> 
> Looking at the lwip code there are other ret values than just ERR_OK,
> ERR_INPROGRESS. Should we have an 'else' handling the rest?

Not needed, since in this case we will reach the next line
'if (done && host_ipaddr.addr != 0)' which is the true success condition.

Thanks,
-- 
Jerome
