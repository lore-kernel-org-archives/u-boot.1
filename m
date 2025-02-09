Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFA0C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 19:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 215BE803B5;
	Sun,  9 Feb 2025 20:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Vqj1pPnD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C144807FE; Sun,  9 Feb 2025 20:05:31 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DA4C800B3
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 20:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739127928; x=1739732728; i=xypron.glpk@gmx.de;
 bh=nolqsAUE39LFxD/6hpdxAAWb3QHHUgnwIVo21jo1k1Y=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Vqj1pPnDfPQHce3FpHkBoPd6YZgFyBfwnBVmPt5dEwGnRemWYb0/Lg1elC0VjqFd
 qglROgElG/xZK9ISMJFYgdFQBugYKUmOY9PgsgNCSwQ8NLhj1yvtZXjs67gdrD4Yj
 KIjdhbxfwOByUObtk1B5YtSuxEyCrVQcqUqMpNZtcjIjjl2k5bLnZeLeOEOqv8eTL
 G3THDQL9MYVZxgplrD8QvBfm5KAf8HHwUTfdu93KqGvBLED88Xt1aZMe3TTB5LkoU
 dY7p3cWg6xmUP5f+4eb8nrkgzR3wWxKNhZFvZ5Lczb7uJp8K6/snScnmjZbc+GMQH
 ky2uPkZxzbrr3J96rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.104.145]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC30P-1tXX2D0BOn-00886A; Sun, 09
 Feb 2025 20:05:28 +0100
Date: Sun, 09 Feb 2025 20:05:23 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 07/32] scripts: Update build-efi to support arm64
User-Agent: Thunderbird for Android
In-Reply-To: <20250203174245.1331464-8-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-8-sjg@chromium.org>
Message-ID: <EF141676-AFAA-4E88-925D-D504426DDBCB@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VZAjMuE5X3eJGLtAjAQKbjM/t2Q1c9+v3pR5JHxyAugb5rUm7Hb
 hT47pftuVE1gQh6OIYTOy8s7Qv2e6k7lYATQIIu+xuRdN7yaGWDfQcFyg92VhLrDB3lsrgl
 iVHwUfb+HWj0/SfaVVrWge3V0AEKxYvXJRqOBB37GlPfNS9Hc6BXddOQW5DbTL7n5UiHM9a
 HNhVoMKOjlG4fa6c6uV+A==
UI-OutboundReport: notjunk:1;M01:P0:dBLphd8fc4U=;VbR+M0K/wPTi69h4uSysKVsTKVm
 tB1W3TfrKt7By8EnZN/qYsGuQ0kYVfnbHXPQLcFTntbqiWdXtafs0r++ggbpWIvYFu8LU8KKl
 5gAl/LxuFf4zEwf3sg+fnvvsyqgZAmCuQfoOqWyoi1wwczYKJqlYr4XlWtF/EvaP8l3PXFwFF
 bDEIIRQHBWbDp7a2ypi8IMKYfK7H+E8BAnxTUx9EgV1uukf8byWNJ9mI6eWJar3WP5CFd2eX6
 LQxoTxJyurFiWEYzParg9KAr9q/+Yf8opf0HMgVcU1HMXQNyHeOiNZjLV8AJK0Zwgrg1/ftPe
 p2yFhY6ph4FeDq4mLdRmDwKmfRnWJ7fXO0KUUlaJYwyDOUeI2p0IOqhDfhxb1RvSN7AfCCCBt
 rew48w82MIHdPc3/6P1Jb1bts6w7jdOwmKDyWnOwLTnG07DsyYbKB3KcUBwGcZ5Xv/ZmgaYP4
 dEkSXeJ1DhTEyu1GbGHQ1NFdN4BrKwpVDWaql8OMttqE58aXRp4iILMunRRU4CgcFeDI+/uPP
 BvwJLEy5Z81h7GNgSU6zX3gfx3+bziAoH4aonB1utaN6xknWEfJjwznnnASSd1rzr76ZFvurH
 iH6nEHz7Ve3+oe5IgESq2i3A3B0tbdyxNyft4BEEkHt/KtPNH2ylk4gwHL2KKF7CSHVTqjcy8
 OF4f5JM9X5USKJs+iBg/icOqAPYAjWbnxLvo1mTq2wTW5WH4t9A897jz/wJ9nHQPQHOfzEzSh
 5H2Eq5XTiTQQWat22kWUxdxm6QB+PY4wNQghFWgAwSEsDvaV0t6IqjTCrghMywYygO79yAPUZ
 iWE1tsfm+RYCVYwNQzfEUMSqFMkjZwxQAP5vS75gHQIHcFSpDVF796pPaF/6D/NDRuzQjUAeX
 RVXskB07K6yu8c8CmwqGlyHEs6q7hODEUejDKhxtE9U/D7qDt1KPHZDkAXH+I2MqsoKVbv2xE
 j3RK3yV2VStU0LPk8hTcgLoq8hZv5jTBuwu/BggR8sUcTYTsKV64btW/aGzNNODJdZhsb5o/w
 632rMa6DJ4+bq6J4REc/+XmZGpX6IgDUER2TuXVXPJQE1RAVERZVfIkjsb2sT5C4TjKkcmm94
 OgK0Prhz2s78SQbReg/8qjoU7nZl6HdTSUJG62DSQk/d18MpdAaBxETAQHaqv5VrE9a7mNYOU
 xK0qvwKT7JSfEwke9jSl8Yy4XpRy1hQJaSjkylqW9UJG1yDJ2aUubURVayTF6aDt+r5DqZzQ0
 JsxujQYGWuIQ/1gb3FCjMDzTy5uRWdKpyr0s7fglZ6JnV/lJsAIyILULob4PwCkJokIMeXaaO
 zMKcblSpOESunezR6wqGdjuHWlPqsn13NtuD06Tk61fBca7QwzGvraegOwjaR0tGfN9mvjixj
 0uI/9Isu85v6UYi/Oo1pcCwhxunIx0byoXpp5Vtfsw4Zwk6AfwSOqsbAiQ
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

Am 3=2E Februar 2025 18:42:00 MEZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Provide a -A flag to select ARM instead of x86=2E For now, only the app
>is supported and only for 64-bit ARM=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> scripts/build-efi=2Epy | 49 +++++++++++++++++++++++++++++++-------------
> 1 file changed, 35 insertions(+), 14 deletions(-)
>
>diff --git a/scripts/build-efi=2Epy b/scripts/build-efi=2Epy
>index 3a1bf180ade=2E=2E1ba37e86e88 100755
>--- a/scripts/build-efi=2Epy
>+++ b/scripts/build-efi=2Epy
>@@ -48,6 +48,8 @@ def parse_args():
>         epilog=3D'Script for running U-Boot as an EFI app/payload')
>     parser=2Eadd_argument('-a', '--app', action=3D'store_true',
>                         help=3D'Package up the app')
>+    parser=2Eadd_argument('-A', '--arm', action=3D'store_true',

Why have a flag per EFI architecture?

Please add a parameterized flag instead=2E

--arch i386
--arch x64
--arch arm
--arch aarch64
--arch riscv64

and get rid of the bitness parameter=2E

>+                        help=3D'Run on ARM architecture')
>     parser=2Eadd_argument('-B', '--no-build', action=3D'store_true',
>                         help=3D"Don't build (an existing build must be p=
resent")
>     parser=2Eadd_argument('-k', '--kernel', action=3D'store_true',
>@@ -131,26 +133,43 @@ class BuildEfi:
>         """
>         extra =3D []
>         efi_dir =3D self=2Eget_setting("efi_dir")
>-        if bitness =3D=3D 64:
>-            qemu =3D 'qemu-system-x86_64'
>-            bios =3D 'OVMF-pure-efi=2Ex64=2Efd'
>-        else:
>-            qemu =3D 'qemu-system-i386'
>-            bios =3D 'OVMF-pure-efi=2Ei386=2Efd'
>+        if self=2Eargs=2Earm:
>+            qemu_arch =3D 'aarch64'
>+            extra +=3D ['--machine', 'virt', '-cpu', 'max']
>+            bios =3D os=2Epath=2Ejoin(efi_dir, 'OVMF-pure-efi=2Eaarch64=
=2Efd=2E64m')
>+            var_store =3D os=2Epath=2Ejoin(efi_dir, 'varstore=2Eimg')
>+            extra +=3D [
>+                '-drive', f'if=3Dpflash,format=3Draw,file=3D{bios},reado=
nly=3Don',
>+                '-drive', f'if=3Dpflash,format=3Draw,file=3D{var_store}'
>+                ]
>+            extra +=3D ['-drive',
>+                      f'id=3Dhd0,file=3D{self=2Eimg},if=3Dnone,format=3D=
raw',
>+                      '-device', 'virtio-blk-device,drive=3Dhd0']
>+        else:  # x86
>+            if bitness =3D=3D 64:
>+                qemu_arch =3D 'x86_64'
>+                bios =3D 'OVMF-pure-efi=2Ex64=2Efd'

Not a filename used by EDK II or by QEMU=2E

Best regards

Heinrich

>+            else:
>+                qemu_arch =3D 'i386'
>+                bios =3D 'OVMF-pure-efi=2Ei386=2Efd'
>+            extra +=3D ['-bios', os=2Epath=2Ejoin(efi_dir, bios)]
>+            extra +=3D ['-drive', f'id=3Ddisk,file=3D{self=2Eimg},if=3Dn=
one,format=3Draw']
>+            extra +=3D ['-device', 'ahci,id=3Dahci']
>+            extra +=3D ['-device', 'ide-hd,drive=3Ddisk,bus=3Dahci=2E0']
>+        qemu =3D f'qemu-system-{qemu_arch}'
>         if serial_only:
>-            extra =3D ['-display', 'none', '-serial', 'mon:stdio']
>+            extra +=3D ['-display', 'none', '-serial', 'mon:stdio']
>             serial_msg =3D ' (Ctrl-a x to quit)'
>         else:
>-            extra =3D ['-serial', 'mon:stdio']
>+            if self=2Eargs=2Earm:
>+                extra +=3D ['-device', 'virtio-gpu-pci']
>+            extra +=3D ['-serial', 'mon:stdio']
>             serial_msg =3D ''
>         print(f'Running {qemu}{serial_msg}')
>=20
>         # Use 512MB since U-Boot EFI likes to have 256MB to play with
>-        cmd =3D [qemu, '-bios', os=2Epath=2Ejoin(efi_dir), bios)]
>+        cmd =3D [qemu]
>         cmd +=3D '-m', '512'
>-        cmd +=3D '-drive', f'id=3Ddisk,file=3D{self=2Eimg},if=3Dnone,for=
mat=3Draw'
>-        cmd +=3D '-device', 'ahci,id=3Dahci'
>-        cmd +=3D '-device', 'ide-hd,drive=3Ddisk,bus=3Dahci=2E0'
>         cmd +=3D '-nic', 'none'
>         cmd +=3D extra
>         command=2Erun(*cmd)
>@@ -229,6 +248,7 @@ class BuildEfi:
>                 command=2Eoutput(*cmd)
>             except command=2ECommandExc:
>                 time=2Esleep(0=2E5)
>+                cmd =3D 'sudo', 'kpartx', '-d', self=2Eimg
>                 command=2Eoutput(*cmd)
>=20
>     def do_build(self, build):
>@@ -244,15 +264,16 @@ class BuildEfi:
>         """This does all the work"""
>         args =3D self=2Eargs
>         bitness =3D 32 if args=2Eword else 64
>+        arch =3D 'arm' if args=2Earm else 'x86'
>         build_type =3D 'payload' if args=2Epayload else 'app'
>         self=2Etmp =3D f'{self=2Ebuild_dir}/efi{bitness}{build_type}'
>-        build =3D f'efi-x86_{build_type}{bitness}'
>+        build =3D f'efi-{arch}_{build_type}{bitness}'
>=20
>         if not args=2Eno_build:
>             self=2Edo_build(build)
>=20
>         if args=2Eold and bitness =3D=3D 32:
>-            build =3D f'efi-x86_{build_type}'
>+            build =3D f'efi-{arch}_{build_type}'
>=20
>         self=2Esetup_files(build, build_type)
>=20

