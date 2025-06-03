Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0F3C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62E9382998;
	Tue,  3 Jun 2025 16:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="7mpZxzwF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D57829B2; Tue,  3 Jun 2025 16:24:45 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A45281E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82493dba10=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553Av2w9030683;
 Tue, 3 Jun 2025 16:24:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 TqxHJFN6DykM61/VHyT/BtIHjASSxcNoGtDwwoSAh2g=; b=7mpZxzwFQepJed4A
 PqTx+EGUv96FZ7qJ+heV8cZMd2PTJyvY9JEvq3SOrz7YALObGXtSNEJY53h/GXxT
 VwPxjJAY6Mielh60m542lXT8DD4JSV2DW9nNOSnAVv3D+kHyy00Fx83mCKceYylg
 k6rhbmcNBqBu8r0fA05d2nBZ8CN+/v6Dg99u/Jf1wopAwnJp2l5n8jvKzqABFclu
 zusD76WwKPZ/J8b2a+you1Ief+Uc6NoUjuyrCfAmrIB7JNSZ/Vj+CXw1aJ3wpJWH
 d18vSvuDALys0LR/dGfga8CbsO6mnd0U85Elbw5HXOXGykrepC6EvuPTN+DYvKir
 ocl4Jg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g8tcmhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 16:24:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DBE6440059;
 Tue,  3 Jun 2025 16:23:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 76467B322D6;
 Tue,  3 Jun 2025 16:22:49 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 16:22:48 +0200
Message-ID: <c6d04a79-f36a-4eaf-a4f0-06067307cc54@foss.st.com>
Date: Tue, 3 Jun 2025 16:22:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] ARM: dts: stm32: Add stm32mp13-ddr.dtsi template
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Cheick Traore <cheick.traore@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
 <20250512172149.150214-7-marek.vasut@mailbox.org>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250512172149.150214-7-marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

Hi,

On 5/12/25 19:21, Marek Vasut wrote:
> Factor out common parts of STM32MP15xx DRAM controller configuration DT
> description into stm32mp1-ddr.dtsi and introduce stm32mp13-ddr.dtsi which
> describes STM32MP13xx DRAM controller configuration in DT.
>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Cheick Traore <cheick.traore@foss.st.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>
> Cc: Lionel Debieve <lionel.debieve@foss.st.com>
> Cc: Pascal Zimmermann <pzimmermann@dh-electronics.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>   arch/arm/dts/stm32mp1-ddr.dtsi  | 187 ++++++++++++++++++++++++++++++++
>   arch/arm/dts/stm32mp13-ddr.dtsi |  49 +++++++++
>   arch/arm/dts/stm32mp15-ddr.dtsi | 170 +----------------------------
>   3 files changed, 237 insertions(+), 169 deletions(-)
>   create mode 100644 arch/arm/dts/stm32mp1-ddr.dtsi
>   create mode 100644 arch/arm/dts/stm32mp13-ddr.dtsi
>
....
> diff --git a/arch/arm/dts/stm32mp13-ddr.dtsi b/arch/arm/dts/stm32mp13-ddr.dtsi
> new file mode 100644
> index 00000000000..30d8c5014e0
> --- /dev/null
> +++ b/arch/arm/dts/stm32mp13-ddr.dtsi
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause


For new STM32MP file avoids to use the Deprecated License Identifiers 
(GPL-2.0+ / GPL-2.0)

reference=

+https://spdx.dev/learn/handling-license-info/

+ https://spdx.org/licenses/


=>

SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause


> +/*
> + * Copyright : STMicroelectronics 2018


This copyright, with year 2018 is strange this file is copied for TF-A 
file, I think = ./fdts/stm32mp13-ddr.dtsi


Copyright (C) 2022, STMicroelectronics - All Rights Reserved


> + */
> +#ifdef CONFIG_SPL
> +&ddr {
> +	clocks = <&rcc AXIDCG>,
> +		 <&rcc DDRC1>,
> +		 <&rcc DDRPHYC>,
> +		 <&rcc DDRCAPB>,
> +		 <&rcc DDRPHYCAPB>;
> +
> +	clock-names = "axidcg",
> +		      "ddrc1",
> +		      "ddrphyc",
> +		      "ddrcapb",
> +		      "ddrphycapb";
> +
> +	config-DDR_MEM_COMPATIBLE {
> +		st,ctl-perf = <
> +			DDR_SCHED
> +			DDR_SCHED1
> +			DDR_PERFHPR1
> +			DDR_PERFLPR1
> +			DDR_PERFWR1
> +			DDR_PCFGR_0
> +			DDR_PCFGW_0
> +			DDR_PCFGQOS0_0
> +			DDR_PCFGQOS1_0
> +			DDR_PCFGWQOS0_0
> +			DDR_PCFGWQOS1_0
> +		>;
> +
> +		st,phy-reg = <
> +			DDR_PGCR
> +			DDR_ACIOCR
> +			DDR_DXCCR
> +			DDR_DSGCR
> +			DDR_DCR
> +			DDR_ODTCR
> +			DDR_ZQ0CR1
> +			DDR_DX0GCR
> +			DDR_DX1GCR
> +		>;
> +	};
> +};
> +#endif
> +
> +#include "stm32mp1-ddr.dtsi"

...

Witth the minor updates

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick



