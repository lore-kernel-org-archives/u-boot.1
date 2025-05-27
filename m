Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC19BC54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC01783877;
	Tue, 27 May 2025 15:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="l0HGz8OU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A0C83865; Tue, 27 May 2025 15:24:43 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7318380E
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCdO4H013199;
 Tue, 27 May 2025 15:24:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 iBRfSxFxlCyJswOrVtgTqAPZKchXIpaR7Z8AQ0kGYuo=; b=l0HGz8OUUCCgcLvM
 l4sC3+tXQJG1r/5fLbkICqsgJHqwocy/ThotI/Zd1n4fPdw7QyVD2N3+I+RduBv2
 eLdWHO+iDTE51mJ5SPFzrOzcHVuXb1McC1UAi1NoGdroEtJu+AXpIX6oFyqZVsbz
 eGtwoLtLADfExHRbe0iH9bsKz4aMXgcinVzJPycWmnDJPRvIOjlkHjeQRrNXBi/H
 /5W3xXtL5noKEQprCgz0Wt4JS9VYLVMoFMhUqTLO6UM3GpH2oe4numz6e/AIEWcb
 07cLRLID1/P5NSxQhi+bMTUJmkfCS/RHSX5EmMxZ5j1LBs1/sfZDTNNLKcMpHVal
 wBzC0A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46u388v32v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:24:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 26C0A4004A;
 Tue, 27 May 2025 15:23:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A13F6AEA23F;
 Tue, 27 May 2025 15:23:19 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:23:19 +0200
Message-ID: <f85452b5-45fa-4097-8649-517c6b1f143c@foss.st.com>
Date: Tue, 27 May 2025 15:23:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] arm: dts: add STM32H747 discovery board
To: Johannes Krottmayer <johannes@krotti42.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
 <20250508212058.640483-9-johannes@krotti42.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250508212058.640483-9-johannes@krotti42.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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



On 5/8/25 23:24, Johannes Krottmayer wrote:
> Add initial support for the STM32H747 discovery baord. Copied
> from the STM32H743 discovery board.
> 
> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  arch/arm/dts/stm32h747i-disco-u-boot.dtsi | 101 ++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 arch/arm/dts/stm32h747i-disco-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/stm32h747i-disco-u-boot.dtsi b/arch/arm/dts/stm32h747i-disco-u-boot.dtsi
> new file mode 100644
> index 00000000000..02e28c63f28
> --- /dev/null
> +++ b/arch/arm/dts/stm32h747i-disco-u-boot.dtsi
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <stm32h7-u-boot.dtsi>
> +
> +&fmc {
> +
> +	/*
> +	 * Memory configuration from sdram datasheet IS42S32800G-6BLI
> +	 * first bank is bank@0
> +	 * second bank is bank@1
> +	 */
> +	bank1: bank@1 {
> +		st,sdram-control = /bits/ 8 <NO_COL_9
> +					     NO_ROW_12
> +					     MWIDTH_32
> +					     BANKS_4
> +					     CAS_2
> +					     SDCLK_3
> +					     RD_BURST_EN
> +					     RD_PIPE_DL_0>;
> +		st,sdram-timing = /bits/ 8 <TMRD_1
> +					    TXSR_1
> +					    TRAS_1
> +					    TRC_6
> +					    TRP_2
> +					    TWR_1
> +					    TRCD_1>;
> +		st,sdram-refcount = <1539>;
> +	};
> +};
> +
> +&pinctrl {
> +	fmc_pins: fmc@0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('D', 0, AF12)>,
> +				 <STM32_PINMUX('D', 1, AF12)>,
> +				 <STM32_PINMUX('D', 8, AF12)>,
> +				 <STM32_PINMUX('D', 9, AF12)>,
> +				 <STM32_PINMUX('D',10, AF12)>,
> +				 <STM32_PINMUX('D',14, AF12)>,
> +				 <STM32_PINMUX('D',15, AF12)>,
> +
> +				 <STM32_PINMUX('E', 0, AF12)>,
> +				 <STM32_PINMUX('E', 1, AF12)>,
> +				 <STM32_PINMUX('E', 7, AF12)>,
> +				 <STM32_PINMUX('E', 8, AF12)>,
> +				 <STM32_PINMUX('E', 9, AF12)>,
> +				 <STM32_PINMUX('E',10, AF12)>,
> +				 <STM32_PINMUX('E',11, AF12)>,
> +				 <STM32_PINMUX('E',12, AF12)>,
> +				 <STM32_PINMUX('E',13, AF12)>,
> +				 <STM32_PINMUX('E',14, AF12)>,
> +				 <STM32_PINMUX('E',15, AF12)>,
> +
> +				 <STM32_PINMUX('F', 0, AF12)>,
> +				 <STM32_PINMUX('F', 1, AF12)>,
> +				 <STM32_PINMUX('F', 2, AF12)>,
> +				 <STM32_PINMUX('F', 3, AF12)>,
> +				 <STM32_PINMUX('F', 4, AF12)>,
> +				 <STM32_PINMUX('F', 5, AF12)>,
> +				 <STM32_PINMUX('F',11, AF12)>,
> +				 <STM32_PINMUX('F',12, AF12)>,
> +				 <STM32_PINMUX('F',13, AF12)>,
> +				 <STM32_PINMUX('F',14, AF12)>,
> +				 <STM32_PINMUX('F',15, AF12)>,
> +
> +				 <STM32_PINMUX('G', 0, AF12)>,
> +				 <STM32_PINMUX('G', 1, AF12)>,
> +				 <STM32_PINMUX('G', 2, AF12)>,
> +				 <STM32_PINMUX('G', 4, AF12)>,
> +				 <STM32_PINMUX('G', 5, AF12)>,
> +				 <STM32_PINMUX('G', 8, AF12)>,
> +				 <STM32_PINMUX('G',15, AF12)>,
> +
> +				 <STM32_PINMUX('H', 5, AF12)>,
> +				 <STM32_PINMUX('H', 6, AF12)>,
> +				 <STM32_PINMUX('H', 7, AF12)>,
> +				 <STM32_PINMUX('H', 8, AF12)>,
> +				 <STM32_PINMUX('H', 9, AF12)>,
> +				 <STM32_PINMUX('H',10, AF12)>,
> +				 <STM32_PINMUX('H',11, AF12)>,
> +				 <STM32_PINMUX('H',12, AF12)>,
> +				 <STM32_PINMUX('H',13, AF12)>,
> +				 <STM32_PINMUX('H',14, AF12)>,
> +				 <STM32_PINMUX('H',15, AF12)>,
> +
> +				 <STM32_PINMUX('I', 0, AF12)>,
> +				 <STM32_PINMUX('I', 1, AF12)>,
> +				 <STM32_PINMUX('I', 2, AF12)>,
> +				 <STM32_PINMUX('I', 3, AF12)>,
> +				 <STM32_PINMUX('I', 4, AF12)>,
> +				 <STM32_PINMUX('I', 5, AF12)>,
> +				 <STM32_PINMUX('I', 6, AF12)>,
> +				 <STM32_PINMUX('I', 7, AF12)>,
> +				 <STM32_PINMUX('I', 9, AF12)>,
> +				 <STM32_PINMUX('I',10, AF12)>;
> +
> +			slew-rate = <3>;
> +		};
> +	};
> +};

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
