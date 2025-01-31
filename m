Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0F5C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 08:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF978215B;
	Fri, 31 Jan 2025 09:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="QEgBAYn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0434A80F0E; Fri, 31 Jan 2025 09:12:26 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1352980F0E
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 09:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41261629dd=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V80ujS022400;
 Fri, 31 Jan 2025 09:12:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 8+QqdUWKBnK/Muv5RBrkMQUFbgNIwn+vqXbGJv/b/H0=; b=QEgBAYn/Gs61ITdm
 kKRA4W2k3n45uWvvGMuAjd8zWgU+0cCWSPifPKQIKI4rMQGjwPbvIOQcor+siUpE
 yoXuT7uYmBhoHVlFZIIPnoFHUcaiCkIUVzyWxyiMWTuwPQshzk9EIXjQky2wKl0r
 X4wOpYM6QTDqZs5GK02y7aXdprWB0DNFj2/o3ieaNdXRIlD9XGijpAxWdcrqYS8Y
 MpTjOimoIkwt2+8YP6eZeev0D4B1AMX+x4xY8iBwutDyeLCjom9c0o0HzzdYR9bi
 oPp8Qgzx2XTjKEXk0yDZYFazKEmT7dcYStkNiKKJxjCFVo5fMsuFm1DCEGq5gMBX
 ASh/KQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gf7c9u1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 09:12:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7A0ED40065;
 Fri, 31 Jan 2025 09:11:27 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 34F8E29E869;
 Fri, 31 Jan 2025 09:06:58 +0100 (CET)
Received: from [10.252.27.7] (10.252.27.7) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 31 Jan
 2025 09:06:57 +0100
Message-ID: <8185e1f2-daa7-43c1-aae8-2f9d37b84b0b@foss.st.com>
Date: Fri, 31 Jan 2025 09:06:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: stm32f469-disco: Set CYCLIC_MAX_CPU_TIME_US
 to 50000 for stm32f469-disco
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20241211080936.1133105-1-patrice.chotard@foss.st.com>
 <20241211080936.1133105-2-patrice.chotard@foss.st.com>
 <47929bfc-5a76-490e-a445-d0a0e991cc13@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <47929bfc-5a76-490e-a445-d0a0e991cc13@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.27.7]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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



On 1/8/25 19:53, Patrick DELAUNAY wrote:
> Hi,
> 
> On 12/11/24 09:09, Patrice Chotard wrote:
>> Updating the framebuffer takes quite a long time on this slow patform,
>> set CYCLIC_MAX_CPU_TIME_US to 50000 for stm32f469-disco to avoid
>> following cyclic warning:
>>
>> "cyclic function video_init took too long: 46784us vs 5000us max"
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   configs/stm32f469-discovery_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/stm32f469-discovery_defconfig b/configs/stm32f469-discovery_defconfig
>> index 98399416fa5..b0144763d37 100644
>> --- a/configs/stm32f469-discovery_defconfig
>> +++ b/configs/stm32f469-discovery_defconfig
>> @@ -14,6 +14,7 @@ CONFIG_DISTRO_DEFAULTS=y
>>   CONFIG_BOOTDELAY=3
>>   CONFIG_SYS_PBSIZE=1050
>>   # CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_CYCLIC_MAX_CPU_TIME_US=50000
>>   CONFIG_MISC_INIT_R=y
>>   CONFIG_SYS_PROMPT="U-Boot > "
>>   CONFIG_CMD_IMLS=y
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
Applied to u-boot-stm32/master

Thanks
Patrice
