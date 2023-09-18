Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCA7CD37B0
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 15:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 002E286A1D;
	Mon, 18 Sep 2023 17:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZirbcBl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5458E869C4; Mon, 18 Sep 2023 17:37:06 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 384A586A27
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 17:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76259f6df1=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38IDQdmU009703; Mon, 18 Sep 2023 17:37:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=2GwW0W2p/CbuBpgMvTezCXTabVr9Dt+HEAgV/OZv9og=; b=Zi
 rbcBl237awe1KZqDmeJRDWBpL0BkYPEr+LWMFfWxtSNtxpw17AcGi/y9rv1QQyz8
 VyNJT7hVmEgOos1KunmzHbkhIl/ZStCn2+JbRnep7HYwl5CRvt6EW+fHYylph4M+
 bNecrG++JQs54tjj+6VbbcZ/0Z/iusmrfsnc1Wymz4xw48oF/4ptnRv8w8+rkMnj
 J9F/Km0k9h2766PavaYy0JuVy8o6R1D6+SRnPlRrP2nEN350kxYDKFIXJXHeC8Jx
 EF9Vakh6sdeY5BP1OujfuFY9zVrjTJwo94FOiKrJYNsQAjzC8Oz9lKR6cPnejB45
 VZJr8Kbk1dT2brxZvPYA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t53pwpqyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Sep 2023 17:37:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0146D10005B;
 Mon, 18 Sep 2023 17:36:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DEBB026A9B3;
 Mon, 18 Sep 2023 17:36:58 +0200 (CEST)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 17:36:58 +0200
Message-ID: <6014678e-2525-97d7-6073-7f7a6fa16f58@foss.st.com>
Date: Mon, 18 Sep 2023 17:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/7] rng: stm32: rename STM32 RNG driver
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>, Grzegorz Szymaszek
 <gszymaszek@short.pl>
References: <20230911153724.799535-1-gatien.chevallier@foss.st.com>
 <20230911153724.799535-2-gatien.chevallier@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20230911153724.799535-2-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_08,2023-09-18_01,2023-05-22_02
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

On 9/11/23 17:37, Gatien Chevallier wrote:
> Rename the RNG driver as it is usable by other STM32 platforms
> than the STM32MP1x ones. Rename CONFIG_RNG_STM32MP1 to
> CONFIG_RNG_STM32
>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> Reviewed-by: Grzegorz Szymaszek <gszymaszek@short.pl>
> ---
>
> Changes in V2:
> 	- Added ARCH_STM32 in the "depends on" section of the
> 	  RNG_STM32 configuration field.
> 	- Added Grzegorz's tag and discarded Patrick's and
> 	  Heinrich's as there's a modification
>
>   MAINTAINERS                                 | 2 +-
>   configs/stm32mp15_basic_defconfig           | 2 +-
>   configs/stm32mp15_defconfig                 | 2 +-
>   configs/stm32mp15_trusted_defconfig         | 2 +-
>   drivers/rng/Kconfig                         | 8 ++++----
>   drivers/rng/Makefile                        | 2 +-
>   drivers/rng/{stm32mp1_rng.c => stm32_rng.c} | 0
>   7 files changed, 9 insertions(+), 9 deletions(-)
>   rename drivers/rng/{stm32mp1_rng.c => stm32_rng.c} (100%)
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

