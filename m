Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782A1CA0FE9
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 09:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B4D1830B4;
	Tue, 26 Aug 2025 11:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="wy3Dtvgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BE07830F6; Tue, 26 Aug 2025 11:44:39 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53949830B4
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 11:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0333e70c0e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q9dY3A004177;
 Tue, 26 Aug 2025 11:44:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 U71FWt6QlBgFEQuC0nrXTrztx20w7nGVXxP3eg9aB8Q=; b=wy3DtvgubGqsTgFV
 IvgChSezLgTjZbJfwcwcIlq3GZ98GyI+mb1uyemW3kP2l+xbaiIyu2kpV02qG6qt
 6kH3tOPlkvGUEtnlPuSDdp48IpaqXMDafngxamKxp2dsvLziuNx0ne3lfuDMSDd/
 sEFp9of9MNzLt9Ip8gN8qG49P2g7Upvm9WMHtbtudwWIH09SY6NQlDrniHamzRNW
 KnWi0mx4Og+cAW1jEFYq0tyJkAqS1aAWC/9qYmLLG/V/9FOPXb8qVJYVEHioEmNp
 kAnz4nwKP/yD+nFJU18uVjfY+CdDyQsd9OjscB3h/COPsITaR7wqc8FxmbmIzrS7
 7ZcCcg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q626j5pa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 11:44:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7F7DA40044;
 Tue, 26 Aug 2025 11:43:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8965F5F9A95;
 Tue, 26 Aug 2025 11:43:01 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 26 Aug
 2025 11:43:01 +0200
Message-ID: <c8cd2235-525d-4931-bff2-8a29bc2fa87d@foss.st.com>
Date: Tue, 26 Aug 2025 11:43:00 +0200
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
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
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
Applied to u-boot-stm32/master

Thanks
Patrice
