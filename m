Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CE9CDB483
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 13:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D291A86E77;
	Fri, 13 Oct 2023 15:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BCC386E5E; Fri, 13 Oct 2023 15:05:25 +0200 (CEST)
Received: from 8.mo576.mail-out.ovh.net (8.mo576.mail-out.ovh.net
 [46.105.56.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51C6786ED0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director1.ghost.mail-out.ovh.net (unknown [10.108.1.202])
 by mo576.mail-out.ovh.net (Postfix) with ESMTP id DDEBC23BF4
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 13:05:18 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-bm8bq (unknown [10.111.172.111])
 by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 32A921FE9D;
 Fri, 13 Oct 2023 13:05:18 +0000 (UTC)
Received: from armadeus.com ([37.59.142.101])
 by ghost-submission-6684bf9d7b-bm8bq with ESMTPSA
 id g/JHB45AKWVKNQAAKSu0LQ
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Fri, 13 Oct 2023 13:05:18 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G00456f55dc4-3929-46ae-8e4b-25432a9021a5,
 7C22F39476E699F77263983D1F603F73B3003938)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
Message-ID: <05121e6e-5c0f-4083-9be9-2bd542f47c01@armadeus.com>
Date: Fri, 13 Oct 2023 15:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] clk: imx: add i.MX93 CCF driver
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
References: <20230725080856.26567-1-sebastien.szymanski@armadeus.com>
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
In-Reply-To: <20230725080856.26567-1-sebastien.szymanski@armadeus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4651655467520813989
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrieefgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhepgeegffegfeeileehueehudelteefgfdtjeduudfhledvjeeggefguefgkedtfefgnecuffhomhgrihhnpehprghsthgvsghinhdrtghomhenucfkphepuddvjedrtddrtddruddpledvrddugeekrddvheefrddvgeefpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht
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

Hello,

On 7/25/23 10:08, Sébastien Szymanski wrote:
> This series adds i.MX93 CCF driver, modifed from Linux kernel 6.5-rc2
> and adapted for U-Boot.
> 
> Patches 2 and 3 come from NXP U-Boot.
> 
> A boot log and a dump of the clock tree are available at the following
> URL:
> https://pastebin.com/7WbubSXK
> 
> Alice Guo (1):
>    arm: dts: imx93: add a per clock for LPUART1
> 
> Sébastien Szymanski (2):
>    clk: imx: add i.MX93 CCF driver
>    imx93_evk: defconfig: enable clock driver
> 
> Ye Li (1):
>    serial: lpuart: Enable IPG clock
> 

gentle ping.
Maybe someone at NXP can help review this patchset?

Regards,

>   arch/arm/dts/imx93-11x11-evk-u-boot.dtsi |  23 ++
>   arch/arm/dts/imx93.dtsi                  |   4 +-
>   board/freescale/imx93_evk/imx93_evk.c    |   2 -
>   configs/imx93_11x11_evk_defconfig        |   2 +
>   drivers/clk/imx/Kconfig                  |  18 ++
>   drivers/clk/imx/Makefile                 |   2 +
>   drivers/clk/imx/clk-composite-93.c       | 142 +++++++++
>   drivers/clk/imx/clk-fracn-gppll.c        | 382 +++++++++++++++++++++++
>   drivers/clk/imx/clk-gate-93.c            | 148 +++++++++
>   drivers/clk/imx/clk-imx93.c              | 343 ++++++++++++++++++++
>   drivers/clk/imx/clk.h                    |  42 +++
>   drivers/serial/serial_lpuart.c           |  14 +-
>   include/dt-bindings/clock/imx93-clock.h  |   6 +-
>   13 files changed, 1122 insertions(+), 6 deletions(-)
>   create mode 100644 drivers/clk/imx/clk-composite-93.c
>   create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
>   create mode 100644 drivers/clk/imx/clk-gate-93.c
>   create mode 100644 drivers/clk/imx/clk-imx93.c
> 

-- 
Sébastien Szymanski, Armadeus Systems
Software engineer

