Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9972BC83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 09:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B0B98349B;
	Thu, 31 Jul 2025 11:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="8Z6EA1I8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D18D28360D; Thu, 31 Jul 2025 11:21:49 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E669583457
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 11:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0307a9198e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V8cMgS032657;
 Thu, 31 Jul 2025 11:21:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Y2C6QE+hVOhfXLJX9aGP10E+xUCbxchgXhrcS8Utjes=; b=8Z6EA1I8IOT1blrd
 HpZbqs6uoixsN3m+pJLvVTQM8yZAVkud6/gL2dHQnzepSzNWPWpvZbRlKuxzvkNI
 NMOYqgVqSVw/ymvKeE11EqKNn5oyw5r2XHtPV0QtavmtvbBQHPCfxaxjv5PRzVBF
 W6WbCnAOaem2YeiQmVWoWyutooKphy0bBW3B3YMOHbfEnMxhYCkPawNqfkUzc3xm
 JLrDVXkqgAvTFM4AHJISPM1jeF5yidZFND11DsibwvrYRBgOZsuyIvuPz1Dvs2Qt
 9mxN9NolTl20vjTdNHrfomEHPfaL2l6ksQYn4wjeYV1JejsthOqX0C55BjFEsjfX
 cDQxZw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484pc2pe6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Jul 2025 11:21:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C780E40047;
 Thu, 31 Jul 2025 11:20:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D7BB67530B4;
 Thu, 31 Jul 2025 11:19:54 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 11:19:54 +0200
Message-ID: <23d37033-1fba-404b-aa80-f7bd0a1ff4d3@foss.st.com>
Date: Thu, 31 Jul 2025 11:19:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: scmi: Fix clock identifier passed to struct
 scmi_clk_parent_set_in
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, <lukma@denx.de>,
 <seanga2@gmail.com>, <trini@konsulko.com>, <festevam@gmail.com>,
 <alice.guo@nxp.com>, <patrick.delaunay@foss.st.com>,
 <peng.fan@nxp.com>, <ye.li@nxp.com>, <valentin.caron@foss.st.com>
CC: <u-boot@lists.denx.de>
References: <20250707202034.385890-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250707202034.385890-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
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



On 7/7/25 22:20, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Commit aa7bdc1af505 ("clk: scmi: manage properly the clk identifier with
> CFF") enables CONFIG_CLK_AUTO_ID, so need to use clk_get_id() to get the
> real SCMI CLK ID, otherwise wrong ID is used when set clk parent.
> 
> Fixes: aa7bdc1af505 ("clk: scmi: manage properly the clk identifier with
> CCF")
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> Changes for v2:
>  - improve commit log
>  - add Reviewed-by
> 
>  drivers/clk/clk_scmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index cfb372e6190..0c9a81cabcc 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -336,8 +336,8 @@ static int scmi_clk_probe(struct udevice *dev)
>  static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
>  {
>  	struct scmi_clk_parent_set_in in = {
> -		.clock_id = clk->id,
> -		.parent_clk = parent->id,
> +		.clock_id = clk_get_id(clk),
> +		.parent_clk = clk_get_id(parent),
>  	};
>  	struct scmi_clk_parent_set_out out;
>  	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
Applied to u-boot-stm32/master

Thanks
Patrice
