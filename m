Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B08C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 03:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4153D886DF;
	Mon, 26 Aug 2024 05:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="avPfiV8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 607A08891B; Mon, 26 Aug 2024 05:54:46 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A70AD8852A
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 05:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47Q3sMD4015861;
 Sun, 25 Aug 2024 22:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724644462;
 bh=JFSvuVl8evaNBv06xSlLFyj1MOl22RP7xhXXCk9Csgc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=avPfiV8nHjwkZJHpX4JqWOQesr/usPKTjIbd9Th7wrX+rQxeQQZ/AfhHsdJL9zRoz
 zUIcWshbEo6y27v2K59mREoveO+JCw3zB/VjXsOfx3HjLwDMl6JIYatosTclnAAFP1
 CSm4DJvC4q4v65qRntnPjxbrHFz6H0s8JmpAPYfk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47Q3sMC2125343
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 25 Aug 2024 22:54:22 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 25
 Aug 2024 22:54:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 25 Aug 2024 22:54:21 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47Q3sD5f028860;
 Sun, 25 Aug 2024 22:54:14 -0500
Message-ID: <7524f32d-d420-4a76-85c9-f84f7bb7b5e8@ti.com>
Date: Mon, 26 Aug 2024 09:24:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] soc: ti: k3-navss-ringacc: Fix reset ring API
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>,
 "dannenberg@ti.com" <dannenberg@ti.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "n-jain1@ti.com" <n-jain1@ti.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "afd@ti.com" <afd@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "seanga2@gmail.com"
 <seanga2@gmail.com>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>, "d-gole@ti.com"
 <d-gole@ti.com>, "danishanwar@ti.com" <danishanwar@ti.com>,
 "devarsht@ti.com" <devarsht@ti.com>,
 "w.egorov@phytec.de" <w.egorov@phytec.de>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>, "jonas@kwiboo.se"
 <jonas@kwiboo.se>, "kishon@ti.com" <kishon@ti.com>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>, "nm@ti.com" <nm@ti.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "u-kumar1@ti.com" <u-kumar1@ti.com>, "bb@ti.com"
 <bb@ti.com>, "rogerq@kernel.org" <rogerq@kernel.org>, "kabel@kernel.org"
 <kabel@kernel.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "srk@ti.com" <srk@ti.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-5-c-vankar@ti.com>
 <047e9aff7ac10f52cd3afb052da6874eb4ebbdda.camel@siemens.com>
 <d9419b64-a2c7-4f73-b401-4f2e71a6bf40@ti.com>
 <9328c6779d5c4bfecf09708e854aad5adac79861.camel@siemens.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <9328c6779d5c4bfecf09708e854aad5adac79861.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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



On 23/08/24 16:03, Sverdlin, Alexander wrote:
> Hi Chintan,
> 
> On Fri, 2024-08-23 at 15:22 +0530, Chintan Vankar wrote:
>> On 16/08/24 17:58, Sverdlin, Alexander wrote:
>>> Hi Chintan, Vignesh,
>>>
>>> On Fri, 2024-07-05 at 10:20 +0530, Chintan Vankar wrote:
>>>> From: Vignesh Raghavendra <vigneshr@ti.com>
>>>>
>>>> Expectation of k3_ringacc_ring_reset_raw() is to reset the ring to
>>>> requested size and not to 0. Fix this.
>>>>
>>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>>> ---
>>>>
>>>> Link to v2:
>>>> https://lore.kernel.org/r/20240425120822.2048012-5-c-vankar@ti.com/
>>>>
>>>> Changes from v2 to v3:
>>>> - No changes.
>>>>
>>>>     drivers/soc/ti/k3-navss-ringacc-u-boot.c | 9 ++++++++-
>>>>     1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/soc/ti/k3-navss-ringacc-u-boot.c b/drivers/soc/ti/k3-navss-ringacc-u-boot.c
>>>> index f958239c2a..5d650b9de7 100644
>>>> --- a/drivers/soc/ti/k3-navss-ringacc-u-boot.c
>>>> +++ b/drivers/soc/ti/k3-navss-ringacc-u-boot.c
>>>> @@ -25,9 +25,16 @@ struct k3_nav_ring_cfg_regs {
>>>>     #define KNAV_RINGACC_CFG_RING_SIZE_ELSIZE_MASK		GENMASK(26, 24)
>>>>     #define KNAV_RINGACC_CFG_RING_SIZE_ELSIZE_SHIFT		(24)
>>>>     
>>>> +#define KNAV_RINGACC_CFG_RING_SIZE_MASK			GENMASK(15, 0)
>>>> +
>>>>     static void k3_ringacc_ring_reset_raw(struct k3_nav_ring *ring)
>>>>     {
>>>> -	writel(0, &ring->cfg->size);
>>>> +	u32 reg;
>>>> +
>>>> +	reg = readl(&ring->cfg->size);
>>>> +	reg &= KNAV_RINGACC_CFG_RING_SIZE_MASK;
>>>
>>> should it actually be "reg &= ~KNAV_RINGACC_CFG_RING_SIZE_MASK;"?
>>> Otherwise you could potentially bump the size to some number higher than ring->size
>>> if you "OR" ring->size with something lower than ring->size and ring->size is not
>>> N^2-1?
>>>
>>
>> Hello Alexander, I didn't get your comment, can you explain in more
>> detail?
> 
> What is the exact purpose of "reg &= KNAV_RINGACC_CFG_RING_SIZE_MASK;"?
> Which corner case is handled by it?
> 
> What happens if ring->cfg->size contains "1" and ring->size contains "2"?
> What will be written into ring->cfg->size?
> 

Hello Alexander, Thank you for asking above questions, I got your point.
You are correct that we need to "AND" negation of
KNAV_RINGACC_CFG_RING_SIZE_MASK with reg.

By doing so we can avoid clearing out fields other than size, and also
at the same time it will make sure to clear size field in
ring->cfg->size and later we can "OR" it with requested size to not
change other field in the reg and only update the size field.

I hope this is what you wanted to say at your very first comment.


>>>> +	reg |= ring->size;
>>>> +	writel(reg, &ring->cfg->size);
>>>>     }
>>>>     
>>>>     static void k3_ringacc_ring_reconfig_qmode_raw(struct k3_nav_ring *ring, enum k3_nav_ring_mode mode)
> 
