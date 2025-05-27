Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D7EC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20883830D9;
	Tue, 27 May 2025 15:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="jbJe2/N7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4961982A25; Tue, 27 May 2025 15:01:44 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546FF83086
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCw4ew003897;
 Tue, 27 May 2025 15:01:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 +RtHBwk2UDu8eptpWNrfvL+9vVwyBADwGW/6WUKVECY=; b=jbJe2/N7Xg3gjedp
 I4pKVPm7qqDKQg0drgK8A8kHmNISsBHZToKrnKdiUohdNgxKpJ2k2w4voXZICH+7
 Y0nc9xjlWJd7dtJg2cIBQg/lHq9ySFcaOFDRyEFVCdPACv+vONw8g2JuPFtc/2JI
 RdPY5eXouPOYbjU85kZPYZck9HKg32DH5H7vrqq3rwfKbZ9YMZG4Z7g/7jC/y+Fi
 o8JG1aR9d2044N6DwEQVfPPDNuivVYEVCEsnMgPs7XnW5xw6fcmHzddsOp6hnakJ
 duCbholkChiRx8Yjk+MZvkTwqvHuU1t8qHGh3Z7zc3Uo8VGhl7bo246OwCrc+T78
 wYpxVg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46u3hk4dx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:01:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E9B804006E;
 Tue, 27 May 2025 15:00:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7C51A9DCA1;
 Tue, 27 May 2025 15:00:17 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:00:17 +0200
Message-ID: <0d7274a5-491f-4c43-92bd-8950c3312662@foss.st.com>
Date: Tue, 27 May 2025 15:00:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] arm: mach-stm32: stm32h7: add initial Makefile
To: Johannes Krottmayer <johannes@krotti42.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
 <20250508212058.640483-3-johannes@krotti42.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250508212058.640483-3-johannes@krotti42.com>
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



On 5/8/25 23:23, Johannes Krottmayer wrote:
> Add initial Makefile for the STM32H7 series:
> 
> Currently it includes only one additional assembly source file
> which is required for the STM32H747I-DISCO board.
> 
> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  arch/arm/mach-stm32/stm32h7/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 arch/arm/mach-stm32/stm32h7/Makefile
> 
> diff --git a/arch/arm/mach-stm32/stm32h7/Makefile b/arch/arm/mach-stm32/stm32h7/Makefile
> new file mode 100644
> index 00000000000..a70d4b445db
> --- /dev/null
> +++ b/arch/arm/mach-stm32/stm32h7/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# (C) Copyright 2025
> +# Johannes Krottmayer <johannes@krotti42.com>
> +
> +obj-y += lowlevel.o
Hi Johannes

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
