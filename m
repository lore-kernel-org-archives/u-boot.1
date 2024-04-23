Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E38DC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 13:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA578880D6;
	Tue, 23 Apr 2024 15:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="AioWadkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8581087F65; Tue, 23 Apr 2024 15:52:45 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B94880DE
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 15:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713880363; x=1716472363;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f3tQvssrdrPjNXGlGliLNw0Xm0gWI4XcQWxH6oIb4Ks=;
 b=AioWadkghrB0we8yd5v5Be90fNT/dB+De6IQ1rNC13ytDXp5IVXnxCBWfSQ5+mbS
 ygnwiAYZygPVbWLMWQMJM3Gl7NQPqwzlYJHq/tGQJiw45e0OqcqOVQLyA6J+Huvo
 ECDqccus1uz4pdYBAyS0PLvbCZvQU2N9F1RwPpFcXc8=;
X-AuditID: ac14000a-fadff7000000290d-8f-6627bd2b0dfb
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 18.A4.10509.B2DB7266;
 Tue, 23 Apr 2024 15:52:43 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 23 Apr
 2024 15:52:42 +0200
Message-ID: <74b32ce3-a710-4168-9c7f-32fb2170c0fc@phytec.de>
Date: Tue, 23 Apr 2024 15:52:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: am642: Fix reset for workaround errata ID
 i2331
To: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Jon Humphreys <j-humphreys@ti.com>, <u-boot@lists.denx.de>
References: <20240418175828.84548-1-afd@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240418175828.84548-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWyRpKBR1d7r3qawZ6zPBbvT01kt5jz7DSb
 xckbrewWb36cZbL4tmUbo8XUSZvZLd7u7WS3+H/2A7sDh8fshossHq8OrGL3OHtnB6PH8Rvb
 mQJYorhsUlJzMstSi/TtErgyOh4+Zyk4z1Wxc+8XtgbGBxxdjJwcEgImErf+drF0MXJxCAks
 YZLYeGY9K4Rzl1Hi7t+rzCBVvAI2ErOv9zKB2CwCqhLz1l1jhYgLSpyc+YQFxBYVkJe4f2sG
 O4gtLBAiMXHxOyaQQSICpxkl3q2/CTaIWcBO4vX66WANQgL6ErM+rGaBiItL3HoyH2wBm4C6
 xJ0N38AWcAoYSKzet5QNosZCYvGbg+wQtrzE9rdzmCHmyEu8uLScBeIdeYlp514zQ9ihEkc2
 rWaawCg8C8mts5Csm4Vk7CwkYxcwsqxiFMrNTM5OLcrM1ivIqCxJTdZLSd3ECIoiEQauHYx9
 czwOMTJxMB5ilOBgVhLh/fVHJU2INyWxsiq1KD++qDQntfgQozQHi5I47+qO4FQhgfTEktTs
 1NSC1CKYLBMHp1QDY7jb1BdXJi3X7zx/Y6re3JvJ5anW9alL0qwaL3JEzdg7x1L9T7dd6Buf
 QK7KI6XTH58Wj4+oviXZyfmvV9D99+8ArU0MyWs1Za7effz7pu3CiJ8Pzz2fpVdslTT5mt5s
 j1a76fNeSao/897r9XL+cjWdtKlJYpNfLjxkUec4Mbt2+/TPXpuKriqxFGckGmoxFxUnAgDU
 Gi3ykAIAAA==
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



Am 18.04.24 um 19:58 schrieb Andrew Davis:
> To workaround an issue in AM642 we reset the SoC in early boot. For that
> we first probed the sysreset driver by calling uclass_get_device(). The
> ti-sci sysreset driver is now probed during the ti-sci firmware probe.
> Update this call to probe the firmware driver which will then probe
> the sysreset driver allowing do_reset() to again function as expected.
> 
> Reported-by: Jonathan Humphreys <j-humphreys@ti.com>
> Fixes: fc5d40283483 ("firmware: ti_sci: Bind sysreset driver when enabled")
> Signed-off-by: Andrew Davis <afd@ti.com>

Tested-by: Wadim Egorov <w.egorov@phytec.de>

on phycore-am64x

> ---
>   arch/arm/mach-k3/am642_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-k3/am642_init.c b/arch/arm/mach-k3/am642_init.c
> index ddf47ef0a9b..80c3cb3479f 100644
> --- a/arch/arm/mach-k3/am642_init.c
> +++ b/arch/arm/mach-k3/am642_init.c
> @@ -226,7 +226,7 @@ void board_init_f(ulong dummy)
>   	 * The warm reset realigns internal clocks and prevents the lockup from
>   	 * happening.
>   	 */
> -	ret = uclass_first_device_err(UCLASS_SYSRESET, &dev);
> +	ret = uclass_get_device_by_driver(UCLASS_FIRMWARE, DM_DRIVER_GET(ti_sci), &dev);
>   	if (ret)
>   		printf("\n%s:uclass device error [%d]\n",__func__,ret);
>   
