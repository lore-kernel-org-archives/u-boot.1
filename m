Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D098CC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D646881D6;
	Tue, 18 Jun 2024 14:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kD9oTrQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DFD188137; Tue, 18 Jun 2024 14:34:05 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1A6882ED
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C87353F42A
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 12:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718714040;
 bh=v6unGyKfnAZe8ZH6zMDskQrx4MmLwDKHv9WgKXayykM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=kD9oTrQoeQ/UR+aTSY9lEHyVJJUU+3ipaNOUKHcKAwHK0PsDGVfTU3jHMsSaZks/P
 BVaIEPADpwNUfSqO2ukykCqhyD35xDcpCbNgmAoWSbdEnCTX0Y7KnhQ7g5BfLJvNrP
 UbCIFNeWxaeagxRUJgxUYEiN6VwZ57wrYYUQiyDf6DVPeZE4NASBaThFD/+u7qLSL2
 6hgITZyDEGqykcQ9yrmz9SDzuQORkmNGtOKpR4Jh3BGwUDb3qId5m5wY3M5TLlLY0G
 V3rEb7vOK71GdXzwLS3YFtsySnz396s+xCa6kpKNMPzd0IRBsSkkOgBjaWoUeju/EL
 WOEWwpWCCm7RQ==
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52bc0027a29so3412441e87.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 05:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718714040; x=1719318840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v6unGyKfnAZe8ZH6zMDskQrx4MmLwDKHv9WgKXayykM=;
 b=gMmNf1F2jh0J3t7A80qIU4fvYvxOprC2rW0/ZXiBSDXtvRrrLPpAFVgjK6w3PyPvWg
 NNP3j5WoYm2jbb6ub/aCP/YSe6v58y4t55/6uue9SJjYOqVJL0yh4vPZAofnLo5rTSRw
 DsReTOWaQnDjOJlN/i3ZNd6SCF/nh2zzeyQX9KEEbKPbvQY18b4M/l3bxXEKX6n2gtfP
 sYg+ElgV5WE6HfomuCkdrJoajZeZrzUKcQpqpS/SVM9A/ALv/g0wnQLTAd+lBWOqyfG8
 tV9VlDXsqLCJjPtCUASneIL4VE5V2Lx1j6r+MqBgwMXf5GZRqXWwEP7KBjQIQSzhOEFx
 44OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnqpM68tcEvw+60gcLgjtEhbrHZBYpAxdM68LgbJUHpxxXDunJx15pVCDRlNCjhZSO4F3jDbpXmZDRWYNp7LjL6PVCdQ==
X-Gm-Message-State: AOJu0YwKFgdqB7UcQTOvHXutCbO4UnswFAmyn4cfhhkVojgsOKZFSi4C
 Or8tchhUI+OszaqyT4ZNg1FmcK9gc9d0PmSCVLe8dLfobFAN3pvODkly+lBA6rO1NxrMgHTVLOi
 Ty8fBo0fy+jcx4KdJEWqFSV2T2uen+H95jMXDJz5S+LJMs6TRC7xyks5J/wgZ7ekd/eqOtHVWJG
 k=
X-Received: by 2002:a05:6512:308c:b0:52b:c262:99b3 with SMTP id
 2adb3069b0e04-52ca6e56389mr8571238e87.11.1718714040140; 
 Tue, 18 Jun 2024 05:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6Mf0G/vW9bk2rnjOQNL31RoNQ/JHRCCVfNgsGrkxojHaXTv8I8jpxQZcxUos+zpYk8pcL7w==
X-Received: by 2002:a05:6512:308c:b0:52b:c262:99b3 with SMTP id
 2adb3069b0e04-52ca6e56389mr8571219e87.11.1718714039729; 
 Tue, 18 Jun 2024 05:33:59 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104c50sm13917998f8f.108.2024.06.18.05.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 05:33:59 -0700 (PDT)
Message-ID: <30db2e7f-86f4-472e-9661-c50e32e400ca@canonical.com>
Date: Tue, 18 Jun 2024 14:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] spl: correct link to FIT specification
To: Marek Vasut <marex@denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20240618063230.24478-1-heinrich.schuchardt@canonical.com>
 <30fc3a75-ee32-440a-9730-57dd5883919f@denx.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <30fc3a75-ee32-440a-9730-57dd5883919f@denx.de>
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

On 18.06.24 13:54, Marek Vasut wrote:
> On 6/18/24 8:32 AM, Heinrich Schuchardt wrote:
>> Replace the invalid link to the FIT file format specification.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> SPL is tightly size constrained.
>>
>> Shouldn't we remove the message with the link which is only of interest
>> to developers.
>> ---
>>   common/spl/spl_fit.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>> index 988125be008..2a097f4464c 100644
>> --- a/common/spl/spl_fit.c
>> +++ b/common/spl/spl_fit.c
>> @@ -587,7 +587,7 @@ __weak void *spl_load_simple_fit_fix_load(const 
>> void *fit)
>>   static void warn_deprecated(const char *msg)
>>   {
>>       printf("DEPRECATED: %s\n", msg);
>> -    printf("\tSee doc/uImage.FIT/source_file_format.txt\n");
>> +    printf("\tSee https://fitspec.osfw.foundation/\n");
> 
> Why not fix the link to local documentation in the source tree instead ?
> 
> I would much prefer that than random links to random websites .

The internal page is going away, cf.

[RFC 1/1] doc: Remove FIT documentation that is elsewhere
https://lore.kernel.org/u-boot/20240617202041.3740154-2-sam.povilus@amd.com/

Best regards

Heinrich
