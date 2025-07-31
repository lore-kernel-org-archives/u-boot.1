Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B619C87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 05:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC32E8319A;
	Thu, 31 Jul 2025 07:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PQhpHE5v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C2D48319C; Thu, 31 Jul 2025 07:11:41 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23E2B8313B
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 07:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V5BbFT2951587;
 Thu, 31 Jul 2025 00:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753938697;
 bh=9+/bVWrO/t06ImXACe74hRIvhNMj5eYbMY1zrftfsA4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=PQhpHE5vA9X4vUT7NEkiDtKFZBfkgkdeNrlMOrH+dp3/wsqWzw6cTHi/zPM8EneUS
 f2WrvTacKr9b9K7QjXuntr6H6TiPrd2tzEwb4neUJx7qCywChOsZsaRDWQYyoflkAy
 N3QaJ300Ca4RC94QajHq28l11vVJvm8Lgmlp37mY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V5BaUx3711078
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 00:11:36 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 00:11:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 00:11:36 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V5BXa22364708;
 Thu, 31 Jul 2025 00:11:34 -0500
Message-ID: <ad1d6d7d-cbb5-4873-971e-c754f2bc5038@ti.com>
Date: Thu, 31 Jul 2025 10:41:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] ddr: imx8m: Fix DDR inline ECC scruber configuration
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Oliver Chen <oliver.chen@nxp.com>
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
 <20250728-ddr-imx-v1-1-73da75bb33d3@nxp.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250728-ddr-imx-v1-1-73da75bb33d3@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Peng

On 28/07/25 08:54, Peng Fan (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> The ECC scruber setting is incorrect and decreases the DDR performance
> in ECC enabled mode.
> 

nitpick: s/scruber/scrubber

> Detail changes:
> -Before, scrub_burst was 0; this is not allowed per SNPS umctl2 spec.
>  Set to "2" to align with DXL whichw as found to be most optimal setting
> -Before, scrub_interval was set to 1, which means back-to-back scrubber
>  reads will occur very frequently, potentially effecting performance.
> -Set scrub_interval to 0xFF which is the default value. However, users
>  can tune this to meet their system needs.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Oliver Chen <oliver.chen@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I understand you are porting downstream patches and retaining the tags,
but aren't both R/B and SO/B tags for a single person is redundant? I
have not seen it elsewhere yet.

> ---
>  drivers/ddr/imx/imx8m/ddr_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ddr/imx/imx8m/ddr_init.c b/drivers/ddr/imx/imx8m/ddr_init.c
> index e9209ce8b61d7ed3507bc102cc8f57ebba077067..7fdcfee1d9c982d391fe0d20e373a66d71d26e23 100644
> --- a/drivers/ddr/imx/imx8m/ddr_init.c
> +++ b/drivers/ddr/imx/imx8m/ddr_init.c
> @@ -58,9 +58,9 @@ void ddrc_inline_ecc_scrub(unsigned int start_address,
>  	/* Step11: Disable SBR by programming SBRCTL.scrub_en=0 */
>  	clrbits_le32(DDRC_SBRCTL(0), 0x1);
>  	/* Step12: Prepare for normal scrub operation(Read) and set scrub_interval*/
> -	reg32_write(DDRC_SBRCTL(0), 0x100);
> +	reg32_write(DDRC_SBRCTL(0), 0xFF20);
>  	/* Step13: Enable the SBR by programming SBRCTL.scrub_en=1 */
> -	reg32_write(DDRC_SBRCTL(0), 0x101);
> +	reg32_write(DDRC_SBRCTL(0), 0xFF21);

Changing the write value to using macros like SBRBURST | SBRINTV | SBREN
will help. Especially since you've mentioned that these parameters are
tunable.

>  	/* Step14: Enable AXI ports by programming */
>  	reg32_write(DDRC_PCTRL_0(0), 0x1);
>  	/* Step15: Disable quasi-dynamic programming */
> 

-- 
Thanking You
Neha Malcom Francis
