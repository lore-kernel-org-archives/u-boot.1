Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF9EC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 14:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF6FA83858;
	Tue, 27 May 2025 16:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="y7BatTaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA74E8386F; Tue, 27 May 2025 16:01:13 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A314483818
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 16:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RA2TNS020525;
 Tue, 27 May 2025 16:01:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 8QMgi0gE0FBaMNeI2NwsQMyJfMwFa/dBNiObpX8qq7M=; b=y7BatTaFCc00FTx4
 FQC8/C2YlxLT1R+P0ga5UhZINPu0lPTDxJDU7vDDky4xhn9ytzq8Yph+DygWK9x8
 NqWF51+OaZmQpzguNYJfcygsBIYcH9wBWtMDHHJJzXRhTt732nCLA4ieWB/j12kf
 t4CtvI/ERSrXfbFbexXyUWBim+/JrDLp5dvdjzQfpl/Aa/Vn6yV58NEeCJrBdqSp
 9QqX13U3wKbg+7/ghp4saw36jbWSdBlvtoCSxWAxoU4+B7BDL+O5JDy41S8E8LmO
 6nZPfY2i+HeYJC4p43RqgDunWUU9b8qcfBap/40c1SmauGzAoabt80JTIoaGNRmt
 le4sgA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46uqp4j9h6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 16:01:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0766A4005A;
 Tue, 27 May 2025 16:00:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5FC5EAFAE80;
 Tue, 27 May 2025 16:00:04 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 16:00:03 +0200
Message-ID: <2154fd75-d1e0-4673-9bbe-4200c661275c@foss.st.com>
Date: Tue, 27 May 2025 16:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] watchdog: stm32mp: check the watchdog status
To: Antonio Borneo <antonio.borneo@foss.st.com>, <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>, Patrick Delaunay <patrick.delaunay@foss.st.com>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?=
 <clement.legoffic@foss.st.com>
References: <20250521122755.265760-1-antonio.borneo@foss.st.com>
 <20250523094658.299730-4-antonio.borneo@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250523094658.299730-4-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_07,2025-05-27_01,2025-03-28_01
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



On 5/23/25 11:46, Antonio Borneo wrote:
> From: Clément Le Goffic <clement.legoffic@foss.st.com>
> 
> Add a mean to check the IWDG status based on the peripheral version.
> This is done by either checking the status bit ONF either by updating
> the reload register with the same value and check if the reload succeed.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> ---
>  drivers/watchdog/stm32mp_wdt.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/watchdog/stm32mp_wdt.c b/drivers/watchdog/stm32mp_wdt.c
> index 97ab8cfe7ab..0712524b4a8 100644
> --- a/drivers/watchdog/stm32mp_wdt.c
> +++ b/drivers/watchdog/stm32mp_wdt.c
> @@ -21,11 +21,13 @@
>  #define IWDG_PR		0x04	/* Prescaler Register */
>  #define IWDG_RLR	0x08	/* ReLoad Register */
>  #define IWDG_SR		0x0C	/* Status Register */
> +#define IWDG_VERR	0x3F4	/* Version Register */
>  
>  /* IWDG_KR register bit mask */
>  #define KR_KEY_RELOAD	0xAAAA	/* Reload counter enable */
>  #define KR_KEY_ENABLE	0xCCCC	/* Peripheral enable */
>  #define KR_KEY_EWA	0x5555	/* Write access enable */
> +#define KR_KEY_DWA	0x0000	/* Write access disable*/
>  
>  /* IWDG_PR register bit values */
>  #define PR_256		0x06	/* Prescaler set to 256 */
> @@ -36,10 +38,17 @@
>  /* IWDG_SR register bit values */
>  #define SR_PVU		BIT(0)	/* Watchdog prescaler value update */
>  #define SR_RVU		BIT(1)	/* Watchdog counter reload value update */
> +#define SR_ONF		BIT(8)	/* Watchdog enable status bit */
> +
> +/* IWDG Compatibility */
> +#define ONF_MIN_VER	0x31
> +
> +#define TIMEOUT_US	10000
>  
>  struct stm32mp_wdt_priv {
>  	fdt_addr_t base;		/* registers addr in physical memory */
>  	unsigned long wdt_clk_rate;	/* Watchdog dedicated clock rate */
> +	unsigned int hw_version;	/* Peripheral version */
>  };
>  
>  static int stm32mp_wdt_reset(struct udevice *dev)
> @@ -90,6 +99,7 @@ static int stm32mp_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>  static int stm32mp_wdt_probe(struct udevice *dev)
>  {
>  	struct stm32mp_wdt_priv *priv = dev_get_priv(dev);
> +	u32 rlr, sr;
>  	struct clk clk;
>  	int ret;
>  
> @@ -115,6 +125,29 @@ static int stm32mp_wdt_probe(struct udevice *dev)
>  
>  	priv->wdt_clk_rate = clk_get_rate(&clk);
>  
> +	priv->hw_version = readl(priv->base + IWDG_VERR);
> +
> +	if (priv->hw_version >= ONF_MIN_VER) {
> +		if (readl(priv->base + IWDG_SR) & SR_ONF)
> +			wdt_set_force_autostart(dev);
> +	} else {
> +		/*
> +		 * Workaround for old versions without IWDG_SR_ONF bit:
> +		 * - write in IWDG_RLR_OFFSET
> +		 * - wait for sync
> +		 * - if sync succeeds, then iwdg is running
> +		 */
> +		writel(KR_KEY_EWA, priv->base + IWDG_KR);
> +		rlr = readl(priv->base + IWDG_RLR);
> +		writel(rlr, priv->base + IWDG_RLR);
> +		ret = readl_poll_timeout(priv->base + IWDG_SR, sr, sr & SR_RVU,
> +					 TIMEOUT_US);
> +		if (!ret)
> +			wdt_set_force_autostart(dev);
> +
> +		writel(KR_KEY_DWA, priv->base + IWDG_KR);
> +	}
> +
>  	dev_dbg(dev, "IWDG init done\n");
>  
>  	return 0;
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
