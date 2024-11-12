Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBFFD32D9C
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 11:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC9388B9F;
	Tue, 12 Nov 2024 12:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="gnRxUIfp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DEEF8918E; Tue, 12 Nov 2024 12:51:22 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEE9889D2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 12:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=104698dab8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC97NNs029351;
 Tue, 12 Nov 2024 12:51:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 rAe/0rLcLms/daw6d3qsJO1ID4LRCJDtUoSuheIvV2U=; b=gnRxUIfpEKWPtmco
 PG5KENWfamHo3/msN8hdeZhkKxCUcZmPLX6qK8J5LdfBe/p4z4/J5i96MrTsKQQ7
 pejf6cDrItq8PR6QNoWvBsgQr112d7/u/+pvQOmxQUgv1hpimCocMGUPzDRbc7qE
 27vb8qAqcfru86m3s2YvKJksIQDvdkEnllZ8n3tIvToNuWGyYqzY8hqnwwy4m23c
 ilFENe2iOOKZx22WsQPugzfGC5WLUIKGtPH0vp5BKAAqZbFlYXz9pIPm3iBh+ScO
 5Xpd2umbDPKA4hXvK2ximQQ8S7xbIuoWh1/mimmj+QC+XQVonnxR/yGclX11juLb
 4sGrmg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42tkjnha7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 12:51:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4099C40045;
 Tue, 12 Nov 2024 12:50:04 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 909552A2FC3;
 Tue, 12 Nov 2024 12:49:34 +0100 (CET)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 12:49:34 +0100
Message-ID: <828ae2de-1f7b-49ca-9733-66f7846dac8b@foss.st.com>
Date: Tue, 12 Nov 2024 12:49:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: stm32: Deduplicate DH STM32MP1xx DHSOM defconfigs
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241027010437.350243-1-marex@denx.de>
 <20241027010437.350243-2-marex@denx.de>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241027010437.350243-2-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 10/27/24 02:03, Marek Vasut wrote:
> Deduplicate defconfigs for all DH STM32MP1xx DHSOM systems by factoring
> out the common parts into generic stm32mp_dhsom.config and including
> those using the #include <configs/...> preprocessor macro in the current
> set of board specific defconfigs. The preprocessor macro is applicable
> to defconfigs as well.
>
> This introduces no functional change, the resulting .config is identical
> for all DH STM32MP1xx DHSOM systems.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>   configs/stm32mp13_dhcor_defconfig | 107 +-----------------------------
>   configs/stm32mp15_dhsom.config    | 107 +-----------------------------
>   configs/stm32mp_dhsom.config      | 105 +++++++++++++++++++++++++++++
>   3 files changed, 109 insertions(+), 210 deletions(-)
>   create mode 100644 configs/stm32mp_dhsom.config
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

