Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75F4C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 22:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2862988582;
	Fri, 24 May 2024 00:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k5zOY71i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E56A988595; Fri, 24 May 2024 00:08:30 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E29C68820C
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 00:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so4798619a12.0
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716502108; x=1717106908; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v+/I7oSF9PELsvgo74DYWA1mzKFMa3bdbD8wf+/fFHo=;
 b=k5zOY71ileOjuKzwWlTpMPjUv6sPRLiRABUhkRcin+NTALJxZCiv/RfGPUsB1M0f7s
 IGzncJLVnE8ZTnXBnSIDE4+hmb6ADEr82dMWVCi83Lha98/zcLypCw+WpE74JJ13u+Fc
 QPZrs00GIQiF4P/LPwSl0bfwTCb5qTVAsPolOQqUZD2+YjDJpRDd/UY8XtWFlUramNbo
 kucsy/p6VBiONKJWBUIef5Gc+1oEU4fwFmpUy8tjDecrBo6pSzT8Skkq3eD8jQHxoVbe
 ubDHPfwa9wOYu9ejcLmRi3abhRxjlUWjuFYn7i+d92LNeFSZnAVHzwiggHRlTHZUupOj
 w3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716502108; x=1717106908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v+/I7oSF9PELsvgo74DYWA1mzKFMa3bdbD8wf+/fFHo=;
 b=LvKrlo9VVHARCYlMxIjAWX7E8+5Jk/gJ36Z3QTygyr9CLVRYlxQHMXrAVCORir4kJw
 xgE7jufJYmCYAtgDWNlUwF4tV22N5RHAWpSevYe54SbjtWO9lwtUxSgEDZN5CdvYUxQe
 sgw5e5ub8pKiLIQaxlKQ4yiTOyseUw46czJs9XjuYQr6AYow5i2VqXSelWc7XaNpfmh5
 q5RhukpiJvSj4G1b0WYhHSdpL7SWoERmSopmIKtxlIAaRCqDtSRN4S1yUVILY2k19WJT
 R1BG3kfEVTFY1i/nMb/hecD22gdPRktMvUP5o4Owkyp2x+RXEizXzEE0HCYDO0cTlLJN
 /fOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk7BwB3i39ttQ8z9k2ZKjuCKhuqFTzBDRivZL3FBEHC0C68OrxeWqR9r2GObXrJyjCnX7LeEMwT5Zyc4xe9IYYsZz7BA==
X-Gm-Message-State: AOJu0YxgMUFsIeZwH3+nRnXiQI46Sh0/6yjYTpYyTfQXlLoqr0h3ozWz
 RU1JGF2ycsraggSsyy9UmXILn/FiXMcwo4Fh+0oUPLCGp0NbzHQgfdKJtCCYWug=
X-Google-Smtp-Source: AGHT+IFzdh+KjN7GlZFJml3PmcqWIBOpLK4Gea1Wm6oztdTjfzAqnJOlA0cFa2hvKuQPQCgiP+B15g==
X-Received: by 2002:a50:cd43:0:b0:574:f83d:b282 with SMTP id
 4fb4d7f45d1cf-57843c4337cmr2972901a12.2.1716502108314; 
 Thu, 23 May 2024 15:08:28 -0700 (PDT)
Received: from hera (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5785233bfddsm302062a12.3.2024.05.23.15.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 15:08:28 -0700 (PDT)
Date: Fri, 24 May 2024 01:08:24 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 15/19] board: am62px: Define capsule update firmware
 info
Message-ID: <Zk--WFQJC-wi5zE5@hera>
References: <20240509164123.1753050-1-j-humphreys@ti.com>
 <20240509164123.1753050-16-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509164123.1753050-16-j-humphreys@ti.com>
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

Hi Jonathan

Thanks for working on this

On Thu, May 09, 2024 at 11:41:19AM -0500, Jonathan Humphreys wrote:
> Define the firmware components updatable via EFI capsule update, including
> defining capsule GUIDs for the various firmware components for the AM62px
> SK.
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  board/ti/am62px/evm.c        | 32 ++++++++++++++++++++++++++++++++
>  include/configs/am62px_evm.h | 24 ++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
> index 97a95ce8cc2..6d0f66e5dc0 100644
> --- a/board/ti/am62px/evm.c
> +++ b/board/ti/am62px/evm.c
> @@ -6,6 +6,7 @@
>   *
>   */
>
> +#include <efi_loader.h>
>  #include <asm/arch/hardware.h>
>  #include <asm/io.h>
>  #include <dm/uclass.h>
> @@ -13,6 +14,37 @@
>  #include <fdt_support.h>
>  #include <spl.h>
>
> +struct efi_fw_image fw_images[] = {

It's better if we add an
#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
for both of the structs that follow (and it applies to all your patches)

> +	{
> +		.image_type_id = AM62PX_SK_TIBOOT3_IMAGE_GUID,
> +		.fw_name = u"AM62PX_SK_TIBOOT3",
> +		.image_index = 1,
> +	},
> +	{
> +		.image_type_id = AM62PX_SK_SPL_IMAGE_GUID,
> +		.fw_name = u"AM62PX_SK_SPL",
> +		.image_index = 2,
> +	},
> +	{
> +		.image_type_id = AM62PX_SK_UBOOT_IMAGE_GUID,
> +		.fw_name = u"AM62PX_SK_UBOOT",
> +		.image_index = 3,
> +	}
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +	.dfu_string = "sf 0:0=tiboot3.bin raw 0 80000;"
> +	"tispl.bin raw 80000 200000;u-boot.img raw 280000 400000",
> +	.num_images = ARRAY_SIZE(fw_images),
> +	.images = fw_images,
> +};

I haven't worked on any TI platforms lately so I cant say much about the
naming and the flash regions. The definition seems correct


> +
> +void set_dfu_alt_info(char *interface, char *devstr)
> +{
> +	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> +		env_set("dfu_alt_info", update_info.dfu_string);
> +}

There's a CONFIG_SET_DFU_ALT_INFO symbol. This better if we add a check here
as well

> +
>  int board_init(void)
>  {
>  	return 0;
> diff --git a/include/configs/am62px_evm.h b/include/configs/am62px_evm.h
> index 06b12860e21..57a1ba9dc3c 100644
> --- a/include/configs/am62px_evm.h
> +++ b/include/configs/am62px_evm.h
> @@ -8,6 +8,30 @@
>  #ifndef __CONFIG_AM62PX_EVM_H
>  #define __CONFIG_AM62PX_EVM_H
>
[...]

Regards
/Ilias
