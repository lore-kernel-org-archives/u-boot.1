Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8973FC4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 18:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6BB387E7F;
	Fri,  9 Feb 2024 19:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jBDMBRlb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDA5687E88; Fri,  9 Feb 2024 19:37:37 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F244187E7E
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 19:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 797E23F131
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707503851;
 bh=Qzsfs0kR7gb18TpirsEn4VIHvrqpqv/TNqCXOHygAyg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=jBDMBRlbmV7c4OIALsESHR95CFUmZl6rskvLchrfDfIZBluhS87+UHG4oljkdx2zT
 DhyrvjMLwTfVQufogig1Cpl4cDYQRrBd1QehcIK7PfZ3Muca4ktwabfRZ3xyM7c/CD
 pCH3IwC1Ojotgsv3t2P3ubvSoi0ru7HNXztTxhN71jy1w245D2sKEdbbVyUtnkWVmU
 2p6oA572ICC4EZmjg5/GUK2vWoPlWbfW8rnHft3ELvfRxb/re0Z1BQoCkyB00fmIoz
 JCIUZFX1VDTqsdIiFM0EMEqxh29jewcZB9slp3CZeNSIzbVt/ziZV/mvqvlux4dtnU
 5KWzMhf5Y36Ow==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a2f71c9f5d2so84136566b.2
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 10:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707503851; x=1708108651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qzsfs0kR7gb18TpirsEn4VIHvrqpqv/TNqCXOHygAyg=;
 b=eJo710BcvbiFwAYkYU59+Q05vA9K3wk9KF2agq4kbIfxkm2iFTJk0+Ps3vUTZ9Hm/3
 VWfITyBlHHEF5xiiMc7aIFcSOomfDlfr4scvQirwyGfO0SlxIlidLSd6BHmq/12cKAAZ
 O5Q3EnS4JA+SBVn1/2RpbIjr5u4eySgT6PuhzHp3tiu0NQK1jEw6HS9CZc5MRJdLtF7u
 xbg9hlmgumVPo1vJdEcMxtFIvVLVzKD3MSvdRrp93AxxKk6rhFz6/yuO5G2EcdJarXyi
 KbqT9iGaIEd3gmooaDEjz5VoUxwGAR+wv3sn2oMaxhCzv6t0mvdbzUptuCPkCJLsCcLg
 qzmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdpPp8LEECHnUr4LH9GABDv0q23QNOztFBa4ruQMbKDrboTvv8uxBlgAtvUgc7542aBHkVVVO4kef1HQ3Y22W7LiJlYw==
X-Gm-Message-State: AOJu0YyZw09ASolXaX8B0aUHYvHQhRNU50AGhOeRnO8aqfQY1Vfue/ZH
 J7pispFPNe/sJP87ZfZq6Y6XajkNSDK5faS2EF4+FAcsAhSSwuESBfQU3cqinm4gVD0nJUhEvka
 bDgiOS4Ev7EC6Nj55V/yRln9/sytru3Ab/+jFygE+9IGhTjkssN5UjdZ2W63JgniVSE0=
X-Received: by 2002:a17:906:bc47:b0:a3b:ec24:a7f8 with SMTP id
 s7-20020a170906bc4700b00a3bec24a7f8mr1954086ejv.34.1707503851088; 
 Fri, 09 Feb 2024 10:37:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGIhuQtOwzMVIirtAwZl+AnjQfxA98bkIRaXjU0NrFZvoJzftgQNDAnGhe8BbW8Wi1tqgIjA==
X-Received: by 2002:a17:906:bc47:b0:a3b:ec24:a7f8 with SMTP id
 s7-20020a170906bc4700b00a3bec24a7f8mr1954065ejv.34.1707503850687; 
 Fri, 09 Feb 2024 10:37:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXV4oNBOaQVFJftF1oSWjuSpvy1/YDe1sXptdTT0eMO+Ujo90K9diTUliYEJV2PfzhsrC3dWpF8tbBWOeXKk62FCRnpml1SVwp2TgtkL7m9JXn9+07I73VnRx2859GnOouo6KWPMXedTzc3Lj28VD6sJsKenEMQmg8T8Qg9LnnqwVrZdlSmuGEqM4uOG22j1Nx+D0UdKlgVzfLfpQUB
Received: from [192.168.123.81] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 lj8-20020a170907188800b00a3c04228478sm463816ejc.120.2024.02.09.10.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 10:37:30 -0800 (PST)
Message-ID: <97001fd9-1fbb-4f42-85fa-491660239ce5@canonical.com>
Date: Fri, 9 Feb 2024 19:37:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] smbios: fill wake-up type
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20240209155115.102957-1-heinrich.schuchardt@canonical.com>
 <20240209155115.102957-3-heinrich.schuchardt@canonical.com>
 <20240209181251.GO1152441@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240209181251.GO1152441@bill-the-cat>
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

On 2/9/24 19:12, Tom Rini wrote:
> On Fri, Feb 09, 2024 at 04:51:15PM +0100, Heinrich Schuchardt wrote:
> 
>> We should not use the reserved value 0x00 for the wake up type but
>> use 0x02 (Unknown).
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> [snip]
>> @@ -108,6 +108,16 @@ struct __packed smbios_type0 {
>>   	char eos[SMBIOS_STRUCT_EOS_BYTES];
>>   };
>>   
>> +#define SMBIOS_WAKEUP_TYPE_RESERVED		0x00
>> +#define SMBIOS_WAKEUP_TYPE_OTHER		0x01
>> +#define SMBIOS_WAKEUP_TYPE_UNKNOWN		0x02
>> +#define SMBIOS_WAKEUP_TYPE_APM_TIME		0x03
>> +#define SMBIOS_WAKEUP_TYPE_MODEM_RING		0x04
>> +#define SMBIOS_WAKEUP_TYPE_LAN_REMOTE		0x05
>> +#define SMBIOS_WAKEUP_TYPE_POWER_SWITCH		0x06
>> +#define SMBIOS_WAKEUP_TYPE_PCI_PME		0x07
>> +#define SMBIOS_WAKEUP_TYPE_AC_POWER_RESTORED	0x08
> 
> Shouldn't we do this as an enum these days?
> 

The field in the SMBIOS is of type u8 and cannot be an enum. Defining an 
enum would only make a difference if we had a function using it.

Do you want me to resend the patch with an enum?

Best regards

Heinrich
