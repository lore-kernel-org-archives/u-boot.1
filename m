Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FEDC54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 09:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4289C87E93;
	Fri,  8 Mar 2024 10:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="blwInS6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA27187E93; Fri,  8 Mar 2024 10:00:24 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 869C588043
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 10:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4288xtGe018786;
 Fri, 8 Mar 2024 02:59:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709888395;
 bh=APCO1zwamYQdOCgJjhc9ug5eCr31PaPFjsfYwTUU8XU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=blwInS6ssDAt/ALBVebsvRzRI7YLINm/1aE2AS/KK/yLrVhIUfM3t5fJJm9xwqL3n
 AoZ/Mq64RaEdDOM21DG82GWw67evMWo1XHGEZgy3igwh62RcCSTm7ni0+T7aNiF9+o
 S/jv1+SuHkqZ/TVWlj7ZeTrPnAhEWc2cNahAI8Rk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4288xtkB019942
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Mar 2024 02:59:55 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Mar 2024 02:59:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Mar 2024 02:59:55 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4288xsKS121883;
 Fri, 8 Mar 2024 02:59:55 -0600
Date: Fri, 8 Mar 2024 14:29:54 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
CC: <u-boot@lists.denx.de>, <jh80.chung@samsung.com>, <sjg@chromium.org>,
 <m.nirmaladevi@ltts.com>, <trini@konsulko.com>, <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 2/5] power: pmic: tps65941: Add TI TPS65224 PMIC
Message-ID: <20240308085954.bcefjtpk3eqr5wj5@dhruva>
References: <20240306133947.160354-1-bhargav.r@ltts.com>
 <20240306133947.160354-3-bhargav.r@ltts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240306133947.160354-3-bhargav.r@ltts.com>
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

On Mar 06, 2024 at 19:09:44 +0530, Bhargav Raviprakash wrote:
> Adds compatible and data field values of TPS65224 driver in
> TPS65941 PMIC driver.
> 
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> ---
>  drivers/power/pmic/tps65941.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/pmic/tps65941.c b/drivers/power/pmic/tps65941.c
> index 727b42747a..ef63eb733a 100644
> --- a/drivers/power/pmic/tps65941.c
> +++ b/drivers/power/pmic/tps65941.c
> @@ -75,6 +75,7 @@ static const struct udevice_id tps65941_ids[] = {
>  	{ .compatible = "ti,tps659412", .data = TPS659411 },
>  	{ .compatible = "ti,tps659413", .data = TPS659413 },
>  	{ .compatible = "ti,lp876441",  .data =  LP876441 },
> +	{ .compatible = "ti,tps65224",  .data =  TPS65224 },

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
