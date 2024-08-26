Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87186C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 08:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 050298877E;
	Mon, 26 Aug 2024 10:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yZm/xPnk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10C8588795; Mon, 26 Aug 2024 10:58:01 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 296FD880D1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 10:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a02a=PZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1724662673;
 bh=kYOSGlMXkS2i6m9P5Qb9v+j8ren79jTJP7YOeWTozZU=;
 b=yZm/xPnkrc4mvum1yi2IN60f+TzIrWTUKu+3hSAL+vYsqHM12lxFAweFX51+z2aAMZDEWGz8B
 u3JxLkPpZ5k+KUtzXGsw7GgRQLlSyjNnp040rkWmZkvi5xt3dx0dNSi+8ivc9UKSW8Qw1IjDg3Q
 S1mBxrnweQCWf7LY0GSuRbDcimjU+iYbH86IguMzQ444VU1bvNiW+WrJXSVaJdAV+GpDPqOCMFI
 GGfG/SXVKyXs6M9E1X+YYXTUbMkcTPZUmIWaazo1NkeoskFwws6ijhspdZpv17ltkOkrZkCm+P+
 tDqMnKFl4zWoJHZ5F9YYjKa9VMQl6qFbFB3VnXwX6b+A==
Message-ID: 8dc08759-c3ee-4c56-9902-d785e361baf7@kwiboo.se
Date: Mon, 26 Aug 2024 10:57:45 +0200
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
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66cc438f6a727c42ee54e658
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

On 2024-08-26 08:44, Sumit Garg wrote:
> Hi,
> 
> On Wed, 14 Aug 2024 at 22:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 14.08.24 11:41, Jan Kiszka wrote:
>>> On 13.08.24 14:52, Nishanth Menon wrote:
>>>> On 11:16-20240813, Jan Kiszka wrote:
>>>>> Hi all,
>>>>>
>>>>> I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
>>>>> facing issues because I need to still build the u-boot-only overlays. It
>>>>> is also a bit weird (but works) having to specify
>>>>>
>>>>> CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"
>>>>>
>>>
>>> Actually, this does NOT work: I just had a long morning debugging SPL
>>> which no longer started because it picked the non-filtered dtb. The
>>> filtered one ended up in a folder outside of the u-boot sources because
>>> of all those ../ and hard-wiring to dts/upstream.
>>>
>>>>> for our spl dtb.
>>>>>
>>>>> Are there means to still build certain dtb[o] files in arch/<arch>/dts?
>>>>> I'm a bit lost in the Makefile forest.
>>>>>
>>>>
>>>> Sumit: Any suggestions?
>>>>
> 
> Apologies for the delayed reply. I was a bit busy with other high
> priority stuff.
> 
>>>
>>> I would really like to hear some better proposals than my local
>>> workarounds to far. They don't converge although I already patched some
>>> core Makefile (overlays are building now).
>>>
>>
>> OK, I side-stepped the spl issue by using one of our variant DTBs for
>> spl as well - happens to work.
> 
> That's good to know.
> 
>>
>> For the overlays, I need to add
>>
>> --- a/scripts/Makefile.dts
>> +++ b/scripts/Makefile.dts
>> @@ -1,5 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0+
>>
>> +include $(srctree)/config.mk
>> +
>>  dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
>>
>>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
>>
>>
>> in order to then be able to do
>>
>> --- a/board/siemens/iot2050/config.mk
>> +++ b/board/siemens/iot2050/config.mk
>> @@ -5,4 +5,12 @@
>>  # Authors:
>>  #   Jan Kiszka <jan.kiszka@siemens.com>
>>
>> +ifneq ($(CONFIG_SPL_BUILD),y)
>> +dtbo-list = \
>> +       k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay \
>> +       k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay
>> +
>> +dtb-y += $(patsubst %,../../../../arch/arm/dts/%.dtbo,$(dtbo-list))
>> +endif
>> +
>>  flash.bin: all
>>
>>
>> Does that make sense?
> 
> A switch to OF_UPSTREAM means that we build all the DT artifacts from
> dts/upstream/src/ directory with the only exception that we include
> U-Boot specific overrides via *-u-boot.dtsi from arch/<arch>/dts. In
> case of overlays, is there any reason for IOT2050 board overlays not
> being pushed into Linux kernel repo? AFAIU, overlays are also
> describing puggable hardware so they shouldn't be referred to as
> "u-boot-only" overlays.

I have a related issue where I would like to build board DT from
dts/upstream, however there is also a need for a limited U-Boot specific
DT that only is intended for initial boot so that U-Boot at runtime can
determine what hw revision is booting and select correct DT to use for
U-Boot proper and OS.

For now I have just set the board target to use OF_UPSTREAM=n and
instead created minimal .dts-files in arch/<arch>/dts that include the
full .dts-file from dts/upstream.

Any suggestion on how we better can support having a U-Boot only
.dts-file together with OF_UPSTREAM=y ?

Please see following for more details:
https://source.denx.de/u-boot/u-boot/-/commit/a52099b4a2ae9e8cafc79268325249bcad308012
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/rk3566-orangepi-3b.dts
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/rk3566-orangepi-3b-v1.1.dts
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/rk3566-orangepi-3b-v2.1.dts

Regards,
Jonas

> 
> -Sumit
> 
>>
>> Jan
>>
>> --
>> Siemens AG, Technology
>> Linux Expert Center
>>

