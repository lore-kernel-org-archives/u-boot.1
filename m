Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03EAD1BDEB
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 19:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A9A988E4B;
	Mon,  4 Nov 2024 20:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730750274;
	bh=RH1brYDuawlHWbk5iB8cV60VXAt57CiLksO4WCXzGlw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YoHfDItDabPC1ixQpuZ1gjkRHLkRDO3kDVE7u0SWiTaYs3z+Ew9roOxuhTTDCYeSx
	 TE2/PzXTxMoOl88zO1ZpExTvp118P7jLvlk5xXil59Z/LDUfySH0tlQMLrnhou2kPq
	 8tQQvyKZ7V/yVIntcEZHSpsnKAGQxOBKGNpDcnabrUwoxe0l5S2rKJ9GLrRT1MxxrB
	 rIkNvWTtBGT54WewXKuv4DE9A4VLBQVjqZeSiT3C27l40fiog+zr+Yxq7cZHXAT5FN
	 s2ZJ4XtHZxxz167ownuvzwcx8rQ9/s2LWjbyKdMRPYvXMnsTP4qh/g4oVIvJq8aqNh
	 tYNPikXPa9dQQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5105A88CED;
 Mon,  4 Nov 2024 20:57:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730750273;
 bh=RH1brYDuawlHWbk5iB8cV60VXAt57CiLksO4WCXzGlw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=yt+KxwK7yN8SkYAeT0fGRFbmYBcSYW4AjOh8/2pY2WLa1WPM4gI2o/7CV/ejOboEB
 ZcJlVdhZ+Rkb7AYKaPc0fSbSOxszBBWSGuhnETRHPRHDiqxmfIrn8y9xoni+3iUkkM
 gMKWxkLbF4ugKDEcxOjyWc7ROzukwgJy7WRHCbsaItWsOPzDUCIjZfMAa4Uo+K4db1
 f89apQO5mHyx8iyirZGV7pwdfGwb9ErIZMtLeVQOJDdf/iyjI/ywPL28v1oWT6AlTU
 1Q8NROB7ANpifjIMNm37il26LgAtVr5ejZVo9NSXajpljKZtwl2IUVj83SluOfdPHE
 Z4qBM2conOZDg==
Message-ID: <60302aa2-4838-4f59-8aeb-9d02def683f7@denx.de>
Date: Mon, 4 Nov 2024 16:39:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] (no cover subject)
To: Peng Fan <peng.fan@nxp.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Viorel Suman <viorel.suman@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <ee6519d5-30cc-485c-b87e-89665066a827@denx.de>
 <PAXPR04MB8459B83D68F7365C5C0B5C2A88512@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <77ef2f17-66b7-4f5c-ab99-4b15f5c1a84d@denx.de>
 <PAXPR04MB8459F3E50519ABEED5C806C688512@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB8459F3E50519ABEED5C806C688512@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/4/24 1:39 PM, Peng Fan wrote:
>> Subject: Re: [PATCH 00/17] (no cover subject)
>>
>> On 11/4/24 1:20 PM, Peng Fan wrote:
>>>> Subject: Re: [PATCH 00/17] (no cover subject)
>>>>
>>>> On 10/16/24 9:17 AM, Alice Guo wrote:
>>>>> This patch set adds the basic support of i.MX95 and has been
>> tested
>>>> on
>>>>> i.MX95 19x19 EVK.
>>>> I have a somewhat more generic question -- can we start U-Boot SPL
>>>> and U-Boot first, and start the ELE/OpTee/... whatever firmwares
>>>> AFTER U-Boot has started, so they can be updated just like the
>> kernel
>>>> can be updated ?
>>>
>>> ELE Firmware packed in flash.bin is used by ROM, out of control of
>>> SPL/U-Boot.
>>
>> Used by ROM how ? Details please ?
> 
> ELE Firmware is for secure enclave usage. 8ULP/93 also has it.
> I could not share more details.

Is this some magic proprietary closed source goo ?

Why can this not be started from U-Boot just like OpTee-OS which 
implements TEE for Secure TEE trustlets (or whatever that is called) ?

>>> OP-Tee is optional, but if it is there, it could only be loaded by SPL
>>> and kicked by ATF
>> Why ? U-Boot running in EL3 can start OpTee OS, so what is the
>> problem ?
> 
> Ah. As we know there is a wrapper in ATF controlled with spd_optee.
> Technically let uboot in EL3 to kick optee is feasible, but I am not
> sure people would do this.
Because if there is a bug in OpTee, it can be safely updated just like 
the kernel can be safely updated -- just boot the other copy as a 
fallback. If the Optee is baked into your flash.bin , you have to update 
bootloader, which is dangerous.
