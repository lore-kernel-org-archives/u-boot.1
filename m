Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D67CF58ED
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EB4B88C2E;
	Wed, 25 Sep 2024 15:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727271845;
	bh=8Hd3o/vPRzP2rZa/JwaXbi6Y9SfqakaE5ioaavBRuKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qm4qa/1qyWEsM/coUbxLMwLilHNLl0SC7nfISteLBKs8uFn45urUZ0NStDPc8ty2v
	 B3uKnUNml9BMILTq2WgzjM6VQavVAc2XWiY3yF9yCgZaUloNowVjAJAb4invxzeDOG
	 fR/kSTQe2BHvnR38L9Cb1Kx4nvJrDpxzdMhaAzhbwDqU1n1bJxWtfHRCHP19phLRx2
	 BxpAPAcGe4qbl9Z1NVb0zJe+Szux5lhYrjJza2nfAGyLzLSdthR7ZSPKyMWazUO26v
	 HmmaNYSPAuRdQC5/S5/o96SV53tbFw4ARSF8YzxSzelgQbPl0pR2DOhZEMd2eC2QHQ
	 doL1LUhRM7cBw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 75B3C8897F;
 Wed, 25 Sep 2024 15:43:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727271843;
 bh=8Hd3o/vPRzP2rZa/JwaXbi6Y9SfqakaE5ioaavBRuKU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=yPPp4oQkV3+t+4GTgVIf8/F7RIpf4xeMRdQvirgUFMbeSRTCT2jYLwLhBNCYA312+
 x/kb90CU1CUzxiZZ+araOjbWdjP0ehLjvjLOfXzlQ2RGf6uiIIQiIMnhxFyt71uG9Z
 HfndmwnIZ59t0EuMXdbW23mOgO7FWxXzEa777uJKLxAOHSkWSTZqw7Hh9UO2pjFhMt
 gDb01bSxTSmt+ihoR1m5gqveCnjvMzmg9PBP87oS6bjPmjE2zULFa0z/XXLyvhRLkz
 eZwnLY+DI+IbxR2LO3Z1sZhi7LHWeciO2xqdHlO+K2gXTXH1GKUoowFW9C89D6/zY3
 Tq92sbHy73xNQ==
Message-ID: <5de166a6-25ce-4b75-8257-5a32531cd890@denx.de>
Date: Wed, 25 Sep 2024 14:50:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/20] linker: Add SPL linker script for SoC64 devices
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Meng, Tingting" <tingting.meng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-4-tien.fong.chee@intel.com>
 <858854ad-bebb-4199-bd8f-a5807a2144dd@denx.de>
 <DM8PR11MB55923CF1E2F876C6EB68FC9BD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
 <4f7c1b66-7ed1-4333-beb7-345639a3ff2b@denx.de>
 <DM8PR11MB55925249D5D10BE76135201BD2692@DM8PR11MB5592.namprd11.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <DM8PR11MB55925249D5D10BE76135201BD2692@DM8PR11MB5592.namprd11.prod.outlook.com>
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

On 9/25/24 8:06 AM, Chee, Tien Fong wrote:

Hi,

>>>>> Add a new .data section for preserving the original state of the
>>>>> .data section of SoC64 SPL. This new .data section is required to
>>>>> make SPL reentrant after warm reset.
>>>> Where is the linker script copied from ? What is the original file
>>>> name and path ?
>>>
>>> I think the script is copied from arch/arm/cpu/armv8/u-boot-spl.lds .
>> Can arch/arm/cpu/armv8/u-boot-spl.lds be extended somehow instead , or
>> are there too many differences ?
> 
> We think can use arch/arm/cpu/armv8/u-boot-spl.lds, because we just noticed the CONFIG_SPL_RECOVER_DATA_SECTION was added into lds and this should be the same design with current patch.
Excellent !
