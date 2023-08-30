Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2A3C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 09:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F707864EF;
	Wed, 30 Aug 2023 11:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D51EB8650F; Wed, 30 Aug 2023 11:19:15 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 05FEB80275
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C33212F4;
 Wed, 30 Aug 2023 02:19:48 -0700 (PDT)
Received: from [192.168.1.21] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C40823F64C;
 Wed, 30 Aug 2023 02:19:08 -0700 (PDT)
Message-ID: <a16b6cdd-a248-2801-b394-b074a409a8bc@arm.com>
Date: Wed, 30 Aug 2023 10:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] pinctrl: sunxi: add SPI1 pinmuxes for f1c100s
Content-Language: en-US
To: Iota Hydrae <writeforever@foxmail.com>
References: <tencent_807B704C8CF66453A9723C0E19D28E962607@qq.com>
 <20230824145621.33370e53@slackpad.lan>
 <tencent_33B0F669D3B672650E0BD2D91656FB1ACC07@qq.com>
From: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
In-Reply-To: <tencent_33B0F669D3B672650E0BD2D91656FB1ACC07@qq.com>
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

Hi Iota,

please keep the list and other people on CC: when replying, so that it 
stays transparent.

On 27/08/2023 23:10, Iota Hydrae wrote:
> Sorry for I didn't realized the confilcting problem.
> 
> I was developing a video driver for a small oled display (ssd1327)
> using SPI1 and It's not necessary to use it actually (board specific).
> 
> I do have a board needs this, but still got work to do and we don't
> have an defconfig or dt for that now.

I see, that's fine.

> Maybe we could add a config like "CONFIG_UART0_PORT_F" to specify
> if SPI1 on Port A? Anyway, thanks for your replay.

Nah, we don't want any more of those hacks.
If you eventually upstream your defconfig, we can take this patch, and 
any other user will have to face the problem then.
We have ideas how to fix the problem (for instance adding a port number 
to each line), but we don't want to prematurely add something without it 
really being needed.
So if you have non-mainline patches in your branch anyway, just keep 
this patch there as well, and then send all of them once you are ready.
The conflict is theoretical at this point, and we will work out a proper 
solution once this actually becomes necessary.

Cheers,
Andre

> 
> Cheers,
> Iota
> 
> On Thu, Aug 24, 2023 at 02:56:21PM +0100, Andre Przywara wrote:
>> On Wed, 23 Aug 2023 14:47:16 +0800
>> Iota Hydrae <writeforever@foxmail.com> wrote:
>>
>> Hi,
>>
>>> SPI1 is also usable on port A.
>>>
>>> But there's nothing about SPI1 pinmux there for now.
>>>
>>> This should be set when you are using SPI1.
>>>
>>> According to the manual, the mux value would be 6.
>>
>> So technically that looks alright, but what do you need that for? We
>> try to not add pinmux values to that table unless they are used
>> somewhere, especially if there are potential conflicting values: SPI1
>> on PE is on pinmux 4.
>> So do you have a board that needs that? Any chance you could upstream
>> the DT (to the kernel list!) and defconfig for that board? That would
>> it make it a no-brainer to merge this patch.
>>
>> Cheers,
>> Andre
>>
>>> Signed-off-by: Iota Hydrae <writeforever@foxmail.com>
>>> ---
>>>   drivers/pinctrl/sunxi/pinctrl-sunxi.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>>> index e5102180902..c448e40ab07 100644
>>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>>> @@ -240,6 +240,7 @@ static const struct sunxi_pinctrl_function suniv_f1c100s_pinctrl_functions[] = {
>>>   	{ "mmc0",	2 },	/* PF0-PF5 */
>>>   	{ "mmc1",	3 },	/* PC0-PC2 */
>>>   	{ "spi0",	2 },	/* PC0-PC3 */
>>> +	{ "spi1",	6 },	/* PA0-PA3 */
>>>   #if IS_ENABLED(CONFIG_UART0_PORT_F)
>>>   	{ "uart0",	3 },	/* PF2-PF4 */
>>>   #else
>>
> 
