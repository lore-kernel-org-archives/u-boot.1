Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3196EC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 14:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8955188B78;
	Fri, 19 Jul 2024 16:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=armadeus.com header.i=@armadeus.com header.b="erPiPhqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5509D88BBA; Fri, 19 Jul 2024 16:01:02 +0200 (CEST)
Received: from 7.mo582.mail-out.ovh.net (7.mo582.mail-out.ovh.net
 [46.105.59.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CE0788B65
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 16:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.17.234])
 by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4WQWY72x7Qz1QGY
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:00:59 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-snzmb (unknown [10.110.178.59])
 by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id E1E261FE98;
 Fri, 19 Jul 2024 14:00:58 +0000 (UTC)
Received: from armadeus.com ([37.59.142.107])
 by ghost-submission-6684bf9d7b-snzmb with ESMTPSA
 id voJaNZpxmmaX6AAAp8BpyQ
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Fri, 19 Jul 2024 14:00:58 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001c6110fe4-3ef8-43fd-9786-65078e3bf1b9,
 68270C7946175900C0D504C303ABE67534C2A4CF)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
Message-ID: <abf7f940-1bfb-4e5f-937b-135a580034b3@armadeus.com>
Date: Fri, 19 Jul 2024 16:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx93-u-boot: Describe the CPU clocks in the devicetree
To: Fabio Estevam <festevam@gmail.com>, peng.fan@nxp.com
Cc: uboot-imx@nxp.com, m.othacehe@gmail.com, u-boot@lists.denx.de
References: <20240718165454.904763-1-festevam@gmail.com>
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
In-Reply-To: <20240718165454.904763-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8186136751533976489
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrhedugdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnheptdeghedtudeltdduveevkeevveevfefftdehtdeikeegueekvedtffeigeetkefhnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdfovfetjfhoshhtpehmohehkedvpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=KNIAKsLp8uw6hRn5IQ58dGpEOfHBUVfff4+RnZxUnWw=; 
 c=relaxed/relaxed; d=armadeus.com; h=From;
 s=ovhmo103079-selector1; t=1721397659; v=1;
 b=erPiPhqLs52cEQMLjciH06KN2m1YQZr08Lx+f1jX5N4nCISnV2Hw3co/FdlsrhHTHfhQ0mHZ
 D0BeHhZAGsgiA9Ex6XjmMGUhq0wvdbRtSE8L1xw/VZvGs56DOQmevPrx1BJVuWyLOqvBDJttF/3
 ZIzTO9gYBXoCwoiDYPWN4ynm2jbCsYa8m9DzIBqpnJEEn2lk+G9rx3AqsK9iE29lnoBIGaQJ8jm
 OyyVUwbVEhSqAJDuR8sCzsDW0h7JFfhZhaLURr3bK2RtXW8CCcWe+BoMMwth7KIMRZsmY4gIE2z
 ZhTL/o1it2doqQfZ97BlkjuqLBs998hz3xrr9HHHYan5Q==
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

Hello Fabio,

On 7/18/24 18:54, Fabio Estevam wrote:
> Currently, there is an error when the i.MX93 CPU frequency is
> read:
> 
> Could not read CPU frequency: -2
> CPU:   NXP i.MX93(52) Rev1.1 A55 at 0 MHz
> 
> Fix it by describing the A55 clock nodes in the devicetree, like done
> on other i.MX SoCs.
> 
> With this change, the CPU frequency error is gone and it can be correctly
> retrieved:
> 
> CPU:   NXP i.MX93(52) Rev1.1 A55 at 1700 MHz
> CPU:   Industrial temperature grade  (-40C to 105C) at 35C
> 
> As the upstream imx93.dtsi does not describe the CPU clocks,
> keep the clock node in imx93-u-boot.dtsi for now.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>   arch/arm/dts/imx93-u-boot.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
> index 289aba175843..b2b3d57318fc 100644
> --- a/arch/arm/dts/imx93-u-boot.dtsi
> +++ b/arch/arm/dts/imx93-u-boot.dtsi
> @@ -9,6 +9,14 @@
>   	};
>   };
>   
> +&A55_0 {
> +	clocks = <&clk IMX93_CLK_ARM_PLL>;

Why IMX93_CLK_ARM_PLL and not IMX93_CLK_A55_SEL ?

Best regards,

> +};
> +
> +&A55_1 {
> +	clocks = <&clk IMX93_CLK_ARM_PLL>;
> +};
> +
>   &binman {
>   	u-boot-spl-ddr {
>   		align = <4>;

-- 
Sébastien Szymanski, Armadeus Systems
Software engineer

