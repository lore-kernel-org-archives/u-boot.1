Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99333C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 035B58141D;
	Thu,  6 Mar 2025 15:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Wpdo6IeV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51BE681430; Thu,  6 Mar 2025 15:15:11 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23BB880756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=5160866d43=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526DMtxR028180;
 Thu, 6 Mar 2025 15:15:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 wG3ScQC2YN6VjN4kaFGZZmu/XFUtZJwCxN+l8tCODVw=; b=Wpdo6IeVbYzeNbsc
 p4H5ZOw9TvZ4RJ9IbljQ22cdog7z43Nz8+luGagQeP/etvhbpZc4zQtAJNPtSBYX
 AeEl5WUQAgF2zoMj0Zg+at6siDLhy0rPyZDhsDWD1xFBEZg8Rj+abJpfISi5dJ77
 QIEQJ2ixh+Nn02ShXrFcQdt4aVX+DCMVtO8MCnvSqzA6TnEAOhMPGFnKdqCvWJWX
 57zzvH5e9sqsb9Jy5IS2QDmPrOP5DBHcy/xCw20wAConULMmMjzDnoJalLJ96uov
 Doqtz9vHH/D+Hg2mPGIq5r8fPsF9ETe0XPfxgJ4ToYvAqzfhQ4aoCIHNMbFN6CVx
 AclCOw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 457a6fhjfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 15:15:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C5A554006C;
 Thu,  6 Mar 2025 15:14:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E46E257E845;
 Thu,  6 Mar 2025 15:13:52 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 15:13:52 +0100
Message-ID: <6ef98461-7ffb-4257-bc5f-bc0c543a773c@foss.st.com>
Date: Thu, 6 Mar 2025 15:13:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dm: pwm: Check if duty_ns is lower than period_ns
To: Cheick Traore <cheick.traore@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20250306105620.624760-1-cheick.traore@foss.st.com>
 <20250306115558.1.I060a56226e03cddfd4a6d6b98bc86c91435710cc@changeid>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250306115558.1.I060a56226e03cddfd4a6d6b98bc86c91435710cc@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
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



On 3/6/25 11:56, Cheick Traore wrote:
> It was possible to provide a duty_ns greater than period_ns to
> "pwm config" command. The framework must check the values before
> providing them to drivers.
> 
> Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
> ---
> 
>  drivers/pwm/pwm-uclass.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-uclass.c b/drivers/pwm/pwm-uclass.c
> index 6543db1d623..b4491f7dcd4 100644
> --- a/drivers/pwm/pwm-uclass.c
> +++ b/drivers/pwm/pwm-uclass.c
> @@ -27,6 +27,9 @@ int pwm_set_config(struct udevice *dev, uint channel, uint period_ns,
>  	if (!ops->set_config)
>  		return -ENOSYS;
>  
> +	if (duty_ns > period_ns)
> +		return -EINVAL;
> +
>  	return ops->set_config(dev, channel, period_ns, duty_ns);
>  }
>  
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
