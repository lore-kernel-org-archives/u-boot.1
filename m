Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626EFC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 04:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9761082CFA;
	Tue, 29 Jul 2025 06:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oFtmo+QR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91EBD82D21; Tue, 29 Jul 2025 06:03:21 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DD2782CBB
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 06:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4brhXP3TKmz9tbL;
 Tue, 29 Jul 2025 06:03:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753761797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0yZDVs8hL+75fOHZKF0G37rm4qFxQfyDfih2PXTOTPg=;
 b=oFtmo+QRRPmafC0THbfMyXyoGGdu6sGfi6rqAVzGyDzn4yX8QU+XGLHbiwCYHdEtJpEokI
 it3vM/sg7yk2WhgqshZLjcE2SsRqBoALZ/V6j9hYWGEmmaf7rCcRzj3rg97gmOSW2hnSah
 D0G4YXjwlPUOno9Kqp6g86MeJYCFZyBuQLq6fD0tHzctPS8zlNh20gCDLaZI8GST4+27a4
 vg2jw1zZ+SNVorfO37dZtKrB1/8awoF0+gUezUqt9p5s1CcJgjlrd3MsZYHMbpGOiK39j9
 g2146dzd90AgGfGUeMkQjqeQdikWrrLfPhxijwkzfp4tWIgyPvGhEST2Y+XzEw==
Message-ID: <4199ed7b-77ed-4c4c-9da4-60843d25f57a@mailbox.org>
Date: Tue, 29 Jul 2025 06:03:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] reset: stm32: Fix header misuse
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20250630000926.952277-1-marek.vasut@mailbox.org>
 <8341a0eb-4182-4c40-9f0a-26b92941c18e@foss.st.com>
 <0c691188-9216-4f0c-ba42-73df986372e0@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <0c691188-9216-4f0c-ba42-73df986372e0@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f20af5ad017c54451aa
X-MBO-RS-META: 8fgn9nqgj9c7m44q5mfbpousc8f1ym98
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

On 6/30/25 8:20 AM, Patrice CHOTARD wrote:

Hi,

>>> diff --git a/drivers/reset/stm32/stm32-reset.c b/drivers/reset/stm32/stm32-reset.c
>>> index 975f67f712a..918e81e588f 100644
>>> --- a/drivers/reset/stm32/stm32-reset.c
>>> +++ b/drivers/reset/stm32/stm32-reset.c
>>> @@ -5,7 +5,7 @@
>>>    */
>>>   
>>>   #include <dm.h>
>>> -#include <stm32-reset-core.h>
>>> +#include "stm32-reset-core.h"
>>>   
>>>   /* Timeout for deassert */
>>>   #define STM32_DEASSERT_TIMEOUT_US	10000
>>
>> Which version of gcc do you use ? on my side i got no issue with arm-none-eabi-gcc (Arm GNU Toolchain 14.2.Rel1 (Build arm-14.52)) 14.2.1 20241119
>> But nevertheless :
>>
>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Thanks
>> Patrice
>>
> 
> I double checked, in fact for AARCH64, i am using aarch64-none-elf-gcc (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621 which is out of date.

2025.10-rc1 is now out, this is still broken.

-- 
Best regards,
Marek Vasut
