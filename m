Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA5BC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 05:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEEA2884F3;
	Fri,  3 May 2024 07:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hJtz3YDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ECA08831B; Fri,  3 May 2024 07:30:36 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62C8588261
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 07:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4435UWQj046931;
 Fri, 3 May 2024 00:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714714232;
 bh=l+2ggDdyxIn+LeqdBh2+omqUdFlMTwx+Z1kAghHT3WI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=hJtz3YDUK674stJW/Wh6nHt2t0T73XAKHeqSsqgQntAuLVxIQrQfltpvRpuZO+Mw0
 C9QHQGGbfVonDWqZ8WZnNIvz4RUr1r5Nl5jeUe1X2bUPFYtBHQpdtcfrFNYxOdN16q
 PQ8LvQw3DXy2BSF5yMh9TXwhiNnHvVDDWqf5digs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4435UWFC130046
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 May 2024 00:30:32 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 00:30:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 00:30:32 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4435UVKU037294;
 Fri, 3 May 2024 00:30:32 -0500
Date: Fri, 3 May 2024 11:00:31 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Nitin Yadav
 <n-yadav@ti.com>
Subject: Re: [PATCH 2/2] configs: add defconfigs for the am625-lp-sk
Message-ID: <20240503053031.sqg2esmbgfvkunco@dhruva>
References: <20240429-am62q-wip-v1-0-927fd2e0a53b@ti.com>
 <20240429-am62q-wip-v1-2-927fd2e0a53b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240429-am62q-wip-v1-2-927fd2e0a53b@ti.com>
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

On Apr 30, 2024 at 14:57:46 -0500, Bryan Brattlof wrote:
> The am62x-lp-sk is a package and reference board spin of the am62x-sk to
> showcase the low-power features of the am62x SoC family. Because it so
> closely resembles the am62x-sk board, us the preprocessor to inherit its

s/us/use

> configuration making the needed changes for this board.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  configs/am62x_lp_sk_a53_defconfig | 3 +++
>  configs/am62x_lp_sk_r5_defconfig  | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/configs/am62x_lp_sk_a53_defconfig b/configs/am62x_lp_sk_a53_defconfig
> new file mode 100644
> index 0000000000000..904b2142b2f53
> --- /dev/null
> +++ b/configs/am62x_lp_sk_a53_defconfig
> @@ -0,0 +1,3 @@
> +#include <configs/am62x_evm_a53_defconfig>
> +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62-lp-sk"
> +CONFIG_OF_UPSTREAM=y
> diff --git a/configs/am62x_lp_sk_r5_defconfig b/configs/am62x_lp_sk_r5_defconfig
> new file mode 100644
> index 0000000000000..93b3922e6fec5
> --- /dev/null
> +++ b/configs/am62x_lp_sk_r5_defconfig
> @@ -0,0 +1,2 @@
> +#include <configs/am62x_evm_r5_defconfig>
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-lp-sk"

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
