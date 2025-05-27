Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B9DC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E09836BE;
	Tue, 27 May 2025 15:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="TU9eUPN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0190D83818; Tue, 27 May 2025 15:59:52 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A27830AB
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RBga7T000339;
 Tue, 27 May 2025 15:59:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 SkLMhHA8vn5MA7WR3D9loFZ9hWdDPSAn6hZipwKI99c=; b=TU9eUPN1ToD4rcv6
 IMggkwM3XOKIjRrx2nwrqcW1hv8W6c4pzPPDqx9tPJuxZkTl3S5LeY/KYWQmS7JG
 CH9JAcSDaP0Tlhi87DY831jeQOsztvxC+k652F/huYDDDlxM4xFPRLqT7mRt1MlK
 jOU75Pzp6JPdVodQNMZzZQT9Caa3k3c5sNSrU6tonRozvzIHWnzmPfYAkuinX7i2
 CtUK+ZoIRkU7UFDbTBTPEosHU8P7R/OmkdVd49yXAH6z3T62TEhRW/CoFvFjgA6O
 tFhuAsVgsZNwDZJbmW0Tplf1m4Yn+vY837Nvkxe855M7GKctUBWgVVdl0ZFT0KSM
 436xig==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46u50gm2ws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:59:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 08D594005F;
 Tue, 27 May 2025 15:59:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 98146AFA926;
 Tue, 27 May 2025 15:58:54 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:58:54 +0200
Message-ID: <9920c51f-24a2-4c8e-9787-2bd4b3f11d15@foss.st.com>
Date: Tue, 27 May 2025 15:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] watchdog: wdt-uclass.c: add
 wdt_set_force_autostart() helper
To: Antonio Borneo <antonio.borneo@foss.st.com>, <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>, Patrick Delaunay <patrick.delaunay@foss.st.com>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?=
 <clement.legoffic@foss.st.com>
References: <20250521122755.265760-1-antonio.borneo@foss.st.com>
 <20250523094658.299730-2-antonio.borneo@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250523094658.299730-2-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
> The watchdog could have been already started by a previous boot
> stage (e.g. bootrom or secure OS). U-Boot has to start and kick
> the watchdog even when CONFIG_WATCHDOG_AUTOSTART is not enabled
> or when the DT property u-boot,noautostart is present.
> 
> Add the helper wdt_set_force_autostart() that can be called by the
> driver's probe() when it detects that the watchdog has already
> been started and is running.
> 
> Co-developed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> ---
>  drivers/watchdog/wdt-uclass.c | 9 +++++++++
>  include/wdt.h                 | 9 +++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
> index 10be334e9ed..b32590069d9 100644
> --- a/drivers/watchdog/wdt-uclass.c
> +++ b/drivers/watchdog/wdt-uclass.c
> @@ -46,6 +46,15 @@ struct wdt_priv {
>  	struct cyclic_info cyclic;
>  };
>  
> +int wdt_set_force_autostart(struct udevice *dev)
> +{
> +	struct wdt_priv *priv = dev_get_uclass_priv(dev);
> +
> +	priv->autostart = true;
> +
> +	return 0;
> +}
> +
>  static void wdt_cyclic(struct cyclic_info *c)
>  {
>  	struct wdt_priv *priv = container_of(c, struct wdt_priv, cyclic);
> diff --git a/include/wdt.h b/include/wdt.h
> index 5026f5a6db4..1ef656585c4 100644
> --- a/include/wdt.h
> +++ b/include/wdt.h
> @@ -18,6 +18,15 @@ struct udevice;
>   * which typically include placing the system in a safe, known state.
>   */
>  
> +/*
> + * Force watchdog start during init. Called by driver's probe when the watchdog
> + * is detected as already started.
> + *
> + * @dev: WDT Device
> + * @return: 0 if OK, -ve on error
> + */
> +int wdt_set_force_autostart(struct udevice *dev);
> +
>  /*
>   * Start the timer
>   *

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
