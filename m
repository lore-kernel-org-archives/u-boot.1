Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495DECF2590
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 06:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72BD088DCC;
	Mon, 14 Oct 2024 08:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728888469;
	bh=T/kb8mB6xBw+IRqcgTVt2OtGoteqPjdKxoy4assSP4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=pzxKwNymyCjVBH6zAMOqzkwPGkBdmLB/SbIXZ8cSkESERD7VZl/JCNDmx9pvtEtPO
	 Cr+2/H3xz56KR7S0vdFhDFazm3QbqmW68ghFaaVDRiXbJfHXL9uUu+m3/jtn/VYOWZ
	 FTT2hkga853u/MLp65p0bCgY5e+7ycSJfVdNQ28Kb37LQ2IeMPfFIPuQsQq9POOz67
	 iH1KwAlFQm9A8Z5rJvVX3Cbtwn4Erx1IrQJFVB67Tdv7jwO01/0VUVqNVaAgibrq+r
	 gT9pvR4QERSGCctP4Kv1rAJAzM22vHW3Y4yN5IwqR6QvzTF9XgoeG5aOsizDk1Wtf3
	 5wj0t77d+0hlw==
Received: from [192.168.1.107] (87-97-107-160.pool.digikabel.hu
 [87.97.107.160])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6B00188B8F;
 Mon, 14 Oct 2024 08:47:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728888467;
 bh=T/kb8mB6xBw+IRqcgTVt2OtGoteqPjdKxoy4assSP4k=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=nNMciiYHex0pFvIbyEKNvThiuikblne7O/MLWmGDDPyLemM5WSREkY6IhU3gAxjyZ
 mmHbh4e+LOHD+/p6J2SqVMLSyO7QTdSwknsHMAJWmHDl418dLx5KKvFyLstt0cK14B
 upsKp4E68P79z/dd4gPnjUOIVS9T/ncfKwaJuSOGKcvQHjH4CoUGRXajtNWjMuXYaH
 9MhDWgKuw3mW2LFzNkcnRor0HNv5P1S6rtGjxTTMT2JQsROK6t0u5KUtPjR6YHI0p/
 YJ0TB/lAAGw+LME6PILEnN8F6bwcWNzKhFElxImKidG6rbmokxZxJq8am7u7fTuipj
 eDVez9BYuFYCg==
Message-ID: <43ea1972-ee4f-ab25-aa98-2ae3fc4f20fb@denx.de>
Date: Mon, 14 Oct 2024 08:45:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
Content-Language: en-US
To: Peng Fan <peng.fan@nxp.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefano Babic
 <sbabic@denx.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20241010082831.19983-1-hs@denx.de>
 <DB9PR04MB846127A928CBE4AB1F373DFE88442@DB9PR04MB8461.eurprd04.prod.outlook.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <DB9PR04MB846127A928CBE4AB1F373DFE88442@DB9PR04MB8461.eurprd04.prod.outlook.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Peng!

On 14.10.24 08:29, Peng Fan wrote:
> Hi Heiko,
> 
> With the two applied, with latest U-Boot, uuu works
> well on i.MX8MP-EVK
> https://lore.kernel.org/all/20241012093410.9069-1-peng.fan@oss.nxp.com/
> https://lore.kernel.org/all/20241011105827.7729-1-peng.fan@oss.nxp.com/

Thanks for verifying! So the problem is for sure on my side...

My base is:
* f919c3a889 - (tag: v2024.10) Prepare v2024.10 (vor 7 Tagen) <Tom Rini>

So, your patches not applied ... yet.

Yes some patches above to introduce board support, mainlining
comes soon...

I tried with your patches, still teh same problem on my side.

> Would you share your commit hash and boot log?

see below ... I must admit I have enabled IMX_HAB boot, and signing
works well with binman... may I ask, if you can enable IMX_HAB too?

here the bootlog:

│   │    <> U-Boot SPL 2024.10-00017-gdf824fb3d8ef-dirty (Oct 07 2024 - 14:54:35 +0000)
│   │    <> DDR:   4096 MiB [0x2]
│   │    <> DDR:   Inline ECC disabled
│   │    <> SEC0:  RNG instantiated
│   │    <> Normal Boot
│   │    <> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
│   │    <> Trying to boot from BOOTROM
│   │    <> Boot Stage: USB boot
│   │    <> Find img info 0x48021000, size 1493611
│   │    <> Need continue download 1492992
│   │    <> hab fuse not enabled
│   │    <>
│   │    <> Authenticate image from DDR location 0x44000000...
│   │    <> NOTICE:  Do not release JR0 to NS as it can be used by HAB
│   │    <> NOTICE:  BL31: v2.11.0(release):v2.10.0-984-gf2735ebcc
│   │    <> NOTICE:  BL31: Built : 11:51:22, May 23 2024
│   │    <>
│   │    <>
│   │    <> U-Boot 2024.10-00017-gdf824fb3d8ef-dirty (Oct 07 2024 - 14:54:35 +0000)
│   │    <>
│   │    <> CPU:   Freescale i.MX8MP[8] rev1.1 1800 MHz (running at 1200 MHz)
│   │    <> CPU:   Commercial temperature grade (0C to 95C) at 41C
│   │    <> Reset cause: POR
│   │    <> Model: Aristainetos3 ADLink PI SMARC carrier
│   │    <> DRAM:  4 GiB
│   │    <> Core:  172 devices, 36 uclasses, devicetree: separate
│   │    <> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
│   │    <> FSL_SDHC: 1, FSL_SDHC: 0
│   │    <> Loading Environment from MMC... Reading from MMC(0)... OK
│   │    <> In:    serial
│   │    <> Out:   serial
│   │    <> Err:   serial
│   │    <> SEC0:  RNG instantiated
│   │    <> Net:
│   │    <> Warning: ethernet@30bf0000 (eth0) using random MAC address - 9a:16:44:b4:19:9f
│   │    <>
│   │    <> Warning: ethernet@30be0000 (eth1) using random MAC address - 96:f4:de:9a:49:8f
│   │    <> eth1: ethernet@30be0000, eth0: ethernet@30bf0000 [PRIME]
│   │    <> Hit any key to stop autoboot:  0
│   │    <> u-boot=>

bye,
Heiko
> 
> Regards,
> Peng.
> 
>> Subject: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
>>
>> trying to load current flash.bin with uuu tool leads in not booting U-
>> Boot as missing some bytes.
>>
>> Align flash.bin in this case to 0x800 bytes, to make uuu and ROM api
>> happy.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>> I am unsure about the value of 0x800 which is twice the value the code
>> in spl_romapi_load_image_stream(), requests from romapi which in my
>> case on imx8mp is 0x400...
>>
>> May I oversee something?
>>
>>   arch/arm/dts/imx8mp-u-boot.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-
>> u-boot.dtsi index 56749ccacd..3c0bf8c4d6 100644
>> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
>> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
>> @@ -85,6 +85,7 @@
>>   	filename = "flash.bin";
>>   	section {
>>   		pad-byte = <0x00>;
>> +		align-size = <0x800>;
>>
>>   #ifdef CONFIG_IMX_HAB
>>   		nxp-imx8mcst@0 {
>> --
>> 2.20.1

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
