Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49B1C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 778DA81DF6;
	Fri, 28 Mar 2025 09:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="OSqFLMgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB9081E1C; Fri, 28 Mar 2025 09:30:43 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F2B81DCA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6182c41fd1=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S212rS015598;
 Fri, 28 Mar 2025 09:30:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 NRvqyYO9Rhw7Ah58c/sdh1jlciJj0k34YBNvg4B62RQ=; b=OSqFLMgddzgizkJP
 0tTvU5irPGIStGnOSLoPS0TV1vXOoihoVZavmYcDNIIvdex6ztmUJNifr5rP/6Ae
 Se4y8oWlE4BYAGlezyC68UgkfUZANxFsc9Lwzdbg8+pP0IjviBFivLXsi63uDyVt
 HRXxFazvbRVGQZcRlBVu4wgmRtEbrUVHOu6Mg+IPdaTo9JdU19HUfTSQRZvf/VKM
 NpoNG0fIk8Zhxv4iKkSXf9x1yhQ+CIZKE+/yu4ydOqd0TCElxvs6pCKuI6tnbWrE
 CQDh09TMalkrYTzd6Opz7GJlSAURjIXli6kkRQR3EqXs/hmF3oYhE2s3lGxGo9i2
 Pqic8Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45me34rbhu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Mar 2025 09:30:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CD8A140087;
 Fri, 28 Mar 2025 09:28:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF5C387B01A;
 Fri, 28 Mar 2025 09:25:14 +0100 (CET)
Received: from [10.252.6.4] (10.252.6.4) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 09:25:13 +0100
Message-ID: <b37a11ae-931d-4399-8c73-705a386bcb5d@foss.st.com>
Date: Fri, 28 Mar 2025 09:25:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] ARM: dts: add stm32f769-disco-mb1166-reva09
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Fabio Estevam <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Prasad Kummari
 <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Tom Rini
 <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
 <20250324180047.1571378-5-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250324180047.1571378-5-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.6.4]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_04,2025-03-27_02,2024-11-22_01
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



On 3/24/25 19:00, Dario Binacchi wrote:
> [backport from Linux commit db4fc2c79c533986795a7750e9a12caf9d620b48]
> 
> As reported in the section 8.3 (i. e. Board revision history) of document
> UM2033 (i. e. Discovery kit with STM32F769NI MCU) these are the changes
> related to the board revision addressed by the patch:
> - Board MB1166 revision A-09:
>   - LCD FRIDA FRD397B25009-D-CTK replaced by FRIDA FRD400B25025-A-CTK
> 
> The patch adds the DTS support for the new display which belongs to the
> the Novatek NT35510-based panel family.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  arch/arm/dts/Makefile                               |  1 +
>  .../dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi   |  6 ++++++
>  arch/arm/dts/stm32f769-disco-mb1166-reva09.dts      | 13 +++++++++++++
>  3 files changed, 20 insertions(+)
>  create mode 100644 arch/arm/dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi
>  create mode 100644 arch/arm/dts/stm32f769-disco-mb1166-reva09.dts
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 267b0179a5f2..8719b58152fd 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -523,6 +523,7 @@ dtb-$(CONFIG_STM32F4) += stm32f429-disco.dtb \
>  
>  dtb-$(CONFIG_STM32F7) += stm32f746-disco.dtb \
>  	stm32f769-disco.dtb \
> +	stm32f769-disco-mb1166-reva09.dtb \
>  	stm32746g-eval.dtb
>  dtb-$(CONFIG_STM32H7) += stm32h743i-disco.dtb \
>  	stm32h743i-eval.dtb \
> diff --git a/arch/arm/dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi b/arch/arm/dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi
> new file mode 100644
> index 000000000000..43dd3b993d5e
> --- /dev/null
> +++ b/arch/arm/dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Copyright (c) 2025 Dario Binacchi <dario.binacchi@amarulasolutions.com>
> +//
> +
> +#include <stm32f769-disco-u-boot.dtsi>
> diff --git a/arch/arm/dts/stm32f769-disco-mb1166-reva09.dts b/arch/arm/dts/stm32f769-disco-mb1166-reva09.dts
> new file mode 100644
> index 000000000000..ff7ff32371d0
> --- /dev/null
> +++ b/arch/arm/dts/stm32f769-disco-mb1166-reva09.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + */
> +
> +#include "stm32f769-disco.dts"
> +
> +&panel0 {
> +	compatible = "frida,frd400b25025", "novatek,nt35510";
> +	vddi-supply = <&vcc_3v3>;
> +	vdd-supply = <&vcc_3v3>;
> +	/delete-property/power-supply;
> +};

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
