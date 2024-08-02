Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8ADC3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 21:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D1E88B80;
	Fri,  2 Aug 2024 23:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="r2OoQnxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 258DC88B8E; Fri,  2 Aug 2024 23:04:25 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE66288B22
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 23:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1722632654;
 bh=E4Z5s5LPq9gjOxO0ZSDD1L79O5MAjVjTk8yS/FMT0FQ=;
 b=r2OoQnxUnyicTMKjl1Ld2hQG3CYUxeX4caR/Z62V9gA6WN0+uJ93X2sEtmA3Tlp7vx+fE5FRd
 TWujOXISgVa/zThaQENbIGBizII5Xl2oB+1lrLyLBpxQoxCoemVigwmVbQUpbF+tU1WSHPAJ/YN
 fr4YPyPVEsd+XsbjwbIBZPl9h7swLeRmMPr055mj1r4gYvAoDfM/u4SNPmFt+q5jSjD/qcv5dWQ
 1RLr44GTWrPiXL+ONNRtRKVPrk3Ky7PDxCba9B6RpEqgXe4J6wHdcUNaq/AM3xso/MLjxBbIvXz
 ARHdKoc16Ctpw6c63rGiKdCla/wNHbuUpnP9o+3QdG2w==
Message-ID: <88da35e4-77d8-4360-8be2-5efa6ae0d5cf@kwiboo.se>
Date: Fri, 2 Aug 2024 23:04:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] board: rock5b-rk3588: enable USB-C in operating
 system
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, Eugen Hristev
 <eugen.hristev@collabora.com>, Tim Harvey <tharvey@gateworks.com>, Kever
 Yang <kever.yang@rock-chips.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Soeren Moch
 <smoch@web.de>, u-boot@lists.denx.de
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <20240802180027.139193-5-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240802180027.139193-5-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ad49cbb3fb002aec6e62fa
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

Hi Sebastian,

On 2024-08-02 19:59, Sebastian Reichel wrote:
> Since older U-Boot releases do not negotiate USB PD, the kernel
> DT may not enable the USB-C controller by default to avoid a
> regression. The plan is to upstream it with 'status = "fail";'
> instead. U-Boot should then mark it as 'status = "okay";' if
> it negotiated USB PD. Currently existing upstream kernel DTs do
> not yet have the USB-C controller at all, so we ignore any
> failures.

I do not really understand why you need to upstream it this way, there
are plenty of other rk3588 boards with fcs,fusb302 already having status
"okay" that possible are affected by same USB PD issue that ROCK 5B
have.

I guess you want to try and protect users that upgrade kernel DT and
ignore upgrading to a newer U-Boot, use vendor U-Boot or any other
bootloader from having possible issues with those USB PD power supplies
that have issues?

> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  board/radxa/rock5b-rk3588/rock5b-rk3588.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> index 1c17ae93c76c..4e926ebf2cb0 100644
> --- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> +++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> @@ -3,6 +3,8 @@
>   * Copyright (c) 2023-2024 Collabora Ltd.
>   */
>  
> +#include <fdtdec.h>
> +#include <fdt_support.h>
>  #include <usb/tcpm.h>
>  
>  #ifdef CONFIG_MISC_INIT_R
> @@ -33,3 +35,12 @@ int misc_init_r(void)
>  	return 0;
>  }
>  #endif
> +
> +#ifdef CONFIG_OF_BOARD_SETUP
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	if (IS_ENABLED(CONFIG_MISC_INIT_R))

It make very little sense to check for this, it is implied for almost
all Rockchip boards since it is used in rockchip board common code
to setup serial and Ethernet mac addresses env vars.

Regards,
Jonas

> +		fdt_status_okay_by_compatible(blob, "fcs,fusb302");
> +	return 0;
> +}
> +#endif

