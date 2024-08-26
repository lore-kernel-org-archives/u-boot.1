Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECF0C5472C
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 21:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B889988155;
	Mon, 26 Aug 2024 23:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15F6788B37; Mon, 26 Aug 2024 23:05:26 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A5188009
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 23:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtp77t1724706290t1oehuxs
X-QQ-Originating-IP: R0l0UtGFfDAoZc7aOz/RkG1WkeA46Oxe8pj6Ujhb1cY=
Received: from [192.168.159.131] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 27 Aug 2024 05:04:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2796045904454888329
Message-ID: <58B453FBE3C7DD03+3ed72f8c-9a4d-43bd-995a-4b357bf0bf1c@radxa.com>
Date: Tue, 27 Aug 2024 06:04:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: add SPI NOR flash support for Radxa E25(CM3I)
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com
References: <20240824220701.97796-1-naoki@radxa.com>
 <2795c560-d36e-4de2-9b72-fb42b245d7fd@cherry.de>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <2795c560-d36e-4de2-9b72-fb42b245d7fd@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
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

hi,

On 8/27/24 01:11, Quentin Schulz wrote:
> Hi Naoki,
> 
> On 8/25/24 12:07 AM, FUKAUMI Naoki wrote:
>> some SKU for CM3I SoM have a SPI NOR flash. this patch enables related
>> configurations and changes devicetree.
>>
>> => sf probe
>> SF: Detected w25q128fw with page size 256 Bytes, erase size 4 KiB, 
>> total 16 MiB
>>
>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>> ---
>> Changes in v2:
>> - reword commit message
>> ---
>>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi | 16 ++++++++++++++++
>>   configs/radxa-e25-rk3568_defconfig        | 14 ++++++++++++++
>>   2 files changed, 30 insertions(+)
>>
>> diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi 
>> b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
>> index 74755a44eae..1f0bacbf61f 100644
>> --- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
>> @@ -21,6 +21,22 @@
>>       mmc-hs400-enhanced-strobe;
>>   };
>> +&sfc {
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +    status = "okay";
>> +
>> +    flash@0 {
>> +        compatible = "jedec,spi-nor";
>> +        reg = <0>;
>> +        bootph-pre-ram;
>> +        bootph-some-ram;
>> +        spi-max-frequency = <24000000>;
>> +        spi-rx-bus-width = <4>;
>> +        spi-tx-bus-width = <1>;
>> +    };
>> +};
>> +
> 
> Was this sent upstream to the Linux kernel already? I did a very quick 
> search on lore.kernel.org and didn't find anything. Is there anything 
> that's preventing you from sending this to them first? I really would 
> prefer to have only U-Boot specific stuff in -u-boot.dtsi DTSIs.

no, not yet, but I'll send this to Linux ASAP.

since SPI NOR flash is used for U-Boot, I sent this to here first.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Cheers,
> Quentin
> 
