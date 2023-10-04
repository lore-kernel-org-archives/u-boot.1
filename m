Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EC3E7B5E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACA1874B1;
	Wed,  4 Oct 2023 11:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="OXqZx9KK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7ACC874B4; Wed,  4 Oct 2023 11:55:45 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C2886EA3
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8641a2a2c4=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39450H3o026784; Wed, 4 Oct 2023 11:55:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=rf76t6ChcusOmshBrH/jwUhR2UF8R8ZSIAcvNBgOzk8=; b=OX
 qZx9KKbE6YzTtcG6amu3RxOrXLsC9/9feZjEZuYeHTtBozQxZm9VIUf2czjbfX/z
 E0AaxMZh6tBnRhLjqguN6l7X6kpKPXEpmfm/zMgkaEuYIutOSVI+9uear+tVAIxC
 3b6byDqDcQKJTSwc7ZBiplEchp3R5nr1vW9grOkQvOJntxi2NjJJL+8qmaOs9t5K
 zGHq0GAbVFcIsIE75It1G2qE6Cd2J42zBr4EcOpxsVW3H7Sa+Lx23b3PFkpA/3rg
 V/MnVMLnOaaqc9uSADvv9o1WQiEO4ZSBJQfpXeylVGCqck80HDodRC/owhq8ovTS
 YmSU77wyakFnshM98XQw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tew80p09s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 11:55:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EC849100053;
 Wed,  4 Oct 2023 11:55:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DE6D222F7A4;
 Wed,  4 Oct 2023 11:55:40 +0200 (CEST)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 11:55:39 +0200
Message-ID: <85fc4468-136b-4d26-b249-50f147722377@foss.st.com>
Date: Wed, 4 Oct 2023 11:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/6] ARM: dts: stm32mp: alignment with v6.6-rc1
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Jagan Teki
 <jagan@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Tom Rini <trini@konsulko.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230926150924.1150082-1-patrice.chotard@foss.st.com>
 <20230926150924.1150082-2-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20230926150924.1150082-2-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
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

On 9/26/23 17:09, Patrice Chotard wrote:
> Device tree alignment with Linux kernel v6.6.rc1.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/dts/stm32mp131.dtsi                  |  52 +--
>   arch/arm/dts/stm32mp135f-dk.dts               |  68 ++--
>   arch/arm/dts/stm32mp15-pinctrl.dtsi           | 364 +++++++++++++++++-
>   arch/arm/dts/stm32mp15-scmi.dtsi              |   7 +-
>   arch/arm/dts/stm32mp151.dtsi                  |  34 +-
>   arch/arm/dts/stm32mp157.dtsi                  |  15 +-
>   arch/arm/dts/stm32mp157a-dk1-scmi.dts         |   7 +-
>   ...157a-microgea-stm32mp1-microdev2.0-of7.dts |   3 +
>   arch/arm/dts/stm32mp157c-dk2-scmi.dts         |   7 +-
>   arch/arm/dts/stm32mp157c-dk2.dts              |  30 +-
>   arch/arm/dts/stm32mp157c-ed1-scmi.dts         |   7 +-
>   arch/arm/dts/stm32mp157c-ed1.dts              |  24 +-
>   arch/arm/dts/stm32mp157c-ev1-scmi.dts         |   7 +-
>   arch/arm/dts/stm32mp157c-ev1.dts              |  34 +-
>   arch/arm/dts/stm32mp15xx-dkx.dtsi             |  42 +-
>   include/dt-bindings/clock/stm32mp1-clks.h     |   2 +-
>   include/dt-bindings/clock/stm32mp13-clks.h    |   2 +-
>   .../regulator/st,stm32mp13-regulator.h        |  42 ++
>   include/dt-bindings/reset/stm32mp1-resets.h   |   2 +-
>   include/dt-bindings/reset/stm32mp13-resets.h  |   2 +-
>   20 files changed, 585 insertions(+), 166 deletions(-)
>   create mode 100644 include/dt-bindings/regulator/st,stm32mp13-regulator.h
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick



