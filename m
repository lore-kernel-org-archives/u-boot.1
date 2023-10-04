Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D61E7B5E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 477C9874BC;
	Wed,  4 Oct 2023 11:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="i8Nvr8id";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F587874C1; Wed,  4 Oct 2023 11:56:06 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 461AB874B9
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8641a2a2c4=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3945Wi1b024393; Wed, 4 Oct 2023 11:56:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=5rJrCKca3KNRWyefijDOLQEd+Tw2q1wWR078hLT6m28=; b=i8
 Nvr8iduPDWcdEFoyT2+8V6jT6hwdEH9NoZU/K0tK6I2IPrv/TSPeFNFTvCtaE9Kz
 gB+EuBHo+Ii1DcwHryTm6Jyg3S7/QAsswYHArDs1agbAooUpelWg5PC7d7PGzwKH
 XufALtmUB5DRjiLpryICWzfbfFm/sEr+qeTXiP76G13oxvAfm639KTI6qpGUGhac
 +SjmyRhZOmomXQMBc78hA3n5caNpd4gIHUKxHV7OoxV5tl2hT/THsq9a5ivnVhgQ
 WiCDL5UVTVNQs86Jd59gbVfCLWK0ZISS3GczzJ1LutbgRAYnazaJnVGvHZXPmm6Q
 NPU+I3les3oRtCbQchNg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3te8t50jqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 11:56:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 99775100057;
 Wed,  4 Oct 2023 11:56:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 907F622F7A6;
 Wed,  4 Oct 2023 11:56:01 +0200 (CEST)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 11:56:00 +0200
Message-ID: <e9fff0fc-27db-20f9-b2b5-1abee5ac739e@foss.st.com>
Date: Wed, 4 Oct 2023 11:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/6] ARM: dts: stm32: force b-session-valid for otg on
 stm32mp135f-dk board
Content-Language: en-US
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Tom Rini
 <trini@konsulko.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230926150924.1150082-1-patrice.chotard@foss.st.com>
 <20230926150924.1150082-3-patrice.chotard@foss.st.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20230926150924.1150082-3-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
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
> From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>
> stm32mp135f-dk board has a type-c connector to retrieve the connection
> state. For now, simply force an active peripheral mode in u-boot for
> flashing.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/dts/stm32mp135f-dk-u-boot.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi
> index 48605ff8bbe..ba0c02489d1 100644
> --- a/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi
> @@ -38,3 +38,7 @@
>   		bootph-all;
>   	};
>   };
> +
> +&usbotg_hs {
> +	u-boot,force-b-session-valid;
> +};



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick



