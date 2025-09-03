Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856F0CA1007
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 00:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D452883390;
	Wed,  3 Sep 2025 02:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EAF833D0; Wed,  3 Sep 2025 02:00:21 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C255832AD
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 02:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B1D5CB22043C;
 Wed,  3 Sep 2025 02:00:15 +0200 (CEST)
Message-ID: <b6164731-08bc-4354-8d05-4a4f6e68c39c@freeshell.de>
Date: Tue, 2 Sep 2025 17:00:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 07/10] riscv: dts: jh7110: Add StarFive VisionFive 2 Lite
 u-boot device tree
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-8-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250829060931.79940-8-hal.feng@starfivetech.com>
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


On 8/28/25 23:09, Hal Feng wrote:
> Add the u-boot device tree include needed to support the
> StarFive VisionFive 2 Lite board.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi     | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi
> 
> diff --git a/arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi b/arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi
> new file mode 100644
> index 00000000000..46ef07a99eb
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2025 StarFive Technology Co., Ltd.
> + */
> +
> +#include "jh7110-common-u-boot.dtsi"
> +#include "starfive-visionfive2-binman.dtsi"

NAK. Not needed, with some expected changes to U-Boot. See comments
about "[RFC 02/10] riscv: dts: starfive: Add VisionFive 2 Lite board
device tree" [1]
1:
https://lore.kernel.org/u-boot/3b75e20f-261e-4a23-b2b6-d4f4596b5fb3@freeshell.de/

-E
