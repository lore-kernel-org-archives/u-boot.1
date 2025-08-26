Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96F4CA0FE9
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 09:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B62483071;
	Tue, 26 Aug 2025 11:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="kf7IDdP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD8D8830B4; Tue, 26 Aug 2025 11:45:30 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1D6C82FC7
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 11:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0333e70c0e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q94xe6010392;
 Tue, 26 Aug 2025 11:45:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 swW2zHduk75ZVDiZekYLUJhrNes+UQpnKZWGq1SHezY=; b=kf7IDdP2buPEgF34
 Vnt3EU4C9QIDGkYqltEVRhgb8CQ0Z5rAE5qE1rlVFcx2jPUOg4gRaDNawxahyS+j
 uonfqK3XiH4lZfxVpw26alLWO/E8tYH2J/DTgkRoePccULX4cbXtZfw36hfSxJOK
 wpMzYW50DqW9tUQOs43F88XDN3RsDiM35djMhx35Vj2nG0wnxNYthbuqlgyizEdo
 Pj6xGhZelhpwei03SxpDC0u2V5EBxSahpt70zryzvookcB/nM1F8nNMYLDrrfkGt
 tknwmUeTV4ZJtH35GYblWNaax7LFcVjlsg/jXh3CZZMDIwgkmqWdCB+YbGOiIq23
 kcYpWg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48qq740eqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 11:45:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B71F340049;
 Tue, 26 Aug 2025 11:44:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 670495F93B3;
 Tue, 26 Aug 2025 11:44:03 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 26 Aug
 2025 11:44:02 +0200
Message-ID: <cac6160d-fe45-47ca-b988-fdb9b0082194@foss.st.com>
Date: Tue, 26 Aug 2025 11:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: stm32mp25: Enable OF_UPSTREAM_BUILD_VENDOR
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Cheick Traore
 <cheick.traore@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250814120938.1358059-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250814120938.1358059-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
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



On 8/14/25 14:09, Patrice Chotard wrote:
> Initially, only one STM32MP25 based board was available, the
> stm32mp257f-ev1 board which was set by default in stm32mp25_defconfig.
> 
> Since commit 79f3e77133bd ("Subtree merge tag 'v6.16-dts' of dts repo [1] into dts/upstream")
> we inherited of a second MP25 based board which is the stm32mp257f-dk board.
> 
> Enable OF_UPSTREAM_BUILD_VENDOR and set OF_UPSTREAM_VENDOR to allow all
> STMicroelectronics DT compilation.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> ---
> 
> Changes in v2:
>   - Update commit message with more details.
> 
>  configs/stm32mp25_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
> index 14619ffd96c..2b02cd86d61 100644
> --- a/configs/stm32mp25_defconfig
> +++ b/configs/stm32mp25_defconfig
> @@ -41,6 +41,8 @@ CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_LOG=y
>  CONFIG_CMD_UBI=y
>  CONFIG_OF_LIVE=y
> +CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
> +CONFIG_OF_UPSTREAM_VENDOR="st"
>  CONFIG_ENV_IS_NOWHERE=y
>  CONFIG_ENV_IS_IN_MMC=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y

Applied to u-boot-stm32/master

Thanks
Patrice
