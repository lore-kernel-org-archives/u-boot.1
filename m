Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E58E810D0
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 11:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 033BD86D67;
	Wed, 27 Sep 2023 13:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J/TTigQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2D1C86D9C; Wed, 27 Sep 2023 13:53:01 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6468786B95
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 13:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RBqvjl032882;
 Wed, 27 Sep 2023 06:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695815577;
 bh=V8sz4cUwdEIKOpbxLrgi+vZiamwKP2WlD/t5oSCXoW4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=J/TTigQZto1qiGoQ/gXvkE35ZgSen6t+3m8VfXKJxw8SgHccC/zYc5jGitM6kSOkE
 f9WwWgYCX34H1cT+w1eliB+zqo2/V1prPVFycL4qyPp9qgxFQIOOtHB+ylE+3OSDpM
 dUwXAfuRj7ZyuE27BLSqLyPyzlV0OXv/8UqfpY/8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RBqvq3029977
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 06:52:57 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 06:52:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 06:52:57 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RBqvfd081214;
 Wed, 27 Sep 2023 06:52:57 -0500
Date: Wed, 27 Sep 2023 06:52:57 -0500
From: Nishanth Menon <nm@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/4] arm: dts: k3-am62-lp-sk-binman: Add binman support
Message-ID: <20230927115257.6qlopxkfrahchazq@levitator>
References: <20230927082105.3729470-1-n-yadav@ti.com>
 <20230927082105.3729470-4-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230927082105.3729470-4-n-yadav@ti.com>
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

On 13:51-20230927, Nitin Yadav wrote:
> Switch to binman for building bootloader images. Reuse
> k3-am625-sk-binman and override the dtb names to that
> of AM62 LP SK board.
> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>  arch/arm/dts/k3-am62-lp-sk-binman.dtsi | 29 ++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 arch/arm/dts/k3-am62-lp-sk-binman.dtsi
> 
> diff --git a/arch/arm/dts/k3-am62-lp-sk-binman.dtsi b/arch/arm/dts/k3-am62-lp-sk-binman.dtsi
> new file mode 100644
> index 0000000000..6841bea118
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62-lp-sk-binman.dtsi
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include "k3-am625-sk-binman.dtsi"
> +
> +#ifdef CONFIG_TARGET_AM625_A53_EVM
> +
> +#define SPL_AM62_LP_SK_DTB "spl/dts/k3-am62-lp-sk.dtb"
> +#define AM62_LP_SK_DTB "u-boot.dtb"
> +
> +&spl_am625_sk_dtb_unsigned {
> +	filename = SPL_AM62_LP_SK_DTB;
> +};
> +
> +&am625_sk_dtb_unsigned {
> +	filename = AM62_LP_SK_DTB;
> +};
> +
> +&spl_am625_sk_dtb {
> +	filename = SPL_AM62_LP_SK_DTB;
> +};
> +
> +&am625_sk_dtb {
> +	filename = AM62_LP_SK_DTB;
> +};
> +
> +#endif
> -- 
> 2.25.1
> 

Squash this to the u-boot.dtsi ?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
