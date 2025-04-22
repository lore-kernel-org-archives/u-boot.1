Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411B8C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 08:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E8680F03;
	Tue, 22 Apr 2025 10:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="MnMTuK5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08447810EB; Tue, 22 Apr 2025 10:05:07 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5865981273
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 10:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=620721f65c=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M7j2U7003391;
 Tue, 22 Apr 2025 10:03:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 6iYgMABT+8YdZZfu8p6hxpdPCYAHdFKQ0LzyBu+FhGs=; b=MnMTuK5JovTJR6oE
 vBkPaLYwPwIScBuL8JzwiPkdEEu6XGjuRgDLsW4LUgDrHVSa9L5l4X/EmHok0A0U
 zALhGVvotiK3UQY4D7PjuPhGathuypOmn7kOKxcf0Wg7l7pgWZLxxML3y1SugWZM
 Hc2DtN3BnLGxbWwR+EBGCKXr8SZo3TXF9PtS0DEqEP0uOHPB2JnKdQl56q9j9fu0
 mJ2BJyS50+O1NopHjT3E1eZVbGFjz50wm/p8g4xxZS2q4gRycsJIaNTTR6fyMGRk
 FeQkoagQKZ1CKPVzyh+jSZk5rSG/NewzHlfZJZ3kK2GucjZ6P+kcjrA3rZgei7Md
 vfzGpw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4640y80xar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 10:03:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4F4A14004A;
 Tue, 22 Apr 2025 10:02:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CA54E9A634A;
 Tue, 22 Apr 2025 09:59:51 +0200 (CEST)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 09:59:50 +0200
Message-ID: <dfcc6ea3-4b77-40e5-8df6-314c6dc76d8d@foss.st.com>
Date: Tue, 22 Apr 2025 09:59:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] ARM: dts: sti: convert stih410-b2260 board to
 OF_UPSTREAM
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Adam Ford
 <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Fabio Estevam <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250401131413.387139-1-patrice.chotard@foss.st.com>
 <20250401131413.387139-2-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250401131413.387139-2-patrice.chotard@foss.st.com>
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
> Enable OF_UPSTREAM flag for stih410-b2260 board.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/dts/Makefile                      |    2 -
>   arch/arm/dts/st-pincfg.h                   |   72 --
>   arch/arm/dts/stih407-clock.dtsi            |  323 -----
>   arch/arm/dts/stih407-family.dtsi           | 1000 ----------------
>   arch/arm/dts/stih407-pinctrl.dtsi          | 1262 --------------------
>   arch/arm/dts/stih410-b2260-u-boot.dtsi     |   46 +-
>   arch/arm/dts/stih410-b2260.dts             |  214 ----
>   arch/arm/dts/stih410-clock.dtsi            |  333 ------
>   arch/arm/dts/stih410-pinctrl.dtsi          |   31 -
>   arch/arm/dts/stih410.dtsi                  |  300 -----
>   configs/stih410-b2260_defconfig            |    3 +-
>   include/dt-bindings/clock/stih407-clks.h   |   90 --
>   include/dt-bindings/clock/stih410-clks.h   |   25 -
>   include/dt-bindings/mfd/st-lpc.h           |   16 -
>   include/dt-bindings/reset/stih407-resets.h |   65 -
>   15 files changed, 24 insertions(+), 3758 deletions(-)
>   delete mode 100644 arch/arm/dts/st-pincfg.h
>   delete mode 100644 arch/arm/dts/stih407-clock.dtsi
>   delete mode 100644 arch/arm/dts/stih407-family.dtsi
>   delete mode 100644 arch/arm/dts/stih407-pinctrl.dtsi
>   delete mode 100644 arch/arm/dts/stih410-b2260.dts
>   delete mode 100644 arch/arm/dts/stih410-clock.dtsi
>   delete mode 100644 arch/arm/dts/stih410-pinctrl.dtsi
>   delete mode 100644 arch/arm/dts/stih410.dtsi
>   delete mode 100644 include/dt-bindings/clock/stih407-clks.h
>   delete mode 100644 include/dt-bindings/clock/stih410-clks.h
>   delete mode 100644 include/dt-bindings/mfd/st-lpc.h
>   delete mode 100644 include/dt-bindings/reset/stih407-resets.h
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


