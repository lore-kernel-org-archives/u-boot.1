Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EAED42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6A2689440;
	Tue, 12 Nov 2024 15:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Itrzvu2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B4CE89477; Tue, 12 Nov 2024 15:19:25 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BEAE88EDD
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=104698dab8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACABFMG022508;
 Tue, 12 Nov 2024 15:19:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 WQT7r2AsxpKkbZturdV3gKaUyT1pLl6MlrTsXaDlOhU=; b=Itrzvu2PfL26qxeA
 7h7rilRDK4w66ACYZxp0Y0HVvndHTIiJhYDMTUTjHbWTyqIfRrq+UUujTAuMIiUm
 cEH+IwWFJNvxRPr/COEyfREd/OhSXTUCUaWK22eR185s9O8wNzcdr5uj/EXe+8gj
 k6GfUl23OeXGMzGj2TA6TMvClALG3cxLWBgoFtoeP+1a8oFCgmAdfJU9UnzAoeg9
 lf+5hv5BfhMQXTvnD11wE4p+touu02vG1EdsfVFDfdfdgkkOMS+n1M/f2fV1I8vK
 UDzVMgWQ94cYfvtIaAJpa/AlBvrGAEJcDfngqzsoBccN/HdVZXt59962e21pfpdQ
 5j/jOA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42swr8vrmb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:19:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A8DF040066;
 Tue, 12 Nov 2024 15:17:39 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2B6CD2A5D45;
 Tue, 12 Nov 2024 15:15:26 +0100 (CET)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 15:15:25 +0100
Message-ID: <2f7509b4-749d-4f94-aff7-c064d37066e9@foss.st.com>
Date: Tue, 12 Nov 2024 15:15:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: Drop duplicate pinmux on DH STM32 DHCOM
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241021194451.202977-1-marex@denx.de>
 <35e93102-c4d9-425b-84a5-23d42c5cf73e@foss.st.com>
Content-Language: en-US
In-Reply-To: <35e93102-c4d9-425b-84a5-23d42c5cf73e@foss.st.com>
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


On 11/12/24 12:33, Patrick DELAUNAY wrote:
> Hi,
>
> On 10/21/24 21:44, Marek Vasut wrote:
>> The ethernet0_rmii_pins_a pinmux change has no effect on any
>> DHSOM based hardware. The mco2_pins_a and mco2_sleep_pins_a
>> are both part of stm32mp15-pinctrl.dtsi . Drop both pinmux
>> changes.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi | 28 ----------------------
>>   1 file changed, 28 deletions(-)
>>
>
>
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Thanks
> Patrick
>


Applied to u-boot-stm/master, thanks!

Regards
Patrick

