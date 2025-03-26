Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55201C28B30
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 05:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C10F808B6;
	Wed, 26 Mar 2025 06:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742966462;
	bh=uGs4RLYs2YKo1NTTe3y4Pao/0i60qrC1dEYNdyUPxOk=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=XvLMH0ICHTqoUjDbKaAyHTzqh9b1Ucsasz26qZK/FrTWv+j+5YqsPswDf1dF7KU9I
	 4OtiSrYdf9MoTCr9BxDsQmkhTLzDrHHlVmD4+FJ5sWpTEMgPZ1LX4T4z+SDrUh1zsH
	 rDW0savOYLNxNBTQSVtq4dhrH3cz4Owf0d5jdrqqd6kjEL5jPSRhol72PR+vr/pj2N
	 RoZI4ReVzJFzOqfIhC2caiE1jvpfEyV+XM0GTQHroDJ2ckMmL+9m2cErc60jAY23F3
	 kA5XpqGj8/xuzKxPgFsYJeOeGDsSPLew7JpNwoSg/eVb72CoRnhd0FkuCexYXUcviM
	 rz0oI85qrhEsw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ABC0809D0; Wed, 26 Mar 2025 06:21:01 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E197D800C1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 06:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="XCis27M5"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3E99E10382D3C; Wed, 26 Mar 2025 06:20:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742966458;
 h=from:reply-to:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=uGs4RLYs2YKo1NTTe3y4Pao/0i60qrC1dEYNdyUPxOk=;
 b=XCis27M5iKHwMBIGrcsc61mydYst0GaTf9ZNz7CxIse5bCVZOsjAsNki0D/Vpknm55+hM/
 dFYBoY6OOt6ekNp0HDkjoBrkBp1GGFt7w0Jr03CryM/K+E8PPcCCF0elrCDJEsw6UvayGe
 EQpBShx/bzK09b7JoEVoGdMEPcdS9M0NdEors/zZTE9z0HTavzmBbXiTWHHSwGp+r0vyby
 nurcjrPt+1+Qvsbp7SaurR3vw8fh0KYf4kJ7akSR+lHiRkF/DYxo4eI8VfHnvEoMURsvYL
 BMOSJWfVNcCX0LKVdA/HZzsdR86UCTc0g65EvgXz95uX6d1FsgICttyr2SySkA==
Message-ID: <a1fedb6c-afc3-aabb-ed47-ef581e4a9432@denx.de>
Date: Wed, 26 Mar 2025 06:21:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: block devices on MTD and UBI
Content-Language: en-US
To: onilsson@rums.se, u-boot@lists.denx.de
References: <1742889603533.7.1744@webmail-backend-production-5f8dbfcff-mztks>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <1742889603533.7.1744@webmail-backend-production-5f8dbfcff-mztks>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Oskar,

On 25.03.25 09:00, Oskar Nilsson wrote:
>> On 20-03-2025 17:03, Mike Looijmans wrote:
>>> On 19-03-2025 15:06, Heiko Schocher wrote:
>>>> Hello Mike,
>>>>
>>>> On 18.03.25 10:04, Mike Looijmans wrote:
>>>>> I think I have everything set up to access MTD (and UBI) devices as
>>>>> "block", however, lsblk always ignores them, and refuses to list
>>>>> anything but the mmc. I can read ubifs and boot from it though, and
>>>>> since UBI runs on top of MTD block devices, MTD block device should
>>>>> be working, right?
>>>>
>>>> Yes. I must admit, I have no device on which I have such a setup...
>>>>
>>>> added Alexey (who introduced ubi block support), may he can give some
>>>> hints.
>>>>
>>>>> I also have UBI_BLOCK enabled, so I would expect UBI volumes to
>>>>> appear in the "lsblk" as well.
>>>>
>>>> good, that would have been my first question, if you have enabled
>>>> "UBI_BLOCK"
>>>>
>>>>> Example U-boot session:
>>>>>
>>>>> Zynq> mtd list
>>>>> SF: Detected n25q256ax1 with page size 256 Bytes, erase size 64 KiB,
>>>>> total 32 MiB
>>>>> List of MTD devices:
>>>>> * nor0
>>>>> - device: flash at 0
>>>>> - parent: spi at e000d000
>>>>> - driver: jedec_spi_nor
>>>>> - path: /axi/spi at e000d000/flash at 0
>>>>> - type: NOR flash
>>>>> - block size: 0x10000 bytes
>>>>> - min I/O: 0x1 bytes
>>>>> - 0x000000000000-0x000002000000 : "nor0"
>>>>> - 0x000000000000-0x000000100000 : "qspi-boot-bin"
>>>>> - 0x000000100000-0x000002000000 : "qspi-rootfs"
>>>>
>>>> Aha, SPI NOR. I fear this is not supported yet.
>>>>
>>>> Do you have somehow called ubi_part() ?
>>>>
>>>> Can you try "ubi part...." and look if this helps?
>>>
>>> See below I guess...
>>>
>>>> It seems to me, that you have to implement this like it is done for
>>>> spi nand:
>>>>
>>>> drivers/mtd/nand/spi/core.c
>>>> 1180 static int spinand_bind(struct udevice *dev)
>>>> 1181 {
>>>> 1182 if (blk_enabled()) {
>>>> 1183 struct spinand_plat *plat = dev_get_plat(dev);
>>>> 1184 int ret;
>>>> 1185
>>>> 1186 if (CONFIG_IS_ENABLED(MTD_BLOCK)) {
>>>> 1187 ret = mtd_bind(dev, &plat->mtd);
>>>> 1188 if (ret)
>>>> 1189 return ret;
>>>> 1190 }
>>>> 1191
>>>> 1192 if (CONFIG_IS_ENABLED(UBI_BLOCK))
>>>> 1193 return ubi_bind(dev);
>>>> 1194 }
>>>> 1195
>>>> 1196 return 0;
>>>> 1197 }
>>>>
>>> I guess that shouldn't be to hard to implement... I'll send a patch if
>>> that fixes the MTD missing...
>>
>> Not as simple as one would think. The spi flash struct has its own "mtd"
>> member which isn't a pointer but was already filled in. So I cannot
>> simply call mtd_bind().
>>
>> I tried calling ubi_bind anyway, which had some effect:
>>
>> Zynq> lsblk
>> Block Driver Devices
>> -----------------------------
>> efi_blk : <none>
>> mmc_blk : mmc 0
>> mtd_blk : <none>
>> ubi_blk : mtd 0
>> usb_storage_blk : <none>
>>
>> But that didn't get me any further. I'm quite puzzled by UBI block
>> support...
>>
> 
> I have been looking at the same issue, but haven't made much progress either.
> 
>>From my understanding, when enabling UBI_BLOCK the .bind function will add a
> block device on top of the UBI device. It should then be usable by commands
> that expect a blk device like sqfsls.

Hmm... yep, so the theory ... but let me first look if this is used in mainline:

hs@threadripper:u-boot  [master] $ grep -lr UBI_BLOCK configs/
hs@threadripper:u-boot  [master] $

So no users at all currently? That explains, why it is may buggy.

hs@threadripper:u-boot  [master] $ grep -lr UBI_BLOCK .
./drivers/mtd/nand/spi/core.c
./drivers/mtd/ubi/ubi.h
./drivers/mtd/ubi/Makefile
./drivers/mtd/ubi/Kconfig
./include/ubi_uboot.h

And option is not selected through any Kconfig ... so yes, expect bugs
here... and I have no hardware for that to dig into ... I am sorry.

> 
> Note that I'm on u-boot-imx 2024.04 and have back ported the ubi and mtd block
> patches, so there may be differences to latest.
> 
> Looking at the driver model, a .blk has been added:
> => dm tree
> Class Index Probed Driver Name
> -----------------------------------------------------------
> root 0 [ + ] root_driver root_driver
> thermal 0 [ ] imx_thermal |-- imx_thermal
> simple_bus 0 [ + ] simple_bus |-- soc
> mtd 0 [ + ] mxs-nand-dt | |-- nand-controller@1806000
> blk 0 [ ] ubi_blk | | `-- <nand-controller@1806000.blk>
> ...
> 
> Calling sqfsls, seems to find the right volume (rootfs0):
> => sqfsls mtd 0 /
> FS: Setting up block device: ifname='mtd', dev_part_str='0', fstype=6
> Read 512 bytes from volume rootfs0 to 9ef2cb80
> Disk <nand-controller@1806000.blk> not ready
> ** Bad device specification mtd 0 **
> Couldn't find partition mtd 0
> FS: Failed to get partition info (err=-19)
> 
> Interestingly after each command that uses a blk device, I get 128 blk_partitions

Do I see it correct that your patch:

https://patchwork.ozlabs.org/project/uboot/patch/20250325174708.426459-1-onilsson@rums.se/

fixes this problem?

> => dm tree
> Class Index Probed Driver Name
> -----------------------------------------------------------
> root 0 [ + ] root_driver root_driver
> thermal 0 [ ] imx_thermal |-- imx_thermal
> simple_bus 0 [ + ] simple_bus |-- soc
> mtd 0 [ + ] mxs-nand-dt | |-- nand-controller@1806000
> blk 0 [ ] ubi_blk | | `-- <nand-controller@1806000.blk>
> partition 0 [ ] blk_partition | | |-- <nand-controller@1806000.blk>:1
> partition 1 [ ] blk_partition | | |-- <nand-controller@1806000.blk>:2
> partition 2 [ ] blk_partition | | |-- <nand-controller@1806000.blk>:3
> partition 3 [ ] blk_partition | | |-- <nand-controller@1806000.blk>:4
> partition 4 [ ] blk_partition | | |-- <nand-controller@1806000.blk>:5
> ...
> 
> At first I also got the error "UBIFS not mounted, use ubifsmount to mount volume first!"
> To fix that I added this small patch:
> 
> diff --git a/disk/part.c b/disk/part.c
> index 8982ef3bae..f168311e9a 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -524,7 +524,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
> }
> #endif
> 
> -#if IS_ENABLED(CONFIG_CMD_UBIFS) && !IS_ENABLED(CONFIG_SPL_BUILD)
> +#if IS_ENABLED(CONFIG_CMD_UBIFS) && !IS_ENABLED(CONFIG_SPL_BUILD) && !IS_ENABLED(CONFIG_UBI_BLOCK)
> /*
> * Special-case ubi, ubi goes through a mtd, rather than through
> * a regular block device.

Please send a formal patch for this, so I can pick it up, thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
