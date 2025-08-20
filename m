Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F12CA0EF5
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 05:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0345E80FA1;
	Wed, 20 Aug 2025 07:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IGQjIACL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E4B28211F; Wed, 20 Aug 2025 07:28:16 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B628809A5
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 07:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57K5SA8b3059663;
 Wed, 20 Aug 2025 00:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755667690;
 bh=mKf51FtFwN2YVGRFLvWDe9GnRWpK5jLH1L8A4tFyIjw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=IGQjIACLtZPZXtG8s77r9LflsYB+RaxsgEeDrOJ9ERKHB5mQY+0S31uUMJpjGKeM/
 oIcauPaYV+qnkbEaTXBnXGuIvwpjdLEHiyTw4GhjYsQxSYq9OQeqshbjcgviZLG8lO
 SJDCyEX271ONJ5oFAka63sKhqHs7BoCNAcmv7NZY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57K5SAHc1817957
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 20 Aug 2025 00:28:10 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 00:28:09 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.1748.24; Wed, 20 Aug
 2025 00:28:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 00:28:09 -0500
Received: from [172.24.234.127] (psdkl-workstation0.dhcp.ti.com
 [172.24.234.127])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57K5S7x54188308;
 Wed, 20 Aug 2025 00:28:08 -0500
Message-ID: <3c7164dd-699b-47d9-a99a-ade42cc007c1@ti.com>
Date: Wed, 20 Aug 2025 10:58:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: omap24xx_i2c: remove unused members of struct
 omap_i2c
To: Rasmus Villemoes <ravi@prevas.dk>, <u-boot@lists.denx.de>
CC: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20250815061719.2758662-1-ravi@prevas.dk>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20250815061719.2758662-1-ravi@prevas.dk>
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



On 15/08/25 11:47, Rasmus Villemoes wrote:
> The clk and clk_id members of struct omap_i2c are not used anywhere,
> and AFAICT never have been.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---

Looks good to me,

Reviewed-by: Aniket Limaye <a-limaye@ti.com>

>   drivers/i2c/omap24xx_i2c.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/i2c/omap24xx_i2c.c b/drivers/i2c/omap24xx_i2c.c
> index a6361d3d17d..2c6f8ea5901 100644
> --- a/drivers/i2c/omap24xx_i2c.c
> +++ b/drivers/i2c/omap24xx_i2c.c
> @@ -134,12 +134,10 @@ static const u8 __maybe_unused reg_map_ip_v2[] = {
>   };
>   
>   struct omap_i2c {
> -	struct udevice *clk;
>   	int ip_rev;
>   	struct i2c *regs;
>   	unsigned int speed;
>   	int waitdelay;
> -	int clk_id;
>   };
>   
>   static inline const u8 *omap_i2c_get_ip_reg_map(int ip_rev)

