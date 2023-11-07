Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B293CC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 22:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF4FB87636;
	Tue,  7 Nov 2023 23:58:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=superboring.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=superboring.dev header.i=@superboring.dev header.b="c/MRAPWM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB5286EF1; Tue,  7 Nov 2023 21:42:55 +0100 (CET)
Received: from mail.halogenos.org (mail.halogenos.org
 [IPv6:2a02:c207:2037:5246::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1CDE803AC
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 21:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=superboring.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devel@superboring.dev
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPA id 6BEFF151B35A; Tue,  7 Nov 2023 21:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
 s=dkim; t=1699389771;
 h=from:subject:date:message-id:to:cc:mime-version:content-type;
 bh=PbL4PthJDNpl7rqKE+F3WLoax8puI8WrNtcr76/QQvc=;
 b=c/MRAPWMBDjbUOo8/AYJr5/hzLbbg/CgUbZM2vFNOnp2KmEnvv0tle/6sUTRI83LMxZCH6
 9VHaT5Kl0bFGq7jwTqAMgFlMo8HMQl4ABNhUjFsoLzHSru5X/2z/5KWbOU7dEAolXnY5px
 TEOzT3wan/GZk2cz6RVwFEW9Xc9n36t/nGEIrNw8NZ6ByTGNkYQ2YOLaYIyez6KRHwIViW
 zdaFTfF5em9B6rzjk5jYyBgZMqBciW3GlqSXlYikGvLgN2UALYalr9GEA5dtljNyD+Si3z
 C5QA4i2zG2r73/t+n9JGJyd+3SvhruDTZFTxeTG+q0YEAuYyvcv4T8X0UBLQsA==
From: =?utf-8?q?Sim=C3=A3o_Gomes_Viana?= <devel@superboring.dev>
Date: Tue, 07 Nov 2023 21:42:50 +0100
Cc: u-boot@lists.denx.de
To: sjg@chromium.org
MIME-Version: 1.0
Message-ID: <43-654aa180-23-25098340@136247483>
Subject: Booting Android using U-Boot
User-Agent: SOGoMail 5.9.0
X-Last-TLS-Session-Version: None
X-Mailman-Approved-At: Tue, 07 Nov 2023 23:58:28 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


Hi Simon,
Hi everyone from the mailing list,

I'm following up to the email you sent today about a particular problem=
 I'm facing trying to boot AOSP 11 (built from source) using U-Boot.
I have extended my original email to include additional information and=
 added the mailing list to CC as requested.

In essence, it boils down to this:
## Booting Android Image at 0x00c00800 ...
Kernel load addr 0x00c01000 size 15184 KiB
Kernel command line: console=3DttyS2,1500000 earlycon=3Duart8250,mmio32=
,0xfe660000 androidboot.selinux=3Dpermissive service=5Flocator.enable=3D=
1 kpti=3D0 loop.max=5Fpart=3D7 firmware=5Fclass.path=3D/vendor/etc/firm=
ware buildvariant=3Duser
RAM disk load addr 0x01ad5000 size 751 KiB
## Flattened Device Tree blob at 00600000
=C2=A0=C2=A0 Booting using the fdt blob at 0x600000
Working FDT set to 600000
=C2=A0=C2=A0 Uncompressing Kernel Image
lz4 compressed: uncompress error -71
Must RESET board to recover


I have asked the same question on SO with more details.

The kernel is built in-line with the AOSP sources, just like LineageOS =
does it.
It builds the kernel using make as usual, then takes the Image.lz4 and =
runs mkbootimg with that.

I found this in scripts/Makefile.lib:
quiet=5Fcmd=5Flz4 =3D LZ4=C2=A0=C2=A0=C2=A0=C2=A0 $@
cmd=5Flz4 =3D (cat $(filter-out FORCE,$^) | \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lz4 -l -12 --favor-decSpeed =
stdin stdout && \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call size=5Fappend, $(filt=
er-out FORCE,$^))) > $@ || \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (rm -f $@ ; false)

It is using the -l parameter which is required for LZ4 compression of t=
he kernel image.

This is what is present in my BoardConfig:

# Kernel
BOARD=5FKERNEL=5FCMDLINE :=3D \
=C2=A0=C2=A0 =C2=A0console=3DttyS2,1500000 \
=C2=A0=C2=A0 =C2=A0earlycon=3Duart8250,mmio32,0xfe660000 \
=C2=A0=C2=A0 =C2=A0androidboot.selinux=3Dpermissive \
=C2=A0=C2=A0 =C2=A0service=5Flocator.enable=3D1 \
=C2=A0=C2=A0 =C2=A0kpti=3D0 \
=C2=A0=C2=A0 =C2=A0loop.max=5Fpart=3D7 \
=C2=A0=C2=A0 =C2=A0firmware=5Fclass.path=3D/vendor/etc/firmware

BOARD=5FKERNEL=5FBASE :=3D 0x10000000
BOARD=5FKERNEL=5FPAGESIZE :=3D 2048
BOARD=5FKERNEL=5FIMAGE=5FNAME :=3D Image.lz4
TARGET=5FKERNEL=5FCLANG=5FCOMPILE :=3D true
#TARGET=5FKERNEL=5FCLANG=5FVERSION :=3D latest
TARGET=5FKERNEL=5FSOURCE :=3D kernel/rockchip/rk356x
TARGET=5FKERNEL=5FCONFIG :=3D xos=5Frk356x=5Fdefconfig
TARGET=5FPREBUILT=5FRESOURCE ?=3D $(TARGET=5FKERNEL=5FSOURCE)/resource.=
img
TARGET=5FBOOTLOADER=5FIS=5F2ND :=3D true

This is what the file utility tells me:
out/target/product/rk3566=5Frgo/boot.img: Android bootimg, kernel (0x10=
008000), ramdisk (0x11000000), second stage (0x10f00000), page size: 20=
48, cmdline (console=3DttyS2,1500000 earlycon=3Duart8250,mmio32,0xfe660=
000 androidboot.selinux=3Dpermissive service=5Flocator.enable=3D1 kpti=3D=
0 loop.m)


unpack=5Fbootimg shows:
boot magic: ANDROID!
kernel=5Fsize: 15547433
kernel load address: 0x10008000
ramdisk size: 768194
ramdisk load address: 0x11000000
second bootloader size: 200192
second bootloader load address: 0x10f00000
kernel tags load address: 0x10000100
page size: 2048
os version: 11.0.0
os patch level: 2021-09
boot image header version: 2
product name:
command line args: console=3DttyS2,1500000 earlycon=3Duart8250,mmio32,0=
xfe660000 androidboot.selinux=3Dpermissive service=5Flocator.enable=3D1=
 kpti=3D0 loop.max=5Fpart=3D7 firmware=5Fclass.path=3D/vendor/etc/firmw=
are buildvariant=3Duser
additional command line args:
recovery dtbo size: 0
recovery dtbo offset: 0x0000000000000000
boot header size: 1660
dtb size: 11792057
dtb address: 0x0000000011f00000

This is what the working boot.img built by the manufacturer yields:
boot.img: Android bootimg, kernel (0x10008000), ramdisk (0x11000000), s=
econd stage (0x10f00000), page size: 2048, cmdline (console=3DttyFIQ0 a=
ndroidboot.baseband=3DN/A androidboot.wificountrycode=3DCN androidboot.=
veritymode=3Denforcing androidboot.hardware=3Dr)

unpack=5Fbootimg shows:
boot magic: ANDROID!
kernel=5Fsize: 31041552
kernel load address: 0x10008000
ramdisk size: 904155
ramdisk load address: 0x11000000
second bootloader size: 200192
second bootloader load address: 0x10f00000
kernel tags load address: 0x10000100
page size: 2048
os version: 11.0.0
os patch level: 2021-04
boot image header version: 2
product name:
command line args: console=3DttyFIQ0 androidboot.baseband=3DN/A android=
boot.wificountrycode=3DCN androidboot.veritymode=3Denforcing androidboo=
t.hardware=3Drk30board androidboot.console=3DttyFIQ0 androidboot.verifi=
edbootstate=3Dorange firmware=5Fclass.path=3D/vendor/etc/firmware init=3D=
/init rootwait ro loop.max=5Fpart=3D7 androidboot.selinux=3Dpermissive =
buildvariant=3Duserdebug
additional command line args:
recovery dtbo size: 0
recovery dtbo offset: 0x0000000000000000
boot header size: 1660
dtb size: 111487
dtb address: 0x0000000011f00000

Given that the kernel image is actually smaller than the manufacturer o=
ne, there can't be an overlapping issue.
The only real difference is the dtb size which is a lot bigger on the n=
on-functional boot image (I don't know why).
However, U-Boot is able to list all the DTBs.

The kernel source I'm using is the one provided in the BSP here (the 79=
G file): https://wiki.pine64.org/wiki/Quartz64=5FSoftware=5FReleases#An=
droid=5FSDK

If I build the kernel with CONFIG=5FCOMPRESS=5FGZ instead of CONFIG=5FC=
OMPRESS=5FLZ4, I also get an error:
## Booting Android Image at 0x00c00800 ...
Kernel load addr 0x00c01000 size 13176 KiB
Kernel command line: console=3DttyS2,1500000 earlycon=3Duart8250,mmio32=
,0xfe660000 androidboot.selinux=3Dpermissive service=5Flocator.enable=3D=
1 kpti=3D0 loop.max=5Fpart=3D7 firmware=5Fclass.path=3D/vendor/etc/firm=
ware buildvariant=3Duserdebug
RAM disk load addr 0x018df000 size 890 KiB
## Flattened Device Tree blob at 00600000
=C2=A0=C2=A0 Booting using the fdt blob at 0x600000
Working FDT set to 600000
=C2=A0=C2=A0 Uncompressing Kernel Image
Error: inflate() returned -5
gzip compressed: uncompress error -1
Must RESET board to recover

file utility says this about the kernel inside the boot image:
kernel: gzip compressed data, max compression, from Unix, original size=
 modulo 2^32 30021648

I am able to decompress it using gzip -d < kernel > kernel=5Fdecompress=
ed
Now file utility says:
kernel=5Fdecompressed: Linux kernel ARM64 boot executable Image, little=
-endian, 4K pages

The manufacturer kernel is not compressed, so it just tries to boot wit=
hout decompressing:

## Booting Android Image at 0x00c00800 ...
Kernel load addr 0x00c01000 size 30315 KiB
Kernel command line: console=3DttyFIQ0 androidboot.baseband=3DN/A andro=
idboot.wificountrycode=3DCN androidboot.veritymode=3Denforcing androidb=
oot.hardware=3Drk30board androidboot.console=3DttyFIQ0 androidboot.veri=
fiedbootstate=3Dorange firmware=5Fclass.path=3D/vendor/etc/firmware ini=
t=3D/init rootwait ro loop.max=5Fpart=3D7 androidboot.selinux=3Dpermiss=
ive buildvariant=3Duserdebug
RAM disk load addr 0x0299c000 size 883 KiB
## Flattened Device Tree blob at 00600000
=C2=A0=C2=A0 Booting using the fdt blob at 0x600000
Working FDT set to 600000
=C2=A0=C2=A0 XIP Kernel Image
=C2=A0=C2=A0 Loading Ramdisk to ede39000, end edf15bdb ... OK
ERROR: reserving fdt memory region failed (addr=3D0 size=3D0 flags=3D0)
ERROR: reserving fdt memory region failed (addr=3D0 size=3D0 flags=3D0)
=C2=A0=C2=A0 Loading Device Tree to 00000000edd36000, end 00000000ede38=
fff ... OK
Working FDT set to edd36000

Starting kernel ...


But the kernel does not start, the board just resets after a few second=
s.

I'm guessing there's something wrong with my bootcommand.

I'd appreciate it if you could point me in the right direction.
In case you need more information or want images of what I built, feel =
free to ask for it.

I have been trying to get this to work for weeks without any meaningful=
 success and am running out of ideas.

Thanks a lot and best regards,
Simao
=C2=A0
