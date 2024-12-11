Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0B7E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 16:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A579E8010E;
	Wed, 11 Dec 2024 17:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Z7vcMrdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2162680040; Wed, 11 Dec 2024 17:20:06 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2412802A1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 17:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=207521b3fe=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBF99Zm028237;
 Wed, 11 Dec 2024 17:19:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 32V3xR1FSn7HoVO+JHc4mQ9OMVNlydAHZWDgolUI/gc=; b=Z7vcMrdu6HnDfkhc
 yXf63du7Jw1rSchy4R1m+yNvOiTXeNESUiuQEdFidOw5s2o9rCS+wO+4tIpBPlbG
 ZORk/dJDi7h6sOyvjX7+Nc285AHN++kJXGEqzGwi6J2iF2qndW36uCz3VaZKAGR2
 l0rh0VcWHmzfPwEXdsEyLoU1J6oXiDSC0gM6jLoMnB8LN0HOYLHsS4Qt7+ISnE5D
 McewiW+3gmx6ubLwmJXHOZMy/JmXlQg0Kx581Vr9zyTmAQC1HHBFOKc4PKurUPzl
 pDyQYh8oMs6oe+Sca4SvMzaRLqJUR12AKBhcJf23gzyJQfmDQ3BAwZsODxFXFCIV
 bNg54Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ccnmbyah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2024 17:19:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 22C7840049;
 Wed, 11 Dec 2024 17:19:01 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7AC22C38A2;
 Wed, 11 Dec 2024 17:18:29 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 11 Dec
 2024 17:18:29 +0100
Message-ID: <092f9d73-c0c5-419e-b6e5-e671f8227753@foss.st.com>
Date: Wed, 11 Dec 2024 17:18:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: prohibit allocations above ram_top even from same
 bank
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Patrick DELAUNAY <patrick.delaunay@foss.st.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <lucent@gmail.com>
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
 <173358702572.3722028.2684286775587826268.b4-ty@konsulko.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <173358702572.3722028.2684286775587826268.b4-ty@konsulko.com>
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



On 12/7/24 16:57, Tom Rini wrote:
> On Mon, 02 Dec 2024 12:36:24 +0530, Sughosh Ganu wrote:
> 
>> There are platforms which set the value of ram_top based on certain
>> restrictions that the platform might have in accessing memory above
>> ram_top, even when the memory region is in the same DRAM bank. So,
>> even though the LMB allocator works as expected, when trying to
>> allocate memory above ram_top, prohibit this by marking all memory
>> above ram_top as reserved, even if the said memory region is from the
>> same bank.
>>
>> [...]
> 
> Applied to u-boot/master, thanks!
> 
Hello

This patch is breaking the boot on STM32MP135F-DK.

On this platform, we got an area above gd->ram_top, 
this area, reserved for OPTEE, is tagged with LMB_NOMAP in boot_fdt_add_mem_rsv_regions().

Since this commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank"),
this area is no more tagged as LMB_NOMAP, because it's previously been 
tagged with LMB_NOOVERWRITE in lmb_add_memory().

By not being tagged LMB_NOMAP, the MMU configuration is impacted and leads to a panic.

I suggest to revert this patch.

Patrice
