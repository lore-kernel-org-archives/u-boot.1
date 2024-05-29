Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4C3C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 04:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1D4D88590;
	Wed, 29 May 2024 06:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZiQmXkUQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 509DF883B9; Wed, 29 May 2024 06:21:49 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F34588210
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 06:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T4LiVx088646;
 Tue, 28 May 2024 23:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716956504;
 bh=tMlBXwKvoKMD+6xdZAx1Lf+szs4TYbyuUgaZxS85mVc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZiQmXkUQcuXKv8ntfo21C6LYZsLIK43r4pv0kJhW03yBvXQrxzOsA7Iw8bWnFCbXo
 dt3W1/y0zuZT6KdzYWTd1WMHNpSHVnIk3hBLypEr2MmMzQaC7XqTA2hR0W1YNV+Oz5
 Z02qmGGM+O5TqtrmxYIlOdGmXgyaSO58EvvV43R4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T4LiFe108621
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 23:21:44 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 23:21:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 23:21:44 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T4LdGr048704;
 Tue, 28 May 2024 23:21:40 -0500
Message-ID: <c1821e3d-4f15-4ce9-8301-20a4b57185d9@ti.com>
Date: Wed, 29 May 2024 09:51:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drivers: misc: k3_avs: Use soc_match_device
 instead of compatible.
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>, Nishanth Menon <nm@ti.com>
References: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
 <20240528-b4-upstream-j721s2-avs-v2-2-df940f2309d0@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240528-b4-upstream-j721s2-avs-v2-2-df940f2309d0@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Manorit

On 5/28/2024 1:43 PM, Manorit Chawdhry wrote:
> vd_data remains the same for most of the SoCs but there are some
> differences in power domains and clocks that don't need a change to
> compatible and can be handled at SoC level.
>
> Change the data population logic from compatible to soc_match_device to
> add support for newer devices.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   drivers/misc/k3_avs.c | 189 +++++++++++++++++++++++++++-----------------------
>   1 file changed, 103 insertions(+), 86 deletions(-)
>
> diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
> index 87471cc3b16a..a0d7bb7595b3 100644
> --- a/drivers/misc/k3_avs.c
> +++ b/drivers/misc/k3_avs.c
> @@ -12,6 +12,7 @@
>   #include <asm/io.h>
>   #include <i2c.h>
>   #include <k3-avs.h>
> +#include <soc.h>
>   #include <dm/device_compat.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
> @@ -111,6 +112,95 @@ static u32 am6_efuse_xlate(struct k3_avs_privdata *priv, int idx, int opp)
>   	return 300000 + 20000 * val;
>   }
>   
> [..]
> +const struct soc_attr vtm_soc_list[] = {
> +	{ .family = "AM65X", .data = (void *)&am654_vd_config },
> +	{ .family = "J721E", .data = (void *)&j721e_vd_config },
> +	{ .family = "J7200", .data = (void *)&j721e_vd_config },
> +	{}
> +};

We may end up updating this driver for each SOC family,

Even if VTM IP remain same in two SOC family.

In my view, driver should be specific to IP not specific to SOC or SOC 
family.


> [..]
>
