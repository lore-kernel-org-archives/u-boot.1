Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D18E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 08:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 830B18022B;
	Wed, 18 Dec 2024 09:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="7ka27ryA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B5428022E; Wed, 18 Dec 2024 09:59:46 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3637B8021D
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 09:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2082afbf55=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI76J9V017142;
 Wed, 18 Dec 2024 09:59:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 1PWHxioncE+IpY/TSbKMpwYmt2jx6b6CCe4i8k455A4=; b=7ka27ryAoNaeVVKe
 IFuxfeSqiioVkVdC1sgCUcP9DV1Rp8Uqqw37MFy/9lqiSKt7Nb4Z6K2EXLQeYNgw
 P6iDSi1XR8k29zZnmfSHshvylz2nomNNligks2LrL1Kl5bUkD9nGKbp8LhH/ePRS
 4YJ+hnGcNwSAnM+HXWOvh07UWayH9Yyrc7ojj/jWzea2r6hGn6euexTKucBFetLZ
 87URpOP7wPy4t0J+nJixdM8MnWIZ15d4yFANjkBgRSdAU1VDtAFxOf+nnTA5Pots
 Dm+AexofdaKoOPM7YhS1siamXTpVLglp5pGQ3q2kWKZKJwBDPDwkvO9N8ub3AF+1
 gpJ3VQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ksq6repb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Dec 2024 09:59:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2FD2640073;
 Wed, 18 Dec 2024 09:58:39 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E061E261805;
 Wed, 18 Dec 2024 09:56:48 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 09:56:48 +0100
Message-ID: <100a3725-f9f1-4035-9f90-28dc15f6ee16@foss.st.com>
Date: Wed, 18 Dec 2024 09:56:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32mp: Fix dram_bank_mmu_setup() for LMB located
 above ram_top
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Igor Opaniuk <igor.opaniuk@foundries.io>, Simon
 Glass <sjg@chromium.org>
References: <20241213132655.670837-1-patrice.chotard@foss.st.com>
 <173445589585.4187054.717117017229929078.b4-ty@konsulko.com>
 <20241217171845.GP1505244@bill-the-cat>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20241217171845.GP1505244@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
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



On 12/17/24 18:18, Tom Rini wrote:
> On Tue, Dec 17, 2024 at 11:18:15AM -0600, Tom Rini wrote:
>> On Fri, 13 Dec 2024 14:26:55 +0100, Patrice Chotard wrote:
>>
>>> Previously, all LMB marked with LMB_NOMAP (above and below ram_top)
>>> are considered as invalid entry in TLB.
>>>
>>> Since commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top
>>>  even from same bank") all LMB located above ram_top are now marked
>>> LMB_NOOVERWRITE and no more LMB_MAP.
>>>
>>> [...]
>>
>> Applied to u-boot/master, thanks!
> 
> And apologies for applying this directly, I wanted to make sure the
> regression fix got in ASAP.
> 


No Problem , i understand ;-)
I expected to send a pull request today or tomorrow including this patch.

Patrice
