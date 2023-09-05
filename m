Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A362C83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 08:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5759386961;
	Tue,  5 Sep 2023 10:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lLrBPOwv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC72F86961; Tue,  5 Sep 2023 10:58:36 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5164E8653D
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 10:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C8ADD3F149
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 08:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693904313;
 bh=TInf+1OD+Zk3nLuDycIUdZV17y1xArmP+s/KFWvK+vs=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=lLrBPOwvb/d74BgeW4Q3pKt7FYW4ajqAQFry7tX6rWqYZgyAUFRWN/AJ6q+/Hy6Tr
 wyFVnmXnl8m9GzXzeIqq1Bq6apgkcZZbnBkt6CnCTtKVKQYxCMzcQuLxMrGvrhBo5r
 kTf0hvB9dE8Y5OGj/oKtsL5rimDxneDlDsGEhLow5liPTlPyay1v4xNyhWDly9UBji
 OyWn7Y50RoXoWDYQDIHTxZ21OpBPzMElOlZKOFybWtEYcOLw+zg8DnEikSn3T3wDyZ
 zT9wfvA9ZYTzmYvsqBF06RZi6/OH3dcuTOgI216d0ad3a+1hrGKZ7qzh+tgSZFZ4EA
 oECTHTaFByWHg==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9a5d86705e4so156041866b.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 01:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693904313; x=1694509113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TInf+1OD+Zk3nLuDycIUdZV17y1xArmP+s/KFWvK+vs=;
 b=DE6zh9u+dJ9WIUUphUs5JRARIigUhOya3FwxX4HSUXUuY5R7hiCKsCEMvNv1iSQoOq
 EvhmTJQNcCHgBcOkykmQKy/j90YfhxeOCKLQCqomSRbiOiWcbU63szrZjOuTW5loyUQ9
 IlbklguT87q8nCwMLuQvcDyWbMrJN8kLu1mvL24Vp1u/3bI1VFXmP7xLM+SoNBBjsAoz
 bhLex9k5ez8egl8flm+rTABKO/gVbAz3WbWoXzx7/si7asRI7n6/dNQX0dd5oYDlNk52
 FSbeXNP7Bdg7DAaZHauy47OZYje760QQp5km3rtgljElHKfI9eQ649DMYOi3f8QMtIHc
 QCTw==
X-Gm-Message-State: AOJu0Yxh+Mtfq4+myvcbshP0ZV7v70+lTPH30RDYk4MSpvB1p0DPW6C/
 q+zpAkWEneE7w4Uq2io0tUuAo50xRRDqYw5Dd+c+TNQ28BmGrbYuD4zSlJIjIyYnjiTMqSUBhit
 NnbY6xwlkofud+aqXsHV7TCZuBjKh3PI=
X-Received: by 2002:a17:907:1dd7:b0:9a1:f21e:cdfd with SMTP id
 og23-20020a1709071dd700b009a1f21ecdfdmr8233094ejc.34.1693904313439; 
 Tue, 05 Sep 2023 01:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqurShXzgGhQ1s/JCDg1TN6c3znNweWY+MCYVhewYRxGrqsFdxa+u+g3VLn0t7ultT3+o9XQ==
X-Received: by 2002:a17:907:1dd7:b0:9a1:f21e:cdfd with SMTP id
 og23-20020a1709071dd700b009a1f21ecdfdmr8233077ejc.34.1693904313042; 
 Tue, 05 Sep 2023 01:58:33 -0700 (PDT)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 x10-20020a1709064a8a00b0099b8234a9fesm7264113eju.1.2023.09.05.01.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 01:58:32 -0700 (PDT)
Message-ID: <9cc69902-f8d7-4b86-b071-f293463a8f5d@canonical.com>
Date: Tue, 5 Sep 2023 10:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: Rework riscv_cpu_probe for current event macros
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20230904190635.3896494-1-trini@konsulko.com>
 <ZPaaEyaBss-XDc4X@swlinux02>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZPaaEyaBss-XDc4X@swlinux02>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 05.09.23 05:01, Leo Liang wrote:
> Hi Tom,
> 
> On Mon, Sep 04, 2023 at 03:06:34PM -0400, Tom Rini wrote:
>> This function should now be a EVENT_SPY_SIMPLE call, update it.
>>
>> Signed-off-by: Tom Rini <trini@konsulko.com>
>> ---
>>   arch/riscv/cpu/cpu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
>> index d64aa330f206..cfe9fdc9df55 100644
>> --- a/arch/riscv/cpu/cpu.c
>> +++ b/arch/riscv/cpu/cpu.c
>> @@ -66,7 +66,7 @@ static inline bool supports_extension(char ext)
>>   #endif /* CONFIG_CPU */
>>   }
>>   
>> -static int riscv_cpu_probe(void *ctx, struct event *event)
>> +static int riscv_cpu_probe(void)
>>   {
>>   #ifdef CONFIG_CPU
>>   	int ret;
>> @@ -79,7 +79,7 @@ static int riscv_cpu_probe(void *ctx, struct event *event)
>>   
>>   	return 0;
>>   }
>> -EVENT_SPY(EVT_DM_POST_INIT_R, riscv_cpu_probe);
>> +EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, riscv_cpu_probe);
> 
> I cannot seem to find macro "EVENT_SPY_SIMPLE".
> Is there anything that should be added?
> Or did I miss anything?

This patch is only applicable to origin/next. The definition there is in 
include/event.h:311.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>


