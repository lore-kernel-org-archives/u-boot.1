Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C93BC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 09:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1996871C4;
	Thu,  9 Nov 2023 10:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="B2zF8KQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665D5871DF; Thu,  9 Nov 2023 10:17:38 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 192FF8715C
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 10:17:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9677b570d6=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3A96eWi9015559; Thu, 9 Nov 2023 10:17:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=YDYJ/fAJK+QUQlUfsVNncnLD026s4Yxn9YGhz4lQI1I=; b=B2
 zF8KQc7KCcdomsEwpN9enC15ahcioI+tuHUrgcyG5spGqdpyjOj2pisYJ+62K9gz
 Ef31q2Mjdy4QCGiNjfKXPfqOaKK1NLIQ1RhlVyhCwj+Ypi98ra5xD9FG3AuXYro0
 Y3ClGxW7InHoPwD33A9SGjy+jiJ1hUVqikTn1Vw2DryN6hPAT/6xBah4TUzrelg/
 iPlMGpdPfauAILsXOIZg38RbOCnOtMR1yre4TEvVLBNVywHTm/DLtunPIEqhZ96x
 PbG9QfmnEx/rBuuB99GMp7A1gpWU1cCg3nORXu5hdIVAis4ZrgJGwLHDZk++iJoU
 SqIRhTw+x8/NNw/Md7CA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w22fkxk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 10:17:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AFA3E10005E;
 Thu,  9 Nov 2023 10:17:34 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9FD0B20800B;
 Thu,  9 Nov 2023 10:17:34 +0100 (CET)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 Nov
 2023 10:17:33 +0100
Message-ID: <3f645d34-476e-49a1-9e3a-95e5142d6c32@foss.st.com>
Date: Thu, 9 Nov 2023 10:17:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/9] ARM: dts: stm32: Add STM32MP257F Evaluation board
 support
Content-Language: en-US
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20231027144304.1002307-1-patrice.chotard@foss.st.com>
 <20231027144304.1002307-9-patrice.chotard@foss.st.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20231027144304.1002307-9-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_07,2023-11-08_01,2023-05-22_02
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

On 10/27/23 16:43, Patrice Chotard wrote:
> Add STM32MP257F Evaluation board support. It embeds a STM32MP257FAI SoC,
> with 4GB of DDR4, TSN switch (2+1 ports), 2*USB typeA, 1*USB2 typeC,
> SNOR OctoSPI, mini PCIe, STPMIC2 for power distribution ...
>
> Sync device tree with kernel v6.6-rc1.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/dts/Makefile                       |   3 +
>   arch/arm/dts/stm32mp25-pinctrl.dtsi         |  38 +++
>   arch/arm/dts/stm32mp25-u-boot.dtsi          | 102 +++++++
>   arch/arm/dts/stm32mp251.dtsi                | 285 ++++++++++++++++++++
>   arch/arm/dts/stm32mp253.dtsi                |  23 ++
>   arch/arm/dts/stm32mp255.dtsi                |   9 +
>   arch/arm/dts/stm32mp257.dtsi                |   9 +
>   arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi    |  20 ++
>   arch/arm/dts/stm32mp257f-ev1.dts            |  55 ++++
>   arch/arm/dts/stm32mp25xc.dtsi               |   8 +
>   arch/arm/dts/stm32mp25xf.dtsi               |   8 +
>   arch/arm/dts/stm32mp25xxai-pinctrl.dtsi     |  83 ++++++
>   arch/arm/dts/stm32mp25xxak-pinctrl.dtsi     |  71 +++++
>   arch/arm/dts/stm32mp25xxal-pinctrl.dtsi     |  71 +++++
>   include/dt-bindings/pinctrl/stm32-pinfunc.h |   3 +
>   15 files changed, 788 insertions(+)
>   create mode 100644 arch/arm/dts/stm32mp25-pinctrl.dtsi
>   create mode 100644 arch/arm/dts/stm32mp25-u-boot.dtsi
>   create mode 100644 arch/arm/dts/stm32mp251.dtsi
>   create mode 100644 arch/arm/dts/stm32mp253.dtsi
>   create mode 100644 arch/arm/dts/stm32mp255.dtsi
>   create mode 100644 arch/arm/dts/stm32mp257.dtsi
>   create mode 100644 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
>   create mode 100644 arch/arm/dts/stm32mp257f-ev1.dts
>   create mode 100644 arch/arm/dts/stm32mp25xc.dtsi
>   create mode 100644 arch/arm/dts/stm32mp25xf.dtsi
>   create mode 100644 arch/arm/dts/stm32mp25xxai-pinctrl.dtsi
>   create mode 100644 arch/arm/dts/stm32mp25xxak-pinctrl.dtsi
>   create mode 100644 arch/arm/dts/stm32mp25xxal-pinctrl.dtsi
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

