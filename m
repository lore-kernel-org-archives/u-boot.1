Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C33CF9C69
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 20:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48BD388B14;
	Tue, 24 Sep 2024 22:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727208062;
	bh=NroMeT8LddEIkesSwO65ZLKRGIx4yF5EiSWierx8KW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0CH1owtcx4CFYDh+66f4Kg1ARfEzcbmhQkC1WpmyrZ0a9yHWlUHdPnyJppdMbfJGw
	 uRG08OrjIyKdYoKgPTcPthi8eDmTRvAfR1hNiKG2uST8JPHm+z20evAMtbU3Mz2EBY
	 3Nho7F9dZCwKN01VCoFXEC8MGMUiTqW1ll9vfZ0c/87WrYFN/MiDn42wMZSV5WFZbf
	 H42nn2TwGcTltVGctCNB1JfZA8V0/MiS+sOKhUOOvSV1LJyrbS6YxNLQv5q9UvyNn8
	 JFGyDuIY+VnfDm6IRrvFFF1itrWHdjooPGk+rPiBuoTHEa0H1QiFWVHLfo31ep2yS1
	 Fc6pKTlb4hAUA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C632A88AD7;
 Tue, 24 Sep 2024 22:00:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727208058;
 bh=NroMeT8LddEIkesSwO65ZLKRGIx4yF5EiSWierx8KW8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tZMcibPCT4mJ9eP+kfrodNQAIRe0zmkeETtvfItMs1W2qg5c8Y6SU7vTkVgV7vPyb
 o3IpztcolcX4P5dn4W17xc3BvoSHAv5VQ6IZ3cjf/oW9UdkHRHSBRC3MqecFjyC2nN
 5iNtcJU8OheCKSx/N+nHnEHucUeJhu8/ldlQCYXX9hanxn3IMGX/pO960XZYDBs6Bs
 7RJAOlIewACeIJV5SnJ4n8RoLqgwhWtXCs7NtUFrlALsn/EP1KPqgb+dJB/Wbxb8v2
 F25k0gc2ZyNbQRcv8ayk0luqVUsKn9VFVoPBwmUJ60YDJDTUtdB0RY+EM2vx2q/alO
 vbZ1FI+rkohXg==
Message-ID: <5db7f491-e8f2-45d0-baab-fa309cb4db64@denx.de>
Date: Tue, 24 Sep 2024 20:36:04 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <DM8PR11MB5592C2455A4CFA9CDE0F6DD8D2682@DM8PR11MB5592.namprd11.prod.outlook.com>
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

On 9/24/24 8:02 AM, Chee, Tien Fong wrote:
> Hi,

Hi,

>>> diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
>> b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
>>> index 9eb21d65428..75ab05031bc 100644
>>> --- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
>>> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
>>> @@ -122,3 +122,36 @@
>>>    	bootph-all;
>>>    };
>>>
>>> +&gmac0 {
>>> +	status = "okay";
>>> +	phy-mode = "rgmii";
>>> +	phy-handle = <&emac0_phy0>;
>> Shouldn't this be part of Linux DT already ?
> 
> This enablement not yet in Linux DT, I believe our Linux team is still working on it.
Is there at least a patch posted upstream ?
