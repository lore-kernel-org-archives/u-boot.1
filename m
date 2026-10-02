Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F77CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 05:47:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F21640B77;
	Fri,  2 Oct 2026 05:47:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OctTantEfR-4; Fri,  2 Oct 2026 05:47:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6C25240B5A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790920033;
	b=pHlCdmnLf1nNrW5zEHYgLgQp3mBJuZg3wctGYGwq/shsFqhIR/dKQJS541ROu9S8Ioq0
	 O6HUnIKHfLr3xMzQRcncAxS6u5YTo+RhVY7jCnIC+27Pjd3isoEkRRxb2IMchw6vf0Bvf
	 OVK1n8LDocosHYAbKuJ2mdDMnikeyKC6kzO19n0qCDdxpUwcNJaYFN2WiILtwEnYUbMPY
	 KHm9dIawI/XhX1irv2C4U1jPg1s++sQTinZPad+/uim1MMmp2D4Kw+WLL83GAMEhMuN7g
	 ywaYM8c8SBuGqn0ATPwBBl82PV1T5LBNDes60ryAXUEBCVPi/ucLd9Qz9AfDhy/y5gQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790920033;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=josSrn8Sk+UK1TYrKcMOl1d7s74GAkH6WpDoUQI+LAw=;
	b=jjRtg2JL2N6djhBP0zuZ0weMC/Hcm7Fe1KGm0M/OL3U00KkKxQyynu2PDiMIR04GQBNT
	 yTUx9/Gp6odKAkiH2EfuhVRSQcvN738UxCQ/85hj6dqNAKXFMZG8q/yuLI3S4b27+H+Sz
	 1YjsHXy3xYjPG+T+tWjuSDLZlSNF6qPpbuqbfhIfQOzcPl8IlrinzsdSsajBR3uJiNu/X
	 EBrn5nnybxDepNpXEn4xoyZBu1PcKI7ZD0w/owPVBa9lHwYLv02sN5YtmfvXPZecy23f1
	 KFWQgWfV7vOIs1xm1saF34GFsH9h7IAGuF9xQM1fpS7Bg6spMkLp5TwqHFj8WPbjZJg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=b9dWbrgw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790920033;
	bh=josSrn8Sk+UK1TYrKcMOl1d7s74GAkH6WpDoUQI+LAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1HVYNRuhSJu/hsxsg97BNNw6shd5CbsJUb46A47iGrYtQ2K6KP51VrwwegjpddFgs
	 JS3XqgIaGhze+PSl3JrTnIQDtCTjSMRiZDw7/d/4BH8DiPSIwkerrBTcCIDtaMzpnl
	 Z6xdQCwMV7TLfs8J3ObOaq4M/mc0S7aPdAXa+4YpxEBupIBEjiqlFZQjaYs74Jq1zh
	 9/vHwo3kRQr4U4ArY2o7vp0Pi9r/JVQszYLsJAAl6BKIST2nBWAHrQyNkfj4pcx2DW
	 8tz6VZnqfKsyelQl+MSQQPlKLSPMz8Nh7NbvasglaJbSSKDwAb9KU+xOtA0tn6pBvZ
	 kd2wBAH1GH6tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C25240B5A;
	Fri,  2 Oct 2026 05:47:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 782DA22B
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 05:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 75BA540B5A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 05:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZVEiNWhnkfBx for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 05:47:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 53E9140B51
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790920031;
 b=QLeIFO0Bodt2W0lQUQy5JDQ8QMHVVpoTRDxySRzicVtpG6pubP8XxZmi0jjoCpwiyJq0
 fJrtTPR4hDuXKloVJdA5tFMV7uC3yR2ynlZp4Sp+4Adrji/AMrzPQ1TmbgcFoo8PUzFiq
 mCTDkbRWVdWhlm5pgAYcoivw4innBLeQz+1N2tgRzZyRjXP80fC6IveJyG4UyoWNLx4/3
 dRUdWuPmGeJUMt+WinfwzaNGgbxE5fA4FjWOcVoxEmYh1p7tlhrv2MgmtkuJSml/LWaON
 HQxKCXiTXKBCiJO2AEuGp/hruJDBJgCYy8Km0ilhUBo/UbccRsIDCRhgpkPvSr2OmIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790920031;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=josSrn8Sk+UK1TYrKcMOl1d7s74GAkH6WpDoUQI+LAw=;
 b=Y1Dw4L3xUybNTNxfwZ+7FwmzzPsn5yyZKEUsVsUVrSH02XpkQF/EIe0tKHYiVdybFtLH
 5GzCe4yoo6ifPkIwVicCHQQ72b1R7WzytXZg2fNNJYgzyS1Q+TbD6/a0SHQGuBzgXB1Xe
 KbUlyfWTdYAhX9HHZnex8X4Itb6Lrh9UAUaUHyXGxpSZJGwo9JBgHeRT8wxhCm3ah38XQ
 Eo2Bb8rzWt0OGl/d5NOP08fgweV4DuMgheITkFWv0F1N2+9shptgTo0a7zWfJ8aOvkyhr
 cn8Fg+r0UW9JPmMNSQMlENOAXJrZaysnjZD6/FsWcetHeYsCdDahWy+ykFY6xKbeMIw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=b9dWbrgw; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1fb7=hy=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=b9dWbrgw
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53E9140B51
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 05:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1790920029;
 bh=josSrn8Sk+UK1TYrKcMOl1d7s74GAkH6WpDoUQI+LAw=;
 b=b9dWbrgw1f5fYKL07TjkSsa5uz4lFxgLFW8anfmwZKcImKs66vp/9XYap6IFZ3fnA+8qMer+l
 nSHwldsK6/wVRvAm/DieUsXDCF7CEzWb/JQQ1zurmoQO4EP5LulPXTZDodnbK201pL5HHxB00U/
 2ab4rpo+N+1DWxJM1Xaq3qPxgz9rYYekK29pPhhUJ9IgLCUXOwHG1/TxYwXyAq+zo+aZ0VIElsq
 W85gluOC3OdOhC/zugJNZ/RPXxcJilGQn5ppL3QPneRWgyIPldj+Cx/eSKuhJOkVJJxbqdy0/yN
 FZ2Qc8YNbApPt2IKOdXl7DtA3h4cQg3lYEsbTHrsxVWw==
X-Forward-Email-ID: 6abf455b13359ab4759aadfa
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.17.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <8baf5015-eefd-45c3-ab65-7e779407e620@kwiboo.se>
Date: Fri, 2 Oct 2026 07:47:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Disable SMBIOS table creation for Odroid M2
To: Milivoje Legenovic <m.legenovic@gmail.com>
Cc: Quentin Schulz <u-boot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20260926005853.1727-1-m.legenovic@gmail.com>
 <CAFLszTh=X272wjo4_7B54hYMz4gRZ78KhUuDCKBPzOR8L4RA3g@mail.gmail.com>
 <CAGuQyfUdhhFuW-DCgw8C5hA8mkgP9DGyUW6XnLdMZ0q+Ui0QzA@mail.gmail.com>
 <CAFLszThQZy=Sj7bRsbWOFn=Sn4mgzkeo=4Sj0Qyhu9cWotO1ZA@mail.gmail.com>
 <CAGuQyfVDA9cGRk-o9O2ha3GC5-U+7q3fwz3tJ08-DOxiQEMi=w@mail.gmail.com>
 <CAGuQyfXOPM1KVci6rD1x-uav+dGiH5z2HMz+_5zeXP0BBJhX9A@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAGuQyfXOPM1KVci6rD1x-uav+dGiH5z2HMz+_5zeXP0BBJhX9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Milivoje,

On 10/2/2026 2:55 AM, Milivoje Legenovic wrote:
> Hi Quentin,
> 
> You’re actually right; git bisect has shown that the problematic
> commit is the following one:
> 
> commit c6bba31dbdd450081503dc0e20fcfb4328b347e4
> Author: Jonas Karlman <jonas@kwiboo.se>
> Date:   Sat Jul 12 21:12:29 2025 +0000
> 
>     rockchip: spl-boot-order: Defer probe of boot device
> 
>     Boot devices are being probed when SPL boot order is determined. This
>     may delay boot slightly and can prevent booting from SPI Flash on boards
>     that use same pins for SPI Flash and eMMC due to pinctrl being applied
>     prior to booting.
> 
>     Instead defer probe of the boot device until SPL try to load image from
>     the boot device by using uclass_find_device_by_of_offset() instead of
>     the get variant.

This patch changed so that devices is lazy probed in SPL, a side affect
from this has likely been that the clock drivers are no longer always
probed in SPL phase.

Please see the test the series "rockchip: Always init clocks in SPL
build for RK35xx" [1], it should help ensure that e.g. SPLL and CPU PLLs
are configured in SPL, instead of possible having to wait until Linux
configures CPU clocks.

[1] https://lore.kernel.org/u-boot/20260804002643.2308515-1-jonas@kwiboo.se/

Regards,
Jonas

> 
> Your question about used u-boot and kernel version: currently u-boot
> version is v2025.10, and this version works. I tried switching to
> v2026.01 a while ago, but because of this problem I’ve been waiting
> for a newer version to come out, in the hope that the problem will be
> sorted out there. I’ve tried every new version, but the problem
> persisted.. Kernel versiona are: 6.18 (so called "current" kernel in
> Armbian) and 7.2 (so called "edge"). I have tested both versions, but
> the behaviour is the same. For git bisect I have used "edge" kernel
> (7.2.8).
> 
> I’m absolutely on your side – we should get to the root of the problem
> rather than just treating the symptoms.
> 
> Cheers,
> Milivoje
> 
> On Thu, Oct 1, 2026 at 8:59 PM Milivoje Legenovic <m.legenovic@gmail.com> wrote:
>>
>> Hi Simon,
>>
>> 'dmesg | grep -i dmi' shows this:
>>
>> [    1.107089] DMI not present or invalid.
>>
>> and /sys/firmware/dmi/tables is not populated:
>>
>> ls -l /sys/firmware/dmi/tables
>> ls: cannot access '/sys/firmware/dmi/tables': No such file or directory
>>
>> Adding fdt_add_mem_rsv() does not change anything, it still hangs, and
>> "DMI not present or invalid" message remains. This is how I did it:
>>
>> fdt_add_mem_rsv(fdt, smbiosaddr, 0x00001000);
>>
>> As I’m not familiar with the code, I didn’t know how to calculate or
>> determine the table size, so I simply used the SZ_4K constant (aligned
>> to 4KB). Let me know if that is wrong, and what the correct value
>> should be.
>>
>> Cheers,
>> Milivoje
>>
>> On Thu, Oct 1, 2026 at 3:27 AM Simon Glass <sjg@chromium.org> wrote:
>>>
>>> Hi Milivoje,
>>>
>>> On Wed, 30 Sept 2026 at 23:29, Milivoje Legenovic <m.legenovic@gmail.com> wrote:
>>>>
>>>> Hello everyone,
>>>>
>>>> Here are the details of my analysis:
>>>> The commit that introduced the change in behavior in version 2026.01
>>>> is this one:
>>>>
>>>> commit 209bbc4e0032228c6ea17e2172a8a6b89756c4f5
>>>> Author: Adriana Nicolae <adriana@arista.com>
>>>> Date:   Thu Nov 27 08:28:34 2025 -0800
>>>>
>>>>     boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI boots
>>>>
>>>>     The Linux kernel can discover SMBIOS tables through two primary methods:
>>>>     1. Via EFI tables, when using EFI boot;
>>>>     2. Via the 'smbios3-entrypoint' property in the /chosen node of the
>>>>     device tree.
>>>> ...
>>>>
>>>> I found this out by comparing the device tree from a working version,
>>>> decompiled using
>>>>
>>>> sudo dtc -I fs -O dts /sys/firmware/devicetree/base -o live_tree.dts
>>>>
>>>> and difference was in /chosen node:
>>>>
>>>> chosen {
>>>>         u-boot,version =
>>>> "2026.01_armbian-2026.01-S127a-P7283-Hee1c-V2928-B3a7f-R448a";
>>>>         linux,initrd-end = <0x00 0xecbffca5>;
>>>>         bootargs = ...
>>>>         smbios3-entrypoint = <0x00 0xedf47000>;
>>>>         kaslr-seed = <0x00 0x00>;
>>>>         linux,initrd-start = <0x00 0xeb519000>;
>>>>         stdout-path = "serial2:1500000n8";
>>>> };
>>>>
>>>> In 2026.01 version smbios3-entrypoint was there, in 2025.10 not. I
>>>> searched for this term in git history and found the commit mentioned
>>>> above.
>>>> With git show I saw what activates this, and made a patch in armbian
>>>> build system to disable it and confirm it fixes the problem. And it
>>>> fixed it.
>>>>
>>>> Here is also where kernel hangs for 60 seconds (always at the same place):
>>>>
>>>> [   14.482048] calling  gpio_led_driver_init+0x0/0x38 @ 1
>>>> [   78.137967] Freeing initrd memory: 23448K
>>>> [   78.165027] probe of leds returned 0 after 63677665 usecs
>>>> [   78.166792] initcall gpio_led_driver_init+0x0/0x38 returned 0 after
>>>> 63684076 usecs
>>>>
>>>> As you can see, I was only able to find the cause, but that’s the
>>>> extent of my expertise.
>>>>
>>>> At first, I wanted to sort out the problem with a patch in the Armbian
>>>> build project, but then I thought: "Why not sort it out at source?"
>>>
>>> Good idea!
>>>
>>> Does 'dmesg | grep -i dmi' show a DMI line, and is
>>> /sys/firmware/dmi/tables populated? That shows whether the kernel
>>> reads the property.
>>>
>>> Does the hang go away if the property stays but the region is
>>> reserved? A quick hack is fdt_add_mem_rsv(fdt, smbiosaddr, TABLE_SIZE)
>>> next to the setprop in fdt_chosen()
>>>
>>> If so, you could add a fix for 209bbc4e003 - i.e. reserve the table.
>>>
>>> Regards,
>>> Simon
>>>
>>>>
>>>> Cheers,
>>>> Milivoje
>>>>
>>>> On Mon, Sep 28, 2026 at 4:37 PM Simon Glass <sjg@chromium.org> wrote:
>>>>>
>>>>> On Fri, 25 Sept 2026 at 18:59, Milivoje Legenovic <m.legenovic@gmail.com> wrote:
>>>>>>
>>>>>> After upgrading u-boot in Armbian for the Odroid M2 board from
>>>>>> version v2025.10 to a higher version (it doesn’t matter which one),
>>>>>> the board does boot, but the boot process halts for 60 seconds,
>>>>>> and only continues once this time has elapsed. Debugging via a
>>>>>> UART cable showed that u-boot hands control over to the kernel,
>>>>>> and then freezes there. The only difference compared to v2025.10
>>>>>> was the SMBIOS table. After disabling this configuration option
>>>>>> everything worked perfectly.
>>>>>>
>>>>>> Signed-off-by: Milivoje Legenovic <m.legenovic@gmail.com>
>>>>>> ---
>>>>>>  configs/odroid-m2-rk3588s_defconfig | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>>
>>>>> But I agree it would be useful to know why the kernel can hang in this
>>>>> way (I didn't even know it looked at SMBIOS tables!)
>>>>>
>>>>> - Simon

