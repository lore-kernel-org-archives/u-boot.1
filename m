Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937C4CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 13:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1EB1801BE;
	Mon, 18 Aug 2025 15:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="3unjGSpW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF07801DD; Mon, 18 Aug 2025 15:06:38 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D9380107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 15:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0325d41c3d=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IC254u031415;
 Mon, 18 Aug 2025 15:06:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 iVi3duLdkHhBL9D1dqp7qTOGGxpdgY6qK9dghnt/CX0=; b=3unjGSpWjGK6jdE0
 YL+o7MI9Mox2ej/rRBeccd1kqbQvMgv9xu0NmbBvqdbCt5QLARLuJD1z/Sp1kj4I
 t2dynZHh2iIVh+uwGYAkctsmVSLCrZRnfbSzY3etPprEGY/C0irjVBjNv0j5E8Gt
 0xV0upxde6iNrZafemoWxLMscIVQHkoGTvZh+J+K9anEKXBqJLlWzmE3eA+5wwz5
 a3EA7STL+9hdp+S65n3gWHHBYgUjppoMOswYm8UDt/xQUyYkz02lXWSD5Gw2Xw6E
 B9wIwTUKvHn3PBnsGQnc1FsS7dC1QTz09xdZEvzYYske4OlflbRJwPZQ0hDuOoEE
 2+Ex9g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48k4xmm7xr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 15:06:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 49B454002D;
 Mon, 18 Aug 2025 15:05:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8ABB572C005;
 Mon, 18 Aug 2025 15:05:11 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 15:05:10 +0200
Message-ID: <0a9dbd9f-b4b3-48f8-ab2b-af29ff66016f@foss.st.com>
Date: Mon, 18 Aug 2025 15:05:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: rawnand: stm32_fmc2: set available OOB bytes per page
To: Christophe Kerello <christophe.kerello@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
References: <20250812123511.250782-1-christophe.kerello@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250812123511.250782-1-christophe.kerello@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
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



On 8/12/25 14:35, Christophe Kerello wrote:
> File system such as YAFFS2 need to know the number of available
> OOB bytes per page to be able to choose if they should locate their
> metadata in the data area or in the spare area.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> ---
> 
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> index d1c88643c98..21e3c88a55a 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -1034,6 +1034,7 @@ static int stm32_fmc2_nfc_probe(struct udevice *dev)
>  		ecclayout->eccpos[i] = oob_index;
>  	ecclayout->oobfree->offset = oob_index;
>  	ecclayout->oobfree->length = mtd->oobsize - ecclayout->oobfree->offset;
> +	ecclayout->oobavail = ecclayout->oobfree->length;
>  	chip->ecc.layout = ecclayout;
>  
>  	if (chip->options & NAND_BUSWIDTH_16)
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
