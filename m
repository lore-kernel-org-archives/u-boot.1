Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB645C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 10:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF78C8357F;
	Fri, 18 Jul 2025 12:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SLf7ebo7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59EC68362A; Fri, 18 Jul 2025 12:29:58 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63F58353A
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 12:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so20732705e9.1
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752834595; x=1753439395; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qcGWGMM8sn0NBmqno+64Rkir46lou529IQdrIgrRMHw=;
 b=SLf7ebo7aovDq4XDN5k5dBZ2Xnr+5p1w7bzPmgl/zXhGKd6dh8V6DJ1mnClIVOAbmA
 Ro2/PSwY25e1Jb2oaNR28tCmYRkrwPblDS42JqZai9O8weD2ryUhgmaqnrXyI38eIevC
 g/mpkTCO5EVDHtlPqpn/Tva9bLgI0gYmFj5rjqreinM5qau8zHfvZ60JKjFAl0xetS3w
 zJ2nD0dWfh5m1SCSspQqs2kZ/sTwdaQKM3HOPstG554I+2vMptlswXKKr3egCkFhf/mD
 H2QSin+oieAlxalUcfD2Wg6pfD70c0LtsMXcWbdB2RQd94Yzx6tJnCfVIw2eMpTL7fuk
 TBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752834595; x=1753439395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qcGWGMM8sn0NBmqno+64Rkir46lou529IQdrIgrRMHw=;
 b=XQSwrLpp82kk2p1sNF7gEr7ZzzFjx1TYXbXLMaBLJIwIMb0KKfaGizkj8273GYV5Vu
 TcDw+rqgWi2Bc8JySrz6h0qvP9aaaq0JBwQUP/qU/DSGvCfwakGLuSBuAT1c/LReAauO
 6fWBfv9hN9SioGuB1REYBme+dpxefbg6HEMwg1WxyKL/w23jERwTs2XPIzw8vGM/rJMi
 tOOUXWcY/owry/ay27tlqood0dZ/Xc6F7RAoOLjsnTf4L01FEavQZQRM9APyNy9UmlyC
 O7m9fjVEoH1AP0dAko9618HS8A0S1H1an3bc001bTTf2WxAk+C5lXwqeJ1jnI055zoVu
 UetA==
X-Gm-Message-State: AOJu0YyJ+Xs30SF2VnWTH6DILtDwJAVFl2jr7PxgGwCfNPNVSfO7084Z
 8ZbcGS4ZAncMppTx6KV37fz3AlUQRXiYm6InBRyEhfOM1tYabGPT0wrJ19Fz9d8WtY8=
X-Gm-Gg: ASbGncs2gCtfE88AXqHcm29AYtMQe+UJ0pLbi/Nr1P4cbOj34Mfd6zXc2qpkz7TArEG
 SermGZRkOYkUDbAjC8186XuBgbq2srRp/vyI1yo19rFGHSgsdmmuITrSd3U6iKqpZ98B1A8b8jJ
 wkhVi2UQMVNhD0kge15QLkuizehjXapuK1Jc4QUrZP9jvM98FHgm7I4wA7tAFgYpyQ28px+zmYb
 3Zmq5D8i8QwSIlU/KCSHpvKFmTBAffvBVyLLgTp334ATW6KxM9WcxxpIx/B9qFJTKUWK8MWxR8E
 9yOmRRQbctBgWGAML/Q/SRfHc8yIECtITZdHBeENA8uIWuRq6eDP707J0JM+TO1+lvM004VvJiz
 t2bWqSw1MFQjDoyKWfPUDW+en7msnH2O517LJDWkeWE7Yj6wQ7NUNPC9+HXuyBwZ2kYVus2+LcH
 VGGtVjCtrmN5T75YRYHU5rRz81ZFr50y0gEIAUan1Xr/Sxf/9rsP5Ej1W1Wo4=
X-Google-Smtp-Source: AGHT+IEgHiU0iRVD8oq6KxmaZ6CVPiJvSut2G7qZv3BblC+ql/0KgjvE/narGw1ZLReeJpfjmGr0Jg==
X-Received: by 2002:a05:600c:c4a6:b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-45632a45295mr76723085e9.4.1752834595115; 
 Fri, 18 Jul 2025 03:29:55 -0700 (PDT)
Received: from ?IPV6:2a02:8429:3fb:8e01:16dc:b0a2:e54e:22?
 (2a02-8429-03fb-8e01-16dc-b0a2-e54e-0022.rev.sfr.net.
 [2a02:8429:3fb:8e01:16dc:b0a2:e54e:22])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca24224sm1456349f8f.8.2025.07.18.03.29.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 03:29:54 -0700 (PDT)
Message-ID: <d0c203c4-3981-40d2-986b-93daf8737379@linaro.org>
Date: Fri, 18 Jul 2025 12:29:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: dns depend on enabled protocol config instead
 of command
To: E Shattow <e@freeshell.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
References: <20250712050121.88951-1-e@freeshell.de>
 <60f316be-a61e-4a8e-8f5a-964fd3e1b912@freeshell.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <60f316be-a61e-4a8e-8f5a-964fd3e1b912@freeshell.de>
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

Hi E,

On 7/14/25 03:52, E Shattow wrote:
> 
> 
> On 7/11/25 22:01, E Shattow wrote:
>> Allow dns when enabled CONFIG_PROT_DNS_LWIP=y CONFIG_CMD_DNS=n
>>
>> Fixes: a383869d6b58 ("net: lwip: move dns init to common function")
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>  net/lwip/net-lwip.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
>> index 3918d57d7e5..5d247c3721b 100644
>> --- a/net/lwip/net-lwip.c
>> +++ b/net/lwip/net-lwip.c
>> @@ -147,7 +147,7 @@ static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
>>   */
>>  int net_lwip_dns_init(void)
>>  {
>> -#if CONFIG_IS_ENABLED(CMD_DNS)
>> +#if CONFIG_IS_ENABLED(PROT_DNS_LWIP)
>>  	bool has_server = false;
>>  	ip_addr_t ns;
>>  	char *nsenv;
>>
>> base-commit: 6bb0679377abb01a82db1ce69b5bf1d40aa02ace

I think the proper way is to introduce a new "DNS" Kconfig symbol to
differentiate between DNS support and the DNS command itself. PROT_DNS_LWIP
should remain an internal symbol not exposed to the user and selected
automatically when DNS is enabled. DNS would apply to both NET and NET_LWIP.

We already have a similar mechanism in place for WGET and CMD_WGET.

> 
> Postscript: There was recently a U-Boot release and the above patch only
> applies to origin/master (is apparently not needed or applicable to
> origin/next). However on origin/next there are similar troubles where
> DNS is disabled unless the dns command is enabled in several network
> commands, which is something I can test for but am not the expert to
> make a patch or suggestion for.

IIUC origin/next is not the proper reference at this point in the release
cycle, so I would say it doesn't matter.

I will send a patch shortly to introduce CONFIG_DNS. I am currently running
CI.

Regards,
-- 
Jerome

> 
> -E
