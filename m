Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7059DC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 08:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E60A81026;
	Tue, 22 Apr 2025 10:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="W7aeWU8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49E38810F4; Tue, 22 Apr 2025 10:05:01 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5151B80F03
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 10:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=620721f65c=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M6uxNA025914;
 Tue, 22 Apr 2025 10:04:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 7UyMTBvZcCkoDdSMbk6vZuSbLntlvSyc/y2/Z3IqhVM=; b=W7aeWU8LR0KoQ6yh
 PI5Ki9pM3sXFbNzNg1hezGQUwG6IaCCpVdyRdXiC+JdAffSbxLlIdIPFjMvbevsr
 IEAiCDMHoPmBdpK0+X9vUbgvtXOMRlUXymdfq4YgW92HsRryTLqmwFi5GFqRC/p/
 hSOgv3shXp2HHQsgoOW+zg/Okn8To6YOjuhzrnYP+HLmV40scBiU1grSlBOx6WEO
 OCSiKNwOToO94ECZXLC3i+GMZnLwMx8RNFO5DY1jf/v12zC/GuPfuDBIfS8m4LU+
 HgBWShH4BVEmhVb+Dd1ig7725S5m0QHFb5pdth5pDxJhSNL2dtTE1tcEk7BwBG98
 eupG5g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 464362913d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 10:04:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2A33740051;
 Tue, 22 Apr 2025 10:02:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 795799C6CF6;
 Tue, 22 Apr 2025 10:00:56 +0200 (CEST)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 10:00:55 +0200
Message-ID: <050aa371-e183-4cd3-8fd9-61732f38f292@foss.st.com>
Date: Tue, 22 Apr 2025 10:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] ARM: dts: stm32: convert stm23h7 boards to
 OF_UPSTREAM
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Adam Ford
 <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>, Dillon Min
 <dillon.minfei@gmail.com>, Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Oliver Gaskell
 <Oliver.Gaskell@analog.com>, Prasad Kummari <prasad.kummari@amd.com>, Sumit
 Garg <sumit.garg@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250401131413.387139-1-patrice.chotard@foss.st.com>
 <20250401131413.387139-3-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250401131413.387139-3-patrice.chotard@foss.st.com>
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
> Enable OF_UPSTREAM flag for STM32H7 platforms.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/dts/Makefile              |   3 -
>   arch/arm/dts/stm32h7-pinctrl.dtsi  | 274 ------------
>   arch/arm/dts/stm32h7-u-boot.dtsi   |   1 -
>   arch/arm/dts/stm32h743.dtsi        | 695 -----------------------------
>   arch/arm/dts/stm32h743i-disco.dts  |  75 ----
>   arch/arm/dts/stm32h743i-eval.dts   | 160 -------
>   arch/arm/dts/stm32h750.dtsi        |   5 -
>   arch/arm/dts/stm32h750i-art-pi.dts | 188 --------
>   arch/arm/mach-stm32/Kconfig        |   1 +
>   configs/stm32h743-disco_defconfig  |   2 +-
>   configs/stm32h743-eval_defconfig   |   2 +-
>   configs/stm32h750-art-pi_defconfig |   2 +-
>   12 files changed, 4 insertions(+), 1404 deletions(-)
>   delete mode 100644 arch/arm/dts/stm32h7-pinctrl.dtsi
>   delete mode 100644 arch/arm/dts/stm32h743.dtsi
>   delete mode 100644 arch/arm/dts/stm32h743i-disco.dts
>   delete mode 100644 arch/arm/dts/stm32h743i-eval.dts
>   delete mode 100644 arch/arm/dts/stm32h750.dtsi
>   delete mode 100644 arch/arm/dts/stm32h750i-art-pi.dts
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

