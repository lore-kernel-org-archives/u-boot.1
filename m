Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61A9C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 15:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 373F28056A;
	Thu, 24 Apr 2025 17:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51547806FC; Thu, 24 Apr 2025 17:05:44 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 072598004F
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 17:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.25.173])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 872EBB4C1B7B;
 Thu, 24 Apr 2025 17:05:38 +0200 (CEST)
Message-ID: <009d493c-9549-4203-aab7-c03e0a552559@freeshell.de>
Date: Thu, 24 Apr 2025 08:05:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] riscv: dts: jh7110: add DeepComputing FML13V01
 device-tree
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@linaro.org>
References: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
 <20250424121315.144549-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250424121315.144549-3-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 4/24/25 05:13, Heinrich Schuchardt wrote:
> Add the u-boot device-tree include needed to support the
> DeepComputing Framework motherboard (FML13V01).
> 
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
> 	no change
> v3:
> 	no change
> v2:
> 	no change
> ---
>  arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> 
> diff --git a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> new file mode 100644
> index 00000000000..ab882d07f6f
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + */
> +
> +#include "jh7110-common-u-boot.dtsi"
> +#include "starfive-visionfive2-binman.dtsi"

Reviewed-by: E Shattow <e@freeshell.de>
