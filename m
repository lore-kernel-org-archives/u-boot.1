Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C995E77197
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 22:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2655805D5;
	Sun,  5 Jan 2025 23:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736115125;
	bh=ePd0Tclo06x/SWESDLN8ctgghW+l960R8ZYQb+aYryo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IVmuHGBXW85HAXjAGkj6+Me2XcXwwO9LrRqURGndP1VgiCMDC7FYQqFh/xNaSoXdJ
	 g4c43+8Swflg5GXpFkPkKEeVRDzYxz3YRqRtH53sKfbWc1lnuEG4XmOvSk31Fhg7Ys
	 C148BgBWXYbGagH/C/J/Er4d9u1W59G/IGYs7LUUyunH0QNLOQMVbv3unQsQrpJDDm
	 BIw+W8LPeHvOYAJM+k7GRa+jsqHHvRFaukV9sup6YYCihr6UsvCtzriqSL8pxwn1Hu
	 NX0GenjcXaXYOyvMV0O6sAIqjY+pFtGZxVXcM8n98dRRmxVlq7OzcNl4Sx9jLBgcyi
	 Dq7et8NLic6eQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66624805CB; Sun,  5 Jan 2025 23:12:05 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1E29801CE
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 23:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Z9u3Mn7K"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 34BEC109403D2; Sun,  5 Jan 2025 23:11:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736115121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePd0Tclo06x/SWESDLN8ctgghW+l960R8ZYQb+aYryo=;
 b=Z9u3Mn7K81IB5vedaukkBeDdMgYv6e39DAD9ZxYreRLCBigUrrZLMhCuwWHqvY0GLMLa47
 F390HncTcrnsv31+Sy53y771ojWxiTeZQaFLfXfFqS8ZWO8uPF4L0H+ThXxQxpwghymWuv
 rVpD6win3AsUkPzXg0m1qEqKc4xtUQ3rNgFedY7JmnwITy7qhLbFVRNip2H+T+bI3nzmlG
 /Ffg9kmrZ2DaiKGahQUSS50kxkD+MonGtCa9eeqizoio34XEVnf/ZQhtdLlnIU3nlEIcpu
 OkUPfiMz1f7QfoeqEJarhMfxlj9zMK8clKFt1fzIVkTrlpznRvjfVPHtF0zxaA==
Message-ID: <1bc61bdc-2ecd-4705-9873-8e0e3257a6a8@denx.de>
Date: Sun, 5 Jan 2025 21:59:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/17] firmware: scmi: smt: Interrupt communication
 enable
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-2-6744df5dc020@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250103-imx95-v1-2-6744df5dc020@oss.nxp.com>
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
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> When interrupt driven communication is supported

U-Boot does not use interrupts.

> , the transport allows
> the caller to choose between interrupt and polling driven
> communications. To make the choice, the channel flags are used. i.MX95
> uses interrupt driven communication so that Channel flags should be set
> to 1.

How does this work in U-Boot, which does not use interrupts ?

> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>   drivers/firmware/scmi/smt.c |  4 ++++
>   drivers/firmware/scmi/smt.h | 10 ++++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
> index 67d2f45002490ab64a6bc997eda93a8f4681d99b..e5b902dcb0e641065f4c0faae6bc6660a7e2c6af 100644
> --- a/drivers/firmware/scmi/smt.c
> +++ b/drivers/firmware/scmi/smt.c
> @@ -48,6 +48,10 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
>   	if (!smt->buf)
>   		return -ENOMEM;
>   
> +	/* Command should complete via an interrupt so that set Channel flags to 1. */
> +	if (IS_ENABLED(CONFIG_IMX95))
> +		scmi_smt_enable_intr(smt, true);
This SoC specific stuff shouldn't be in generic code.

Can this be moved elsewhere ?
