Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB25C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 584E6883C2;
	Thu,  6 Jun 2024 16:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="cEKZxoim";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB7388247; Thu,  6 Jun 2024 16:37:39 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7060B8806C
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6887058c03=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456DATRa011730;
 Thu, 6 Jun 2024 16:37:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 czoVYV/NdlrIgvtP3o9EKuzTXl9I60xfWKYpBIXK16g=; b=cEKZxoimKHLXp8CL
 31MzR63TtX23lSXfFCLVh0zJqvFxI7CB9L0kUkLXuQzbajkWH2n1O0+s5G5Qqh9I
 ujyuz/CXEFkgU7HZHuaUNfg6UJ6vIemmQb1GCXjQ4FJdHT9lQnJYL/8DmKO3KFa2
 cS4ZWObB0q+g73VWv9E+ucN80JCt2DkZ1gRD/DSxjKm49NPqVZGSy0NZIL7KPMIP
 endDgqh4OFfiKHyYGESBXDoD+AeWK24v7/3IaKCR9ADyPqGEXO3qf0G3QOhjyV19
 u4yfhHhGFt9JHFYB6JSo1+WNjyL4jzHh4qckC0BdDdGTC/KTAdHOsJrl9R0Qp8T9
 k8o/Ig==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ygekj4r9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 16:37:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C10E44004B;
 Thu,  6 Jun 2024 16:37:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 72C512248BE;
 Thu,  6 Jun 2024 16:37:23 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:37:23 +0200
Message-ID: <d25061ab-77f1-45ca-a36a-cbaecb15e6b2@foss.st.com>
Date: Thu, 6 Jun 2024 16:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dts: stm32mp157c-odyssey: use internal clock for Tx
To: Heesub Shin <heesub@gmail.com>, <u-boot@lists.denx.de>
References: <20240428142406.28445-1-heesub@gmail.com>
 <20240428142406.28445-2-heesub@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240428142406.28445-2-heesub@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
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



On 4/28/24 16:24, Heesub Shin wrote:
> In Odyssey board, we should use the internal clock from RCC as the
> transmit clock, instead of the external clock from ETH_CLK125 pad. This
> commit adds a property, st,eth-clk-sel, so that the ETH_CLK_SEL mux
> selects ETH_CLK.
> 
> Signed-off-by: Heesub Shin <heesub@gmail.com>
> ---
>  arch/arm/dts/stm32mp157c-odyssey.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/dts/stm32mp157c-odyssey.dts b/arch/arm/dts/stm32mp157c-odyssey.dts
> index 17bcf56f74..53ba018197 100644
> --- a/arch/arm/dts/stm32mp157c-odyssey.dts
> +++ b/arch/arm/dts/stm32mp157c-odyssey.dts
> @@ -75,6 +75,7 @@
>  	phy-mode = "rgmii-id";
>  	max-speed = <1000>;
>  	phy-handle = <&phy0>;
> +	st,ext-phyclk;
>  
>  	mdio0 {
>  		#address-cells = <1>;

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
