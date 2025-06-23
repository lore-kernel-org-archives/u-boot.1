Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5409BC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 07:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F2E581F66;
	Mon, 23 Jun 2025 09:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="wXL7SI3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1041C81FEE; Mon, 23 Jun 2025 09:25:06 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A2180548
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 09:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82692562d4=fabrice.gasnier@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N6lBHa002078;
 Mon, 23 Jun 2025 09:25:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 HTK8JKQ4BHDVqZosB5s/ONuJ2J4lfiogpfoSc/gtTqE=; b=wXL7SI3P61Ki45aS
 NaNS8hkUWebtzzg793n7mCcTT2Se39jRJwh6uEbYxE8w9GclWFGedRRCeAYycN6w
 sLFWK5Hu+WQifXJ7q+eXMJI6Jz6rwmqQCIWYVUR99UQc+YQqTwXcR8xdwtgpwRYI
 o+xrpP1vd5b3bMeeapWrYBfhW10Cwag7xMsMLH8aEJ0r+fDDwVLoe9VIFBCOeZLY
 IXO6AgbwnNeay2EkhHTP+ynCTWo628GnW6qASrbvmTWcHDwjYW1/+cU+2ef18n4X
 BC4mQpyBUSzKao3fFxXbDkQx/B24mgEmIe2ft/vl12l5HwKOno9lPPT9KZAADiZq
 z7LA3Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47e7pp3mn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 09:25:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2A5254002D;
 Mon, 23 Jun 2025 09:23:40 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E94EB6C0D2;
 Mon, 23 Jun 2025 09:22:33 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 09:22:32 +0200
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 09:22:32 +0200
Message-ID: <e64bf5d1-b19d-49c1-9d2b-ee4bfbe29448@foss.st.com>
Date: Mon, 23 Jun 2025 09:22:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for STM32 TIMERS and STM32 PWM on
 STM32MP25
To: Cheick Traore <cheick.traore@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250620155000.1258718-1-cheick.traore@foss.st.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250620155000.1258718-1-cheick.traore@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.222]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_02,2025-06-20_01,2025-03-28_01
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

Hi Cheick,

On 6/20/25 17:49, Cheick Traore wrote:
> 
> This serie adds:
> * drivers support on stm32mp25 for MFD STM32 TIMERS and STM32 PWM
> * enable these drivers on stm32mp25
> 
> 
> Cheick Traore (3):
>   arm: stm32mp2: add multifunction timer support for stm32mp25
>   pwm: stm32: add support for stm32mp25
>   configs: stm32mp25: Enable MFD timer and PWM for stm32mp25_defconfig

For this series, you can add my:

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> 
>  arch/arm/mach-stm32mp/include/mach/timers.h |  9 ++++++
>  arch/arm/mach-stm32mp/timers.c              | 34 ++++++++++++++++++++-
>  configs/stm32mp25_defconfig                 |  4 +++
>  drivers/pwm/pwm-stm32.c                     | 11 ++++++-
>  4 files changed, 56 insertions(+), 2 deletions(-)
> 
