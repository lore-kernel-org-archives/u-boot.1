Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A08F5A8A6
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 17:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C41F484310;
	Mon, 20 Apr 2026 19:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="eIT1H2SD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE7EE84315; Mon, 20 Apr 2026 19:41:38 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A548425F
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 19:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776706894; x=1777311694; i=xypron.glpk@gmx.de;
 bh=WjNwcsDBbwwW9k95B7X2n6ojYpbOAFvAjEiuoD1R8vU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=eIT1H2SDiuh/+9CDa57EFdAQeW3i2sHRlNBv05Mk8C/QLl8J5dSkYAmEb46OzEij
 DxgH1BqGqYB5KD2Gg2875AlzoOR8OluPgtdVF/qVf8m/32r2JH8AC0fszy8eE5ciA
 WXMWlM3chG7Gphh3JZ2kWowQ8Ly8iNEDhUmAB+E2GBpl8gbtDYwhEzDaSv9FigAp+
 e7b8DE4GQco/R7x12048lMM8Nz+PGSDCXNGt3m2h49jzyeML7Plhov3KDqFGUysF4
 YXtpfil6tK7rPACzfMrgpu6WSjptt8c/w+fUZbXY6Vqum0oMczZJGXwYXLVbIhuoh
 Xx2ooJpKDFHTT+9CIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhhX-1w4fUY4AH1-007wxN; Mon, 20
 Apr 2026 19:41:34 +0200
Message-ID: <a5724941-bf58-4e5a-b0a7-0d460e4d74c0@gmx.de>
Date: Mon, 20 Apr 2026 19:41:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: emulation: qemu-arm: add secure state steps
To: Johannes Krottmayer <krotti83@proton.me>
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, u-boot@lists.denx.de,
 sjg@chromium.org
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
 <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
 <20260224193312.GB3233182@bill-the-cat>
 <02e49242-da72-4bcd-a428-f7e8c9aee742@proton.me>
 <20260225004838.GA1593142@bill-the-cat>
 <20260225020042.20823-1-krotti83@proton.me>
 <20260225020042.20823-2-krotti83@proton.me>
 <CAFLszTiH0T56YgWhjp6hiXMTswcgu-yp-ivSKS3u4JoPMJDBKA@mail.gmail.com>
 <20260420112815.1448132-1-krotti83@proton.me>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260420112815.1448132-1-krotti83@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m5uLlaKO7wwPzFMKcF7Du5qXQEfkcu4bCAapFb1FUA9+X5N8atz
 isiFgHCtJbTiE+nphnM2D6vrteoep6sFXwtNd4TgGyWh+bxUqox4mRMQFvSJhlpLX+17FM3
 bmzSVdKZjVkEWEf+Ks5pCMNGxNs6LalDSuIBFAFVXHL7HCCg8ISWI0lsiqVcXhxyesu8wqp
 9+a1u3bY/FdGAMUSMf2Yw==
UI-OutboundReport: notjunk:1;M01:P0:+yQ15sXwChY=;hemZx59IlaSsKWGpi2Quf6R0IEK
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

On 4/20/26 13:29, Johannes Krottmayer wrote:
> Add build steps for building U-Boot in secure state with
> TF-A and OP-TEE. It includes the full steps for building
> OP-TEE and TF-A to use with U-Boot. Also a short description
> how to invoke QEMU with enabled EL3 and EL2. EL3 (machine
> option secure=3Don) is required to run TF-A.
>=20
> Signed-off-by: Johannes Krottmayer <krotti83@proton.me>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
> ---
>=20
> Changes PATCH v2:
> - Fix typo (OT-TEE -> OP-TEE)
> - Fix grammatic and correct spellings
> - Fix line warp and formatting
> - Add 'git checkout' for the specific (tested) version in the used build=
 commands
> - Change misleading filename 'flash.bin' to 'qemu_fw.bios'
>=20
>=20
>   doc/board/emulation/qemu-arm.rst | 88 ++++++++++++++++++++++++++++++--
>   1 file changed, 84 insertions(+), 4 deletions(-)
>=20
> diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu=
-arm.rst
> index 1c91c7f3ac6..9e993ca9783 100644
> --- a/doc/board/emulation/qemu-arm.rst
> +++ b/doc/board
> /emulation/qemu-arm.rst
> @@ -24,8 +24,78 @@ Additionally, a number of optional peripherals can be=
 added to the PCI bus.
>   See :doc:`../../develop/devicetree/dt_qemu` for information on how to =
see
>   the devicetree actually generated by QEMU.
>  =20
> -Building U-Boot
> ----------------
> +Building (secure)
> +-----------------
> +
> +U-Boot
> +^^^^^^
> +
> +- For AArch64::
> +
> +    make qemu_arm64_defconfig
> +    make
> +
> +On successful build 'u-boot.bin' should be created. It's necessary in t=
he following
> +steps (building TF-A).
> +
> +OP-TEE
> +^^^^^^
> +
> +- For AArch64::
> +
> +    git clone https://github.com/OP-TEE/optee_os.git
> +    cd optee_os
> +    git checkout 4.9.0
> +    export CROSS_COMPILE64=3Daarch64-none-elf-
> +    export CROSS_COMPILE32=3Darm-none-eabi-
> +    make PLATFORM=3Dvexpress-qemu_armv8a CFG_TRANSFER_LIST=3Dy CFG_MAP_=
EXT_DT_SECURE=3Dy
> +
> +At least OP-TEE v4.9.0 for AArch64 needs both compiler (64-Bit and 32-B=
it edition) for
> +a successful build. On a successful build following files should
> be created under the
> +directory 'out/arm-plat-vexpress/core' from OP-TEE::
> +
> +    optee_os/out/arm-plat-vexpress/core/tee-header_v2.bin
> +    optee_os/out/arm-plat-vexpress/core/tee-pageable_v2.bin
> +    optee_os/out/arm-plat-vexpress/core/tee-pager_v2.bin
> +
> +TF-A
> +^^^^
> +
> +- For AArch64::
> +
> +    git clone https://github.com/ARM-software/arm-trusted-firmware.git
> +    cd arm-trusted-firmware
> +    git submodule update --init
> +    git checkout v2.14.0
> +    export CROSS_COMPILE=3Daarch64-none-elf-
> +    export BL32=3Dpath/to/tee-header_v2.bin
> +    export BL32_EXTRA1=3Dpath/to/tee-pager_v2.bin
> +    export BL32_EXTRA2=3Dpath/to/tee-pageable_v2.bin
> +    export BL33=3Dpath/to/u-boot.bin
> +    make PLAT=3Dqemu BL32_RAM_LOCATION=3Dtdram SPD=3Dopteed TRANSFER_LI=
ST=3D1 all fip
> +
> +On successful build the following files should be created under the dir=
ectory
> +'build/qemu/release' from TF-A::
> +
> +    arm-trusted-firmware/build/qemu/release/bl1.bin
> +    arm-trusted-firmware/build/qemu/release/fip.b
> in
> +
> +The following file is at least created with TF-A v2.14.0 and can be dir=
ectly passed
> +with the '-bios' option to QEMU::
> +
> +    arm-trusted-firmware/build/qemu/release/qemu_fw.bios
> +
> +If the single file ('qemu_fw.bios') doesn't exist, 'bl1.bin' and 'fip.b=
in' can be
> +concatenated with the command 'dd' alternatively::
> +
> +    dd if=3Dbl1.bin of=3Dqemu_fw.bios bs=3D4096 conv=3Dnotrunc
> +    dd if=3Dfip.bin of=3Dqemu_fw.bios seek=3D64 bs=3D4096 conv=3Dnotrun=
c
> +
> +Building (non-secure)
> +---------------------
> +
> +U-Boot
> +^^^^^^
>   Set the CROSS_COMPILE environment variable as usual, and run:
>  =20
>   - For ARM::
> @@ -38,8 +108,18 @@ Set the CROSS_COMPILE environment variable as usual,=
 and run:
>       make qemu_arm64_defconfig
>       make
>  =20
> -Running U-Boot
> ---------------
> +Running U-Boot (secure)
> +-----------------------
> +
> +- For AArch64::
> +
> +    qemu-system-aarch64 -machine virt,secure=3Don,virtualization=3Don \
> +    -nographic -cpu cortex-a57 -bios qemu_fw.bios
> +
> +For additional QEMU comman
> d description see running U-Boot in non-secure state.

This is not a valid patch:

b4 shazam=20
https://lore.kernel.org/u-boot/20260420112815.1448132-1-krotti83@proton.me=
/T/#u

Applying: doc: emulation: qemu-arm: add secure state steps
Patch failed at 0001 doc: emulation: qemu-arm: add secure state steps
error: patch with only garbage at line 17

Best regards

Heinrich

> +
> +Running U-Boot (non-secure)
> +---------------------------
>   The minimal QEMU command line to get U-Boot up and running is:
>  =20
>   - For ARM::

