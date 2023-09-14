Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ADBEDE984
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 06:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A39528658B;
	Thu, 14 Sep 2023 08:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YAld95pr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 555548658D; Thu, 14 Sep 2023 08:05:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63EAE8656A
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 08:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694671525; x=1695276325; i=xypron.glpk@gmx.de;
 bh=jh5KG5CTAtZcdQyKDpqwjr33M67hMbQFChYJLG5Xyls=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=YAld95prqe6Nj20GYKTM09rF0LkaMQYY1USZA4Nvv5YY2AzKwgJY60kUrBZGgfk4LUqgEkFsGFx
 kgtlWTS82qwAEtL9kNHHTGxyvjgYxfIp5dYh8C2yX7g4/xET/SI+1Jn15v1B7EaFnfIZb/5i7ORQd
 6zWIgqVuduWdEX/t8bf16myg4PtqyB+b9HXhKN6dquRysuxjQZ7QbhGe+haAb4q1B5VkGwXYpceib
 IGLJvNIA9BlZIUxugM6yrUeAYSsPYl1GUhwN3bo6dDkC6RyJtImHlIsR/dv6oMoqoo0z9E5GwVeUV
 dg6KB3sN9p/GK90elnny9BPKRsHqSXzWB1Ww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wys-1qmBn63Lr2-005Xhi; Thu, 14
 Sep 2023 08:05:24 +0200
Date: Thu, 14 Sep 2023 08:05:22 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Fei Wu <fei2.wu@intel.com>, rick@andestech.com, ycliang@andestech.com,
 bmeng.cn@gmail.com, sjg@chromium.org, pali@kernel.org, u-boot@lists.denx.de,
 andrei.warkentin@intel.com, sunilvl@ventanamicro.com
Subject: Re: [PATCH v2] riscv: enable multi-range memory layout
User-Agent: K-9 Mail for Android
In-Reply-To: <20230914053055.745507-1-fei2.wu@intel.com>
References: <20230914053055.745507-1-fei2.wu@intel.com>
Message-ID: <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7nr5Tx1LsZ+uh1q11jDQHjuESoolNSz/KuTqoemy3Ky8Tgrc+th
 sF4TnvPzBdzY0E4vvdkiRvqXlvUKTlz54Ftx1HhKxA96Tz80AGAUlg4C3n0aKHADpY6iE9n
 VuioxSbicFwR+OP2pPbiY0rlDB/RZsg7SXjpdt2Y5DamB87mq4NvK4IKPDC8wFvBA5F0b0i
 SvUabv2TCmuOQkQoAKHKg==
UI-OutboundReport: notjunk:1;M01:P0:/b4Ul8mfmpY=;ov7c3UwNLsfp9xqhLn1Lr9MX72f
 45zBNSyNZwnmSf89A+q52xgoBpomrlIgEiOmqYEJ+zVF4ZhTtGgzeWutONZWaNUeH+3Wd4RFt
 VLHbU1oLbDqnW7WawlF9PNzoZ35fHLTKdSz1Ew/4/zOK/5aRJZYRQjx4FP9BnpRotjDEFTCJk
 MfBBzRNdi5GcqKCp1yGoSrt3lpPgqyvMh1GtBe/O59uMazXmQjEw88AHNkI9gZQ8+dgQVDTjV
 vGYuaQKvMqTIOBvWOJx3m4/KUAlhsp3iYOHHJfpzvllm6ZMk6bGrYgyYd5vkNHcNOjgg+FKji
 1scFGRalvpBarJIEFfEYLSjjLft67MU7qAXdAaEnScK0GglL0OV9nviHF5VMBhHQhbJ35uJgx
 9/uu6tqh+Z0b7oXjhejzO6BUM4inhQQPgA/ItH9jxONq74lCvqRslCmWb+zEkfCC3yeKfmVD/
 Elq1/60fRkj0B2QAEJ7xXxWzLKjpfzr7GZ1nR6YzY6EB2wlymQy7JySW5EvCUvef18lb9XPM3
 X0q/HIDqzgMl5cblmXdYunFH5kLDP5GSmvGnfIrKjdRPFKRfk+AU8vVsmyKjcaY2YTswlODIC
 WG8dOCV3ihm29EV0u4EvenljHQRlgt9fBttgNG0y3UeqM08UtsNkb2YM5rb7FGDPX865VFvHK
 kqahgz//11xxUUGbLCIHdKL804m0CZRCM4Ps7OajiFDh3hDAO4MMM5qVWFpLxH1qEfFJs7wPa
 b2lIKcU+m0jvvbP1Mo+4rbIsmRdscARxHmbx5e5FIX6xNF/E0ili9GiC+wq0fXZXleW8Vn05Z
 gka3C3KLh2Yfn93hVZlSEUiZsPKtCzJEGe2Y2akbwN1gZJyejLisKZEpe0I7uaZ2b90KDp8Yw
 6wPR5giXqCib7hI+wj5dOUU5OdZYGwX8Q9x8Cb9bTxjpXZD5ly2q/TVVpdL/Kjqt5oXLFlIia
 IMHp9m/NAc+E1hYiMyo5dyqfNI8=
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



Am 14=2E September 2023 07:30:55 MESZ schrieb Fei Wu <fei2=2Ewu@intel=2Eco=
m>:
>In order to enable PCIe passthrough on qemu riscv, the physical memory
>range between 3GB and 4GB is reserved=2E Therefore if guest has 4GB ram,
>two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot sets
>ram_top to 4G - 1 if the gd->ram_top is above 4G in

This should move to 7GiB - 1 in your example on riscv64=2E

>board_get_usable_ram_top(), but that address is not backed by ram=2E This
>patch selects the lowest range instead=2E
>
>Signed-off-by: Fei Wu <fei2=2Ewu@intel=2Ecom>
>---
> arch/riscv/cpu/generic/dram=2Ec        | 2 +-
> configs/qemu-riscv64_defconfig       | 2 +-
> configs/qemu-riscv64_smode_defconfig | 2 +-
> configs/qemu-riscv64_spl_defconfig   | 2 +-
> 4 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/arch/riscv/cpu/generic/dram=2Ec b/arch/riscv/cpu/generic/dra=
m=2Ec
>index 44e11bd56c=2E=2Efb53a57b4e 100644
>--- a/arch/riscv/cpu/generic/dram=2Ec
>+++ b/arch/riscv/cpu/generic/dram=2Ec
>@@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
>=20
> int dram_init(void)
> {
>-	return fdtdec_setup_mem_size_base();
>+	return fdtdec_setup_mem_size_base_lowest();

Linaro is working on allowing to download a distro image via https and ins=
talling from a RAM disk=2E

We should not artificially reduce the RAM size available for U-Boot by res=
tricting ourselfs to 1 GiB=2E

We must ensure that ram top is in the upper range=2E

Best regards

Heinrich

> }
>=20
> int dram_init_banksize(void)
>diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defcon=
fig
>index 9a8bbef192=2E=2Eaa55317d26 100644
>--- a/configs/qemu-riscv64_defconfig
>+++ b/configs/qemu-riscv64_defconfig
>@@ -1,6 +1,6 @@
> CONFIG_RISCV=3Dy
> CONFIG_SYS_MALLOC_LEN=3D0x800000
>-CONFIG_NR_DRAM_BANKS=3D1
>+CONFIG_NR_DRAM_BANKS=3D2
> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
> CONFIG_ENV_SIZE=3D0x20000
>diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_=
smode_defconfig
>index 1d0f021ade=2E=2Ede08a49dab 100644
>--- a/configs/qemu-riscv64_smode_defconfig
>+++ b/configs/qemu-riscv64_smode_defconfig
>@@ -1,6 +1,6 @@
> CONFIG_RISCV=3Dy
> CONFIG_SYS_MALLOC_LEN=3D0x800000
>-CONFIG_NR_DRAM_BANKS=3D1
>+CONFIG_NR_DRAM_BANKS=3D2
> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
> CONFIG_ENV_SIZE=3D0x20000
>diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_sp=
l_defconfig
>index bb10145e6e=2E=2E66dc2a1dd9 100644
>--- a/configs/qemu-riscv64_spl_defconfig
>+++ b/configs/qemu-riscv64_spl_defconfig
>@@ -1,6 +1,6 @@
> CONFIG_RISCV=3Dy
> CONFIG_SYS_MALLOC_LEN=3D0x800000
>-CONFIG_NR_DRAM_BANKS=3D1
>+CONFIG_NR_DRAM_BANKS=3D2
> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
> CONFIG_ENV_SIZE=3D0x20000
