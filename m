Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7583CCF58ED
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDA3588BC2;
	Wed, 25 Sep 2024 15:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727271855;
	bh=LYf4a2/yZphr6Y1vfGv8VAl2zmMnC+zc3bvoKpntWMc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TuonkYsEmDZUxoVew5wbjdFe5L0pFpqyCEqBvsG5QrqkEcs50hsQB1mCW5/w347xw
	 Ezg+UHtMP+A/miXi5QYNYNX/ORbiXE1Z4XakBkxZiUXigbcemCvyIn8U2lXnIwi8d6
	 Oj7e8PvfiGwGME66hF4MwCglOELONBbOUZC447o7rHBVQzJ/5BPfwcQiS3lmy74jUd
	 QBPc/IllCEd+lFKxyIihac9VKYOkUkwHO8mEoSewQ0j3p+Sj+sK5mzLTLR0Vh34b1Q
	 RPSA2VE72xLXvpumR9tBJEbwiIl2SN1MpXmCI7YlcCDgYg+b6jr6GscJJjVYcI+yfL
	 lZaZEVvEUAKUA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2B95988BBE;
 Wed, 25 Sep 2024 15:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727271854;
 bh=LYf4a2/yZphr6Y1vfGv8VAl2zmMnC+zc3bvoKpntWMc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=K9A2sHN4cxybvMqxHCC0Aq4jxxl05rAknQRrcgChktQ+qMW9ogHCXcg7/J0gAdyL1
 FeE6sOsJRqapEP4Cw6ujvUmS1BWZaVdHwTr63SZka2hypg3Lnezq01kDgVva3bjXPA
 7KHdGdFaCbsAqfRZ2Y+5t28G8eI7lkFJH3Hw/enhAJi0dINcGhEWsFT+pFD/e/wbfP
 tm5i3hi5svGX7EB1IiP6Cdp34jUrVNI2e+4x9zU2So78VA5sNT6bNVlKjKzeapmuWD
 bIIneQNaXWroBHgAuGZ10zXMSNhnTqLk5Fn4BxVDP8zqPvHABEhh70bqa3erXf/zVr
 /vALOBdz2ymRA==
Message-ID: <749f6964-52be-4b4a-81e6-d351564d5465@denx.de>
Date: Wed, 25 Sep 2024 14:51:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/20] arm: dts: agilex5: Enable XGMAC
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Meng, Tingting" <tingting.meng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-9-tien.fong.chee@intel.com>
 <92fa9c17-bbf4-49b5-8d7c-4b7d06f60736@denx.de>
 <DM8PR11MB5592C2455A4CFA9CDE0F6DD8D2682@DM8PR11MB5592.namprd11.prod.outlook.com>
 <5db7f491-e8f2-45d0-baab-fa309cb4db64@denx.de>
 <DM8PR11MB5592C49308440E5F902A4F1BD2692@DM8PR11MB5592.namprd11.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <DM8PR11MB5592C49308440E5F902A4F1BD2692@DM8PR11MB5592.namprd11.prod.outlook.com>
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

On 9/25/24 8:13 AM, Chee, Tien Fong wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Wednesday, September 25, 2024 2:36 AM
>> To: Chee, Tien Fong <tien.fong.chee@intel.com>; u-boot@lists.denx.de
>> Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>; Meng, Tingting
>> <tingting.meng@intel.com>; Yuslaimi, Alif Zakuan
>> <alif.zakuan.yuslaimi@intel.com>; Hea, Kok Kiang
>> <kok.kiang.hea@intel.com>
>> Subject: Re: [PATCH v1 08/20] arm: dts: agilex5: Enable XGMAC
>>
>> On 9/24/24 8:02 AM, Chee, Tien Fong wrote:
>>> Hi,
>>
>> Hi,
>>
>>>>> diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
>>>> b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
>>>>> index 9eb21d65428..75ab05031bc 100644
>>>>> --- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
>>>>> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
>>>>> @@ -122,3 +122,36 @@
>>>>>     	bootph-all;
>>>>>     };
>>>>>
>>>>> +&gmac0 {
>>>>> +	status = "okay";
>>>>> +	phy-mode = "rgmii";
>>>>> +	phy-handle = <&emac0_phy0>;
>>>> Shouldn't this be part of Linux DT already ?
>>>
>>> This enablement not yet in Linux DT, I believe our Linux team is still working
>> on it.
>> Is there at least a patch posted upstream ?
> 
> Having two patches posted now in Linux mainline, but gmac device is still not yet added into these dt.
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
> 
> I think we can do a cleanup if the duplicated found in U-Boot later.
At least reference the two patches (lore links) in the V2 of this patch.
