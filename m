Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A196CC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 08:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24FDD80FE1;
	Fri, 28 Feb 2025 09:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="P+uOgrx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BA68810EA; Fri, 28 Feb 2025 09:16:52 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 090B4807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 09:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9373B14848A0; Fri, 28 Feb 2025 09:16:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1740730608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P5OUZLxj1T6qqetjJmriz4DlTkRa5Sn462sy0prJ3u8=;
 b=P+uOgrx6hVv0ln4o83clADD0ZcxtrehlbYa+u1EqV8YDZaeRAFzAEHDLDZLb8cM4VTV5Bt
 J8awGOymZKoCLqNLEfmg6l4QYrw/W+lraRPv+VETfoWsBRTnC2p+WJa7QXWc9L1ZoQFnKS
 s4qOS816jhjQ3Hh7GE8HtJASMeqoON7uRs4FwYtBanAsBO4/ZpOBZfCRtUok+1S1S4VBjL
 U/NTgt6uOmarknVqQIDtoGeu1E5Lo6+dbNxpAyWk8SSbi1YXN/COK4ThAJg1oK1mt1oYnX
 jq6bHJBA9XqzZee6EieolWB5uPQIpbDW+Yxi+Fqd+ctz9mh706yvIl61j4V0ww==
Date: Fri, 28 Feb 2025 09:16:38 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, seanga2@gmail.com,
 sumit.garg@linaro.org, kever.yang@rock-chips.com,
 marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, festevam@denx.de,
 Oliver.Gaskell@analog.com, aford173@gmail.com,
 prasad.kummari@amd.com, caleb.connolly@linaro.org,
 andre.przywara@arm.com, neil.armstrong@linaro.org,
 mibodhi@gmail.com, nicolas.ferre@microchip.com,
 mihai.sain@microchip.com, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
Message-ID: <20250228-tigress-curfew-db928c18c24e@thorsis.com>
Mail-Followup-To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, seanga2@gmail.com,
 sumit.garg@linaro.org, kever.yang@rock-chips.com,
 marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, festevam@denx.de,
 Oliver.Gaskell@analog.com, aford173@gmail.com,
 prasad.kummari@amd.com, caleb.connolly@linaro.org,
 andre.przywara@arm.com, neil.armstrong@linaro.org,
 mibodhi@gmail.com, nicolas.ferre@microchip.com,
 mihai.sain@microchip.com, sjg@chromium.org, u-boot@lists.denx.de
References: <20250227093559.797618-1-manikandan.m@microchip.com>
 <20250227093559.797618-2-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227093559.797618-2-manikandan.m@microchip.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hei hei,

Am Thu, Feb 27, 2025 at 03:05:52PM +0530 schrieb Manikandan Muralidharan:
> Add PMC clock definitions for MCK and UTMI which will be required
> for the sam9x7 OF_upstream DT since the clock framework is not in
> sync with Linux and also include this header in 'clock/at91.h' file
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  include/dt-bindings/clk/at91.h   | 3 +++
>  include/dt-bindings/clock/at91.h | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/include/dt-bindings/clk/at91.h b/include/dt-bindings/clk/at91.h
> index a178b94157b..016c6e0c620 100644
> --- a/include/dt-bindings/clk/at91.h
> +++ b/include/dt-bindings/clk/at91.h
> @@ -24,4 +24,7 @@
>  #define USB_UTMI2		1
>  #define USB_UTMI3		2
>  
> +#define PMC_MCK			1
> +#define PMC_UTMI		2

These are in include/dt-bindings/clock/at91.h in Linux.

> +
>  #endif
> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> index ab3ee241d10..7235b3ba01e 100644
> --- a/include/dt-bindings/clock/at91.h
> +++ b/include/dt-bindings/clock/at91.h
> @@ -6,6 +6,8 @@
>   * Licensed under GPLv2 or later.
>   */
>  
> +#include <dt-bindings/clk/at91.h>

If the u-boot driver or some *-u-boot.dtsi needs that additional
header, I would include it there.

Besides this, you might be interested those bindings are in a process
of rework in Linux currently.  Especially the PMC clock IDs you ported
from Linux are about to be split out into SoC specific headers.
Discussion over here:

https://lore.kernel.org/linux-clk/20250210164506.495747-2-ada@thorsis.com/

Greets
Alex


> +
>  #ifndef _DT_BINDINGS_CLK_AT91_H
>  #define _DT_BINDINGS_CLK_AT91_H
>  
> -- 
> 2.25.1
> 
