Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E2FC4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 08:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08FB7880F4;
	Sat, 20 Apr 2024 10:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="smHO+MYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDEA88131; Sat, 20 Apr 2024 10:11:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB5E4880F1
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 10:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1919=LZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1713600674;
 bh=bsCYIjArG2PRhLoTtwjfObm/Ob6hYvxGTxPmysC97Os=;
 b=smHO+MYXaFbtbGpwTKon+GJs9HzT0K4cj0K79+4ur3MNM+c1H64v+j0CTZCjCtpsKTWNyDB8c
 3aif4yf67IZSEoTIiUYsbfvxd9kbzjpmE1Fz//07AdpdvEQJxNopd23FSVwMKB9Jc6cSBXXVydv
 WGzuhPTZS/hgP8rSnyC5xIbU43vRgE3/7ThD9je/DiPENJ7VXuh9LAdcC7HlcMpRfuFN3oRmSCv
 5S2roujyVkTd+0mTZlMFGMeryVzuXpsV/7F/MlIpKCJv3S14jKTj2zGZ5m13Iw50hwVcP5G4L15
 383RDZQoPgD324tOtGilVqqW79ciu6gncwkTb6kEB/rA==
Message-ID: <3cdcb7a7-ef7c-4fdd-9cb7-91590ea575a8@kwiboo.se>
Date: Sat, 20 Apr 2024 10:11:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] pxe: Allow extlinux booting without CMDLINE
 enabled
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>
References: <20231215041919.2197788-1-sjg@chromium.org>
 <171279991820.196936.155872099351797064.b4-ty@konsulko.com>
 <50dfa3d6-a1ca-4492-a3fc-8d8c56b40b43@kwiboo.se>
 <20240418181305.GI1054907@bill-the-cat>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240418181305.GI1054907@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 662378a078a87b61d1c8f8b4
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

Hi Tom and Simon,

On 2024-04-18 20:13, Tom Rini wrote:
> On Sun, Apr 14, 2024 at 06:58:03PM +0200, Jonas Karlman wrote:
>> Hi Tom and Simon,
>>
>> On 2024-04-11 03:45, Tom Rini wrote:
>>> On Thu, 14 Dec 2023 21:18:58 -0700, Simon Glass wrote:
>>>
>>>> This series is the culmanation of the current line of refactoring
>>>> series. It adjusts pxe to call the booting functionality directly
>>>> rather than going through the command-line interface.
>>>>
>>>> With this is is possible to boot using the extlinux bootmeth without
>>>> the command line enabled.
>>>>
>>>> [...]
>>>
>>> Applied to u-boot/master, thanks!
>>>
>>
>> This series is causing boot issues using extlinux in bootm_run_states():
>>
>>   ERROR: booting os 'Invalid OS' (0) is not supported
>>
>> Following extlinux.conf was used:
>>
>>   label linux
>>   	kernel /Image.gz
>>   	initrd /initramfs.cpio.gz
>>
>> Before this series booting works, bootm_run_states() is first called
>> with states=0x1 (BOOTM_STATE_START):
>>
>>   Scanning bootdev 'mmc@fe2b0000.bootdev':
>>     1  extlinux     ready   mmc          1  mmc@fe2b0000.bootdev.part /extlinux/extlinux.conf
>>   ** Booting bootflow 'mmc@fe2b0000.bootdev.part_1' with extlinux
>>   1:      linux
>>   Retrieving file: /Image.gz
>>   Retrieving file: /initramfs.cpio.gz
>>   bootm_run_states(): images->state: 0, states: 1
>>   bootm_run_states(): images->os.os: 0
>>   bootm_run_states(): images->os.arch: 0
>>   bootm_run_states(): boot_fn: 0000000000000000, need_boot_fn: 0
>>      Uncompressing Kernel Image to 0
>>   ## Flattened Device Tree blob at edef8410
>>      Booting using the fdt blob at 0xedef8410
>>   Working FDT set to edef8410
>>   bootm_run_states(): images->state: 1, states: 1710
>>      Loading Ramdisk to ecdfd000, end eceb274d ... OK
>>   bootm_run_states(): images->os.os: 5
>>   bootm_run_states(): images->os.arch: 16
>>   boot_fn: 00000000eff2b83c, need_boot_fn: 0
>>      Loading Device Tree to 00000000ecde8000, end 00000000ecdfc97f ... OK
>>   Working FDT set to ecde8000
>>
>> After this series booting fails, bootm_run_states() is first called
>> with states=0x1710.
>>
>>   Scanning bootdev 'mmc@fe2b0000.bootdev':
>>     1  extlinux     ready   mmc          1  mmc@fe2b0000.bootdev.part /extlinux/extlinux.conf
>>   ** Booting bootflow 'mmc@fe2b0000.bootdev.part_1' with extlinux
>>   1:      linux
>>   Retrieving file: /Image.gz
>>   Retrieving file: /initramfs.cpio.gz
>>   bootm_run_states(): images->state: 0, states: 1710
>>   bootm_run_states(): images->os.os: 0
>>   bootm_run_states(): images->os.arch: 0
>>   bootm_run_states(): boot_fn: 0000000000000000, need_boot_fn: 0
>>   ERROR: booting os 'Invalid OS' (0) is not supported
>>   Boot failed (err=-14)
>>
>> Looks like booti_start() -> bootm_run_states(bmi, BOOTM_STATE_START) is
>> no longer called due to changes in this series.
> 
> I think the problem is with:
> commit 6d803ec9cc757bda0c48f2fd419cb6878eab92c4
> Author: Simon Glass <sjg@chromium.org>
> Date:   Thu Dec 14 21:19:12 2023 -0700
> 
>     pxe: Allow booting without CMDLINE for bootm methods
>     
>     Use bootm_run() and booti_run() to boot rather than the command line.
>     This allows extlinux to be used without CMDLINE being enabled.
>     
>     Collect any error but do not return it, to match the existing code.
>     
>     Signed-off-by: Simon Glass <sjg@chromium.org>
> 
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> [snip]
> @@ -641,23 +644,18 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
>  	if (!fdt_addr && genimg_get_format(buf) != IMAGE_FORMAT_FIT)
>  		fdt_addr = env_get("fdtcontroladdr");
>  
> -	if (fdt_addr) {
> -		if (!bootm_argv[2])
> -			bootm_argv[2] = "-";
> -		bootm_argc = 4;
> -	}
> -	bootm_argv[3] = (char *)fdt_addr;
> +	bmi.conf_fdt = fdt_addr;
>  
>  	/* Try bootm for legacy and FIT format image */
>  	if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
> -            IS_ENABLED(CONFIG_CMD_BOOTM))
> -		do_bootm(ctx->cmdtp, 0, bootm_argc, bootm_argv);
> +	    IS_ENABLED(CONFIG_BOOTM))
> +		ret = bootm_run(&bmi);
>  	/* Try booting an AArch64 Linux kernel image */
> -	else if (IS_ENABLED(CONFIG_CMD_BOOTI))
> -		do_booti(ctx->cmdtp, 0, bootm_argc, bootm_argv);
> +	else if (IS_ENABLED(CONFIG_BOOTM))
> +		ret = booti_run(&bmi);
>  	/* Try booting a Image */
> -	else if (IS_ENABLED(CONFIG_CMD_BOOTZ))
> -		do_bootz(ctx->cmdtp, 0, bootm_argc, bootm_argv);
> +	else if (IS_ENABLED(CONFIG_BOOTM))
> +		ret = bootz_run(&bmi);
>  	/* Try booting an x86_64 Linux kernel image */
>  	else if (IS_ENABLED(CONFIG_CMD_ZBOOT))
>  		do_zboot_parent(ctx->cmdtp, 0, zboot_argc, zboot_argv, NULL);
> 
> And this doesn't seem equivalent really. The logic used to be checking
> if we had bootm/booti/bootz and now it's always checking for
> CONFIG_BOOTM. Jonas, can you please share the defconfig you used here as
> well? But I think for now reverting the series is the best path forward,
> unfortunately.
> 

I have re-tested following on rockpro64-rk3399_defconfig using:

- Image.gz: plain Linux kernel v6.9-rc4, ARCH=arm64 defconfig
            (without module support)
- initramfs.cpio.gz: minimal busybox system
- extlinux/extlinux.conf: minimal extlinux file

"""
label linux
	kernel /Image.gz
	initrd /initramfs.cpio.gz
"""

And following diff to add debug prints:

"""
diff --git a/boot/bootm.c b/boot/bootm.c
index 032f5a4a1605..e106cde7076b 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -998,6 +998,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	ulong iflag = 0;
 	int ret = 0, need_boot_fn;
 
+	printf("%s(): images->state: %x, states: %x\n", __func__, images->state, states);
 	images->state |= states;
 
 	/*
@@ -1060,10 +1061,13 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	/* From now on, we need the OS boot function */
 	if (ret)
 		return ret;
+	printf("%s(): images->os.os: %x\n", __func__, images->os.os);
+	printf("%s(): images->os.arch: %x\n", __func__, images->os.arch);
 	boot_fn = bootm_os_get_boot_func(images->os.os);
 	need_boot_fn = states & (BOOTM_STATE_OS_CMDLINE |
 			BOOTM_STATE_OS_BD_T | BOOTM_STATE_OS_PREP |
 			BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO);
+	printf("%s(): boot_fn: %p, need_boot_fn: %x\n", __func__, boot_fn, need_boot_fn);
 	if (boot_fn == NULL && need_boot_fn) {
 		if (iflag)
 			enable_interrupts();
"""


Result for the U-Boot prior to you revert using commit 3434b88d2c2f
("Merge branch 'master-fdt' of https://source.denx.de/u-boot/custodians/u-boot-sh"):

  Scanning bootdev 'mmc@fe320000.bootdev':
    1  extlinux     ready   mmc          1  mmc@fe320000.bootdev.part /extlinux/extlinux.conf
  ** Booting bootflow 'mmc@fe320000.bootdev.part_1' with extlinux
  1:      linux
  Retrieving file: /Image.gz
  Retrieving file: /initramfs.cpio.gz
  bootm_run_states(): images->state: 0, states: 1710
  bootm_run_states(): images->os.os: 0
  bootm_run_states(): images->os.arch: 0
  bootm_run_states(): boot_fn: 0000000000000000, need_boot_fn: 700
  ERROR: booting os 'Invalid OS' (0) is not supported
  Boot failed (err=-14)

And using an uncompressed /Image does not make any difference.


Result for the U-Boot after to your revert using commit cdd20e3f66fe
("Revert "Merge patch series "pxe: Allow extlinux booting without CMDLINE enabled"""):

  Scanning bootdev 'mmc@fe320000.bootdev':
    1  extlinux     ready   mmc          1  mmc@fe320000.bootdev.part /extlinux/extlinux.conf
  ** Booting bootflow 'mmc@fe320000.bootdev.part_1' with extlinux
  1:      linux
  Retrieving file: /Image.gz
  Retrieving file: /initramfs.cpio.gz
  bootm_run_states(): images->state: 0, states: 1
  bootm_run_states(): images->os.os: 0
  bootm_run_states(): images->os.arch: 0
  bootm_run_states(): boot_fn: 0000000000000000, need_boot_fn: 0
     Uncompressing Kernel Image to 0
  Moving Image from 0x2080000 to 0x2200000, end=6df0000
  ERROR: RD image overlaps OS image (OS=2200000..6df0000)
  Boot failed (err=-14)

Changing the RD image addr fixes such overlap (a separate issue not
present on my initial testing board, generic-rk3568_defconfig):

=> env set ramdisk_addr_r 10000000
=> boot

  Scanning bootdev 'mmc@fe320000.bootdev':
    1  extlinux     ready   mmc          1  mmc@fe320000.bootdev.part /extlinux/extlinux.conf
  ** Booting bootflow 'mmc@fe320000.bootdev.part_1' with extlinux
  1:      linux
  Retrieving file: /Image.gz
  Retrieving file: /initramfs.cpio.gz
  bootm_run_states(): images->state: 1, states: 1
  bootm_run_states(): images->os.os: 0
  bootm_run_states(): images->os.arch: 0
  bootm_run_states(): boot_fn: 0000000000000000, need_boot_fn: 0
     Uncompressing Kernel Image to 0
  Moving Image from 0x2080000 to 0x2200000, end=6df0000
  ## Flattened Device Tree blob at f1ef7c70
     Booting using the fdt blob at 0xf1ef7c70
  Working FDT set to f1ef7c70
  bootm_run_states(): images->state: 1, states: 1710
     Loading Ramdisk to f0dfb000, end f0eb074d ... OK
  bootm_run_states(): images->os.os: 5
  bootm_run_states(): images->os.arch: 16
  bootm_run_states(): boot_fn: 00000000f3f13828, need_boot_fn: 700
     Loading Device Tree to 00000000f0de6000, end 00000000f0dfa0e7 ... OK
  Working FDT set to f0de6000
  Starting kernel ...


I hope this can give some more details on how to reproduce the issue.

Regards,
Jonas
