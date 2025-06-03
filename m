Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115D0C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 17:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA3F482AA7;
	Tue,  3 Jun 2025 19:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="OId7SoVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1728C82AAA; Tue,  3 Jun 2025 19:17:48 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3DC682A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 19:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82493dba10=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553D4XRH008726;
 Tue, 3 Jun 2025 19:17:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 7OaWsgy6WTfvktE8+PqIriTFGDaHjcVumL1jWfmB5Uo=; b=OId7SoVDxjP/kCEG
 tkuSyxBrCuDwHszAcP8uVjTpP4o6qbG+hLCIRg3jHuvgtI8UnsXE4gF7vffA5Avu
 eJh0Upyk/ZWBXK16qr15q95PqlVOqpGtKdKb+63BCRnNGyJ7TeGIexIOrjARov65
 3eo9Jcvei15gSvK4dbjKn8ZdrNJi7MW/RT8LrEuUt3NPmCMKLheC0GifjGn4g+eE
 scmwhSb4YX3JvBjAGiC2r0DGyfxWPD8FzQHz4lmVkZ+JVWbq4LBa1UCMZE89nPaN
 MGZQlz7RB0ZQ1666wlRzw8NHRRREzYISaFKTaNizz+/l5pVZowhoBQN4Q0vox70y
 bU8K9A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g8v56sb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 19:17:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2E89F4007C;
 Tue,  3 Jun 2025 19:16:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2395EB5326A;
 Tue,  3 Jun 2025 19:15:28 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 19:15:27 +0200
Message-ID: <da6ec8aa-3dd2-4590-8892-042be75e8fd6@foss.st.com>
Date: Tue, 3 Jun 2025 19:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] clk: stm32mp25: Add clock driver support
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
 <20250527132755.2169508-3-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250527132755.2169508-3-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
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

On 5/27/25 15:27, Patrice Chotard wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>
> Add clock driver support for STM32MP25 SoCs.
>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Sean Anderson <seanga2@gmail.com>
>
> ---
>
> Changes in v2:
>      - Rename GATE_USB2 into GATE_USBH
>      - Rename RCC_USB2CFGR to RCC_USBHCFGR
>
>   drivers/clk/stm32/Kconfig         |   9 +
>   drivers/clk/stm32/Makefile        |   1 +
>   drivers/clk/stm32/clk-stm32mp25.c | 665 ++++++++++++++++++++++++++++
>   include/stm32mp25_rcc.h           | 712 ++++++++++++++++++++++++++++++
>   4 files changed, 1387 insertions(+)
>   create mode 100644 drivers/clk/stm32/clk-stm32mp25.c
>   create mode 100644 include/stm32mp25_rcc.h
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

