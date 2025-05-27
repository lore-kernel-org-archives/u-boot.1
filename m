Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1928FC54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A398183771;
	Tue, 27 May 2025 15:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="8bBGNoyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 572BA830B6; Tue, 27 May 2025 15:02:26 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C98E82A25
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RBw2qU002122;
 Tue, 27 May 2025 15:02:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 /qQJZTAkKQUMlja7gYsB78HH1c0EI8l4eHSOumyiDfg=; b=8bBGNoyZEOJluJFz
 Mxlu6ee/Y9Xt9jyghmXeBdGQ0URB21lCxM/E9NZrr6Sl+NCktqZ7+KcVPvx26sbe
 5SbEYqJWLZB/ooLtvduva43FJMFDr9aqF/lVDHnA8CVXwlvgu/M+bqwtE/rBfV+c
 LhQ37s65q1k4Pt4lDlSe0g8V4HsxueyBY5QajBGYMgYoUZkeb5ahUY5yOjSZUkUe
 EmGb6jiOlyrDt83O/thiHymtoQNAng9Qc33cYZvQTaqZeKhuqcCOqbgS9S8Yndpu
 1Yy4uuI3xCKfsPuakiDGuMaU3T+iwypXK7EmAwhFB3vS4JnTjlCrbmPhUBqYcnRP
 WShcjA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46w54hjkvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:02:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DDC7D4005B;
 Tue, 27 May 2025 15:01:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EEEA3AD004E;
 Tue, 27 May 2025 15:01:24 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:01:24 +0200
Message-ID: <999bd3bb-9f8c-481d-be89-6da957e6b27c@foss.st.com>
Date: Tue, 27 May 2025 15:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] arm: mach-stm32: stm32h7: add STM32H747-DISCO board
To: Johannes Krottmayer <johannes@krotti42.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
 <20250508212058.640483-4-johannes@krotti42.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250508212058.640483-4-johannes@krotti42.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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



On 5/8/25 23:23, Johannes Krottmayer wrote:
> Add initial support for the STM32H747-DISCO board in Kconfig.
> 
> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  arch/arm/mach-stm32/stm32h7/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-stm32/stm32h7/Kconfig b/arch/arm/mach-stm32/stm32h7/Kconfig
> index 70233a4b23c..281906d8595 100644
> --- a/arch/arm/mach-stm32/stm32h7/Kconfig
> +++ b/arch/arm/mach-stm32/stm32h7/Kconfig
> @@ -9,8 +9,13 @@ config TARGET_STM32H743_EVAL
>  config TARGET_STM32H750_ART_PI
>  	bool "STM32H750 ART Pi board"
>  
> +config TARGET_STM32H747_DISCO
> +	bool "STM32H747 Discovery board"
> +	select ARCH_VERY_EARLY_INIT
> +
>  source "board/st/stm32h743-eval/Kconfig"
>  source "board/st/stm32h743-disco/Kconfig"
>  source "board/st/stm32h750-art-pi/Kconfig"
> +source "board/st/stm32h747-disco/Kconfig"

Add this new line respecting alphabetical order

With that fix :

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

>  
>  endif
