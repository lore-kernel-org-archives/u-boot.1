Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE2CC5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 15:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D92F687FB3;
	Tue, 20 Feb 2024 16:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708443147;
	bh=ogVg9fehEZrkeuGc9x1JDR1zA+tkeGytlAsh88Pwe04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WIVd1zrAyGQsT1q0FJpaTRCYMLT0OyWC5pQy7trUtUCpZ3VIDcBf9WNZUWOti0M5v
	 WN9jD8UPVR0N7nVVueg8Gwq2uCLrOsWmR5RW2X3gsrA7MeipTurQlkBy9hqPCwC6vP
	 IkcJim300mZFHUx0VpGBCjkoWPZD/ZkyLKjUDgnxHywlQp1xD/RLJo41Bn4uUwPV1n
	 +XxYVtTLZgoCSl9Rzb9lWDFFb3f4oGtVPwcdcgTtKZ9zlx2kd2fWXFQikWSIYY3RII
	 XkYJJ1gRwHusRy6XMD1r2KfPSJWV2iP6pbJYvkVtcGxRWghHTcrg/nej7DhYvkCwTy
	 TppFnf4ncEWIQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9510887F7D;
 Tue, 20 Feb 2024 16:32:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708443146;
 bh=ogVg9fehEZrkeuGc9x1JDR1zA+tkeGytlAsh88Pwe04=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eT2hQAG2fUm1ao76h833k7yDgmqnaibgn9OlyADH2FMCwaLoOpcHX6Os4VsDnymEN
 0j5zEofjCGpni2NmElI3HWmXADHizefYcEz5vacYshnyN5Ms9oSggpapOCWCKt4p+g
 q3O9m3ogu5fTHvFjNA3rH5U7906TuBg0JusqewrmGJMTYZzNqM4U8y1qeoGeHx3Rmm
 rB3r9Jjfbl176sI0TwtQmrUcYdYV6VImOf595LY5yuHVLYYEjV/km7zaoxfln1xWDE
 4URhB0xZ+MpVIUaruqY/ITqCeNZbr56noeS1My2T+8V+JoDesfH29AbhCATsW08wvr
 tYdI47YEDY5sw==
Message-ID: <314b12f0-7b5d-44f4-bcf1-69a287a9005d@denx.de>
Date: Tue, 20 Feb 2024 16:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] reset: imx: Add support for i.MX8MP reset controller
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-3-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240220131056.2962331-3-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2/20/24 14:10, Sumit Garg wrote:
> Pre-requisite to enable PCIe support on iMX8MP SoC.

Please write a proper commit message .

> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   drivers/reset/reset-imx7.c | 114 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 114 insertions(+)
> 
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index eaef2cc2cdf..c1de84dea8b 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -10,6 +10,7 @@
>   #include <dm.h>
>   #include <dt-bindings/reset/imx7-reset.h>
>   #include <dt-bindings/reset/imx8mq-reset.h>
> +#include <dt-bindings/reset/imx8mp-reset.h>
>   #include <reset-uclass.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
> @@ -252,6 +253,115 @@ static int imx7_reset_assert_imx8mq(struct reset_ctl *rst)
>   	return 0;
>   }
>   
> +enum imx8mp_src_registers {
> +	SRC_SUPERMIX_RCR	= 0x0018,
> +	SRC_AUDIOMIX_RCR	= 0x001c,
> +	SRC_MLMIX_RCR		= 0x0028,
> +	SRC_GPU2D_RCR		= 0x0038,
> +	SRC_GPU3D_RCR		= 0x003c,
> +	SRC_VPU_G1_RCR		= 0x0048,
> +	SRC_VPU_G2_RCR		= 0x004c,
> +	SRC_VPUVC8KE_RCR	= 0x0050,
> +	SRC_NOC_RCR		= 0x0054,
> +};

This seems copied from Linux, include Linux commit ID as of which this 
was imported from in commit message.
