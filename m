Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677E8CFA74C
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 09:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA9DF88CD9;
	Fri,  4 Oct 2024 11:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xDbP1g2K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E778901F; Fri,  4 Oct 2024 11:07:32 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D075688CD1
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 11:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d2b24b7a8so558055066b.1
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728032849; x=1728637649; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ya8pW2fqvKPJc/RvM1DIOEb7nqssGQpLDjGKgtzim3s=;
 b=xDbP1g2KEsH/oyr9FGl8LKi/Lnza5FStH8R9mxc41HI0g6QkMAg04Ul2zAdqXwFKrV
 fmaazUO9r3bmVSmBDpEY3rIEhAovAeVRhSDV4S1w7o+RmTUkYXAQKKMzgElMUuPuKKTa
 POFqKL4z/ValAJiMOLAfJg6kdIJ17CFZ7BPZKfiK//ssy9XE55QrSafsGDrbkouK0dF7
 BCc61X2HYjx4hqE0TuhILAQAonmeFxI2TWbSw5i34Ux/9wbitBIZVz2wgx++WgtZIv3Q
 drEQ6DbZH/sccU7d1Heo99FLa0n5On5sUywm83jjPh3AxQmgDHUexfbk2xHn4zfPB86p
 UquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728032849; x=1728637649;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ya8pW2fqvKPJc/RvM1DIOEb7nqssGQpLDjGKgtzim3s=;
 b=BM5acYNxsoAKVsvt+bbvCiy6uldyI6lWHGa0s14amD4I6TW7cVQ4KWURnzyW2svisn
 nFufKUPyapCqgwjxlFgoxxbzV80tSr3TPZRsTGDIwzXRg4SV2O7Z2JkTO0TGB3WQE2CZ
 sTkq66y15gfS4JgQCZPfGc8s12S6X7GGx410I8zpQ/CDNPthTjtwerYs7qSccORP9sP3
 3CeS/oUsTZ5b8Bh2MIjRt+2o0x5XKURsaT4+btsyZv3fTmw+Vsghr987v7rGB9z4CFjW
 1omBukPDyI1gY84HaUpvRYHG9AjOHKxjCFucfWr1vS2ozF3qbIRHecOm+blCmJt6JPk8
 ciFw==
X-Gm-Message-State: AOJu0YziCPl1tE8iA4HCdBQBRAa1cLvutRUC4KmhBZzpKXy1+q+iWdgS
 Zrnv98qt2NIhYWm4PlQuVG2WCi7pOKiZysekoq2/0k+DEHOXbnrYlP9itu3YBX8=
X-Google-Smtp-Source: AGHT+IFq3L2lbY2+QPzKTaPDNMyVNwJ9HxIfICPAX6KaVEU2w5RFCA66CIKepniPnIzD31VZr8PIOA==
X-Received: by 2002:a17:906:6a1f:b0:a91:15ba:7c4d with SMTP id
 a640c23a62f3a-a991d008494mr159294766b.33.1728032849269; 
 Fri, 04 Oct 2024 02:07:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe?
 ([2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99104cc7ecsm197067566b.225.2024.10.04.02.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 02:07:29 -0700 (PDT)
Message-ID: <474cc6ed-c339-409f-a0c2-a30ccfc4b223@linaro.org>
Date: Fri, 4 Oct 2024 11:07:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/29] lwip: tftp: bind to TFTP port only when in
 server mode
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <c29c2aa6fc0f1a97afff121e2f42abcac5b671f2.1727968902.git.jerome.forissier@linaro.org>
 <CAC_iWj+Q9VSVPqGBveYm5+PYQXm0CKRg5==z=VJPd0G4-7U0ug@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWj+Q9VSVPqGBveYm5+PYQXm0CKRg5==z=VJPd0G4-7U0ug@mail.gmail.com>
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



On 10/4/24 08:11, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> On Thu, 3 Oct 2024 at 18:47, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> The TFTP app should not bind to the TFTP server port when configured as
>> a client. Instead, the local port should be chosen from the dynamic
>> range (49152 ~ 65535) so that if the application is stopped and started
>> again, the remote server will not consider the new packets as part of
>> the same context (which would cause an error since a new RRQ would be
>> unexpected).
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  lib/lwip/lwip/src/apps/tftp/tftp.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
>> index ddfdbfc0c1b..74fc1fbe586 100644
>> --- a/lib/lwip/lwip/src/apps/tftp/tftp.c
>> +++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
>> @@ -454,10 +454,12 @@ tftp_init_common(u8_t mode, const struct tftp_context *ctx)
>>      return ERR_MEM;
>>    }
>>
>> -  ret = udp_bind(pcb, IP_ANY_TYPE, TFTP_PORT);
>> -  if (ret != ERR_OK) {
>> -    udp_remove(pcb);
>> -    return ret;
>> +  if (mode == LWIP_TFTP_MODE_SERVER) {
>> +    ret = udp_bind(pcb, IP_ANY_TYPE, TFTP_PORT);
>> +    if (ret != ERR_OK) {
>> +      udp_remove(pcb);
>> +      return ret;
>> +    }
> 
> This should be sent to lwip as well right?

Yes: https://savannah.nongnu.org/patch/?10480

Link added to the patch description.

> 
>>    }
>>
>>    tftp_state.handle    = NULL;
>> --
>> 2.40.1
>>
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks,
-- 
Jerome
