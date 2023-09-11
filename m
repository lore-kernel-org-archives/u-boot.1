Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376DDEEB580
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 09:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447BA86D3C;
	Mon, 11 Sep 2023 11:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="v1XtKIBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D8A86D3F; Mon, 11 Sep 2023 11:50:40 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05EC886D11
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 11:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76189757ae=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38B9SxUl015392; Mon, 11 Sep 2023 11:50:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=v7OpwpClRNLkzPSS3cYs1vIp1PRe28m5DIAziVDrbh0=; b=v1
 XtKIBdU1bFnAlf9cuZtD4VrC0JLJcqjTp9yOrb6c2FjPuFw+hoZuD/Y7FX9KGRVk
 lAf3dtTfQ+NxEKKWwzm7u1Kl1dAh+b7l0pYRFSPUYgT8V9cnuHu1j5bA+PeSCaln
 LrDo1E+6vrQDq6uHUKv9ydw4B5zpbv2yBgRWzb0/4mDtfrKtIvfNJc9aBq1NYxQv
 d44no6v77lZ+yc1wKFHpIwEspBjWL6JpACmiyDaNCbisykxqSPwqi0dQPVjbvzPs
 uILZmOFwldD68lwWpp3kIBKUNLtaurPoskRY+g61fJw/W0STIv2S8x8MRaajegq+
 4oMcniHSkyXi0poKnuxA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t0fkcg3k0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 11:50:36 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0B96510005A;
 Mon, 11 Sep 2023 11:50:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 030AB23A15B;
 Mon, 11 Sep 2023 11:50:36 +0200 (CEST)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 11:50:35 +0200
Message-ID: <3b755794-b61e-140e-f292-94ca88e7f03b@foss.st.com>
Date: Mon, 11 Sep 2023 11:50:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/7] configs: default activate CONFIG_RNG_STM32 for
 STM32MP13x platforms
Content-Language: en-US
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
 <20230907162200.205602-2-gatien.chevallier@foss.st.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20230907162200.205602-2-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
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

On 9/7/23 18:21, Gatien Chevallier wrote:
> Default embed this configuration. If OP-TEE PTA RNG is present as well,
> the priority will be given to it instead of the U-Boot driver.


The STM32 RNG driver will be probed when the is activated in U-Boot 
device tree,

it is avaiable for non secure world.


OP-TEE RNG PTA will be registered when the RNG access is liited to

secure world by firewall.


For me not priority here but secure/non secure configuration, managed by 
device tree.


>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>   configs/stm32mp13_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
> index 82b62744f6..4a899c85de 100644
> --- a/configs/stm32mp13_defconfig
> +++ b/configs/stm32mp13_defconfig
> @@ -65,6 +65,7 @@ CONFIG_DM_REGULATOR_GPIO=y
>   CONFIG_DM_REGULATOR_SCMI=y
>   CONFIG_RESET_SCMI=y
>   CONFIG_DM_RNG=y
> +CONFIG_RNG_STM32=y
>   CONFIG_DM_RTC=y
>   CONFIG_RTC_STM32=y
>   CONFIG_SERIAL_RX_BUFFER=y


with commit message update


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

