Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C9AE7718B
	for <u-boot@archiver.kernel.org>; Wed, 25 Dec 2024 20:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B4A8036E;
	Wed, 25 Dec 2024 21:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1735159804;
	bh=QjsfKSfReaA21qyoN0K1ZZHec7M/OkxjAEsLLmiTl5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GihQTYUJ3LC8K6pxh8FakYSOvQFdpsOEGi8c3ETyq/1W3XqD1/vU/97TFs3FxZU9N
	 82y/kLG/p7a1/ALh3Fd4VHdHRLKWVfS88NrNbLzNUhyHfXz69Q+mfLbXGVZEXv2e1E
	 Ud5Ib8oN7flpycW00oMg+4Nk/O29E4iFSHFL6ypNTKYaoR5dLaY2sKrdIR3cTc70wr
	 ukRHFeHpQE0bH8QuPhpYd7Q2tA/HyLdYdKElLDAe4WDlRZWcCn1V5bMPG1P/CzBRNi
	 pLmJajeyBkQ5d9u9xWR+BHkeaKHJQ4x8mJtDcHb9DQvVpIUNUyQUTXsc0S45Kj9iB1
	 K4FKE/ThCpg5w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB0480374; Wed, 25 Dec 2024 21:50:02 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF1DC8034E
 for <u-boot@lists.denx.de>; Wed, 25 Dec 2024 21:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="OI7lclM7"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EF0FE1040DBCA; Wed, 25 Dec 2024 21:49:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1735159797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QjsfKSfReaA21qyoN0K1ZZHec7M/OkxjAEsLLmiTl5Y=;
 b=OI7lclM7i89ODU59E90tRm0J6fB8fCknRMDXpTtRQ3Kqw6DpOiCsc2tjDffRdT1UEiDcci
 ZnXdhghrRBxh+hUeyHUNBnJ6EUZC/Rozwl/xvevL8PKd1+5QiKMCdsmMrTlXi5GggdF2pu
 DQFH5XiD7eaVXUvysSV1R3L/Wn+oaMTm7jhCb9jhoTKtI1eteZTdmgtHWyviPqLEbQx7w8
 7D3yhRh+VFSWC97wysLVNLXfzCBS7fPU7GAjlfXvPASCi8rQoIJEzhYL4oEiZopYsJDudQ
 BU91g+FsBnhV+2GzEnDRz/MF0Yoa/1t/Tl7HsCksLYUEzV3P4kAXLx1T9XiXbQ==
Message-ID: <148a7bd2-a243-4964-948d-abd3545b9e41@denx.de>
Date: Wed, 25 Dec 2024 21:20:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
 "j-humphreys@ti.com" <j-humphreys@ti.com>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "william.zhang@broadcom.com" <william.zhang@broadcom.com>,
 "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
References: <20241220143006.1921705-1-venkatesh.abbarapu@amd.com>
 <63291d8d-ca66-4e8a-a9aa-efba47a1f505@denx.de>
 <SA1PR12MB86971D338EE7CCDED324172D98032@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SA1PR12MB86971D338EE7CCDED324172D98032@SA1PR12MB8697.namprd12.prod.outlook.com>
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

On 12/24/24 4:34 PM, Abbarapu, Venkatesh wrote:

[...]

>>> @@ -1593,18 +1595,23 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t
>> from, size_t len,
>>>    	}
>>>
>>>    	while (len) {
>>> -		bank = (u32)from / SZ_16M;
>>> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
>>> -			bank /= 2;
>>> -
>>> -		rem_bank_len = SZ_16M * (bank + 1);
>>> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
>>> -			rem_bank_len *= 2;
>>> -		rem_bank_len -= from;
>>> -
>>> +		size_t read_len = len;
>>
>> size_t read_len should be declared at the beginning of this function.
>>
>>>    		offset = from;
>>>
>>> +	if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
>>
>> The indent here needs to be pushed on tab RIGHT -> .
>>
>> Do you need this functionality in SPL ? If so, you might need a matching Kconfig
>> SPL_SPI_STACKED_PARALLEL symbol .
> 
> This functionality is not needed for SPL.

So SPL does use SPI NOR in non-stacked/parallel mode, and U-Boot does 
use it in stacked/parallel mode ? Doesn't that pose a problem ?

[...]

> FLASH_BAR and stacked parallel configuration doesn’t depend on each other.
Is the use of BAR register and stacked/parallel mode mutually exclusive 
or can they be used together ?
