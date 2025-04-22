Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E14BC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7304F810F4;
	Tue, 22 Apr 2025 16:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b34En2WF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F79581273; Tue, 22 Apr 2025 16:18:06 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7432580F9C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MEHuuU1237923
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 09:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745331476;
 bh=yxIDKXAWDko9sjp+g0wGe2P/+Oh8zugjGuq2nAn6iSg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=b34En2WFFesFnGk9OaUH5Ldt+hmu6lRIFM/XzXz4JtrTFsieVcfX4a+Z1zldLQbHY
 /nMy/JHz1c5NKH77aIDFluug2GW7nJ2qxwub1+ZcWyoyR7NM8OTnPYcPR7TTr6Sven
 6mNRywSGMzC1MZA41Zny1adrAnJegX3ppcMTVIAI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MEHuYp089471
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 09:17:56 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 09:17:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 09:17:56 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MEHqvC004034;
 Tue, 22 Apr 2025 09:17:53 -0500
Message-ID: <ed3dd7cf-0a49-4178-9132-c389880e788b@ti.com>
Date: Tue, 22 Apr 2025 19:47:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] omap24xx_i2c: Enable Repeated Start functionality
To: Aniket Limaye <a-limaye@ti.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <hs@denx.de>, <marek.vasut+renesas@mailbox.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <virag.david003@gmail.com>, <w.egorov@phytec.de>, <j-keerthy@ti.com>,
 <u-kumar1@ti.com>
References: <20250422101957.1949448-1-a-limaye@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250422101957.1949448-1-a-limaye@ti.com>
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

Thanks for patch Aniket

On 4/22/2025 3:49 PM, Aniket Limaye wrote:
> This series implements Repeated Start functionality for the DM_I2C xfer
> API (omap_i2c_xfer())
>
> First, split out the actual implementation for each individual i2c msg
> transfer into a new function __omap24_i2c_xfer_msg() and use this to
> implement omap_i2c_xfer().
>
> Then, add support for the Repeated Start condition in omap_i2c_xfer()
> through the CONFIG_I2C_REPEATED_START option.

For series

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>
> Also add this config to Kconfig and enable it for ARCH_K3 platforms by
> default.
>
> Test logs (On J7200 EVM with DEBUG enabled):
> https://gist.github.com/aniket-l/9124c65a85a093a5bdc4517e0f813259
>
> ---
> v3:
> - Fixup [PATCH 2/4] to avoid unused function __omap24_i2c_xfer_msg()
>    compile time warnings... Move this behind DM_I2C ifdef
> - Link to v2: https://lore.kernel.org/all/20250310103702.1464782-1-a-limaye@ti.com/
>
> v2:
> - Add another patch to remove unused CONFIG_I2C_REPEATED_START
> - use new CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
> - Return right error codes and update debug prints to be driver specific
> - patch formatting updates
> - Link to v1: https://lore.kernel.org/u-boot/20250304220546.866602-1-a-limaye@ti.com/
>
>
> Aniket Limaye (4):
>    i2c: omap24xx_i2c: Remove unused CONFIG_I2C_REPEATED_START
>    i2c: omap24xx_i2c: Use new function __omap24_i2c_xfer_msg()
>    i2c: omap24xx_i2c: support CONFIG for repeated start in DM_I2C xfer
>    drivers: i2c: Kconfig: Add CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
>
>   drivers/i2c/Kconfig        |   9 ++
>   drivers/i2c/omap24xx_i2c.c | 165 ++++++++++++++++++++++++++++++-------
>   2 files changed, 144 insertions(+), 30 deletions(-)
>
