Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A70D42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066BD88EDD;
	Tue, 12 Nov 2024 15:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="zprw6xb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF6F88FED; Tue, 12 Nov 2024 15:18:50 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AFAD889D2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:18:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=104698dab8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACCUKWk022637
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:18:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 IB0VXYc0ZPgeG7ig7KkEAUVikamLEtAwrXJcYCRAyoE=; b=zprw6xb7rxJRp/r4
 ab0LQ8uRvS2aWn+zDZTWLZDI39h9dWXzsNXYuXUUeG2XUedYoFhoCoeESwtuH1Au
 4lNx0kRgtZ0T0GRspUZ5jYGx2PYjGbMeoXbXDZtiuDpcTbvnSHM/+vET6babwg+g
 4/dmzYAUgmOx3v4D9gAYu5R3bOEQCiIMW6P4LREE7Uo8vD/qLE3Bl2mZ5ogQ1E9X
 bgOGf+zRLCLwyrvfUVG4jYdrVreRJM9jtadDsrPKM6Tw9k8Wyej99OxqhGLwKJF0
 wKY2jaWvVk2TVqz8qZvCfsyxmmwMY0nVZnMvgcSDDcMsC2RWl3ne1qK9c2C00OKd
 gRgNPw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42sx1kn31d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:18:48 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8F6E140046
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:17:38 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 63DEF2B6E58
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:16:11 +0100 (CET)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 15:16:11 +0100
Message-ID: <10bb9af7-f281-4f49-9ce6-993c73b80386@foss.st.com>
Date: Tue, 12 Nov 2024 15:16:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: stm32: Deduplicate DH STM32MP15xx DHSOM
 defconfigs
To: <u-boot@lists.denx.de>
References: <20241027010437.350243-1-marex@denx.de>
 <6613e670-a5b5-4942-b456-c5944cffd871@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <6613e670-a5b5-4942-b456-c5944cffd871@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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


On 11/12/24 12:48, Patrick DELAUNAY wrote:
> Hi,
>
> On 10/27/24 02:03, Marek Vasut wrote:
>> Deduplicate defconfigs for all DH STM32MP15xx DHSOM systems by factoring
>> out the common parts into generic stm32mp15_dhsom.config and including
>> those using the #include <configs/...> preprocessor macro in the current
>> set of board specific defconfigs. The preprocessor macro is applicable
>> to defconfigs as well.
>>
>> This introduces no functional change, the resulting .config is identical
>> for all DH STM32MP15xx DHSOM systems.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Sean Anderson <seanga2@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   configs/stm32mp15_dhcom_basic_defconfig | 174 +-----------------------
>>   configs/stm32mp15_dhcor_basic_defconfig | 174 +-----------------------
>>   configs/stm32mp15_dhsom.config          | 172 +++++++++++++++++++++++
>>   3 files changed, 176 insertions(+), 344 deletions(-)
>>   create mode 100644 configs/stm32mp15_dhsom.config
>>
>
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Thanks
> Patrick



Applied to u-boot-stm/master, thanks!

Regards
Patrick

