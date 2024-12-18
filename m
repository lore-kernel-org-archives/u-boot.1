Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0562E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40AD280241;
	Wed, 18 Dec 2024 16:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734535365;
	bh=MCw1TJaHnfDnno+ZydgTxX38MeZJXdIPJeKbJ36PIQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LV/911tnmfXm4Nn0t1FOt43XJNWUWVuX/MIP303+6FjWOLg4hUsNFyZnqjQBj+2q0
	 JaBsNkgOjkKzUra1//xhl3X/USUC3LFf1BBbJCljJewM9fNkfuOjZpfPpXqTspV0NF
	 GpkwPS3UT5j/VGkkwrijr1ufWnNwwCZ5JbFTyUST69TFK4iozHenx0Bl3l3lMXQoXH
	 nh63mboA5Y6XtzrbRRB2xUkawIVfa8VsEpRmY8rRFTpDzSnYPMPtKdwJOyZ5Latv9I
	 fq10Aj5zmZ3FSjnLg1eLfbCwfEFcrupf7nJMVBKsZXbULlgiBQcua09YDbpZsbQ8Zj
	 T3JH1ISfwkDUg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0233780269; Wed, 18 Dec 2024 16:22:44 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D218022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BEnRtmbZ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 59C861048558D; Wed, 18 Dec 2024 16:22:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734535360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCw1TJaHnfDnno+ZydgTxX38MeZJXdIPJeKbJ36PIQk=;
 b=BEnRtmbZcACWIXPqrWnXb25I7yI52Yqn9aKKXXD/YkjQ5+GgVuHrsiGHXk8yUJX1veMj5j
 AO5/ajf+kN8a60poMWXsJLNwfUgf1uQdbjNzvLuGfbwddPiBpQ4PlDIhCgYiP83HM+BNwg
 D7L0TbRnjbRQIB59cHzgMNfuZx2QevyAv9Lb0LGCW1OzQ6ZX8S2KOMMrhaTWoVgB9uzh08
 Stn1rfULmVpFDyzrCqquwSefC/aaFilWnXIpIxTRUCgmconuHRaRbqvnkOYYjtQRJ+KAo9
 OTLHwffgEdtVHtmGlMNWkOFHQkZMT4vwyHwWtJXnJO5Ah0G6xkdH9BoiU5YGeQ==
Message-ID: <7cef71fc-7d7f-4c9f-b28c-e2b1ab893f75@denx.de>
Date: Wed, 18 Dec 2024 14:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: Fix the spi_nor_read() when config
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
References: <20241211120644.775575-1-venkatesh.abbarapu@amd.com>
 <fccae74a-3097-4172-8ae5-3bc72e8d9aa0@denx.de>
 <SA1PR12MB869702808B7A784031F17F83983B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <3307c1e3-123b-4ff1-8140-18be7393b5e5@denx.de>
 <SA1PR12MB86974EDF358A58732A9B7A6F983B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <7f2b69af-ea98-4d22-a831-e484811c9715@denx.de>
 <SA1PR12MB86975AD9D85A5F7865FF4AFD98052@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SA1PR12MB86975AD9D85A5F7865FF4AFD98052@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/18/24 10:22 AM, Abbarapu, Venkatesh wrote:

>>>>> For parallel/stacked configuration and address width the
>>>>> "rem_bank_len" will vary
>>>> and as we don't want to disturb the default read functionality added
>>>> the ifdef separately.
>>>> What would happen if both SPI_FLASH_BAR and SPI_STACKED_PARALLEL
>> are
>>>> enabled on a system that only has one SPI NOR attached
>>>> (non-stacked/parallel) ? I noticed the second "copy" of the code
>>>> behaves slightly differently in the else branch, so does that mean this would
>> break such setup ?
>>>
>>> If both SPI_FLASH_BAR and SPI_STACKED_PARALLEL are enabled, the
>> "rem_bank_len" manipulation is done under the
>> CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL) code and this won't break any
>> default functionality.
>> Wouldn't read_len calculation be done twice ?
> Yes.  As "rem_bank_len" will be changed based on parallel configuration, so added the additional code copy to not break the default code.
Can you please also update it to avoid the code duplication ?

Thank you
