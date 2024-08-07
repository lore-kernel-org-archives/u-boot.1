Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE54C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62E8288D4C;
	Wed,  7 Aug 2024 16:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZJxCiKNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3470F88D54; Wed,  7 Aug 2024 16:39:58 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E768872E
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6F7FA3FA90
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723041595;
 bh=YGou20G1A792f69UqzrD8/QhkcXDhVbJJn9V2XpkRnk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=ZJxCiKNeo72CP8+x4qYcWusG/v3SrEaZW8haC7h8VAaXovwEolVS73bfj+MH17wbz
 isXIXLcgZw9M36NC/C7uZI0ZNtnMzcc6W3cs7K3ATke9ctEDDQVIV/6rU9JoFPytYV
 HZFr+jKi6nlA+eKUtd9PDfRjxf4KkqJett3c4OHQnhDawN1zBg3MEKJ90CTfUFF5WY
 x2iaY5n6gkMVO5rzlqOMpTBbcrKt5yeUkSoJkYkpZz9L/P/8Qc7kckmrdDdL3/+yN9
 eIsQekNmZbj2R031fz6lR/CvNLT+ggRQbyg/fgJzrgUPLm68BCx1VAjUVvgPQ9Zy7h
 CJZ285ZfgiC5A==
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52efe4c2372so2279017e87.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723041595; x=1723646395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YGou20G1A792f69UqzrD8/QhkcXDhVbJJn9V2XpkRnk=;
 b=ncbWfgBy4M+s/YmxZLqxS+Vcx5peHSHprzcDQMtbJmPFsDtGNh5eRQTFezDJHwlX7v
 eu9FzY7yzbjclLsDTyOhti9+WEQaLXstdODPzNq/C/rqjK8qFnkO4Ge7lqWGfrfJTGZQ
 Wdt6esNALCmmq87MKAD9Hr7EhHMT7WMbzQgImRGF7CP+ltskIlFv2EtirNw9eljMe60W
 br53m80Vhx4WVQshhmLqnIdapjXQMoI8AJvdQcXMb/kWnBZZlVir+Ad0HFw85bDPYLSB
 HHe3O3ItwT/1++cZGPe6BA+nf2v3X2pGp+lKhfJd85QR/5amrAxYPc4IIye09RyGalxy
 umzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUARQowYzKOuu60rMV3SUNeBCTUhJJbdFrS/Bd5hTyKDdx1i9oQt0egfSnxLMZdGMMIcIMGW+FeMdnrF4tOa14aQRBoCg==
X-Gm-Message-State: AOJu0YzU0G/W+k/sUbaRFSabfM1b7h1c9kYq96YLLm/THS4tpDjuqwf+
 FdpCBuicy26nWfR5tPZG8gpw7mX/PR5aJo+wGbDNf+3fkqmXfr4E7o1rS+KkYaUBimV2Tcd2f5i
 jhwb5E03Y/zRh1/1L+EowAuJ7T5DznsCrfiXfD53kFdsDHdxvMIJ6jMTo4z5gU3VxOiQSa2v8im
 w=
X-Received: by 2002:a05:6512:1393:b0:52d:215b:9028 with SMTP id
 2adb3069b0e04-530bb3b3b43mr12504363e87.60.1723041594674; 
 Wed, 07 Aug 2024 07:39:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCCQoOd0Yq3WYJrTzBM42A2TtnGHNl2uS6CnobfQqtJFKnsL9MDCEyX/8Z43CJ/SEetMsjZw==
X-Received: by 2002:a05:6512:1393:b0:52d:215b:9028 with SMTP id
 2adb3069b0e04-530bb3b3b43mr12504334e87.60.1723041594070; 
 Wed, 07 Aug 2024 07:39:54 -0700 (PDT)
Received: from ?IPV6:2a02:3037:2e0:4fb6:d51:5282:a43a:434e?
 ([2a02:3037:2e0:4fb6:d51:5282:a43a:434e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ecad25sm647383366b.221.2024.08.07.07.39.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 07:39:53 -0700 (PDT)
Message-ID: <dde17dfb-bf49-4b79-906a-54127c6f0e87@canonical.com>
Date: Wed, 7 Aug 2024 16:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] boot: set correct block device name in
 set_efi_bootdev()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shantur Rathore <i@shantur.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
References: <20240807001345.296937-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjw=WEQsPdxoxjdZ980Vq4wvb1tuvFnevOiVBZNARGGJA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTjw=WEQsPdxoxjdZ980Vq4wvb1tuvFnevOiVBZNARGGJA@mail.gmail.com>
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

On 07.08.24 16:36, Simon Glass wrote:
> On Tue, 6 Aug 2024 at 18:13, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> For SATA devices the class name is 'ahci' but the block device name is
>> 'sata'.
>>
>> Use function blk_get_uclass_name() to retrieve the correct string.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   boot/bootmeth_efi.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Hmm I suppose I need to do another round to try to get rid of
> blk_desc->uclass_id

efi_set_bootdev() should take a udevice in future.

We are converting to string and later back to device before we create a 
device-path. This makes little sense.

Best regards

Heinrich

> 
> 
>> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
>> index 39232eb2e25..6b41c0999f1 100644
>> --- a/boot/bootmeth_efi.c
>> +++ b/boot/bootmeth_efi.c
>> @@ -100,11 +100,10 @@ static void set_efi_bootdev(struct blk_desc *desc, struct bootflow *bflow)
>>          if (last_slash)
>>                  *last_slash = '\0';
>>
>> -       log_debug("setting bootdev %s, %s, %s, %p, %x\n",
>> -                 dev_get_uclass_name(media_dev), devnum_str, bflow->fname,
>> -                 bflow->buf, size);
>>          dev_name = device_get_uclass_id(media_dev) == UCLASS_MASS_STORAGE ?
>> -                "usb" : dev_get_uclass_name(media_dev);
>> +                "usb" : blk_get_uclass_name(device_get_uclass_id(media_dev));
>> +       log_debug("setting bootdev %s, %s, %s, %p, %x\n",
>> +                 dev_name, devnum_str, bflow->fname, bflow->buf, size);
>>          efi_set_bootdev(dev_name, devnum_str, bflow->fname, bflow->buf, size);
>>   }
>>
>> --
>> 2.45.2
>>

