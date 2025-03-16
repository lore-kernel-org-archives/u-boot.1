Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2B1C282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 05:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E8868082A;
	Sun, 16 Mar 2025 06:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dIFG2Pb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D97DD8091A; Sun, 16 Mar 2025 06:27:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A498058A
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 06:27:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1742102838; x=1742707638; i=xypron.glpk@gmx.de;
 bh=e0YACZ/ggJQLorT9Ufk+vDRJbPbusqiv06TCYyVlONw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=dIFG2Pb2v5exAIs7L1mm5/8YEE/gzv/VwBlewhcxgZs4hHiLyVWitxnahmRZGUBY
 /JvsTx93w9yBXyCRFdWVQTaRXbP6Y85O7BXd5wAxeUJqkkB8MEFU3PKyJGhkSJy3O
 8phn/RIWJOpildiewprruqL6nE9bpT5YXcCck9fYbzFUIvXbgFEyT5/IL6oS73b9x
 yMPE1jPwGRWAy7e/Q2gbj1XO0a7EG8JmoxT5j/KwiUSKJyY0m3OYPSV4yRoKOxSki
 e23NlzEz4V98dzphGl/9FbZjBmpWaAsvD4yqVlqLYeSsuN3fc/pt7dHr0Qk93r2ku
 8bj5KfoD3ZvVbrVXzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.92.224.94]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fMe-1tqxlk0C3m-001vmv; Sun, 16
 Mar 2025 06:27:18 +0100
Date: Sun, 16 Mar 2025 06:27:14 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Sam Edwards <cfsworks@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_00/15=5D_Various_toolch?=
 =?US-ASCII?Q?ain_compatibility_fixes/improvements?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250315221813.1265193-1-CFSworks@gmail.com>
References: <20250315221813.1265193-1-CFSworks@gmail.com>
Message-ID: <ACC5355E-F949-42BD-8BDC-C2C8C740DB34@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kSHxzBZGhpxSUkC6u3Y3sk8YqpdzHEYs13Q+7o7dFc9IH416+Tu
 1R92xyIEQe+2qRtzOft1R5LIqpyPIgom6Xk/RS/arnyChEe0x69LZsGaBcfyQooWUZg/vsQ
 zltXPqG4AjEu0zgzK25rSGg5ICfQCWdk4V6Xlbt4Dzgi0/yuX5BVfUPjKkXZOOwy071K1og
 +x5BFjKHodlWmrZavnBqA==
UI-OutboundReport: notjunk:1;M01:P0:MOYovg/xLUU=;ZfJXRbY2t6ILeLkQf+KB9BKR7Uf
 X4koaE8ByVciXCLzuVkKeHhH4wN7+LIGiLVRKTF6ddj/nAWoDwLpNaiXnTc/UJzpQFgxDBTQC
 KZ9TkvIudD+dxWwWWvGQnjxPHA4LjI0DNCj+MfGsiRuPNbZpiYYvtTZwg+cM9dblyYy2x/RAk
 8SkAOJKkTa9EmvMbCdiaYhumKo9N0cmU9i7FHUlCczkXwSkLIxEPVsBo365fC48ZBRa7ItoSm
 lfKfJNvCTPPKDpBQglgWONOJ3x524zDtbnA1zNQwumDdvIhU11+pX4YMzqNzHQ74sWZ/uTBwc
 4PhA5ph0piKJs8x16W47O//BIya9iGbboX28/t8/dukdACjrd08K+rGWaQ6g+sL/YpN+jh85b
 UFeaUcBtJc2acHlU/ZJVVOvWRHdJhTjkJDtpa9xb1IUCEvGyya37rL68fFRdNW6YZ5u6quSzj
 gwnQw3i2b3HY5gLn1CjD+L90tpvGUjXd7lVln+LyeziOoVR6UkKcuEcSSt1ERU+pt5mqqIMiv
 OhYVtJ8mD3Agur+SpNDKTdCVHDTaWcmJVHSaRyC9Wyqq70sFYMxInXw11kfzbg+PblCIftvhX
 ydsbtpovaXAuZYiyVYAkNcdsjFYW70C4wkYhWZkHCxwTRyskxs8HuSu2PGQ7/6s3eI3PVUFaK
 xz37d4qQXKmas934IntNoI59LANJuMzKTY1Y5PdOv3FZSeWJ36h6Kc3xGO+bhtIuccw0+JByF
 LpoprpW8pBNC3jm3ixD5aMkXpo5AaL4nGggd++hvrrjspEhHPke4CQoOIMsbN+YwbYllernfi
 VScqKi56OvJdOFNLuEHc/kHft/ZxOvotVbKA6aagRqb1DSYPfU+9X93kD+qDILr+4egypq/Yk
 n9xESKIvUxS119pwgF4MuNDveJgXBJ1ld9zWLFihJxqITCvx0mfRcoUIigS5q6VW2MLtMy7+9
 CozNVC6Etg+N7R1Y4w1KT2jB5VSH1Zw5KWzqhBbRSpWQDUSLXUh6Ti3Iq6EvtER01Id9/2T01
 /GMAI0DpeYuC987c9Vyhua51c1wXJVGUDdn/n+84FY7jxuvm8g0M3G5XJdIwyVosvNgLirK4N
 PIQ6wA66zo8uheh8rjBOelyisY5S+ofwofEkT8WWPQW//c9Oe+I6oP30RecGvFUFIXeIq6fig
 KvQ+hrKlPDqn0IZ0eJNRFrttwF30kDKAroNvlRoFWyENzpZQXjFgf2JnviK9clkf1kbsVCLa5
 ouQ3F63mwLE6BWgUrMRuGuF6/7dJzKJp97XElhZZ/vn6ZgFN0dCQCYirnQ9Q0LLUpBGwzlHfE
 GLzixgwLSpJICeAOBEenF5/G3/a+6mg8YUNh1T7YCMGtqzCquEIKvjfF3Ny8oRfXUntu+0qyz
 N+RW4RYO6pwxRaj4PheTw5FCedEEosMm5abdLbLVIQS5/yhyCP4zJiz8zgqLkomhYFm3LTmpL
 e5NmOVA==
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

Am 15=2E M=C3=A4rz 2025 23:17:58 MEZ schrieb Sam Edwards <cfsworks@gmail=2E=
com>:
>Hello again U-Boot list,
>
>This is v2 of my "misc=2E fixes" series, sent to prepare the codebase for=
 more
>direct LLVM support in the near future=2E This series contains several fi=
xes that
>I found in the process of preparing that support and which address issues
>independent of any future feature or enhancement=2E I am sending these no=
w, both
>so that their inclusion is not delayed by discussion on my upcoming serie=
s and
>to make the latter more manageable=2E
>
>PLEASE APPLY PARTIALLY! I have tried to sort these so that the most
>straightforward changes come first=2E If any patch proves contentious, yo=
u can
>either skip it or stop applying the series at that point=2E Any patches t=
hat need
>revisions will be included in a future series, but I'm trying to avoid th=
ere
>being a v3 of *this* series=2E :)
>
>Happy Saturday,
>Sam

Hello Sam,

I wonder why there are only ARM and X86 specific patches in this series =
=2E Wouldn't some of the changes also be needed for RISC-V and other archit=
ectures?

For EFI we have carved out a linker script include file to harmonize the l=
inker scripts used by ARM and RISC-V=2E Shouldn't we do the same for main U=
-Boot?

Best regards

Heinrich

>
>Changes v1->v2:
>- Carried forward acked/reviewed tags
>- Dropped two patches (one was incorrect, the other can be fixed differen=
tly)
>- Minor phrasing changes to commit messages
>- Instead of removing `ENTRY(_start)`, I instead added `=2Eglobl _start` =
where
>  appropriate, in the EFI apps
>
>Sam Edwards (15):
>  arm: Remove stray =2Emmutable reference in linker script
>  arm: Exclude eabi_compat from LTO
>  arm: Add __aeabi_memclr in eabi_compat
>  arm: Add aligned-memory aliases to eabi_compat
>  arm: Discard unwanted sections in linker script
>  arm: Replace 'adrl' in EFI crt0
>  x86: Fix call64's section flags
>  makefile: Avoid objcopy --gap-fill for =2Ehex/=2Esrec
>  makefile: Add `norelro` linker option
>  makefile: Add READELF command variable
>  arm: riscv: efi: Export _start symbol from crt0_*_efi stubs
>  efi_loader: Move =2Edynamic out of =2Etext in EFI
>  scripts/Makefile=2Elib: efi: Preserve the =2Edynstr section as well
>  spl: riscv: opensbi: Error on misaligned FDT
>  spl: Align FDT load address
>
> Makefile                        | 14 ++++++++------
> arch/arm/cpu/u-boot=2Elds         | 29 ++++++++++-------------------
> arch/arm/lib/Makefile           |  1 +
> arch/arm/lib/crt0_aarch64_efi=2ES |  1 +
> arch/arm/lib/crt0_arm_efi=2ES     |  4 +++-
> arch/arm/lib/eabi_compat=2Ec      | 17 +++++++++++++++++
> arch/riscv/lib/crt0_riscv_efi=2ES |  1 +
> arch/x86/cpu/i386/call64=2ES      |  2 +-
> common/spl/spl_fit=2Ec            |  2 +-
> common/spl/spl_opensbi=2Ec        |  5 +++++
> lib/efi_loader/elf_efi=2Eldsi     |  6 +++---
> scripts/Makefile=2Elib            |  4 ++--
> 12 files changed, 53 insertions(+), 33 deletions(-)
>

