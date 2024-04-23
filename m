Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA4CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 12:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1580588589;
	Tue, 23 Apr 2024 14:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tl4tlFxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C008859A; Tue, 23 Apr 2024 14:16:34 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CE43884EF
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 14:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 126F761445;
 Tue, 23 Apr 2024 12:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BFDC116B1;
 Tue, 23 Apr 2024 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713874590;
 bh=l/vd82fskF/z/lsXlSUXNZug2F9SgSt3Brouh09C+xQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Tl4tlFxAm828VTG0OYXWKLL9kVrN/ug6p4ohmNeI4YEoNFB8PP3TfuOn6rszQIhtl
 xR65k9uryxKseZsQU6edQy12k9WhhgjGWB3brxv/qRpMQUQy1IGiBMeusWocDKPAPb
 D9BS+KUoeOdlGKXYFAvsPPxICZQ1CH3W3Cv7zAsBQArs8k4nEYjfvHlidmrOkx17jP
 +jCWyKQbmjbfIr3w7d81vlt5IK9M8s/FJ81Om8OReyvT0ZpNMtLoahUfVQhVEohm41
 nLqt3DsOosbPqMggfLw3/MXygSvaYUUz+c9SUjNaJhVTg4yfiO7+mAc5Tm/DUmDgB2
 nf6mdyZXT85nA==
Message-ID: <b19f02e0-a80a-46d6-8296-5d516577766a@kernel.org>
Date: Tue, 23 Apr 2024 15:16:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/19] board: am64x: Define capsule update firmware info
To: Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240419205701.163821-1-j-humphreys@ti.com>
 <20240419205701.163821-3-j-humphreys@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240419205701.163821-3-j-humphreys@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 19/04/2024 23:56, Jonathan Humphreys wrote:
> Define the firmware components updatable via EFI capsule update, including
> defining capsule GUIDs for the various firmware components for the AM64x SK.
> 
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  board/ti/am64x/evm.c        | 33 +++++++++++++++++++++++++++++++++
>  include/configs/am64x_evm.h | 24 ++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
> index b8de69da06c..83df75a6911 100644
> --- a/board/ti/am64x/evm.c
> +++ b/board/ti/am64x/evm.c
> @@ -7,6 +7,7 @@
>   *
>   */
>  
> +#include <efi_loader.h>
>  #include <asm/io.h>
>  #include <dm/uclass.h>
>  #include <k3-ddrss.h>
> @@ -27,6 +28,38 @@
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)

Checkpatch warns:

WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
#31: FILE: board/ti/am64x/evm.c:31:
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)


How about we drop the #if here and instead see possible solution below.

> +struct efi_fw_image fw_images[] = {
> +	{
> +		.image_type_id = AM64X_SK_TIBOOT3_IMAGE_GUID,
> +		.fw_name = u"AM64X_SK_TIBOOT3",
> +		.image_index = 1,
> +	},
> +	{
> +		.image_type_id = AM64X_SK_SPL_IMAGE_GUID,
> +		.fw_name = u"AM64X_SK_SPL",
> +		.image_index = 2,
> +	},
> +	{
> +		.image_type_id = AM64X_SK_UBOOT_IMAGE_GUID,
> +		.fw_name = u"AM64X_SK_UBOOT",
> +		.image_index = 3,
> +	}
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +	.dfu_string = "sf 0:0=tiboot3.bin raw 0 100000;tispl.bin raw 100000 200000;u-boot.img raw 300000 400000",
> +	.num_images = ARRAY_SIZE(fw_images),
> +	.images = fw_images,
> +};
> +
> +void set_dfu_alt_info(char *interface, char *devstr)
> +{

set the environment variable only if relevant config is enabled.

if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))

> +	env_set("dfu_alt_info", update_info.dfu_string);

> +}
> +
> +#endif /* EFI_HAVE_CAPSULE_SUPPORT */
> +
>  int board_init(void)
>  {
>  	return 0;
> diff --git a/include/configs/am64x_evm.h b/include/configs/am64x_evm.h
> index f9f8c7bc2f6..9db83621ea8 100644
> --- a/include/configs/am64x_evm.h
> +++ b/include/configs/am64x_evm.h
> @@ -9,6 +9,30 @@
>  #ifndef __CONFIG_AM642_EVM_H
>  #define __CONFIG_AM642_EVM_H
>  
> +/**
> + * define AM64X_SK_TIBOOT3_IMAGE_GUID - firmware GUID for AM64X sk tiboot3.bin
> + * define AM64X_SK_SPL_IMAGE_GUID     - firmware GUID for AM64X sk SPL
> + * define AM64X_SK_UBOOT_IMAGE_GUID   - firmware GUID for AM64X sk UBOOT
> + *
> + * These GUIDs are used in capsules updates to identify the corresponding
> + * firmware object.
> + *
> + * Board developers using this as a starting reference should
> + * define their own GUIDs to ensure that firmware repositories (like
> + * LVFS) do not confuse them.
> + */
> +#define AM64X_SK_TIBOOT3_IMAGE_GUID \
> +	EFI_GUID(0xede0a0d5, 0x9116, 0x4bfb, 0xaa, 0x54, \
> +		0x09, 0xe9, 0x7b, 0x5a, 0xfe, 0x1a)
> +
> +#define AM64X_SK_SPL_IMAGE_GUID \
> +	EFI_GUID(0x77678f5c, 0x64d4, 0x4910, 0xad, 0x75, \
> +		0x52, 0xc9, 0xd9, 0x5c, 0xdb, 0x1d)
> +
> +#define AM64X_SK_UBOOT_IMAGE_GUID \
> +	EFI_GUID(0xc6ad43a9, 0x7d31, 0x4f5d, 0x83, 0xe9, \
> +		0xb8, 0xef, 0xec, 0xae, 0x05, 0xbf)
> +
>  /* Now for the remaining common defines */
>  #include <configs/ti_armv7_common.h>
>  

-- 
cheers,
-roger
