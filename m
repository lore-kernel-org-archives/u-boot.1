Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D50E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 10:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E844805F0;
	Thu,  9 Jan 2025 11:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="fvZceEUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 991F98005B; Thu,  9 Jan 2025 11:24:08 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E3F8060A
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 11:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3104a8932e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5098Vj70023173;
 Thu, 9 Jan 2025 11:24:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Mq1wgX+MCJ77CmvXuyQ+uxauAewWPNk5HdFKeICvgP4=; b=fvZceEUI5iII7+iG
 O4yj5DcQRqJQ9AbjTsSf+HxMBKiXrVmh9EJl4vDjiVDfMVWhHgWq6fzJgG0yF5ZI
 JMfZDOamJ5euNZbNg0lsr87VjF+SAC4i+XBshBuV8xvDwiQyZCCqMfLbPYQCbogq
 QXWjO9Jz9gOEfxIR2eaJMduFZURZ30u9Nr0bP/Q1UfPxrEkXf/bwoSPcQC476FQM
 N7SIqDjqsRQnLBtcbEh74lHI6DCYIaxcP5aOjyaZjyV0D5GVK0YO4WDjewIKAgTp
 SdzoouUoDUzUHOkeCV0O6vIqDs63FTHKsEGWbhVfCm0l4mObdqjTRg+PlohVMuFY
 CnZgSw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 441u78uw9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 11:24:04 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3E4904004D;
 Thu,  9 Jan 2025 11:23:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8FC5D22B143;
 Thu,  9 Jan 2025 11:22:39 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 9 Jan
 2025 11:22:39 +0100
Message-ID: <c4fe14d9-6b7c-469d-b63c-3e972905f77a@foss.st.com>
Date: Thu, 9 Jan 2025 11:22:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2]
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250109101838.1733468-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250109101838.1733468-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

Don't take care of this series, i will resend it with correct cover letter title

Sorry
Patrice

On 1/9/25 11:18, Patrice Chotard wrote:
> stm32mp: Restore STM32MP257F-EV1 boot
> 
> This series is restoring STM32MP257F-EV1 boot :
>   _ Fix usart2 clock frequency
>   _ Fix board_get_usable_ram_top()
> 
> 
> 
> Patrice Chotard (2):
>   stm32mp: Fix board_get_usable_ram_top()
>   ARM: dts: stm32: Update ck_flexgen_08 frequency.
> 
>  arch/arm/dts/stm32mp251.dtsi      | 2 +-
>  arch/arm/mach-stm32mp/dram_init.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
