Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D810EC54734
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 12:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 319FC87E9D;
	Tue, 27 Aug 2024 14:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iUPg2pIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A1A88981; Tue, 27 Aug 2024 14:00:57 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFC6D87BF4
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 14:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=164f=P3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1724760052;
 bh=8ggx/eHPGE0p7RShZpx+M/y/HhjIR0iqXnocRBzyphs=;
 b=iUPg2pIRrY9MxdFK1g3tq3aUTFQwfQAwfeug8lBi2BLvrBj/kyVmAHSJsk2uBTeDjkdCUBDrX
 72pfNgLn/qCLurwD1ZJH8eYvdJv8GuvcuUJOcK1Rca1HcZmjnaV9OpoDBSyic1rAZyS7k6FrF+A
 6ud9pN1ldHP6MjWfZJzjBBJLbO+Aw2evHErDe0ir8pRtPGX67D0+YoReadCu+WMmu4wmT4D+fsj
 28wmyilKbzh6wN1dfDOnke39o4PIP4RrxB1LGKZ18vhh6JhXbSHZ6slsMb+IzsvnqSWgegU7NEn
 TGrYN+nUTQPn+oELC9nJ5j3+uiY7lUzLiSW04hvSTKrQ==
Message-ID: fbd065a2-fe56-4781-aa79-089964eaefe1@kwiboo.se
Date: Tue, 27 Aug 2024 14:00:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: OF_UPSTREAM vs. additional dtbs
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <66cc4396.670a0220.ebd0d.a836SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAFA6WYOgL6726=EVQyuWPqXEuf+efZyt0AOmVWQXcLq5eOUOrg@mail.gmail.com>
 <66cc733b.050a0220.26d1c6.5ff7SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAFA6WYOuzJfDP1J=9c6Y=fg4m7UMguJBTAUj6gDnYmTNnCDmDQ@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFA6WYOuzJfDP1J=9c6Y=fg4m7UMguJBTAUj6gDnYmTNnCDmDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66cdbfefc6e9b6aad349dade
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

Hi Sumit,

On 2024-08-27 09:11, Sumit Garg wrote:
> On Mon, 26 Aug 2024 at 17:51, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Sumit,
>>
>> On 2024-08-26 13:48, Sumit Garg wrote:
>>> Hi Jonas,
>>>
>>> On Mon, 26 Aug 2024 at 14:27, Jonas Karlman <jonas@kwiboo.se> wrote:
>>>>
>>>> Hi Sumit,
>>>>
>>>> On 2024-08-26 08:44, Sumit Garg wrote:
>>>>> Hi,
>>>>>
>>>>> On Wed, 14 Aug 2024 at 22:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>
>>>>>> On 14.08.24 11:41, Jan Kiszka wrote:
>>>>>>> On 13.08.24 14:52, Nishanth Menon wrote:
>>>>>>>> On 11:16-20240813, Jan Kiszka wrote:
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
>>>>>>>>> facing issues because I need to still build the u-boot-only overlays. It
>>>>>>>>> is also a bit weird (but works) having to specify
>>>>>>>>>
>>>>>>>>> CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"
>>>>>>>>>
>>>>>>>
>>>>>>> Actually, this does NOT work: I just had a long morning debugging SPL
>>>>>>> which no longer started because it picked the non-filtered dtb. The
>>>>>>> filtered one ended up in a folder outside of the u-boot sources because
>>>>>>> of all those ../ and hard-wiring to dts/upstream.
>>>>>>>
>>>>>>>>> for our spl dtb.
>>>>>>>>>
>>>>>>>>> Are there means to still build certain dtb[o] files in arch/<arch>/dts?
>>>>>>>>> I'm a bit lost in the Makefile forest.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Sumit: Any suggestions?
>>>>>>>>
>>>>>
>>>>> Apologies for the delayed reply. I was a bit busy with other high
>>>>> priority stuff.
>>>>>
>>>>>>>
>>>>>>> I would really like to hear some better proposals than my local
>>>>>>> workarounds to far. They don't converge although I already patched some
>>>>>>> core Makefile (overlays are building now).
>>>>>>>
>>>>>>
>>>>>> OK, I side-stepped the spl issue by using one of our variant DTBs for
>>>>>> spl as well - happens to work.
>>>>>
>>>>> That's good to know.
>>>>>
>>>>>>
>>>>>> For the overlays, I need to add
>>>>>>
>>>>>> --- a/scripts/Makefile.dts
>>>>>> +++ b/scripts/Makefile.dts
>>>>>> @@ -1,5 +1,7 @@
>>>>>>  # SPDX-License-Identifier: GPL-2.0+
>>>>>>
>>>>>> +include $(srctree)/config.mk
>>>>>> +
>>>>>>  dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
>>>>>>
>>>>>>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
>>>>>>
>>>>>>
>>>>>> in order to then be able to do
>>>>>>
>>>>>> --- a/board/siemens/iot2050/config.mk
>>>>>> +++ b/board/siemens/iot2050/config.mk
>>>>>> @@ -5,4 +5,12 @@
>>>>>>  # Authors:
>>>>>>  #   Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> +ifneq ($(CONFIG_SPL_BUILD),y)
>>>>>> +dtbo-list = \
>>>>>> +       k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay \
>>>>>> +       k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay
>>>>>> +
>>>>>> +dtb-y += $(patsubst %,../../../../arch/arm/dts/%.dtbo,$(dtbo-list))
>>>>>> +endif
>>>>>> +
>>>>>>  flash.bin: all
>>>>>>
>>>>>>
>>>>>> Does that make sense?
>>>>>
>>>>> A switch to OF_UPSTREAM means that we build all the DT artifacts from
>>>>> dts/upstream/src/ directory with the only exception that we include
>>>>> U-Boot specific overrides via *-u-boot.dtsi from arch/<arch>/dts. In
>>>>> case of overlays, is there any reason for IOT2050 board overlays not
>>>>> being pushed into Linux kernel repo? AFAIU, overlays are also
>>>>> describing puggable hardware so they shouldn't be referred to as
>>>>> "u-boot-only" overlays.
>>>>
>>>> I have a related issue where I would like to build board DT from
>>>> dts/upstream, however there is also a need for a limited U-Boot specific
>>>> DT that only is intended for initial boot so that U-Boot at runtime can
>>>> determine what hw revision is booting and select correct DT to use for
>>>> U-Boot proper and OS.
>>>>
>>>> For now I have just set the board target to use OF_UPSTREAM=n and
>>>> instead created minimal .dts-files in arch/<arch>/dts that include the
>>>> full .dts-file from dts/upstream.
>>>>
>>>> Any suggestion on how we better can support having a U-Boot only
>>>> .dts-file together with OF_UPSTREAM=y ?
>>>
>>> The motivation is rather to avoid any U-Boot specific DT files.
>>> Shouldn't you be able to create a DT overlay of v2.1 board over v1.1
>>> and push that upstream? The runtime DT choice sounds pretty similar to
>>> how you can choose to apply the DT overlay or not with common boot DT.
>>> Also, bundling multiple DT within U-Boot proper FIT image can be an
>>> alternative too.
>>
>> Both rk3566-orangepi-3b-v1.1.dts and rk3566-orangepi-3b-v2.1.dts are
>> in/from upstream Linux, and they are both included in the same FIT along
>> with the default U-Boot specific DT (rk3566-orangepi-3b.dtb):
>>
>>  CONFIG_OF_LIST="rk3566-orangepi-3b rk3566-orangepi-3b-v1.1 rk3566-orangepi-3b-v2.1"
>>
>>  Default Configuration: 'config-1'
>>  Configuration 0 (config-1)
>>   Description:  rk3566-orangepi-3b.dtb
>>   Kernel:       unavailable
>>   Firmware:     atf-1
>>   FDT:          fdt-1
>>   Loadables:    u-boot
>>                 atf-2
>>                 atf-3
>>                 atf-4
>>                 atf-5
>>                 atf-6
>>  Configuration 1 (config-2)
>>   Description:  rk3566-orangepi-3b-v1.1.dtb
>>   Kernel:       unavailable
>>   Firmware:     atf-1
>>   FDT:          fdt-2
>>   Loadables:    u-boot
>>                 atf-2
>>                 atf-3
>>                 atf-4
>>                 atf-5
>>                 atf-6
>>  Configuration 2 (config-3)
>>   Description:  rk3566-orangepi-3b-v2.1.dtb
>>   Kernel:       unavailable
>>   Firmware:     atf-1
>>   FDT:          fdt-3
>>   Loadables:    u-boot
>>                 atf-2
>>                 atf-3
>>                 atf-4
>>                 atf-5
>>                 atf-6
>>
>> Main reason why a U-Boot specific DT is used is because the hw revisions
>> use different voltage for Ethernet PHY, and we want to avoid causing
>> damage to a board when runtime cannot determine what hw revision is
>> running, and thus we use a safe U-Boot specific DT.
> 
> Okay so the runtime check for hw revision isn't stable. If that's the
> case then I am unsure if we should enable it at all. IIUC in case a
> fallback to safe U-Boot DT is made then the ethernet won't be
> functional. I would rather favour separate U-Boot images for each
> board with corresponding DT to provide a fully functional system.

The runtime check is stable, at least for current hw revisions, however
the vendor is known to make minor revision changes. End-users may change
Kconfig options or future U-Boot changes may break the runtime detection.

Also there is history that wrong U-Boot vendor image has been used by
end-users and that has resulted in damage to Ethernet, so for mainline I
specifically wanted to avoid such issue by using a single U-Boot target
and play it safe if the runtime detection for whatever reason is not
fully working.

> 
>>
>> I do not see any reason to try and upstream this u-boot only DT to Linux,
>> since it's only purpose is to assist boot firmware to select correct DT.
> 
> I suppose similar functionality would be needed if any other
> bootloader/firmware has to be enabled for these boards. So we can't
> say it's particularly specific to U-Boot but it is rather a dowsized
> DT which can boot on both boards with ethernet non-functional. You can
> also rather have a single downsized DT supported upstream with 2
> overlays one for each board which can be applied on successful
> detection of hw revision.

Providing different firmware images for each hw revission can be an
option for other bootloaders, or they can provide similar runtime
detection as U-Boot.

So I still see a valid need for having U-Boot only DT together with main
DTs from dts/upstream. It can also be protected behind a new Kconfig
symbol, e.g. OF_UPSTREAM_MIXED or similar.

Regards,
Jonas

> 
> -Sumit
> 
>>
>> Regards,
>> Jonas
>>
>>>
>>> -Sumit
>>>
>>>>
>>>> Please see following for more details:
>>>> https://source.denx.de/u-boot/u-boot/-/commit/a52099b4a2ae9e8cafc79268325249bcad308012
>>>> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/rk3566-orangepi-3b.dts
>>>> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/rk3566-orangepi-3b-v1.1.dts
>>>> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/rk3566-orangepi-3b-v2.1.dts
>>>>
>>>> Regards,
>>>> Jonas
>>>>
>>>>>
>>>>> -Sumit
>>>>>
>>>>>>
>>>>>> Jan
>>>>>>
>>>>>> --
>>>>>> Siemens AG, Technology
>>>>>> Linux Expert Center
>>>>>>
>>>>
>>

