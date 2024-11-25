Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A61D58D65
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 16:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A3D089A0B;
	Mon, 25 Nov 2024 17:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bvT2+dI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA77589A53; Mon, 25 Nov 2024 17:27:09 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0309488D9C
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 17:27:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4APGR4p9699422
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Nov 2024 10:27:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732552024;
 bh=LrCyXYVDuNAc0qCxFgvgcSHhJSNu0toQX2kWWbZfATY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=bvT2+dI3DlROjfFicnQE+H5Qkfe/JtTBCHYWosx5MxDkq7xmnNKAGzvrBNMXw8BIw
 fMgdYey+FZEJT5y/YJNLUurj9rN1xfwaNSCUjcpc/hysjtZKUhEq+GV5DxUweBKMjm
 qv+G+ssCxftkRDghEBTgFpul9H9oAfzzPzVeS4OQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4APGR4Ce024926
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Nov 2024 10:27:04 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Nov 2024 10:27:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Nov 2024 10:27:04 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4APGR1Tm035877;
 Mon, 25 Nov 2024 10:27:02 -0600
Message-ID: <ea5abd4c-1f18-44f2-b44c-1b4014ceb5cb@ti.com>
Date: Mon, 25 Nov 2024 21:57:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-core: Fixup SNOR_F_IO_MODE_EN_VOLATILE for
 MT35X
To: Prasanth Babu Mantena <p-mantena@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <vigneshr@ti.com>, Jagan Teki
 <jagan@amarulasolutions.com>
CC: <j-humphreys@ti.com>, <n-francis@ti.com>, <vaishnav.a@ti.com>
References: <20241125104947.1324824-1-p-mantena@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241125104947.1324824-1-p-mantena@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Thanks for fix

On 11/25/2024 4:19 PM, Prasanth Babu Mantena wrote:
> From: Vaishnav Achath <vaishnav.a@ti.com>
>
> MT35XU512ABA has only BFPT and 4-Byte Address Instruction Table
> in  SFDP. commit bebdc237507c ("mtd: spi-nor: Parse SFDP SCCR Map")
> added checks in spi_nor_octal_dtr_enable() to bail out if the 22nd DWORD
> in SCCR does not indicate DTR Octal Mode Enable, since MT35XU512ABA device
> supports octal DTR mode, add this property in SFDP fixup.
>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>
> Test results : https://gist.github.com/PrasanthBabuMantena/678cbd7a230a4e2d19e22d20dfeb1235
>
>   drivers/mtd/spi/spi-nor-core.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index ec841fb13bd..6364d91fac0 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -4109,6 +4109,12 @@ static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor,
>   	params->rdsr_dummy = 8;
>   	params->rdsr_addr_nbytes = 0;
>   
> +	/*
> +	 * SCCR Map 22nd DWORD does not indicate DTR Octal Mode Enable
> +	 * for MT35XU512ABA but is actually supported by device.
> +	 */
> +	nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
> +


Reviewed-by: Udit Kumar <u-kumar1@ti.com>

+ jagan@amarulasolutions.com, not sure, if this needs to go through SPI 
branch


>   	/*
>   	 * The BFPT quad enable field is set to a reserved value so the quad
>   	 * enable function is ignored by spi_nor_parse_bfpt(). Make sure we
