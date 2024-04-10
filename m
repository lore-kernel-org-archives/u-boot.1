Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F028BCD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 18:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539F887073;
	Wed, 10 Apr 2024 20:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YER4nn7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF0B4881AC; Wed, 10 Apr 2024 20:16:15 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99F4786D38
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 20:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43AIG5MX021469;
 Wed, 10 Apr 2024 13:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712772965;
 bh=UHxual3/RRk36X9AX08QmHSOtPVGhsvyf70BAfonZ/I=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=YER4nn7uSu2cOZp0pFUiEcoE89y6EbTsvR8p0avnT3y1ApcoVNyfw5jaQ/BQfhowz
 mKPkdsFKSu5uod5adtWnFE+N++Ox9mKM/EWfyo6QvrvjKS85VyTkTAApXRQH5atoau
 4daWooJErktXT4qODStcrXXAdb9qDE6zhd2uWJis=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43AIG5w1031912
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Apr 2024 13:16:05 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 13:16:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 13:16:05 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43AIG4sd043100;
 Wed, 10 Apr 2024 13:16:04 -0500
Date: Wed, 10 Apr 2024 23:46:03 +0530
From: Dhruva Gole <d-gole@ti.com>
To: <tkuw584924@gmail.com>
CC: <u-boot@lists.denx.de>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
 <Bacem.Daassi@infineon.com>, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2 1/3] mtd: spi-nore-core: Fix 4KB erase opcode for
 s25fs-s
Message-ID: <20240410181603.xfbrt66iubc2hixg@dhruva>
References: <cover.1712638210.git.Takahiro.Kuwano@infineon.com>
 <f351754643dda5305f385ce23eb74ff2ee41e177.1712638210.git.Takahiro.Kuwano@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f351754643dda5305f385ce23eb74ff2ee41e177.1712638210.git.Takahiro.Kuwano@infineon.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On Apr 09, 2024 at 15:20:20 +0900, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> The correct 4KB erase opcode should be selected based on the address width
> currently used.
> 
> Fixes: 562d166a13 ("mtd: spi-nor-core: Add fixups for s25fs512s")
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index f86003ca8c..9620852817 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -3299,8 +3299,10 @@ static int s25fs_s_quad_enable(struct spi_nor *nor)
>  
>  static int s25fs_s_erase_non_uniform(struct spi_nor *nor, loff_t addr)
>  {
> +	u8 opcode = nor->addr_width == 4 ? SPINOR_OP_BE_4K_4B : SPINOR_OP_BE_4K;
> +
>  	/* Support 8 x 4KB sectors at bottom */
> -	return spansion_erase_non_uniform(nor, addr, SPINOR_OP_BE_4K_4B, 0, SZ_32K);
> +	return spansion_erase_non_uniform(nor, addr, opcode, 0, SZ_32K);

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva
