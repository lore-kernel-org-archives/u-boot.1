Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EDDC982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 16:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6834840B02;
	Fri, 18 Sep 2026 16:25:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zRSQmlF_mwOZ; Fri, 18 Sep 2026 16:25:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E8A3540B65
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789748718;
	b=m9k7heCbD8jhBphm7Yc1xQH30q3ibPSVj1wX6UAzhacPWMrsRkN9SuTwLG4sweeSclxV
	 gwbYAbHH/ZY0fhTBOFdKick8KqmEz5e8aRXSMjFNVagdqrPtpz6bJtnAcYko0nYKtnCCa
	 mpxX2RkjRYBTsW3m5wmtHJqX4U/z67w/injKsYwT+lPKvZPSxPwq07ot+LZnJFVDQ5TMY
	 pru3iTOmlYtGBHSI2SLmeI3hJrT+1m0fxBlJIdg0T9ed2Q+ItyvglOSIjPgPxl9+3irkb
	 jmZtzGULGZ3JxSvbtmFc7ugsmp37kHhYrR5SzheI8rEP/N6FBlVxGg3Nnj/7DIhuocQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789748718;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ATgaoZpWBNx+09/GKo239nLzKyvylRy+xqhSgBZMoyc=;
	b=DN0s3wmVuVl/mQGEWC8FZ8CI+LZQvGhy/3JtvbAY5Yr3YRS+fGyycaGCvaEGmcyfYEfs
	 tmxBqLZIXWlcfp5LEiQg599jK4CYjOL7VzAwzoQwhnPLmrJdSy9vNm19O/vtgWwExvNLg
	 dtiJbR5d02gZDONnOtdCcN0mgUnKdS5jlJoBiup0w190tQKQ5PIGXn8epEbmymI0XRn9+
	 6dUY3iwojGMF4bFf+v31BQMwdfciyjvNdSOEH/ocJeAJw0wzGEzXo1M/HrYvDofU9AP5G
	 UfwMmZVPxlZEvqb6NRs3Dtc5SZmHq/rZrppqVz5aVoSflQY852KWhdNF/E5Fpzr6XrA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dn2skM0t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789748718;
	bh=ATgaoZpWBNx+09/GKo239nLzKyvylRy+xqhSgBZMoyc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LOdYi4IBlmDbniS+V/gSxC4OVmQUlL/TzAz8BcAT4naAUNLoav5KMXFTrMGQXaW5x
	 nEjRVd3/41pzi6ToK8pq0mEW08M+aqsDNmEzH6IxawcoYDNZPphhPhwK+Puestg6zE
	 NYDUxMW2fm+dLZevBg9ZYvcZa+ewIQBxcbqG52BGqtyqM1BI4YMYNSIo5JXMB9pOu+
	 O5YEm4T5RbYzf67z5/9wzUqnPCS2WYjgWIJoOxdts+QQ2C8ksaGasl65l8HmczS8eN
	 m33/8GxbCqZbyrEB4xblAxkQE7SzXioE0mARtDKRr7FenTQsNLJnzm3PfZpDmj3ZlZ
	 BEDZHO4rY/FTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8A3540B65;
	Fri, 18 Sep 2026 16:25:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6860723F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65AC140B65
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:25:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hDhH12hLXcx3 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 16:25:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 17A5B40B02
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789748715;
 b=qCT8WZholfKTWoAccGqdEPBxaZhWjYxUa6YclBibS86jQUzdGWH07Nvas/YbNfV2aLIJ
 Z8T1+YvOBuTPmF9DWJmyj9cvu23s1D0uXwF1p5cP6iHlAzGvCdZhARCn21o1CNR2rfo8F
 +wmxiTG3rNfNfQ3qvy84RXWbyeefgk85b4YqXsCYef3S4lRqdxreIBDAC/Qvg5gT3omoP
 1HWsCY9D7/aH4oayAMg2enk7eCdeRajJSpWfKwhxBAxybJ+3qO8aExYYNYF1vmESJeaD4
 DVWUiRIKFy70mbn46TnoQjNnWMePHsTL+EvlZgEx7wUZpJ8Y9Mpo4aAUbdFQPryWRvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789748715;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=ATgaoZpWBNx+09/GKo239nLzKyvylRy+xqhSgBZMoyc=;
 b=dhpvdK8XkOkYPXb+UcdvKmFFBlNrZA1S8Y+EWxWkfPwWxwO8tLkMEWZ+S3gJ7hKiB3QL
 TUpbn9LnjzNUEuTp2NCprjX8R/aABuEiINvZTCi1nk38T31CkJjXw0owUOpzq2zPLMdvi
 puhFpGwymdM4EDTXMknNMfEJG3cl7wRisnLZ4zvFyLI3IsGJISJwYr3KfIVBvk8fRlAB5
 f5V4P2/e9zviGjD9oL5rK9JISYwXPQ/UX24baRx/tvwu3w1Tcydt35T9jUkdAVjsH9ErN
 x1Vm26VloimzISEG/BADVWy7JPECzFi/XrmSX44otmy6Pk2Nx26nED4jaHA2XMxIpKw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dn2skM0t; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dn2skM0t
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17A5B40B02
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:25:12 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633ecdeso900299f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789748710; x=1790353510;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ATgaoZpWBNx+09/GKo239nLzKyvylRy+xqhSgBZMoyc=;
 b=dn2skM0tSUm3NmRlLJH+zuBJPe8c0usK+Zp9/nSNNvAuqMVkU2RHN7ki29Mn2qfofe
 c+e+R2lKe5tp3+srlqay4Dbl8tyx9TaGNS65MMhOEN6UsaaL0fMeR0XJxna6MKZhgbV/
 f7/NTke3TNuizI+9Dgv9eMfwml6PPlYdR6vYV48rQS9Skwii9V/J9oqHstSPtnTNmyK0
 6StzkyPYZ79mHdROsXZYYLG5JunRL0jz3v1m742OugFXNKA8lcz/S8BwC2dVJFydUBi4
 pgk94QnzZxA68Ql4JtnGmNtnDSZQV6pQY/iCpuavHfpxij1+Imfp5jQEPkY6RTsrwVeO
 Nraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789748710; x=1790353510;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ATgaoZpWBNx+09/GKo239nLzKyvylRy+xqhSgBZMoyc=;
 b=yJmwVFhv9dGCYVetA2u+oQV8qQslAQ/RgwG5loHXVn4NaYS9ZA8CPJgCtC6Va4R84M
 7KpGDt2rE1qcvt/auwlebdHR8wHPqcjei+iwD5tdaF11BK4pzV4OJmKNekQOO/5s09oU
 FlZLcRRw71Elxwdg6ZR+m6D0jJ//VgmGnT6/M+GOcKWHmwKJy/bwqSlxSiqfvVseRFB8
 LfpHVEP+d40xmW7U73/dwyNcSK4QdEnBE4+p+WPSZYaqz+DbWOqYvcN7oeEFy3o1aswN
 hwNbWQHJqoHRHYdi/8YJBb5sblSWVH3YTWq8QcDYMQTL64ATyiI0tcOzcvW+R4HsZbyJ
 ODqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxm79cnQtsyHg3BPY/E8IFRU1Z3ANMEZrLqO5npIFuqrYkWTRtAsN3fl+SviuTLuPmyY6a7s1U=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lwSutowgxKsV/4TwQZZOvon5JIKsrwLuCDPXxN4jByEDhCKoxx
 U4iLggJH/w3usyssbTGi4edHCDKSeC3HYjMOqmWPzpi9/kZfIDP1qR5i4eOwcBZlRCvxErIoNWQ
 aKm3Yyog=
X-Gm-Gg: AYBFou2skntDZ0LWPlcRXoc/ns43ijulc6am+PiN5bfGJddjO28ArnsYHVumP4NhF3J
 DOifajCJIsCbgAWkAWTeUmD8iPeylPIpsbyBqFhIwbKsTynFhvegGRmh7ZrSGVYbnFfapOZoiVW
 HMGrBiyjWTPm0doe+JYTyYeib9hwE+SmgieY6mw+T3Ghz04xbiCd0OUWq9XoAqq6ukt8G2EfeMA
 yZchGtrmW/xudcZFIImZULa+eLFvV+ucsJYtmehQxbyN+1jg756oxu135doST6SB0PRxvK7YkOK
 vy+8omtycmEB6JPv/jVcz+qpuBqkBiOHvjx8nsc+MhRJibMO7F21y0A+jz2Bo+EYackVZqNeZB1
 R33bruRlFY6pTGyq81Z4Bp40GYzZngBHIUtWlY/kXYy7XFFNVF0vo3XZ2FXHSg9PBKAafs9470y
 8t478pyrpmNs8RtQYFDuctWKUKdoBnmGvpz5OKddFKoTIATzePF7uJUT42bO7Zv2THb8gGaaVpo
 D83rf7P5GR3rqPQTtXq
X-Received: by 2002:a05:6000:2884:b0:487:360:5be1 with SMTP id
 ffacd0b85a97d-4871e2112femr4560760f8f.8.1789748709998; 
 Fri, 18 Sep 2026 09:25:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e50:3860::642d:5bda?
 ([2a01:e0a:e50:3860::642d:5bda]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4871ff5605dsm4962769f8f.19.2026.09.18.09.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 09:25:09 -0700 (PDT)
Message-ID: <34d17332-b903-479f-ba72-af02ed33c762@baylibre.com>
Date: Fri, 18 Sep 2026 18:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fastboot: block: add 'oem set-block-target' command and
 runtime override
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>, 
 u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Neil Armstrong <neil.armstrong@linaro.org>
References: <20260917-series2-fastboot-block-target-v1-1-fc8328bc2d12@oss.qualcomm.com>
 <487435d1-9d9d-4e18-a2a6-ed631760fc25@baylibre.com>
 <009abac6-415f-4848-a41c-d8c79f7bcb6b@oss.qualcomm.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <009abac6-415f-4848-a41c-d8c79f7bcb6b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi ,

Thanks for clarification,

Le 17/09/2026 à 19:01, Vandhiadevan Karunamoorthy a écrit :
> Hi Guillaume,
>
> On 9/17/2026 5:59 PM, Guillaume La Roque wrote:
>> Hi,
>>
>> Probably a stupid question but in your commit message you speak about 
>> SPI-NOR  but fastboot support flash spi , why not enable it or update 
>> it if it's not exactly work as you want instead of create a new 
>> command ? 
>
> This patch is not intended to add SPI-NOR support itself. I have a 
> separate change that exposes SPI-NOR through the MTD Fastboot backend.
>
> The purpose of this patch is to allow switching the generic block 
> Fastboot backend between different storage interfaces at runtime. On 
> some platforms multiple Fastboot-capable storage devices can coexist, 
> for example a default SCSI/UFS device and an SPI-NOR device exposed 
> through the MTD block uclass.

to not create a new command it's possible to just use 
fastboot_raw_partition_*[1] variable extend it to support spi or block 
fastboot support , actually only missing part is to parse this variable 
properly to  know in which FASTBOOT_FLASH_XXX use it.

or an other solution will be to extend series on flash[2] command to 
give possibility to select block device/interface to flash on flash 
command : for example fastboot flash mtd:0 bootloader XXX

you do a lot of patch to add some new oem command on fastboot not sure 
it's always the good solution for all , just my opinion .

finally you do this jsut because fastboot not work properly when you 
enable multiple FASTBOOT_FLASH_XXX Config.

[1] : 
https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-descriptors

[2] : 
https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/


Regards,
Guillaume

>
> Today the block backend is selected through the build-time
> CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME and
> CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID settings, so only a single target
> can be accessed during a Fastboot session. The OEM command allows
> changing the active interface/device at runtime and accessing either
> storage device without rebuilding or restarting Fastboot.
>
> SPI-NOR was mentioned only as an example use case for a runtime-selected
> target rather than as a replacement for existing Fastboot SPI/MTD
> support. 
>
> Thanks,
> Vandhiadevan
> ``
>
>>
>> Thanks
>> Guillaume
>>
>> Le 17/09/2026 à 11:01, Vandhiadevan Karunamoorthy a écrit :
>>> Add fastboot_block_set_target() so an OEM command can point the
>>> generic block fastboot backend at a different interface/device at
>>> runtime, without requiring a rebuild. Falls back to the existing
>>> build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME/
>>> CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults when no override is
>>> set.
>>>
>>> Expose this to fastboot clients via a new "oem set-block-target
>>> <interface> [device]" command, gated behind
>>> CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET (depends on
>>> CONFIG_FASTBOOT_FLASH_BLOCK).
>>>
>>> This is needed to target storage devices, such as SPI-NOR exposed
>>> through the MTD block uclass, that aren't known until runtime or
>>> that coexist with another default block interface on the same
>>> board.
>>>
>>> To: u-boot@lists.u-boot-project.org
>>> To: u-boot@lists.denx.de
>>> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Cc: Dmitrii Merkurev <dimorinny@google.com>
>>> Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
>>> Cc: Heiko Schocher <hs@nabladev.com>
>>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>>>
>>> Signed-off-by: Vandhiadevan Karunamoorthy 
>>> <vandhiadevan.karunamoorthy@oss.qualcomm.com>
>>> ---
>>> This series lets a fastboot client redirect the generic block
>>> fastboot backend (CONFIG_FASTBOOT_FLASH_BLOCK) to a different
>>> interface/device at runtime, instead of being fixed to the
>>> build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
>>> CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults.
>>>
>>> This is useful for storage devices that aren't known until runtime,
>>> or that coexist with another default block interface on the same
>>> board -- for example, SPI-NOR exposed through the MTD block uclass
>>> (see the companion "mtd: spi: Expose SPI-NOR as a GPT-capable MTD
>>> block device" series).
>>>
>>> The patch adds fastboot_block_set_target() to the generic block
>>> backend, plus a new "oem set-block-target <interface> [device]"
>>> fastboot command (gated behind
>>> CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET, which depends on
>>> CONFIG_FASTBOOT_FLASH_BLOCK) that lets a client invoke it.
>>> ---
>>> Depends on: [PATCH v6 0/8] arm: snapdragon: Add snagboot support for 
>>> Lemans-EVK
>>> Link: 
>>> https://lore.kernel.org/u-boot/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com/
>>> Depends on: [PATCH v2 0/4] fastboot: block: Add GPT/MBR and device 
>>> selection
>>> Link: 
>>> https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/
>>> ---
>>>   drivers/fastboot/Kconfig      | 11 +++++++
>>>   drivers/fastboot/fb_block.c   | 75 
>>> ++++++++++++++++++++++++++++++++++++-------
>>>   drivers/fastboot/fb_command.c | 51 +++++++++++++++++++++++++++++
>>>   include/fastboot.h            |  1 +
>>>   include/fb_block.h            |  9 ++++++
>>>   5 files changed, 136 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>>> index a4539844d89..c7e0509eaad 100644
>>> --- a/drivers/fastboot/Kconfig
>>> +++ b/drivers/fastboot/Kconfig
>>> @@ -225,6 +225,17 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>>>         Device identifiers are numbered starting from 0 and the most
>>>         common case is to use the first controller on the system.
>>>   +config FASTBOOT_CMD_OEM_SET_BLOCK_TARGET
>>> +    bool "Enable the 'oem set-block-target' command"
>>> +    depends on FASTBOOT_FLASH_BLOCK
>>> +    help
>>> +      Add support for the "oem set-block-target" command from a 
>>> client.
>>> +      This allows switching the block interface (e.g. scsi, mtd) and
>>> +      device number used by the fastboot "flash"/"erase" commands at
>>> +      runtime, instead of relying solely on the
>>> +      CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
>>> +      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID build-time defaults.
>>> +
>>>   config FASTBOOT_GPT_NAME
>>>       string "Target name for updating GPT"
>>>       depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && 
>>> EFI_PARTITION
>>> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
>>> index a8c74e35d0d..d3e5f6ed1f3 100644
>>> --- a/drivers/fastboot/fb_block.c
>>> +++ b/drivers/fastboot/fb_block.c
>>> @@ -125,6 +125,66 @@ static lbaint_t fb_block_sparse_reserve(struct 
>>> sparse_storage *info,
>>>       return blkcnt;
>>>   }
>>>   +/**
>>> + * block_interface_override - runtime-set block interface name, 
>>> empty if unset
>>> + */
>>> +static char block_interface_override[16];
>>> +/**
>>> + * block_device_override - runtime-set block device number, -1 if 
>>> unset
>>> + */
>>> +static int block_device_override = -1;
>>> +
>>> +/**
>>> + * fb_block_interface() - Resolve the block interface name to use
>>> + *
>>> + * Returns the runtime override set via fastboot_block_set_target() 
>>> if one
>>> + * is active, otherwise falls back to the build-time config default.
>>> + */
>>> +static const char *fb_block_interface(void)
>>> +{
>>> +    if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
>>> +        return NULL;
>>> +
>>> +    if (block_interface_override[0])
>>> +        return block_interface_override;
>>> +
>>> +    return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>>> +                  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, NULL);
>>> +}
>>> +
>>> +/**
>>> + * fb_block_device() - Resolve the block device number to use
>>> + *
>>> + * Returns the runtime override set via fastboot_block_set_target() 
>>> if one
>>> + * is active, otherwise falls back to the build-time config default.
>>> + */
>>> +static int fb_block_device(void)
>>> +{
>>> +    if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
>>> +        return -1;
>>> +
>>> +    if (block_device_override >= 0)
>>> +        return block_device_override;
>>> +
>>> +    return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>>> +                  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
>>> +}
>>> +
>>> +int fastboot_block_set_target(const char *interface, int device)
>>> +{
>>> +    if (interface) {
>>> +        if (strlen(interface) >= sizeof(block_interface_override))
>>> +            return -EINVAL;
>>> +        strlcpy(block_interface_override, interface,
>>> +            sizeof(block_interface_override));
>>> +    }
>>> +
>>> +    if (device >= 0)
>>> +        block_device_override = device;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   /**
>>>    * parse_device_partition() - Parse and validate device:partition 
>>> format
>>>    * @part_name: Input string in format "N:partition" or "partition"
>>> @@ -140,8 +200,7 @@ static int parse_device_partition(const char 
>>> *part_name, int *device,
>>>   {
>>>       const char *colon_pos;
>>>   -    *device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>>> -                     CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
>>> +    *device = fb_block_device();
>>>         /* Check for colon in partition name */
>>>       colon_pos = strchr(part_name, ':');
>>> @@ -190,9 +249,7 @@ int fastboot_block_get_part_info(const char 
>>> *part_name,
>>>                    char *response)
>>>   {
>>>       int ret;
>>> -    const char *interface = 
>>> config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>>> - CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
>>> -                           NULL);
>>> +    const char *interface = fb_block_interface();
>>>       int device;
>>>       const char *partition_name;
>>>   @@ -385,9 +442,7 @@ void fastboot_block_flash_write(const char 
>>> *part_name, void *download_buffer,
>>>   #if CONFIG_IS_ENABLED(EFI_PARTITION)
>>>       if (is_partition_table_name(part_name, 
>>> CONFIG_FASTBOOT_GPT_NAME)) {
>>>           int device;
>>> -        const char *interface = 
>>> config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>>> - CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
>>> -                               NULL);
>>> +        const char *interface = fb_block_interface();
>>>             parse_device_partition(part_name, &device, NULL);
>>>           fastboot_flash_gpt_partition_table(interface, device,
>>> @@ -399,9 +454,7 @@ void fastboot_block_flash_write(const char 
>>> *part_name, void *download_buffer,
>>>   #if CONFIG_IS_ENABLED(DOS_PARTITION)
>>>       if (is_partition_table_name(part_name, 
>>> CONFIG_FASTBOOT_MBR_NAME)) {
>>>           int device;
>>> -        const char *interface = 
>>> config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>>> - CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
>>> -                               NULL);
>>> +        const char *interface = fb_block_interface();
>>>             parse_device_partition(part_name, &device, NULL);
>>>           fastboot_flash_mbr_partition_table(interface, device,
>>> diff --git a/drivers/fastboot/fb_command.c 
>>> b/drivers/fastboot/fb_command.c
>>> index 18d86988f4c..235fae74fee 100644
>>> --- a/drivers/fastboot/fb_command.c
>>> +++ b/drivers/fastboot/fb_command.c
>>> @@ -45,6 +45,7 @@ static void oem_partconf(char *, char *);
>>>   static void oem_bootbus(char *, char *);
>>>   static void oem_console(char *, char *);
>>>   static void oem_board(char *, char *);
>>> +static void oem_set_block_target(char *, char *);
>>>   static void run_ucmd(char *, char *);
>>>   static void run_acmd(char *, char *);
>>>   @@ -120,6 +121,11 @@ static const struct {
>>>           .command = "oem board",
>>>           .dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, 
>>> (oem_board), (NULL))
>>>       },
>>> +    [FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET] = {
>>> +        .command = "oem set-block-target",
>>> +        .dispatch = 
>>> CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_SET_BLOCK_TARGET,
>>> +                          (oem_set_block_target), (NULL))
>>> +    },
>>>       [FASTBOOT_COMMAND_UCMD] = {
>>>           .command = "UCmd",
>>>           .dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, 
>>> (run_ucmd), (NULL))
>>> @@ -589,3 +595,48 @@ static void __maybe_unused oem_board(char 
>>> *cmd_parameter, char *response)
>>>   {
>>>       fastboot_oem_board(cmd_parameter, (void *)fastboot_buf_addr, 
>>> image_size, response);
>>>   }
>>> +
>>> +/**
>>> + * oem_set_block_target() - Execute the OEM set-block-target command
>>> + *
>>> + * @cmd_parameter: Pointer to "<interface> [device]" command parameter
>>> + * @response: Pointer to fastboot response buffer
>>> + *
>>> + * Switches the block interface (e.g. "scsi", "mtd") and, optionally,
>>> + * device number used by the fastboot block backend at runtime.
>>> + */
>>> +static void __maybe_unused oem_set_block_target(char 
>>> *cmd_parameter, char *response)
>>> +{
>>> +    char interface[16] = { 0 };
>>> +    int device = -1;
>>> +    char *space;
>>> +
>>> +    if (!cmd_parameter) {
>>> +        fastboot_fail("Expected command parameter", response);
>>> +        return;
>>> +    }
>>> +
>>> +    space = strchr(cmd_parameter, ' ');
>>> +    if (space) {
>>> +        size_t len = space - cmd_parameter;
>>> +
>>> +        if (len >= sizeof(interface)) {
>>> +            fastboot_fail("interface name too long", response);
>>> +            return;
>>> +        }
>>> +        memcpy(interface, cmd_parameter, len);
>>> +        interface[len] = '\0';
>>> +        device = simple_strtoul(space + 1, NULL, 10);
>>> +    } else {
>>> +        if (strlen(cmd_parameter) >= sizeof(interface)) {
>>> +            fastboot_fail("interface name too long", response);
>>> +            return;
>>> +        }
>>> +        strlcpy(interface, cmd_parameter, sizeof(interface));
>>> +    }
>>> +
>>> +    if (fastboot_block_set_target(interface, device))
>>> +        fastboot_fail("invalid interface name", response);
>>> +    else
>>> +        fastboot_okay(NULL, response);
>>> +}
>>> diff --git a/include/fastboot.h b/include/fastboot.h
>>> index b106d617749..13dcdf919bc 100644
>>> --- a/include/fastboot.h
>>> +++ b/include/fastboot.h
>>> @@ -51,6 +51,7 @@ enum {
>>>       FASTBOOT_COMMAND_OEM_RUN,
>>>       FASTBOOT_COMMAND_OEM_CONSOLE,
>>>       FASTBOOT_COMMAND_OEM_BOARD,
>>> +    FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET,
>>>       FASTBOOT_COMMAND_ACMD,
>>>       FASTBOOT_COMMAND_UCMD,
>>>       FASTBOOT_COMMAND_COUNT
>>> diff --git a/include/fb_block.h b/include/fb_block.h
>>> index 189c708e2f0..fd981d95316 100644
>>> --- a/include/fb_block.h
>>> +++ b/include/fb_block.h
>>> @@ -102,4 +102,13 @@ void fastboot_block_write_sparse_image(struct 
>>> blk_desc *dev_desc, struct disk_pa
>>>   void fastboot_block_flash_write(const char *part_name, void 
>>> *download_buffer,
>>>                   u32 download_bytes, char *response);
>>>   +/**
>>> + * fastboot_block_set_target() - Override block interface/device at 
>>> runtime
>>> + *
>>> + * @interface: New interface name (e.g. "scsi", "mtd"), or NULL to 
>>> leave unchanged
>>> + * @device: New device number, or -1 to leave unchanged
>>> + * Return: 0 on success, -EINVAL if interface name too long
>>> + */
>>> +int fastboot_block_set_target(const char *interface, int device);
>>> +
>>>   #endif // _FB_BLOCK_H_
>>>
>>> ---
>>> base-commit: 4d3823469724bca19ba4ed3a5a38fc8e951775e2
>>> change-id: 20260824-series2-fastboot-block-target-c8e9418babdf
>>>
>>> Best regards,
>>> -- 
>>> Vandhiadevan Karunamoorthy 
>>> <vandhiadevan.karunamoorthy@oss.qualcomm.com>
>>>
>>

