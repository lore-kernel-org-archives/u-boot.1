Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0174AD6A220
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 17:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C8D8895C9;
	Thu, 14 Nov 2024 18:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XLDbvAbr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1DB189607; Thu, 14 Nov 2024 18:20:03 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4E828954C
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 18:20:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a99eb8b607aso115535966b.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731604801; x=1732209601; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ucEkMN+AtLey75upljsxwLcShzlBwkMiICYd+xWO8as=;
 b=XLDbvAbrkVuPOO55cXx2LY87Kn6zuUhU0C2azc2xXUqIj8Rd+pKz+4rV1gBDOcQgc6
 oTxD1vE8Rwh1cBrNk+oZxMh/6Odemb/vRnJ1kEeXhootPpjWCQ9l67xCmusHySjrdwUh
 ShT0J05Kslqfm7veRA8WcdijJ/7V6Zy9Pv5QTNlWc7oKLzOoOdK/vxX7nnlC3u+91zox
 MHVAymMpPdd1z7AjLjpMI3hocK9Gj3TaaaeHKTDIyv42iJU51/CW44w+/mfs4O6KsjBC
 UR5pUaNbqDZwG7nP3CEXIMRPmXItowZFdzZipB1CTAVkWREkHxAo4WoFhzLMr9S4IjXC
 icJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731604801; x=1732209601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ucEkMN+AtLey75upljsxwLcShzlBwkMiICYd+xWO8as=;
 b=vqqqCPaFR6GkN/sEx2JDrbB7NfsSOv/hg9TU7izSyg8xNGFZBVJLgjlE5AcrxkwFdy
 sItoOjQrsH77AOeNytN1dESaR0rf8NjTKOIiwLgDdq42kwdl3t3zgOr6da9i/tW3N1mM
 q1YCjL89e0eIof7pmUuGw22k3lMr9xtFpaxp+aEY6eglN/Q5ijxMpSIETLH8ZaB7Qb/S
 Mw0nPVpJGbzVw+QYZAUII/IcnCw8nh6UAxkjw6J36KZ3w3pATTy/x5zp0gTtALY07yNz
 y5SB1Qk2RyLs+edZl2dZaa7W1MbTcElLXganOEDR+a89g7va5M5B2SbPsH40PX6TqKgj
 dxng==
X-Gm-Message-State: AOJu0YyOrDegJmQvZM0Djhwp8P1SfZHzhC9L8q9SR1PAzHmyaYMKEqy/
 4XGq6SYKLyqIh8pqDqOxn4wgAUso5uzBJt4EAtZJT/BEW/QAGoIXeqyVpDliWW6QPbRFyQNKdwl
 B6L0=
X-Google-Smtp-Source: AGHT+IFWBIciHteQ3ifyx98oVFtWeA1Hh+WZ5jXgJjGa3S1aSh1o7US/pKrclS+GO3hkqZdcqniWkg==
X-Received: by 2002:a17:907:60c8:b0:a9a:46:83ee with SMTP id
 a640c23a62f3a-a9eefff1531mr2315117866b.48.1731604801223; 
 Thu, 14 Nov 2024 09:20:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6dc2:e776:8a06:3912?
 ([2a01:e0a:3cb:7bb0:6dc2:e776:8a06:3912])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e048f12sm83872366b.173.2024.11.14.09.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 09:20:01 -0800 (PST)
Message-ID: <18ff628e-8322-4554-9b15-f756fb1025c5@linaro.org>
Date: Thu, 14 Nov 2024 18:19:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: dhcp: support arguments for TFTP file download
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, E Shattow <lucent@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
References: <20241114171002.2073594-1-jerome.forissier@linaro.org>
 <CAM=mAOmfQWhQ+eLwQ4qXbsiB26Zc9FimJhsp93Xi9MTerMw=GA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAM=mAOmfQWhQ+eLwQ4qXbsiB26Zc9FimJhsp93Xi9MTerMw=GA@mail.gmail.com>
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



On 11/14/24 18:15, Heinrich Schuchardt wrote:
> Jerome Forissier <jerome.forissier@linaro.org> schrieb am Do., 14. Nov.
> 2024, 18:10:
> 
>> The dhcp command is supposed to have the following syntax as per
>> "help dhcp":
>>
>>   dhcp [loadAddress] [[hostIPaddr:]bootfilename]
>>
>> In other words, any arguments should be passed to an implicit
>> tftpboot command after the DHCP exchange has occurred.
>>
>> Add the missing code to the lwIP version of do_dhcp().
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  net/lwip/dhcp.c | 27 ++++++++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
>> index 23b56226921..6f987e469d6 100644
>> --- a/net/lwip/dhcp.c
>> +++ b/net/lwip/dhcp.c
>> @@ -111,9 +111,34 @@ static int dhcp_loop(struct udevice *udev)
>>
>>  int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>  {
>> +       int ret;
>> +
>>         eth_set_current();
>>
>> -       return dhcp_loop(eth_get_dev());
>> +       ret = dhcp_loop(eth_get_dev());
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (argc > 1) {
>> +               int i;
>> +               char **tftp_argv;
>> +               struct cmd_tbl cmdtp = {};
>> +
>> +               /* Invoke tftpboot with the arguments passed to dhcp */
>> +               if (argc > 3)
>> +                       return CMD_RET_FAILURE;
>> +               tftp_argv = malloc(argc * sizeof(char *));
>> +               if (!tftp_argv)
>> +                       return CMD_RET_FAILURE;
>> +               tftp_argv[0] = "tftpboot";
>> +               for (i = 1; i < argc; i++)
>> +                       tftp_argv[i] = argv[i];
>>
> 
> Couldn't you just pass the original argv and argc if argc > 1.

Ha! Yes. I don't know why I thought tftpboot might be confused by
the content of argv[0]. It is of course not the case. v2 coming
shortly, thanks!

-- 
Jerome

> 
> Best regards
> 
> Heinrich
> 
> 
> +               ret = do_tftpb(&cmdtp, 0, argc, tftp_argv);
>> +               free(tftp_argv);
>> +               return ret;
>> +       }
>> +
>> +       return CMD_RET_SUCCESS;
>>  }
>>
>>  int dhcp_run(ulong addr, const char *fname, bool autoload)
>> --
>> 2.40.1
>>
>>
> 
