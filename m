Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23C3CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 19:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F843808AF;
	Tue,  4 Nov 2025 20:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iGUeQeTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C4382A9E; Tue,  4 Nov 2025 20:58:41 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEFCA8004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 20:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d2e=5N=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1762286317;
 bh=YpgqGJCiQKTIVkpaPcABvP4WSrcJ/p54MMQkksFG2pE=;
 b=iGUeQeTF1xsw3tVSTAec5zw1BGzr/x2tg/whH1eYRSwMVWfhW+0vW4ibihTv3q4jMfvcVgR81
 hluMM5nVQT1gWB9CJAlKbiK2YJUCtSUzaA5QM63X3I0ofrJqgrdqFU5u/q4GTmBwHq3Ju7HjEcx
 6W5AM6SkyYyhM0D3rx+R1VU1qwruUBsQkViFyBWqYBmfhoDHwMwpiRmtA4qjXYFAx4triprauwQ
 H2nTlnH5oN2HrKo/0vbSW7x5hbvv9R8ey219g++9VLLCUCiJvE97lmfcqvNURDhzc+VCZzu8LJ6
 KBEYUkCoHGN3n5HmaFglN7x5jZPDpEjvy6Vhh+bwtaJQ==
X-Forward-Email-ID: 690a5ae9c1241ac5cd3cab13
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.4.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <fa5080ae-0652-451a-8b71-d90d6fb139a8@kwiboo.se>
Date: Tue, 4 Nov 2025 20:58:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add Radxa ROCK 5B+ defconfig
To: Bryan Hinton <bryan@bryanhinton.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <dc3d6a1c-37f1-45c9-95c0-d37effcb2ad5@kwiboo.se>
 <097D31DF-D7AC-4008-BF9A-CBFBF01247A4@bryanhinton.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <097D31DF-D7AC-4008-BF9A-CBFBF01247A4@bryanhinton.com>
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

Hi Bryan,

On 11/4/2025 8:43 PM, Bryan Hinton wrote:
> Thanks, I did see that. When I pulled mainline master, I only saw the 5b
> defconfig and dtsi includes in arch/arm/dts. The plus dts file was in
> dts/upstream/src/arm64/rockchip and appeared to mirror the dts
> configuration in Linux mainline arch/arm64/boot/dts/rockchip for the 5b+.
> I tried the dts configuration a few different ways and reduced it to just
> including the 5b config per Tom in the patches just sent.
> I’m doing other testing on the board related to memory and timing, and
> hope to submit some more mainline contributions in the future.

Please try the existing series and if possible review it instead of
sending a new conflicting series :-)

The plan is to use a single rock5b defconfig target for both 5B and 5B+.
And in the future the ROCK 5T should also be able to the same target.

> 
> Which TPL do you use for testing the rock5b+?

The latest ddr bin from rkbin at the time when my series was sent back
in July and August when my series was sent, should have been the
v1.19.bin blob. Did you have an issue with a TPL blob using my series?

With my series applied you should be able to build the rock5b target
and when booting on a 5B+ you should be able to see something like

  Model: Radxa ROCK 5B+
  SoC:   RK3588

and this will indicate that the 5B+ device tree is correctly used.

Regards,
Jonas

> 
> 
>> On Nov 4, 2025, at 1:04 PM, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> ﻿Hi Bryan,
>>
>>> On 11/4/2025 7:25 PM, Bryan Hinton wrote:
>>> This series adds initial support for the Radxa ROCK 5B+ (RK3588).
>>> It introduces a new defconfig that mirrors the ROCK 5B baseline
>>> while building from the vendored upstream DTS snapshot
>>> (rockchip/rk3588-rock-5b-plus).
>>
>> Please take a look at the existing "rockchip: Add support for ROCK 5B+"
>> series at [1], it extends the rock5b target to also support the 5B+
>> variant instead of adding a new defconfig target.
>>
>> [1] https://patchwork.ozlabs.org/cover/2118033/
>>
>> Regards,
>> Jonas
>>
>>>
>>> Tested on ROCK 5B+ rev 1.2 (32 GB LPDDR5) booting U-Boot from microSD card.
>>> Build used:
>>>  - TPL rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.19.bin
>>>  - BL31 rk3588_bl31_v1.51.elf
>>>  - GCC 15.1.0 toolchain
>>>
>>> The eMMC controller enumerates even without a soldered module. SPL → U-Boot
>>> boot verified; SD and USB enumeration work as expected.
>>>
>>> Thanks,
>>> Bryan
>>>
>>> ---
>>> Bryan Hinton (2):
>>>  configs: Add rock5b_plus-rk3588_defconfig
>>>  MAINTAINERS: Add entry for Radxa ROCK 5B+
>>>
>>> MAINTAINERS                          |   5 ++
>>> configs/rock5b_plus-rk3588_defconfig | 118 +++++++++++++++++++++++++++
>>> 2 files changed, 123 insertions(+)
>>> create mode 100644 configs/rock5b_plus-rk3588_defconfig
>>>
>>

