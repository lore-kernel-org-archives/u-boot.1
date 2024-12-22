Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90002E77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 14:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9EA8056B;
	Sun, 22 Dec 2024 15:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZkiCGqlU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E119B80690; Sun, 22 Dec 2024 15:14:56 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AB4C8056A
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 15:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BMEEhjI108153;
 Sun, 22 Dec 2024 08:14:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734876883;
 bh=Vv/3tRNO8+jIQBQxeTOdvdWlI4KMH1u/qn6GZZ6sN5Y=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZkiCGqlUDNCE84CyjOGznR98rn8Jep3t68B04jenvRuwptWGHq+8TwA6QUVMLah5P
 JAV96W9s9XQeRHW/Ok9YegBt5HkSZiONghf8+uQek/2gxoiW1of3SGJ5p/IwpCbnee
 tSZyu88QqJPbUSCHKr+dSIVbvpoeKW5ZpxMsyCr8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BMEEhS9113263
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 22 Dec 2024 08:14:43 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 22
 Dec 2024 08:14:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 22 Dec 2024 08:14:43 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BMEEcZp013898;
 Sun, 22 Dec 2024 08:14:39 -0600
Message-ID: <a61dd9fd-96c4-4e40-9a92-6f16d846c4ee@ti.com>
Date: Sun, 22 Dec 2024 19:44:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 8/8] configs: Introduce configs for J742S2
To: Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Keerthy
 <j-keerthy@ti.com>, <u-kumar1@ti.com>
References: <20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com>
 <20241217-b4-upstream-j742s2-v1-8-13a6a127b344@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241217-b4-upstream-j742s2-v1-8-13a6a127b344@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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


On 12/17/2024 4:37 PM, Manorit Chawdhry wrote:
> Based off j784s4 configs with delta changes for J742S2
>
> [ Add AVS support for J742S2 ]
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   board/ti/j784s4/MAINTAINERS      | 2 ++
>   configs/j742s2_evm_a72_defconfig | 9 +++++++++
>   configs/j742s2_evm_r5_defconfig  | 9 +++++++++
>   3 files changed, 20 insertions(+)
>
> diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
> index bc3a726228c75e7db7547abd2d7d6a13f043bdae..b289c639f3f880ef50b2e0b2c7e586c7d2ccad71 100644
> --- a/board/ti/j784s4/MAINTAINERS
> +++ b/board/ti/j784s4/MAINTAINERS
> @@ -28,3 +28,5 @@ F:	arch/arm/dts/k3-j784s4-j742s2-ddr.dtsi
>   F:	arch/arm/dts/k3-j742s2-r5-evm.dts
>   F:	arch/arm/dts/k3-j742s2-evm-u-boot.dtsi
>   F:	arch/arm/dts/k3-j742s2-ddr-evm-lp4-4266.dtsi
> +F:	configs/j742s2_evm_r5_defconfig
> +F:	configs/j742s2_evm_a72_defconfig
> diff --git a/configs/j742s2_evm_a72_defconfig b/configs/j742s2_evm_a72_defconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..e534ce4c2e3bf28a78eff241c4b035917e3fb61c
> --- /dev/null
> +++ b/configs/j742s2_evm_a72_defconfig
> @@ -0,0 +1,9 @@
> +#include <configs/j784s4_evm_a72_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SOC_K3_J784S4=y
> +CONFIG_TARGET_J742S2_A72_EVM=y
> +
> +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-j742s2-evm"
> +CONFIG_SPL_OF_LIST="ti/k3-j742s2-evm"
> diff --git a/configs/j742s2_evm_r5_defconfig b/configs/j742s2_evm_r5_defconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..2be6318df76632dd2cc5cbeebcb6ce674cd80338
> --- /dev/null
> +++ b/configs/j742s2_evm_r5_defconfig
> @@ -0,0 +1,9 @@
> +#include <configs/j784s4_evm_r5_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SOC_K3_J784S4=y

Isn't above enabled by j784s4_evm_r5_defconfig


> +CONFIG_TARGET_J742S2_R5_EVM=y
> +CONFIG_DEFAULT_DEVICE_TREE="k3-j742s2-r5-evm"
> +CONFIG_SPL_OF_LIST="k3-j742s2-r5-evm"

Also, AVS is enable with 
https://lore.kernel.org/all/20241118105714.1973573-2-n-francis@ti.com/ 
series

So please update k3_avs.c if needed as part of initial series.


