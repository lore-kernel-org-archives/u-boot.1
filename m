Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD118C369D7
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 08:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1BCD80194;
	Tue, 22 Apr 2025 10:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="1rZXeH48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE29803CC; Tue, 22 Apr 2025 10:12:53 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF03800D7
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 10:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=620721f65c=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M58IP6013542;
 Tue, 22 Apr 2025 10:12:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 XmXfVRr4/yKE8Ujk/QwHy5OqUyMbK4yBZ/jBITb1pP0=; b=1rZXeH48bnDBFRjy
 i++4Tgb1UYWe7GFjoNb0rflx40M1y8lPkOw7uqnwynbm+oIRw1QcExaugx4PlmiO
 +VYRZwBlwUyzs+OWkH3WiqPXp1ZzCuJdWNjGqiylokt6HotQ/x1UwEIyoIeiCRbz
 T2Q6nhaSdOiyfkh3WZJlX7izbGeOdqUnDZhnxsNa+aIZ7FNY/gnGl1724Qu/AB+H
 Y87P43uD5lqbBgiTkf8/BzFh6owG3XWRcAXFyyA8KCYAvdJa/sim8hBzrIcIKBDg
 JixEEvPemqX8r59tyJI5Mkx4zjvxo9aau2Q22ZesmmgCtQO6BGlCUeiufLUXJBiY
 mzdWVw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 464psp6kw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 10:12:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9BD314002D;
 Tue, 22 Apr 2025 10:10:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F1FB9C8C8C;
 Tue, 22 Apr 2025 10:08:53 +0200 (CEST)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 10:08:52 +0200
Message-ID: <f242f3eb-c687-445f-9db3-43b80d6c078c@foss.st.com>
Date: Tue, 22 Apr 2025 10:08:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] ARM: dts: stm32: convert stm32mp13 board to
 OF_UPSTREAM
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Adam Ford
 <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Cheick Traore <cheick.traore@foss.st.com>, Christophe Roullier
 <christophe.roullier@st.com>, Fabio Estevam <festevam@denx.de>, "Fabrice
 Gasnier" <fabrice.gasnier@foss.st.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, "Simon Glass" <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250401131413.387139-1-patrice.chotard@foss.st.com>
 <20250401131413.387139-6-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250401131413.387139-6-patrice.chotard@foss.st.com>
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
> Enable OF_UPSTREAM flag for STM32MP13 platforms.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/dts/Makefile               |    3 -
>   arch/arm/dts/stm32mp13-pinctrl.dtsi |  888 ---------------
>   arch/arm/dts/stm32mp131.dtsi        | 1567 ---------------------------
>   arch/arm/dts/stm32mp133.dtsi        |   98 --
>   arch/arm/dts/stm32mp135.dtsi        |   12 -
>   arch/arm/dts/stm32mp135f-dk.dts     |  376 -------
>   arch/arm/dts/stm32mp13xc.dtsi       |   18 -
>   arch/arm/dts/stm32mp13xf.dtsi       |   18 -
>   arch/arm/mach-stm32mp/Kconfig       |    1 +
>   configs/stm32mp13_defconfig         |    2 +-
>   10 files changed, 2 insertions(+), 2981 deletions(-)
>   delete mode 100644 arch/arm/dts/stm32mp13-pinctrl.dtsi
>   delete mode 100644 arch/arm/dts/stm32mp131.dtsi
>   delete mode 100644 arch/arm/dts/stm32mp133.dtsi
>   delete mode 100644 arch/arm/dts/stm32mp135.dtsi
>   delete mode 100644 arch/arm/dts/stm32mp135f-dk.dts
>   delete mode 100644 arch/arm/dts/stm32mp13xc.dtsi
>   delete mode 100644 arch/arm/dts/stm32mp13xf.dtsi
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


