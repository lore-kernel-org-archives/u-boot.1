Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22610CDDE7B
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 15:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F4E8919C;
	Wed, 23 Oct 2024 17:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VuNlVcq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B03A891A3; Wed, 23 Oct 2024 17:11:00 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7790189184
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 17:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XYXYV1zzKz9spX;
 Wed, 23 Oct 2024 17:10:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729696254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0ecRAJOc0nTRn3Qu+ryMPavGa0pqr9Rf7OIj6n4eOg=;
 b=VuNlVcq3H4reTUU/H4TpjFQjIL1XhiOgOt4exvl1jOALl8PGcXmwmLRldCuWLqCZ7aaNQU
 lwpAVZWp5iEzq8133fZyHof5lGdLhB+Nd7q3WICDWb9NNMKTqfx/KMMYm8WnxWzXvfbupT
 OwNQI5U3Ucw66TrUSTxi7M8sy04+Fx0I8POPoDi/Dc71166OLXmZpGnxDxwrI8ZCHP7vOY
 c0ybrDcQgYM6k9pRBdWAHvhXyRVfmL1enjGbzEudpAcRJDcgdJQiC0q8n7g8Q/7hP4aeLr
 dSOqhR34DyKNdo0DUcn3o5cLI66qOBBWXhGpIdBxnz8auOxOiMCwJjTrvmQCvA==
Message-ID: <c3c81551-ebc6-4d7a-8770-802b6435ca77@mailbox.org>
Date: Wed, 23 Oct 2024 17:10:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories support
 in QSPI driver"
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241022210633.271534-1-marek.vasut+renesas@mailbox.org>
 <SA1PR12MB8697AF99B0A56734FF65AD47984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <699f9d96-a109-40ab-9cd8-ed0c5b4b589f@mailbox.org>
 <SA1PR12MB869767A8D003AB114830D46A984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <03389ee7-3da9-4160-a193-00fd517ad56e@mailbox.org>
 <SA1PR12MB869722D8E2019193343572AF984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <SA1PR12MB869722D8E2019193343572AF984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9c1pbr83yopsre9zq6egecs5513memr6
X-MBO-RS-ID: 30904d7e4ccd7576eb8
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

On 10/23/24 4:14 PM, Abbarapu, Venkatesh wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Marek Vasut <marek.vasut@mailbox.org>
>> Sent: Wednesday, October 23, 2024 6:15 PM
>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.de
>> Cc: Andre Przywara <andre.przywara@arm.com>; Ashok Reddy Soma
>> <ashok.reddy.soma@amd.com>; Jagan Teki <jagan@amarulasolutions.com>;
>> Michael Walle <mwalle@kernel.org>; Simek, Michal <michal.simek@amd.com>;
>> Patrice Chotard <patrice.chotard@foss.st.com>; Patrick Delaunay
>> <patrick.delaunay@foss.st.com>; Pratyush Yadav <p.yadav@ti.com>; Quentin
>> Schulz <quentin.schulz@cherry.de>; Sean Anderson <seanga2@gmail.com>;
>> Simon Glass <sjg@chromium.org>; Takahiro Kuwano
>> <Takahiro.Kuwano@infineon.com>; Tom Rini <trini@konsulko.com>; Tudor
>> Ambarus <tudor.ambarus@linaro.org>; uboot-stm32@st-md-
>> mailman.stormreply.com
>> Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories support in
>> QSPI driver"
>>
>> On 10/23/24 11:07 AM, Abbarapu, Venkatesh wrote:
>>> Hi,
>>> Tested with the non-stacked default single configuration on ZynqMP zcu102 board
>> and didn’t see any issue.
>>>
>>> ZynqMP> sf probe 0 0 0
>>> SF: Detected mt25qu512a with page size 256 Bytes, erase size 64 KiB,
>>> total 64 MiB
>>> ZynqMP> sf erase 0x0 0x4000000;mw.b 0x8000 aabbccdd 0x4000000;sf write
>>> ZynqMP> 0x8000 0x0 0x4000000;mw.b 0x8008000 0x0 0x4000000;sf read
>>> ZynqMP> 0x8008000 0x0 0x4000000;cmp.b 0x8000 0x8008000 0x4000000
>>> SF: 67108864 bytes @ 0x0 Erased: OK
>>> device 0 whole chip
>>> SF: 67108864 bytes @ 0x0 Written: OK
>>> device 0 whole chip
>>> SF: 67108864 bytes @ 0x0 Read: OK
>>> Total of 67108864 byte(s) were the same
>>>
>>> Thanks
>>> Venkatesh
>>>
>>>> -----Original Message-----
>>>> From: Marek Vasut <marek.vasut@mailbox.org>
>>>> Sent: Wednesday, October 23, 2024 2:12 PM
>>>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; Marek Vasut
>>>> <marek.vasut+renesas@mailbox.org>; u-boot@lists.denx.de
>>>> Cc: Andre Przywara <andre.przywara@arm.com>; Ashok Reddy Soma
>>>> <ashok.reddy.soma@amd.com>; Jagan Teki <jagan@amarulasolutions.com>;
>>>> Michael Walle <mwalle@kernel.org>; Simek, Michal
>>>> <michal.simek@amd.com>; Patrice Chotard
>>>> <patrice.chotard@foss.st.com>; Patrick Delaunay
>>>> <patrick.delaunay@foss.st.com>; Pratyush Yadav <p.yadav@ti.com>;
>>>> Quentin Schulz <quentin.schulz@cherry.de>; Sean Anderson
>>>> <seanga2@gmail.com>; Simon Glass <sjg@chromium.org>; Takahiro Kuwano
>>>> <Takahiro.Kuwano@infineon.com>; Tom Rini <trini@konsulko.com>; Tudor
>>>> Ambarus <tudor.ambarus@linaro.org>; uboot-stm32@st-md-
>>>> mailman.stormreply.com
>>>> Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel
>>>> memories support in QSPI driver"
>>>>
>>>> On 10/23/24 5:18 AM, Abbarapu, Venkatesh wrote:
>>>>> Hi Marek,
>>>>> There was some issue and fix is sent
>>>>> https://lore.kernel.org/u-boot/20241018082644.22495-1-venkatesh.abba
>>>>> ra
>>>>> pu@amd.com/T/#u
>>>>
>>>> Is this one fix or three fixes for three different issues ?
>>>>
>>>> This seems to fix READ errors, which is apparently another error
>>>> introduced by this stuff. In my case, plain and simply 'sf probe ; sf
>>>> update' combination with single non- stacked SPI NOR does not work. Was such
>> a simple configuration ever tested ?
>>>>
>>>>> Not sure we need to revert whole parallel/stacked support?
>>>> Please stop top-posting.
>>
>> You ran completely different test on completely different chip.
>>
>> Stop top posting.
> 
> Sorry for top posting
> 
> Will try to get the spansion flash part and try the below tests.
> At this point tried testing on different board with different flash part.
> 
> Zynq> sf probe 0 0 0
> SF: Detected mx66l1g45g with page size 256 Bytes, erase size 64 KiB, total 128 MiB
> Zynq> sf update 0x4000000 0 0x160000
> device 0 offset 0x0, size 0x160000
> 1441792 bytes written, 0 bytes skipped in 5.735s, speed 257435 B/s
I'm sorry, I missed this ^ part.
