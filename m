Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9146CC36002
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 00:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38A6F819B1;
	Tue, 25 Mar 2025 01:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="okSBouVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 153F580EEF; Mon, 24 Mar 2025 18:51:24 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746E080548
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 18:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1742838630; x=1743443430; i=xypron.glpk@gmx.de;
 bh=Qx4B6wm4bfj0k9vOM1XsJ+RRp02TRWnyAaBUbcckkes=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=okSBouVuimHIfbJJvtuk89VCwSwSdvveRITKvh2YR1FK0lLDuLUf8Pmhlzt1PFam
 HzEsuOqlTcOarpX6co5NcBYQLvuNsXyFLhdmleV4vc9ncfDZhl9Bg9LR1ve3Gb0QE
 fpX0dHd2LVtRfnGYRaZAmKXmgEohfcrNH021agAQWEwwLZRejYrAG1r5dnZ/AmbrA
 XN6muZxCbHuXSJAyq5OI+zVV4+aLOzhk6imNoSVbmsVkoVb9+j/mJ5lih+dhAKuA/
 caw3mE7bIjnSLCeSkXBir7JnZhUSeNWrd7EfuNVHAMtvhS4eG25pbE5BYho7JXcNO
 6pgd/zlUYtUkGYaSNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1szbZd1rfn-00sd3j; Mon, 24
 Mar 2025 18:50:30 +0100
Message-ID: <380f1f2c-59cd-4c52-a598-5e6f1ed1dcad@gmx.de>
Date: Mon, 24 Mar 2025 18:50:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: remove EFI_BOUNCE_BUFFER
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: e@freeshell.de, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tang Yuantian <andy.tang@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Udit Agarwal <udit.agarwal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Manish Tomar <Manish.Tomar@nxp.com>, Mathew McBride <matt@traverse.com.au>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Sumit Garg <sumit.garg@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Robert Marko <robert.marko@sartura.hr>,
 Lukas Funke <lukas.funke@weidmueller.com>, Peng Fan <peng.fan@nxp.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>, Maks Mishin <maks.mishinfz@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com,
 Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20250317133845.138061-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250317133845.138061-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k6U/0KwRV/2YDtVzRWbW42pyOb5J2Vqo6OgOs75Ix5Ij9BmHGHB
 pIigmgeRuk9+5Fk2cDmDtxrQ3GRrB9Tyi8n7LZp9Cm7dopLlaeEHu9f9wklHg2oAxW8P3VS
 9ww1u/K0CenxUAtstn5vcOX+OxPT0aRaEWYpDzRrgRsH5iqCjiOR1z3bpjG1VuHormQ3qkB
 mQAVCFP9QUCyNSOU3v+PA==
UI-OutboundReport: notjunk:1;M01:P0:zNe0lvPJj8w=;//i+JWRhH7Ei5w/iSTxJdO7h/YJ
 vW/ZQBp5xEcNuztp26hmm7iemPDFjb366JqUeMstZcY1JS8cbtG81PXWm0EHhb8xNNr50yx0e
 wPQCkHEPi4eVk25/0lB4pcko1gOXL7eiwlF1Fk9zTzde2XaNi2mVQ76V8rKXzi4reENlW/MmY
 hW01Gq1NNTkWULV03OVx2w0p0Xqu33YoTf0zR1zzgMSGz0+xghiCmythI91hK3PvNJHt+3DAi
 Dtzwpgs7BOShj4Rfjldt8S4Q4CzQVtR2/o1tEDTvfptPZhIvv1W0DRquJ1h3sIObdnZXXOrQo
 HLYqxV0jK/PIexyawsDbYercVI0fEJPFo8/JXTcCXkeRP+IZOfT50dxR9nfaBbJxeGwPcJMjC
 gJYUdZVaWhJnSaS5ngSp9oOJWphf7hJVf/ptMhPe4Vh8cvFpKlY5JdJbSfq5SOoMbOxKE1ycR
 v82UZadoPfRvM2esxeUpaHosNcpTekjv3tb/qdULnTFgfSDcqQ3fPQ77cn8uhQosaSWlxdwCu
 BSNxwJ+VjGRSmEjpkMUWQIulfoBLkmnqMWG6TqwVHFPPPn94IL7Jbrkt8fpp9wZO+Lpw9Kmn3
 faYGjpeQrklZjWbI1FGyReevIkuVEAunNfTjWnB6qxb79od8ag0lx2W/VSufdvJlNvzBapyU2
 nmwjBha/WvWQ1IsuOTZtXO2eSTMu8xdByhZxYtuC7oHsAmRXW8+869lVlC0LOXnXMhbekZU9p
 wafQwWUKgTfiPrzpd5JUSnTwXDwQsmkcIZLDJTgbgmqnMtTnM3Q5wnhJTLPnl8yc0Heg5f2t7
 9K/vZs4jKYrCn3h+mxEempiIF1VmePIRJfpXqIk/7yIDnyPOj/KiwcftoH2Bl6jypRrQ5mBix
 nKFePn+t9BqMFdRMJzuDknO6IyBDCDdMmcKoQt6ZXQXcS+aRoC0r+jL7NUVU4O59ro/derGOV
 NKPAlSrK/Bx86gIGP+bxnY4Efbsi1E/tvn5+ZXG2T88e5a4QnkKiNVKHXIxwZ4AUmgtW4gaSG
 GBVhFWq02f1DLu5OylcIVLtp7JcdpN81idV9mZb64QIRATmhmzXOP9t3LBkttYjBFfU7sv5Xo
 Rvpwwine+iNnw2/gw+TZeBqFgsmSmC+Y+HLBbHqJO1cgwNjC6eZAmBXgpSQ3a159u8B4QJNi0
 UhVxpPaPJxV1rWlEwHJWhSdG9YUcW9+vkSJ9xW4m2xxCSrXZK8P8W0jq7z1Xe2qKkk/TX2dY1
 IWwxeISSxsHM13bTDJZbh3tZYmQMPEZU/T0CS/R5i1MVS2+oDAAiHEwnNRn4GGwNWtAdKVM3z
 L6VreKBRRZLfyndn5uM37ouPhSJ/H2ZZKJOAcdNFYcrfxquBBWhEIinX7hcM/f4HAPXYg8pmf
 G9HpwvU9uO12cK5Gy8BG5HW+bfGFRiOWzeBHc7bpg1wRo3ZoPcoCyvF0bu59UIWixdT/DkjlO
 CGaDYcM30joSOv9P/5wpYVMsFNs0=
X-Mailman-Approved-At: Tue, 25 Mar 2025 01:35:45 +0100
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

On 17.03.25 14:38, Ilias Apalodimas wrote:

%s/EFI_BOUNCE_BUFFER/CONFIG_EFI_LOADER_BOUNCE_BUFFER/

> The EFI subsystem defines its own bounce buffer for devices that
> can't transfer data > 4GB. U-Boot already has a generic BOUNCE_BUFFER
> which can be reused instead of defining another symbol.
> The only limitation for EFI is that we don't know how big the file a use=
r
> chooses to transfer is and as a result we can't depend on allocating the
> memory from the malloc area, which can prove too small.
>
> So allocate an EFI buffer of the correct size and pass it to the DM,
> which already supports bounce buffering via bounce_buffer_start_extalign=
()

Looking at

     if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && desc->bb) {

in drivers/block/blk-uclass.c the bounce buffer has to be explicitly
enabled by the device driver. Only the scsi drivers sets bb =3D true.

Cf. 81bd22e935dc ("rockchip: block: blk-uclass: add bounce buffer flag
to blk_desc")

Which device-drivers of the boards mentioned below do actually need
bounce buffering?

Best regards

Heinrich

>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   arch/arm/Kconfig                              |  8 ++
>   configs/ls1028aqds_tfa_SECURE_BOOT_defconfig  |  1 -
>   configs/ls1028aqds_tfa_defconfig              |  1 -
>   configs/ls1028aqds_tfa_lpuart_defconfig       |  1 -
>   configs/ls1028ardb_tfa_SECURE_BOOT_defconfig  |  1 -
>   configs/ls1028ardb_tfa_defconfig              |  1 -
>   configs/ls1043ardb_tfa_SECURE_BOOT_defconfig  |  1 -
>   configs/ls1043ardb_tfa_defconfig              |  1 -
>   configs/ls1046ardb_tfa_SECURE_BOOT_defconfig  |  1 -
>   configs/ls1046ardb_tfa_defconfig              |  1 -
>   configs/ls1088aqds_tfa_defconfig              |  1 -
>   configs/ls1088ardb_tfa_SECURE_BOOT_defconfig  |  1 -
>   configs/ls1088ardb_tfa_defconfig              |  1 -
>   configs/ls2088aqds_tfa_defconfig              |  1 -
>   configs/ls2088ardb_tfa_SECURE_BOOT_defconfig  |  1 -
>   configs/ls2088ardb_tfa_defconfig              |  1 -
>   configs/lx2160aqds_tfa_SECURE_BOOT_defconfig  |  1 -
>   configs/lx2160aqds_tfa_defconfig              |  1 -
>   configs/lx2160ardb_tfa_SECURE_BOOT_defconfig  |  1 -
>   configs/lx2160ardb_tfa_defconfig              |  1 -
>   configs/lx2160ardb_tfa_stmm_defconfig         |  1 -
>   configs/lx2162aqds_tfa_SECURE_BOOT_defconfig  |  1 -
>   configs/lx2162aqds_tfa_defconfig              |  1 -
>   .../lx2162aqds_tfa_verified_boot_defconfig    |  1 -
>   configs/ten64_tfa_defconfig                   |  1 -
>   include/efi_loader.h                          |  4 -
>   lib/efi_loader/Kconfig                        |  7 --
>   lib/efi_loader/efi_disk.c                     | 78 +++++++------------
>   lib/efi_loader/efi_memory.c                   | 16 ----
>   29 files changed, 36 insertions(+), 101 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cf08fe63f1e7..bb946e69254c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1417,6 +1417,7 @@ config TARGET_LS2080A_EMU
>   	select ARCH_LS2080A
>   	select ARM64
>   	select ARMV8_MULTIENTRY
> +	select BOUNCE_BUFFER
>   	select FSL_DDR_SYNC_REFRESH
>   	select GPIO_EXTRA_HEADER
>   	help
> @@ -1432,6 +1433,7 @@ config TARGET_LS1088AQDS
>   	select ARMV8_MULTIENTRY
>   	select ARCH_SUPPORT_TFABOOT
>   	select BOARD_LATE_INIT
> +	select BOUNCE_BUFFER
>   	select GPIO_EXTRA_HEADER
>   	select SUPPORT_SPL
>   	select FSL_DDR_INTERACTIVE if !SD_BOOT
> @@ -1448,6 +1450,7 @@ config TARGET_LS2080AQDS
>   	select ARMV8_MULTIENTRY
>   	select ARCH_SUPPORT_TFABOOT
>   	select BOARD_LATE_INIT
> +	select BOUNCE_BUFFER
>   	select GPIO_EXTRA_HEADER
>   	select SUPPORT_SPL
>   	imply SCSI
> @@ -1467,6 +1470,7 @@ config TARGET_LS2080ARDB
>   	select ARMV8_MULTIENTRY
>   	select ARCH_SUPPORT_TFABOOT
>   	select BOARD_LATE_INIT
> +	select BOUNCE_BUFFER
>   	select SUPPORT_SPL
>   	select FSL_DDR_BIST
>   	select FSL_DDR_INTERACTIVE if !SPL
> @@ -1485,6 +1489,7 @@ config TARGET_LS2081ARDB
>   	select ARM64
>   	select ARMV8_MULTIENTRY
>   	select BOARD_LATE_INIT
> +	select BOUNCE_BUFFER
>   	select GPIO_EXTRA_HEADER
>   	select SUPPORT_SPL
>   	help
> @@ -1500,6 +1505,7 @@ config TARGET_LX2160ARDB
>   	select ARMV8_MULTIENTRY
>   	select ARCH_SUPPORT_TFABOOT
>   	select BOARD_LATE_INIT
> +	select BOUNCE_BUFFER
>   	select GPIO_EXTRA_HEADER
>   	help
>   	  Support for NXP LX2160ARDB platform.
> @@ -1514,6 +1520,7 @@ config TARGET_LX2160AQDS
>   	select ARMV8_MULTIENTRY
>   	select ARCH_SUPPORT_TFABOOT
>   	select BOARD_LATE_INIT
> +	select BOUNCE_BUFFER
>   	select GPIO_EXTRA_HEADER
>   	help
>   	  Support for NXP LX2160AQDS platform.
> @@ -1529,6 +1536,7 @@ config TARGET_LX2162AQDS
>   	select ARMV8_MULTIENTRY
>   	select ARCH_SUPPORT_TFABOOT
>   	select BOARD_LATE_INIT
> +	select BOUNCE_BUFFER
>   	select GPIO_EXTRA_HEADER
>   	help
>   	  Support for NXP LX2162AQDS platform.
> diff --git a/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig b/configs/ls10=
28aqds_tfa_SECURE_BOOT_defconfig
> index 97eb7d9dca4c..e3b1018f6f8e 100644
> --- a/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
> +++ b/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
> @@ -23,7 +23,6 @@ CONFIG_SYS_MEMTEST_START=3D0x80000000
>   CONFIG_SYS_MEMTEST_END=3D0x9fffffff
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_DISTRO_DEFAULTS=3Dy
>   CONFIG_BOOTDELAY=3D10
> diff --git a/configs/ls1028aqds_tfa_defconfig b/configs/ls1028aqds_tfa_d=
efconfig
> index cc53c17f543b..5b7dd4bf7dd5 100644
> --- a/configs/ls1028aqds_tfa_defconfig
> +++ b/configs/ls1028aqds_tfa_defconfig
> @@ -25,7 +25,6 @@ CONFIG_SYS_MEMTEST_START=3D0x80000000
>   CONFIG_SYS_MEMTEST_END=3D0x9fffffff
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_DISTRO_DEFAULTS=3Dy
>   CONFIG_BOOTDELAY=3D10
> diff --git a/configs/ls1028aqds_tfa_lpuart_defconfig b/configs/ls1028aqd=
s_tfa_lpuart_defconfig
> index 8da7271c7f85..a38c81e83199 100644
> --- a/configs/ls1028aqds_tfa_lpuart_defconfig
> +++ b/configs/ls1028aqds_tfa_lpuart_defconfig
> @@ -24,7 +24,6 @@ CONFIG_SYS_MEMTEST_START=3D0x80000000
>   CONFIG_SYS_MEMTEST_END=3D0x9fffffff
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_DISTRO_DEFAULTS=3Dy
>   CONFIG_BOOTDELAY=3D10
> diff --git a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig b/configs/ls10=
28ardb_tfa_SECURE_BOOT_defconfig
> index 3f71a37559be..da225e1dad8f 100644
> --- a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
> +++ b/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
> @@ -23,7 +23,6 @@ CONFIG_SYS_MEMTEST_START=3D0x80000000
>   CONFIG_SYS_MEMTEST_END=3D0x9fffffff
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_DISTRO_DEFAULTS=3Dy
>   CONFIG_BOOTDELAY=3D10
> diff --git a/configs/ls1028ardb_tfa_defconfig b/configs/ls1028ardb_tfa_d=
efconfig
> index 89e452bdb1a8..829cc5204d34 100644
> --- a/configs/ls1028ardb_tfa_defconfig
> +++ b/configs/ls1028ardb_tfa_defconfig
> @@ -25,7 +25,6 @@ CONFIG_SYS_MEMTEST_START=3D0x80000000
>   CONFIG_SYS_MEMTEST_END=3D0x9fffffff
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_DISTRO_DEFAULTS=3Dy
>   CONFIG_BOOTDELAY=3D10
> diff --git a/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig b/configs/ls10=
43ardb_tfa_SECURE_BOOT_defconfig
> index 1b41fe608dae..04ca2a3afd81 100644
> --- a/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
> +++ b/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
> @@ -24,7 +24,6 @@ CONFIG_PCIE2=3Dy
>   CONFIG_PCIE3=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_DISTRO_DEFAULTS=3Dy
>   CONFIG_BOOTDELAY=3D10
> diff --git a/configs/ls1043ardb_tfa_defconfig b/configs/ls1043ardb_tfa_d=
efconfig
> index ca100bd4bca9..a6ca63cd8f79 100644
> --- a/configs/ls1043ardb_tfa_defconfig
> +++ b/configs/ls1043ardb_tfa_defconfig
> @@ -26,7 +26,6 @@ CONFIG_PCIE2=3Dy
>   CONFIG_PCIE3=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_DISTRO_DEFAULTS=3Dy
>   CONFIG_BOOTDELAY=3D10
> diff --git a/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig b/configs/ls10=
46ardb_tfa_SECURE_BOOT_defconfig
> index 6b4e834ad4a0..9c22d542a6f8 100644
> --- a/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
> +++ b/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
> @@ -24,7 +24,6 @@ CONFIG_PCIE2=3Dy
>   CONFIG_PCIE3=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_DISTRO_DEFAULTS=3Dy
>   CONFIG_BOOTDELAY=3D10
> diff --git a/configs/ls1046ardb_tfa_defconfig b/configs/ls1046ardb_tfa_d=
efconfig
> index a8f20f9b87b7..4eab8ea19e8e 100644
> --- a/configs/ls1046ardb_tfa_defconfig
> +++ b/configs/ls1046ardb_tfa_defconfig
> @@ -26,7 +26,6 @@ CONFIG_PCIE2=3Dy
>   CONFIG_PCIE3=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_DISTRO_DEFAULTS=3Dy
>   CONFIG_BOOTDELAY=3D10
> diff --git a/configs/ls1088aqds_tfa_defconfig b/configs/ls1088aqds_tfa_d=
efconfig
> index df86bf982ee4..31d56f587af8 100644
> --- a/configs/ls1088aqds_tfa_defconfig
> +++ b/configs/ls1088aqds_tfa_defconfig
> @@ -29,7 +29,6 @@ CONFIG_SYS_MEMTEST_END=3D0x9fffffff
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
>   CONFIG_DYNAMIC_SYS_CLK_FREQ=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_DISTRO_DEFAULTS=3Dy
>   CONFIG_OF_BOARD_SETUP=3Dy
> diff --git a/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig b/configs/ls10=
88ardb_tfa_SECURE_BOOT_defconfig
> index df472eeb404d..c910b73634f9 100644
> --- a/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
> +++ b/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
> @@ -26,7 +26,6 @@ CONFIG_SYS_MEMTEST_START=3D0x80000000
>   CONFIG_SYS_MEMTEST_END=3D0x9fffffff
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_DISTRO_DEFAULTS=3Dy
>   CONFIG_OF_BOARD_SETUP=3Dy
> diff --git a/configs/ls1088ardb_tfa_defconfig b/configs/ls1088ardb_tfa_d=
efconfig
> index 8d640f6594b2..682007e803d1 100644
> --- a/configs/ls1088ardb_tfa_defconfig
> +++ b/configs/ls1088ardb_tfa_defconfig
> @@ -28,7 +28,6 @@ CONFIG_SYS_MEMTEST_START=3D0x80000000
>   CONFIG_SYS_MEMTEST_END=3D0x9fffffff
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_DISTRO_DEFAULTS=3Dy
>   CONFIG_OF_BOARD_SETUP=3Dy
> diff --git a/configs/ls2088aqds_tfa_defconfig b/configs/ls2088aqds_tfa_d=
efconfig
> index 8c86b8b11eb3..ea73a4cda971 100644
> --- a/configs/ls2088aqds_tfa_defconfig
> +++ b/configs/ls2088aqds_tfa_defconfig
> @@ -23,7 +23,6 @@ CONFIG_FSL_QIXIS=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
>   CONFIG_DYNAMIC_SYS_CLK_FREQ=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_BOOTDELAY=3D10
>   CONFIG_OF_BOARD_SETUP=3Dy
> diff --git a/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig b/configs/ls20=
88ardb_tfa_SECURE_BOOT_defconfig
> index 3fd1de967896..7f53397cdcb1 100644
> --- a/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
> +++ b/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
> @@ -27,7 +27,6 @@ CONFIG_FSL_QIXIS=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
>   CONFIG_DYNAMIC_SYS_CLK_FREQ=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_BOOTDELAY=3D10
>   CONFIG_OF_BOARD_SETUP=3Dy
> diff --git a/configs/ls2088ardb_tfa_defconfig b/configs/ls2088ardb_tfa_d=
efconfig
> index f053044fa56e..398dfe068015 100644
> --- a/configs/ls2088ardb_tfa_defconfig
> +++ b/configs/ls2088ardb_tfa_defconfig
> @@ -29,7 +29,6 @@ CONFIG_FSL_QIXIS=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
>   CONFIG_DYNAMIC_SYS_CLK_FREQ=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_BOOTDELAY=3D10
>   CONFIG_OF_BOARD_SETUP=3Dy
> diff --git a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig b/configs/lx21=
60aqds_tfa_SECURE_BOOT_defconfig
> index 321ed71993b8..afb842978209 100644
> --- a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
> +++ b/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
> @@ -28,7 +28,6 @@ CONFIG_FSL_QIXIS=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
>   CONFIG_DYNAMIC_SYS_CLK_FREQ=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_OF_BOARD_SETUP=3Dy
>   CONFIG_OF_STDOUT_VIA_ALIAS=3Dy
> diff --git a/configs/lx2160aqds_tfa_defconfig b/configs/lx2160aqds_tfa_d=
efconfig
> index 465f07ee7f82..ec23ed384c44 100644
> --- a/configs/lx2160aqds_tfa_defconfig
> +++ b/configs/lx2160aqds_tfa_defconfig
> @@ -30,7 +30,6 @@ CONFIG_FSL_QIXIS=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
>   CONFIG_DYNAMIC_SYS_CLK_FREQ=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_BOOTDELAY=3D10
>   CONFIG_OF_BOARD_SETUP=3Dy
> diff --git a/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig b/configs/lx21=
60ardb_tfa_SECURE_BOOT_defconfig
> index 478a01b566c6..71f4436eca06 100644
> --- a/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
> +++ b/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
> @@ -29,7 +29,6 @@ CONFIG_FSL_QIXIS=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
>   CONFIG_DYNAMIC_SYS_CLK_FREQ=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_OF_BOARD_SETUP=3Dy
>   CONFIG_OF_STDOUT_VIA_ALIAS=3Dy
> diff --git a/configs/lx2160ardb_tfa_defconfig b/configs/lx2160ardb_tfa_d=
efconfig
> index 8fd18825569c..6be3890de3ed 100644
> --- a/configs/lx2160ardb_tfa_defconfig
> +++ b/configs/lx2160ardb_tfa_defconfig
> @@ -31,7 +31,6 @@ CONFIG_FSL_QIXIS=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
>   CONFIG_DYNAMIC_SYS_CLK_FREQ=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_BOOTDELAY=3D10
>   CONFIG_OF_BOARD_SETUP=3Dy
> diff --git a/configs/lx2160ardb_tfa_stmm_defconfig b/configs/lx2160ardb_=
tfa_stmm_defconfig
> index cf65897af898..ef89b0f34575 100644
> --- a/configs/lx2160ardb_tfa_stmm_defconfig
> +++ b/configs/lx2160ardb_tfa_stmm_defconfig
> @@ -32,7 +32,6 @@ CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
>   CONFIG_DYNAMIC_SYS_CLK_FREQ=3Dy
>   CONFIG_EFI_MM_COMM_TEE=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_BOOTDELAY=3D10
>   CONFIG_OF_BOARD_SETUP=3Dy
> diff --git a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig b/configs/lx21=
62aqds_tfa_SECURE_BOOT_defconfig
> index 46b6085a52fe..2b31be10899b 100644
> --- a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
> +++ b/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
> @@ -28,7 +28,6 @@ CONFIG_FSL_QIXIS=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
>   CONFIG_DYNAMIC_SYS_CLK_FREQ=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_OF_BOARD_SETUP=3Dy
>   CONFIG_OF_STDOUT_VIA_ALIAS=3Dy
> diff --git a/configs/lx2162aqds_tfa_defconfig b/configs/lx2162aqds_tfa_d=
efconfig
> index 41e0262f3ca5..43f8069cfde5 100644
> --- a/configs/lx2162aqds_tfa_defconfig
> +++ b/configs/lx2162aqds_tfa_defconfig
> @@ -30,7 +30,6 @@ CONFIG_FSL_QIXIS=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
>   CONFIG_DYNAMIC_SYS_CLK_FREQ=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_BOOTDELAY=3D10
>   CONFIG_OF_BOARD_SETUP=3Dy
> diff --git a/configs/lx2162aqds_tfa_verified_boot_defconfig b/configs/lx=
2162aqds_tfa_verified_boot_defconfig
> index 7abfdbafbdf1..33b362c20b65 100644
> --- a/configs/lx2162aqds_tfa_verified_boot_defconfig
> +++ b/configs/lx2162aqds_tfa_verified_boot_defconfig
> @@ -30,7 +30,6 @@ CONFIG_FSL_QIXIS=3Dy
>   CONFIG_REMAKE_ELF=3Dy
>   CONFIG_MP=3Dy
>   CONFIG_DYNAMIC_SYS_CLK_FREQ=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_SIGNATURE=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_BOOTDELAY=3D10
> diff --git a/configs/ten64_tfa_defconfig b/configs/ten64_tfa_defconfig
> index a65209e8335b..f35de31718f7 100644
> --- a/configs/ten64_tfa_defconfig
> +++ b/configs/ten64_tfa_defconfig
> @@ -16,7 +16,6 @@ CONFIG_PCI=3Dy
>   CONFIG_AHCI=3Dy
>   CONFIG_SYS_FSL_NUM_CC_PLLS=3D3
>   CONFIG_MP=3Dy
> -CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_BOOTSTD_FULL=3Dy
>   CONFIG_BOOTSTD_BOOTCOMMAND=3Dy
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index e9c10819ba26..3ed27e97a083 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -894,10 +894,6 @@ efi_status_t efi_setup_loaded_image(struct efi_devi=
ce_path *device_path,
>   				    struct efi_loaded_image_obj **handle_ptr,
>   				    struct efi_loaded_image **info_ptr);
>
> -#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> -extern void *efi_bounce_buffer;
> -#define EFI_LOADER_BOUNCE_BUFFER_SIZE (64 * 1024 * 1024)
> -#endif
>
>   /* shorten device path */
>   struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp);
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 6130af14337e..bc08776ef4a6 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -490,13 +490,6 @@ config EFI_HTTP_PROTOCOL
>   endmenu
>
>   menu "Misc options"
> -config EFI_LOADER_BOUNCE_BUFFER
> -	bool "EFI Applications use bounce buffers for DMA operations"
> -	help
> -	  Some hardware does not support DMA to full 64bit addresses. For this
> -	  hardware we can create a bounce buffer so that payloads don't have t=
o
> -	  worry about platform details.
> -
>   config EFI_GRUB_ARM32_WORKAROUND
>   	bool "Workaround for GRUB on 32bit ARM"
>   	default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 5452640354e0..a0202032bb5a 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -105,6 +105,8 @@ static efi_status_t efi_disk_rw_blocks(struct efi_bl=
ock_io *this,
>   	int blksz;
>   	int blocks;
>   	unsigned long n;
> +	u64 bb =3D 0xffffffff;
> +	void *bb_ptr =3D buffer;
>
>   	diskobj =3D container_of(this, struct efi_disk_obj, ops);
>   	blksz =3D diskobj->media.block_size;
> @@ -113,27 +115,35 @@ static efi_status_t efi_disk_rw_blocks(struct efi_=
block_io *this,
>   	EFI_PRINT("blocks=3D%x lba=3D%llx blksz=3D%x dir=3D%d\n",
>   		  blocks, lba, blksz, direction);
>
> +	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && (uintptr_t)buffer >=3D SZ_4G +=
 buffer_size - 1) {
> +		if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DA=
TA,
> +				       buffer_size >> EFI_PAGE_SHIFT, &bb) !=3D EFI_SUCCESS)
> +			return EFI_OUT_OF_RESOURCES;
> +
> +		bb_ptr =3D (void *)(uintptr_t)bb;
> +	}
>   	/* We only support full block access */
> -	if (buffer_size & (blksz - 1))
> +	if (buffer_size & (blksz - 1)) {
> +		if (buffer !=3D bb_ptr)
> +			efi_free_pages(bb, buffer_size >> EFI_PAGE_SHIFT);
>   		return EFI_BAD_BUFFER_SIZE;
> +	}
>
>   	if (CONFIG_IS_ENABLED(PARTITIONS) &&
>   	    device_get_uclass_id(diskobj->header.dev) =3D=3D UCLASS_PARTITION=
) {
>   		if (direction =3D=3D EFI_DISK_READ)
> -			n =3D disk_blk_read(diskobj->header.dev, lba, blocks,
> -					  buffer);
> +			n =3D disk_blk_read(diskobj->header.dev, lba, blocks, bb_ptr);
>   		else
> -			n =3D disk_blk_write(diskobj->header.dev, lba, blocks,
> -					   buffer);
> +			n =3D disk_blk_write(diskobj->header.dev, lba, blocks, bb_ptr);
>   	} else {
>   		/* dev is a block device (UCLASS_BLK) */
>   		struct blk_desc *desc;
>
>   		desc =3D dev_get_uclass_plat(diskobj->header.dev);
>   		if (direction =3D=3D EFI_DISK_READ)
> -			n =3D blk_dread(desc, lba, blocks, buffer);
> +			n =3D blk_dread(desc, lba, blocks, bb_ptr);
>   		else
> -			n =3D blk_dwrite(desc, lba, blocks, buffer);
> +			n =3D blk_dwrite(desc, lba, blocks, bb_ptr);
>   	}
>
>   	/* We don't do interrupts, so check for timers cooperatively */
> @@ -141,8 +151,16 @@ static efi_status_t efi_disk_rw_blocks(struct efi_b=
lock_io *this,
>
>   	EFI_PRINT("n=3D%lx blocks=3D%x\n", n, blocks);
>
> -	if (n !=3D blocks)
> +	if (n !=3D blocks) {
> +		if (buffer !=3D bb_ptr)
> +			efi_free_pages(bb, buffer_size >> EFI_PAGE_SHIFT);
>   		return EFI_DEVICE_ERROR;
> +	}
> +
> +	if (buffer !=3D bb_ptr) {
> +		memcpy(buffer, bb_ptr, buffer_size);
> +		efi_free_pages(bb, buffer_size >> EFI_PAGE_SHIFT);
> +	}
>
>   	return EFI_SUCCESS;
>   }
> @@ -166,7 +184,6 @@ static efi_status_t EFIAPI efi_disk_read_blocks(stru=
ct efi_block_io *this,
>   			u32 media_id, u64 lba, efi_uintn_t buffer_size,
>   			void *buffer)
>   {
> -	void *real_buffer =3D buffer;
>   	efi_status_t r;
>
>   	if (!this)
> @@ -184,31 +201,12 @@ static efi_status_t EFIAPI efi_disk_read_blocks(st=
ruct efi_block_io *this,
>   	    (this->media->last_block + 1) * this->media->block_size)
>   		return EFI_INVALID_PARAMETER;
>
> -#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> -	if (buffer_size > EFI_LOADER_BOUNCE_BUFFER_SIZE) {
> -		r =3D efi_disk_read_blocks(this, media_id, lba,
> -			EFI_LOADER_BOUNCE_BUFFER_SIZE, buffer);
> -		if (r !=3D EFI_SUCCESS)
> -			return r;
> -		return efi_disk_read_blocks(this, media_id, lba +
> -			EFI_LOADER_BOUNCE_BUFFER_SIZE / this->media->block_size,
> -			buffer_size - EFI_LOADER_BOUNCE_BUFFER_SIZE,
> -			buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
> -	}
> -
> -	real_buffer =3D efi_bounce_buffer;
> -#endif
> -
>   	EFI_ENTRY("%p, %x, %llx, %zx, %p", this, media_id, lba,
>   		  buffer_size, buffer);
>
> -	r =3D efi_disk_rw_blocks(this, media_id, lba, buffer_size, real_buffer=
,
> +	r =3D efi_disk_rw_blocks(this, media_id, lba, buffer_size, buffer,
>   			       EFI_DISK_READ);
>
> -	/* Copy from bounce buffer to real buffer if necessary */
> -	if ((r =3D=3D EFI_SUCCESS) && (real_buffer !=3D buffer))
> -		memcpy(buffer, real_buffer, buffer_size);
> -
>   	return EFI_EXIT(r);
>   }
>
> @@ -232,7 +230,6 @@ static efi_status_t EFIAPI efi_disk_write_blocks(str=
uct efi_block_io *this,
>   			u32 media_id, u64 lba, efi_uintn_t buffer_size,
>   			void *buffer)
>   {
> -	void *real_buffer =3D buffer;
>   	efi_status_t r;
>
>   	if (!this)
> @@ -252,29 +249,10 @@ static efi_status_t EFIAPI efi_disk_write_blocks(s=
truct efi_block_io *this,
>   	    (this->media->last_block + 1) * this->media->block_size)
>   		return EFI_INVALID_PARAMETER;
>
> -#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> -	if (buffer_size > EFI_LOADER_BOUNCE_BUFFER_SIZE) {
> -		r =3D efi_disk_write_blocks(this, media_id, lba,
> -			EFI_LOADER_BOUNCE_BUFFER_SIZE, buffer);
> -		if (r !=3D EFI_SUCCESS)
> -			return r;
> -		return efi_disk_write_blocks(this, media_id, lba +
> -			EFI_LOADER_BOUNCE_BUFFER_SIZE / this->media->block_size,
> -			buffer_size - EFI_LOADER_BOUNCE_BUFFER_SIZE,
> -			buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
> -	}
> -
> -	real_buffer =3D efi_bounce_buffer;
> -#endif
> -
>   	EFI_ENTRY("%p, %x, %llx, %zx, %p", this, media_id, lba,
>   		  buffer_size, buffer);
>
> -	/* Populate bounce buffer if necessary */
> -	if (real_buffer !=3D buffer)
> -		memcpy(real_buffer, buffer, buffer_size);
> -
> -	r =3D efi_disk_rw_blocks(this, media_id, lba, buffer_size, real_buffer=
,
> +	r =3D efi_disk_rw_blocks(this, media_id, lba, buffer_size, buffer,
>   			       EFI_DISK_WRITE);
>
>   	return EFI_EXIT(r);
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 6d00b1862505..d7a8cb89e5b5 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -40,10 +40,6 @@ struct efi_mem_list {
>   /* This list contains all memory map items */
>   static LIST_HEAD(efi_mem);
>
> -#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> -void *efi_bounce_buffer;
> -#endif
> -
>   /**
>    * struct efi_pool_allocation - memory block allocated from pool
>    *
> @@ -852,18 +848,6 @@ int efi_memory_init(void)
>
>   	add_u_boot_and_runtime();
>
> -#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> -	/* Request a 32bit 64MB bounce buffer region */
> -	uint64_t efi_bounce_buffer_addr =3D 0xffffffff;
> -
> -	if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DAT=
A,
> -			       (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
> -			       &efi_bounce_buffer_addr) !=3D EFI_SUCCESS)
> -		return -1;
> -
> -	efi_bounce_buffer =3D (void*)(uintptr_t)efi_bounce_buffer_addr;
> -#endif
> -
>   	return 0;
>   }
>
> --
> 2.47.2
>

