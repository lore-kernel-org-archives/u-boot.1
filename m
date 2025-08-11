Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416D9C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 07:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 596EC832FE;
	Mon, 11 Aug 2025 09:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PW4oxqAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B27183321; Mon, 11 Aug 2025 09:27:10 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2DC0830B3
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 09:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 22A453F169
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 07:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1754897227;
 bh=4rc8UdxahP3nli6NIgHnl9pT0QgGmB5/Uh3uxx7wur0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=PW4oxqAZXD/tEv3mUuAvSjKKhmwfraUUeYPt1hgrSzsSG68Zbvxa5nD1F8Iq6Uy2E
 C9Yr8Efhdxm3zG//5ZPDT4jD53+L0/Gj3isEjfbUZQ0dKy+7dJ+Wzvok7Xd4ABLjQx
 69SeS59gWxmCLpQOX//SCa86KCZMUOKANp9JAPvlcy9BuEhnez44n99zNhyBsW++5Z
 VB+K8i7G+13BVz9veBnENn4A/5xzP9fOmwgCDoc31SAA93xJq/KNyLZyoEBX689mdk
 temh7zH1Y0BDGr+immtTaXaiSalvcgd81+Uk/VsIqLttJ6SVrhM4QM8hs61FTeZ4xP
 a2mTrvC9Yw3KA==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b7851a096fso2967218f8f.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 00:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754897227; x=1755502027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4rc8UdxahP3nli6NIgHnl9pT0QgGmB5/Uh3uxx7wur0=;
 b=c6u7U14PtdKexmaJi2Zhzxr46krhEekUF6zakJaanI0rybfBDVU7xnLK6ZIO7ZvvTs
 atXAb5/QJC0xNumS+Kd6ILY1D/isEvoZpxOg13SNo9fC2YTNuSeCCvRhKEHwpx2UNNRu
 eCEviqLo2R9Zsw6SydSlnFoS4eijsPAOQZ0NC1vULcPaZqTJVVQHa+vUOmR3Xsdgn+Nk
 Huid/hDyN4GC10HfMzEv+igHqn9b3U5jUyxEXulS0GhKKUXT4fEsPwbD0e5SNnCW3Lun
 HhrL35py0xQ1E7REVMejR3HKI5Rvy908WqLeuvr5v3QPVigGGbzxFHkshWbNBt0RTxAz
 zDkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2F8HSi3X1z4ZwSsFV96NOIRA6rOgC56SgVC5nci0Igcm4LxGyfJdBPoyP27ScyreJDZGnTTI=@lists.denx.de
X-Gm-Message-State: AOJu0YzrYYwUdFbWZSX/wk556O+kcf+fZyjLqTHGnD6AiTnQ78c0dRbN
 cJ/Hfoc34PgL26j+seLDpcfw2TTDCeLuLJc/iL7M8MvCEQGNSA+ClCSdU4uFmCbfWEnq7gI+XCH
 BxVFBRem9HxfYQkz42I7vsyajq3WYTwL3LisfiuWbz0QWNOrIWyBGqPzneDJ8+GiWuBlE69s=
X-Gm-Gg: ASbGncv0ywGnwa8sMeBqYsJCgrlYtdF30pmbZdFxnSrY+bkhuaG3gag7unZ3K/6OPG2
 e0DOb3xoTckgLTTzKwW1Fm6FTmUSgeW9/dbJhTelzOwqr+e3g6QajWtLpK8JZx+whQjZDcLLD+Y
 bTezYHZiBt2Lp9tKxGSe8bjPUSqxsli2IutmZHp7N6kQfzaiFUhq0qAqUklMm922jiA9Dd1Xy+5
 IBvufF7BaWwPSbKI251KrQw3SaUy1Km0yasQwdCOO4+uiQ1f9BatbBbgquEs56q32KlndVxPTiO
 +wWfPI6SpLDEnHlm8mmDoCdr6BHko09SkWTh+rUXmXlBPluB7Z/77WJeYrWKgqOCg80/hnaNxlA
 WfGDZEc/7CSmnaMPGnTDag3koGt0nTwNkDJZ2
X-Received: by 2002:a05:6000:4202:b0:3b7:8a49:eee9 with SMTP id
 ffacd0b85a97d-3b900929b36mr8528177f8f.8.1754897226651; 
 Mon, 11 Aug 2025 00:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHumwkRMys7K+4zzf/BiU+Eh0A7rxzjPLQpnjwzv4IYfzpYAnONMaPiS2BQ2MkErV1wNuz8nA==
X-Received: by 2002:a05:6000:4202:b0:3b7:8a49:eee9 with SMTP id
 ffacd0b85a97d-3b900929b36mr8528150f8f.8.1754897226012; 
 Mon, 11 Aug 2025 00:27:06 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459de0d4cf1sm304960365e9.13.2025.08.11.00.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 00:27:05 -0700 (PDT)
Message-ID: <91af5ee7-21c9-4a1e-9a0d-eef5be2fc154@canonical.com>
Date: Mon, 11 Aug 2025 09:27:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] starfive: fix return code of `mac write_eeprom`
To: E Shattow <e@freeshell.de>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, 
 Yanhong Wang <yanhong.wang@starfivetech.com>, u-boot@lists.denx.de,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
References: <20250809082155.6929-1-heinrich.schuchardt@canonical.com>
 <e6f1cb27-371c-44ef-b7ec-3f348ca0a085@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <e6f1cb27-371c-44ef-b7ec-3f348ca0a085@freeshell.de>
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

On 11.08.25 05:16, E Shattow wrote:
> 
> 
> On 8/9/25 01:21, Heinrich Schuchardt wrote:
>> When writing the EEPROM fails, the command usage help text is displayed
>> after the error message. We should only display the error message instead.
>>
>> If writing the EEPROM fails, return CMD_RET_FAILURE (1) instead of
>> CMD_RET_USAGE (-1).
>>
>> Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   board/starfive/visionfive2/visionfive2-i2c-eeprom.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>> index 010e386e64d..17a44020bcf 100644
>> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>> @@ -275,7 +275,7 @@ static int prog_eeprom(unsigned int size)
>>   
>>   	if (is_match_magic()) {
>>   		printf("MAGIC ERROR, Please check the data@%p.\n", pbuf.buf);
>> -		return -1;
>> +		return CMD_RET_FAILURE;
>>   	}
>>   
>>   	ret = i2c_get_chip_for_busnum(CONFIG_SYS_EEPROM_BUS_NUM,
>> @@ -285,7 +285,7 @@ static int prog_eeprom(unsigned int size)
>>   	if (ret) {
>>   		printf("Get i2c bus:%d addr:%d fail.\n", CONFIG_SYS_EEPROM_BUS_NUM,
>>   		       CONFIG_SYS_I2C_EEPROM_ADDR);
>> -		return ret;
>> +		return CMD_RET_FAILURE;
>>   	}
>>   
>>   	for (i = 0, p = (u8 *)pbuf.buf; i < size; ) {
>> @@ -314,11 +314,11 @@ static int prog_eeprom(unsigned int size)
>>   	if (ret) {
>>   		has_been_read = -1;
>>   		printf("Programming failed.\n");
>> -		return -1;
>> +		return CMD_RET_FAILURE;
>>   	}
>>   
>>   	printf("Programming passed.\n");
>> -	return 0;
>> +	return CMD_RET_SUCCESS;
>>   }
>>   
>>   /**
> 
> This patch is a good start, but I think maybe more is needed? Quoting
> the notes I wrote for myself last year:
> 
> "
> mac command:
> 
> if data did not change then "Programming passed." is printed regardless
> of write protect state but no action was taken and no usage help is
> printed. 'mac' still outputs in-memory info.
> 
> when data was changed the command shows "Programming failed." or
> "Programming passed." followed by usage help and 'mac' command shows no
> output until 'mac read_eeprom'.
> 
> Suggested:
> 
> If data did not change at time of 'mac eeprom_write' then it should
> still try to write so the message pass/fail will be correct.
> The usage info following 'mac write_eeprom' is a bug, should not be printed.

Thank you for reviewing.

The EEPROM driver does the right thing. If data is not changed, do not 
write. This avoids wear.

We would have to keep a second copy of the EEPROM contents when reading 
if we wanted to observe that no change was done.

This is beyond the scope of the current patch.

> 
> prog_eeprom return values inconsistent with command.h
> 
> prog_eeprom returns -1 which overlaps with CMD_RET_USAGE
> should be 1 for failure

This is covered by the current patch.

> 
> show_eeprom()
> 
> Print a message "No valid data. Please do mac read_eeprom".
> Maybe "Read nnn bytes from EEPROM" and "Displaying local copy of EEPROM
> from memory" to be more clear.

show_eeprom() already checks the value of variable has_been_read and 
doesn't display the EEPROM content if it is not set. A message could be 
added in this case.

But the EEPROM is read before reaching the coammand line if 
CONFIG_ID_EEPROM=y:

common/board_r.c:732:   INITCALL(mac_read_from_eeprom);

Therefore we typically don't observe has_been_read=0 when executing the 
mac command.

Best regards

Heinrich

> "
> 
> Acked-by: E Shattow <e@freeshell.de>

