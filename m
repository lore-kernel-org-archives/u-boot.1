Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEBBC282D0
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 19:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F79810ED;
	Fri, 28 Feb 2025 20:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740770845;
	bh=kmwR8mKCdhoBd5Ea/hd+XUkXjZQr7xgv7DZvkPJP1Z8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OEjLZSnJWR5Yc3unywgZ0oM/wUeIZvkVLN36ArO74bYVu0SKKPgFvBTcu72droOtc
	 zwgQWzKvfwfLkHX6LL59IeR6C29ehPGhjXYqeL1OGK53bwc1bjlPYKJxgkUnRF7ava
	 AT1BlS+2StzciyTHkU9cd254NH9PmNJBi/ieu8cHVtbDr0s5kPgmLi67b+pXoMqKtf
	 KuSgdCKQmZu2xIjYyZf+5pNVAn7XmLUN/m0fiUhalaCnqvawsvDQud2dyssFVf61MA
	 rODenkBiNjnqu0yv5VCZJdvOGXZWN3qEFJtqVgaUw9aUymGB+VgPTmYQXchaoT9BoB
	 0ae8A0BRvFCCA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1CDE81120; Fri, 28 Feb 2025 20:27:24 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 982C8810ED
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 20:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="INb1ys2j"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 78FBB102FD52C; Fri, 28 Feb 2025 20:27:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740770841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmwR8mKCdhoBd5Ea/hd+XUkXjZQr7xgv7DZvkPJP1Z8=;
 b=INb1ys2jDdgo294ssebysUZZHPCi2sZqn7sprkXtd2msqvlI+JWFM76GKI3YDEdSXSDFq3
 zpZhPYSGb+dRYuR7EKJK2ve0bBve+dG+Mhy9Ni6lL3sbM+ccDf95IaSdK7pfYCbC6VJKjR
 G7mJIVw8RwS312Lk6BUMVDMSyPkegXtaVk/GFWWjnxJAdNPcq2CfqIKZYWH6XaTxQD+y6c
 CU+KrEvmeFLJuZ4QhZ0UJ5/qjMnsjiksDbhX98LEiPXmDPCb1gU0jY7jesDL+EKltgqbo3
 K2Th/Mu1SRHXNx40SFRmnVRoNy7tlfEMsWjIgUbXfiqCFKQIVniqv+x9x8hchg==
Message-ID: <9f02e9b3-a238-4a68-93f7-550bd63dceb2@denx.de>
Date: Fri, 28 Feb 2025 20:12:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/20] firmware: scmi: smt: Interrupt communication
 enable
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Viorel Suman <viorel.suman@nxp.com>,
 Ye Li <ye.li@nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-2-09594e93cc9b@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250228-imx95-v1-2-09594e93cc9b@oss.nxp.com>
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

On 2/28/25 11:53 AM, Alice Guo (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> i.MX95 System Manager uses interrupt driven communication which requires
> the caller to set Bit[0] of channel flags to 1. When transmission
> completes and the previous general purpose interrupt has been processed
> by the other core, i.MX95 System Manager will set General Purpose
> Interrupt Control Register (GCR). U-Boot polls General-purpose Status
> (GSR) to check if the operation is finished.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>   drivers/firmware/scmi/Kconfig |  6 ++++++
>   drivers/firmware/scmi/smt.c   | 13 +++++++++++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/firmware/scmi/Kconfig b/drivers/firmware/scmi/Kconfig
> index 8cf85f0d7a..eb62b88615 100644
> --- a/drivers/firmware/scmi/Kconfig
> +++ b/drivers/firmware/scmi/Kconfig
> @@ -41,3 +41,9 @@ config SCMI_AGENT_OPTEE
>   	help
>   	  Enable the SCMI communication channel based on OP-TEE transport
>   	  for compatible "linaro,scmi-optee".
> +
> +config SCMI_TRANSPORT_SMT_INTR
> +	bool
> +	depends on SCMI_FIRMWARE
> +	help
> +	  Enable interrupt communication of shared memory based transport.
> diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
> index 67d2f45002..a0489f9718 100644
> --- a/drivers/firmware/scmi/smt.c
> +++ b/drivers/firmware/scmi/smt.c
> @@ -20,6 +20,16 @@
>   
>   #include "smt.h"
>   
> +static void scmi_smt_enable_intr(struct scmi_smt *smt, bool enable)
> +{
> +	struct scmi_smt_header *hdr = (void *)smt->buf;
> +
> +	if (enable)
> +		hdr->flags |= SCMI_SHMEM_FLAG_INTR_ENABLED;
> +	else
> +		hdr->flags &= ~SCMI_SHMEM_FLAG_INTR_ENABLED;
> +}
> +
>   /**
>    * Get shared memory configuration defined by the referred DT phandle
>    * Return with a errno compliant value.
> @@ -48,6 +58,9 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
>   	if (!smt->buf)
>   		return -ENOMEM;
>   
> +	if (IS_ENABLED(CONFIG_SCMI_TRANSPORT_SMT_INTR))
> +		scmi_smt_enable_intr(smt, true);
Would it be possible to check DT /firmware/scmi node for compatible == 
"arm,scmi" and presence of "mboxes" property , and based on that , 
determine that this is mailbox based SCMI ?
