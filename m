Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D97C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 00:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C1B887539;
	Wed,  8 Nov 2023 01:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=superboring.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=superboring.dev header.i=@superboring.dev header.b="nvxaGRzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CA1B8761A; Wed,  8 Nov 2023 01:06:24 +0100 (CET)
Received: from mail.halogenos.org (mail.halogenos.org
 [IPv6:2a02:c207:2037:5246::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 773C3876D5
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 01:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=superboring.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devel@superboring.dev
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPA id 74BAB151B37A; Wed,  8 Nov 2023 01:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
 s=dkim; t=1699401978;
 h=from:subject:date:message-id:to:cc:mime-version:content-type;
 bh=YqfGF8ZSPT7DOExd2nMYlWBCBb+wrLusXmUIeQPGA7E=;
 b=nvxaGRzZBozbDh6M8ADm+Iw0+OlpjKIVSO/oGgmen505imkIfCM+RFKBtl3esEiBkNjADz
 hl7l78j3qHuuyg+GxyVH3WU2zEiLjpbrLVAxGyV8j4CoAgxiOaKMcf/R0Ua3rDQ2kwoz/l
 mG3G5V8mg7TEQ4bPvoyraY9gf3gq662KU8+uu/LlZGl6G2exEzIdCiYAGbRQDHOa3+9qf3
 TgZAKp5ZywKHEtxfCe3L422gJxSSZASF5veSiSRNrSaynxxlbhPnf64aWv5bz3Bz0+ZhQb
 TC/HhC0E/0q0b0Phl8uPmcM1AhOE8awe4/1mw4lJW9dcghbAeO0T3rjEhm3r3g==
From: =?utf-8?q?Sim=C3=A3o_Gomes_Viana?= <devel@superboring.dev>
Date: Wed, 08 Nov 2023 01:06:16 +0100
Cc: u-boot@lists.denx.de
To: sjg@chromium.org, mkorpershoek@baylibre.com
MIME-Version: 1.0
Message-ID: <39-654ad100-39-2ca944c0@142113415>
Subject: =?utf-8?q?Re=3A?= Booting Android using U-Boot
User-Agent: SOGoMail 5.9.0
X-Last-TLS-Session-Version: None
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


Hi everyone,

Good news! I disabled compression on kernel build and the resulting boo=
t image starts booting Linux.

This is great but it does not solve the decompression issue.
Thanks to Mattijs for pointing me in the compression direction which ma=
de me further investigate compression options.

So with compression disabled, let's move on to the next issue:
I picked the Quartz64 DTS commits, built and booted it, however there s=
eems to still be an issue:
Starting kernel ...

[=C2=A0=C2=A0=C2=A0 0.000000] Booting Linux on physical CPU 0x000000000=
0 [0x412fd050]
[=C2=A0=C2=A0=C2=A0 0.000000] Linux version 4.19.154-xos (nobody@androi=
d-build) (Android (6877366 based on r383902b1) clang version 11.0.2 (ht=
tps://android.googlesource.com/toolchain/llvm-project b397f81060ce6d701=
042b782172ed13bee898b79), GNU ld (binutils-2.27-bd24d23f) 2.27.0.201703=
15) #1 SMP PREEMPT Wed Nov 8 00:54:49 CET 2023
[=C2=A0=C2=A0=C2=A0 0.000000] Machine model: Pine64 RK3566 Quartz64-A B=
oard
...omitted for brevity...
[=C2=A0=C2=A0=C2=A0 0.000007] sched=5Fclock: 56 bits at 24MHz, resoluti=
on 41ns, wraps every 4398046511097ns
[=C2=A0=C2=A0=C2=A0 0.001828] Insufficient stack space to handle except=
ion!
[=C2=A0=C2=A0=C2=A0 0.001835] ESR: 0x81054040 -- IABT (lower EL)
[=C2=A0=C2=A0=C2=A0 0.002766] FAR: 0xc08eea4d24faf096
[=C2=A0=C2=A0=C2=A0 0.003098] Task stack:=C2=A0=C2=A0=C2=A0=C2=A0 [0xff=
ffff8009cc1000..0xffffff8009cc5000]
[=C2=A0=C2=A0=C2=A0 0.003697] IRQ stack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
[0xffffff8008000000..0xffffff8008004000]
[=C2=A0=C2=A0=C2=A0 0.004299] Overflow stack: [0xffffffc1ff713080..0xff=
ffffc1ff714080]
[=C2=A0=C2=A0=C2=A0 0.004907] CPU: 0 PID: 0 Comm: swapper/0 Not tainted=
 4.19.154-xos #1
[=C2=A0=C2=A0=C2=A0 0.005516] Hardware name: Pine64 RK3566 Quartz64-A B=
oard (DT)
[=C2=A0=C2=A0=C2=A0 0.006073] pstate: 20400009 (nzCv daif +PAN -UAO)
[=C2=A0=C2=A0=C2=A0 0.006544] pc : start=5Fkernel+0x26c/0x3d0
[=C2=A0=C2=A0=C2=A0 0.006931] lr : start=5Fkernel+0x25c/0x3d0
...omitted for brevity...
[=C2=A0=C2=A0=C2=A0 0.098560] Kernel panic - not syncing: kernel stack =
overflow
[=C2=A0=C2=A0=C2=A0 0.099108] CPU: 0 PID: 0 Comm: swapper/0 Not tainted=
 4.19.154-xos #1
[=C2=A0=C2=A0=C2=A0 0.099717] Hardware name: Pine64 RK3566 Quartz64-A B=
oard (DT)
[=C2=A0=C2=A0=C2=A0 0.100270] Call trace:
[=C2=A0=C2=A0=C2=A0 0.100515]=C2=A0 dump=5Fbacktrace+0x0/0x158
[=C2=A0=C2=A0=C2=A0 0.100871]=C2=A0 show=5Fstack+0x14/0x1c
[=C2=A0=C2=A0=C2=A0 0.101195]=C2=A0 dump=5Fstack+0xb8/0xf0
[=C2=A0=C2=A0=C2=A0 0.101519]=C2=A0 panic+0x12c/0x2a4
[=C2=A0=C2=A0=C2=A0 0.101815]=C2=A0 panic+0x0/0x2a4
[=C2=A0=C2=A0=C2=A0 0.102095]=C2=A0 handle=5Fbad=5Fstack+0x118/0x12c
[=C2=A0=C2=A0=C2=A0 0.102479]=C2=A0 =5F=5Fbad=5Fstack+0xc0/0xc4
[=C2=A0=C2=A0=C2=A0 0.102809]=C2=A0 start=5Fkernel+0x26c/0x3d0


Full log: https://termbin.com/yzx6k

Do I need to do anything to reserve stack space for the kernel?

Thanks a lot!

Cheers,
Simao


On Tuesday, November 07, 2023 21:42 CET, Sim=C3=A3o Gomes Viana <devel@=
superboring.dev> wrote:
=C2=A0Hi Simon,
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

=C2=A0
