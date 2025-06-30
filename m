Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F00BC7EE2A
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 05:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6588781FEE;
	Mon, 30 Jun 2025 07:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hoictmZj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 970F882B34; Mon, 30 Jun 2025 07:20:26 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E91F881E13
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 07:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=g-praveen@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55U5KD8D3229080;
 Mon, 30 Jun 2025 00:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751260813;
 bh=HCQrr1x6zwXiOv7mO4gjnXX4Yy39F7xQIDRX399q3x8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=hoictmZjccofPv98g6c87qZjs5EzRv3M+eT2lPuhrhNTE93+4JO2BoUjuqt4+Ags+
 2KZ0DI0Z0L0jsnxVRcjPkbV5LRsgyaFvVzLVPZP17VqxYdSp7nlwd1Pi7DSeFBDZQf
 6vq9WLaSVQ81tuSFeuPrSLVgL2aY8fuX8sN/+SAw=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55U5KDH23060489
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 30 Jun 2025 00:20:13 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 30
 Jun 2025 00:20:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 30 Jun 2025 00:20:13 -0500
Received: from [10.24.72.119]
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.72.119])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55U5KA4P3026693;
 Mon, 30 Jun 2025 00:20:10 -0500
Message-ID: <a6e024ba-8642-4c58-a7b7-284c8cf448e5@ti.com>
Date: Mon, 30 Jun 2025 10:50:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] configs: KASLR OPTEE RNG support for K3 devices
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <tien.fong.chee@altera.com>, <sjg@chromium.org>,
 <patrick.rudolph@9elements.com>, <1425075683@qq.com>,
 <Oliver.Gaskell@analog.com>, <u-boot@lists.denx.de>
References: <20250627092224.36325-1-g-praveen@ti.com>
 <20250627092224.36325-2-g-praveen@ti.com>
 <20250627102218.xtjlreu5qmpmfszr@uda0497581-HP>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20250627102218.xtjlreu5qmpmfszr@uda0497581-HP>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 30 Jun 2025 07:49:50 +0200
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

Hi Manorit,

On 27/06/25 15:52, Manorit Chawdhry wrote:
> Hi Gokul,
> 
> On 14:52-20250627, Gokul wrote:
>> From: Gokul Praveen <g-praveen@ti.com>
>>
>> Add KASLR OPTEE RNG support across K3 devices by enabling the required
>> configs.
>>
>> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>> ---
>>   arch/arm/Kconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 7282c4123b0..cd27e5a5422 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -805,6 +805,9 @@ config ARCH_K3
>>   	select REGEX
>>   	select FIT_SIGNATURE if ARM64
>>   	imply TI_SECURE_DEVICE
>> +	imply DM_RNG
>> +	imply TEE
>> +	imply OPTEE
>>   
> 
> Does it get enabled for R5 based defconfigs too in .config? ARCH_K3 is
> enabled for both R5 and ARM64 cores so wondering if we are ending up
> enabling it for R5 too which might not be required ( or is it? )
> 
> Regards,
> Manorit
> 
No,it does not get enabled for R5 actually.

Regards
Gokul
>>   config ARCH_OMAP2PLUS
>>   	bool "TI OMAP2+"
>> -- 
>> 2.34.1
>>
