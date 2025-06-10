Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8054DC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 14:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D674A82B0E;
	Tue, 10 Jun 2025 16:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xeSB7m+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6142982B20; Tue, 10 Jun 2025 16:51:50 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65BE482B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 16:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so3166175f8f.2
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749567108; x=1750171908; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=In57oEhUECw1B0P3PO4Qz/ye4A8hO1xDUt84a/Lkzkk=;
 b=xeSB7m+m6n3UaEfwPbfan/1+sHLRH3JaERBEcc1x/fbl/PwSeBR7dG7TzWSrR/ChMl
 PrAjk+KZCzt/vZaC2aysWf9FUpUga6UIcIZrcbS41oe7lQ9xJO6MVjlNZijHnXlFW8Az
 ctAKWlsmhc7ONJ1w9lpWsY4vN+Tz5aSIMKoSf3cSLTVmQwmuO1stcHHTqFuin3DMNCg5
 KANwcqin+U3Gnyt2cw+K0TVEWxXEJDs96ZmNKXmVgB/RCVa/BKWHZ+bssNsPgNLP9rST
 eucXirZGHqcuOpIHQ5s7IJSR/VpezVWq/tWh0N6LIDjZXzkwNrSIic/SsURQlmW4/jWT
 3ALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749567108; x=1750171908;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=In57oEhUECw1B0P3PO4Qz/ye4A8hO1xDUt84a/Lkzkk=;
 b=IE98F7mwtKhHJdIEICo612V/qtuXGb1VKtbELuoBJwv6H3J+QYAuKin+F4siAG7zrU
 i4KH4ljvJFTEstzm0VEbmGkl+v6bAWEUJVIPmR6kGzfU+TrrEFsnayiW8HFUVfyrTmhL
 mnIwowNP45rq+9vB1sFHOTCWKBC1ARDz8Ol32uAcTF6VmuTOTMi5tV/JnOKMXfukP/sz
 4dRRt7hkNCVSMta6TPqF9FIcuEwDSoJ4Ma0sok0hG1rRUCL+Mr+QSz1iUcpub5fDdDcX
 vuiSiAd6m12ddlDKp/1FlN4ZZ8/RtRJ4IK+uqIGRuUCc1vHI0297y31E/PxlyTEzvoH8
 4j7Q==
X-Gm-Message-State: AOJu0YyeotsEHCgefu4fOaxIJyTlwOhHruNUo3frsKA/m81t1Ladsing
 l208CqZkRo7085jOlMh8IRWS4dnd0I8iBcLDemBodF6zn5kdIjuuzBV1G4s7K6hzChU=
X-Gm-Gg: ASbGncsdCluKvVDs5l/TwKObfgZhHlG4zhYiY9vN02PZLGAMBqkrrnETxlJvJwjHKe0
 GgrpNP2S6EesBgoejyfPEwosWgCvIZTXCAeOq7CAv1JlDyot6emgBnuYhT8h/lugmgYkIwQZAlT
 e1SQddBuLa+YnOwCJqUSaIv7dVaJf/VaAclw9yzHcQajJur4SBqrH/4rvhLw5dCcwcsrxM2Inaq
 9qLvm+lWHBvlBlcGmnpbTISq2PcteNnKKfe0wZCrpmAs4l8jxQwOFHovMBp0DOpKCZCI/G9J7hH
 9PEHFuapy+RRnKTd5keK7kD51uZkaIZv2EP7/IICv+jPqLz3K46pBgt5mKcqvKoYfI8TyQsR
X-Google-Smtp-Source: AGHT+IHAvCcWPmHcR6soLGABbq7LTMLZ6iIS2FIaLw5fb0APiGJ9lgtkpS9TJK+c3OeeXRb0s73U9w==
X-Received: by 2002:a05:6000:2890:b0:3a4:ef0d:e614 with SMTP id
 ffacd0b85a97d-3a531cc3656mr14890409f8f.33.1749567107790; 
 Tue, 10 Jun 2025 07:51:47 -0700 (PDT)
Received: from [10.100.0.2] ([45.84.137.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5324520e7sm12515131f8f.84.2025.06.10.07.51.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 07:51:47 -0700 (PDT)
Message-ID: <7c28f6e4-49b6-4c40-9342-8c38ef4873e3@linaro.org>
Date: Tue, 10 Jun 2025 16:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] lwip: dns: do not print IP address when a
 variable is specified
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
 <20250606064211.3091237-8-jerome.forissier@linaro.org>
 <20250606141942.GO1382132@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250606141942.GO1382132@bill-the-cat>
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



On 6/6/25 16:19, Tom Rini wrote:
> On Fri, Jun 06, 2025 at 08:41:43AM +0200, Jerome Forissier wrote:
> 
>> When calling "dns <hostname> <varname>", do not print out the IP address
>> of <hostname> onto the console. Print it only when no variable is
>> passed. The reason is to be able to call do_dns() from another command
>> in need of the DNS services without polluting the output.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> 
> As I do not know off-hand, how does this compare with other commands
> which can be used to set a variable? I assume it's similar.

Yes, it seems to be a general pattern. For example:
- 'part list <interface> <dev> [flags] <varname>', see do_part_list() (and
other sub-commands as well)
- 'op count [*]src1 [*]src2 [[*]dest]', see do_binop()
- 'sm reboot_reason [name]', see do_sm_reboot_reason()
etc.

> And then,
> oh, we don't have doc/cmd/usage/dns.rst to start with. So, follow-up to
> this series please, document the network commands that we have in both
> lwip and legacy stack and please note where there's differences if any.

Added to my to-do list ;)

Thanks,
-- 
Jerome
