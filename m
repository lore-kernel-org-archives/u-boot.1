Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2736CC678DC
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 23:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 632E086BED;
	Fri, 18 Aug 2023 01:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="R0mD/Azs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A505886BEE; Fri, 18 Aug 2023 01:56:13 +0200 (CEST)
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net
 (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 683F086BE8
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 01:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=Wykz0hlY2gKdWrVq93wpqbz4gersY5jujhBRoVnFKvE=;
 b=R0mD/AzspYYMDbfBwRCA5juuN8w+dam5RYyzJt75E+aBb4aIgTub6bhavUEH4lNMzT6j
 ej/PPKCB0CBz/K2cCUf4Rfam7hM0/Rvylp4eEtCR+LKvFe8FaZt6MMZsc4isHaLGlYi2qh
 aos8LYxF++qIYdZMojISEwCM5yn0xiaMEwZaq1nXeiBqPSPLto/f16NFVna5SJG3msNV4e
 q5UjyxqFHAFTi9mRlXkVD9Zqy3dOM5edqdRlbOdED+ikvA+XT4TJ5E+ahiIb1SPSXDh3UR
 6+qB2M5qqI42RgB+nh5e9cYcI/nTKGshnHv+uj04lZGqY8S6XBOR4XQCvRdHI/zw==
Received: by filterdrecv-66949dbc98-2h875 with SMTP id
 filterdrecv-66949dbc98-2h875-1-64DEB398-1B
 2023-08-17 23:56:08.772307403 +0000 UTC m=+8554589.695746432
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-9 (SG) with ESMTP
 id G7ySXaDHR_Ky46N0L-q-tA Thu, 17 Aug 2023 23:56:08.488 +0000 (UTC)
Message-ID: <c6acb79a-aa4c-f6e0-648e-7890e75ff714@kwiboo.se>
Date: Thu, 17 Aug 2023 23:56:08 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/5] board: rockchip: Add Pine64 Quartz64-A Board
Content-Language: en-US
References: <20230723145504.2967971-1-jonas@kwiboo.se>
 <20230723145504.2967971-2-jonas@kwiboo.se>
 <1e3634df-593c-506d-5254-332c44ca7c4d@kwiboo.se>
 <9ba7a208113eed26c61d3373f1659b866c1f8c85.camel@collabora.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <9ba7a208113eed26c61d3373f1659b866c1f8c85.camel@collabora.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hzYTj7VSzctHWJY=2Fr?=
 =?us-ascii?Q?6hNz7qxo+IMfZfDCQKqiXSHg2M9N=2Fn5C7RkFi1x?=
 =?us-ascii?Q?o5E1rl8Xl9gA0++s7es5ITCHen6=2FNtdZdd1sQaJ?=
 =?us-ascii?Q?kf2n=2FRH719meF4NjIE8q9hrcxYDFYfcV45Gy6Vq?=
 =?us-ascii?Q?8yRZbbfIg1u+Z=2FZSfHVvThLclWAcchyzyG+Kmj?=
To: Christopher Obbard <chris.obbard@collabora.com>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=iso-8859-1
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

Hi Christopher,

On 2023-08-08 16:25, Christopher Obbard wrote:
> Hi Jonas,
> 
> On Sun, 2023-07-23 at 15:04 +0000, Jonas Karlman wrote:
>> On 2023-07-23 16:55, Jonas Karlman wrote:
>>> The Pine64 Quartz64 Model A is a single-board computer based on the
>>> Rockchip RK3566 SoC. The board features USB3, SATA, PCIe, HDMI, USB2.0,
>>> CSI, DSI, eDP, eMMC, SD, and an e-paper parallel port, as well as a
>>> 20 pin GPIO header.
>>>
>>> Features tested on a Quartz64-A 8GB v2.0 2021-04-27:
>>> - SD-card boot
>>> - eMMC boot
>>> - PCIe/NVMe/AHCI
>>> - USB host
>>>
>>> Device tree is imported from linux v6.4.
>>>
>>> Co-developed-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
>>> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>
>> [...]
>>
>> Boot log with ROCKCHIP_TPL=rk3566_ddr_1056MHz_v1.17.bin and
>> BL31=rk3568_bl31_v1.43.elf:
>>
>> [...]
>>
>> U-Boot 2023.07 (Jul 23 2023 - 12:42:18 +0000)
>>
>> Model: Pine64 RK3566 Quartz64-A Board
>> DRAM:  8 GiB (effective 7.7 GiB)
>> PMIC:  RK8170 (on=0x10, off=0x00)
>> Core:  321 devices, 27 uclasses, devicetree: separate
>> MMC:   rockchip_sdhci_probe clk set rate fail!
>> mmc@fe2b0000: 1, mmc@fe2c0000: 2, mmc@fe310000: 0
>> Loading Environment from nowhere... OK
>> In:    serial@fe660000
>> Out:   serial@fe660000
>> Err:   serial@fe660000
>> Model: Pine64 RK3566 Quartz64-A Board
>> Net:   No ethernet found.
>>
>> Hit any key to stop autoboot:  0
>> =>
> 
> 
> I just tried booting U-Boot v2023.10-rc2 with ROCKCHIP_TPL=rk3566_ddr_1056MHz_v1.17.bin and BL31=rk3568_bl31_v1.43.elf, on my Quartz64-A but it fails during
> loading of some parts. I removed the output of the RK TPL from my logs as there were no errors.

Try with latest rk3566_ddr_1056MHz_v1.18.bin and see if that makes any
difference.

> 
> This is when booting from eMMC.

Does it boot with SD-card or other eMMC modules?

> 
> I also tried building your branch from https://github.com/Kwiboo/u-boot-rockchip/tree/rk3568-2023.10 and 

Please try with a GitHub actions built u-boot-rockchip.bin based on my
rk3568-2023.07.02 branch at
https://github.com/Kwiboo/u-boot-build/actions/runs/5777761235

> 
> 
> The full build commands:
> 
> export ROCKCHIP_TPL=rkbin/bin/rk35/rk3566_ddr_1056MHz_v1.17.bin
> export BL31=rkbin/bin/rk35/rk3568_bl31_v1.43.elf
> make quartz64-a-rk3566_defconfig
> make -j16
> 
> rkdeveloptool db rk356x_spl_loader_v1.13.112.bin
> rkdeveloptool wl 64 u-boot-rockchip.bin

What happens if you write u-boot-rockchip.bin to eMMC module usinga USB adapter:

  dd if=u-boot-rockchip.bin of=/dev/<device> bs=32k seek=1 conv=fsync

or using U-Boot cmd when booted from a SD-card?

  # Read u-boot-rockchip.bin from first partition of a SD card
  load mmc 1:1 10000000 u-boot-rockchip.bin

  # Change to eMMC
  mmc dev 0

  # Write 10 MiB (0x5000 blocks) at sector 64 (0x40)
  mmc write $fileaddr 40 5000

Does that make any difference?

> 
> Boot log (v2023.10-rc2):
> 
> U-Boot SPL 2023.10-rc2 (Aug 08 2023 - 14:02:34 +0100)
> rockchip_sdhci_probe clk set rate fail!
> Trying to boot from MMC1
> spl: mmc init failed with error: -110
> Trying to boot from MMC2
> Card did not respond to voltage select! : -110
> spl: mmc init failed with error: -95
> Trying to boot from MMC1

Strange that second try of eMMC (MMC1) gets little bit longer.

> ## Checking hash(es) for config config-1 ... OK
> ## Checking hash(es) for Image atf-1 ... sha256+ OK
> spl_load_simple_fit: can't load image loadables index 0 (ret = -5)
> mmc_load_image_raw_sector: mmc block read error
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###
> 
> 
> Boot log (your branch):
> 
> U-Boot SPL 2023.10-rc1-00368-g16cb31d427 (Aug 08 2023 - 15:17:35 +0100)
> Trying to boot from MMC1
> spl: mmc init failed with error: -70
> Trying to boot from MMC2
> Card did not respond to voltage select! : -110
> spl: mmc init failed with error: -95
> Trying to boot from MMC1
> ## Checking hash(es) for config config-1 ... OK
> mmc_load_image_raw_sector: mmc block read error
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###

I have not been able to reproduce this kind of issue on any of my two
Quartz64-A boards, tested with different eMMC modules.

Does your eMMC module have some compatibility issue?
Do you have any more details on the eMMC module you have tested with?

There was also some clk and pinctrl changes recently merged into master
branch, but they was probably included in the build from my branch based
on the lack of "rockchip_sdhci_probe clk set rate fail!" message.

Regards,
Jonas

> 
> 
> Thanks!
> 
> Chris
> 

