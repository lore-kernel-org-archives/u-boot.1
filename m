Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCD6C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 08:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A6D88660;
	Mon,  1 Jul 2024 10:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 449188866B; Mon,  1 Jul 2024 10:20:06 +0200 (CEST)
Received: from 7.mo575.mail-out.ovh.net (7.mo575.mail-out.ovh.net
 [46.105.63.230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0508B87D0A
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 10:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director11.ghost.mail-out.ovh.net (unknown [10.109.176.70])
 by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4WCJr323tFz1SQs
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 08:20:03 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-vsjnx (unknown [10.110.178.151])
 by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3AE261FEF5;
 Mon,  1 Jul 2024 08:20:02 +0000 (UTC)
Received: from armadeus.com ([37.59.142.97])
 by ghost-submission-6684bf9d7b-vsjnx with ESMTPSA
 id KK/vB7JmgmYISQAAvTXyuQ
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Mon, 01 Jul 2024 08:20:02 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0024c5a6c70-7c56-4c7e-a0c9-aa3c3724387e,
 42C740D7E38941395E3F43F3BF5FC63AE7EF3D04)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
Message-ID: <b4e9d236-f9b3-4fb8-837c-50c971eb56a3@armadeus.com>
Date: Mon, 1 Jul 2024 10:19:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: uboot 2024.07 regression
To: Frank Wunderlich <frank-w@public-files.de>
Cc: u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>,
 John Crispin <john@phrozen.org>,
 "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
References: <trinity-e357a9ad-a974-44b8-9efc-a236a499c673-1718440537556@3c-app-gmx-bap44>
 <trinity-d5e7efbf-06a7-4a02-ab82-c1738850841d-1719756653263@3c-app-gmx-bap39>
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
In-Reply-To: <trinity-d5e7efbf-06a7-4a02-ab82-c1738850841d-1719756653263@3c-app-gmx-bap39>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7400258615300123580
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnheptdeghedtudeltdduveevkeevveevfefftdehtdeikeegueekvedtffeigeetkefhnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht
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

On 6/30/24 16:10, Frank Wunderlich wrote:
> Hi,
> 
> any thoughts about this?

Do you use an environment file ? If so, can you share it?

Regards,

> 
> Changes do not look like they would cause the ethernet-breakage, but revert confirms...but i have no idea why this happens (maybe some optimization is triggered).
> 
> regards Frank
> 
> 
>> Gesendet: Samstag, 15. Juni 2024 um 10:35 Uhr
>> Von: "Frank Wunderlich" <frank-w@public-files.de>
>> An: u-boot@lists.denx.de, "Sébastien Szymanski" <sebastien.szymanski@armadeus.com>
>> Cc: "Daniel Golle" <daniel@makrotopia.org>, "John Crispin" <john@phrozen.org>, "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
>> Betreff: uboot 2024.07 regression
>>
>> Hi,
>>
>> while testing clock-patches for mediatek as preparation for OF_upstream i've noticed an issue on
>> mt7623 based board (bananapi r2) with ethernet (no ping possible) in 2024.07-rc1 where 2024.04 is good.
>>
>> i bisected it to this commit:
>> ff3bcb17f436 2024-02-23 Makefile: pass -undef option to cmd_gen_envp
>> and when reverting this commit in 2024.07 ethernet works
>>
>> it seems not yet reported or reverted (till 2024.07-rc4).
>>
>> I'm not sure why this commit breaks network on this board, but revert confirms it...
>>
>> regards Frank
>>
>>

-- 
Sébastien Szymanski, Armadeus Systems
Software engineer

