Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8E3C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 15:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17EB6876D3;
	Sat,  3 Feb 2024 16:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HnZ2P6gD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17726871DF; Sat,  3 Feb 2024 16:04:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 973EB876D3
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 16:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=eede=JN=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1706972644;
 bh=mbnwt1jcdSw5CkrEImKQ45M5hOlcxW2IFSVivjwQkrE=;
 b=HnZ2P6gDswmrL2X1ndXnEYVdu02NvIEAr1udVPjVz9rpPSbBiJfMZUb10rZqeH4B75fIRxK3j
 EoQp95YWBUJj1pxhn2fIEY5lJ7MYvtjc7K2y7pXjwrhQdtPPW7LbqV6xou4yOdSX+kGj/sbjyhH
 29yp/oNdVM92DYAf8Ev5aA/kd3TboFDALGYHlV6pvBpp6CM4e3ST8/g/vuyWs9yGtYxIeFpcQdW
 xMOhbmLkqv+9w2I0+CTy0FJy5qBMbKL0FxJvOKQ/IlpNh9DW5r5XY2qIbkT5iI4nPKsTfaUQbf4
 bNcw1YYe8bjz5zDzXwftow46jHh+U/W61y9Ce+pTTjsg==
Message-ID: <3fffabfd-8f3c-429f-b613-672849232046@kwiboo.se>
Date: Sat, 3 Feb 2024 16:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Eugen Hristev
 <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>, Simon
 Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom
 Rini <trini@konsulko.com>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andy Yan <andyshrk@163.com>, Tianling Shen <cnsztl@gmail.com>, Akash
 Gajjar <gajjar04akash@gmail.com>, Joshua Riek <jjriek@verizon.net>
References: <20240126232615.6826-1-jonas@kwiboo.se>
 <20240126232615.6826-2-jonas@kwiboo.se>
 <515157a9-8d19-42f9-ae6d-914aaea8a3ba@collabora.com>
 <e1417a87-15ee-4e1b-9513-c101a02118d4@kwiboo.se>
 <23d7337a-88b7-4dcb-be08-c42b21e9dbd1@theobroma-systems.com>
 <e9d6883b-4331-4237-be19-5df6126a3962@kwiboo.se>
 <ab9af16d-37f5-43a1-9dc6-9d1ba93c1689@theobroma-systems.com>
 <54ad872d-c47a-46ea-a4a5-c9776ae6213f@kwiboo.se>
 <10f0b268-0a9d-41a8-ba4e-d02abb62e418@theobroma-systems.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <10f0b268-0a9d-41a8-ba4e-d02abb62e418@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65be55e24babf999bf9ca7df
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

Hi Quentin,

On 2024-02-02 12:10, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 2/1/24 21:06, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 2024-02-01 13:40, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 2/1/24 11:51, Jonas Karlman wrote:
>>>> Hi Quentin,
>>>>
>>>> On 2024-02-01 11:18, Quentin Schulz wrote:
>>>>> Hi Jonas,
>>>>>
>>>>> On 1/27/24 12:15, Jonas Karlman wrote:
>>>>>> Hi Eugen,
>>>>>>
>>>>>> On 2024-01-27 04:48, Eugen Hristev wrote:
>>>>>>> Hi Jonas,
>>>>>>>
>>>>>>>
>>>>>>> On 1/27/24 01:26, Jonas Karlman wrote:
>>>>>>>> Writing to eMMC using DDR52 mode does not work reliably or at all on
>>>>>>>> RK356x and RK3588 boards.
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> This is related to the old issue I encountered last year with mmc write?
>>>>>>
>>>>>> Yes, I think it is.
>>>>>>
>>>>>> I did some testing on RK3566/RK3568/RK3588S/RK3588 boards with different
>>>>>> eMMC modules with following result:
>>>>>>
>>>>>> Read seem to work with all enabled modes:
>>>>>> RK3566: MMC legacy, MMC High Speed (26MHz), MMC High Speed (52MHz),
>>>>>>            MMC DDR52 (52MHz) and HS200 (200MHz)
>>>>>> RK3568/RK3588S/RK3588: all above + HS400 (200MHz) and HS400ES (200MHz)
>>>>>>
>>>>>> However, write had issues with some of the modes:
>>>>>> MMC DDR52 (52MHz): all RK35xx
>>>>>> HS400/HS400ES: only on RK3568 after changing hs400_txclk_tapnum to 8
>>>>>>
>>>>>> HS200 seem to be the most stable write speed that worked on all SoCs.
>>>>>>
>>>>>> So, dropping MMC DDR52 (52MHz) and enable use of HS200 (200MHz) seem to
>>>>>> be the best option to get speedy and working read and write eMMC.
>>>>>>
>>>>>
>>>>> 1) we have this enabled on RK3588 Jaguar in upstream Linux... I may have
>>>>> improperly tested it then, would you mind sharing how you tested this
>>>>> mode on RK3588 so I can reproduce this and fix it on our product if
>>>>> we're impacted? I assume because we have HS200/HS400/HS400-ES enabled,
>>>>> DDR52 would never be used? (our eMMC is soldered and support the former
>>>>> modes).
>>>>
>>>> My main mode of testing eMMC in U-Boot has been to enable following
>>>> Kconfig options,
>>>>
>>>> CONFIG_MMC_HS200_SUPPORT=y
>>>> CONFIG_MMC_HS400_SUPPORT=y
>>>> CONFIG_MMC_HS400_ES_SUPPORT=y
>>>> CONFIG_MMC_SPEED_MODE_SET=y
>>>>
>>>> and from U-Boot cli run following,
>>>>
>>>> => mmc rescan <mode> && mmc info && mmc read 10000000 2000 10000
>>>> => mmc rescan <mode> && mmc info && mmc write 20000000 4000 10000
>>>>
>>>> for each of the modes below.
>>>>
>>>>     0 = MMC legacy
>>>>     1 = MMC High Speed (26MHz)
>>>>     3 = MMC High Speed (52MHz)
>>>>     4 = MMC DDR52 (52MHz)
>>>>     10 = HS200 (200MHz)
>>>>     11 = HS400 (200MHz)
>>>>     12 = HS400ES (200MHz)
>>>>
>>>> on different boards and different eMMC modules.
>>>>
>>>> Using some modes the read or write return ERROR instead of OK. When
>>>> ERROR was reported a rescan or board reset was needed to test next mode.
>>>>
>>>> Please also note that I have only tested in U-Boot, not in linux.
>>>>
>>>
>>> Thanks for the tips on how to test these.
>>>
>>> I have run the following commands on an RK3588 Jaguar (master branch +
>>> your v6.8-rc1 DTS sync patch series + Jaguar patch series):
>>>
>>> => for j in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19; do for i
>>> in 0 1 3 4 10 11 12; do mmc rescan $i && mmc read 10000000 2000 100000;
>>> if test $? -ne 0; then echo $i FAILED; fi; done; done
>>>
>>> Which is 20 iterations of an mmc read at each of the 7 supported modes.
>>> The result is:
>>> 1 fail in HS200, 2 fails in HS400, the rest passes just fine.
>>
>> I am wondering if your HS200 fails could be because MMC DDR52 (52MHz)
>> was being tested prior to the HS200 mode.
>>
>> What happens if you exclude the mmc-ddr-1_8v prop and mode 4 in your
>> test loops?
>>
>> I did some quick re-test on a ROCK 5A (rk3588s) and ROCK 5B (rk3588)
>> with DDR52 removed and could only see very few read fails with HS400.
>>
> 
> OK so I did something completely different instead. rescan in one mode, 
> do a read, power cycle, rescan in another mode, do a read, power cycle, 
> etc....
> 
> All tests passed.
> 
> Then...
> 
>>>
>>> => for j in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19; do for i
>>> in 0 1 3 4 10 11 12; do mmc rescan $i && mmc write 20000000 4000 100000;
>>> if test $? -ne 0; then echo $i FAILED; fi; done; done
>>>
>>> Which is 20 iterations of an mmc write at each of the 7 supported modes.
>>> The result is:
>>> 20 fails in DDR52, 2 fails in HS200, the rest passes just fine.
>>>
>>> So it seems DDR52, HS200 and HS400 aren't stable on my board, but
>>> HS400ES somehow is (which is enabled in our defconfig).
>>
> 
> I did the same for the write:
> 
> rescan in one mode, do a write, power cycle, rescan in another mode, do 
> a write, power cycle, etc....
> 
> And this brought surprising results:
> 
> EVERYTHING except HS200, HS400 and HS400ES failed. Like not even a block 
> was written.

I now vaguely remember something similar from when I tested back in
November, however during re-testing before posting this series I only
tested without a full power reset between different modes :-)

> 
> Now, that was not really what I remember happening yesterday. So it 
> seems that the modes before HS200 may rely somehow on previous 
> rescans/reads.
> 
> So I tested this theory by just running a single mmc read of one block 
> after doing a rescan and before doing a write. This didn't help.
> 
> Now, I forced a HS400ES read before doing writes at modes below HS200 
> (excluded) and they didn't work. However, once I did a single block read 
> in HS400 instead of HS400ES, the writes in those same modes started to 
> work (except DDR52).
> 
> They also worked when doing a single block read in HS200.

Thanks for testing this more thoroughly!

> 
> For all those tests, I still had mmc-ddr-1_8v in my DT.
> 
> So, I would say everything that isn't HS200+ is broken on RK3588? Did 
> the modes below DDR52 work for you?

I re-tested booting of a SD-card on RK3588 and found out following:

- Write in DDR52 mode never works, hence this patch
- Read works in all modes directly after a power reset

- First write in modes that isn't HS200+ fails
  => mmc rescan 0 && mmc write 2000000 4000 1 # ERROR

- Second+ write in same mode that just failed works
  => mmc write 2000000 4000 1 # OK

- After a rescan to HS200 mode (probably any HS200+) first write in
  modes that isn't HS200+ no longer fails until power reset
  => mmc rescan 10 && mmc rescan 0 && mmc write 2000000 4000 1 # OK

- When rockchip_sdhci_execute_tuning() is empty, changing to HS200 mode
  no longer "fixes" the write for slower modes
  => mmc rescan 10 && mmc rescan 0 && mmc write 2000000 4000 1 # ERROR

- Trying to execute tuning for modes slower then HS200 fails as expected

So based on testing I would say that any mode that isn't HS200+ is only
semi-broken because writing seem to start working after a second try.
And after tuning has been executed in HS200+ any other mode seem to work.

Maybe we should enable the HS200 options for ROCKCHIP_RK3588 by default
instead of explicitly enabling it in defconfig for boards that have
MMC_SDHCI_ROCKCHIP enabled?

--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -665,6 +665,8 @@ config MMC_SDHCI_ROCKCHIP
        depends on ARCH_ROCKCHIP
        depends on DM_MMC && BLK
        depends on MMC_SDHCI
+       imply MMC_HS200_SUPPORT if ROCKCHIP_RK3588
+       imply SPL_MMC_HS200_SUPPORT if ROCKCHIP_RK3588
        help
          Support for Arasan SDHCI host controller on Rockchip ARM SoCs platform

Regards,
Jonas

> 
> Cheers,
> Quentin
> 
>> Please re-test with DDR52 mode skipped and see if you get any other
>> result for HS200 mode.
>>
>> And you are correct, HR400ES seem to also be working fine on my RK3588
>> boards. I can see now that on my old testing commit [1] I only mention
>> and drop the hs400 mode and not the hs400es mode for rk3588. Could also
>> be the change to emmc_data_strobe pinctrl that got synced from linux
>> v6.7 that help improve HR400ES mode results.
>>
>>  From a very quick re-test on two boards with two different emmc modules
>> I could only see a few "Select HS400 failed -70" lines being reported
>> when testing read and/or write using your test loops (with a few modes
>> skipped and smaller amount of data to read/write). Remaining modes seem
>> to be working okay.
>>
>> [1] https://github.com/Kwiboo/u-boot-rockchip/commit/cb1521aea8dee730bddcc5772afa28aa71fc69f9
>> [2] https://lore.kernel.org/all/20231205202900.4617-2-CFSworks@gmail.com/
>>
>> Regards,
>> Jonas
>>
>>>
>>> I'll check if there's an easier way to test the Linux kernel than
>>> rebooting with a newer DTB between every try.
>>>
>>> Cheers,
>>> Quentin
>>>
>>>>>
>>>>> 2) Why are we not enabling HS400/HS400-ES for RK3588 boards? You seem to
>>>>> be saying there are issues with HS400/HS400-ES on RK3568 but you didn't
>>>>> mention the status for RK3588. Did I misunderstand the last sentence?
>>>>> Can you please rephrase in that case?
>>>>
>>>> I can see now that my wording was very confusing.
>>>>
>>>> Write for HS400/HS400ES mode only worked on RK3568 after modification to
>>>> the driver, on RK3588 write always returned error for me.
>>>>
>>>> So on RK3568 HS400 modes could be made work, on remaining SoCs there was
>>>> issues.
>>>>
>>>> Regards,
>>>> Jonas
>>>>
>>>>>
>>>>> Cheers,
>>>>> Quentin
>>>>
>>

