Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90956C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 08:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB6586481;
	Mon, 28 Aug 2023 10:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jFHxr4i4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE83B8648E; Mon, 28 Aug 2023 10:12:00 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 287478056B
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BDD473F629
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693210317;
 bh=qtCz5OGlasMQVxLpu4btkkY11FnZ855wRCi5Bl3yDz4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=jFHxr4i4Hvjp/mlmwJuYmjx7sftw8+zjLAcdN2eb6bAaDa+wZ3w336OXXvL7N744Q
 lXEIsrEDtFfDi9lmlo6Zj7bWtDNMXr145xiWsi+3V9fKhalydvLHaTvmkz2TMq0Lx0
 NwHtLjlrLFYisc/psDNxDBrY5mbm2IKTdmsnSOCf4UsCh8DnPKRcYk6mER8LncO4vz
 YqsbF+l47QCv9GKlp4DRX+Tcn4rC8wZdUCQHz9c70Xs810V8WvDNgewo9iN1x0opdw
 jDVxYjpOdlqtzrqLPJ3KLStgFrnfSLguUOcwkPXeLjyO2u+HwbWzUT4gzinlzEElCJ
 rIMhMM2ZjiZ1A==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fef3606d8cso24150675e9.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 01:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693210317; x=1693815117;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qtCz5OGlasMQVxLpu4btkkY11FnZ855wRCi5Bl3yDz4=;
 b=CUFPRV2yFiaRaWrG06oEgmPQ4JSkcFreWUiSC9enR4hgrKLfXuSwQM+0BpY6uJ0zdB
 mgMrmpZHSbENpjCkQTWnii5wYRVYz04dkTtg1JHERjq03xAn+THxSJyvWApFtpRszqu3
 njGK3L/jGj2AMqpEA+efa+LZscylf4+6TSdLTO6zO7W5ldD+BVO5tglvOt4Vymgk6sOF
 raK7O5qkn7G8EqA3RzHcv1uMITXqUbGfqIvQqhZm/fREqSXkD64Jl+HEEC/sZPGx7cn3
 i5kkw306N0moinH8rm9mS9NODnGS23QuSu4s/JyPu3MkHztIlWfVqJ0/wJC7UrYmnlgJ
 nG4A==
X-Gm-Message-State: AOJu0Yy8dQLWgyGtPwiQLuEXwKS54cd0jVxgwe6Phrdpmu92h3Li2fvr
 CulYw5E23Dlj+xF3hq8vYN2U5w/5n/elz14KI3LD/OoT02uBPMTv6rzgcyTZyqJvZEtCRTmBh3M
 MhNt9GH7AROs5knCo6BSLxgzzl9rdtzM=
X-Received: by 2002:a05:600c:ad2:b0:401:aa8f:7562 with SMTP id
 c18-20020a05600c0ad200b00401aa8f7562mr8368395wmr.11.1693210317377; 
 Mon, 28 Aug 2023 01:11:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHbPEPBCBpPMntJGEN+b5iL+mKo9iTk36NhcpxSF2d8iaUj2S6e0VSj0n+tN5PDVnY2bPzmw==
X-Received: by 2002:a05:600c:ad2:b0:401:aa8f:7562 with SMTP id
 c18-20020a05600c0ad200b00401aa8f7562mr8368381wmr.11.1693210317009; 
 Mon, 28 Aug 2023 01:11:57 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 k2-20020a7bc302000000b003fc06169ab3sm13096793wmj.20.2023.08.28.01.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 01:11:56 -0700 (PDT)
Message-ID: <1190e6cc-ae45-40a6-a93b-0a3ae43948e6@canonical.com>
Date: Mon, 28 Aug 2023 10:11:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cmd: fix gpt setenv
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Joshua Watt <jpewhacker@gmail.com>
References: <20230826015343.167612-1-heinrich.schuchardt@canonical.com>
 <20230826015343.167612-2-heinrich.schuchardt@canonical.com>
 <CAPnjgZ1AqaME9UqHHyfrRSh+41J3oC3+XkZ1Z3hXXzZh7Muufg@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ1AqaME9UqHHyfrRSh+41J3oC3+XkZ1Z3hXXzZh7Muufg@mail.gmail.com>
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

On 26.08.23 04:04, Simon Glass wrote:
> On Fri, 25 Aug 2023 at 19:53, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Do not assume that partitions are continuously numbered starting at 1.
>>
>> Having a partition table with a single partition 63 is valid.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   cmd/gpt.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> I would like to have a map / list of the partition on a disk for
> bootstd. At present we iterate through a lot of partitions that are
> not present.
> 
> What do you think?
> 
> Regards,
> Simon

Reading the partition table and buffering it is possible in principle. 
This is what Linux does. But you have to remember that there are 
multiple commands that can overwrite the partition table, e.g.

* gpt write
* mbr write
* mmc write
* nvme write
* sata write

Or there could be a user action like swapping the SD card.

So you will need an invalidation logic for the buffer.

How much boot time could you save on an embedded board?

Best regards

Heinrich
