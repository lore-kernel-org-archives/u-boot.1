Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9ABC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 555DE8839C;
	Fri,  7 Jun 2024 20:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="txvsY+Gq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB0F78844F; Fri,  7 Jun 2024 20:08:59 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F62C8839C
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717783728; x=1718388528; i=xypron.glpk@gmx.de;
 bh=1uZ4c4Vwfc9+UuaLFn+ATMSKjMyo4umY2f1lrVh8GXM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=txvsY+GqtVuSfTB1Ok9h0hjebIQVj1pL6jpmnw3C0mYfEECW31Tfe2zJ2QyRQQ+2
 R4dsbZtPm7WfCMqeMKHpFpimsBPQSex4CpkTdDHITZtwSjr4dHYpdwZczjDPiRmVb
 Gzmfd8wuIn4QscRshRwjb6EIcmRn6rzf4TZ379i0KXoJ31jPhct0+JTCj+0QDfHm7
 ewFESDwSFYbyLB4QKV0h/+RGZFKMG+o4ESLz3y56lkeIX9ZILwLHcmStY79JEXU/D
 UVzovwSLRE9Pi/EyXOQ40iXQ/y0Bs0YsaUh9Sb9CrNBzlLWruAr4l9zYpUrsuC2/u
 5cs/60LKx7CPDd7ETA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([109.42.178.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1s0iT815Pq-00W0HB; Fri, 07
 Jun 2024 20:08:48 +0200
Message-ID: <a9253b2b-826e-407c-8066-118fef1a1294@gmx.de>
Date: Fri, 7 Jun 2024 20:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] MIPS: Enable EFI support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WM+A4aLE1KRGeDxpju6WIUyiedHkDgs4UYJUyFQOrFADH47fm6/
 iGScbiaXu9bkDoq3y/qJZKHjXQDjzzX1YqFuWphzCgqhEe5bqQ9Q1lAbVgTyq6CLaWseFS0
 v6JwoKiBp0RWPrW4GB9GjUM2x2FbAvIv84NPP7iXbDdeTYT6L0QOVP+8I1DWktfpqMa9ygy
 7DBb1es5FkXcxulczzY3w==
UI-OutboundReport: notjunk:1;M01:P0:A6+XVQ+8fkA=;APU/GJk1+r3RhHV+CQG+VnpxT2h
 sxbeLzViFy7N7aMcvq2Obo/PREDV5VNuzGb9inCJVoiDZxuokAszsciQzPkGSDUuvo4cQ+eXY
 FKGekpy+jzpcX5iYfI3W4m6o/U/m5+Phr/FRIMwiZBbFAkmL1VNKPf51awh181C0FINHzctjK
 w5r6IOchh0DYBPCYHrO5S7gUBqkKi2el5/lk69JL6uA08aNqyuub9NijK132qVjIQRlbB6Mlv
 nHt08srBXznwqAQkGO3znHMWf9yPPq1oxYSBzIBy9vUPrw8Yy6ecLZTE7rC+LR4lhcBbdsIge
 GIupkdTzLcW6uHpOcfaaR4PDECyGHF9G8onNAKIApep2SiLCaZza2cou5TNYE+65MnzvkFT3u
 kRk3vny3l9U1wv+lIDT3Tf8M4cZH3sdJ8iRU4NrwnagttaiWXuKdkvW4XXxjQnS1eBC1jFICw
 QxM0sYXLmXljXZA4wKr/pKBqtG6q4KxOsryEs44ybUGO19HYxpcMkatG+T7q/p2133VYgZnIS
 w+xO4FrRK+R0WqrZbjHv6cyavEsKFV//ZTPEBxG8JewEQg/1WDmyzJLxvha2nukqi/GR2FPie
 rpZ8hmaefQva28H2D8sWTKZl3kCSxtCNN9xzlSFkoGCy/mYBPOuoj/8oB/Z4f7U2awHQ/caQd
 jyGni19NP2mhuE39bDhewCwxx8goHrDpbFCkriHic0QFO3r/Aaz6Z7yj3IWCSWUtzrVDgQ3B7
 5ZfQKO/RZ+ja2iTNOaiLcVI/iceXOTzFBsoKGSYtoCkBAK/9WY8K64oU2iOLDVvtOETLokCIo
 b0HAqHHZY8yUBUlpSG5wBZxUi36hCathrr7FWui0WU1pI=
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

On 17.05.24 18:32, Jiaxun Yang wrote:
> Hi all,
>
> This series enabled EFI support to MIPS platform.
>
> Although MIPS is not defined by UEFI specification, there are
> quite a few firmware implementations available, including
> MIPS-EFI[1] for Loongson-2F, Lemote's proprietary EDK2 implementation
> on Loongson-3[2], Kunlun firmware for Loongson-3[3], efiffy[4]
> for MIPS Creator CI20 and another mystery EDK implementation shipped
> with some Creator CI20 board.
>
> Available applications including gnu-efi, Loongson's GRUB fork[5],
> Ventoy[6].
>
> My implementation in U-Boot is aiming to follow conventions made
> by other implementations for architecture stuff and remain
> compliance with spec for general aspects.
>
> bootefi hello and selftest passed on both 32 and 64 bit system,
> gnu-efi, grub and ventoy are tested on mips64el with my pending
> platform works. mips32el efi executable from efiffy is tested
> as well.
>
> Please review.
> Thanks
>
> [1]: https://github.com/kontais/EFI-MIPS

Last commit 8 years ago.

> [2]: https://github.com/loongson-community/firmware-nonfree

Last commit 4 years ago.

> [3]: http://www.kunluntech.com.cn/klbiosxl
> [4]: https://sourceforge.net/projects/efify/

Last commit 2018.

> [5]: https://github.com/loongson-community/grub

Last commit 5 year ago.

This looks like riding a dead horse.

Best regards

Heinrich


> [6]: https://www.ventoy.net/en/index.html
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (7):
>        MIPS: Implement setjmp
>        efi: Allow runtime relocate to be disabled
>        Makefile.lib: Preserve .rodata section for EFI file
>        Makefile.lib: Enforce EFI CFLAGS/AFLAGS
>        MIPS: Add smbios_start to arch_global_data
>        MIPS: Define MIPS EFI related bits everywhere
>        MIPS: Implement EFI supporting stuff
>
>   Makefile                                          |   3 +
>   arch/mips/config.mk                               |   9 +
>   arch/mips/include/asm/global_data.h               |   3 +
>   arch/mips/include/asm/setjmp.h                    |  36 ++++
>   arch/mips/lib/Makefile                            |  15 ++
>   arch/mips/lib/crt0_mips_efi.S                     | 239 ++++++++++++++=
++++++++
>   arch/mips/lib/elf_mips_efi.lds                    | 113 ++++++++++
>   arch/mips/lib/reloc_mips_efi.c                    |  99 +++++++++
>   arch/mips/lib/setjmp32.S                          |  51 +++++
>   arch/mips/lib/setjmp64.S                          |  56 +++++
>   include/asm-generic/pe.h                          |   5 +
>   include/config_distro_bootcmd.h                   |   6 +
>   include/efi_default_filename.h                    |   8 +
>   include/efi_loader.h                              |  26 ++-
>   include/elf.h                                     |   8 +
>   lib/efi_loader/Kconfig                            |  12 +-
>   lib/efi_loader/efi_image_loader.c                 |  18 ++
>   lib/efi_loader/efi_memory.c                       |  14 +-
>   lib/efi_loader/efi_runtime.c                      |  11 +-
>   lib/efi_loader/efi_var_mem.c                      |   6 +-
>   lib/efi_selftest/Makefile                         |   2 +-
>   lib/efi_selftest/efi_selftest_miniapp_exception.c |   2 +
>   scripts/Makefile.lib                              |  10 +-
>   23 files changed, 734 insertions(+), 18 deletions(-)
> ---
> base-commit: ad7dce5abd49ef3b5c93da5303e15449c8c162b4
> change-id: 20240517-mips-efi-c9a1ad819c2d
>
> Best regards,

