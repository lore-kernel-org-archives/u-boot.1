Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0249AC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7394E871C7;
	Tue,  2 Jul 2024 15:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="KDVg/NY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18871880AE; Tue,  2 Jul 2024 15:12:17 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2770E87073
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719925934; x=1722517934;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sEmhmw3LP7CxpE8eDbApypl3LcDzW04VRqs4wklL05o=;
 b=KDVg/NY3LF7zFVOUH+OAFdZYWmAr6wMDAjGJQ4r1zUnMWTEgS9wEGWY5PtxCV7dj
 Wl8XSDwKvcP27pNvd6f6I71IT3TQDprBbPQhZZaScQF+0JjRnci0kStjfhbRUF9r
 JEEynFosAS5nPvglLsxzURwEks6uFGa2Uw43gkhexxA=;
X-AuditID: ac14000a-03e52700000021bc-e4-6683fcae1181
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 00.3A.08636.EACF3866;
 Tue,  2 Jul 2024 15:12:14 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 2 Jul 2024
 15:12:13 +0200
Message-ID: <3e800028-7b87-4ba0-a08e-ede176523598@phytec.de>
Date: Tue, 2 Jul 2024 15:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: phytec: k3: k3_ddrss_patch: Add ddr phy reg count
To: Dominik Haller <d.haller@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <jma@phytec.com>
References: <20240702092240.34349-1-d.haller@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240702092240.34349-1-d.haller@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWyRpKBR3fdn+Y0g6dLNCyedTYxW0ydtJnd
 4u3eTnaL7nfqDiwerw6sYvc4e2cHo0d/dwurx5+L71gDWKK4bFJSczLLUov07RK4Mh7++cJc
 cJ2r4nPbW7YGxvscXYycHBICJhKTn6xlArGFBJYwSfybWdTFyAVk32GUuN3YyAiS4BWwkTjU
 9hesiEVAReLlvdtQcUGJkzOfsIDYogLyEvdvzWAHsYUFfCVeTPjJBmKLCMRKbOw7AlbPLKAl
 0fLwFgvEMnOJEw272CDi4hK3nswHm88moC5xZ8M3VhCbU8BC4siTPlaIGguJxW8OskPY8hLb
 385hhpgjL/Hi0nIWiGfkJaade80MYYdKbP2ynWkCo/AsJKfOQrJuFpKxs5CMXcDIsopRKDcz
 OTu1KDNbryCjsiQ1WS8ldRMjKC5EGLh2MPbN8TjEyMTBeIhRgoNZSYRX6n1zmhBvSmJlVWpR
 fnxRaU5q8SFGaQ4WJXHe1R3BqUIC6YklqdmpqQWpRTBZJg5OqQZGtudS2w2CCi1P1O03jDLr
 rWycs9XPf+Gb7nD1Auljr7ZMaZO2lciZKuT8V/jxpYPvH+X0bHZ4J77R59uX3Pqt4gJHsqSi
 ph8s7dy6bnflzT2qvwwTbCVXWFQo1Ozpuz1zZayabh/7uU7HDf7qFuovOF99X9W89VXR1nb+
 5zdcoiabn5pjet9CiaU4I9FQi7moOBEAEJU5G3kCAAA=
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



Am 02.07.24 um 11:22 schrieb Dominik Haller:
> Add and use the correct number of ddr phy registers to update the
> corresponding settings.
> 
> Fixes: cbf5c99ef317 ("board: phytec: common: Introduce a method to inject DDR timings deltas")
> Signed-off-by: Dominik Haller <d.haller@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   board/phytec/common/k3/k3_ddrss_patch.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/board/phytec/common/k3/k3_ddrss_patch.c b/board/phytec/common/k3/k3_ddrss_patch.c
> index 39f7be8dc922..5afe5a20c7f3 100644
> --- a/board/phytec/common/k3/k3_ddrss_patch.c
> +++ b/board/phytec/common/k3/k3_ddrss_patch.c
> @@ -12,6 +12,7 @@
>   #ifdef CONFIG_K3_AM64_DDRSS
>   #define LPDDR4_INTR_CTL_REG_COUNT (423U)
>   #define LPDDR4_INTR_PHY_INDEP_REG_COUNT (345U)
> +#define LPDDR4_INTR_PHY_REG_COUNT (1406U)
>   #endif
>   
>   static int fdt_setprop_inplace_idx_u32(void *fdt, int nodeoffset,
> @@ -54,7 +55,7 @@ int fdt_apply_ddrss_timings_patch(void *fdt, struct ddrss *ddrss)
>   					return ret;
>   			}
>   
> -	for (i = 0; i < LPDDR4_INTR_PHY_INDEP_REG_COUNT; i++)
> +	for (i = 0; i < LPDDR4_INTR_PHY_REG_COUNT; i++)
>   		for (j = 0; j < ddrss->phy_regs_num; j++)
>   			if (i == ddrss->phy_regs[j].off) {
>   				ret = fdt_setprop_inplace_idx_u32(fdt,
