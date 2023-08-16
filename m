Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8F6C41513
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 07:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB2D8699C;
	Wed, 16 Aug 2023 09:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Vtt4AjNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FE7D869B1; Wed, 16 Aug 2023 09:40:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C5268699B
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 09:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692171617; x=1692776417; i=xypron.glpk@gmx.de;
 bh=Ri4XTCFeeFxhU7HzTgzUurDqnEngjiGnB4qQOnhZTRE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Vtt4AjNEAajBeLK+6ntCri2Yeue7IYZ/MdZvPbFdgwcSJKqOGoHJ3VsedVQhz3gtWuS7aUw
 51vpx3pAM6O6oBxAEgPHBGUpXCTlRpMcFNyXwJke1a+lhaywP49j3GQ9notUIRojzvDDZLxot
 tNCzjA9kjptdSQew4Tr9wR7vrz8/Jibr+DK9J4MVxV/KHhoYqCtBx+dNhs1i+rq1+4TghyHtg
 PhO03sWSLP1Mmg3vHee8hIM67/7tBJZqC8guxJjB51lEvNZwW9tm3cirhAG03dLUwkDyv0qdV
 WGAq+N5qdbKlbyeitgkAofC2QcjB4dBFwIGGS9qffVSHWp7pm2iA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel81-1pwHxM02EP-00ajb6; Wed, 16
 Aug 2023 09:40:17 +0200
Message-ID: <de4b9edb-1d17-9ca8-1871-e25b280733e3@gmx.de>
Date: Wed, 16 Aug 2023 09:41:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Booting Windows 11
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAPnjgZ2a6S_Hh_=Gb=_Cz2zr9DG7TPEJxJD9z_PU9E6LiiMPHg@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ2a6S_Hh_=Gb=_Cz2zr9DG7TPEJxJD9z_PU9E6LiiMPHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LhUkFYxoFLTGCYLR/YooRO/AMufGFntC2BdgzzWOP8imrfQo/ql
 9svr4zZVkqsZ4fKEE+w0tn8wX1oaBOWrq3LMa+ZNd5IxfvnJq1f3MISv2OB2ngLkO0kIbwl
 pMj5oFWbmoFLI3a0NU170Z9Z76YD7H9LzGhlMEV1XO7jSgBtriolQsqG2o/JUJBtgUVY5U4
 bOhhXRmh9cii52aY12sOQ==
UI-OutboundReport: notjunk:1;M01:P0:CG1vLsnCciY=;63O81ZPbgNEVyRvfXazi10swSVW
 rC8V+DkToeDe8nHXbWXuOzuttjJzh/sITECGTjzCIfi6rn9l1sOhghR2W7e92+4BF3q2KLO9S
 +5cvS3OuWp/z4DYhIwxwXwka6T3WNeJYlcIuC+PbKzQylx6U3tkmbSkIWZFX2A4mX5qBBBfJ8
 nFKM/OfxMwBb90AvQkzK3As5hka668fHY7GivGvhB9pbwmYQ4zRfZG19nD8qtsf6PZCnW0Y7F
 l9yFuOfvQidHvMRdbh0HIoZcTkOUUVZr+BdddZGE0cFZbF+dEvF/2dAPffh/0rdfvoHuvlliI
 QxBDvmP/wPLVF/TNG0Dq+Ll7g9tEoep6QekNVtw3R2dFHbmy58ODYtqW1DX4mOUNtFAm+UEa3
 3HZDlIWcK4BkR28WCTq8GGWiO6fgaYb/wvVxG+gDr/0/4OvWG0pHEuiuOKTrTBoOexTWA6pla
 y0DQWIgbi0VJPaoaR1ZfEh9UGpvRVSSJQStseygICn2jMwzt+qhcGOHUPn553NHO5ItHCLFa4
 L8CDKGL3YG0ES1lcUvogLd+3Biw11YhCPmmxygbCnUUVPYZ+d1SyKeTBedoZNEojCKHKqrCBb
 VpZlVRWQVWHGvNOL4aHY7ALBIVHsaUUdoxyIYqh1e2ipVoYqbf60Vi/L4cWPh1cj0fbnRqKIj
 fwUSS6te7AowN87u6WNB8gm2GQh4LfVMFmN/9O0rxpMTI3wB9BPDPW6eLNMwaKvH98rlYVJIO
 iTUOFApp4ZT6/MvPjZnWWvW08BGDfwlNlND5xxsLmmpRf9A6mVRRiNvfJWNMFWak8vEHHUGUl
 j6XqCXTk0refvT+29dy7Vyo+R5UEDNIaKNLL1sn7dxpM5b+TCisOP+mjSNinO4ABHnvWGZsy1
 o+hGMfB1+QZ/Pu38pLzy7q9bh8NPf4sBNCPWdJu6THBjXul6CIepDgs+lgXAb47Pa1WBW0tox
 +ErJVw==
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

On 8/16/23 03:22, Simon Glass wrote:
> Hi Heinrich,
>
> I thought I would try booting Windows on U-Boot but it does not get
> very far. Have you tried that? I note a ew odd things below. Is there
> a validation suite for it?
>
> https://github.com/sjg20/u-boot/tree/efi2

qemu-x86_64_defconfig does not build with your tree (commit
d4caae6bce9082d0a770047e8f3d3a68b7084740, sjg/efi2):

   BINMAN  .binman_stamp
Wrote map file './rom.map' to show errors
binman: Node '/binman/rom/u-boot-spl-with-ucode-ptr': Offset 0xfffd8000
(4294803456) overlaps with previous entry '/binman/rom/u-boot' ending at
0xfffd84e8 (4294804712)
make: *** [Makefile:1115: .binman_stamp] Error 1

ImagePos    Offset      Size  Name
<none>    00000000  00100000  rom
<none>     fff00000  000d84e8  u-boot
<none>      00000000  000d79a0  u-boot-nodtb
<none>      000d79a0  00000b48  u-boot-dtb
<none>     fffd8000  00015f60  u-boot-spl-with-ucode-ptr
<none>     fffd84e8  00000b48  u-boot-dtb
<none>     fffd9030  000004c6  fdtmap
<none>     fffd94f6  00000000  private-files
<none>     fffedf60  00000b48  u-boot-dtb-with-ucode2
<none>     fffff800  00000070  x86-start16-spl
<none>     fffffff0  00000005  x86-reset16-spl
<none>     fffffff8  00000008  image-header

>
> qemu-system-x86_64  -smp 4 -m 8G -serial mon:stdio -bios
> /tmp/b/qemu-x86_64/u-boot.rom -drive
> id=3Dfisk,file=3Droot.img,if=3Dvirtio,driver=3Draw -drive
> id=3Ddisk,if=3Dvirtio,file=3D/vid/software/win/Win11_22H2_English_x64v2.=
iso

This does not work with EDK II either.

I was able to start the installer with:

qemu-system-x86_64 \
-M q35,smm=3Don,accel=3Dkvm -smp 8 -m 4G -gdb tcp::1234 \
-serial mon:stdio \
-vga std \
-device qemu-xhci \
-device usb-kbd \
-device usb-mouse \
-global driver=3Dcfi.pflash01,property=3Dsecure,value=3Don \
-drive
if=3Dpflash,format=3Draw,unit=3D0,file=3DOVMF_CODE_4M.secboot.fd,readonly=
=3Don \
-drive if=3Dpflash,format=3Draw,unit=3D1,file=3DOVMF_VARS.ms.fd \
-drive file=3Droot.img,if=3Dvirtio,format=3Draw \
-drive file=3DWin11_22H2_EnglishInternational_x64v2.iso,media=3Dcdrom

The Windows installer does not work without SMM but returns to the EFI
shell. This might be what you have seen.

U-Boot's qemu-x86_64_defconfig does not start with
-M q35,smm=3Don,accel=3Dkvm

Instead of using KVM you could specify -cpu Skylake-Client-v4 which is
supported by the Windows 11. But of course this is very slow.

Please, retry with:
qemu-system-x86_64 \
-machine pc-i440fx-2.5,smm=3Don -cpu Skylake-Client-v4 \
-vga std \

Can we get support for -M q35 into U-Boot? Cf.
https://wiki.qemu.org/Features/Q35. This would allow us to actually
compare EDK II and U-Boot when running with the same settings.

Why wouldn't U-Boot support kvm on an AMD Ryzen 5 2500U?

>
> Scanning bootdev 'virtio-blk#0.bootdev':
> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> efi_locate_device_path(protocol, &dp, &old_handle)
> efi_locate_device_path()   EFI: Entry efi_locate_device_path(Device
> Path, 00000000becf6848, 00000000becf6840)
> efi_locate_device_path()     EFI: Call:
> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
> &handles)
> efi_locate_handle_buffer()       EFI: Entry
> efi_locate_handle_buffer(2, Device Path, 0000000000000000,
> 00000000becf67b8, 00000000becf67b0)
> efi_locate_handle_buffer()       EFI: Exit: efi_locate_handle_buffer: 0
> efi_locate_device_path()     EFI: 0 returned by
> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
> &handles)
> efi_locate_device_path()   EFI: Exit: efi_locate_device_path: 14
> efi_install_multiple_protocol_interfaces_int() EFI: 14 returned by
>
>
> ^ This seems unhappy because it is a virtio device?

Before a device path protocol is installed we check that the same device
path has not been installed before (lib/efi_loader/efi_boottime.c:2685).

EFI_NOT_FOUND signals that we are good to continue.

Best regards

Heinrich
