Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814B7C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 17:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 129E282C7D;
	Tue,  3 Jun 2025 19:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="GhhFdafr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6048482CA2; Tue,  3 Jun 2025 19:28:09 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D8482AAA
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 19:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82493dba10=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553CVpxf003099;
 Tue, 3 Jun 2025 19:28:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 qEwJshrEjhKlpSAngSQic5mJXJ9JiQe29DPAd6EtiA8=; b=GhhFdafrknkYxmp8
 BAWT+lZS9C1kUY3NzaOaBmef+MYm7M3Yk6WQfcvdePNIgcWLa63y6ZByfMFNbc8D
 1XKJhuF5ROEOH/4/OtmB20ZtqQOCN9qfmQbX+5DN+WlCAQIPws+uacsYxWuU7aeV
 rOWt1Id1W7N5+tvsEt5791HEZYR/lh1fgYAu8Z+5SRbhuyV0UzTrZISFF+jOF41C
 s55lTakJeeGDE4lxJnJOgSl716F5k2fxuxBSxr8SzZtaBa7veUNAaZv+twv4BrCX
 ZqgWlHQlysq3RKCl3pZAvSmjGnX5jbEAj3pp2j/ZbXyNwxogh5yEWlvZFN2CJj3Q
 YROjyg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g93dbvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 19:28:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8690940048;
 Tue,  3 Jun 2025 19:27:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EE801B59055;
 Tue,  3 Jun 2025 19:25:41 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 19:25:41 +0200
Message-ID: <4b736058-3568-4ab1-9bb8-08f40aa046c3@foss.st.com>
Date: Tue, 3 Jun 2025 19:25:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] clk: fixed_rate: configure clock ID with
 CONFIG_CLK_AUTO_ID
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
 <20250527132755.2169508-8-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250527132755.2169508-8-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
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

Hi,

On 5/27/25 15:27, Patrice Chotard wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Update CLK ID to avoid 0 id, used for dummy clock with CCF
> and to allow selection by clk_get_by_id, used to
> get private data associated to the UCLASS_CLK device
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Sean Anderson <seanga2@gmail.com>
> ---
>
> (no changes since v1)
>
>   drivers/clk/clk_fixed_rate.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/clk_fixed_rate.c
> index d1da05cc18a..95a77d2e041 100644
> --- a/drivers/clk/clk_fixed_rate.c
> +++ b/drivers/clk/clk_fixed_rate.c
> @@ -44,6 +44,7 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev,
>   	dev_set_uclass_priv(dev, clk);
>   
>   	clk->dev = dev;
> +	clk->id = CLK_ID(dev, 0);
>   	clk->enable_count = 0;
>   }
>   


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


