Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CDDC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 13:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1482E87822;
	Fri, 10 Nov 2023 14:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="LERFJOkZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C5458781D; Fri, 10 Nov 2023 14:23:57 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82B7187815
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 14:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9678822151=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AABdBrC006188; Fri, 10 Nov 2023 14:23:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=5uhme6BvYSilLlKpwn+XNWeoPB4HLWE9/Q5kSbsbAzY=; b=LE
 RFJOkZl3bkG/q+K0EnK7aZ82S5a2NduXIwhcHc1SltTqJBNoG6U6e3NWYmIB+3FH
 HVi9ycfpvgxA+SAu9eiiswOLyGM1L/pgfISHSI6yysL31rESxYia0PNxVZBgL+7u
 LIwbh8wVEeriZ+m4L000g0maZjit1Uw9APA/BiMlb/s8il5jy+KpnodC8kaELNb7
 XACEY5tNZu3LNhadMyIvYN/fPFvZSu9Z5Pqm8LDAGrgOe8Plnl4dIkf3iY8TqO7j
 2qZvZw7ZXET6ABfFzX5DU8ZYjE8c2dzILMAiArj6ZNJWAcJXAqTI1Qe7Ia1G+PHk
 xKq5YFyYYujsKHVtwegA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u9fmn9x8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 14:23:54 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 92D9210005E;
 Fri, 10 Nov 2023 14:23:46 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8B00824C443;
 Fri, 10 Nov 2023 14:23:46 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 10 Nov
 2023 14:23:46 +0100
Message-ID: <43bd0525-5c04-4fb8-b02a-727f45d6f27e@foss.st.com>
Date: Fri, 10 Nov 2023 14:23:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/9] ARM: dts: stm32: Add STM32MP257F Evaluation board
 support
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20231027144304.1002307-1-patrice.chotard@foss.st.com>
 <20231027144304.1002307-9-patrice.chotard@foss.st.com>
 <3f645d34-476e-49a1-9e3a-95e5142d6c32@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <3f645d34-476e-49a1-9e3a-95e5142d6c32@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.54]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_10,2023-11-09_01,2023-05-22_02
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



On 11/9/23 10:17, Patrick DELAUNAY wrote:
> Hi,
> 
> On 10/27/23 16:43, Patrice Chotard wrote:
>> Add STM32MP257F Evaluation board support. It embeds a STM32MP257FAI SoC,
>> with 4GB of DDR4, TSN switch (2+1 ports), 2*USB typeA, 1*USB2 typeC,
>> SNOR OctoSPI, mini PCIe, STPMIC2 for power distribution ...
>>
>> Sync device tree with kernel v6.6-rc1.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/Makefile                       |   3 +
>>   arch/arm/dts/stm32mp25-pinctrl.dtsi         |  38 +++
>>   arch/arm/dts/stm32mp25-u-boot.dtsi          | 102 +++++++
>>   arch/arm/dts/stm32mp251.dtsi                | 285 ++++++++++++++++++++
>>   arch/arm/dts/stm32mp253.dtsi                |  23 ++
>>   arch/arm/dts/stm32mp255.dtsi                |   9 +
>>   arch/arm/dts/stm32mp257.dtsi                |   9 +
>>   arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi    |  20 ++
>>   arch/arm/dts/stm32mp257f-ev1.dts            |  55 ++++
>>   arch/arm/dts/stm32mp25xc.dtsi               |   8 +
>>   arch/arm/dts/stm32mp25xf.dtsi               |   8 +
>>   arch/arm/dts/stm32mp25xxai-pinctrl.dtsi     |  83 ++++++
>>   arch/arm/dts/stm32mp25xxak-pinctrl.dtsi     |  71 +++++
>>   arch/arm/dts/stm32mp25xxal-pinctrl.dtsi     |  71 +++++
>>   include/dt-bindings/pinctrl/stm32-pinfunc.h |   3 +
>>   15 files changed, 788 insertions(+)
>>   create mode 100644 arch/arm/dts/stm32mp25-pinctrl.dtsi
>>   create mode 100644 arch/arm/dts/stm32mp25-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/stm32mp251.dtsi
>>   create mode 100644 arch/arm/dts/stm32mp253.dtsi
>>   create mode 100644 arch/arm/dts/stm32mp255.dtsi
>>   create mode 100644 arch/arm/dts/stm32mp257.dtsi
>>   create mode 100644 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/stm32mp257f-ev1.dts
>>   create mode 100644 arch/arm/dts/stm32mp25xc.dtsi
>>   create mode 100644 arch/arm/dts/stm32mp25xf.dtsi
>>   create mode 100644 arch/arm/dts/stm32mp25xxai-pinctrl.dtsi
>>   create mode 100644 arch/arm/dts/stm32mp25xxak-pinctrl.dtsi
>>   create mode 100644 arch/arm/dts/stm32mp25xxal-pinctrl.dtsi
>>
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/next

Thanks
Patrice
