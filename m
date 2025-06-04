Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0529CC5B552
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 06:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C95B382C8A;
	Wed,  4 Jun 2025 08:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="tqO172hT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A5982CC9; Wed,  4 Jun 2025 08:02:42 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4E282BD9
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 08:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8250fb800b=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554561cu030993;
 Wed, 4 Jun 2025 08:02:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 pp+p9tWWi7Jf6J75qY4XT2Q5DqOWjrnwHEnN+QPoKVE=; b=tqO172hTQQk1y5dJ
 eHMO4ScspTxQE8hTq2P6GFJ9rxtYl4d/HsdU+mTPN9q+RvllqCjVEbJXyLxIHRy7
 f1FSdYv4uTOr6Q4PtorEn3csS3MmtbIKBz7lbFyT+pB8+nM725KHbe540FaoRkGE
 MAmSUx/b+jzw+wxNLkR8AgL4x4B28ByE7Skav/9yZ5SH9d2D2we/MIAyQ8a0pd+J
 n9d9g6vyHFYoc0tj6YGqHYcu//dvQow9S68JzYfZ6E8njwX8ml3A2T9QkGk3DOfm
 dLaloA8xIGCmg4pj6apk3Lrv3WSGxo8QrU/eRDTDMN0rPlnkPqjOLXz85jzoiTjQ
 ATjDhw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g8syd9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 08:02:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E2ACE400B3;
 Wed,  4 Jun 2025 08:01:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3DCD5A73EEB;
 Wed,  4 Jun 2025 07:59:49 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 07:59:48 +0200
Message-ID: <5486f57e-064d-4f03-89bd-46fb5a825382@foss.st.com>
Date: Wed, 4 Jun 2025 07:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] clk: scmi: manage properly the clk identifier
 with CCF
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Casey Connolly <casey.connolly@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Neil
 Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>, Ye Li <ye.li@nxp.com>
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
 <20250527132755.2169508-9-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250527132755.2169508-9-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_01,2025-06-03_02,2025-03-28_01
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



On 5/27/25 15:27, Patrice Chotard wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Each clock identifier needs to be unique when CCF is activated,
> and it is not respected today by SCMI clock driver.
> 
> This patch supports a unique clk id by using the uclass API
> clk_get_id() / dev_clk_dm() and by activating by default
> CONFIG_CLK_AUTO_ID with CCF which adds an offset to the SCMI
> clock identifiers.
> 
> After this patch, the SCMI clock driver can coexist with other
> clock provider without conflict, they can share internal identifier
> [0..N] defined in their binding and the clock ID = 0
> (reserved for dummy clock) is no more used.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Sean Anderson <seanga2@gmail.com>
> ---
> 
> (no changes since v1)
> 
>  drivers/clk/Kconfig    | 1 +
>  drivers/clk/clk_scmi.c | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index b2e53fe325e..c848b4984f8 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -192,6 +192,7 @@ config CLK_SCMI
>  	bool "Enable SCMI clock driver"
>  	depends on CLK
>  	depends on SCMI_FIRMWARE
> +	select CLK_AUTO_ID if CLK_CCF
>  	help
>  	  Enable this option if you want to support clock devices exposed
>  	  by a SCMI agent based on SCMI clock protocol communication
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index e323a948780..cfb372e6190 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -132,7 +132,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
>  static int scmi_clk_gate(struct clk *clk, int enable)
>  {
>  	struct scmi_clk_state_in in = {
> -		.clock_id = clk->id,
> +		.clock_id = clk_get_id(clk),
>  		.attributes = enable,
>  	};
>  	struct scmi_clk_state_out out;
> @@ -197,7 +197,7 @@ static int scmi_clk_disable(struct clk *clk)
>  static ulong scmi_clk_get_rate(struct clk *clk)
>  {
>  	struct scmi_clk_rate_get_in in = {
> -		.clock_id = clk->id,
> +		.clock_id = clk_get_id(clk),
>  	};
>  	struct scmi_clk_rate_get_out out;
>  	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
> @@ -219,7 +219,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
>  static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
>  {
>  	struct scmi_clk_rate_set_in in = {
> -		.clock_id = clk->id,
> +		.clock_id = clk_get_id(clk),
>  		.flags = SCMI_CLK_RATE_ROUND_CLOSEST,
>  		.rate_lsb = (u32)rate,
>  		.rate_msb = (u32)((u64)rate >> 32),
> @@ -313,7 +313,7 @@ static int scmi_clk_probe(struct udevice *dev)
>  				return ret;
>  			}
>  
> -			clk_dm(i, &clk_scmi->clk);
> +			dev_clk_dm(dev, i, &clk_scmi->clk);
>  
>  			if (CLK_HAS_RESTRICTIONS(attributes)) {
>  				u32 perm;
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
