Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C07C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 13:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D7C829A1;
	Mon, 28 Apr 2025 15:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="z86YAHTe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D8082724; Mon, 28 Apr 2025 15:28:52 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 492A382935
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7213f5eaf8=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9QT9t011078;
 Mon, 28 Apr 2025 15:28:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Je3dZFx50T2kTOaKz+bZf7JxMJBAU7jkOjOH7uID1Cw=; b=z86YAHTe/xqJeBF3
 liFxpKShCHGf0haw9PvLaxRxs0c6oObRaqhId87wF1/ueJHJxdm4Xe9NiWK6Q1c5
 n4pUL/Zm1KpuLt4+cHq9TiF/ylI69z18TvPoavRCm2dWJRHoo6BNIW9fLekCpFFv
 IlRAxmv5qNB7R3leFRXXwZeuHDoedHzPwysUGPgoF+eXhAglTXY3TPMeCI8hCm4f
 JBrH1Oru5qnzbEE9Jq66EWbNQwkc5IvosGRt/F8MdeWObHpfu3vmV+/iRDfU26Dr
 28fWD6YK0CDCag3uOZw1ufwm8AjkKBBXq1dV5x42j10RGpv+JDlEyCqquK4R41X4
 qPJQUg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 469aencgav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 15:28:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 407774004C;
 Mon, 28 Apr 2025 15:27:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4BD0AA476F9;
 Mon, 28 Apr 2025 15:24:19 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 15:24:18 +0200
Message-ID: <438dcc5f-fef3-44f7-a99d-f00ae5f89557@foss.st.com>
Date: Mon, 28 Apr 2025 15:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/22] arm: stm32mp: stm32prog: PTA BSEC is not
 supported on closed device
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
References: <20250425131533.392747-1-patrice.chotard@foss.st.com>
 <20250425131533.392747-21-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250425131533.392747-21-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
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



On 4/25/25 15:15, Patrice Chotard wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> On closed device the PTA BSEC is never supported and the current check if
> PTA BSEC is supported cause a OP-TEE error:
> 
>   E/TC tee_ta_open_session
> 
> This patch removed this warning on closed device, because the check is
> skipped.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
> index 353aecc09de..f6395bad0ec 100644
> --- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
> +++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
> @@ -13,6 +13,7 @@
>  #include <part.h>
>  #include <tee.h>
>  #include <asm/arch/stm32mp1_smc.h>
> +#include <asm/arch/sys_proto.h>
>  #include <asm/global_data.h>
>  #include <dm/device_compat.h>
>  #include <dm/uclass.h>
> @@ -1357,7 +1358,7 @@ static int dfu_init_entities(struct stm32prog_data *data)
>  
>  	alt_nb = 1; /* number of virtual = CMD*/
>  
> -	if (IS_ENABLED(CONFIG_CMD_STM32PROG_OTP)) {
> +	if (IS_ENABLED(CONFIG_CMD_STM32PROG_OTP) && !stm32mp_is_closed()) {
>  		/* OTP_SIZE_SMC = 0 if SMC is not supported */
>  		otp_size = OTP_SIZE_SMC;
>  		/* check if PTA BSEC is supported */
Applied to u-boot-stm32/master

Thanks
Patrice
