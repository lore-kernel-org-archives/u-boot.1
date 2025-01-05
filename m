Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B50E77198
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 22:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8879801E8;
	Sun,  5 Jan 2025 23:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736115154;
	bh=UmH3zKrnJiBBvSN7DJ6tmSeO9LWxSKhJCrJ7CGVis2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sd+0O5/KperJv2LG9RtUzgORCEV9B2jqyN48780ZbWT57X5VRxqjU9+GgC0oNamkr
	 YFCVkS0VlgR0DWe7Jj5Fp7bdtIEuTGIicOm9mYcTgIZYR7/FxwAZf7IXN3JYBb6AQz
	 WhT5YtKSl7nerzkn6nenvLP6LwdsqjKR98TFNIOOVVtNDPJ9I1BVZvPAOlcdc9zqMH
	 8Py3P5kLH0QEdK7NYcCOYPTpp+ojAHStv7E7rFhfbAbjrHVV44dfDRYuF3ofEKOWoC
	 YDIpZpX34/Bu6hM8X6c6096iGookscafdT+fXiT9ZVHaj0ES5faxSgEhmDKswoSvXb
	 6gohTP3qNaHHA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D28C801E8; Sun,  5 Jan 2025 23:12:32 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F78C80613
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 23:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SO+ZrdTZ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2FA3B101D23BB; Sun,  5 Jan 2025 23:12:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736115146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmH3zKrnJiBBvSN7DJ6tmSeO9LWxSKhJCrJ7CGVis2U=;
 b=SO+ZrdTZtpskNW7g/4x3hZsTK13wTzmArAOrO+xPf1T0OnTgSyDkrXSKOsFYAMnuuLE+Zh
 JeAte1D6+08hwwx8TUMwg/45GxQDpL4zLAwMUcjknthYcrrgKDrqtbFUCw9qFnEV6n+e3G
 fMQpQUrHMw/Wd1BbUmd3HUYOD1Nwj8tc4VcKSgCEe7QzqGCpI8WunUP4XuzSEfCWixYFor
 KTTtqCkA1yNANp7RwjwM1v+UCq1etHz2V4VnfNb0+j2BgqfDD5GFlaXaSkv/FWVw0NwucC
 WqzjUbeF9kv2YaYHnwsM+Ngi3dUT30j/1mJCd1tOXno2SEA7yfJo7EWOUN+fMw==
Message-ID: <e7f2e938-e6a1-4927-91d7-682ca9d683f9@denx.de>
Date: Sun, 5 Jan 2025 22:56:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/17] imx9: scmi: soc: Override h_spl_load_read with
 trampoline buffer
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-11-6744df5dc020@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250103-imx95-v1-11-6744df5dc020@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/3/25 7:45 AM, Alice Guo wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> When SPL loading image to secure region, for example, ATF and tee to
> DDR secure region. Because the USDHC controller is non-secure master,
> it can't access this region and will cause loading issue.
> 
> So override h_spl_load_read to use a trampoline buffer in nonsecure
> region, then use CPU to copy the image from trampoline buffer to
> destination secure region.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>   arch/arm/mach-imx/imx9/scmi/soc.c | 40 +++++++++++++++++++++++++++++++++++++++
>   common/spl/spl_mmc.c              |  2 +-
>   2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
> index fefb1a6f4ca58722a5d93c39e4f6a7aaf85aa177..8a7df24afecc1d6d77b7162be639b56af95fd975 100644
> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> @@ -41,6 +41,8 @@
>   #include <scmi_agent.h>
>   #include <scmi_protocols.h>
>   #endif
> +#include <spl.h>
> +#include <mmc.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -830,3 +832,41 @@ enum boot_device get_boot_device(void)
>   	return boot_dev;
>   }
>   #endif
> +
> +ulong h_spl_load_read(struct spl_load_info *load, ulong off,
> +		      ulong size, void *buf)

Can you simply define spl_get_load_buffer() instead to make sure SPL 
loads your stuff into the correct location ?

This hack in generic code is a NAK.
