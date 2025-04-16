Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBD4C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 05:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13DE82CA0;
	Wed, 16 Apr 2025 07:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="G3+XV/EY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D9082CAE; Wed, 16 Apr 2025 07:34:07 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8F882C8D
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 07:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744781633; x=1745386433; i=xypron.glpk@gmx.de;
 bh=eEw6SWrXAmVD2ErVlIRsLFB/ucxANJGnNIhupA1Ki9I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=G3+XV/EYifEFYQKs9jCpTNaSCRjtX+2iRSTD2HXGrr3BDGzeF/VXk4X5WPvFkrpY
 sJakeRZwEeieetEbOzCGWV+rjFx1l105py8NGVxVDxUMDhH3aF4GVFP81o9lSJ7Fx
 LSv0Xd+j59Ug1iOz57NJtK5DlB+aPZJ4yVn1eYVQDwxW8JbncO0O7KXj3jv8tKNoZ
 3sChQtD4bO0vjh30fq50SKBVBRn32itp0lkAInOuYWFzqqXxOr4WD0LLDOTrvqi2J
 2RXY27bmP16VOzPgHCGESLSlaF7exyZHm/oCXaq4j4+y7Sm3EFhdbgo6gJFTdac+G
 QA/aLVCUXVPb4OmD/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.10]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCtZ-1tTwhC1zN9-00qXKL; Wed, 16
 Apr 2025 07:33:53 +0200
Message-ID: <82103ca6-0e9c-4f4a-bfbf-547d1c06d976@gmx.de>
Date: Wed, 16 Apr 2025 07:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] emulation: fdt: Allow using U-Boot's device tree with
 QEMU
To: Simon Glass <sjg@chromium.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Andrew Phelps <andrew.phelps@canonical.com>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, Sumit Garg <sumit.garg@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250405190711.365419-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250405190711.365419-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Eo+a9Ed71bxMscPDOV7RLzVWDKpQNtxlIngiRz7x30aort8aCGk
 BWEJ5NBnpmF2SxzDkCON3WOo3D/k7PrI64FIgKYj0qcBt1Nuz/ZVE5BU0ixfmkTkGTDR0yL
 sOsd1rbVe2YNKIZgVe0E0iQ0eJ5f5yW705AsPlojKpJyky1awjj/87yZ64VAcADrSKkwruF
 oYwkHqKcP5M8AKhT5pABw==
UI-OutboundReport: notjunk:1;M01:P0:uuQ+xehDG6I=;3WKq/rePql7Y2hqp1Zi4YPfw9nm
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

On 4/5/25 21:07, Simon Glass wrote:
> At present it is impossible to change the qemu_arm64 defconfig to
> obtain a devicetree from the U-Boot build.
>=20
> This is necessary for FIT validation, for example, where the signature
> node must be compiled into U-Boot.

This description looks wrong:

Signatures are in FIT images.

Only public keys to validate the signatures should be compiled into U-Boot=
.

>=20
> A proposed change to QEMU to allow device tree additions has been
> blocked for several years. The only known workaround is to use QEMU's
> dumpdtb option, merge in the signature node manually, disable
> OF_HAS_PRIOR_STAGE and then start QEMU with special arguments. This is
> complicated enough that it is documented in U-Boot[1].

This seems to relate to
[PATCH] hw/arm/virt: Allow additions to the generated device tree
https://lore.kernel.org/qemu-devel/20210926183410.256484-1-sjg@chromium.or=
g/

As your describe in [1] QEMU already provides a -dtb parameter if you=20
want a crafted device-tree. Your proposed change is confounding boot=20
stages and and would not provide value to the QEMU project. It was=20
therefore rejected for good.

It remains unclear why you would disable OF_HAS_PRIOR_STAGE if you were=20
using QEMU's -dtb parameter.

What would be the benefit of compiling the DT into U-Boot instead of=20
providing it via the -dtb parameter?

>=20
> Unfortunately the only way to disable OF_HAS_PRIOR_STAGE at present is
> to hack the Kconfig.
>=20
> Add a new QEMU_MANUAL_DTB Kconfig option which makes OF_HAS_PRIOR_STAGE
> optional, thus avoiding needing to patch U-Boot to get this working.
>=20
> This seems a clearer solution than just making OF_HAS_PRIOR_STAGE
> visible, since that symbol is intended to be set automatically by each
> platform.

To me the new parameter is harder to use than simply making=20
CONFIG_OF_HAS_PRIOR_STAGE always editable.

>=20
> [1] https://docs.u-boot.org/en/latest/develop/devicetree/dt_qemu.html

The instructions that you provide in [1] are incorrect.

"qemu-system-arm -machine virt -machine dumpdtb=3Dqemu.dtb"

The second machine statement overrides the first one. And the second one=
=20
will use the default machine which for instance on riscv64 is not virt.

The correct invocation to download the device-tree would be:

qemu-system-arm -M virt,dumpdtb=3Dqemudtb


> Link: https://patchwork.kernel.org/project/qemu-devel/patch/202109261834=
10.256484-1-sjg@chromium.org/#24481799
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>
> ---
>=20
> Changes in v2:
> - Add a new QEMU-specific Kconfig instead
>=20
>   arch/arm/Kconfig                   |  2 +-
>   board/emulation/common/Kconfig     | 12 ++++++++++++
>   doc/develop/devicetree/dt_qemu.rst |  5 +++++
>   dts/Kconfig                        |  9 +++++++--

This patch lacks proper documentation in doc/

>   4 files changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index db8758e6dfe..b55ed61894a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1055,7 +1055,7 @@ config ARCH_QEMU
>   	imply DM_RNG
>   	imply DM_RTC
>   	imply RTC_PL031
> -	imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA
> +	imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA && !QEMU_MANUAL_DTB
>   	imply VIDEO
>   	imply VIDEO_BOCHS
>   	imply SYS_WHITE_ON_BLACK
> diff --git a/board/emulation/common/Kconfig b/board/emulation/common/Kco=
nfig
> index 4c15c8bcb89..3f9a6ea578f 100644
> --- a/board/emulation/common/Kconfig
> +++ b/board/emulation/common/Kconfig
> @@ -13,3 +13,15 @@ config MTDPARTS_NOR1
>   	help
>   	  This define the partition of nor1 used to build mtparts dynamically
>   	  for the u-boot env stored on nor1.
> +
> +config QEMU_MANUAL_DTB
> +	bool "Manually provide a device tree to QEMU"
> +	help
> +	  For some use cases, such as FIT validation where a public key must b=
e
> +	  placed in U-Boot's device tree, we need to override the device tree
> +	  that QEMU would normally provide to us.
> +
> +	  Note: this work-around is necessary since Linaro has blocked
> +	  addition of a feature to support additions to the QEMU devicetree:
> +
> +	    Link: https://patchwork.kernel.org/project/qemu-devel/patch/202109=
26183410.256484-1-sjg@chromium.org/#24481799
> diff --git a/doc/develop/devicetree/dt_qemu.rst b/doc/develop/devicetree=
/dt_qemu.rst
> index 8ba2b225590..c693b49d3d4 100644
> --- a/doc/develop/devicetree/dt_qemu.rst
> +++ b/doc/develop/devicetree/dt_qemu.rst
> @@ -46,3 +46,8 @@ You can then run qemu with the merged devicetree, e.g.=
::
>  =20
>   Note that there seems to be a bug in some versions of qemu where the o=
utput of
>   dumpdtb does not quite match what is provided to U-Boot.
> +
> +See also the
> +`rejected QEMU patch <https://patchwork.kernel.org/project/qemu-devel/p=
atch/20231117021840.117874-1-sjg@chromium.org>`_
> +and
> +`discussion <https://patchwork.kernel.org/project/qemu-devel/patch/2021=
0926183410.256484-1-sjg@chromium.org>`_.
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 2e88d210bb8..53f7e246a80 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -205,8 +205,13 @@ config OF_HAS_PRIOR_STAGE
>   	  development purposes, but it is not recommended, and likely will no=
t
>   	  even work, for production systems.
>  =20
> -	  Note: This option must be set in Kconfig and cannot be enabled or
> -	  disabled in the board's defconfig file.
> +	  Note: This option can be disabled for QEMU usiing QEMU_MANUAL_DTB th=
us

%s/usiing/using/

Best regards

Heinrich

> +	  allowing QEMU to support FIT validation, where the devicetree must
> +	  include a public key.
> +
> +	  See also this for context:
> +
> +	  https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410=
.256484-1-sjg@chromium.org/#24481799
>  =20
>   config OF_OMIT_DTB
>   	bool "Omit the device tree output when building"

