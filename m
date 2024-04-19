Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8146C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB3E887E9;
	Fri, 19 Apr 2024 14:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="5/VtfK1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A568887E7; Fri, 19 Apr 2024 14:17:24 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 176EE887EA
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43JABb7m030132; Fri, 19 Apr 2024 14:17:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=vKnrIJ8SfYptriWBhyrUW8Sr2mrxIzkSXR2ebEiisAo=; b=5/
 VtfK1IYfRAiCKYuR3Qfh4HuIUPss8oLE9gGqq+GHUsKshwM5+fY76wF72GBBgW56
 GLP83JHXuLrPza2YkVkwMCBoFgE/lnhchfGwgtIVcELFpAzHpo3AC174Tz1mjuCY
 LyaPbglyywAMOnJ6zpRN7H9dx88V8kQwnV/Q3Vo0Mc4k+XgFR/A7E4y1f9fuzk9g
 ABGA4Iwq8H8A3jn0ZGW8HqnA7YRyhpxqcc+SOnqYVWFerW+GNEuBiHMMk7cp05eK
 dhrGjExCTKSDTHJla2fITPxVnPjcdZE6eTCyLPYMkodqN0S/Hzpuyv2aPDvzEfAJ
 FvjtLzpZf8at0AE/BIbQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xff64utke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:17:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6A66440046;
 Fri, 19 Apr 2024 14:17:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 153BC21A200;
 Fri, 19 Apr 2024 14:17:01 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:17:00 +0200
Message-ID: <8761b18a-e030-46f2-bb2e-2d12e8d45941@foss.st.com>
Date: Fri, 19 Apr 2024 14:17:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/25] ARM: dts: stm32: Add gpio-keys for
 stm32mp135f-dk-u-boot
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Tom Rini <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-8-patrice.chotard@foss.st.com>
 <ffb64338-341d-409d-8f27-e615cc9a6f9d@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ffb64338-341d-409d-8f27-e615cc9a6f9d@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_08,2024-04-19_01,2023-05-22_02
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



On 4/17/24 11:06, Patrick DELAUNAY wrote:
> Hi
> 
> On 4/9/24 17:01, Patrice Chotard wrote:
>> Add 2 gpio-keys :
>>    _ button-user-1 for stm32prog mode activation.
>>    _ update button-user's label (defined in kernel DT) to match label
>>      requested in board_key_check() for fastboot mode activation.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp135f-dk-u-boot.dtsi | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 

Applied on u-boot-stm32/master 
