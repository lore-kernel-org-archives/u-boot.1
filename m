Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03495C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 15:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77F9C884E2;
	Fri, 19 Jul 2024 17:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=armadeus.com header.i=@armadeus.com header.b="NykuTlez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F7438852E; Fri, 19 Jul 2024 17:47:46 +0200 (CEST)
Received: from 6.mo576.mail-out.ovh.net (6.mo576.mail-out.ovh.net
 [46.105.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D6988315
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director3.ghost.mail-out.ovh.net (unknown [10.108.9.56])
 by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4WQYwH3Xyqz1XkF
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 15:47:43 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-5bt55 (unknown [10.110.168.219])
 by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0F8591FD7B;
 Fri, 19 Jul 2024 15:47:43 +0000 (UTC)
Received: from armadeus.com ([37.59.142.104])
 by ghost-submission-6684bf9d7b-5bt55 with ESMTPSA
 id 4PFgAZ+KmmaYCwEAzz2HBQ
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Fri, 19 Jul 2024 15:47:43 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005bac1b0eb-5bd7-4765-9cfe-7a77f309ff61,
 68270C7946175900C0D504C303ABE67534C2A4CF)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
Message-ID: <e1645877-d5b8-44f5-b185-5427b28fa2e7@armadeus.com>
Date: Fri, 19 Jul 2024 17:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx93-u-boot: Describe the CPU clocks in the devicetree
To: Fabio Estevam <festevam@gmail.com>
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, m.othacehe@gmail.com,
 u-boot@lists.denx.de
References: <20240718165454.904763-1-festevam@gmail.com>
 <abf7f940-1bfb-4e5f-937b-135a580034b3@armadeus.com>
 <CAOMZO5D4FFvK=L+GwdfpLAyGBV2d2t-9d3GGTAuXYU0jt3kfjg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Autocrypt: addr=sebastien.szymanski@armadeus.com; keydata=
 xsBNBFNfZLEBCACv1lqSePHJNpRgcnER+3emy+Arjz84zFax3XkogjY/e3ZneihIgWrVKe5M
 ql16pX4KTkzNgMUKz4bG/XwT3kjcrXshxFLlg7KrHMl287C+W+QOUjnjVeRi/su+SPmjz8VD
 yr11h+ZkVLAWhS+uQJ93jy1NwG8M4t1kBLAVHHD5Vw4FJ+3ouaVYIp1X1Cr8bVKQw33Q1aTd
 ro0kMBb96B9vNu7ciJZ3gvlaBzUEKOgNnq9KaywuLnqrqr4HUIn5JuxZjCjJzt9kTAKcTfp2
 cJM8qpp+2FF5qtbkse9fZ6M64qozgOPr9Tk4Amf9fZEUQ6UNw14mmBZuXSzoHe75gI7TABEB
 AAHNN1PDqWJhc3RpZW4gU1pZTUFOU0tJIDxzZWJhc3RpZW4uc3p5bWFuc2tpQGFybWFkZXVz
 LmNvbT7CwJAEEwEIADoCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgBYhBJwGygpYm/1C
 /GCmwbCaKeiBMmTiBQJdhIHLAAoJELCaKeiBMmTixXIH/2W3kbzRG0UF81jtRRnp0H83rjDT
 v0H+8fgFMRL/7HCJ1QPArkfRJlM2wlJkN+ChP09CCarYfUEHfRCHlTb7At6Yyrz1jziD7ZwX
 8IWHYRXnZkY5eZc5DsiUgq6JH49kt+GPzK8UVP9MTa6zkBpPCUf7LzZ4pD3FihdkT52BU3gI
 d9P49fSI0TYySlb/VKn815aOhvwEr7+Dh3mZUjSh7saofbRmVUOr7p+R3MvvGI19/IJZjeOE
 ZWliODDOt6HnBOtoGSXMcNIFF6snH52D5N5gY88njZjTwhgGGUBix1bsgf/EY0v4R5itZBXB
 B/Ze4Tm++YHaB75hZK6PQu/YRv7OwE0EU19ksQEIALo7jhXddrXBTRu5SAjelV53jyHBJTX/
 vN4nL/VbbW/saca+NJjDSxx5DBmotZbQdWIyZiSIjU/xnTREvtDrl6ZeSsKWd7ZqiuiY4fSR
 zwuQp9rd0yqRuxesrWeyJB1zCSdEvLyKASERt+nxkOA+IzJ4y1qLtvnWr+SL1AXgTMw+Tkyw
 KIDCRWHTIYas11ldGj82gOIpYeXnapeNLHfT4EQwg0NeWYHynJxAQWiX5aPlw0uSpAQSsBXQ
 FIe3fpoveMSnXK+PG2BBOzexYv7r4S70a6sF9sgTTPpfKqUaqqC+u1+bUX6alTAKhGKJywaF
 6ViqLlgY8PfwohSyAlqlTRMAEQEAAcLAdgQYAQgAIAIbDBYhBJwGygpYm/1C/GCmwbCaKeiB
 MmTiBQJdhIHSAAoJELCaKeiBMmTitU8IAK7NQM3fEwaF5XaKtepYWsVka44CD8A9e4r7NVK9
 ugirKvXirIxBSDmN/Db862NmVpITsZ6ERNSNZLm/7k55N+TexKYiFZeU7G92TEfAM6qPElvx
 DLEcrkNMq9r08YZeUloacsq31AL5fK4LW+xdvXudkdiKRMJsdTpmff3x5kIziGOHjwFP9wve
 ZgEH52gpbRsP8Whx/Z2lNX/BBRmFM8OnEXFsjjqDzYThdxTq85wGPpkgvvUGyPNRD7TpbB1C
 pajOUUkPxgj5LKt77HD1afeZNudWhgcdkbtT5PMQTT0WY6wvMEj9S1+bGPeXRGWLYB7gHQ+L
 JNoSD7Kz6Y9qnKo=
In-Reply-To: <CAOMZO5D4FFvK=L+GwdfpLAyGBV2d2t-9d3GGTAuXYU0jt3kfjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9988702498653072297
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrhedugdelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnheptdeghedtudeltdduveevkeevveevfefftdehtdeikeegueekvedtffeigeetkefhnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=lFmHPWHh4W99xWS50kX34VYDR8PXPUCrZqbiyZjhrn4=; 
 c=relaxed/relaxed; d=armadeus.com; h=From;
 s=ovhmo103079-selector1; t=1721404063; v=1;
 b=NykuTlezVN4AlYNHgRwbEd5Rwyvp2jJXE3Mjt4ayZVcai/kbRKYRdYmhorI0Un3icRVms3wL
 LPlpmae7XhBoVttHs4FfPr0P0ecyZ4J1jA0HzTOSgCz9yPS5J8jq4L2I4JB8rKdypwt32BKVIR6
 WPchNQ/6g1oeXpMWDjJhm1zdYoWSaByGkPkJra4BzNS6OorYY7jA5HfbpKaFKrcFCutb3l1LVbJ
 oK4ggypYwRSkv8jKapqOH9tf2feILQxMSnkQte1b4UvzlR2ft6QMw7CuDVrARkJXSt2YH+iJlCC
 Jr0f0slF0Lz4g/6+vZIryGkWEGyWw54f4S2BeeE7HcBog==
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

On 7/19/24 16:13, Fabio Estevam wrote:
> Hi Sébastien,
> 
> On Fri, Jul 19, 2024 at 11:00 AM Sébastien Szymanski
> <sebastien.szymanski@armadeus.com> wrote:
> 
>>> +&A55_0 {
>>> +     clocks = <&clk IMX93_CLK_ARM_PLL>;
>>
>> Why IMX93_CLK_ARM_PLL and not IMX93_CLK_A55_SEL ?
> 
> IMX93_CLK_A55_SEL is a mux that can select between a55_alt versus arm_pll.
> 
> The real CPU clock is IMX93_CLK_ARM_PLL, so this one better represents it.

Ok, thank for the explanation.

> 
> This is also consistent with the other i.MX8M SoCs.
> 
> Take imx8mm.dtsi for example:
> 
> A53_0: cpu@0 {
> ....
>       clocks = <&clk IMX8MM_CLK_ARM>;
> 
> This also uses the "real" CPU clock, not the mux one (imx8mm_a53_sels).
> 
> I also plan to upstream this clock change to the Linux devicetree.

I did look at imx8mm.dtsi but the clock IMX8MM_CLK_ARM is not defined in 
U-Boot and in Linux it's defined as:

hws[IMX8MM_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
                                      hws[IMX8MM_CLK_A53_CORE]->clk,
				     hws[IMX8MM_CLK_A53_CORE]->clk,
                                      hws[IMX8MM_ARM_PLL_OUT]->clk,
				     hws[IMX8MM_CLK_A53_DIV]->clk);

So in Linux for the i.MX93, the clocks property in the device tree has 
to be IMX93_CLK_A55_CORE:

clks[IMX93_CLK_A55_CORE] = imx_clk_hw_cpu("a55_core", "a55_sel",
					clks[IMX93_CLK_A55_SEL]->clk,
					clks[IMX93_CLK_A55_SEL]->clk,
					clks[IMX93_CLK_ARM_PLL]->clk,
					clks[IMX93_CLK_A55_GATE]->clk);

?

Regards,

> 
> Thanks

-- 
Sébastien Szymanski, Armadeus Systems
Software engineer

