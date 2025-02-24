Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4682DC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 15:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E388E80F3F;
	Mon, 24 Feb 2025 16:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="aUFMJDHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC38B80F7B; Mon, 24 Feb 2025 16:59:08 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EFCF80EC0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 16:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41501624e1=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OFtabN022560;
 Mon, 24 Feb 2025 16:59:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 zI+qPsNWBmCwXiWTFD9c3ILtdCSH+Xe456tgn/qWl4I=; b=aUFMJDHEuhTGkNFA
 fkMFTqPhJ0c6WfwTQar0LYTEP03oSow8ulHzcgeRfFBXA/Vc5P7QNYU7OOJFaUxZ
 73HAjdWm8Zg0Ye9KIeLNpx/gdfnLp38bXIpnyNr+3ypDmPE7+M6BeIM+SpOHUf0z
 OHe8pS9zwxU/Ap1EkFXwLulvFm2ODst5pMkHj+unkQBTomkmP70z1D6XDZJV7PKl
 9B0vnNPEhFxHadb4kkiTXxpuY77/cxhGa6VsTtg+HgkFzfe6PyWzMZfbz/RFK1vn
 sIseH7NXcTzDCueMw4n75oIxi3+5nuAQY03a/DpyQdXYJnTSnkxqK5Crym8xtm9N
 m77S+A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44y6t208x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 16:59:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A402A40071;
 Mon, 24 Feb 2025 16:57:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7DAF151E306;
 Mon, 24 Feb 2025 16:53:29 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 16:53:29 +0100
Message-ID: <1275fa83-668f-4caf-9f69-06c0d789983a@foss.st.com>
Date: Mon, 24 Feb 2025 16:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] board: stm32f746-disco: drop board_late_init()
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Vikas Manocha
 <vikas.manocha@st.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250217181439.1157972-1-dario.binacchi@amarulasolutions.com>
 <20250217181439.1157972-3-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250217181439.1157972-3-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_08,2025-02-24_02,2024-11-22_01
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



On 2/17/25 19:14, Dario Binacchi wrote:
> The removal of the "st,button1" and "st,led1" compatibles has emptied
> the board_late_init(), so let's remove it along with the configuration
> that allows its invocation.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  board/st/stm32f746-disco/stm32f746-disco.c | 5 -----
>  configs/stm32746g-eval_defconfig           | 1 -
>  configs/stm32746g-eval_spl_defconfig       | 1 -
>  configs/stm32f746-disco_defconfig          | 1 -
>  configs/stm32f746-disco_spl_defconfig      | 1 -
>  5 files changed, 9 deletions(-)
> 
> diff --git a/board/st/stm32f746-disco/stm32f746-disco.c b/board/st/stm32f746-disco/stm32f746-disco.c
> index 72f479cea66f..07bc8a5f0a27 100644
> --- a/board/st/stm32f746-disco/stm32f746-disco.c
> +++ b/board/st/stm32f746-disco/stm32f746-disco.c
> @@ -76,11 +76,6 @@ u32 spl_boot_device(void)
>  }
>  #endif
>  
> -int board_late_init(void)
> -{
> -	return 0;
> -}
> -
>  int board_init(void)
>  {
>  #ifdef CONFIG_ETH_DESIGNWARE
> diff --git a/configs/stm32746g-eval_defconfig b/configs/stm32746g-eval_defconfig
> index 4346ecd6e42b..bd3a48b20a2b 100644
> --- a/configs/stm32746g-eval_defconfig
> +++ b/configs/stm32746g-eval_defconfig
> @@ -21,7 +21,6 @@ CONFIG_USE_BOOTARGS=y
>  CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
>  CONFIG_SYS_PBSIZE=1050
>  # CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_BOARD_LATE_INIT=y
>  CONFIG_SYS_PROMPT="U-Boot > "
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MMC=y
> diff --git a/configs/stm32746g-eval_spl_defconfig b/configs/stm32746g-eval_spl_defconfig
> index 2756ad5508fc..d47d059d23b1 100644
> --- a/configs/stm32746g-eval_spl_defconfig
> +++ b/configs/stm32746g-eval_spl_defconfig
> @@ -30,7 +30,6 @@ CONFIG_USE_BOOTARGS=y
>  CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
>  CONFIG_SYS_PBSIZE=1050
>  # CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_BOARD_LATE_INIT=y
>  CONFIG_SPL_PAD_TO=0x9000
>  CONFIG_SPL_NO_BSS_LIMIT=y
>  CONFIG_SPL_BOARD_INIT=y
> diff --git a/configs/stm32f746-disco_defconfig b/configs/stm32f746-disco_defconfig
> index 35a489c34e00..f6fbf83f68f1 100644
> --- a/configs/stm32f746-disco_defconfig
> +++ b/configs/stm32f746-disco_defconfig
> @@ -21,7 +21,6 @@ CONFIG_USE_BOOTARGS=y
>  CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
>  CONFIG_SYS_PBSIZE=1050
>  # CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_BOARD_LATE_INIT=y
>  CONFIG_SYS_PROMPT="U-Boot > "
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MMC=y
> diff --git a/configs/stm32f746-disco_spl_defconfig b/configs/stm32f746-disco_spl_defconfig
> index 6826b1cb7559..dcf077dbfeec 100644
> --- a/configs/stm32f746-disco_spl_defconfig
> +++ b/configs/stm32f746-disco_spl_defconfig
> @@ -30,7 +30,6 @@ CONFIG_USE_BOOTARGS=y
>  CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
>  CONFIG_SYS_PBSIZE=1050
>  # CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_BOARD_LATE_INIT=y
>  CONFIG_SPL_PAD_TO=0x9000
>  CONFIG_SPL_NO_BSS_LIMIT=y
>  CONFIG_SPL_BOARD_INIT=y

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
