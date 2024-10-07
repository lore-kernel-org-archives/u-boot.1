Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71B7CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A2F88B11;
	Mon,  7 Oct 2024 14:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728302541;
	bh=KVlgw/Jjn/S0vSk0c/74WWvzxbHbBIlY8VrnjAhbiWk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WRNV0A7OZq6CzbjM9c8GjKCCicbNg388ie4oEfDZG+nUFS0Zg8/rBh/Eg+NOXO+5h
	 c9HmPyeoVH+BYKrPYl/lsnG7Bepkuc32ub5Z4+jkABTwvaTCGfe+cnt3MiUdfMQbMN
	 3B6EqACIgqgoPpNjFv9R+6+X4SNx+CZdUmqnAfLQvhiDVpHCjlvHmq4OGs0DF1sgIE
	 oPggmy6r84tuS9DNUFnA8BUfQsa1gSohNUORSMv/tzsVfZiyFZ2dnHZMcWODTZEiSM
	 Lz7ciowcI4SwUFr601qJO4JuHXvzrDE31GtMJ+1TWv9p1TUisYOyiQ21mtldA6XamT
	 PlpiRuM067vCg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 89ED988B39;
 Mon,  7 Oct 2024 14:02:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728302540;
 bh=KVlgw/Jjn/S0vSk0c/74WWvzxbHbBIlY8VrnjAhbiWk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cA19VxTQjJgJdJLUtOmxaNSRVB4bFTGkdGkeRAtJCYYWSlJrAdvEsK32bSnEFKfg1
 M11SD5n9hA6l8zhmkjXfZ1zm8hALrKkPH/k73agVFFdQ3CJiz8CmWY8P1kfDp4ourl
 RbH6j4SCIshXVhJiRC9elPGEaevy8+EK5FvUV+MHjtBK0EHUng4+FyXn4vMrHYDn5H
 jU+Hnn8Jm6hB6Ip8YuiMNy/VmLiBwJL1lfS1TH5iRLMd2Es3Wg127y6/bfpXkJHLi2
 tAp4y+5z7h1fm/Qrvz0TjjvxzwxxMF92anawpxKVVUFaSJ8dRSw+QMd1goVke6df+y
 YCLTMfvKT6HyQ==
Message-ID: <27ae6d7f-6e83-4b38-8f03-65e7f73756da@denx.de>
Date: Mon, 7 Oct 2024 13:32:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
To: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sbabic@denx.de" <sbabic@denx.de>, "festevam@gmail.com"
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "Ross, Fedor" <fedor.ross@ifm.com>, Ye Li <ye.li@nxp.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, Alice Guo <alice.guo@nxp.com>
References: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
 <20241006212332.GQ4737@bill-the-cat>
 <f2f2ff63-e186-4065-8e75-7e0064d16037@denx.de>
 <PAXPR04MB84599FA214B38FBB3AFF1E4F887D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB84599FA214B38FBB3AFF1E4F887D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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

On 10/7/24 1:23 PM, Peng Fan wrote:
> Hi Marek,

Hi,

>> Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI
>> configurable
>>
>> On 10/6/24 11:23 PM, Tom Rini wrote:
>>> On Sun, Oct 06, 2024 at 07:31:16AM +0800, alice.guo@oss.nxp.com
>> wrote:
>>>
>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>
>>>> Make CONFIG_IMX8_ROMAPI could be configured in defconfig.
>>>>
>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>> Signed-off-by: Alice Guo <alice.guo@nxp.com>
>>>> Reviewed-by: Ye Li <ye.li@nxp.com>
>>>> ---
>>>>    arch/arm/mach-imx/Kconfig | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-
>> imx/Kconfig
>>>> index 134e42028c..9d3aafd2f8 100644
>>>> --- a/arch/arm/mach-imx/Kconfig
>>>> +++ b/arch/arm/mach-imx/Kconfig
>>>> @@ -179,7 +179,8 @@ config DDRMC_VF610_CALIBRATION
>>>>    	  the ddrmc_cr_setting on relevant board file.
>>>>
>>>>    config IMX8_ROMAPI
>>>> -	def_bool y
>>>> +	bool "Enable i.MX ROMAPI"
>>>> +	default y
>>>>    	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
>>>
>>> Since there's no help here, is this truly configurable, or is this
>>> something that should be select'd based on the SoC and presumably
>> some
>>> of the newer IMX9 parts cannot use this?
>> I can imagine the MX95 calls into this custom ELE firmware stuff
>> instead of ROMAPI ?
> 
> True. i.MX95 A55 code no need ROMAPI.
> 
> But it is still good to make this option configurable, because there
> is case that people no need romapi.
I have a bit of a design question instead -- does U-Boot have to make 
use of SCMI and ELE firmware at all ? Can this dependency be avoided?
