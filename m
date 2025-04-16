Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF629C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 08:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA06E82CE7;
	Wed, 16 Apr 2025 10:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z73xpj1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D7782CF6; Wed, 16 Apr 2025 10:17:42 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B495A81E72
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 10:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G8HYJj276132
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 03:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744791454;
 bh=CVbZSIcv/wluRV2ZfQp5vG6khwYfNmAJNEdllUEdgik=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Z73xpj1XiIR7qMc0DPdN+GcdX5TH9neGHLK5KtkmJc8sCBH3xUbQcfhpN9RvEa60O
 P8uQmrw8hDHs8FXK2d2hn1vkrc8qZTzRSTpPpQrWOqMlfZk3zQuFEcSuXb8LsLoqOH
 Hz1ZBsPH4tqezAioxm7Ukv17GRT5/wKttjqP2NcY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G8HY7H023267
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 03:17:34 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 03:17:33 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 03:17:33 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G8HUI0121047;
 Wed, 16 Apr 2025 03:17:31 -0500
Message-ID: <cecd2c70-92bf-4e7f-a3b5-b4fde4635044@ti.com>
Date: Wed, 16 Apr 2025 13:47:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2 v2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Moteen Shah <m-shah@ti.com>, Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <alpernebiyasak@gmail.com>, 
 <quentin.schulz@cherry.de>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <a-chavda@ti.com>
References: <20250327080642.2269856-1-m-shah@ti.com>
 <20250327080642.2269856-2-m-shah@ti.com>
 <CAFLszTjB+HuX68tmTrLP=gbbpzt0kJr22137cSLiedx6bh6PVw@mail.gmail.com>
 <3d2c894b-11f1-462c-b9f5-8d3f45dc0b61@ti.com>
 <CAFLszThs5W+=tFpUsCE0Qi5mvuymtsHF57jeLpV9KUQfGXBXnA@mail.gmail.com>
 <3287617e-3b6a-4387-90d4-7bbfc810f9c7@ti.com>
 <ec117e91-7b13-4ca9-8509-3075d7071427@ti.com>
 <CAFLszTjD+Aofu8jLMyX4FPxatmt_SaRC8amf7rziNmNKECFrGQ@mail.gmail.com>
 <f39453a5-fdaa-4fab-8230-0d8ddcacb040@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <f39453a5-fdaa-4fab-8230-0d8ddcacb040@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hello Moteen

On 4/16/2025 1:23 PM, Moteen Shah wrote:
> Hey Simon,
>
> I missed some essential build instructions I should have given to you, 
> apologies.

I assume our u-boot public document should capture this information,

It not, then please fix


>
> 1. Clone ti-linux-firmware: 
> https://git.ti.com/git/processor-firmware/ti-linux-firmware.git and 
> switch to ti-linux-firmware-next branch
> 2. Clone U-Boot: https://github.com/Jamm02/U-Boot-patchwork
> 3. Set variables :
>         $ export CC64=aarch64-linux-gnu-
>         $ export LNX_FW_PATH=path/to/ti-linux-firmware
>         $ export UBOOT_CFG_CORTEXA=j7200_evm_a72_defconfig
>
> 4. Inside U-Boot source:
>         $ touch bl31.bin
>         $ touch tee-raw.bin
>         $ make $UBOOT_CFG_CORTEXA
>         $ make CROSS_COMPILE=$CC64 BINMAN_INDIRS=$LNX_FW_PATH \
>                      BL31=bl31.bin \
>                      TEE=tee-raw.bin
>
> Let me know if this works.
>
> Regards,
> Moteen
>
> On 15/04/25 00:18, Simon Glass wrote:
>> Hi Moteen,
>>
>> On Thu, 10 Apr 2025 at 05:39, Moteen Shah <m-shah@ti.com> wrote:
>>> Hey Simon,
>>>
>>> Is the problem discussed in the thread an actual bug or am I missing
>>> something in the implementation?
>>>
>>> Regards,
>>> Moteen
>>>
>>> On 03/04/25 11:51, Moteen Shah wrote:
>>>> Hey Simon,
>>>>
>>>> On 03/04/25 00:52, Simon Glass wrote:
>>>>> Hi Moteen,
>>>>>
>>>>> On Wed, 2 Apr 2025 at 22:01, Moteen Shah <m-shah@ti.com> wrote:
>>>>>> Hey Simon,
>>>>>>
>>>>>> On 29/03/25 05:17, Simon Glass wrote:
>>>>>>> Hi Moteen,
>>>>>>>
>>>>>>> On Thu, 27 Mar 2025 at 08:06, Moteen Shah <m-shah@ti.com> wrote:
>>>>>>>> Add a function to scan through all the nodes in the device-tree
>>>>>>>> recusively for bootph-* property. If found, propagate it to all
>>>>>>>> of its parent nodes up the hierarchy.
>>>>>>>>
>>>>>>>> Signed-off-by: Moteen Shah <m-shah@ti.com>
>>>>>>>> ---
>>>>>>>> [..]
