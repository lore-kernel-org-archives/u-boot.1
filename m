Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28215C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 08:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281F582075;
	Tue, 29 Apr 2025 10:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uDKtSAu9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA79820E1; Tue, 29 Apr 2025 10:30:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB3FA81FDE
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 10:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5DB815C0C41;
 Tue, 29 Apr 2025 08:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DB9C4CEE3;
 Tue, 29 Apr 2025 08:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745915410;
 bh=3o7MPyeAbmDHWg8WNfuhztN3H3GAXEBKJRruq98KrUg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=uDKtSAu9NlU7QeqlyLyLW+IFFZ5B57H5nWeTksGhLp1VdI3jOkvOHdJivf8YH3T82
 RVgKBGsNFpmbinpBFU20JfRbKk6BWUvw6JS5vwBEHC6RvY9a9SFnuAmg4X6rpQv9r9
 M7vMZBljqtdq+6g4trwCeiEAkVrzBL2AucKmdUABdIQr5pCJzNfopQgwgwd+GblWrV
 ZKqqQ21TzmZC6wd/LMpajd8hHtLTEqiB9iculwgOwifk6L2kUrzj76SILHx8qVKbQC
 NyrVvjlzjCLMYpjgQIj3hpoTyA9ro/6cqXcwitVN+4IBaaEShLeEBYsPUIYVarz1RW
 HgXfboI5BoaNw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>, gchan9527@gmail.com, Tom
 Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 0/3] u-boot chain-loading LineageOS bootimg
In-Reply-To: <dfe2c6d1-1935-4af3-b7d2-b04fdcbe6f29@linaro.org>
References: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
 <dfe2c6d1-1935-4af3-b7d2-b04fdcbe6f29@linaro.org>
Date: Tue, 29 Apr 2025 10:30:07 +0200
Message-ID: <87v7qnwesw.fsf@kernel.org>
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

Hi George,

Thank you for contributing.

On lun., avril 28, 2025 at 15:53, Casey Connolly <casey.connolly@linaro.org> wrote:

> Hi George,
>
> Thanks a lot for the series, it's super exciting to see support for 
> booting Android on top of U-Boot :D
>
> On 4/27/25 13:25, George Chan via B4 Relay wrote:
>> This is a series of patches to enable chainloading LineageOS on qcom SOC.
>> 
>> First patch is to workaround kernel/ramdisk invalid addr by identify
>> its physical memory address out-of-range. Since qcom SOC usually have
>> 0x80000000 as start/base/real memory address but androidboot img
>> specified to around 0x0. If other vendor bootloader behave similar then
>> this patch can also workaround it as well.
>
> I'm curious to know what values are there, tbh I think U-Boot should 
> entirely ignore the values in the boot image but I guess that could 
> break some other platforms.

Yes, some platforms actually use the values from the boot.img.
We had some breakage on Khadas VIM3 in this area. See:
https://lore.kernel.org/all/20241003-android-fix-boot-v2-v1-1-13e8e44af4b7@baylibre.com/

The above thread also mentions how to repack a boot.img, where we can
specify a different ramdisk address.

It's a bit unclear to me why it's impractical to repack the boot.img and
specify the appropriate address. Could you elaborate ?

>
> How about adding a config option CONFIG_ANDROID_BOOTIMG_IGNORE_ADDRS and 
> just ORing it in all the places that have checks like 
> "img_data->kernel_addr == 0". Then you can enable this for 
> mach-snapdragon by selecting it in the ARCH_SNAPDRAGON config definition.

If we need to add this in U-Boot, I'd prefer this option as suggested by Casey.

>
>> 
>> Second patch is enable bootmeth-android to have chance for extra mem block.
>> Usually the fastboot mem block, to hold androidboot img, and loadaddr for
>> unzipped kernel. If other SOC have extra mem block available but
>> fastboot block, we can add extra logic to take care of it.
>
> There is a small hack in mach-snapdragon that we put kernel_addr_r and 
> loadaddr at the same address to avoid using up too much memory on 
> devices that only have 1GB which explains this crash because we try to 
> decompress the kernel to the same address it got loaded too.
>
> I think we can get away with giving loadaddr its own allocation of 64M 
> or so, maybe 96. This would make your second patch redundant (and feels 
> like the right fix to me)

I was not aware of this hack, but I agree with Casey.

>
>> 
>> Third patch is optional to enable snapdragon board to have extra cmdline
>> found from original bootloader that is required for LineageOS boot init.
>> An alternate method is to put the append string into a dummy device-tree
>> file, as /chosen/bootarg ofnode porperty, that also contain msm-id. Then
>> encapsulate as androidboot img and let u-boot as kernel binary. Below is
>> an example for Xiaomi Miatoll device.
>
> I assume you're chainloading U-Boot on this device? If so, isn't it 
> enough to just copy the boot args that ABL gives us and maybe tweak a few?
>
> I'd also rather keep this constrained, maybe an android specific board 
> callback to set boot args (if there isn't one already) and have the FDT 
> fixup code be alongside some other generic FDT fixup stuff. I'd rather 
> not have this stuff in board specific code.

I also agree with Casey here. Looking at patch: "[PATCH 3/3]
mach-snapdragon: Add support to append string to kernel cmdline", the
android bootmethod already takes care of some androidboot.* arguments.
See:

https://source.denx.de/u-boot/u-boot/-/blob/master/boot/bootmeth_android.c?ref_type=heads#L504

For androidboot.verifiedbootstate=orange, this is done via
avb_append_commandline_arg() when AVB is enabled in U-Boot.

>
> I hope this makes sense, feel free to ask for clarifications on anything.
>
> Thanks and kind regards,
>
>> 
>> /dts-v1/;
>> 
>> / {
>>          qcom,msm-id = <443 0x0>;
>>          qcom,board-id = <0 0>,
>> 			<0x10022 1>,
>> 			<0x20022 1>,
>> 			<0x30022 1>,
>> 			<0x40022 1>,
>> 			<0x50022 1>;
>> 
>>          #address-cells = <2>;
>>          #size-cells = <2>;
>> 
>>          memory {
>>                  ddr_device_type = <0x07>;
>>                  /* We expect the bootloader to fill in the size */
>>                  reg = <0 0 0 0>;
>>          };
>> 
>> 	chosen {
>> 		bootargs = "";
>> 	};
>> };
>> 
>> Signed-off-by: George Chan <gchan9527@gmail.com>
>> ---
>> George Chan (3):
>>        boot/image-android.c: Workaround androidboot kernel/ramdisk addr
>>        boot/bootmeth-android.c: Reuse fastboot memory block for unzip kernel
>>        mach-snapdragon: Add support to append string to kernel cmdline
>> 
>>   arch/arm/mach-snapdragon/Kconfig | 11 +++++
>>   arch/arm/mach-snapdragon/board.c | 97 ++++++++++++++++++++++++++++++++++++++++
>>   boot/bootmeth_android.c          | 12 +++++
>>   boot/image-android.c             | 10 +++++
>>   4 files changed, 130 insertions(+)
>> ---
>> base-commit: 5a0a93a768487e55ebe50a34cc90d751bf99cc56
>> change-id: 20250427-android-boot-ecbb768cda72
>> 
>> Best regards,
> -- 
> Casey (she/they)
