Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EE9C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 09:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DC9081F32;
	Wed,  7 May 2025 11:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WHy7IhwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA2F1820EB; Wed,  7 May 2025 11:30:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B9028007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 11:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A3F105C4786;
 Wed,  7 May 2025 09:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46929C4CEE7;
 Wed,  7 May 2025 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746610249;
 bh=gFJVv4d6wamhKOXHdvEq/tug0eEg54v8A880hGk9faw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WHy7IhwQ0qOa/WBs+peNGRQ3oiwe/fcEQkc2N9Dy+m6Ylm0J7AU3Yqj9QZ27w6yod
 kegzsTwuOgZ7GGBlgADvU1HxibetYGMSVLV/zheptpYH9mf6DMurgwAJgnv8psyqfB
 f4DNXLMuBT1oJBIlHrzb05rtmOeVXSrteALG74hhkZTZnMbse4HtpYlq3vuWRRsqGc
 p/56qHPItIRDt7pqJJD+FSYwdPhwf9WTu7zNMaZ5E/w1O3LDMRPpycL0vqpNRbI5nv
 O74cSY4rnifMpBYlNs0Xst5Ke8t3ZxKwLzUbyRAufRj4xbVEtEdXTRTopKrsVU9N8i
 tWl1zTDGMS09Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, gchan9527@gmail.com, Tom
 Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Casey Connolly
 <casey.connolly@linaro.org>, Sumit Garg <sumit.garg@kernel.org>, Rayagonda
 Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 1/5] boot/image-android: Workaround kernel/ramdisk
 invalid addr
In-Reply-To: <6ab73e3b-b9e6-464f-b717-1c52248caac0@linaro.org>
References: <20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com>
 <20250505-android-boot-v2-1-92dcb5bf59c8@gmail.com>
 <6ab73e3b-b9e6-464f-b717-1c52248caac0@linaro.org>
Date: Wed, 07 May 2025 11:30:47 +0200
Message-ID: <87selgahtk.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Neil,

On lun., mai 05, 2025 at 14:22, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 05/05/2025 11:17, George Chan via B4 Relay wrote:
>> From: George Chan <gchan9527@gmail.com>
>> 
>> Some androidboot image have invalid kernel/ramdisk load addr,
>> force to ignore those value and use loadaddr instead.
>> 
>> Suggested-by: Casey Connolly <casey.connolly@linaro.org>
>> Signed-off-by: George Chan <gchan9527@gmail.com>
>> ---
>>   boot/Kconfig         | 6 ++++++
>>   boot/image-android.c | 9 ++++++---
>>   2 files changed, 12 insertions(+), 3 deletions(-)
>> 
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index fb37d912bc9..4bdac384181 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -11,6 +11,12 @@ config ANDROID_BOOT_IMAGE
>>   	  This enables support for booting images which use the Android
>>   	  image format header.
>>   
>> +config ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>> +	bool "Android Boot Image ignore addr"
>> +	default n
>> +	help
>> +	  This ignore kernel/ramdisk load addr specified in androidboot header.
>> +
>>   config TIMESTAMP
>>   	bool "Show image date and time when displaying image information"
>>   	default y if CMD_DATE
>> diff --git a/boot/image-android.c b/boot/image-android.c
>> index 1746b018900..7b8eb6a4f64 100644
>> --- a/boot/image-android.c
>> +++ b/boot/image-android.c
>> @@ -268,7 +268,8 @@ static ulong android_image_get_kernel_addr(struct andr_image_data *img_data,
>>   	 *
>>   	 * Otherwise, we will return the actual value set by the user.
>>   	 */
>> -	if (img_data->kernel_addr  == ANDROID_IMAGE_DEFAULT_KERNEL_ADDR) {
>> +	if (img_data->kernel_addr  == ANDROID_IMAGE_DEFAULT_KERNEL_ADDR ||
>> +		IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR)) {
>>   		if (comp == IH_COMP_NONE)
>>   			return img_data->kernel_ptr;
>>   		return env_get_ulong("kernel_addr_r", 16, 0);
>> @@ -464,7 +465,8 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>>   	 */
>>   	if (img_data.header_version > 2) {
>>   		/* Ramdisk can't be used in-place, copy it to ramdisk_addr_r */
>> -		if (img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
>> +		if (img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR ||
>> +			(IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR))) {
>>   			ramdisk_ptr = env_get_ulong("ramdisk_addr_r", 16, 0);
>>   			if (!ramdisk_ptr) {
>>   				printf("Invalid ramdisk_addr_r to copy ramdisk into\n");
>> @@ -488,7 +490,8 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>>   	} else {
>>   		/* Ramdisk can be used in-place, use current ptr */
>>   		if (img_data.ramdisk_addr == 0 ||
>> -		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
>> +		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR ||
>> +			(IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR))) {
>>   			*rd_data = img_data.ramdisk_ptr;
>>   		} else {
>>   			ramdisk_ptr = img_data.ramdisk_addr;
>> 
>
> I like this and should be the default except rare cases, exposing the whole memory
> to image loading sound really dangerous..
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>
> @Mattijs would this still work on Amlogic board if we set loadaddr to the address
> curently used in the boot images ?

TLDR, yes, it would still work on Amlogic if we:
- Set CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR=y
- setenv kernel_addr_r  0x11080000
- setenv ramdisk_addr_r 0x11000000

Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

I've experimented a bit with an old boot.img.
Some details below

NOTE: newer boot.img have different addresses, see:
https://android-review.googlesource.com/c/device/amlogic/yukawa/+/3290364
Before sending a patch for this, make sure to use the latest
ramdisk_addr_r variable

This is the original boot.img I have:

$ unpack_bootimg --format info --boot_img boot.img
boot magic: ANDROID!
kernel_size: 19022293
kernel load address: 0x11080000
ramdisk size: 1751539
ramdisk load address: 0x11000000
second bootloader size: 0
second bootloader load address: 0x00000000
kernel tags load address: 0x10000100
page size: 2048
os version: 13.0.0
os patch level: 2023-05
boot image header version: 2
product name: 
command line args: no_console_suspend console=ttyAML0,115200 earlycon printk.devkmsg=on androidboot.boot_devices=soc/ffe07000.mmc init=/init firmware_class.path=/vendor/firmware androidboot.hardware=yukawa androidboot.selinux=permissive
additional command line args: 
recovery dtbo size: 0
recovery dtbo offset: 0x0000000000000000
boot header size: 1660
dtb size: 295778
dtb address: 0x0000000011f00000

I can unpack/repack it to change "kernel load address" and "ramdisk load
address" with:

$ unpack_bootimg --boot_img boot.img --out out --format=mkbootimg | tee mkbootimg_args
# edit mkbootimg_args to change both --kernel_offset and
--ramdisk_offset to 0x0
$ sh -c "mkbootimg $(cat mkbootimg_args) --output boot_repacked.img"

$ unpack_bootimg --format info --boot_img boot_repacked.img | grep 'load address'
kernel load address: 0x00000000
ramdisk load address: 0x00000000

Reflashing the boot partition with:
$ fastboot flash boot boot_repacked.img

Without modification, this does not boot, as expected:

U-Boot 2025.07-rc1-g8ea79fc630ac (May 07 2025 - 09:30:45 +0200) khadas-vim3

Model: Khadas VIM3
SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
DRAM:  2 GiB (total 3.8 GiB)
Core:  407 devices, 36 uclasses, devicetree: separate
MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
Loading Environment from MMC... MMC Device -1 not found
*** Warning - No MMC card found, using default environment

In:    usbkbd,serial
Out:   vidconsole,serial
Err:   vidconsole,serial
Net:   eth0: ethernet@ff3f0000

Hit any key to stop autoboot:  0
Card did not respond to voltage select! : -110
fs uses incompatible features: 00020000, ignoring
** Booting bootflow 'mmc@ffe07000.bootdev.whole' with android
avb_slot_verify.c:428: ERROR: boot: Hash of data does not match digest in descriptor.
## Booting Android Image at 0x01080000 ...
Kernel load addr 0x01080000 size 18577 KiB
Kernel command line: no_console_suspend console=ttyAML0,115200 earlycon printk.devkmsg=on androidboot.boot_devices=soc/ffe07000.mmc init=/init firmware_class.path=/vendor/firmware androidboot.hardware=yukawa androidboot.selinux=permissive
RAM disk load addr 0x022a5000 size 1711 KiB
Working FDT set to 2486baf
   Uncompressing Kernel Image to 1080000
lz4 compressed: uncompress error -71
Must RESET board to recover
Resetting the board...
bl31 reboot reason: 0xd
bl31 reboot reason: 0x0
system cmd  1.

With the environment variables updated, it boots fine:
U-Boot 2025.07-rc1-g31837b1f1d1d (May 07 2025 - 11:25:40 +0200) khadas-vim3

Model: Khadas VIM3
SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
DRAM:  2 GiB (total 3.8 GiB)
Core:  407 devices, 36 uclasses, devicetree: separate
MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
Loading Environment from MMC... MMC Device -1 not found
*** Warning - No MMC card found, using default environment

In:    usbkbd,serial
Out:   vidconsole,serial
Err:   vidconsole,serial
Net:   eth0: ethernet@ff3f0000

Hit any key to stop autoboot:  0
=> setenv kernel_addr_r  0x11080000
=> setenv ramdisk_addr_r 0x11000000
=> run bootcmd
Card did not respond to voltage select! : -110
fs uses incompatible features: 00020000, ignoring
** Booting bootflow 'mmc@ffe07000.bootdev.whole' with android
avb_slot_verify.c:428: ERROR: boot: Hash of data does not match digest in descriptor.
## Booting Android Image at 0x01080000 ...
Kernel load addr 0x11080000 size 18577 KiB
Kernel command line: no_console_suspend console=ttyAML0,115200 earlycon printk.devkmsg=on androidboot.boot_devices=soc/ffe07000.mmc init=/init firmware_class.path=/vendor/firmware androidboot.hardware=yukawa androidboot.selinux=permissive
RAM disk load addr 0x022a5000 size 1711 KiB
Working FDT set to 2486baf
   Uncompressing Kernel Image to 11080000
   Loading Ramdisk to 7fe54000, end 7ffff9f3 ... OK
   Loading Device Tree to 000000007fe3e000, end 000000007fe537b2 ... OK
Working FDT set to 7fe3e000

Thanks,
Mattijs

>
> Neil
>
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
