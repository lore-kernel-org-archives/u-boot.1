Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E67AC04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 12:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97C6388247;
	Mon, 20 May 2024 14:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IxCWJ2eq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82D6F8824B; Mon, 20 May 2024 14:12:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 024B388229
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 14:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6A0A061C47;
 Mon, 20 May 2024 12:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69675C2BD11;
 Mon, 20 May 2024 12:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716207169;
 bh=lOrtLt96STv4qbRVGvARfUQpCimVF70OILUZSEgKYIo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IxCWJ2eqJI8JqYYR3g1tBZ23oXRFqDFCYgraly9FTWLc8rUaa9QqXnKE3GtN4w/LP
 8gH6cfvhR2dwxHs2Y2oIvYxRNSy7/LvzzXNp0XD++7xJnM011Ls8sWn6qALCEnMGyz
 iIpCHWZMrnDkIFynm+Rpas9KEJ8G4jRWzxmkX9tWPD6Ks47v0kbhpN77Kdz0kp1EDA
 fm8wkZB97o0eKSUEXCFju7TiSjrYpcgVQn1NLd0jYAYSAcmvRQfAREmPRjS40SOHjr
 ffQpZEu58XVC9F0DT16wPB/zpjOxkLxSiiT9iaonP3BU5Pl0kHMvY3AR3cNTe54CbB
 CHMg9JHvv7ebA==
Message-ID: <25fb2205-77e8-42dd-a244-4114f028d2c7@kernel.org>
Date: Mon, 20 May 2024 15:12:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] arm: mach-k3: am625_init: Probe AM65 CPSW NUSS
To: Chintan Vankar <c-vankar@ti.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng@tinylab.org>, Sean Anderson <seanga2@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Andrew Davis <afd@ti.com>, Maxime Ripard <mripard@kernel.org>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240425120822.2048012-1-c-vankar@ti.com>
 <20240425120822.2048012-7-c-vankar@ti.com>
 <84312b9f-7b30-4da1-91a0-067e94cb420a@kernel.org>
 <29092012-e708-4676-99e3-cd8ef64cd701@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <29092012-e708-4676-99e3-cd8ef64cd701@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 25/04/2024 15:59, Chintan Vankar wrote:
> 
> 
> On 25/04/24 17:57, Roger Quadros wrote:
>>
>>
>> On 25/04/2024 15:08, Chintan Vankar wrote:
>>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>>
>>> In order to support Ethernet boot on AM62x, probe AM65 CPSW NUSS
>>> driver in board_init_f().
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>> ---
>>>
>>> Link to v1:
>>> https://lore.kernel.org/r/20240112064759.1801600-8-s-vadapalli@ti.com/
>>>
>>> Changes from v1 to v2:
>>> - No changes.
>>>
>>>   arch/arm/mach-k3/am625_init.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
>>> index 668f9a51ef..9bf61b1e83 100644
>>> --- a/arch/arm/mach-k3/am625_init.c
>>> +++ b/arch/arm/mach-k3/am625_init.c
>>> @@ -277,6 +277,16 @@ void board_init_f(ulong dummy)
>>>           if (ret)
>>>               panic("DRAM init failed: %d\n", ret);
>>>       }
>>> +
>>> +    if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
>>> +        spl_boot_device() == BOOT_DEVICE_ETHERNET) {
>>> +        struct udevice *cpswdev;
>>> +
>>> +        if (uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
>>> +                        &cpswdev))
>>> +            printf("Failed to probe am65_cpsw_nuss driver\n");
>>> +    }
>>> +
>>
>> This looks like a HACK.
>> The network driver should be probed only when the networking feature is actually required.
>>
> 
> Driver is probed only when the condition above
> "spl_boot_device() == BOOT_DEVICE_ETHERNET" is true, which says Boot
> device is Ethernet, and here we are booting with Ethernet so driver is
> getting probed.

I think you misunderstood what I was saying as am625_init.c is not using
any Ethernet function it should not cause the Ethernet driver to probe.

Instead it should be probed by the networking use case.

What happens if you don't use this patch? Where is it failing?

> 
>>>       spl_enable_cache();
>>>         fixup_a53_cpu_freq_by_speed_grade();
>>

-- 
cheers,
-roger
