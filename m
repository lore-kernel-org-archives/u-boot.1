Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFBEC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 10:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE68E807C4;
	Thu, 30 Jan 2025 11:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bShsW+b1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9920E809D0; Thu, 30 Jan 2025 11:55:37 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF5E8076E
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4125fc93c8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UAouCu002195;
 Thu, 30 Jan 2025 11:55:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 XuOoeOa/elVZ17KltJJSA87o/3Vg+3K3KylcmKS15Eo=; b=bShsW+b111Vc3Xyi
 ks6v+fXYitmdsY6DZIPLowcr+20gnovObrVzLJNcy2YDG8iROADF3En/3ggPTKwz
 jzZWHO3+fcytH6fbh54MFcUjm+EtKk3aAnAhTLUgG7huSqHpE91QoCIrxo+0fVpO
 RfFA/Y6lwXcLyRqy8rVDBAeDHM9btE8I/Cabo+AcFQVYkqC03zEzZDn4sZCMsHrx
 G4nL9xe31CdJzZglDS+d3toLRI9s31BBPOy+dooSo/+HBFBhFt6J9Yfmrx9cP642
 aIS/x+JqNgNV+FbPbPwoY48lDs9RoJPh2bulTRfunnUBEnqxO/gpeBkB7RGzzVAz
 JyLz0w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44fy471tfy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 11:55:34 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E7E6240044;
 Thu, 30 Jan 2025 11:54:32 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6E8FE2EEF14;
 Thu, 30 Jan 2025 11:52:48 +0100 (CET)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 11:52:48 +0100
Message-ID: <2214355c-e1b3-4bab-af47-f06030e7a540@foss.st.com>
Date: Thu, 30 Jan 2025 11:52:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: stm32: Update ck_flexgen_08 frequency.
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Tom Rini <trini@konsulko.com>
References: <20250109102148.1733810-1-patrice.chotard@foss.st.com>
 <20250109102148.1733810-3-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250109102148.1733810-3-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
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

On 1/9/25 11:21, Patrice Chotard wrote:
> Spurious characters are displayed on U-Boot console.
> Usart2 clock is ck_flexgen_08 and its frequency is set
> to an incorrect value.
>
> Update ck_flexgen_08 frequency from 100MHz to 64MHz.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>
> ---
>
>   arch/arm/dts/stm32mp251.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/stm32mp251.dtsi b/arch/arm/dts/stm32mp251.dtsi
> index 44eb664fb51..e2d1c88a57f 100644
> --- a/arch/arm/dts/stm32mp251.dtsi
> +++ b/arch/arm/dts/stm32mp251.dtsi
> @@ -38,7 +38,7 @@
>   		ck_flexgen_08: ck-flexgen-08 {
>   			#clock-cells = <0>;
>   			compatible = "fixed-clock";
> -			clock-frequency = <100000000>;
> +			clock-frequency = <64000000>;
>   		};
>   
>   		ck_flexgen_51: ck-flexgen-51 {


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


