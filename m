Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169C2C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 12:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 962D188618;
	Fri,  9 Aug 2024 14:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kr+os3NC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BB5E88AF4; Fri,  9 Aug 2024 14:38:40 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 466E0885AE
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 14:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7ac449a0e6so203096066b.1
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723207118; x=1723811918; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lT7M2jOklsmCc59RaVKRYsjwNNAXDN7bin7Db8/ef/k=;
 b=kr+os3NCCBhMqiHA1CWdoYhEZ/fJQ6reAlNlywlwu3DfkEztCWMR6eKi1F0XxiMHSZ
 5PwsDHTC2qlSU64i1a+3XHWwRVTB6QCcv15DJ14YwKO0bxMnGcua9tTcQwyCcoOUpIBl
 SBZGL1EDOqe5YNzXSYmBGSGMoX5f4jQXoWs5cQMxeMybTceWGVzE/6zILEhnquTKLRhP
 Q5HchfVkUAUjAS2+p0yCKnEbPq2Lh+IoZqqe1aAKf46GUrEzU+qDNs+yu+5d02Yv5KMl
 kf6Fv8yjA5gLsiuK6CbVOrUXWKELlveAOkBBMZqJcSg6kjlutzJ++dQKzQM0w9PUlK52
 L/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723207118; x=1723811918;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lT7M2jOklsmCc59RaVKRYsjwNNAXDN7bin7Db8/ef/k=;
 b=nPmfTVP34GB6Vqj2ug699sj6Tfx4RCsaYgf9Yj+i2syKCtDc+meiiGaQ+eiQADjrOH
 4wz1yn6a9lerkJdP101MEJnT8Fcalu14SppzmwviErOFL0pKUSRDdnB5Tn3nf4+cCRTx
 y/B3gxitTqbKYPxqXlrlCJ4txE9OW4HjBkE5Cb5xr/KwsoV1VrWkBerwlw0hZhPxIdJ8
 ZvotM3Fk8jZSE248hWwQAHj8njJB8OgBPmfTeSYEVgEnacEa8EEuuIyGbzn0F3Bmh7Wn
 gcMeA1Jnq2lJ3IopKKXWEgc9j0IVy3C+xV9P6WnSxWBj4IedsO1k+pwTdLk245UV51cF
 A6AQ==
X-Gm-Message-State: AOJu0YwTY6Rl5/iVAojaNB+ApS8U0VMFm1A4L/vVOBWRkMl5yq/M0JCj
 Tf72Vv/Jk3mkJtVFF7TyHVf9QCBqWdf8UWtkg+K400gLir2xqUJijAi6rJwIeuo=
X-Google-Smtp-Source: AGHT+IFab+D5s104dgbCyLNZtDdrZVHBUp00fmFF92aldnCekI9NwWdx4Skzh3At3b/pI/A2ja8VSA==
X-Received: by 2002:a17:907:1c93:b0:a7a:a3db:c7b3 with SMTP id
 a640c23a62f3a-a80aa599207mr100700666b.19.1723207117529; 
 Fri, 09 Aug 2024 05:38:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:f3b8:f3a:8a2b:6d6?
 ([2a01:e0a:3cb:7bb0:f3b8:f3a:8a2b:6d6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec8cd5sm834280166b.213.2024.08.09.05.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 05:38:37 -0700 (PDT)
Message-ID: <c7f711fb-0ce8-4d59-b457-476f60c233c5@linaro.org>
Date: Fri, 9 Aug 2024 14:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/23] net: wget: allow EFI boot
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>, Yasuharu Shibata
 <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <b02ec5e623fd4c80201c92630780ed7e4f557191.1723050310.git.jerome.forissier@linaro.org>
 <CAC_iWjL-GbO=FFbAyn-OFm5te63zGwwBMAsGv7orGC+oBObb_w@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjL-GbO=FFbAyn-OFm5te63zGwwBMAsGv7orGC+oBObb_w@mail.gmail.com>
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



On 8/9/24 12:53, Ilias Apalodimas wrote:
> On Wed, 7 Aug 2024 at 20:12, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> wget followed by bootefi currently fails as follows:
>>
>>  U-Boot> wget 200000 192.168.0.30:helloworld.efi
>>  Waiting for Ethernet connection... done.
>>  HTTP/1.0 200 OK
>>  Packets received 13, Transfer Successful
>>  Bytes transferred = 12720 (31b0 hex)
>>  U-Boot> bootefi 200000
>>  No UEFI binary known at 200000
>>  U-Boot>
>>
>> Fix the problem by adding the missing efi_set_bootdev() call.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  net/wget.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/net/wget.c b/net/wget.c
>> index 0e4dc5159d0..cf7681a4e79 100644
>> --- a/net/wget.c
>> +++ b/net/wget.c
>> @@ -8,6 +8,7 @@
>>  #include <command.h>
>>  #include <display_options.h>
>>  #include <env.h>
>> +#include <efi_loader.h>
>>  #include <image.h>
>>  #include <lmb.h>
>>  #include <mapmem.h>
>> @@ -429,6 +430,9 @@ static void wget_handler(uchar *pkt, u16 dport,
>>         case WGET_TRANSFERRED:
>>                 printf("Packets received %d, Transfer Successful\n", packets);
>>                 net_set_state(wget_loop_state);
>> +               efi_set_bootdev("Net", "", image_url,
>> +                               map_sysmem(image_load_addr, 0),
>> +                               net_boot_file_size);
> 
> Don't you need an unmap_sysmem() once this completes?

I wondered the same thing but where should the unmap call happen?
This pattern exists in boot/bootmeth_efi.c, cmd/load.c, fs/fs.c and net/tftp.c.
In this series I have blindly copied it into net/wget.c and net/lwip/wget.c and
net/lwip/tftp.c as well. It seems it does somthing in the sandbox only so do we
really care?

Thanks,
-- 
Jerome

> 
> Thanks
> /Ilias
>>                 break;
>>         }
>>  }
>> --
>> 2.40.1
>>
