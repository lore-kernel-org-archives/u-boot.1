Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC24E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 18:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30EAA805E2;
	Wed,  8 Jan 2025 19:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="tuwKSB50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DBF88056E; Wed,  8 Jan 2025 19:50:05 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2ED38006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 19:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3103f025b2=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508EWBMS023173;
 Wed, 8 Jan 2025 19:50:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 IO/ZrZgThO7qUKObTWJ7f1gE+QUElvJc8F+caZ1AMwI=; b=tuwKSB50WDXWDv+O
 QtoleCEQ+e97Rr8li4a2KQ1ys0qd1UBV+yqRphZ5v/96Ajyl4/0y/AX0ni/A+RAO
 lgkKPhAASlFjwSTRHcP3qDNm2c1G5P2FouElHvY4CUVKTogNcEneBPaV9Hr2dhUJ
 ErGWh2Vd9zjBtXEp4E1yeMbSSBqGmM6k0+uTETWp7xocCZcTHcJLetnmUUnGg80k
 6SJNSh9YyuDrKHELw5ZC0e+0bji2dGJ203tWiabYXfyvcVbkylmixx2rNZkKwh9l
 qW1ZyScI8526VDi24PFK30PQD6NAJAwIiP1BiGDiHBU62toqRClgqEL0mJDLM7f4
 r/CAJw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 441u78rxsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 19:50:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F02AE40050;
 Wed,  8 Jan 2025 19:49:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9521029FB0C;
 Wed,  8 Jan 2025 19:49:09 +0100 (CET)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 8 Jan
 2025 19:49:09 +0100
Message-ID: <aede5c04-b1bd-42da-93e4-8c2cc7a5a9a1@foss.st.com>
Date: Wed, 8 Jan 2025 19:49:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] arm: stm32mp: stm32prog: update multiplier is
 part-size is above SZ_1G
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20241129122711.411917-1-patrice.chotard@foss.st.com>
 <20241129122711.411917-4-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241129122711.411917-4-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.126]
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

Hi

On 11/29/24 13:27, Patrice Chotard wrote:
> Set multiplier to 'G' if part->size if above SZ_1G.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
> index f0e019e8da1..353aecc09de 100644
> --- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
> +++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
> @@ -1229,7 +1229,10 @@ static int stm32prog_alt_add(struct stm32prog_data *data,
>   	char multiplier,  type;
>   
>   	/* max 3 digit for sector size */
> -	if (part->size > SZ_1M) {
> +	if (part->size > SZ_1G) {
> +		size = (u32)(part->size / SZ_1G);
> +		multiplier = 'G';
> +	} else if (part->size > SZ_1M) {
>   		size = (u32)(part->size / SZ_1M);
>   		multiplier = 'M';
>   	} else if (part->size > SZ_1K) {



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

