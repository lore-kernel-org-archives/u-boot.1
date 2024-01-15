Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E344C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 17:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC87A879F0;
	Mon, 15 Jan 2024 18:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="MSEDmbkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E19C879A3; Mon, 15 Jan 2024 18:42:01 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46478879D3
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 18:41:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d49635=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40FDU0Mv021553; Mon, 15 Jan 2024 18:41:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=6/UT7gKFicFObzsx8Abj/INWCx8ye9/bLxyN2tBV1Xs=; b=MS
 EDmbkm8U8zX65tCX37I8dp2L6IuIJFdr9ZfBZiiW5x7tfqZh/X/2omlFk+G6F7M2
 sZlGQeRqD9Dk9nCy1NhmUrkcS/WsJui6yMQFc+Yur8q8P8NKpKOXtbhoExkv7BLJ
 OhGGYUnldYANocMSk7PXVkrFVL1FMoXm0ym8QVqJugfYaNrdhe9vu6KrrRbiwHqB
 8kmF+hw9zQ9PbXobY/v4+PYNpvDUlqwvUn1Yauy/meGZeEg49O3pwjAxPTnfThLs
 50xhAvsQAm+OFTbs24iq/kxnekGvWLs44oz3ElMVLR+Rr4wu7AeSMB7H9gpp1EvM
 4qsPY3/g2+CgjKF+A98w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vm4y4qs5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 18:41:50 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0F88210002A;
 Mon, 15 Jan 2024 18:41:50 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 06EE42990BB;
 Mon, 15 Jan 2024 18:41:50 +0100 (CET)
Received: from [10.201.20.205] (10.201.20.205) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 18:41:49 +0100
Message-ID: <4dec5e9a-7a4b-4b1b-8736-8e56970e4bcc@foss.st.com>
Date: Mon, 15 Jan 2024 18:41:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] stm32mp: stm32prog: add support of stm32mp25
Content-Language: en-US
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
 <20240115150451.v2.9.Iad107c8eaf11680ad8debbedc8d48327f31fd866@changeid>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240115150451.v2.9.Iad107c8eaf11680ad8debbedc8d48327f31fd866@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.205]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
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



On 1/15/24 15:05, Patrick Delaunay wrote:
> Change OTP number to 364 for STM32MP25 as it is done in bsec driver.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h
> index ae4bd8842f53..eda98eb61d76 100644
> --- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h
> +++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h
> @@ -28,7 +28,15 @@
>  #else
>  #define OTP_SIZE_SMC		0
>  #endif
> -#define OTP_SIZE_TA		776
> +/* size of the OTP struct in NVMEM PTA */
> +#define _OTP_SIZE_TA(otp)	(((otp) * 2 + 2) * 4)
> +#if defined(CONFIG_STM32MP13x) || defined(CONFIG_STM32MP15x)
> +/* STM32MP1 with BSEC2 */
> +#define OTP_SIZE_TA		_OTP_SIZE_TA(96)
> +#else
> +/* STM32MP2 with BSEC3 */
> +#define OTP_SIZE_TA		_OTP_SIZE_TA(368)
> +#endif
>  #define PMIC_SIZE		8
>  
>  enum stm32prog_target {
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
