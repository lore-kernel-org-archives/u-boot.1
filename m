Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6903BEEF331
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 09:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C908F83FB0;
	Thu,  5 Mar 2026 10:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="PbQGBCme";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51B1F83FB5; Thu,  5 Mar 2026 10:01:56 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC0083FAA
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 10:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so3715386f8f.0
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 01:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772701311; x=1773306111; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sVVBwq2UHjJsm4pmeQ68n8s4KFCmRPJF2me7Lsjondo=;
 b=PbQGBCmeQBV5lUiQn7ppQbHG+7i/PT3jHr+CyGzFgfdBLWxuGR3dGGS2BPUPObQluf
 xlrAGfYtIVw1JtFg/g/4IV8UDkwGb+k1PYLHxEAFnyoD/wO73GFtWcMfIvZkrArEJW6U
 6cGmJJw2Iu2DxiM1IXvA3ZmLY1QWRViGWK7va02G4+nKo2r/uTpjPUPL+catY2+fDgJ0
 ieYBC075de8wgyD6q3zzBKTISj/Hwi4O1P1zKTofdeJXSlAqueCAENop3YT92Beg6mSb
 TXDN5xCz2/4eoPMz23PtS1XtDAhCPgdBHXr5H2mBxDSBsraQY0GdK5kA5KaL3znjYYDm
 sKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772701311; x=1773306111;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVVBwq2UHjJsm4pmeQ68n8s4KFCmRPJF2me7Lsjondo=;
 b=rDXo91PgRwZEwif9iR/Ecplv/UTy5Udp/W0vMlp5YVNFxU6wvH0bL1fIFUsJ+e8nkO
 91UhiPVsil6YPuw8m68dWK4xszNRMs+K7sqsx5uCE4zn310qUWO0bwSbvZmccbF8PJJb
 DVi6knxMd9QNlu4FTfY5jUoOK7o9aSmlE5d+1FjGrQTpOiR4HjsibcyZiPRYeZ9FcokW
 LjSSsqYfE8MgzkXZL69oVNpDQSWSW7G48As9qYWPnrkAQbcEEuBGZ3g5+hAAUYzT1jHE
 ifeV86mCSplfML9zWz6aKz90fCNiznyoYgdU3UIuc3rvn0Yy72Yw/xbVNr+ZgxMeN+9d
 i85w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhYj9f0H7x5CC24E3bW7brlmPT/oCnE6GcCPoR0aXK+1MLIxyQKjvpTtmPM98TEB1RGOdQi5w=@lists.denx.de
X-Gm-Message-State: AOJu0YweHtISzYNgGZpS/L/DK5O8PLEJI1bP29jNlFloMXL0cOpmVd1k
 8OEqrg3Rx/2/Yi73XfStxRmFq5WMCdU+Mj8OrSy8bcE6M66LOjK9DuaoT/oix+T2onA=
X-Gm-Gg: ATEYQzx6LoTjKsM0hdedj2yGH/JoyW9H8C97IpYxEUUE0K4uspFrqDfpgEeFSEVfrxS
 vlF508wIdn89GZYtbLAXzTqgGWT9yhcNxpgDAqe4yxoERYAea3cB5JXJTV7plQPiA/kMUKBzpfZ
 yDo50YScsj4A70bHJbQjEB3LrT0jhIHjUO/3hfAvpMkpFd4DVJK6m7YFXy6KaBdkrfw9bPlUmc5
 GzGMh+QInNVEC1D4Nrn9OcVcGQ1X/MgWKvavPu+DnqOtzu8frRXS5eA44lf7pWUrUOz7PoYQwps
 i2tmUubt6YgqQmVv2aE1Pk8k9FLl82qlrH4ioFgxBpRJZscJeyEuQXsoO6CmyktAr9TdnyZ1mYJ
 cQuqlOYb4q1xbHRN/2c9+VxmX3sgVlGmQMiLsqiyXq4Hk2r9n4RSqHq1a9flq1snWY/q2fJt8m0
 ygCeqCyA3xsFZSGand4isAQyqV8mbaH7ZVIFlMyRweevig6ZCR/mGV+cEyd7n4Q3ZPu0n3kWoYk
 w==
X-Received: by 2002:a5d:5d0f:0:b0:439:b858:1d28 with SMTP id
 ffacd0b85a97d-439c7fc4903mr8990138f8f.26.1772701310932; 
 Thu, 05 Mar 2026 01:01:50 -0800 (PST)
Received: from [192.168.2.177] (241.85-85-167.dynamic.clientes.euskaltel.es.
 [85.85.167.241]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b34b6252sm32535680f8f.10.2026.03.05.01.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 01:01:50 -0800 (PST)
Message-ID: <5e12afaf-4461-4bcd-90fb-cc21138d5333@suse.com>
Date: Thu, 5 Mar 2026 10:01:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [hack] help U-Boot find the correct PCIe inbound offset for NVMe
 on Raspberry Pi 5
To: Pedro Falcato <pfalcato@suse.de>, Torsten Duwe <duwe@lst.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Andrea della Porta <andrea.porta@suse.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260302135940.550e6051@rocky.lan>
 <20260302164256.29af9995@rocky.lan>
 <khr5tpfjql6l5ide644d7x6v2km6m3u4jnlbxq5zsbqefui65i@dlwpybwg3fym>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <khr5tpfjql6l5ide644d7x6v2km6m3u4jnlbxq5zsbqefui65i@dlwpybwg3fym>
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



On 04/03/2026 20:43, Pedro Falcato wrote:
> Hi Torsten,
> 
> On Mon, Mar 02, 2026 at 04:42:56PM +0100, Torsten Duwe wrote:
>> On Mon, 2 Mar 2026 13:59:40 +0100
>> Torsten Duwe <duwe@lst.de> wrote:
>>
>>> This proposed patch uses the already existent dev_phys_to_bus(),
>>> which can dig up the correct offset from associated DT nodes and
>>> subtract it.
>>
>> Just to make it clear, that patch is a necessary but not a sufficient
>> condition to boot the RPi5 from NVMe. The PCIe bus node above
>> the NVMe is generated dynamically has no DT node with dma-ranges and so
>> dev_phys_to_bus() still returns zero. In order to test NVMe on the
>> RPi5 you can either:
>>
> 
> Say I wanted to test NVMe booting on the pi5 (which I actually do).
> I would need:
> 1) this patch
> 2) one of the two BUS_ADDR() related diffs
> 3) the fixes posted in https://lore.kernel.org/u-boot/20251105163553.15F2A227AAC@verein.lst.de/
> 4) anything else?
> 

Just as a heads-up. If you interested to test this on openSUSE, you can install 
uboot-rpiarm64 and raspberrypi-firmware-dt package from this open build service 
project:
https://build.opensuse.org/project/show/home:mbrugger:branches:RPi5

That has both series on top of v2026.01 (plus other openSUSE stuff) and the DT 
patch.

Regards,
Matthias

> Thanks,
> Pedro
> 
>> hard code the 64GiB value when building your private U-Boot binary:
>>
>> -#define BUS_ADDR(a)         dev_phys_to_bus(dev->udev, (a))
>> +#define BUS_ADDR(a)            ((a)+0x1000000000LL)
>>
>> OR use this tricky DT change Andrea has prepared:
>>
>> --- a/dts/upstream/src/arm64/broadcom/bcm2712.dtsi
>> +++ b/dts/upstream/src/arm64/broadcom/bcm2712.dtsi
>> @@ -571,6 +571,15 @@
>>   				<0x03000000 0xff 0xfffff000 0x10 0x00131000 0x00 0x00001000>;
>>   			status = "disabled";
>> +
>> +			pci@0,0 {
>> +				reg = <0x00 0x00 0x00 0x00 0x00>;
>> +				device_type = "pci";
>> +				#address-cells = <0x03>;
>> +				#size-cells = <0x02>;
>> +				ranges;
>> +				dma-ranges;
>> +			};
>>   		};
>>   
>>   		pcie2: pcie@1000120000 {
>>
>> This pci@0,0 node needs to be below the pcie@1000110000 RC node so it
>> can "bridge" dev_phys_to_bus() to the RC node when it climbs up the
>> device tree and so helps it find the correct value.
>>
>> AFAICS the proper fix should be to add some dma-ranges property when
>> dynamic PCI devices are created during enumeration/scan or make
>> dev_phys_to_bus() skip those nodes for the lookup.
>>
>> 	Torsten

