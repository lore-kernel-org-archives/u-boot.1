Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89729C369CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 08:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AEA980F03;
	Tue, 22 Apr 2025 10:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Ddy6+Zed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1347E81026; Tue, 22 Apr 2025 10:09:54 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 235F0809D4
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 10:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=620721f65c=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M7gssm028458;
 Tue, 22 Apr 2025 10:09:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 6Xa29XxqCzGoXKx6EmLDgCT4EFUQ4Fv4LmwS8hl4dDM=; b=Ddy6+ZedH65lU+r5
 Jcg+wokZIq+brOKJ3IJOXrwVZMGOgIIcsBIQ62afgi1tiLqMJ5IDnBlNBO8gjwAu
 0MevT9p0FuU2n3794ehmQJszLCyZEU7jaoZrWTeHnhR0J+yqzuzE5A8FGABdrnZg
 JACta7OeneYK29wxMuk/9VveSpxTIL1MTZP3F+WDwKlOSi+qJRLMPFCe4b1aK/Ci
 pVp7pDd7eJKRwLWF+xeeNVbeh2KnVq+up2FOCV/QrocvBvBvjyfATLnw24C1gzSd
 nN4fUf7mzDZX1lcTNZn6DEcbO3kz639LvdR5D53wf2rSmlUDyOuaSvuGnqQQ1Tcd
 hjstyg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4640y80y95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 10:09:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CFC1540048;
 Tue, 22 Apr 2025 10:07:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 22F629C848C;
 Tue, 22 Apr 2025 10:06:28 +0200 (CEST)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 10:06:27 +0200
Message-ID: <90ffbe15-8b0f-44ec-9d19-08e660b8e8e8@foss.st.com>
Date: Tue, 22 Apr 2025 10:06:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] ARM: dts: stm32: convert stm23f7 boards to
 OF_UPSTREAM
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Adam Ford
 <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Linus Walleij <linus.walleij@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250401131413.387139-1-patrice.chotard@foss.st.com>
 <20250401131413.387139-4-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250401131413.387139-4-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
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

On 4/1/25 15:14, Patrice Chotard wrote:
> Enable OF_UPSTREAM flag for STM32F7 platforms.
>
> Use upstream device tree for DSI and LTDC nodes,
> As now in upstream DT, in panel@0 node, power-supply property is
> present, which is a fixed-regulator, add DM_REGULATOR_FIXED flag
> for stm32f769-disco boards.
>
> Set also DEFAULT_FDT_FILE in defconfigs and use it in stm32f746-disco.h
> to indicate which FDT file to load (All STM32F7 boards are using this
> file).
>
> If something is missing, it must be added in upstream device tree
> in linux kernel ("px_clk" for DSI by example).
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/dts/Makefile                    |   4 -
>   arch/arm/dts/stm32746g-eval.dts          | 186 -------
>   arch/arm/dts/stm32f7-pinctrl.dtsi        | 415 ---------------
>   arch/arm/dts/stm32f746-disco-u-boot.dtsi |  13 +-
>   arch/arm/dts/stm32f746-disco.dts         | 169 -------
>   arch/arm/dts/stm32f746-pinctrl.dtsi      |  11 -
>   arch/arm/dts/stm32f746.dtsi              | 613 -----------------------
>   arch/arm/dts/stm32f769-disco-u-boot.dtsi |  60 +--
>   arch/arm/dts/stm32f769-disco.dts         | 133 -----
>   arch/arm/dts/stm32f769-pinctrl.dtsi      |  11 -
>   arch/arm/mach-stm32/Kconfig              |   1 +
>   configs/stm32746g-eval_defconfig         |   3 +-
>   configs/stm32746g-eval_spl_defconfig     |   3 +-
>   configs/stm32f746-disco_defconfig        |   3 +-
>   configs/stm32f746-disco_spl_defconfig    |   3 +-
>   configs/stm32f769-disco_defconfig        |   4 +-
>   configs/stm32f769-disco_spl_defconfig    |   4 +-
>   include/configs/stm32f746-disco.h        |   2 +-
>   18 files changed, 34 insertions(+), 1604 deletions(-)
>   delete mode 100644 arch/arm/dts/stm32746g-eval.dts
>   delete mode 100644 arch/arm/dts/stm32f7-pinctrl.dtsi
>   delete mode 100644 arch/arm/dts/stm32f746-disco.dts
>   delete mode 100644 arch/arm/dts/stm32f746-pinctrl.dtsi
>   delete mode 100644 arch/arm/dts/stm32f746.dtsi
>   delete mode 100644 arch/arm/dts/stm32f769-disco.dts
>   delete mode 100644 arch/arm/dts/stm32f769-pinctrl.dtsi
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


