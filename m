Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFB3CD5BA4
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 08:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F8E983E81;
	Thu, 21 May 2026 10:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="e1DXS7Dp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC10583E81; Thu, 21 May 2026 10:17:47 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCB248341A
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 10:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 060F4C2C64B;
 Thu, 21 May 2026 08:18:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C8E0260495;
 Thu, 21 May 2026 08:17:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 66066107EA1C0; 
 Thu, 21 May 2026 10:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779351464; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=YKtDNvPp5ogyXmt5e1611eS4z+y4FnrMdE7lPDjVDGM=;
 b=e1DXS7DpfhNOQQTes6VRKDVRdPYZRFbx76x3sUjyZVHFU7oQ6l69mYAk7P6MsNV23UoQh9
 0ZWduUe0KqM9L8qK03ugGu2NQUgT+9Zp5PNXMt07L1vxpuSjQv9GyIoIOPT5sYI4ju0Be6
 iBChOgkHpuYN/guDKTmZoeheLHfTmU1tTFtKVxWvTULLtu8AaNP7eq4Pg/0VQ2xMggrCVq
 jjCIX6/8ENvZCcn6WcrMcsLH1BIGzjHelgKlT9WgiDMWXiJuLzLUjC8gkH3NjgTE/Nt48K
 fLufK3inY4hwZhWVj1Bdas5QR0PN00RrRmKwd9/uvjFYX6d2ksBrP0TAy0bCBQ==
Message-ID: <1114b7fe-b2ca-41b4-bf7b-b0d8c5d9223c@bootlin.com>
Date: Thu, 21 May 2026 10:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] configs: j784s4_evm_r5: enable TI_SCI_POWER_DOMAIN
To: "Kumar, Udit" <u-kumar1@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Abhash Kumar <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-2-richard.genoud@bootlin.com>
 <67f8cce0-a13f-475a-917d-82be137c8053@ti.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <67f8cce0-a13f-475a-917d-82be137c8053@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 11/05/2026 à 11:49, Kumar, Udit a écrit :
> 
> 
> On 4/30/2026 2:13 PM, Richard Genoud (TI) wrote:
>> When resuming, we need the power domain driver to enable R5 cores.
>> So, enable TI_SCI_POWER_DOMAIN driver in R5 configuration.
>>
>> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
>> ---
>>   configs/j784s4_evm_r5_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
>> index 25ab6f17d175..35ac2287bcc7 100644
>> --- a/configs/j784s4_evm_r5_defconfig
>> +++ b/configs/j784s4_evm_r5_defconfig
>> @@ -124,6 +124,7 @@ CONFIG_PINCTRL=y
>>   CONFIG_SPL_PINCTRL=y
>>   CONFIG_PINCTRL_SINGLE=y
>>   CONFIG_POWER_DOMAIN=y
>> +CONFIG_TI_SCI_POWER_DOMAIN=y
>>   CONFIG_TI_POWER_DOMAIN=y
> 
> Wondering how this is helping, to deal with any power you have
> CONFIG_TI_POWER_DOMAIN

Indeed, it not useful here.
I'll drop it.

> 
>>   CONFIG_DM_PMIC=y
>>   CONFIG_PMIC_TPS65941=y
> 

Thanks!
Regards,
Richard
