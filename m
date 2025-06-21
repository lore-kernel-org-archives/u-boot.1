Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61204C7115C
	for <u-boot@archiver.kernel.org>; Sat, 21 Jun 2025 18:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8426282CCE;
	Sat, 21 Jun 2025 20:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lK0pvz1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5377082CF4; Sat, 21 Jun 2025 20:48:59 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C288E8210D
 for <u-boot@lists.denx.de>; Sat, 21 Jun 2025 20:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bc34=ZF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1750531734;
 bh=2K7J5Yjdp0+wcBrcDLtweJep69PtLTUb/1N8Z+SvFpc=;
 b=lK0pvz1zn37YL7j+NOUWL5NkCrJfRMPNtAMms0mOl9d8Nfw2ZtHJ8XKbEFvSHb/XnaFPYlr6U
 AZYRtBGiFz6IgUNgveWrTc3dqMV4vOoslUy6YGJPFyIt/cZcFmRF2vZY3EBLoFrZYVFdAmkeEYY
 3Zrnc+Ji8TzbGpZL7NGgVn99P8V4J1Wzeueas34Dr5VPWHtapZiu9Wg8br9A+88ARYJi0WdKcf8
 0t3ijov1CA5o6GVK/XA0XEOahug5giMwJ+D2HfJvieFrTuQseOs3L/83sC0Eq20UbiqI/7w8eRV
 1xTQX73IahOiWkHFZdtawI9BvDVqkQRmyLhwbgvXSA6A==
X-Forward-Email-ID: 6856fe9405da1d979e43d9a6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1ac97715-1d24-443e-95ff-dda8b691384d@kwiboo.se>
Date: Sat, 21 Jun 2025 20:48:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3328: Fix Synchronous Abort on usb start
To: Alex Shumsky <alexthreed@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250524142258.297397-1-alexthreed@gmail.com>
 <65b2368d-fed5-4633-b9e6-25ab9d151d1e@kwiboo.se>
 <5aecf685-07fd-4cc5-88f4-9624c78aac03@kwiboo.se>
 <CAF4oh-O2WnVt-U6M=vo8O=ms1WN7iUHFca8gc9nYpLYPSs6XQA@mail.gmail.com>
 <CAF4oh-M7AgDoy-=cuxwQEPh8F+iKmTkoh47tu0eXkzpcfWpepw@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAF4oh-M7AgDoy-=cuxwQEPh8F+iKmTkoh47tu0eXkzpcfWpepw@mail.gmail.com>
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

Hi Alex,

On 2025-06-07 14:18, Alex Shumsky wrote:
> On Sun, May 25, 2025 at 8:35 PM Alex Shumsky <alexthreed@gmail.com> wrote:
>>
>> Oops, I forgot Reply-All and some messages missed list. Sorry about that.
>>
>> Jonas and I have found NULL pointer dereference in rockchip_usb2phy_clkout_ctl:
>> https://github.com/u-boot/u-boot/blob/df2ed552f0b05591090369a7fe7ddc92439dea5c/drivers/phy/rockchip/phy-rockchip-inno-usb2.c#L177
>>
>> Here rockchip_usb2phy_clkout_ctl tries to read from
>> `dev_get_priv(parent)->phy_cfg`
>> but it is NULL because rockchip_usb2phy_probe is not yet called.
>>
>> Johnas, I have dug the problem a little further and found something interesting.
>> We have circular dependency between rockchip-inno-usb2 clock/phy initialisation
>> here. The rockchip-inno-usb2 phy node also acts as a parent clock for itself.
>> Parent clocks now are enabled as part of the probe process before dev->probe
>> call, but this particular clock depends on phy. Here is relevant code:
>> https://github.com/u-boot/u-boot/blob/df2ed552f0b05591090369a7fe7ddc92439dea5c/drivers/core/device.c#L572
>>
>> Quick and dirty solution would be to just ignore rockchip_usb2phy_clk_enable
>> when the phy node is not yet probed. USB works fine with this check added,
>> exactly as before the recent parent clock enablement commit that introduced
>> this issue:
>> ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting").
>>
>> Clean solution would probably be to break dependency cycle, but I'm not
>> proficient enough with uboot codebase to propose such solution.
>> I've tried to move some of rockchip_usb2phy_probe initialisation code to
>> rockchip_usb2phy_of_to_plat to make it run before clock initialisation.
>> But I have failed on `priv->reg_base = syscon_get_regmap(dev_get_parent(dev))`
>> which needs a parent node to be probed (I unsure is it OK to probe parent from
>> of_to_plat).
>>
>> If we settle on a quick fix, I propose to add to rockchip_usb2phy_clk_enable
>> something like (Johnas, please let me know if it have some flaw over your
>> patch):
>>   struct rockchip_usb2phy *parent_priv = dev_get_priv(dev_get_parent(clk->dev));
>>   if (!parent_priv->phy_cfg) {
>>       return 0;
>>   }
>>
>>
> 
> Kindly ping Jonas and Kever.
> How can we proceed with this issue to apply fix before the 2025.07 release?
> Do some of my ideas from the previous message make sense to you?

rockchip_usb2phy_clkout_ctl() was introduced this cycle, so I would
personally prefer a proper fix and having this new function incorporate
a proper NULL check, similar to what I sent you some time ago.

If possible, please send a similar patch and include a fixes-tag for
229218373c22 ("phy: rockchip-inno-usb2: Add support for clkout_ctl_phy").

Regards,
Jonas

> 
> 
>>
>> On Sat, May 24, 2025 at 8:43 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>>
>>> On 2025-05-24 18:02, Jonas Karlman wrote:
>>>> Hi Alex,
>>>>
>>>> On 2025-05-24 16:20, Alex Shumsky wrote:
>>>>> Remove incorrect assigned-clock-parents in rk3328-u-boot.dtsi.
>>>>> This incorrect parent has become a problem since recent commit with parent
>>>>> clock enablement.
>>>>>
>>>>> Currently assigned-clock-parents is not a CLK node, but rk3328-usb2phy.
>>>>> It looks like a mistake in dts made a long time ago (~8 years ago).
>>>>
>>>> No, this is very much correct, u2phy is a clk provider as can be seen
>>>> by the use of the '#clock-cells' prop so being able to use it as a
>>>> parent clk is allowed and the device tree is correct.
>>>>
>>>>>
>>>>>   => usb start
>>>>>   starting USB...
>>>>>   Bus usb@ff580000: "Synchronous Abort" handler, esr 0x96000210, far 0x4
>>>
>>> I have now tried to re-create this issue using latest master branch on a
>>> rk3328 board, however I was only able to re-create a different issue.
>>>
>>> On what board and U-Boot version/commit are you seeing this issue?
>>>
>>> The issue I faced was due to only enable usb20_otg and not u2phy_otg,
>>> something that could be fixed with following diff:
>>>
>>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>> index 88b33de1b2a0..d6ce12b5e83d 100644
>>> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>> @@ -538,7 +538,7 @@ U_BOOT_DRIVER(rockchip_usb2phy_clock) = {
>>>
>>>  U_BOOT_DRIVER(rockchip_usb2phy) = {
>>>         .name   = "rockchip_usb2phy",
>>> -       .id     = UCLASS_PHY,
>>> +       .id     = UCLASS_NOP,
>>>         .of_match = rockchip_usb2phy_ids,
>>>         .probe = rockchip_usb2phy_probe,
>>>         .bind = rockchip_usb2phy_bind,
>>>
>>> Regards,
>>> Jonas
>>>
>>>>>
>>>>> Linux dts source reference:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c60c0373a5e85d8bd0bb026cd5440576249d2299
>>>>>
>>>>> Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting")
>>>>> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
>>>>> ---
>>>>>
>>>>>  arch/arm/dts/rk3328-u-boot.dtsi | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
>>>>> index b0e50a973a..39dcc2313b 100644
>>>>> --- a/arch/arm/dts/rk3328-u-boot.dtsi
>>>>> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
>>>>> @@ -150,6 +150,10 @@
>>>>>      bootph-all;
>>>>>  };
>>>>>
>>>>> +&u2phy {
>>>>> +    /delete-property/ assigned-clock-parents;
>>>>> +};
>>>>
>>>> We should fix the driver code and not modify the device tree to fit the
>>>> code.
>>>>
>>>> The u2phy ofnode is tied to multiple uclass drivers so is it possible
>>>> that the parent clock lookup from commit ac30d90f3367 ("clk: Ensure the
>>>> parent clocks are enabled while reparenting") is not getting the
>>>> UCLASS_CLK driver?
>>>>
>>>> Regards,
>>>> Jonas
>>>>
>>>>> +
>>>>>  #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>>>>>  &binman {
>>>>>      simple-bin-spi {
>>>>
>>>

