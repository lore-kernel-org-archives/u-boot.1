Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF89E9410B
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 10:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D49A8420C;
	Fri,  2 Jan 2026 11:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ekrNm148";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C24A84214; Fri,  2 Jan 2026 11:53:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA52284207
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 11:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767351188; x=1767955988; i=xypron.glpk@gmx.de;
 bh=I5QCjQ3hxoJSw3ZSdVKYULgS3KIzw+yRJNBA+T7KFwM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ekrNm148b3tAvdIGu4fsQ/6rBsN2uHmUrSCjN2HU9XPdr/T3vyM4+d7yqSdrzIi8
 RFMKtepcxtUxShQ48raDq2FxpvrwJhuK2BPdZDeDrMOL2xLxdXe0WkX7ziXxUr/YZ
 1cJY9QVwUr2Fq/JVkpkyjDWrR6mE02t0aI7owmHg0f0p5vAq39sXxXADcejc6+GzR
 QNfJxFpSOOsEuh5UOWZV2D0KS6Pko2hvls0I+7SH3Hd421a8XbbQ2s12gVTRyuIG9
 6Pf1Lg2/vL+fLzsSXoC6Fi1NK59BO8FGs3lfZSmRK9fC0ThC5K/77j68UDPetrKhP
 mSn4mGmdvWdfyjqQIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.126] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMbO-1veuZT3Vie-009t68; Fri, 02
 Jan 2026 11:53:07 +0100
Message-ID: <bf0cb1a8-2cdb-4f5a-83e3-a9d1101b9aff@gmx.de>
Date: Fri, 2 Jan 2026 11:53:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Build SPL with -fno-pic
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Nathaniel Hourt <i@nathaniel.land>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
References: <20251215172236.52710-2-me@ziyao.cc>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251215172236.52710-2-me@ziyao.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pzG0qYIkR97TkVDtEwF2bm2t7DElFFr3iwwwmzgSJF74z+z120U
 CJ5MqI/4Xtmvi+kgm5LdrFi2H5JqZMaUlr7dSQ4TC1ammQTRLzuj0my16uvBIiG3Qu/FKtm
 D8H0cjaAuNhMYgzqgSlebdWQSV+ataUggX+CQI61cUg2Md44BN6bmioswflNOKXn/Bi80WL
 +8iehFv3IlFGlrn04HL0g==
UI-OutboundReport: notjunk:1;M01:P0:kZAppL8YxR4=;RJUKynr0JcMUudYkEyx4c10XExn
 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
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

On 12/15/25 18:22, Yao Zi wrote:
> For RISC-V ports, both SPL and proper U-Boot are unconditionally built
> with -fpic, i.e. position-independent code, which means symbols may be
> addressed through GOT. This is useful for proper U-Boot, where we have
> relocate_code in arch/riscv/cpu/start.S and could relocate the GOT
> entries and other .data members to run at any address.
>=20
> But for SPL, there's no self-relocating mechanism, all we could do is
> relying on the linker to fill correct addresses into the binary at link
> time, forming a position-dependent image. This effectively makes the
> GOT, which is generated by usage of -fpic and couldn't be optimized out
> at link time, an unnecessary size burden.

The assumption "for SPL there's no self-relocating mechanism" is wrong.

We can build RISC-V with CONFIG_SPL_RELOC_LOADER=3Dy. And it may make=20
sense to do so if U-Boot SPL is located in flash memory. Please, do not=20
drop this capability.

>=20
> Moreover, our current linkscript for SPL doesn't take .got section into
> account, allowing the linker to put the GOT at unexpected positions,
> like after _end/_image_binary_end symbols. This has caused real-world
> boot failures[1] when SPL is linked by LLD.

Adding the .got section to the linker script would resolve this issue.

Best regards

Heinrich

>=20
> These two reasons make building SPL with -fno-pic good choice,
> eliminating the usage of GOT at the first place. This patch replaces
> -fpic with -fno-pic in PLATFORM_CPPFLAGS when building SPL.
>=20
> We also need to force medany code model for SPL to allow putting the
> executable at any contiguous 4GiB memory range, instead of only the
> lowest and highest 2GiB when using medlow. This wans't an issue
> previously, since GCC ignores -mcmodel=3Dmedlow when -fpic is specified,
> but is problematic with Clang, or without -fpic.
>=20
> Building position-dependent code also produces bss/data/rodata section
> variants with "s" prefix on RISC-V, i.e. sbss/sdata/srodata. These are
> "small" sections which compilers expect to be put together, addressable
> through a single instruction relative to $gp register and thus saving
> code size. This is called GP-relaxation[2]. However, U-Boot takes $gp
> for global data pointer, making it impossible, so these sections are
> merged into their "larger" variants in linkscript.
>=20
> Reported-by: Nathaniel Hourt <i@nathaniel.land>
> Closes: https://lore.kernel.org/all/932979cb47c4fded7ac19216ca172504@nat=
haniel.land/
> Link: https://lore.kernel.org/all/9c0038ed1494e9f293bf4faaf5e66ed8@natha=
niel.land/ # [1]
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>=20
> I've tested the patch with
>=20
> 	starfive_visionfive2_defconfig (StarFive VisionFive2)
> 	sifive_unleashed_defconfig (QEMU -machine sifive_u)
> 	th1520_lpi4a_defconfig (Lichee Pi 4A 16GiB)
>=20
> built with either GCC or Clang, all these ports boot well. When building
> with GCC, this also shrinks SPL of starfive_visionfive2_defconfig by
> 1.5KiB (1%),
>=20
> without patch;
> 	-rw-r--r-- 1 ziyao ziyao 149169 Dec 15 11:56 u-boot-spl.bin
>=20
> with patch:
> 	-rw-r--r-- 1 ziyao ziyao 147731 Dec 15 11:57 u-boot-spl.bin
>=20
> This is a relatively large change to RISC-V SPL, so I'm willing to wait
> for some time for more comments and wider testing. Thanks for your time!
>=20
>   arch/riscv/Makefile           | 5 ++++-
>   arch/riscv/config.mk          | 8 +++++++-
>   arch/riscv/cpu/u-boot-spl.lds | 3 +++
>   3 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index fdda6da1df32..90d98eaba6bc 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -32,13 +32,16 @@ endif
>   ifeq ($(CONFIG_RISCV_ISA_ZBB),y)
>   	ARCH_ZBB =3D _zbb
>   endif
> +ifeq ($(CONFIG_XPL_BUILD),y)
> +	CMODEL =3D medany
> +else
>   ifeq ($(CONFIG_CMODEL_MEDLOW),y)
>   	CMODEL =3D medlow
>   endif
>   ifeq ($(CONFIG_CMODEL_MEDANY),y)
>   	CMODEL =3D medany
>   endif
> -
> +endif
>  =20
>   RISCV_MARCH =3D $(ARCH_BASE)$(ARCH_A)$(ARCH_F)$(ARCH_D)$(ARCH_C)$(ARCH=
_ZBB)
>   ABI =3D $(ABI_BASE)$(ABI_D)
> diff --git a/arch/riscv/config.mk b/arch/riscv/config.mk
> index eddd6a3b9a29..4d6fd7434171 100644
> --- a/arch/riscv/config.mk
> +++ b/arch/riscv/config.mk
> @@ -35,7 +35,13 @@ EFI_LDS			:=3D elf_riscv64_efi.lds
>   PLATFORM_ELFFLAGS	+=3D -B riscv -O elf64-$(large-endian)riscv
>   endif
>  =20
> -PLATFORM_CPPFLAGS	+=3D -ffixed-x3 -fpic
> +ifdef CONFIG_XPL_BUILD
> +PLATFORM_CPPFLAGS	+=3D -fno-pic
> +else
> +PLATFORM_CPPFLAGS	+=3D -fpic
> +endif
> +
> +PLATFORM_CPPFLAGS	+=3D -ffixed-x3
>   PLATFORM_RELFLAGS	+=3D -fno-common -ffunction-sections -fdata-sections
>   LDFLAGS_u-boot		+=3D --gc-sections -static -pie
>  =20
> diff --git a/arch/riscv/cpu/u-boot-spl.lds b/arch/riscv/cpu/u-boot-spl.l=
ds
> index 0717833df556..dc028702a5d8 100644
> --- a/arch/riscv/cpu/u-boot-spl.lds
> +++ b/arch/riscv/cpu/u-boot-spl.lds
> @@ -25,11 +25,13 @@ SECTIONS
>   	. =3D ALIGN(4);
>   	.rodata : {
>   		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
> +		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.srodata*)))
>   	} > .spl_mem
>  =20
>   	. =3D ALIGN(4);
>   	.data : {
>   		*(.data*)
> +		*(.sdata*)
>   	} > .spl_mem
>   	. =3D ALIGN(4);
>  =20
> @@ -52,6 +54,7 @@ SECTIONS
>   	.bss : {
>   		__bss_start =3D .;
>   		*(.bss*)
> +		*(.sbss*)
>   		. =3D ALIGN(8);
>   		__bss_end =3D .;
>   	} > .bss_mem

