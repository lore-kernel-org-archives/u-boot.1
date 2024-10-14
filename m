Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5782CFC500
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 07:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E91789026;
	Mon, 14 Oct 2024 09:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728892016;
	bh=KAaygnuPYo21ldnIpy9RfjQ6UvT6FmMXLD+0131aE3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=djGxDV5t9aBMfy7j6dRtKiX2awbVIbZX4fot2oTaXDkUMmNVPYJhpfnyAb3c0UuC4
	 ebKTtKdElR12pWqsDf4pDEMwMv29bF5VAgvxFL/WMuArVTMAAKz93nUp6Rm+Z0dTYQ
	 v0z94ISb3VcdKV03naWhFoSBm3hvUY0OdcIxUASn0boeIWi3RD3cOA8UR0C+ZLF31v
	 P6fQeKQfrnxokQr8cCeOrSYVkoVbEF/ystBQBisJh7EilSvDGDSRVdeN0vqr80x/f1
	 mFDp2cvoWfYjfW1gggranhcVy97Uyki+5vwzcQpwa60VO5vLBhMY/1iLEv1sFG7kn3
	 O17+GZcfBd/qQ==
Received: from [192.168.1.107] (87-97-107-160.pool.digikabel.hu
 [87.97.107.160])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4AE1789021;
 Mon, 14 Oct 2024 09:46:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728892015;
 bh=KAaygnuPYo21ldnIpy9RfjQ6UvT6FmMXLD+0131aE3o=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=uQorRMLKOyh0++uIVXtmw8H7piy0QOeit8iWBWZUU6UwpUi5/RtB9lqNCyG624yHt
 lHs6uBI8t1rCz/EdmjgYfDzYGMyCHn77Ewq0RJC6Ln9kTWZ5+rwIDLBMC7kPgU8F0a
 ESQl11I9Udp9xnYNmPaEkuvrxwglGz3eOpvxHxyxAZGP0floKIy4NLUC9pDxxnHAAT
 n2cJ42ge8qyCrepknegPfwZuI3ITX4RAnQQQ20R0yEMPDcuRT9PBku02UGME4AN+uN
 6obXwG7HiggQI1dYwmefEy/vQMYfGNEF2XY3sTaCltzda+zFOscXEq+YexgnmXexLD
 VIESoTF9bkxlg==
Message-ID: <aeec07bf-6a3d-08c5-2786-5a7c2bfe92b6@denx.de>
Date: Mon, 14 Oct 2024 09:44:45 +0200
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
 <43ea1972-ee4f-ab25-aa98-2ae3fc4f20fb@denx.de>
 <DB9PR04MB84613CEEBFE7ECE0B249DB6A88442@DB9PR04MB8461.eurprd04.prod.outlook.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <DB9PR04MB84613CEEBFE7ECE0B249DB6A88442@DB9PR04MB8461.eurprd04.prod.outlook.com>
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

On 14.10.24 09:29, Peng Fan wrote:
>> Subject: Re: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
>>
>> Hi Peng!
>>
>> On 14.10.24 08:29, Peng Fan wrote:
>>> Hi Heiko,
>>>
>>> With the two applied, with latest U-Boot, uuu works well on
>>> i.MX8MP-EVK
>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
>> lore
>>> .kernel.org%2Fall%2F20241012093410.9069-1-
>> peng.fan%40oss.nxp.com%2F&da
>>>
>> ta=05%7C02%7Cpeng.fan%40nxp.com%7C26dd8c31b9ca4276aed108
>> dcec1c1dc0%7C6
>>>
>> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386448527505
>> 72116%7CUnknown
>>> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
>> 6Ik1haWwiLCJ
>>>
>> XVCI6Mn0%3D%7C0%7C%7C%7C&sdata=vZqhJCFei5qbUYZT3Lu2SF5kf
>> RwT26lWufHwKZ0
>>> ojto%3D&reserved=0
>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
>> lore
>>> .kernel.org%2Fall%2F20241011105827.7729-1-
>> peng.fan%40oss.nxp.com%2F&da
>>>
>> ta=05%7C02%7Cpeng.fan%40nxp.com%7C26dd8c31b9ca4276aed108
>> dcec1c1dc0%7C6
>>>
>> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386448527505
>> 91559%7CUnknown
>>> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
>> 6Ik1haWwiLCJ
>>>
>> XVCI6Mn0%3D%7C0%7C%7C%7C&sdata=tIjTPu%2Fq7wQqpzIO2EaoCG
>> vgKxM%2Fy2eJoPw
>>> miGiBJ9E%3D&reserved=0
>>
>> Thanks for verifying! So the problem is for sure on my side...
>>
>> My base is:
>> * f919c3a889 - (tag: v2024.10) Prepare v2024.10 (vor 7 Tagen) <Tom
>> Rini>
>>
>> So, your patches not applied ... yet.
>>
>> Yes some patches above to introduce board support, mainlining comes
>> soon...
>>
>> I tried with your patches, still teh same problem on my side.
>>
>>> Would you share your commit hash and boot log?
>>
>> see below ... I must admit I have enabled IMX_HAB boot, and signing
>> works well with binman... may I ask, if you can enable IMX_HAB too?
> 
> I use OEM_OPEN part, not have IMX_HAB enabled.
> 
>>
>> here the bootlog:
>>
>> │   │    <> U-Boot SPL 2024.10-00017-gdf824fb3d8ef-dirty (Oct 07
>> 2024 - 14:54:35 +0000)
> 
> So your board boots ok, but uuu has issue?

Board boots fine from emmc, sd card. Booting blank board with
uuu works with posted RFC patch, as it seems to me code in

spl_romapi_load_image_stream()

waits for more bytes than flash.bin currently has... appending some
zero bytes at the end, and U_Boot begins to boot and works fine, uuu
tool ends with errorcode 0.

bye,
Heiko
> 
> Regards,
> Peng.
> 
>> │   │    <> DDR:   4096 MiB [0x2]
>> │   │    <> DDR:   Inline ECC disabled
>> │   │    <> SEC0:  RNG instantiated
>> │   │    <> Normal Boot
>> │   │    <> WDT:   Started watchdog@30280000 with servicing every
>> 1000ms (60s timeout)
>> │   │    <> Trying to boot from BOOTROM
>> │   │    <> Boot Stage: USB boot
>> │   │    <> Find img info 0x48021000, size 1493611
>> │   │    <> Need continue download 1492992
>> │   │    <> hab fuse not enabled
>> │   │    <>
>> │   │    <> Authenticate image from DDR location 0x44000000...
>> │   │    <> NOTICE:  Do not release JR0 to NS as it can be used by HAB
>> │   │    <> NOTICE:  BL31: v2.11.0(release):v2.10.0-984-gf2735ebcc
>> │   │    <> NOTICE:  BL31: Built : 11:51:22, May 23 2024
>> │   │    <>
>> │   │    <>
>> │   │    <> U-Boot 2024.10-00017-gdf824fb3d8ef-dirty (Oct 07 2024 -
>> 14:54:35 +0000)
>> │   │    <>
>> │   │    <> CPU:   Freescale i.MX8MP[8] rev1.1 1800 MHz (running at
>> 1200 MHz)
>> │   │    <> CPU:   Commercial temperature grade (0C to 95C) at 41C
>> │   │    <> Reset cause: POR
>> │   │    <> Model: Aristainetos3 ADLink PI SMARC carrier
>> │   │    <> DRAM:  4 GiB
>> │   │    <> Core:  172 devices, 36 uclasses, devicetree: separate
>> │   │    <> WDT:   Started watchdog@30280000 with servicing every
>> 1000ms (60s timeout)
>> │   │    <> FSL_SDHC: 1, FSL_SDHC: 0
>> │   │    <> Loading Environment from MMC... Reading from MMC(0)...
>> OK
>> │   │    <> In:    serial
>> │   │    <> Out:   serial
>> │   │    <> Err:   serial
>> │   │    <> SEC0:  RNG instantiated
>> │   │    <> Net:
>> │   │    <> Warning: ethernet@30bf0000 (eth0) using random MAC
>> address - 9a:16:44:b4:19:9f
>> │   │    <>
>> │   │    <> Warning: ethernet@30be0000 (eth1) using random MAC
>> address - 96:f4:de:9a:49:8f
>> │   │    <> eth1: ethernet@30be0000, eth0: ethernet@30bf0000
>> [PRIME]
>> │   │    <> Hit any key to stop autoboot:  0
>> │   │    <> u-boot=>
>>
>> bye,
>> Heiko
>>>
>>> Regards,
>>> Peng.
>>>
>>>> Subject: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
>>>>
>>>> trying to load current flash.bin with uuu tool leads in not booting
>>>> U- Boot as missing some bytes.
>>>>
>>>> Align flash.bin in this case to 0x800 bytes, to make uuu and ROM
>> api
>>>> happy.
>>>>
>>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>>> ---
>>>> I am unsure about the value of 0x800 which is twice the value the
>>>> code in spl_romapi_load_image_stream(), requests from romapi
>> which in
>>>> my case on imx8mp is 0x400...
>>>>
>>>> May I oversee something?
>>>>
>>>>    arch/arm/dts/imx8mp-u-boot.dtsi | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi
>> b/arch/arm/dts/imx8mp-
>>>> u-boot.dtsi index 56749ccacd..3c0bf8c4d6 100644
>>>> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
>>>> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
>>>> @@ -85,6 +85,7 @@
>>>>    	filename = "flash.bin";
>>>>    	section {
>>>>    		pad-byte = <0x00>;
>>>> +		align-size = <0x800>;
>>>>
>>>>    #ifdef CONFIG_IMX_HAB
>>>>    		nxp-imx8mcst@0 {
>>>> --
>>>> 2.20.1
>>
>> --
>> DENX Software Engineering GmbH,      Managing Director: Erika Unter
>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
>> Germany
>> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email:
>> hs@denx.de

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
