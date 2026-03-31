Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CE01061B3C
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 12:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB6DF84010;
	Tue, 31 Mar 2026 14:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Vq+kI7PX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6DBB84011; Tue, 31 Mar 2026 14:35:55 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B6C583A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 14:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4flSJm37vVz9tfD;
 Tue, 31 Mar 2026 14:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774960552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CzArRUFdIpWxH+Syarlo7+vQQM3QKStGOvBmkX/pKr4=;
 b=Vq+kI7PX7syfQU1DvVYKds9OhMItt+b9Z9YPWPBA7jLDeicXvz/LHTWL3ti8UhOgONADq7
 yICeJKziPaBFrQjMl0f8fMpSL78IA/g2naEdPlu7Rp3afJ08CiqJzd8HhgmtpVLbdE0SdU
 K4n5XMTwllYPXINMDVYruSbE4wVBxib6+5k3thGtITsz01jm58Emf8p05y8VrYw8pkVfcJ
 JAwnY7pYvVdEHtrHREjVMAzU+y54Ua96nyTV/1Vqy1zMGXlclNUhO5LuKxUG01HbX3PD0E
 YQeARp8X/WNwY8nZ08yBVumvZs03o6We7PnbFKqMgSshNqjbP7HRORRsQGJvbQ==
Message-ID: <bafefd79-db0c-45d0-90a9-f6404d7ca72c@mailbox.org>
Date: Tue, 31 Mar 2026 14:35:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 3/5] arm: dts: armada-8040-nbx: add U-Boot dtsi for
 conditional OP-TEE
To: Vincent Jardin <vjardin@free.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <cover.1773151972.git.vjardin@free.fr>
 <23919414aa41272279b0e835f92c71f823213cba.1773151972.git.vjardin@free.fr>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <23919414aa41272279b0e835f92c71f823213cba.1773151972.git.vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3ef617e2d806649b2d1
X-MBO-RS-META: j5dztkio4qsxur75za1u1wikr8xfawpi
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

On 3/10/26 15:12, Vincent Jardin wrote:
> Add armada-8040-nbx-u-boot.dtsi with the firmware/optee node guarded
> by CONFIG_OPTEE. This allows U-Boot to probe the OP-TEE driver only
> when OP-TEE support is enabled in the configuration.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   arch/arm/dts/armada-8040-nbx-u-boot.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>   create mode 100644 arch/arm/dts/armada-8040-nbx-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/armada-8040-nbx-u-boot.dtsi b/arch/arm/dts/armada-8040-nbx-u-boot.dtsi
> new file mode 100644
> index 00000000000..dec473b7156
> --- /dev/null
> +++ b/arch/arm/dts/armada-8040-nbx-u-boot.dtsi
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Free Mobile, Vincent Jardin
> + */
> +
> +#ifdef CONFIG_OPTEE
> +/ {
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +	};
> +};
> +#endif

