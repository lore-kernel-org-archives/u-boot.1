Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F209C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 09:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7236887DE2;
	Fri,  1 Mar 2024 10:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A103387DB7; Fri,  1 Mar 2024 10:17:42 +0100 (CET)
Received: from 8.mo581.mail-out.ovh.net (8.mo581.mail-out.ovh.net
 [46.105.77.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7810588123
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 10:17:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.139.16])
 by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4TmMtm6v95z1BRD
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 09:17:36 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-dz9x5 (unknown [10.110.113.119])
 by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 2903F1FEAD;
 Fri,  1 Mar 2024 09:17:36 +0000 (UTC)
Received: from armadeus.com ([37.59.142.103])
 by ghost-submission-6684bf9d7b-dz9x5 with ESMTPSA
 id FJxHBzCd4WUutAQA1IpCEA
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Fri, 01 Mar 2024 09:17:36 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005491b5a0a-8ea4-4232-a0c1-8740468b15fa,
 EA45B6F676092397FF7A27BFF7CFCA9692EE6655)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
Message-ID: <3f6e7fef-b1ee-4c1a-9ca6-fad4959631b3@armadeus.com>
Date: Fri, 1 Mar 2024 10:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 shawnguo@kernel.org, Fabio Estevam <festevam@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Rob Herring <robh@kernel.org>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@denx.de>, "NXP i . MX U-Boot Team"
 <uboot-imx@nxp.com>, Anatolij Gustschin <agust@denx.de>
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
 <47c12ca3-ea7c-4097-90b5-0333c74b05aa@moroto.mountain>
 <20240228131029.GM3040305@bill-the-cat>
 <CAFA6WYN4sCk9Q66i_n+aXxRkGEbh66dh+Sr_C5SbioQ_s5BBbQ@mail.gmail.com>
 <20240228152034.GN3040305@bill-the-cat>
 <CAFA6WYMkdjE6Vrd2_fV_6Rzj8MOiPhO4EJ4kkik1_9vQnhzMqQ@mail.gmail.com>
 <20240229134242.GR3040305@bill-the-cat>
 <20240229140140.GS3040305@bill-the-cat>
 <CAFA6WYPkSd=roYiZrK-9oKOse+zTsbtBj8mrgV=HHFVHtCwHGg@mail.gmail.com>
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
In-Reply-To: <CAFA6WYPkSd=roYiZrK-9oKOse+zTsbtBj8mrgV=HHFVHtCwHGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11326553064619698952
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrhedugddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhepiefgveettdevvdevleetveegveevuedtheeigeegkedvkeeuffethfejudettedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpledvrddugeekrddvheefrddvgeefpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
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

On 3/1/24 07:02, Sumit Garg wrote:
> On Thu, 29 Feb 2024 at 19:31, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Thu, Feb 29, 2024 at 08:42:42AM -0500, Tom Rini wrote:
>>> On Thu, Feb 29, 2024 at 11:17:28AM +0530, Sumit Garg wrote:
>>>> On Wed, 28 Feb 2024 at 20:50, Tom Rini <trini@konsulko.com> wrote:
>>>>>
>>>>> On Wed, Feb 28, 2024 at 07:44:42PM +0530, Sumit Garg wrote:
>>>>>> + Shawn, Krzysztof, Conor
>>>>>>
>>>>>> Hi Tom,
>>>>>>
>>>>>> On Wed, 28 Feb 2024 at 18:40, Tom Rini <trini@konsulko.com> wrote:
>>>>>>>
>>>>>>> On Wed, Feb 28, 2024 at 10:09:13AM +0300, Dan Carpenter wrote:
>>>>>>>> On Tue, Feb 27, 2024 at 04:40:01PM +0100, Sébastien Szymanski wrote:
>>>>>>>>> Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with
>>>>>>>>> linux") removed the display timings from the board device tree whereas
>>>>>>>>> they are still needed by the mxsfb driver.
>>>>>>>>> Add the timings back (the correct ones) in the
>>>>>>>>> imx6ul-opos6uldev-u-boot.dtsi file and remove them from the
>>>>>>>>> opos6uldev.env file.
>>>>>>>>>
>>>>>>>>> Update the opos6uldev_defconfig file so that the LCD turns on at boot.
>>>>>>>>>
>>>>>>>>> Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with linux")
>>>>>>>>> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
>>>>>>>>
>>>>>>>> Huh.  This is the commit that did that upstream.
>>>>>>>>
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d9aa4d4fca67823838fe9861456201430c545e69
>>>>>>>>
>>>>>>>> It's interesting how the timings in linux were always slightly different
>>>>>>>> from in u-boot.
>>>>>>>
>>>>>>> Thanks for tracking that down, Dan. I'm adding in Sumit and Rob here
>>>>>>> because this is a recent (rather than ancient) example of one of the
>>>>>>> concerns about OF_UPSTREAM.
>>>>>>
>>>>>> I rather think about this as an opportunity to improve with
>>>>>> OF_UPSTREAM. We can feed these kinds of DT ABI breakages to
>>>>>> corresponding Linux kernel sub-arch maintainers. Especially once we
>>>>>> move to OF_UPSTREAM and a sub-arch maintainer profile in Linux kernel
>>>>>> to keep them aware that U-Boot should be considered too.
>>>>>
>>>>> Yes, a more extensive check around when removing information from dts
>>>>> files would be good.
>>>>>
>>>>>>> I think the commit in question can be
>>>>>>> summarized as "remove a bunch of explicit HW information because there's
>>>>>>> now a Linux Kernel driver that determines that dynamically". What do we
>>>>>>> do next? The old information is in a presumably valid binding still, can
>>>>>>> we just put it back and comment that consumers outside of Linux use this
>>>>>>> still so it's not removed again later? Or am I just missing where we can
>>>>>>> instead get this information from the DT still and not need to come up
>>>>>>> with a new driver and subsystems?
>>>>>>
>>>>>> I can see following two paths forward:
>>>>>>
>>>>>> 1) Partially revert the Linux kernel commit to add back the display
>>>>>> timings in DT.
>>>>>> 2) Extend drivers/video/simple_panel.c in U-Boot to add support for
>>>>>> compatible: "armadeus,st0700-adapt".
>>>>>>
>>>>>> If possible then I would be in favour of (2) rather than the current
>>>>>> patch to do this properly.
>>>>>
>>>>> Well, looking at the kernel drivers/gpu/drm/panel/panel-simple.c driver
>>>>> and then our drivers/video/simple_panel.c it sure would be nice if it's
>>>>> just a matter of adding a compatible but I wouldn't be surprised if it
>>>>> ends up needing more information being passed along too?
>>>>
>>>> Although I am not a LCD panel expert but looking at the kernel driver
>>>> code [1], the display timings are rather taken from a static data
>>>> structure matching the compatible "armadeus,st0700-adapt".
>>>>
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/panel/panel-simple.c#n901
>>>
>>> Yes. My point is that it seems like the situation changed from "device
>>> tree provides timings for the platform" to "driver has timing
>>> information for N displays" and so we'll need to do something clever to
>>> avoid including the structs for 5 panels when we'll only ever
>>> (likely...) see one. And that also yes, we'll probably need to add data
>>> for this panel rather than re-use the PANASONIC_VVX10F004B00 data.
>>>
>>>>> And I'm going
>>>>> assume there's good reasons for the design change in how the drivers
>>>>> work in Linux now and note that it might make things more challenging
>>>>> for us when we do care about space.
>>>>
>>>> I agree it is always going to be challenging to use DT during SPL
>>>> stage which is mostly constrained by limited on-chip RAM.
>>>
>>> Well, no. The DT way handled this more efficiently, I think I wasn't
>>> clear enough in my reply.
>>
>> And it's not just SPL, full U-Boot needs to stay small and within flash
>> partition considerations and I become cranky and question people when
>> non-generic changes impact platforms that don't need the change.
>>
> 
> Okay I can see your point. I suppose this leads us to option (1) to
> partially revert the Linux kernel commit [1] to add back the display
> timings in DT. Ironically all the folks (developer, U-Boot and Linux
> kernel iMX maintainers) were involved in the upstream process for the
> Linux kernel commit [1] under question. So I will let them chime in
> too.

It is also now possible to have the display timings under the panel node:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/panel/panel-simple.c?h=v6.8-rc6&id=4a1d0dbc8332231d1d500d7a1d13c45457262a97

Not sure if that could help here.

Regards,

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d9aa4d4fca67823838fe9861456201430c545e69
> 
> -Sumit
> 
>> --
>> Tom

-- 
Sébastien Szymanski, Armadeus Systems
Software engineer

