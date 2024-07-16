Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8D6C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 09:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECE7E88908;
	Tue, 16 Jul 2024 11:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NrYlKbvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27F1C889D0; Tue, 16 Jul 2024 11:56:25 +0200 (CEST)
Received: from mail-m155106.qiye.163.com (mail-m155106.qiye.163.com
 [101.71.155.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE3288617
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 11:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=NrYlKbvoUmD0+xImoYUemfVGftwmzJntooI5QWEZCBzUcmaKs5nw7lVmplGXvH5o1drqNlX2cNoSvDraZ/rBVofzGLLSOYNXk6xMvEvNwsNSGzCe26tIIzvZXy8PC+pUjA7c1fr4ZowPBn3u4mG0CUk69dUw9xtM3icoJtrSVuw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=4tTCAQxnYrwZcPA4EiCJ0Vjj6E+8xQYA3wCPdg1EuEo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 6478E9006EF;
 Tue, 16 Jul 2024 17:56:06 +0800 (CST)
Message-ID: <6de0ee14-3d85-4fda-af9d-9be7e0057dc8@rock-chips.com>
Date: Tue, 16 Jul 2024 17:56:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] rockchip: Add gpio request() ops and drop PCIe
 reset-gpios workaround
To: Alex Bee <knaerzche@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, u-boot@lists.denx.de
References: <20240511112821.1156519-1-jonas@kwiboo.se>
 <0e701fd8-b2c6-4ac4-9427-d984032470d1@gmail.com>
 <6853e5ac-271f-4d19-b8fb-a2746b834b24@kwiboo.se>
 <1b3b8c24-a3d9-4c36-a72f-45baee63f385@gmail.com>
 <1251aa97-43b4-485d-b1a7-161c14bc74fa@kwiboo.se>
 <03c73683-faec-4ef3-8af8-caaf0ebbd0e6@gmail.com>
 <96bfe653-3704-4f1b-a8be-6a9702f291b3@kwiboo.se>
 <31fe0d7a-a295-4d29-900f-aa40b497bae2@gmail.com>
 <d626c93a-5c56-4363-b1ac-4de8c03e2f6a@kwiboo.se>
 <3eb74d4a-25c4-4947-bf5a-8194f136c889@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <3eb74d4a-25c4-4947-bf5a-8194f136c889@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx8fHVYZT0saTUJOQh5DTEtWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90baf8824f03a9kunm6478e9006ef
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NlE6KTo5OTIrFB5CKxwxPVEM
 ShYwC0hVSlVKTElKSklITE1MT09PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQkNCSzcG
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

Hi Alex, Jonas,

On 2024/5/23 03:46, Alex Bee wrote:
>
> Am 22.05.24 um 18:20 schrieb Jonas Karlman:
>> On 2024-05-22 16:18, Alex Bee wrote:
>>> Am 13.05.24 um 01:22 schrieb Jonas Karlman:
>>>> On 2024-05-13 00:34, Alex Bee wrote:
>>>>> Am 12.05.24 um 23:37 schrieb Jonas Karlman:
>>>>>> Hi Alex,
>>>>>>
>>>>>> On 2024-05-12 21:49, Alex Bee wrote:
>>>>>>> Am 11.05.24 um 20:47 schrieb Jonas Karlman:
>>>>>>>> Hi Alex,
>>>>>>>>
>>>>>>>> On 2024-05-11 19:44, Alex Bee wrote:
>>>>>>>>> Hi Jonas,
>>>>>>>>>
>>>>>>>>> Am 11.05.24 um 13:28 schrieb Jonas Karlman:
>>>>>>>>>> This series add gpio request() and pinctrl 
>>>>>>>>>> gpio_request_enable() ops so
>>>>>>>>>> that a gpio requested pin automatically use gpio pinmux and 
>>>>>>>>>> U-Boot
>>>>>>>>>> behaves more similar to Linux kernel.
>>>>>>>>> I'm not sure that's a good idea.
>>>>>>>>> While linux does it the same way, we really shouldn't expect 
>>>>>>>>> every
>>>>>>>>> software/os/ … which uses DT (now or in future) to implicitly 
>>>>>>>>> switch the
>>>>>>>>> pin function when using a pin as gpio. So the real fix would 
>>>>>>>>> probably be
>>>>>>>>> to add the the correct pinctrl settings to the upstream DT of 
>>>>>>>>> those
>>>>>>>>> boards and sync it later on (not sure those if those SoCs 
>>>>>>>>> already using
>>>>>>>>> OF_UPSTREAM) and leave the -u-boot.dtsi-"hack" alone for now.
>>>>>>>> I fully agree that the pinctrl for the problematic boards 
>>>>>>>> should be
>>>>>>>> corrected in upstream DT, but that is a separate issue and 
>>>>>>>> should not
>>>>>>>> block adding support for the request()/gpio_request_enable() ops.
>>>>>>>>
>>>>>>>> While the pcie reset-gpios full board freeze that was my 
>>>>>>>> driving factor
>>>>>>>> to fully implement the gpio request() ops it is not the only 
>>>>>>>> use case,
>>>>>>>> using the gpio cmd on a pin that use a non-gpio pinmux is another.
>>>>>>>>
>>>>>>>> Or do you see any technical issue with having the gpio 
>>>>>>>> request() ops
>>>>>>>> implemented and having it ensure gpio pinmux is used on a gpio 
>>>>>>>> requested
>>>>>>>> pin? Similar to how gpio/pinctrl is behaving in Linux and on 
>>>>>>>> some other
>>>>>>>> platforms in U-Boot?
>>>>>>> No, no general ("technical") issue with adding a .request hook 
>>>>>>> to the gpio
>>>>>>> driver. But now you are now moving the original workaround to an 
>>>>>>> even more
>>>>>>> invisible place which does things implicitly. Maybe just don't 
>>>>>>> remove the
>>>>>>> pinctrl from the boards u-boot-dtsi's - just replace it with
>>>>>>>
>>>>>>> &pcie30x2m1_pins {
>>>>>>>         rockchip,pins =
>>>>>>>                  <2 RK_PD4 4 &pcfg_pull_none>,
>>>>>>>                  <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>,
>>>>>>>                  <2 RK_PD5 4 &pcfg_pull_none>;
>>>>>>> };
>>>>>>>
>>>>>>> Even if it would (now) work without. It, at least, documents 
>>>>>>> that there are
>>>>>>> things left to do for the upstream DT.
>>>>>> This is what I was doing when testing PCIe on ROCK 3B, I would 
>>>>>> still like
>>>>>> to drop the "bad" workaround for ROCK 3A and E25 and have it 
>>>>>> fixed in
>>>>>> upstream DT and let it trickle back now that RK356x use OF_UPSTREAM.
>>>>>>
>>>>>> I do not see the point of keeping a workaround that no longer is 
>>>>>> needed,
>>>>>> especially when there is plans to also adjust upstream DT.
>>>>> Yeah, sure: but that certainly should be done/happen first, before 
>>>>> it's
>>>>> removed here. Everybody knows how long that takes, patches being 
>>>>> forgotten
>>>>> ....
>>>> I am fully aware of patches being forgotten :-)
>>>>
>>>> Still, here I try to cleanup a bad workaround that I probably never 
>>>> should
>>>> have added in the first place.
>>> Why is it bad? It's incomplete and the correct pin configuration should
>>> have been added to the upstream board DT in the first place. That's 
>>> what
>>> *-u-boot.dtsi are doing at times :)  It's not as worse as adding 
>>> implicit
>>> pin function switching to a driver to compensate the 
>>> incomplete/incorrect
>>> upstream board device tree, imho.
>>  From my point-of-view the upstream pinctrl is more correct and I 
>> wrongly
>> added a patch that completely disregarded existing pinctrl just to fix
>> pci enumeration in U-Boot when no pci device is connected without
>> thinking of how it could affect linux/bsd, hence why I now think that 
>> old
>> workaround/hack is something bad and something I want to cleanup/remove.
> Yeah, sure. That's why I suggested[0] to replace the current override 
> like
>
> ...
>
> -&pcie3x2 {
> -  pinctrl-0 = <&pcie3x2_reset_h>;
> -};
> -
> -&pinctrl {
> -  pcie {
> -    pcie3x2_reset_h: pcie3x2-reset-h {
> -      rockchip,pins = <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
> -    };
> -  };
> +&pcie30x2m1_pins {
> +  rockchip,pins =
> +    <2 RK_PD4 4 &pcfg_pull_none>,
> +    <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>,
> +    <2 RK_PD5 4 &pcfg_pull_none>;
>  };
>
The PERST is for sure should work as GPIO, and the same as WAKE;

for CLKREQ, only those board want to support L1SS need to work as 
function IO,

in most case, it's fine to work as GPIO, so below update would be a fix 
for -u-boot.dtsi.

&pcie3x2 {
/delete-property/ pinctrl-names
/delete-property/ pinctrl-0;
};

And the update in upstream linux dts should be the correct fix.


> ....
>
> The proper upstream solution should probably add another pinctrl-set to
> rk3568-pinctrl.dtsi - someting like
> ...
>
> +    /omit-if-no-ref/
> +    pcie30x2m1_ep_pins: pcie30x2m1-ep-pins {
> +      rockchip,pins =
> +        /* pcie30x2_clkreqnm1 */
> +        <2 RK_PD4 4 &pcfg_pull_none>,
> +        /* pcie30x2_perstnm1 */
> +        <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>,
> +        /* pcie30x2_wakenm1 */
> +        <2 RK_PD5 4 &pcfg_pull_none>;
> +    };
> +
>
> ...
> and boards needing this just switch from pcie30x2m1_pins to
> pcie30x2m1_ep_pins
>> In my mind the current pinctrl use for pcie3 in U-Boot is describing the
>> hw much worse than what is done in upstream Linux.
>
>
> No, not really. It describes pin settings wrong. The DT suggests GPIO2_D6
> is used with func4, but in reality its used with func0 (gpio). The only
> reason that works correctly is probe order: if the pinctrl driver would
> probe after the gpio driver (which is sort of impossible for Rockchip) 
> the
> pin would be switched to func4 and the controller wouldn't work.
>
>>>>>>> What you were saying in reply to Mark's email is not completely 
>>>>>>> true: Not
>>>>>>> all pins are initialized with gpio func as default. It actually 
>>>>>>> depends on
>>>>>>> the pin which function the bootrom sets initially. In case of 
>>>>>>> RK356x's
>>>>>>> GPIO2_PD6 (the pin in question) it's BT656_D6M0 (func2), for 
>>>>>>> instance. So,
>>>>>>> in fact, you are changing it's function when implicitly setting 
>>>>>>> it's func
>>>>>>> to gpio (func0).
>>>>>> Sure, bootrom will change pin func on some pins so that it e.g. 
>>>>>> can read
>>>>>> from storage etc, but in general gpio mux is what most pins will use
>>>>>> after POR.
>>>>>>
>>>>>> On my ROCK 3A I see the pcie30x2m1 pins using func0 (gpio) after 
>>>>>> POR:
>>>>>>
>>>>>>      => pinmux status
>>>>>>      GPIO2_D4  : gpio
>>>>>>      GPIO2_D5  : gpio
>>>>>>      GPIO2_D6  : gpio
>>>>>>
>>>>>> And with this after a "pci enum":
>>>>>>
>>>>>>      => pinmux status
>>>>>>      GPIO2_D4  : func-4
>>>>>>      GPIO2_D5  : func-4
>>>>>>      GPIO2_D6  : gpio
>>>>>>
>>>>>> Not sure why your board would use BT656_D6M0 (func2) after POR 
>>>>>> unless
>>>>>> there is some other code writing to the IOMUX regs.
>>>>> Oh, I haven't checked on an actual board - I trusted the TRM [0], 
>>>>> page 253
>>>>> GRF_GPIO2D_IOMUX_H[10:8] is (should be) 0x2. But (sadly) there are 
>>>>> lot of
>>>>> blobs involved. for RK35xx SoCs - so maybe something switches the 
>>>>> func for
>>>>> this pin for some reason.
>>>>>> The only thing this series changes is that when a U-Boot drivers 
>>>>>> use e.g.
>>>>>> gpio_request_by_name("reset-gpios") the referenced pin in DT will
>>>>>> implicitly be configured for gpio func.
 From my point of view, I would prefer the dts pinctrl as the only 
source to set the IOMUX,
this is another source of setting IOMUX,
GPIO and PINCTRL should be totally separate, and the DT should be the 
one describe the
HW function.

Thanks,
- Kever
>>>>>>
>>>>>> I would still like to understand if there is any other reason, not
>>>>>> related to dropping current "bad" PCIe DT workaround, to not to 
>>>>>> adopt
>>>>>> this implicit configuration and match Linux kernel?
>>>>> Generally speaking: device trees _must_ represent the actual hardware
>>>>> completely independent from any driver or any software. They are NOT
>>>>> helpers or configuration for drivers. Drivers can use them and 
>>>>> have to
>>>>> adapt to them - not vice versa. So: Being as explict as possible 
>>>>> is a must.
>>>> I am fully aware of this, and I would argue that the DT already is 
>>>> very
>>>> explicit about the HW in regard to PCIe3x2.
>>>>
>>>> The pinctrl function/group explains what function needs to be 
>>>> activated to
>>>> route PCIe3x2 related signals to the PCIe controller.
>>>> And the reset-gpios explains what pin is used for PERST# signal.
>>>>
>>>> However, if we instead are too explicit in the pinctrl 
>>>> function/group and
>>>> say that that the PERST# pin should use gpio iomux function, aren't we
>>>> then actually just describing something that is relevant for 
>>>> software/driver?
>>>>
>>>> And actually ends up loosing information on how the pin can be 
>>>> configured
>>>> to route the PERST# pin to the controller?
>>>>
>>>> And as Mark pointed out, the PERST# pin should probably be 
>>>> configured for
>>>> gpio output when controller works in RC mode, and should use PERSTn 
>>>> func
>>>> when controller works in EP mode.
>>>>
>>>> Guess that could/should possible be described as different pinctrl
>>>> states or if I am not mistaken EP is described as a separate device
>>>> using a different compatible.
>>> Actually I wouldn't be too surprised if the "reset-gpios" property does
>>> actually only exist to not have to define a extra pinctrl and the 
>>> actual
>>> reset-functionality (i.e. pulling the pin up / down by the driver) 
>>> isn't
>>> required at all. Though, untested. That would be similar to define a
>>> "cd-gpios" property for a (sd) mmc-controller which is a similar 
>>> workaround
>>> for not switching the card detection pin to gpio func.
>>  From what I could test the driver need to mux the pin for gpio output
>> use when we use the controller in RC mode and the pin should be muxed to
>> pcie func when the controller is used in EP mode.
>>
>> Leaving the pin muxed for pcie func when we use the controller in RC
>> mode seem to make the board freeze.
>
>
> From what you're saying (maybe I should test myself at some point :)
>
>  rockchip,pins = <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
>
>  instead of
>
>   rockchip,pins = <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
>
> could do the trick and no "reset-gpios" required at all.
>
>>>>> At some point, it is planned, to split whole DT "subsystem" from 
>>>>> the linux
>>>>> kernel.
>>>>> I also have a vague remembering (some mailing list discussion I 
>>>>> can't find
>>>>> right now), that this whole implicit function switching of pins is 
>>>>> sort of
>>>>> "not welcome" in linux anymore. So adding it here also is sort of 
>>>>> a "step
>>>>> back" from that POV.
>>>> I was not expecting this much backlash on this series, so thanks for
>>>> some concrete feedback on why we maybe should not add the gpio 
>>>> request()
>>>> ops :-)
>>> I did my best but couldn't find the discussion I had in mind. The 
>>> context
>>> was: pinctrl and gpio are different subsystems and one really shouldn't
>>> configure the other. That makes sense, I guess. That it exists for 
>>> Rockchip
>>> in linux kernel might be related to the fact that this originally was a
>>> single driver which was splited up later.
>>>
>>  From what I can find in the Linux pinctrl documentation it seem to 
>> suggest that
>> the gpiolib driver should actually hide pinmuxing from a gpio 
>> consumer driver.
>>
>> See "Pin control interaction with the GPIO subsystem":
>>
>> """
>> NOTE that platforms and individual drivers shall NOT request GPIO pins
>> to be controlled e.g. muxed in. Instead, implement a proper gpiolib
>> driver and have that driver request proper muxing and other control for
>> its pins.
>> """
>>
>> https://www.kernel.org/doc/html/latest/driver-api/pin-control.html#pin-control-interaction-with-the-gpio-subsystem 
>>
>>
>> And from "Drivers needing both pin control and GPIOs":
>>
>> """
>> But there are also situations where it makes sense for the GPIO
>> subsystem to communicate directly with the pinctrl subsystem, using the
>> latter as a back-end. This is when the GPIO driver may call out to the
>> functions described in the section Pin control interaction with the GPIO
>> subsystem above. This only involves per-pin multiplexing, and will be
>> completely hidden behind the gpiod_*() function namespace. In this case,
>> the driver need not interact with the pin control subsystem at all.
>>
>> If a pin control driver and a GPIO driver is dealing with the same pins
>> and the use cases involve multiplexing, you MUST implement the pin
>> controller as a back-end for the GPIO driver like this, unless your
>> hardware design is such that the GPIO controller can override the pin
>> controller’s multiplexing state through hardware without the need to
>> interact with the pin control system.
>> """
>>
>> https://www.kernel.org/doc/html/latest/driver-api/pin-control.html#drivers-needing-both-pin-control-and-gpios 
>>
>>
>>> Anyway: I hope we can agree on the point that the correct pinctrl 
>>> settings
>>> for the controller of this board should make it to the upstream 
>>> device tree
>>> in some way :D
>> Fully agree that it should be correct in upstream, my point is that on
>> one hand I actually think it already is correct in upstream and that
>> changing the reset pin to use gpio func as default instead would then be
>> done to assist software, and not correctly describe the hw.
>>
>> On the other hand, if I am not mistaken to use the controller in EP mode
>> another compatible/device node needs to be described and if that is the
>> case I can fully agree that the device node for RC mode could include
>> pinctrl to mux the reset pin for gpio func.
>>
>> Regardless on what is to be done with pinctrl in DT, I still think it
>> will be good to implement these gpio/pinctrl ops in U-Boot to closer
>> match "a proper gpiolib driver" as suggested in the Linux pinctrl
>> documentation where such driver request proper muxing and other control
>> for its pins.
> I can't exactly follow where in the documenation you are reading this, 
> but
> adding the ops should not be an issue, but DT shouldn't depend on it.
>
> Regards
>
> Alex
>
> [0]
> https://lore.kernel.org/all/1b3b8c24-a3d9-4c36-a72f-45baee63f385@gmail.com/ 
>
>> Anyway, I will merge the two gpio/pinctrl series and rearrange patches,
>> and also drop any DT changes in a v2.
>>
>> Regards,
>> Jonas
>>
>>> Regards,
>>> Alex
>>>> Maybe I should just drop this and only keep the follow up series.
>>>>
>>>> Regards,
>>>> Jonas
>>>>
>>>>> Alex
>>>>>
>>>>> [0]
>>>>> https://opensource.rock-chips.com/images/2/26/Rockchip_RK3568_TRM_Part1_V1.3-20220930P.PDF 
>>>>>
>>>>>
>>>>>> Regards,
>>>>>> Jonas
>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Jonas
>>>>>>>>
>>>>>>>>> Alex
>>>>>>>>>> With the gpio and pinctrl ops implemented this series also 
>>>>>>>>>> remove a PCIe
>>>>>>>>>> reset-gpios related device lock-up workaround from board 
>>>>>>>>>> u-boot.dtsi.
>>>>>>>>>>
>>>>>>>>>> PX30, RK3066, RK3188, RK356x and RK3588 are the only SoCs 
>>>>>>>>>> that currently
>>>>>>>>>> define gpio-ranges props and is affected by this series.
>>>>>>>>>>
>>>>>>>>>> A follow up series adding support for the pinmux status cmd 
>>>>>>>>>> will also
>>>>>>>>>> add gpio-ranges props for remaining RK SoCs.
>>>>>>>>>>
>>>>>>>>>> Jonas Karlman (4):
>>>>>>>>>>        pinctrl: rockchip: Add gpio_request_enable() ops
>>>>>>>>>>        gpio: rockchip: Add request() ops
>>>>>>>>>>        rockchip: rk3568-rock-3a: Drop PCIe reset-gpios 
>>>>>>>>>> workaround
>>>>>>>>>>        rockchip: rk3568-radxa-e25: Drop PCIe reset-gpios 
>>>>>>>>>> workaround
>>>>>>>>>>
>>>>>>>>>> arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 12 -------
>>>>>>>>>> arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       | 12 -------
>>>>>>>>>> drivers/gpio/rk_gpio.c                        | 10 ++++++
>>>>>>>>>> .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 31 
>>>>>>>>>> +++++++++++++++++++
>>>>>>>>>>       4 files changed, 41 insertions(+), 24 deletions(-)
>>>>>>>>>>
