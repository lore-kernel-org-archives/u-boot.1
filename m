Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EC3C3600C
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 22:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C5AD82B8E;
	Mon,  7 Apr 2025 00:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="slcuTW7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4157882BE3; Mon,  7 Apr 2025 00:31:57 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C09ED82B45
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 00:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=13a0=WZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743978713;
 bh=HfUU+FWuMXjf0pM6RxkRnF8z/TA9vog3SGYsUQfBoQ8=;
 b=slcuTW7J2yHRfJqWMXV1+mYZAsjvctKyS9kzr1EQZw3qR5kFIGG91ViqszXnQj8ScpkvQxZ1q
 nHeAquLZ7jf59ivjEYd4Dsdz+GKBD4Hs6Hh8SkMGBGAW8wpVGLG0oM5MnC06hzdH/sK8nHTAzm3
 Y93qEpM2ArDVwHctmuxCFMU2MtoZ/Fm7oto+BVatp8CbyRTHIFDDba6FVWXhZr2TRH+esfAoOg7
 oX5k9f/SHm7RP7X4o9lmd1TG8VueRgbD9zzm8iePguREhKWKmAeUndhwRBt6sp1OJyqZ8g/Bc6d
 0fbo4wmLdFA+SBBDhq5/2b0H6RPj2PJRDYjbHTf9MCgw==
X-Forward-Email-ID: 67f300c690f253d89dba217b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <050bd778-3f0c-4f8a-9140-aa73a7943cb0@kwiboo.se>
Date: Mon, 7 Apr 2025 00:31:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] configs: rockchip: Enable ethernet driver on
 RK356x boards
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joseph Chen <chenjh@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Tianling Shen <cnsztl@gmail.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de,
 David Wu <david.wu@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>, Stefan Agner <stefan@agner.ch>
References: <20231001191730.4167035-1-jonas@kwiboo.se>
 <20231001191730.4167035-7-jonas@kwiboo.se> <2086393.9F9pDXStbY@bagend>
 <D8ZTTOA3Q6Q1.39Q6ZX28395IG@cknow.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <D8ZTTOA3Q6Q1.39Q6ZX28395IG@cknow.org>
Content-Type: text/plain; charset=UTF-8
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

Hi Diederik,

On 2025-04-06 22:09, Diederik de Haas wrote:
> Hi,
> 
> On Thu Jul 11, 2024 at 9:38 PM CEST, Diederik de Haas wrote:
>> Some time ago I reported to Jonas privately that I had a problem with
>> my Quartz64 Model A and B and that I bisected it to this commit.
>> I just verified that the problem is still present in 2024.07, so I
>> guess it's time to report it to the (right) Mailing List.
>>
>> The problem: packet loss, varying, but sometimes massive
>> Q64-A: The packet loss was usually between 8% and 30%
>> Q64-B: Packet loss up to 80% sometimes and this also resulted (then) in
>> its inability to receive a DHCP address.
> 
> I just build a ~2025.04-rc5 (i.e. 'master') version and tried it on my
> Q64-B and the problem is still there.
> Furthermore, there have now been several ppl on #quartz64 IRC channel
> (on Pine64 IRC network) who have confirmed both the problem and the
> 'solution'/workaround. Hopefully they'll also report here themselves.

I did a quick test on my Q64-A and can confirm it sometime behaves
strange when Ethernet has been initialized in U-Boot.

At times my iperf3 test report ~0-1 Mbits/sec instead of the more normal
~941 Mbits/sec. After one (or more) "ifconfig eth0 down/up" cycle
everything seemed to work okay again. However after one (or more) eth0
down/up cycle the retries was no longer 0 and speed could instead be
~0-1 Mbits/sec.

I will see if I can replicate this on other rk3566 boards beside Q64.

Can you please try one or more "ifconfig eth0 down/up" cycle and see if
that improves your packet loss issue?

Regards,
Jonas

> 
>> And the fix in my case has always been easy:
>>
>> diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
>> index 1ea8e0f40cc..641452f9162 100644
>> --- a/configs/quartz64-a-rk3566_defconfig
>> +++ b/configs/quartz64-a-rk3566_defconfig
>> @@ -67,9 +67,6 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>>  CONFIG_SPI_FLASH_GIGADEVICE=y
>>  CONFIG_SPI_FLASH_MACRONIX=y
>>  CONFIG_SPI_FLASH_WINBOND=y
>> -CONFIG_PHY_MOTORCOMM=y
>> -CONFIG_DWC_ETH_QOS=y
>> -CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>>  CONFIG_NVME_PCI=y
>>  CONFIG_PCIE_DW_ROCKCHIP=y
>>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>> diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
>> index f61b2c181a1..aae5d66edeb 100644
>> --- a/configs/quartz64-b-rk3566_defconfig
>> +++ b/configs/quartz64-b-rk3566_defconfig
>> @@ -65,9 +65,6 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>>  CONFIG_SPI_FLASH_GIGADEVICE=y
>>  CONFIG_SPI_FLASH_MACRONIX=y
>>  CONFIG_SPI_FLASH_WINBOND=y
>> -CONFIG_PHY_REALTEK=y
>> -CONFIG_DWC_ETH_QOS=y
>> -CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>>  CONFIG_NVME_PCI=y
>>  CONFIG_PCIE_DW_ROCKCHIP=y
>>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>>
>> IOW: a (partial) revert of commit 25f56459aebc
> 
> I didn't try it this time; I just dd-ed my patched 2024.07 version and
> then everything worked again.
> 
> It would be nice to get this fixed. I don't know how to fix it myself,
> but I'm happy to test a potential patch for it.
> 
> Cheers,
>   Diederik

