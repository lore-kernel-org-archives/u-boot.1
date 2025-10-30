Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9AACCF9E3
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 19:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B797C83642;
	Thu, 30 Oct 2025 20:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Gcal9+1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A3783677; Thu, 30 Oct 2025 20:41:18 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A3F800B6
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 20:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=758b=5I=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1761853274;
 bh=pm3nBN8Mfxi5Hkx7s2T6YRjKboSjhzmCXWp444HGoTM=;
 b=Gcal9+1aSqZvmrNwQCPoBo3cM2GVcNZLEXKamLHctI1QrkVCoseKOnjVRyTvXz1e0+ppr6C9g
 EIUx20CTgjWR2TjwTrU4wp0T8iS3+3ljmxDlINKFFr7Carr4iEeC89J3aI2QWjl6LYkvnUzXWUQ
 NBsZxoBT4LA1CEMEpJa+Oq4+4sU2zT4tzA9rgoC1JpcCUt5ivn0hi7cV916zA+hz102MAPtMX7I
 AOetpLZRm1CS7pxJrAtYaSsn4q24rgW50uHWaFkkWsrlsGkO4/yu7ek9s0xlg/7LaExMxm1LH7Q
 9Mv87VQYK4TIi70AnK1blLJypsC3m7hALuJfEGe1J+lg==
X-Forward-Email-ID: 6903bf548f8871ca830cb969
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.4.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <dcbc1f40-f418-459f-9696-b39d22d63180@kwiboo.se>
Date: Thu, 30 Oct 2025 20:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: Fix eMMC write on RK3528
To: Tianling Shen <cnsztl@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250613224343.3521820-1-jonas@kwiboo.se>
 <6ae3eab1-3208-4317-8ae2-5f5cac1e2dfe@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <6ae3eab1-3208-4317-8ae2-5f5cac1e2dfe@gmail.com>
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

Hi Tianling,

On 10/30/2025 7:12 PM, Tianling Shen wrote:
> Hi Jonas,
> 
> On 2025/6/14 6:43, Jonas Karlman wrote:
>> Writing to eMMC on RK3528 is affected with the same or a similar issue
>> as on RK3588, where eMMC must init to HS200 at least once to fully work.
>>
>> Trying to write u-boot-rockchip.bin to eMMC fails with:
>>
>>    => mmc write $fileaddr 40 5000
>>    MMC write: dev # 0, block # 64, count 20480 ... mmc write failed
>>    0 blocks written: ERROR
>>
>> For U-Boot to enable HS200 mode the mmc-hs200-1_8v prop must be defined
>> in the device tree. Linux does not seem to be affected and is able to
>> detect and use HS200 without this prop.
>>
>> Enable use of HS200 and fix eMMC write on RK3528 by adding the missing
>> mmc-hs200-1_8v prop for affected boards:
>>
>>    => mmc write $fileaddr 40 5000
>>    MMC write: dev # 0, block # 64, count 20480 ... 20480 blocks written: OK
>>
> 
> Sorry for the noise.
> 
> I recently got an E20C board, and I ran into a very stange issue, the 
> U-Boot throw errors with any mmc r/w operation, like `boot` or `mmc erase`:
> 
> ```
> => boot
> Scanning for bootflows in all bootdevs
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------ 
> ----------------
> Scanning global bootmeth 'efi_mgr':
>   ** fs_devread read error - block
>   ** fs_devread read error - block
> Card did not respond to voltage select! : -110
> Cannot persist EFI variables without system partition
>    0  efi_mgr      ready   (none)       0  <NULL>
> ** Booting bootflow '<NULL>' with efi_mgr
> Loading Boot0000 'mmc 0' failed
> EFI boot manager: Cannot load any image
> Boot failed (err=-14)
> Scanning bootdev 'mmc@ffc30000.bootdev':
> Card did not respond to voltage select! : -110
> Card did not respond to voltage select! : -110
> Card did not respond to voltage select! : -110
> Card did not respond to voltage select! : -110
> Scanning bootdev 'mmc@ffbf0000.bootdev':
>   ** fs_devread read error - block
>   ** fs_devread read error - block
>   ** fs_devread read error - block
> Unknown uclass 'nvme' in label
> Unknown uclass 'scsi' in label
> No USB controllers found
> Scanning bootdev 'ethernet@ffbe0000.bootdev':
> ethernet@ffbe0000 Waiting for PHY auto negotiation to complete..user 
> interrupt!
> phy_startup() failed: -4
> FAILED: -4
> BOOTP broadcast 1
> 
> => mmc read $loadaddr 0x40 0x4000
> MMC read: dev # 0, block # 64, count 16384 ... 0 blocks read: ERROR
> 
> => mmc erase 0x40 0x4000
> MMC erase: dev # 0, block # 64, count 16384 ... mmc erase failed
> 0 blocks erased: ERROR
> 
> => mmc part
> 
> Partition Map for mmc device 0  --   Partition Type: DOS
> 
> Part	Start Sector	Num Sectors	UUID		Type
> ** Can't read partition table on 0:0 **
> ```
> 
> By checking the mmc information:
> ```
> => mmc info
> Device: mmc@ffbf0000
> Manufacturer ID: ef
> OEM: 0
> Name: TLi16G
> Bus Speed: 200000000
> Mode: HS200 (200MHz)
> Rd Block Len: 512
> MMC version 5.1
> High Capacity: Yes
> Capacity: 14.7 GiB
> Bus Width: 4-bit
> Erase Group Size: 512 KiB
> HC WP Group Size: 128 MiB
> User Capacity: 14.7 GiB WRREL
> Boot Capacity: 4 MiB ENH
> RPMB Capacity: 4 MiB ENH
> ```
> 
> I found the bus width is not corrent, and no "Boot area X is not write 
> protected" tip.
> 
> This is the working `mmc info` output:
> ```
> Device: mmc@ffbf0000
> Manufacturer ID: ef
> OEM: 0
> Name: TLi16G
> Bus Speed: 200000000
> Mode: HS200 (200MHz)
> Rd Block Len: 512
> MMC version 5.1
> High Capacity: Yes
> Capacity: 14.7 GiB
> Bus Width: 8-bit
> Erase Group Size: 512 KiB
> HC WP Group Size: 128 MiB
> User Capacity: 14.7 GiB WRREL
> Boot Capacity: 4 MiB ENH
> RPMB Capacity: 4 MiB ENH
> Boot area 0 is not write protected
> Boot area 1 is not write protected
> ```
> 
> I tried to use the generic-rk3528 configuration, and it seems to work.
> After making some tests (about 50 times reboot/reset), I found the eMMC 
> works fine if `CONFIG_REGULATOR_PWM=y` is disabled.
> This is a bit weird. Maybe disabling this option just hides the real issue?

Interesting information and thanks for testing!

Without REGULATOR_PWM=y the cpu and logic regulators will keep their reset
init values instead of U-Boot trying to configure these pwm regulators.

The generic-rk3528 target does not include information about any of these
regulators so they would keep using the reset init values.

There could be two issues related to this, first both the pwm regulator
and rk pwm driver are not fully aligned with Linux and round values a
little bit different. I have some local work-in-progress patches that I
should complete and send out to fix this discrepancy.

The second issue could be that the logic regulator should be configured
with a higher regulator-init-microvolt value so that U-Boot do not
re-configure the regulator with a lower voltage than it has after reset.

Did your testing also include the "mmc: rockchip_sdhci: Set xx_TAP_VALUE
for RK3528" [1] patch?

> 
> Here's the build information:
> U-Boot commit: 4cad9faf8d28 ("MAINTAINERS: update my email address")
> rkbin commit: 74213af1e952 ("rv1126b: bl31: update version to v1.07")
> Build command:
> make CROSS_COMPILE=aarch64-linux-musl- 
> BL31=../rkbin/bin/rk35/rk3528_bl31_v1.20.elf 
> ROCKCHIP_TPL=../rkbin/bin/rk35/rk3528_ddr_1056MHz_v1.11.bin

I will make some runtime test on my E20C using these as a base and see
if I can replicate a similar issue.

I have also pushed my local pwm-regulator/rk-pwm relates patches to [2],
they need some re-work before being ready to be sent out.

[1] https://lore.kernel.org/u-boot/20250714203410.1782783-1-jonas@kwiboo.se/
[2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528

Regards,
Jonas

> 
> Any help will be greatly appreciated!
> 
> Thanks,
> Tianling.
> 
>> Fixes: b112a44531cb ("board: rockchip: Add minimal generic RK3528 board")
>> Fixes: ccbddf645310 ("board: rockchip: Add Radxa E20C")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Kever, Tom: Please consider this for the v2025.07 release as support for
>> RK3528 was added in v2025.07-rc1.
>> ---
>>   arch/arm/dts/rk3528-generic.dts            | 1 +
>>   arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi | 4 ++++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/dts/rk3528-generic.dts b/arch/arm/dts/rk3528-generic.dts
>> index 792d3e04a4cb..3f6f0bed108d 100644
>> --- a/arch/arm/dts/rk3528-generic.dts
>> +++ b/arch/arm/dts/rk3528-generic.dts
>> @@ -18,6 +18,7 @@
>>   &sdhci {
>>   	bus-width = <8>;
>>   	cap-mmc-highspeed;
>> +	mmc-hs200-1_8v;
>>   	no-sd;
>>   	no-sdio;
>>   	non-removable;
>> diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
>> index 9c2f03a786cf..1372d8f1e38a 100644
>> --- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
>> @@ -2,6 +2,10 @@
>>   
>>   #include "rk3528-u-boot.dtsi"
>>   
>> +&sdhci {
>> +	mmc-hs200-1_8v;
>> +};
>> +
>>   &sdmmc {
>>   	bus-width = <4>;
>>   	cap-mmc-highspeed;
> 

