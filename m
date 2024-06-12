Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93F5C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 14:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38ADF88191;
	Wed, 12 Jun 2024 16:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="HGNdmX5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713178824C; Wed, 12 Jun 2024 16:47:17 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 001D888191
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 16:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ebd421a931so47458991fa.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1718203634; x=1718808434;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TIokQ3dNoXrvYF5WC5GiAhb4oCrCGi5X+u9DI9cyFcA=;
 b=HGNdmX5aGf1NaBXFZtukfhu4vf1uQaiHTEWWufe9HybU8VQxlrkU0BcbFIKttmDxsb
 SLi5fQPahYJXEAriNOUKC6lztDmNHyf8GjpgJkzJAgLD66wRO6zDYGvgiRITpey01giH
 wXePW0dHtQSNf4ZKB31eeAbaF3EtwQYSS6Kqa2if+50fztp3HMmgcgjXkDRhq4SlFqZx
 KLUmcArkv5X0odpie4N74mcQGMlpNLX/8ZasJ5OXT1Vs4PmM31tMuH/Sn17OWJbub0CV
 8zrCj0j31u9R7tUoObYtRKwoZl3WMUHDJIrJXAV48CTy6yaq2O8rF6OydbdhsOOrBz/i
 LA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718203634; x=1718808434;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TIokQ3dNoXrvYF5WC5GiAhb4oCrCGi5X+u9DI9cyFcA=;
 b=Y+BB1XTVpPiTVUytLepAQTvEOD31OXxsUn6aZv0RnceALVEgeCO+0zEKt/14uTZTBG
 05LlJcYjowL2uwh4CNCa7LjObBUThQPsGsvWseC3LyKRyYDq8hVvZ/jKKHsUVWwQO8Vn
 sPKZnNuBNrZ2jv67ACme5x8hIU4jk12F+A7CK/H1Ato1NqYMz0srAlJDUJbdbuGqch3S
 3/RqJbWhHYGxtCc8/45QjrvarzIGEl3hucFQLRofYJKjfWvejUOczJd9vyhgSVytNXDX
 eqf87sOKI89yquJtHlFDN+O3n/iRvtaczbxubtGAaRvz5FctKVfdM7DD7SJN5/EUuKd7
 Is1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVomHAjchGd8TqrEWw+rTBbm2481Fajbl0WPTxJ0ne7bsK/89Dy0u4BS8LZB/UjncokSSElYOb19GWaOSMchOoyf4CXZA==
X-Gm-Message-State: AOJu0YwIU+wz2yqk/Is+RWR29aWMHz2djj+MDSCRn6HcS9uer0Ut7YoT
 Z9ay0rgxlK+W7I/OVZfa1FE9I25N/osPb7qC/UnhyqQOpAe66BXKLtMkdG6xUhrcjjM1n/Hi9fH
 0dw==
X-Google-Smtp-Source: AGHT+IEH7JBfI+D6+sCQdEKqQa4tzOXhXSToFhUP7xMmA+ZNMGQKtKgCRfhMdj2d9F2kQgcjmE62Og==
X-Received: by 2002:a2e:9906:0:b0:2eb:dc13:2d6b with SMTP id
 38308e7fff4ca-2ebfc8d5c79mr12865981fa.13.1718203633987; 
 Wed, 12 Jun 2024 07:47:13 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c9d5e29e9sm2400837a12.2.2024.06.12.07.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 07:47:13 -0700 (PDT)
Message-ID: <48dc217d-f5ca-4ba0-b174-18b4ba6ac0d8@monstr.eu>
Date: Wed, 12 Jun 2024 16:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] xilinx: Add option to load environment from
 outside of
To: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>,
 "vassilisamir@gmail.com" <vassilisamir@gmail.com>
Cc: "michal.simek@amd.com" <michal.simek@amd.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "santoshsagar.algapally@amd.com" <santoshsagar.algapally@amd.com>,
 "LPolak@arri.de" <LPolak@arri.de>,
 "venkatesh.abbarapu@amd.com" <venkatesh.abbarapu@amd.com>,
 "sr@denx.de" <sr@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20240603164738.437834-1-vassilisamir@gmail.com>
 <CAHTX3d+mD+iqJ-+N4W+y5XVUozVqq-n19-zRBBT5BqDs3BpJAg@mail.gmail.com>
 <482398653f2b41292c056eb67077ca29f0b9a7ae.camel@cern.ch>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <482398653f2b41292c056eb67077ca29f0b9a7ae.camel@cern.ch>
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



On 6/12/24 15:57, Vasileios Amoiridis wrote:
> On Wed, 2024-06-12 at 15:42 +0200, Michal Simek wrote:
>> Hi Vasileios,
>>
>> út 4. 6. 2024 v 15:21 odesílatel Vasileios Amoiridis
>> <vassilisamir@gmail.com> napsal:
>>>
>>> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
>>>
>>> Changes in v2:
>>>          - Remove duplication of custom hardcoded env_locations[]
>>> code.
>>>          - Add implementation with general arch_env_get_location(op,
>>> prio)
>>>
>>> v1:
>>> https://lore.kernel.org/u-boot/20240522174738.73522-1-vassilisamir@gmail.com/
>>>
>>> Vasileios Amoiridis (1):
>>>    xilinx: Add option to load environment from outside of boot media
>>>
>>>   board/xilinx/versal-net/board.c | 47 ++++++++++++++--------------
>>>   board/xilinx/versal/board.c     | 47 ++++++++++++++--------------
>>>   board/xilinx/zynq/board.c       | 49 +++++++++++++++--------------
>>>   board/xilinx/zynqmp/zynqmp.c    | 55 +++++++++++++++++------------
>>> ----
>>>   4 files changed, 101 insertions(+), 97 deletions(-)
>>>
>>> --
>>> 2.34.1
>>>
>>
>> I have to remove this patch from my queue because it is actually
>> breaking current behavior.
>> CI is reporting an issue with it and I did a closer look and what is
>> happening is that if one location has no valid
>> data it goes and looks at another location from the list.
>>
> 
> But that is the desired behavior, if the environment is not in one
> location to check to the others.

That's how u-boot is written but if device doesn't exist or not accessible by 
u-boot it is clear that it shouldn't be used and then behavior is correct.

If device exists and simple varibles are not yet saved there going to different 
device is IMHO problematic.

> 
>> On Zynq it behaves like this.
>>
>> MMC:   mmc@e0100000: 0
>> prio 0
>> Loading Environment from SPIFlash... SF: Detected n25q128a13 with
>> page
>> size 256 Bytes, erase size 64 KiB, total 16 MiB
>> *** Warning - bad CRC, using default environment
>>
>> prio 1
>> Loading Environment from NAND... *** Error - No Valid Environment
>> Area found
>> *** Warning - bad env area, using default environment
>>
>> prio 2
>> Loading Environment from SPIFlash... *** Warning - bad CRC, using
>> default environment
>>
>> prio 3
>> Loading Environment from nowhere... OK
>>
>>
> 
> This is the message that we get as well when this patch is not added.

It means you are booting out of QSPI but qspi is not accessible by u-boot. Correct?


>> prio is my print to show where code is. Qemu boots out in QSPI boot
>> mode and SPI is tried first and because
>> this is xilinx_zynq_virt defconfig drivers/env locations for other
>> devices are present too. That's why it goes over the list
>> and it always ends in nowhere which never fails.
>>
>> If this runs on real HW then the same behavior is visible and I don't
>> think it is right.
>> I think this solution should be rethought.
>> In product current behavior from our code is not the best and current
>> U-Boot implementation is not allowing
>> flexibility too. We are enabling redundant variables which can be
>> only
>> on the same device but not that you have
>> one copy in QSPI and second in EMMC.
>> That's why I think location should be pretty much read from DT.
>> There is options/u-boot node where location of variables should be
>> described and this should replace
>> env_get_location().
> 
> You mean that there should be some type of new U-Boot node that
> describes where the environment should be located and go and
> search in this device?

Not sure if node or just dt property which points where that variables are stored.


>> It is a lot of work that's why I think second solution is more
>> reasonable for you which is simply create new Kconfig symbol
>> to disable board env_get_location() implementation.
>>
>> Thanks,
>> Michal
>>
> 
> You mean to basically disable the board env_get_location() that
> exists in board/xilinx/zynqmp/zynqmp.c for example?

yes. Something like this.

config BOARD_ENV_LOCATION
	bool "Use board defined ENV location"
	default y
	...

if defined (BOARD_ENV_SETUP/LOCATION)
enum env_location env_get_location(enum env_operation op, int prio)
{
...
}
endif

M


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
