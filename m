Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3319DE7B5F7
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 11:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB5F874D1;
	Wed,  4 Oct 2023 13:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="JIoc3oe+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E030874D1; Wed,  4 Oct 2023 13:39:20 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE9EE8722D
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 13:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864180acd4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 394A4GdM021981; Wed, 4 Oct 2023 13:39:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=aq1TNJJAyiL2CNSahXVlxuj/w1yMLHCg4l8VFego18E=; b=JI
 oc3oe+aeb7D7+PfxFViMjuawg9ivzkwnxqYQ3tKDCjU2QdwxaUTYOZ34FJSdXFUY
 bpgE4Ma/8FlousMyJ52RBlFI3HvRbTqq7TV5jl4G6H67IPt/CiwxVrAIdXxy6QA5
 HijtvEtBzyxdmENKusNj04AIbD3cjnRDDomNf90q/TRAeZXq0kf88I1kFpW2VMQi
 79iRAs5d1iB2gC3RNc4jdwGoMnvCCsNE/G53MaZVuWVFIE6hCpD8ysAjMpJVIbuX
 uk/Qt0ZSWUgmjBuYiwCYevOQNRXItUTryxNfnJzoxXABzPTCJ/fFLpvfQ2XMTyH5
 xLNyK2S+iMQiJ8Wk/Lfg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3teajd0swe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 13:39:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 08320100053;
 Wed,  4 Oct 2023 13:39:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F123D235F0B;
 Wed,  4 Oct 2023 13:39:09 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 13:39:09 +0200
Message-ID: <fc505891-dc25-07e4-2ef8-b9d776a99c9f@foss.st.com>
Date: Wed, 4 Oct 2023 13:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/6] ARM: dts: stm32mp: alignment with v6.6-rc1
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Jagan Teki
 <jagan@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Tom Rini <trini@konsulko.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230926150924.1150082-1-patrice.chotard@foss.st.com>
 <20230926150924.1150082-2-patrice.chotard@foss.st.com>
 <85fc4468-136b-4d26-b249-50f147722377@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <85fc4468-136b-4d26-b249-50f147722377@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_03,2023-10-02_01,2023-05-22_02
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



On 10/4/23 11:55, Patrick DELAUNAY wrote:
> Hi,
> 
> On 9/26/23 17:09, Patrice Chotard wrote:
>> Device tree alignment with Linux kernel v6.6.rc1.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp131.dtsi                  |  52 +--
>>   arch/arm/dts/stm32mp135f-dk.dts               |  68 ++--
>>   arch/arm/dts/stm32mp15-pinctrl.dtsi           | 364 +++++++++++++++++-
>>   arch/arm/dts/stm32mp15-scmi.dtsi              |   7 +-
>>   arch/arm/dts/stm32mp151.dtsi                  |  34 +-
>>   arch/arm/dts/stm32mp157.dtsi                  |  15 +-
>>   arch/arm/dts/stm32mp157a-dk1-scmi.dts         |   7 +-
>>   ...157a-microgea-stm32mp1-microdev2.0-of7.dts |   3 +
>>   arch/arm/dts/stm32mp157c-dk2-scmi.dts         |   7 +-
>>   arch/arm/dts/stm32mp157c-dk2.dts              |  30 +-
>>   arch/arm/dts/stm32mp157c-ed1-scmi.dts         |   7 +-
>>   arch/arm/dts/stm32mp157c-ed1.dts              |  24 +-
>>   arch/arm/dts/stm32mp157c-ev1-scmi.dts         |   7 +-
>>   arch/arm/dts/stm32mp157c-ev1.dts              |  34 +-
>>   arch/arm/dts/stm32mp15xx-dkx.dtsi             |  42 +-
>>   include/dt-bindings/clock/stm32mp1-clks.h     |   2 +-
>>   include/dt-bindings/clock/stm32mp13-clks.h    |   2 +-
>>   .../regulator/st,stm32mp13-regulator.h        |  42 ++
>>   include/dt-bindings/reset/stm32mp1-resets.h   |   2 +-
>>   include/dt-bindings/reset/stm32mp13-resets.h  |   2 +-
>>   20 files changed, 585 insertions(+), 166 deletions(-)
>>   create mode 100644 include/dt-bindings/regulator/st,stm32mp13-regulator.h
>>
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
> 

Apply on stm32/next

Thanks
Patrice
