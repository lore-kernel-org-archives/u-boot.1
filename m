Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200C1C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 20:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D0428824A;
	Wed, 22 May 2024 22:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a/Zq5NM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 986928825A; Wed, 22 May 2024 22:18:56 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 182A3881C3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 22:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 80D99CE1300;
 Wed, 22 May 2024 20:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C770C2BBFC;
 Wed, 22 May 2024 20:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716409128;
 bh=mFxl5kECD+/JbOLOFgUMXECdEdfXiYnEuzwyIJbNL64=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=a/Zq5NM9Y/w2uRbPuuHd4ciHcqyuABEcUIGfLHIPuVHjPZ9HdAKjdf2EkZEvHdD1V
 GdPcXb6bUshtDwENiNQgj27rqo/pbxbi1W4gldfpu14TDywlDFH/a/1Tafe+5R/oyq
 t3VehSQUnn6aIPi/DR1F4hV5ybFRXKiQm3yJh7GEpjoPO2vX/694hr0pkkFyiXO1s0
 dGPXNvEc66nL7WQM4J+mGh7M5HCBkLaocFROntTdKlyoTxVtA3WL7nzXTS7fCrEb3H
 QrmHvpemWd08kzvQzPJbn/UkB3mRUjiQ01U89jRyLQad0raG057Sr6xlArbBs98MWX
 nql408cOoxD8g==
Message-ID: <d68c8045-116a-49c0-9e74-d6a366e6f008@kernel.org>
Date: Wed, 22 May 2024 23:18:40 +0300
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
 <25fb2205-77e8-42dd-a244-4114f028d2c7@kernel.org>
 <7f264a02-f80f-46fd-9aec-780b7bbe27bf@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <7f264a02-f80f-46fd-9aec-780b7bbe27bf@ti.com>
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



On 21/05/2024 08:34, Chintan Vankar wrote:
> 
> 
> On 20/05/24 17:42, Roger Quadros wrote:
>>
>>
>> On 25/04/2024 15:59, Chintan Vankar wrote:
>>>
>>>
>>> On 25/04/24 17:57, Roger Quadros wrote:
>>>>
>>>>
>>>> On 25/04/2024 15:08, Chintan Vankar wrote:
>>>>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>>>>
>>>>> In order to support Ethernet boot on AM62x, probe AM65 CPSW NUSS
>>>>> driver in board_init_f().
>>>>>
>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>>>> ---
>>>>>
>>>>> Link to v1:
>>>>> https://lore.kernel.org/r/20240112064759.1801600-8-s-vadapalli@ti.com/
>>>>>
>>>>> Changes from v1 to v2:
>>>>> - No changes.
>>>>>
>>>>>    arch/arm/mach-k3/am625_init.c | 10 ++++++++++
>>>>>    1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
>>>>> index 668f9a51ef..9bf61b1e83 100644
>>>>> --- a/arch/arm/mach-k3/am625_init.c
>>>>> +++ b/arch/arm/mach-k3/am625_init.c
>>>>> @@ -277,6 +277,16 @@ void board_init_f(ulong dummy)
>>>>>            if (ret)
>>>>>                panic("DRAM init failed: %d\n", ret);
>>>>>        }
>>>>> +
>>>>> +    if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
>>>>> +        spl_boot_device() == BOOT_DEVICE_ETHERNET) {
>>>>> +        struct udevice *cpswdev;
>>>>> +
>>>>> +        if (uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
>>>>> +                        &cpswdev))
>>>>> +            printf("Failed to probe am65_cpsw_nuss driver\n");
>>>>> +    }
>>>>> +
>>>>
>>>> This looks like a HACK.
>>>> The network driver should be probed only when the networking feature is actually required.
>>>>
>>>
>>> Driver is probed only when the condition above
>>> "spl_boot_device() == BOOT_DEVICE_ETHERNET" is true, which says Boot
>>> device is Ethernet, and here we are booting with Ethernet so driver is
>>> getting probed.
>>
>> I think you misunderstood what I was saying as am625_init.c is not using
>> any Ethernet function it should not cause the Ethernet driver to probe.
>>
>> Instead it should be probed by the networking use case.
>>
>> What happens if you don't use this patch? Where is it failing?
>>
> 
> You are correct that it should be probed by the networking use case and
> we are using networking functionality of "Booting via Ethernet".
> Regarding its probing, I already had discussion that why do I have to
> probe it explicitly at here:
> https://lore.kernel.org/r/ee1d16fd-b99b-4b07-97bb-a896e179157a@ti.com/
> 
> Now if I don't use this patch then Ethernet will not get initialized at
> SPL stage, and in "spl_net_load_image()" function, there will be an
> error saying "No Ethernet Found", and since we selected booting via
> Ethernet it will fail to boot.

OK Now I see the problem.

in am65-cpsw-nuss.c the following is defined:

> U_BOOT_DRIVER(am65_cpsw_nuss) = {
>         .name   = "am65_cpsw_nuss",
>         .id     = UCLASS_MISC,
>         .of_match = am65_cpsw_nuss_ids,
>         .probe  = am65_cpsw_probe_nuss,
>         .priv_auto = sizeof(struct am65_cpsw_common),
> };
> 
> U_BOOT_DRIVER(am65_cpsw_nuss_port) = {
>         .name   = "am65_cpsw_nuss_port",
>         .id     = UCLASS_ETH,
>         .probe  = am65_cpsw_port_probe,
>         .ops    = &am65_cpsw_ops,
>         .priv_auto      = sizeof(struct am65_cpsw_priv),
>         .plat_auto      = sizeof(struct eth_pdata),
>         .flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_OS_PREPARE,
> };

Now I suppose spl_net_load_image() tries to probe all UCLASS_ETH devices
which should call am65_cpsw_port_probe() but it fails to probe am65_cpsw_probe_nuss().

This limitation was introduced by commit
38922b1f4acc ("net: ti: am65-cpsw: Add support for multi port independent MAC mode")

which says "Since top level driver is now UCLASS_MISC, board
files would need to instantiate this driver explicitly.

I wonder if there can be a better solution to this?

-- 
cheers,
-roger
