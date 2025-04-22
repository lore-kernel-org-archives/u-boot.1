Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4EDC369CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 08:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B97A5807AE;
	Tue, 22 Apr 2025 10:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="oZA8A5Hf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB99E809D4; Tue, 22 Apr 2025 10:38:51 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAB50803CC
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 10:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=620721f65c=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M74ncB031449;
 Tue, 22 Apr 2025 10:38:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 zZdOn+MOqxQHSWa23m81VucdrT2YHYdpPJwbHNa0HCE=; b=oZA8A5HfIA6b1Hea
 kMvpsaT5XJ0mOW4VJCA0iv0MGoltDIreIZCt2BWtzzioQaKwNZNWTaC/tAIQmLS+
 BhFVE3H5osrBceXggU7Lk7/yvLrCZ/k99s53ppW8uiDtvmkAL6oSFKrdA4gh4zWb
 vOuGw9fzjV9TlfYcQB37dP+TbtYz+NWoCPTtl6QP2YKzTECWYOdy1D0zD/uIGPtZ
 9Wty+pwk6tP2On1RAdqihEBOYOzIcn0ajVBRGo1I7NF3t1DOe3xrnh+x37VY0WaA
 BhaqGZtK3Iy8igaVI6U9uOVVmHPrclfEElyjUWywAEAeUv9PUaaUSCtTqtPaeUqb
 TWEv0A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 464nd3y1v6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 10:38:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 707E340053;
 Tue, 22 Apr 2025 10:37:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E669F9D6F69;
 Tue, 22 Apr 2025 10:37:30 +0200 (CEST)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 10:37:30 +0200
Message-ID: <7886acd9-7849-4b06-9eb1-0fe4ca19413e@foss.st.com>
Date: Tue, 22 Apr 2025 10:37:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] stm32mp: fdt: remove ETZPC peripheral cleanup
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250401131413.387139-1-patrice.chotard@foss.st.com>
 <20250401131413.387139-12-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250401131413.387139-12-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
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

On 4/1/25 15:14, Patrice Chotard wrote:
> From: Lionel Debieve <lionel.debieve@foss.st.com>
>
> Due to feature domains management, there is no more
> need to maintain the fdt cleanup.
>
> Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/mach-stm32mp/Kconfig        |   8 -
>   arch/arm/mach-stm32mp/stm32mp1/fdt.c | 258 ---------------------------
>   2 files changed, 266 deletions(-)
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

