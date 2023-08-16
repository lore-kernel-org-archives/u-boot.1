Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D55C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 10:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F271869A5;
	Wed, 16 Aug 2023 12:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AVLYS/oH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4901869BF; Wed, 16 Aug 2023 12:50:07 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE173868FC
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 12:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692183003; x=1692787803; i=xypron.glpk@gmx.de;
 bh=gGC3fGtqoO5C2Gyv/myOxDqGU+FQ00483h9y54OHIfo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=AVLYS/oHCqEfyqP1VmRTtMHMmbKfa+g7egYUCNNnPq6PzvDMLPGgyBVdKxeDZYgKZFMsUtE
 o970NrpG9DaJ8D7Rti+0y3YcMfMVhXhKs1cSzbA+d3zf75Ohinbap6Tb0V13ZC1QNVcGckwHu
 65hgVDZZlEwI5ltfHBEosfl5SivbqcX7X5f6oqEL6Mxb0BpkTXWnpVX69IRQrKuelpVLr3g/W
 4GCxoJoraq61GnSiuvGbh5A4cjngTKCYFEHBVc4cW0xqHnixd3/Wh3hIaXgyxd21VVhNFTfpZ
 081pMEgS5AzzzOniQUTj4VZapsbpj3pggDRanMmLeW7/OU5B638g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26rD-1qUI9i3SNV-002YVc; Wed, 16
 Aug 2023 12:50:03 +0200
Message-ID: <8c605f6f-ad36-27da-83ac-54932e6b1226@gmx.de>
Date: Wed, 16 Aug 2023 12:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Booting Windows 11
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAPnjgZ2a6S_Hh_=Gb=_Cz2zr9DG7TPEJxJD9z_PU9E6LiiMPHg@mail.gmail.com>
 <de4b9edb-1d17-9ca8-1871-e25b280733e3@gmx.de>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <de4b9edb-1d17-9ca8-1871-e25b280733e3@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gGMln/wLk19WYxMQOsI2OMaVUAsR+vbJA1PCfTA3S7P8N102U6a
 NG7pNgVwiez0sv4b8MGl+sg4TysbrVl1Dp2+QtcQX+VPDMBwEwI09ilJBT80KZ1OElrKxpM
 DBX5UKwLlgZ2mCx4zRpiCy9lCDvX7x9IdQLVKG/QYw8+nuxyWGJYIjGo3MszQjwFTnSLCM5
 D03wehi4yruMb32qMwRhQ==
UI-OutboundReport: notjunk:1;M01:P0:1v2mmjegk+A=;uHp3F5+oFEqswu55lzLKYZJeb3r
 5RO+yv2pBdZbRBryhTVb1z+6KZ4+qUd6CbrmmTM7W5pZkafsRczz6ASFCaga0GaZpzkPfMHCw
 bczBXnwzMmDQ47jIXJ6uQxfJsf0PEr+8RvSATQGYXINqGELMqCbEX+I7WngjlaoTqX+ihj6nd
 zd/Pwji5N/xenVF5jLyq52SaeMR8nOl3xGTZpSz3UbMBs3aWVF+gPXJ8JpnvL7mikQh93EFsq
 et2d/k1IrgJRz12O17V4Lfm4So0SHv3AsQf3Q3Qbl9PK6cbwnbfI5pMk0I3XPVp7OKKHQf05s
 LPHLle1OzCueGtJP33jUc9ho5hBeSP++T4sOf0eSTxv/GVekqVw/Rr6ASjI/6Tq+GDF5qHIo0
 p3JeDYqRBv4feGC/2Saz5JaVrWxCy3UzFG/WWBX9eUtt1kGKtF2zdg4ll/wOKXD7+3RYvesq6
 LRizz5YOkh7FlEJN+ZXf5t1O9zmSr2nRrjvV4gmaV20xgdc/eIhQkgW7jlIgeL4b6X+Mdp4OE
 c8T8pA+mNixjI08V4KuTRYqQlJNIz0TvB8NuMhcouZtOwLBu0nIBnIrI6QqNI4ImNjKxgIHhR
 I3dhNqLi7OQqRXg6Gpbqw+CjASBUHawJxthDcgMkA3aM6jq9EGweXAK6uHyQZOaxUNa9qq/AG
 PXNKGbTv6dg96F7Yp1T2JQE5LFK0x+/RuzkIwTVsaDEgND1W7g26Wp5wq7GK3evE6q+YQj+Vk
 4r+DHeViPPqwdkrJ6qw9upFE/QGHpgD2QWkCqhunu4oRafmVYRModDkIXnpx1dJPsWoMtdE2R
 XP4J7Ur42VQ5Iw0IG62us+f3V5QoGYFGFWW4dj/TkxDPUClrW08GY+GmC8IO8DORkUTh4gaRJ
 ItidutstrWWsUOIS2qqdT8qXtep/fzCqKeIk9LoDCo1LtigqX7kMuHYRMXXqQ3Fy54a4yBn9E
 DUmw3FkAc36cTNlIVqXGkgBQ7lY=
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

On 8/16/23 09:41, Heinrich Schuchardt wrote:
> On 8/16/23 03:22, Simon Glass wrote:
>> Hi Heinrich,
>>
>> I thought I would try booting Windows on U-Boot but it does not get
>> very far. Have you tried that? I note a ew odd things below. Is there
>> a validation suite for it?
>>
>> https://github.com/sjg20/u-boot/tree/efi2
>
> qemu-x86_64_defconfig does not build with your tree (commit
> d4caae6bce9082d0a770047e8f3d3a68b7084740, sjg/efi2):
>
>  =C2=A0 BINMAN=C2=A0 .binman_stamp
> Wrote map file './rom.map' to show errors
> binman: Node '/binman/rom/u-boot-spl-with-ucode-ptr': Offset 0xfffd8000
> (4294803456) overlaps with previous entry '/binman/rom/u-boot' ending at
> 0xfffd84e8 (4294804712)
> make: *** [Makefile:1115: .binman_stamp] Error 1
>
> ImagePos=C2=A0=C2=A0=C2=A0 Offset=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=
=A0 Name
> <none>=C2=A0=C2=A0=C2=A0 00000000=C2=A0 00100000=C2=A0 rom
> <none>=C2=A0=C2=A0=C2=A0=C2=A0 fff00000=C2=A0 000d84e8=C2=A0 u-boot
> <none>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000=C2=A0 000d79a0=C2=A0 u-boo=
t-nodtb
> <none>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000d79a0=C2=A0 00000b48=C2=A0 u-boo=
t-dtb
> <none>=C2=A0=C2=A0=C2=A0=C2=A0 fffd8000=C2=A0 00015f60=C2=A0 u-boot-spl-=
with-ucode-ptr
> <none>=C2=A0=C2=A0=C2=A0=C2=A0 fffd84e8=C2=A0 00000b48=C2=A0 u-boot-dtb
> <none>=C2=A0=C2=A0=C2=A0=C2=A0 fffd9030=C2=A0 000004c6=C2=A0 fdtmap
> <none>=C2=A0=C2=A0=C2=A0=C2=A0 fffd94f6=C2=A0 00000000=C2=A0 private-fil=
es
> <none>=C2=A0=C2=A0=C2=A0=C2=A0 fffedf60=C2=A0 00000b48=C2=A0 u-boot-dtb-=
with-ucode2
> <none>=C2=A0=C2=A0=C2=A0=C2=A0 fffff800=C2=A0 00000070=C2=A0 x86-start16=
-spl
> <none>=C2=A0=C2=A0=C2=A0=C2=A0 fffffff0=C2=A0 00000005=C2=A0 x86-reset16=
-spl
> <none>=C2=A0=C2=A0=C2=A0=C2=A0 fffffff8=C2=A0 00000008=C2=A0 image-heade=
r
>
>>
>> qemu-system-x86_64=C2=A0 -smp 4 -m 8G -serial mon:stdio -bios
>> /tmp/b/qemu-x86_64/u-boot.rom -drive
>> id=3Dfisk,file=3Droot.img,if=3Dvirtio,driver=3Draw -drive
>> id=3Ddisk,if=3Dvirtio,file=3D/vid/software/win/Win11_22H2_English_x64v2=
.iso
>
> This does not work with EDK II either.
>
> I was able to start the installer with:
>
> qemu-system-x86_64 \
> -M q35,smm=3Don,accel=3Dkvm -smp 8 -m 4G -gdb tcp::1234 \
> -serial mon:stdio \
> -vga std \
> -device qemu-xhci \
> -device usb-kbd \
> -device usb-mouse \
> -global driver=3Dcfi.pflash01,property=3Dsecure,value=3Don \
> -drive
> if=3Dpflash,format=3Draw,unit=3D0,file=3DOVMF_CODE_4M.secboot.fd,readonl=
y=3Don \
> -drive if=3Dpflash,format=3Draw,unit=3D1,file=3DOVMF_VARS.ms.fd \
> -drive file=3Droot.img,if=3Dvirtio,format=3Draw \
> -drive file=3DWin11_22H2_EnglishInternational_x64v2.iso,media=3Dcdrom
>
> The Windows installer does not work without SMM but returns to the EFI
> shell. This might be what you have seen.
>
> U-Boot's qemu-x86_64_defconfig does not start with
> -M q35,smm=3Don,accel=3Dkvm
>
> Instead of using KVM you could specify -cpu Skylake-Client-v4 which is
> supported by the Windows 11. But of course this is very slow.
>
> Please, retry with:
> qemu-system-x86_64 \
> -machine pc-i440fx-2.5,smm=3Don -cpu Skylake-Client-v4 \
> -vga std \
>
> Can we get support for -M q35 into U-Boot? Cf.
> https://wiki.qemu.org/Features/Q35. This would allow us to actually
> compare EDK II and U-Boot when running with the same settings.
>
> Why wouldn't U-Boot support kvm on an AMD Ryzen 5 2500U?

With KVM I either get:
"int_exception_handler() Exception 13 while executing option rom"
or the code hangs in cpu_call64.

Best regards

Heinrich

>
>>
>> Scanning bootdev 'virtio-blk#0.bootdev':
>> efi_install_multiple_protocol_interfaces_int() EFI: Call:
>> efi_locate_device_path(protocol, &dp, &old_handle)
>> efi_locate_device_path()=C2=A0=C2=A0 EFI: Entry efi_locate_device_path(=
Device
>> Path, 00000000becf6848, 00000000becf6840)
>> efi_locate_device_path()=C2=A0=C2=A0=C2=A0=C2=A0 EFI: Call:
>> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
>> &handles)
>> efi_locate_handle_buffer()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EFI: Ent=
ry
>> efi_locate_handle_buffer(2, Device Path, 0000000000000000,
>> 00000000becf67b8, 00000000becf67b0)
>> efi_locate_handle_buffer()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EFI: Exi=
t: efi_locate_handle_buffer: 0
>> efi_locate_device_path()=C2=A0=C2=A0=C2=A0=C2=A0 EFI: 0 returned by
>> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
>> &handles)
>> efi_locate_device_path()=C2=A0=C2=A0 EFI: Exit: efi_locate_device_path:=
 14
>> efi_install_multiple_protocol_interfaces_int() EFI: 14 returned by
>>
>>
>> ^ This seems unhappy because it is a virtio device?
>
> Before a device path protocol is installed we check that the same device
> path has not been installed before (lib/efi_loader/efi_boottime.c:2685).
>
> EFI_NOT_FOUND signals that we are good to continue.
>
> Best regards
>
> Heinrich

