Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8ABCD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 11:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B6A988094;
	Tue,  2 Apr 2024 13:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Fm9XwHX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8855B880DE; Tue,  2 Apr 2024 13:56:01 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B34AC87ED8
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 13:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8AE1642491
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 11:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712058958;
 bh=Ni2fDb/+byh5ROykxWmnW430XrzdNT1F6JCuiYkcv/w=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Fm9XwHX73u1r+VOtPA1g6hvYYwEilQlRSIuqzVVmiWl/1PL5/xjxMOxyrPp7JCtzs
 5XJsDWNplB2inOiAXVRbOs3XDhE1CAeqQJXQuAtw36NDSidMTLgAw6LTKkC6PZay3q
 z9Bui4dSv6dXuj+amgJg1xfipLlmPpSRh6ly1zM1ko2aplkvSdAzGbIyGZahuCxYIb
 qr1Rl2Abrpkl9EtnEN11mWdCD7UYMZNrvgBvRurQNh8ArhdXyfTShlvmN7vEGlFpW7
 VkZpk9HtTnB5Jn6c8QJt56A/uJe7zXJM8WYlBewl7DSJZAnzHp2urkwp+ky1obFHik
 KbxgxKnE3Y2pA==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3436714e286so425954f8f.0
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 04:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712058956; x=1712663756;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ni2fDb/+byh5ROykxWmnW430XrzdNT1F6JCuiYkcv/w=;
 b=btLPuYLgwJb2NXewGyL4o648r7ziTOcpX+3MZHxZx/a48giq9Ffz9CnWADGtYv7pZr
 Ai6p46jzXv8vsOq7l3QUUm+IEvUVA54Ev2BDihebEb0qviloSI1/ElfAUsMg47oydMIK
 +l1Gh1sAcwmCnz4zYewfwbABGOkTvH1Gi61I4TUjWmZoDcDaOhhWkaz2RYtWk7DN5qUS
 NXRVErS5bpeCzVxqtzD2HfqAGbQIEN1aPeN4ZYyMB6Dbx0hydWdPeBs1Rrg1Ze5Z4XWL
 F0HiSZoq5cFQpQ0bcmUywd9XGIbVCZVcM1+LgZd1gZfIPpeUsWqt6Oq/QYyR2EAiwmJZ
 ctPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrN5h3Y0BqmMmjDHk8udCv/g2BGFCyIGHfyFk3OqgslVE58SobwfRIGcXwo6n0gx4eNH9Y6AEyzqTpXURRTbTkVE6PHg==
X-Gm-Message-State: AOJu0YzssPebPsuDxMSmDeE/KIXtT1iSGa3QTvN8rZX1x2fqaMRdYX2Z
 49Fuw/kCJ8786RDxQDn08GL6qV9K/rGqFjed2M2YEz0RAPqUa9bAQ4jLkAQpebYHNF2QyfXbYl0
 fAd7dom27zsYxqIA0C2FX89ATPIgZOEyyMn+XMDVwBHgu/4O2XY3LbtDA/kotSSiNWkk=
X-Received: by 2002:adf:f986:0:b0:341:d2e2:31d4 with SMTP id
 f6-20020adff986000000b00341d2e231d4mr6985246wrr.57.1712058956420; 
 Tue, 02 Apr 2024 04:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd504CLhe5sJXXx0SI4uDQM9RK3/9F/qatdPWWKgDq7sBfENYSKLQz8bPKBuDAd95XDW6ZyA==
X-Received: by 2002:adf:f986:0:b0:341:d2e2:31d4 with SMTP id
 f6-20020adff986000000b00341d2e231d4mr6985235wrr.57.1712058955995; 
 Tue, 02 Apr 2024 04:55:55 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 d8-20020adfef88000000b0033ed7181fd1sm13940906wro.62.2024.04.02.04.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 04:55:55 -0700 (PDT)
Message-ID: <6e06a4c7-77ca-4ed0-bb75-88a93d204cec@canonical.com>
Date: Tue, 2 Apr 2024 13:55:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: dw_eth_qos: Add missing \n in error messages.
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Ley Foon Tan
 <leyfoon.tan@starfivetech.com>, Marek Vasut <marex@denx.de>,
 Elmar Psilog <epsi@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
References: <20240402083934.42733-1-heinrich.schuchardt@canonical.com>
 <60726dc4-4952-4e60-bdf1-f5e14cacf0ff@theobroma-systems.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <60726dc4-4952-4e60-bdf1-f5e14cacf0ff@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 02.04.24 13:26, Quentin Schulz wrote:
> Hi Heinrich,
> 
> On 4/2/24 10:39, Heinrich Schuchardt wrote:
>> Missing line-feeds in error messages lead to output like:
>>
>>      phy_startup() failed: -110FAILED: -110=>
>>
>> Output like the following is much easier to read:
>>
>>      phy_startup() failed: -110
>>      FAILED: -110
>>      =>
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   drivers/net/dwc_eth_qos.c | 108 +++++++++++++++++++-------------------
>>   1 file changed, 54 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
>> index 9b3bce1dc87..1b4d0eda887 100644
>> --- a/drivers/net/dwc_eth_qos.c
>> +++ b/drivers/net/dwc_eth_qos.c
>> @@ -159,7 +159,7 @@ static int eqos_mdio_read(struct mii_dev *bus, int 
>> mdio_addr, int mdio_devad,
>>       ret = eqos_mdio_wait_idle(eqos);
>>       if (ret) {
>> -        pr_err("MDIO not idle at entry");
>> +        pr_err("MDIO not idle at entry\n");
> 
> What about using this as an opportunity to migrate to dev_err? 
> (considering there are two GMAC controllers on RK3588(s), this would 
> help identify which has an issue :) ).
> 

I have a dislike for mangling different changes into the same patch.

Please, consider providing a separate patch.

We might also want to get rid of references to __func__ as the log 
framework allows to print function names.

In the example above we might prefer to eliminate writing the same 
information twice.

Best regards

Heinrich

