Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0032C001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 14:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3361847D3;
	Wed, 16 Aug 2023 16:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hqCF/rVc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59989857BF; Wed, 16 Aug 2023 16:16:01 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85E33847C3
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 16:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5254f9eda36so5260643a12.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692195354; x=1692800154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ou7ABXuvG4MX865LM7Jz+5s/N5SQ6rUMMWKJsD6s0ik=;
 b=hqCF/rVcEXJju8AvxXgnjlJC4FMbXxelm3th16c+5gxzS5Wfe62hf3chppKhC9NqPx
 qRUPTEWWr13fUp+YejlQms20gDtZiA3fDKK/npZ+Z+9fBkYcqhI3h/OyprEM/GONVMa1
 5d7uYhrFunYlYMSoJd0FHA5yNdrL5HgfuOe1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692195354; x=1692800154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ou7ABXuvG4MX865LM7Jz+5s/N5SQ6rUMMWKJsD6s0ik=;
 b=SUJUnKOW5/3dYFI6RrM6ZZW64OWlRRBp5g3F8sppOBzOqTzaKtjFlahq6vmwDuXEba
 luwHOs84gtC9csdU2VMpbnS6952NuD2irCrAotn69PpzveVs0t90cqP2F89z7VV231MD
 eqgO2SaXyILt/sZkLNO5bO0/E/SMv4dl5AvdhPmkT4hzpNHSDvUZ0OwCx3IEyjnBbq9X
 4CTTXmHkcYkUinTNgcFDn4wa002/VfKyH8JbWky3gCrdqodgOYOxvDXLbwiGMhpc90U8
 s/S+qUYbdvI4YK6ngL0mOiT2uw3RA3oaltvraDaKm+wzBQFU9GCxKRoMc0xR0rhtd6Xf
 PPnw==
X-Gm-Message-State: AOJu0Yz8LQFW1X+k9fHUz3AfokRta79bLzZrZbhLEEGNKZtY2qwz9vO+
 trnMtklrGP0La1smgnvBtuWOjfSdlmbJOljYspGM5w==
X-Google-Smtp-Source: AGHT+IEd5BtfuXlRTo+4v5qk+X3oTdFFyT3VFaAxEGG+r7gmnOTcPn6VTYlqnZ4jP7UDjnFyZsHq/VTmwAaJCg9pXjY=
X-Received: by 2002:a17:907:a071:b0:99b:c0a0:8e17 with SMTP id
 ia17-20020a170907a07100b0099bc0a08e17mr1609730ejc.52.1692195353714; Wed, 16
 Aug 2023 07:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ2a6S_Hh_=Gb=_Cz2zr9DG7TPEJxJD9z_PU9E6LiiMPHg@mail.gmail.com>
 <de4b9edb-1d17-9ca8-1871-e25b280733e3@gmx.de>
 <8c605f6f-ad36-27da-83ac-54932e6b1226@gmx.de>
In-Reply-To: <8c605f6f-ad36-27da-83ac-54932e6b1226@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 16 Aug 2023 08:15:42 -0600
Message-ID: <CAPnjgZ1CVSFptm7h6_sYD0Rk7xXyYz6LJOVs5DyJDcyzxtTjYg@mail.gmail.com>
Subject: Re: Booting Windows 11
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Wed, 16 Aug 2023 at 04:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 8/16/23 09:41, Heinrich Schuchardt wrote:
> > On 8/16/23 03:22, Simon Glass wrote:
> >> Hi Heinrich,
> >>
> >> I thought I would try booting Windows on U-Boot but it does not get
> >> very far. Have you tried that? I note a ew odd things below. Is there
> >> a validation suite for it?
> >>
> >> https://github.com/sjg20/u-boot/tree/efi2

Thanks for all the helpful info. I know very little about this so am
happy that you do!

> >
> > qemu-x86_64_defconfig does not build with your tree (commit
> > d4caae6bce9082d0a770047e8f3d3a68b7084740, sjg/efi2):
> >
> >    BINMAN  .binman_stamp
> > Wrote map file './rom.map' to show errors
> > binman: Node '/binman/rom/u-boot-spl-with-ucode-ptr': Offset 0xfffd8000
> > (4294803456) overlaps with previous entry '/binman/rom/u-boot' ending at
> > 0xfffd84e8 (4294804712)
> > make: *** [Makefile:1115: .binman_stamp] Error 1
> >
> > ImagePos    Offset      Size  Name
> > <none>    00000000  00100000  rom
> > <none>     fff00000  000d84e8  u-boot
> > <none>      00000000  000d79a0  u-boot-nodtb
> > <none>      000d79a0  00000b48  u-boot-dtb
> > <none>     fffd8000  00015f60  u-boot-spl-with-ucode-ptr
> > <none>     fffd84e8  00000b48  u-boot-dtb
> > <none>     fffd9030  000004c6  fdtmap
> > <none>     fffd94f6  00000000  private-files
> > <none>     fffedf60  00000b48  u-boot-dtb-with-ucode2
> > <none>     fffff800  00000070  x86-start16-spl
> > <none>     fffffff0  00000005  x86-reset16-spl
> > <none>     fffffff8  00000008  image-header

I am building with

> >
> >>
> >> qemu-system-x86_64  -smp 4 -m 8G -serial mon:stdio -bios
> >> /tmp/b/qemu-x86_64/u-boot.rom -drive
> >> id=fisk,file=root.img,if=virtio,driver=raw -drive
> >> id=disk,if=virtio,file=/vid/software/win/Win11_22H2_English_x64v2.iso
> >
> > This does not work with EDK II either.
> >

OK

> > I was able to start the installer with:
> >
> > qemu-system-x86_64 \
> > -M q35,smm=on,accel=kvm -smp 8 -m 4G -gdb tcp::1234 \
> > -serial mon:stdio \
> > -vga std \
> > -device qemu-xhci \
> > -device usb-kbd \
> > -device usb-mouse \
> > -global driver=cfi.pflash01,property=secure,value=on \
> > -drive
> > if=pflash,format=raw,unit=0,file=OVMF_CODE_4M.secboot.fd,readonly=on \
> > -drive if=pflash,format=raw,unit=1,file=OVMF_VARS.ms.fd \
> > -drive file=root.img,if=virtio,format=raw \
> > -drive file=Win11_22H2_EnglishInternational_x64v2.iso,media=cdrom
> >

For me I get an error:

$ dpkg -l ovmf
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name           Version                  Architecture Description
+++-==============-========================-============-=============================================
ii  ovmf           2022.02-3ubuntu0.22.04.1 all          UEFI firmware
for 64-bit x86 virtual machines

$ qemu-system-x86_64 -M q35,smm=on,accel=kvm -smp 8 -m 4G -gdb
tcp::1234 -serial mon:stdio -vga std -device qemu-xhci -device usb-kbd
-device usb-mouse -global driver=cfi.pflash01,property=secure,value=on
-drive if=pflash,format=raw,unit=0,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd,readonly=on
-drive if=pflash,format=raw,unit=1,file=//vid/software/devel/u-boot/efi/OVMF_VARS.ms.fd
-drive file=root.img,if=virtio,format=raw -drive
file=/vid/software/win/Win11_22H2_English_x64v2.iso,media=cdrom
qemu-system-x86_64: Gdk:
gdk_wayland_window_set_dbus_properties_libgtk_only: assertion
'GDK_IS_WAYLAND_WINDOW (window)' failed
!!!! X64 Exception Type - 06(#UD - Invalid Opcode)  CPU Apic ID - 00000000 !!!!
RIP  - 0000000000030000, CS  - 0000000000000038, RFLAGS - 0000000000010246
RAX  - 0000000000000000, RCX - 0000000000000000, RDX - 0000000000000000
RBX  - FFFFFFFFFFFFFFFF, RSP - 000000007EEC1E18, RBP - 0000000000000001
RSI  - 000000007E8EC818, RDI - 000000007EED9830
R8   - 0000000000000000, R9  - 0000000003041001, R10 - 000000000000003A
R11  - 000000007E8E9680, R12 - 000000007E8E9018, R13 - 000000007EEC1EA0
R14  - 000000007EED72F0, R15 - 0000000000000000
DS   - 0000000000000030, ES  - 0000000000000030, FS  - 0000000000000030
GS   - 0000000000000030, SS  - 0000000000000030
CR0  - 0000000080010033, CR2 - 0000000000000000, CR3 - 000000007EC01000
CR4  - 0000000000000668, CR8 - 0000000000000000
DR0  - 0000000000000000, DR1 - 0000000000000000, DR2 - 0000000000000000
DR3  - 0000000000000000, DR6 - 00000000FFFF0FF0, DR7 - 0000000000000400
GDTR - 000000007E9E2000 0000000000000047, LDTR - 0000000000000000
IDTR - 000000007E4E6018 0000000000000FFF,   TR - 0000000000000000
FXSAVE_STATE - 000000007EEC1A70
!!!! Can't find image information. !!!!


> > The Windows installer does not work without SMM but returns to the EFI
> > shell. This might be what you have seen.

OK.

> >
> > U-Boot's qemu-x86_64_defconfig does not start with
> > -M q35,smm=on,accel=kvm
> >
> > Instead of using KVM you could specify -cpu Skylake-Client-v4 which is
> > supported by the Windows 11. But of course this is very slow.
> >
> > Please, retry with:
> > qemu-system-x86_64 \
> > -machine pc-i440fx-2.5,smm=on -cpu Skylake-Client-v4 \
> > -vga std \

That does the same thing for me with qemu-x86_64 (eventually reboots).
I tried using Q35 too:

qemu-system-x86_64 -M smm=on  -cpu Skylake-Client-v4 -vga std  -m 4G
-serial mon:stdio -bios /tmp/b/qemu-x86_64/u-boot.rom -drive
id=fisk,file=root.img,if=virtio,driver=raw  -drive
id=disk,file=/vid/software/win/Win11_22H2_English_x64v2.iso,if=none
   -device ich9-ahci,id=ahci       -device
ide-hd,drive=disk,bus=ahci.0

Trying the same idea with the OVMF stuff hangs with nothing on the display:

qemu-system-x86_64 -M pc-i440fx-2.5,smm=on -cpu Skylake-Client-v4 -vga
std  -m 4G -gdb tcp::1234 -serial mon:stdio -vga std -device qemu-xhci
-device usb-kbd -device usb-mouse -global
driver=cfi.pflash01,property=secure,value=on -drive
if=pflash,format=raw,unit=0,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd,readonly=on
-drive if=pflash,format=raw,unit=1,file=//vid/software/devel/u-boot/efi/OVMF_VARS.ms.fd
-drive file=root.img,if=virtio,format=raw -drive
file=/vid/software/win/Win11_22H2_English_x64v2.iso,media=cdrom

> >
> > Can we get support for -M q35 into U-Boot? Cf.
> > https://wiki.qemu.org/Features/Q35. This would allow us to actually
> > compare EDK II and U-Boot when running with the same settings.

Yes but you need to change CONFIG_DEVICE_TREE to "qemu-x86_q35"

> >
> > Why wouldn't U-Boot support kvm on an AMD Ryzen 5 2500U?
>
> With KVM I either get:
> "int_exception_handler() Exception 13 while executing option rom"
> or the code hangs in cpu_call64.

Yes, that is a bug I mentioned to Bin as well. It happens when jumping
into 64-bit mode. However, it works fine with booting from coreboot,
so it is probably something missing in the CPU init. I have not dug
into that yet.

I pushed a new tree to my github/efi2 with the Q35 changes so that you
can try that.

>
> Best regards
>
> Heinrich
>
> >
> >>
> >> Scanning bootdev 'virtio-blk#0.bootdev':
> >> efi_install_multiple_protocol_interfaces_int() EFI: Call:
> >> efi_locate_device_path(protocol, &dp, &old_handle)
> >> efi_locate_device_path()   EFI: Entry efi_locate_device_path(Device
> >> Path, 00000000becf6848, 00000000becf6840)
> >> efi_locate_device_path()     EFI: Call:
> >> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
> >> &handles)
> >> efi_locate_handle_buffer()       EFI: Entry
> >> efi_locate_handle_buffer(2, Device Path, 0000000000000000,
> >> 00000000becf67b8, 00000000becf67b0)
> >> efi_locate_handle_buffer()       EFI: Exit: efi_locate_handle_buffer: 0
> >> efi_locate_device_path()     EFI: 0 returned by
> >> efi_locate_handle_buffer(BY_PROTOCOL, protocol, NULL, &no_handles,
> >> &handles)
> >> efi_locate_device_path()   EFI: Exit: efi_locate_device_path: 14
> >> efi_install_multiple_protocol_interfaces_int() EFI: 14 returned by
> >>
> >>
> >> ^ This seems unhappy because it is a virtio device?
> >
> > Before a device path protocol is installed we check that the same device
> > path has not been installed before (lib/efi_loader/efi_boottime.c:2685).
> >
> > EFI_NOT_FOUND signals that we are good to continue.

OK, thanks.

Regards,
Simon
