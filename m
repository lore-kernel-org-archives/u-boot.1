Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE1AC3DA62
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 18:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02E2988602;
	Wed, 17 Jul 2024 20:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="2JUSLMk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A58E88A93; Wed, 17 Jul 2024 20:32:10 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047948859B
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 20:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=walter.lozano@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1721241127;
 bh=RHBP6g1g/UCUWbajMZ9vJpeIJeMjoN/b6bXwM6h6sJs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=2JUSLMk2UHIdoiRZs/uSLaT27Hh+6FEZBy/sgwPj7H5oydppXWxCTUiTPfkm/MAX0
 YieZrCSyTRjeSiJWq3iASq5RFVa0o+6AmQdW/R5PH76dDExDtMN1hKq+2ve1BCHzsC
 KjVwwKArZEA1Tc4QhJPMitqy7uGJR8qBq0oEa0Gb5ljPSdsfj6DElFkMdpIk6GklTy
 ACORVv0Yh/h5b02IFSKAXo75ejqZDDAL6Pm0qwa8gmbgzXbNjkQVBYMGZ4jyjwBLRE
 2fitv551WiTmPBFs8DY3imLj36aMG/i9S0I5KqwpaWqlYfSgUKlyiqErgpgiwHpZRt
 ORVJRoPXJEphg==
Received: from [100.99.210.253]
 (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: wlozano)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2D32C3780C11;
 Wed, 17 Jul 2024 18:32:04 +0000 (UTC)
Message-ID: <1f85166d-5ec9-48bb-b4d9-6a76158e0d4e@collabora.com>
Date: Wed, 17 Jul 2024 15:32:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rpi: Update memory layout for Aarch64
To: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Martyn Welch <martyn@collabora.com>,
 Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>
References: <20240716171602.2279766-1-walter.lozano@collabora.com>
 <20240716172113.GG561963@bill-the-cat>
 <CALeDE9PUF4-oCk+CXB0FiL=Haq9o0MkHa5BS4JTvZw7HbwjjaQ@mail.gmail.com>
 <20240717154437.GP561963@bill-the-cat>
Content-Language: en-US
From: Walter Lozano <walter.lozano@collabora.com>
In-Reply-To: <20240717154437.GP561963@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 7/17/24 12:44, Tom Rini wrote:
> On Wed, Jul 17, 2024 at 11:59:50AM +0100, Peter Robinson wrote:
>> On Tue, 16 Jul 2024 at 18:21, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Tue, Jul 16, 2024 at 02:16:02PM -0300, Walter Lozano wrote:
>>>
>>>> ARM and Aarch64 have different restrictions and trying to accommodate
>>>> larger kernels like the ones used in distros can be challenging. For this
>>>> reason, separate the layout and rearrange the map for Aarch64 to support
>>>> kernels larger than 36 MB.
>>>>
>>>> Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
>>>> ---
>>>>
>>>>   board/raspberrypi/rpi/rpi.env | 25 ++++++++++++++++++-------
>>>>   1 file changed, 18 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
>>>> index 30228285edd..37c7f6a920e 100644
>>>> --- a/board/raspberrypi/rpi/rpi.env
>>>> +++ b/board/raspberrypi/rpi/rpi.env
>>>> @@ -42,13 +42,19 @@ dfu_alt_info+=zImage fat 0 1
>>>>    *   For Aarch64, the kernel image is uncompressed and must be loaded at
>>>>    *   text_offset bytes (specified in the header of the Image) into a 2MB
>>>>    *   boundary. The 'booti' command relocates the image if necessary. Linux uses
>>>> - *   a default text_offset of 0x80000.  In summary, loading at 0x80000
>>>> - *   satisfies all these constraints and reserving memory up to 0x02400000
>>>> - *   permits fairly large (roughly 36M) kernels.
>>>> + *   a default text_offset of 0x80000.  However, loading it at 0x80000
>>>> + *   will allow to reserve only up to 0x02400000 which permits medium size
>>>> + *   kernels (roughly 36M). This is good enough for customized kernels but
>>>> + *   not for distros which by default enable drivers for many different
>>>> + *   boards. Under these circumstances, using 0x00200000 provides room for
>>>> + *   larger kernels.
>>>>    *
>>>>    * scriptaddr and pxefile_addr_r can be pretty much anywhere that doesn't
>>>>    * conflict with something else. Reserving 1M for each of them at
>>>> - * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
>>>> + * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty for ARM.
>>>> + *
>>>> + *   For Aarch64, since the kernel is placed in different location,
>>>> + *   accommodate them to reserver 1M for each of them.
>>>>    *
>>>>    * On ARM, both the DTB and any possible initrd must be loaded such that they
>>>>    * fit inside the lowmem mapping in Linux. In practice, this usually means not
>>>> @@ -62,16 +68,21 @@ dfu_alt_info+=zImage fat 0 1
>>>>    * large initrds before they start colliding with U-Boot.
>>>>    */
>>>>   #ifdef CONFIG_ARM64
>>>> +pxefile_addr_r=0x00080000
>>>> +scriptaddr=0x00100000
>>>> +kernel_addr_r=0x00200000
>>>> +fdt_addr_r=0x03400000
>>>> +ramdisk_addr_r=0x03500000
>>>>   fdt_high=ffffffffffffffff
>>>>   initrd_high=ffffffffffffffff
>>>>   #else
>>>> -fdt_high=ffffffff
>>>> -initrd_high=ffffffff
>>>> -#endif
>>>>   kernel_addr_r=0x00080000
>>>>   scriptaddr=0x02400000
>>>>   pxefile_addr_r=0x02500000
>>>>   fdt_addr_r=0x02600000
>>>>   ramdisk_addr_r=0x02700000
>>>> +fdt_high=ffffffff
>>>> +initrd_high=ffffffff
>>>> +#endif
>>>>
>>>>   boot_targets=mmc usb pxe dhcp
>>>
>>> We need to drop the disabling of device tree / initrd relocation as
>>> that's sure not going to help matters. What's the minimum amount of
>>> memory an aarch64 Pi will have? I really prefer reserving 128MiB (even
>>> if that's not the maximum Linux Kernel Image size anymore) and then
>>> device tree and then initrd.
>>
>> 512Mb on the Zero2W and RPi3A.
>>
>> We've not seen an issue here on the very large Fedora kernel, but I
>> suspect that's because using UEFI mitigates this somewhat because here
>> we're actually loading shim/grub.
> 
> OK, that should be enough to put a 128MiB spot for kernel, then 512KiB
> for device tree, and then rest for initrd, and not be disabling
> relocation (and thus preventing U-Boot from fixing failures).
> 

Thanks for the feedback! If I understood it correctly a layout like the
the one bellow would be the right thing. The only difference is in
device tree for which is reserved a bit more.

pxefile_addr_r=0x00080000
scriptaddr=0x00100000
kernel_addr_r=0x00200000
fdt_addr_r=0x09800000
ramdisk_addr_r=0x09900000

If this matches the expectations I will prepare the V2.

Thanks in advance,

Walter

-- 
Walter Lozano
Collabora Ltd.
