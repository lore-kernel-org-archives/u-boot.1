Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BECCA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4257D8309D;
	Mon, 25 Aug 2025 15:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="KSC4hnNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96EB382DA1; Mon, 25 Aug 2025 15:55:40 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF28483043
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0332a41ace=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PDe0hf027111;
 Mon, 25 Aug 2025 15:55:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 rlC89Aw8SS1zXG4ursEiIMOYcJjbg5U3weFcKVtxjMU=; b=KSC4hnNmbxm2O6l4
 gRhzpJJMy/nv6POmJfUmkBiaexoM7XVdtw8gBinBw7MBAY79fh2KqcCn9RlkLgzh
 8hpblRv/q5/4ET174sASeyGIlALoD1p5o/eZFrUXDIEb7meBUxbPr8VFZbnj+l3d
 dWQsWmTckgkHw9l7+8bYHB2ZW1HF61Cvf3XESN1hIpazX9lBtg1qqWUCsTOOhzuB
 Z6Inx/xEJGNNurBIKipf//rAYfRiHQJm3vOOROJFy+++kSiFVInQNN9PskqmWwko
 iSzmFaYOx+MQWL0ClZAIzXVgDOT0S0kpjCptYY5xh/oVeRC+ZtxW5dspOG4OVUMP
 XyonyQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q626enxk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 15:55:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0D5714002D;
 Mon, 25 Aug 2025 15:54:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 506B1450171;
 Mon, 25 Aug 2025 15:54:19 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 25 Aug
 2025 15:54:18 +0200
Message-ID: <b071f211-38a8-4eef-94ce-e1b3d02ef929@foss.st.com>
Date: Mon, 25 Aug 2025 15:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] ARM: dts: stm32: remove panel property in
 stm32mp257f-ev1-u-boot
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>, Dillon Min
 <dillon.minfei@gmail.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250820-master-v1-0-fc76f18ab2fd@foss.st.com>
 <20250820-master-v1-7-fc76f18ab2fd@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250820-master-v1-7-fc76f18ab2fd@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
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



On 8/20/25 18:17, Raphael Gallais-Pou wrote:
> SCMI regulators are not yet implemented in OP-TEE.  This leads to an
> invalid argument error when retrieving the 'power-supply' property.
> Ultimately this chains into the panel not probing and makes the whole
> display pipe fail.
> 
> Remove the property in the upstream device-tree to allow display pipe to
> boot.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi b/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
> index 9a566e18d3fd9b0cf4e21605f2cb060b49fadcb6..7a4b623664a1e167ccc0f4c73a979a083337d7a2 100644
> --- a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
> @@ -12,6 +12,10 @@
>  	};
>  };
>  
> +&panel_lvds {
> +	/delete-property/ power-supply;
> +};
> +
>  &usart2 {
>  	bootph-all;
>  };
> 

This patch is a temporary patch right ?
If yes, i am not in favor to applied this patch, i prefer to see that there is something missing.

Thanks
