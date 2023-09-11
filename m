Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD008EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 09:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3259086D5C;
	Mon, 11 Sep 2023 11:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="XhkdFVS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A7A86D68; Mon, 11 Sep 2023 11:40:41 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A448E86D3C
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 11:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76189757ae=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38B9StRv013570; Mon, 11 Sep 2023 11:40:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=dvAWhie1tSiON2yN8R77H8RN2Em1umlxvQ7B6DCTiwI=; b=Xh
 kdFVS61SQR8EQUlsimHKVQmgVb3RerOGi8XzBjMurGBHBYA5B7ZWtY26kTNMwC6j
 3VAJxy4AFIZalFu83uS0AcaCL4BiT2IMtGNbrJt80zBahnA3O5urIja8AnID34Ue
 9SDwe6JVXObyq66Tsu0L3JShnjz5utiwULYkyDmiDNdfbcsLqWTVA6VIBLQhtflU
 dhOs1oJD2u0PBNkIhkYPpNO6Aeov4bWJs+HsjCCyhTRpOS5LfJ9hIkgP9X7Wf3Od
 iSOKQ4wpgPM9fryAa/NXJoUq5m3WIjNTQlDd0pOYNfx0ec119bz/VjevMVjKTgcd
 QET5onMOatj9xoYmjbqA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t207nr32s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 11:40:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AB04A10005A;
 Mon, 11 Sep 2023 11:40:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9D9D5237D9C;
 Mon, 11 Sep 2023 11:40:36 +0200 (CEST)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 11:40:35 +0200
Message-ID: <6eb16d4e-d892-d07c-f19f-74e10e8f024c@foss.st.com>
Date: Mon, 11 Sep 2023 11:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] rng: stm32: rename STM32 RNG driver
Content-Language: en-US
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
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
> Rename the RNG driver as it is usable by other STM32 platforms
> than the STM32MP1x ones. Rename CONFIG_RNG_STM32MP1 to
> CONFIG_RNG_STM32
>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>   MAINTAINERS                                 | 2 +-
>   configs/stm32mp15_basic_defconfig           | 2 +-
>   configs/stm32mp15_defconfig                 | 2 +-
>   configs/stm32mp15_trusted_defconfig         | 2 +-
>   drivers/rng/Kconfig                         | 6 +++---
>   drivers/rng/Makefile                        | 2 +-
>   drivers/rng/{stm32mp1_rng.c => stm32_rng.c} | 0
>   7 files changed, 8 insertions(+), 8 deletions(-)
>   rename drivers/rng/{stm32mp1_rng.c => stm32_rng.c} (100%)
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

