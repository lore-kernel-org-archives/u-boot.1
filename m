Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F575C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 20:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB951605D1;
	Tue, 25 Aug 2026 20:38:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZIc-FXT8zie; Tue, 25 Aug 2026 20:38:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787690338;
	bh=hSzUaSJJEheZWjl/CF8mV+xZ9BuIKwfGWT4KPWGtIXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bUj+8Ato2MFAw+9rJfiL04FMp5F0G/H1Lt3PP7Pq0uSZOuRV1So/odSkQluFv23Oe
	 TaNJ0OhfQPZQX992X8HyAyudyWexMpYQSmfMpzttPWD2SjIpSvIKlwU8/C/rT9a0js
	 3Vto9rDbnKpngk7nXXTkMwHrxKiRnSoAbvBPGdzDHS/+Fu3MBNXtiTXuMTPhSwpR18
	 0P44+PEDdKayWl8GoPInZnKvf38jaLXOHGP8sBO2qGBqPMmD2HHrX3Rgrtf27G1V1u
	 7RFpgDFvIENEEuYE3g4ZnzJnlMKY29p8AQ5I1/sHYdQm+bdFl/m+U9ty84nE0BchZF
	 y0Z9KaMFwGAFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6C746061C;
	Tue, 25 Aug 2026 20:38:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 801B5230
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71AF36061C
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:38:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SgNC8nR_hJt4 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 20:38:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iyNcUham
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BD624605D1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:38:51 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7eb61bbeb25so314035a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787690331; x=1788295131;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hSzUaSJJEheZWjl/CF8mV+xZ9BuIKwfGWT4KPWGtIXA=;
 b=iyNcUhamOP5TBu2ZOqNfbpGkz1mfTjIkujL/FYOHNHyeuLhfETeYe2wAcyZx/aZVG3
 /WPR0Z1h+DCIu8xnB7Lsc70VOEjhsEa/J3+RE6vx0llz0sddlAe/1PbEt3Whe0D3hpx6
 uWxz92bAHIzENV6eY8M3kZb9cimUaBGqHB9QWvKXtwNAHk2hh/I0DXZFMaPv0DJ4WUAk
 JuoyX2fuL4csyz1BTMKyPsqPhlguKqfZRS14xPiTLXcpR/FhTPWdCgfsay0W8vt6blCR
 1q8c2/Cwp6rogxFFqSL9GBcVgN2tSB5raBC51fIrux1lHGckuzyJr6/RaEXgkmHBDIQm
 k4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787690331; x=1788295131;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hSzUaSJJEheZWjl/CF8mV+xZ9BuIKwfGWT4KPWGtIXA=;
 b=KQmseqctTGlA4xkr+iXZaKC0VrsSzMmJaRXARWUgOaIKHpurj/iV/AaHQD0KXc62oZ
 4SP/lvuKbhX7ymnu5QkEQ8y4qRoPucW4yOcN6Cahro0Opum9ODGzWWm1ve23V1JL8dCs
 X54pQWKpYKX9jbk7/kxpU8Ev3pPqH+x1+rkkR4lXunCw4tbHm920MWwk9dABg585NRGV
 NIPoZpVzEg4no3kFiOj3gnBHtu25Ss7vWuAWWSGj2r78256i6/lykJEUvmV0butu9ddc
 ENhDCPJvSHs/D70zkz4/5BatqS7liEORtj3asrzXayIifsi307X8khqZJ9R5fQSWnUAm
 vclg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsnqOUJgXFGGJCgA8rRE6wYPAO+ujiyGqmJrSlnk29PSWE08wilx5hV0xgrPWjT5gWZriZ6jU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mrfkR3C1IIiuXGgv4PH7oHgfSSNz6FZkoj8xabXTbjEIg9lpg+
 9GtsdaVaUcNoUIKtFyaPqZDk85vJJX9TJsJ1Oqh98Edelm6FRREoXetf/GRwRSIXYEw=
X-Gm-Gg: AR+sD10GSZGLSMzJwYs5Xj+DLx04oxtgya/B1psXQdbTLSQyD+c38lsARDYChpmVyJ6
 ZLl3cpNobqVINSUiEE1pdoLkroTDWCqMvxNuRlCMgUNruD0i98e0v/Fqoco9/LAhogqaHF6Y2FA
 kYR/UAlJaPEUv6vrzcnquYLV9iiNqO5PWkKnFntyYufYPqLl/iU3tzZrXHcmyXWW0M6UqKr73Ov
 6cEcyAFkFUz6GJaHQW3r3VtziL7Osm1DwCsyOIT8v0DaVXRuP1hip6uq17Sv2OcCgdhQb8MgCCf
 wT+SSIYbtKZhC1+9DZVs5vlfafpGTWDB5iwQd/no76CI7HGJnLeYRluH6zQWYnV6ayGSxfjA7Xc
 nekw5AS4J4MYp+gEcHC/cpEmyl9zdBsWWhT659F0uSHllM5yOpG7i5jEme1is9F2ExMzf/wdRy4
 XUr44UCSG4N2yL86g0LSBpAIT1NFdMuE48GJgchifCz1EmcWkTZiL2iH5xzaNiW8RwPSay9+prB
 Pv25aVzXWVqu1bgBlt0CJgNYuoTIf7502To
X-Received: by 2002:a05:6830:917:b0:7e9:e709:44f6 with SMTP id
 46e09a7af769-7f4c513b6efmr1403791a34.12.1787690330633; 
 Tue, 25 Aug 2026 13:38:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e96b:b637:f05:5bfd?
 ([2600:8803:e7e4:500:e96b:b637:f05:5bfd])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c4210437sm465084a34.3.2026.08.25.13.38.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 13:38:50 -0700 (PDT)
Message-ID: <f5a976eb-6e5b-4210-9f3e-8068961a1fa5@baylibre.com>
Date: Tue, 25 Aug 2026 15:38:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] arm: mediatek: build Genio 510 and 700 boot images
 with binman
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Johan Jonker
 <jbx6244@gmail.com>, Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>
References: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
 <20260814-ccaione-upstream-mt8390-spl-v4-3-f4f92978a79e@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260814-ccaione-upstream-mt8390-spl-v4-3-f4f92978a79e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/14/26 9:47 AM, Carlo Caione wrote:
> Genio 510 and Genio 700 use an external DDR loader before U-Boot SPL,
> then load the remaining firmware from a FIT. Add shared binman
> descriptions for both images so integration builds can assemble the
> complete boot chain.
> 
> Keep packaging optional because the required platform firmware is built
> outside U-Boot.
> 
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi  |  9 +++
>  arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi  |  9 +++
>  arch/arm/dts/mtk-genio-binman.dtsi             | 12 ++++
>  arch/arm/dts/mtk-genio-bootloaders-binman.dtsi | 95 ++++++++++++++++++++++++++
>  arch/arm/dts/mtk-genio-loader-spl-binman.dtsi  | 16 +++++
>  arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi    | 26 +++++++
>  arch/arm/mach-mediatek/Kconfig                 | 43 ++++++++++++
>  board/mediatek/MAINTAINERS                     |  2 +
>  common/spl/Kconfig                             |  1 +
>  9 files changed, 213 insertions(+)
> 
> diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> index 1a5f45cba6b..e3cf1e306e9 100644
> --- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> +++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> @@ -4,4 +4,13 @@
>   * Author: Julien Stephan <jstephan@baylibre.com>
>   */
>  
> +#include <config.h>
>  #include "mt8390-genio-common-u-boot.dtsi"
> +
> +#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
> +#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 510 bootloaders"
> +#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 510 boot chain"
> +#include "mtk-genio-binman.dtsi"
> +#include "mtk-genio-mtk-boot-binman.dtsi"
> +#include "mtk-genio-bootloaders-binman.dtsi"

Would be nice if the commit message explained why we need 3 separate files
if we always include them all.

> +#endif
> diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> index 1a5f45cba6b..cb50efab376 100644
> --- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> +++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> @@ -4,4 +4,13 @@
>   * Author: Julien Stephan <jstephan@baylibre.com>
>   */
>  
> +#include <config.h>
>  #include "mt8390-genio-common-u-boot.dtsi"
> +
> +#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
> +#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 700 bootloaders"
> +#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 700 boot chain"
> +#include "mtk-genio-binman.dtsi"
> +#include "mtk-genio-mtk-boot-binman.dtsi"
> +#include "mtk-genio-bootloaders-binman.dtsi"
> +#endif
> diff --git a/arch/arm/dts/mtk-genio-binman.dtsi b/arch/arm/dts/mtk-genio-binman.dtsi
> new file mode 100644
> index 00000000000..7e718ddf8da
> --- /dev/null
> +++ b/arch/arm/dts/mtk-genio-binman.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + * Author: Carlo Caione <ccaione@baylibre.com>
> + */
> +
> +/ {
> +	binman: binman {
> +		multiple-images;
> +	};
> +};
> diff --git a/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi b/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
> new file mode 100644
> index 00000000000..c43d8c32507
> --- /dev/null
> +++ b/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + * Author: Carlo Caione <ccaione@baylibre.com>
> + */
> +
> +&binman {
> +	bootloaders {
> +		filename = "bootloaders.img";
> +
> +		fit {
> +			description = MTK_BOOTLOADERS_DESCRIPTION;
> +			#address-cells = <1>;
> +
> +			images {
> +				uboot {
> +					description = "U-Boot";
> +					type = "firmware";
> +					os = "u-boot";
> +					arch = "arm64";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					entry = <CONFIG_TEXT_BASE>;
> +
> +					u-boot-nodtb {
> +					};
> +
> +					hash {
> +						algo = "sha256";
> +					};
> +				};
> +
> +				atf {
> +					description = "ARM Trusted Firmware BL31";
> +					type = "firmware";
> +					os = "arm-trusted-firmware";
> +					arch = "arm64";
> +					compression = "none";
> +					load = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
> +					entry = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
> +
> +					atf-bl31 {
> +					};
> +
> +					hash {
> +						algo = "sha256";
> +					};
> +				};
> +
> +				optee {

Can we use `fit,operation = "split-elf";` here instead of requiring config
options for the load and entry address?

> +					description = "OP-TEE";
> +					type = "firmware";
> +					os = "tee";
> +					arch = "arm64";
> +					compression = "none";
> +					load = <CONFIG_MTK_GENIO_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_MTK_GENIO_OPTEE_ENTRY_ADDR>;
> +
> +					tee-os {
> +					};
> +
> +					hash {
> +						algo = "sha256";
> +					};
> +				};
> +
> +				uboot-fdt {
> +					description = "U-Boot control devicetree";
> +					type = "flat_dt";
> +					arch = "arm64";
> +					compression = "none";
> +
> +					u-boot-dtb {
> +					};
> +
> +					hash {
> +						algo = "sha256";
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf";
> +
> +				conf {
> +					description = MTK_BOOT_CHAIN_DESCRIPTION;
> +					firmware = "atf";
> +					loadables = "uboot", "optee";
> +					fdt = "uboot-fdt";
> +				};
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
> new file mode 100644
> index 00000000000..e49ad5c471f
> --- /dev/null
> +++ b/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + * Author: Carlo Caione <ccaione@baylibre.com>
> + */
> +
> +ddr-loader {
> +	type = "blob-ext";
> +	filename = "ddr-loader.bin";
> +	size = <CONFIG_MTK_GENIO_DDR_LOADER_SIZE>;
> +};
> +
> +u-boot-spl {
> +	size = <CONFIG_SPL_MAX_SIZE>;
> +};
> diff --git a/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi b/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
> new file mode 100644
> index 00000000000..16ce9cacb66
> --- /dev/null
> +++ b/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + * Author: Carlo Caione <ccaione@baylibre.com>
> + */
> +
> +#include <linux/stringify.h>
> +
> +&binman {
> +	mtk-boot {
> +		filename = "mtk-boot.bin";
> +
> +		mkimage {
> +			args = "-T", "mtk_image",
> +			       "-a", __stringify(CONFIG_MTK_GENIO_BROM_LOAD_ADDR),
> +			       "-e", __stringify(CONFIG_MTK_GENIO_BROM_LOAD_ADDR),
> +			       "-n", "media=emmc;arm64=1";

Should this be coming from CONFIG_MTK_BROM_HEADER_INFO?

We will probably eventually be adding ufs and nor boot support too.

> +
> +			section {
> +				pad-byte = <0>;
> +#include "mtk-genio-loader-spl-binman.dtsi"
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index 5e6c50ca64d..eb8d072e686 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -210,6 +210,49 @@ config MTK_BROM_HEADER_INFO
>  	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
>  	default "lk=1" if TARGET_MT7623
>  
> +config MTK_GENIO_BOOT_IMAGES
> +	bool "Build MediaTek firmware images"
> +	depends on TARGET_MT8188 && SPL
> +	select BINMAN
> +	select MTK_GENIO_IMAGE_CONTRACT
> +	help
> +	  Enable binman to assemble the MediaTek BootROM image and firmware
> +	  FIT from U-Boot and external platform firmware components.
> +
> +config MTK_GENIO_IMAGE_CONTRACT
> +	bool
> +
> +if MTK_GENIO_IMAGE_CONTRACT
> +
> +config MTK_GENIO_BROM_LOAD_ADDR
> +	hex "BootROM payload load address"
> +	default 0x201000 if TARGET_MT8188
> +	help
> +	  Address at which the MediaTek BootROM loads and enters the external
> +	  DDR loader.
> +
> +config MTK_GENIO_DDR_LOADER_SIZE
> +	hex "DDR-loader image region size"
> +	default 0x4b000 if TARGET_MT8188
> +	help
> +	  Size reserved for the external DDR loader at the start of the
> +	  BootROM payload. This is also the offset of U-Boot SPL and must match
> +	  the loader's SPL_OFFSET value.
> +
> +config MTK_GENIO_BL31_LOAD_ADDR
> +	hex "BL31 load and entry address"
> +	default 0x54601000 if TARGET_MT8188
> +
> +config MTK_GENIO_OPTEE_LOAD_ADDR
> +	hex "OP-TEE load address"
> +	default 0x431fffe4 if TARGET_MT8188
> +
> +config MTK_GENIO_OPTEE_ENTRY_ADDR
> +	hex "OP-TEE entry address"
> +	default 0x43200000 if TARGET_MT8188
> +
> +endif
> +
>  config MTK_TZ_MOVABLE
>  	select ARCH_MISC_INIT
>  	select OF_SYSTEM_SETUP
> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index d0d25b096e5..2048cca22b2 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -24,6 +24,8 @@ S:	Maintained
>  F:	arch/arm/dts/mt8188-u-boot.dtsi
>  F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
>  F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> +F:	arch/arm/dts/mtk-genio-*-binman.dtsi
> +F:	arch/arm/dts/mtk-genio-binman.dtsi

Should these be -u-boot.dtsi? I know the won't actually match anything
but makes it clear that the are u-boot-specific additions rather than
something that hasn't been upstreamed yet.

>  F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
>  F:	configs/mt8188.config
>  F:	configs/mt8370_genio_510_evk_defconfig
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 0618f42c941..e5d0aade7fc 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -194,6 +194,7 @@ config SPL_SHOW_ERRORS
>  config SPL_BINMAN_SYMBOLS
>  	bool "Declare binman symbols in SPL"
>  	depends on SPL_FRAMEWORK && BINMAN
> +	default n if TARGET_MT8188

I think it is unusual to add board/chip-specific things in this file as the
lists could grow very long. Maybe we can make a MTK_GENIO symbol so that we
don't have to keep adding more TARGETs here?

>  	default y
>  	help
>  	  This enables use of symbols in SPL which refer to other entries in
> 

