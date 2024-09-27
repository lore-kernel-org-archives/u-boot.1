Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D488CDD1C8
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 16:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453F78910E;
	Fri, 27 Sep 2024 18:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C8KskgtG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C4BB8910E; Fri, 27 Sep 2024 18:01:22 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A0C589105
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 18:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37cdbcb139cso395785f8f.1
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727452880; x=1728057680;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YI46YMRgzu9HpNeVHBBF+GGVpNsymGGvDSbwsbtptDo=;
 b=C8KskgtGtDFF+I7n5VCw03xeolP6JoRA3FW9Vqrbm65x199ye7HBB7iOf/j6sHGl5R
 1pPTsPiEO+g50ECkiJhGRv25Nin4pP2ptBMYQvjN0cUFlC1K7RxwzF3DQ/GyF2c18eil
 Y1X4b4Zty6tHofCggsU7l1h6Z8sJOJUSnk/hJqIeObWPpPzMHTuztEQi4Zf9X9ANg/0o
 96uuL8gUOGTbDtjn6M2FL5WnJMQ5II8AE9d5XcdoWEi4/KHd6fviROzclJCnkrTPToOA
 LNQVwBGNd342QKgkvKtd+DH/wvaTjlehaym5NC0WAyFAEUWh226YRrYMaM6BIvgZ8I1V
 SY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727452880; x=1728057680;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YI46YMRgzu9HpNeVHBBF+GGVpNsymGGvDSbwsbtptDo=;
 b=nfcw/CDgu3RCU1drr1WoHAtb0F+Th4fvIA+LzryMHDIBFUYNUK9gUm0O8lTgNa31b+
 ZkMZ7T74O/Gk/Hi7GzfvvbyyPGPFMp9/OkCbAh+i3etK0GD6E7J+R+jhYaotTIhlMhml
 gJHDZEFYkXQY/IehKTvoDIl8LQ6vf684ZiRTlsGt2/RopLnSl0OvnKLV+ni5iPps9NcS
 Ew8IrJ1aLhESqiIa1j7RWin6c5/nP4Gaq5A/2L0987BVuMFyJKryIPXhVz28rPbqLeuy
 wBO1ajPebsTmO/Bi85nVVTw3mqKTbqbHcWcHLrKp4DvB+NBUjoTQkpGW1ESxXtYttD6J
 hhyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUG7nbraqHHJ5MSEOpE0Pbl7G5RZwbQfyRZeGA/BOnRp459syuo385Y/HKWyabLLDZ24QzOxw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5viL07uS/Y7nT0VUJY1wQbmBWUK4HkKbwB9DhaYNbRN3P6+kU
 RtV6wrjcmI9LVyUqO4FIYGKlsZFyaXcZwtjHxRJR5tWjwDeqJii3jBiCnkwT5JA=
X-Google-Smtp-Source: AGHT+IEWRkSH9VFfbIUvBj+qQhrtkh8I9L6PazmiK/K1aMpKGbvPcWraHBmknUUY2CX/s8ZxS/7roQ==
X-Received: by 2002:a5d:5910:0:b0:37c:c60d:f9b5 with SMTP id
 ffacd0b85a97d-37cd5a60a1fmr2351646f8f.2.1727452879409; 
 Fri, 27 Sep 2024 09:01:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:35ef:1faa:c54c:3c?
 ([2a05:6e02:10a5:e010:35ef:1faa:c54c:3c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd5764c50sm2829573f8f.112.2024.09.27.09.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2024 09:01:19 -0700 (PDT)
Message-ID: <411a5d8a-a101-47c3-bdc2-20a2dd93a812@baylibre.com>
Date: Fri, 27 Sep 2024 18:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] board: ti: am62px: Add android bootflow support
To: Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Vishal Mahaveer <vishalm@ti.com>
References: <20240912-sitaraupstream-v2-0-2101323d3fa5@baylibre.com>
 <20240912-sitaraupstream-v2-3-2101323d3fa5@baylibre.com>
 <20240916132720.r3tstmbxmbqpvncb@bryanbrattlof.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20240916132720.r3tstmbxmbqpvncb@bryanbrattlof.com>
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

Hi Bryan,

Le 16/09/2024 à 15:27, Bryan Brattlof a écrit :
> Hi Guillaume!
>
> On September 12, 2024 thus sayeth Guillaume La Roque:
>> From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>
>> When CONFIG_BOOTMETH_ANDROID is set, enable Android boot flow support.
>>
>> To build for AM62Px for Android, we can re-use
>> the am62x_a53_android.config fragment when building A53 bootloaders:
>>
>>    $ make am62px_evm_a53_defconfig
>>    $ make am62x_a53_android.config
>>    $ make
>>
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>   board/ti/am62px/am62px.env | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/board/ti/am62px/am62px.env b/board/ti/am62px/am62px.env
>> index f8b6aff2c2fd..7ef54079aa8d 100644
>> --- a/board/ti/am62px/am62px.env
>> +++ b/board/ti/am62px/am62px.env
>> @@ -13,3 +13,8 @@ mmcdev=1
>>   bootpart=1:2
>>   bootdir=/boot
>>   rd_spec=-
>> +
>> +#if CONFIG_BOOTMETH_ANDROID
>> +#include <env/ti/android.env>
>> +adtb_idx=3
>> +#endif
>> \ No newline at end of file
> It's odd that checkpatch.pl didn't complain about this. Or maybe it has
> never complained about newlines? my git hook script didn't complain so
> IDK. Anywho just wanted to point out the nitpick ;)
i run checkpatch with b4 tool and script not return any error on this.
i will change settings to not add this for the future .
thanks to point me this .

Guillaume
> ~Bryan


