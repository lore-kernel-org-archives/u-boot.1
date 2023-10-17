Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D32CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 20:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A6A86F15;
	Tue, 17 Oct 2023 22:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qNcNmImc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29EAC86F2C; Tue, 17 Oct 2023 22:48:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F2A86F06
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 22:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=165c=GA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1697575679;
 bh=BGOFYJrIuYdY4Ln9KKzyuShdy4G2F8hd41ao4bq8D/c=;
 b=qNcNmImcLL4z/g0th/mnzKuOomZ+Fd0LJ36f6GIvmQOZq3jfGybjcNbizYF+9Faa9idHCOHjr
 QaAbQ2ViNvfu477gnKQLiPvSygWPXyD3dlEk+Uta/w2gHCWNVFASbpNo9VPXe9lu/7pYg62hPMd
 aeacxO5Xd70t/NNRxBzed8DrMRkKxON8pkEaEaAnfw6Flvhdj12Dj1MAy+1StwbKAOEY8eGiYqZ
 Ru3I9kH7xkPLwMCqwke53jfd6cX0GKpHkV+2PpnEXyPgQiweFJyGnhdGaIp7zTMd+ti+K8LFQnD
 wQBrCjqOtg7uQVcCGMaxr3AX7RAqnml+V0yCcbJICdeA==
Message-ID: <b82c02c0-0a37-8553-f498-b03f85394d59@kwiboo.se>
Date: Tue, 17 Oct 2023 22:47:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] board: rockchip: add FriendlyElec NanoPC-T6 rk3588 board
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>, John Clark <inindev@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Jagan Teki
 <jagan@edgeble.ai>, Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 chenfen <chenfen@rock-chips.com>, "=?UTF-8?B?6LW15Luq5bOw?="
 <zyf@rock-chips.com>
References: <20231007212552.11109-1-inindev@gmail.com>
 <3145ccc9-d6d6-ee81-4158-9ac576f1a236@rock-chips.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <3145ccc9-d6d6-ee81-4158-9ac576f1a236@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 652ef2ff90b186ea678a965a
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

Hi Kever,

On 2023-10-08 11:09, Kever Yang wrote:
> 
> On 2023/10/8 05:25, John Clark wrote:
>> NanoPC-T6 is a Rockchip RK3588 based SBC by FriendlyElec.
>>
>> There are four variants depending on the DRAM size: 4G/32GB eMMC, 8G/64GB eMMC,
>> 16G/16MB SPI NOR, and 16G/256GB eMMC/16MB SPI NOR
> 
> So the board is using SPI NOR flash.
> 
> 
> [...]
> 
>> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
>> index b1f535fad5..e08ebfa39b 100644
>> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
>> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
>> @@ -40,6 +40,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>   	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe2e0000",
>>   	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
>> +	[BROM_BOOTSOURCE_SPINAND] = "/spi@fe2b0000/flash@0",
> 
> Why need a SPI NAND?
> 
> If this is really needed, will be a separate patch to support a new boot 
> source from bootrom.

I have done spi boot testing on a few rk3588 boards with SPI NOR flash,
and there seem to be a correlation between the bootsource/bootdevice id
written to reg by the bootrom and the fspi iomux used by the board.

Following bootsource/bootdevice value can be read from reg,

- FSPI (M0): 3
- FSPI (M1): 4
- FSPI (M2): 6

based on testing on the following boards:

- Radxa ROCK 5 Model A - fspim0_pins - rk3588s
- Xunlong Orange Pi 5 - fspim0_pins - rk3588s
    brom_bootdevice_id: 3

- FriendlyElec NanoPC-T6 - fspim1_pins - rk3588
- Xunlong Orange Pi 5 Plus - fspim1_pins - rk3588
    brom_bootdevice_id: 4

- Radxa ROCK 5 Model B - fspim2_pins - rk3588
    brom_bootdevice_id: 6

Can these observations be correct? And if so, maybe we should use
following constants for RK3588?

  BROM_BOOTSOURCE_FSPI_M0 = 3
  BROM_BOOTSOURCE_FSPI_M1 = 4
  BROM_BOOTSOURCE_FSPI_M2 = 6

Any insights into what values bootrom will write to reg would be very
helpful.

Regards,
Jonas

> 
> 
> Thanks,
> - Kever
> 

