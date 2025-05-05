Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902D6C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E2A58214A;
	Mon,  5 May 2025 15:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="E/3tbS4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E483882161; Mon,  5 May 2025 15:34:17 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E868F820E1
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7220064b2c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545CXuc4010482;
 Mon, 5 May 2025 15:34:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 llLJT0Lujvn7Ld9hDHvA0zvv0nzdqqe3I1lgxC1x8ro=; b=E/3tbS4+g6VupN/C
 R4bBg8DdltwVrMy62BFOG8bWf6Hisg6/IX17fco5Cp3NY0iJFf9B1B8wSA7g+5rA
 51jPULr1sJ8HUsb5nJAxHOiC4vXENSaQwg/EyhmFqnzHX2GsNihegq5CuLxvmuk7
 Pq93cl0K7bWd1fgvaws8UA9M3SJPQyY0kMS9l6kWJ+GE1TB0eDPKQq8vcsYKzEhO
 mHqjJ8A1QtfK5Fl/iTE+EIfS8u+jIUw0tW7oxKSL2dlfYC2hQsNozEqK/xV9b4DX
 3H68prV8RSPpoMbKpuydVu1EOoFB9bXQIcv3ziapwjp+SCL43HbGkFjF6V+jgq4x
 /FmTqA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46dx3m4k4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 15:34:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id ADCB540077;
 Mon,  5 May 2025 15:32:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 24BD7B1B533;
 Mon,  5 May 2025 15:29:51 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 15:29:50 +0200
Message-ID: <5820a305-8f14-4c6f-8771-743cba89d45b@foss.st.com>
Date: Mon, 5 May 2025 15:29:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dwc_eth_qos: add support of stm32mp2 platform
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Christophe
 Roullier <christophe.roullier@foss.st.com>, Erik Schumacher
 <erik.schumacher@iris-sensing.com>,
 Greg Malysa <malysagreg@gmail.com>, Heesub Shin <heesub@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Philip Oberfichtner <pro@denx.de>, Ramon Fried <rfried.dev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>
References: <20250411092721.331518-1-patrice.chotard@foss.st.com>
 <3757b4a7-735a-4e19-a460-b3cfe73dff5c@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <3757b4a7-735a-4e19-a460-b3cfe73dff5c@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_06,2025-05-05_01,2025-02-21_01
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



On 4/22/25 09:47, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/11/25 11:27, Patrice Chotard wrote:
>> From: Christophe Roullier <christophe.roullier@foss.st.com>
>>
>> Add compatible "st,stm32mp25-dwmac" to manage STM32MP2 boards
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   drivers/net/dwc_eth_qos.c       |  4 ++++
>>   drivers/net/dwc_eth_qos.h       |  1 +
>>   drivers/net/dwc_eth_qos_stm32.c | 11 +++++++++++
>>   3 files changed, 16 insertions(+)
>>
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
