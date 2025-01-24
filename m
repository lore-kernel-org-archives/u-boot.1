Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B777C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DDF780B9E;
	Fri, 24 Jan 2025 16:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732373;
	bh=J/fC9AsdjYX16AUC7UHdLbd4KuMDuYnH3gAYT/jGjDU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FLnWj+5cuHdl/POwFYtxsqh6pvAFGVMMdNqu5UEMTZH8iq9oZN1cLOOprXga5B/uQ
	 l1yr+9Bfr5/63HOZOIUo6wwu+napzYzNUR72aah7LL/o9dNAms2ewPttPM4UBkqU+D
	 FT6SHaHTAfPhiExzqnO2F1liNAxgy5bprsJKY8pyKlkWXH6PgQHw0BZCIJqSQiO5pJ
	 4GGgByLP5dRfbMHo3JwijeJ4yPJPWbQbiTQWpXauG5xlxIIgwNMJfsImDfGlhpH7dd
	 N1BVgIdGXBd9F9NQSkZsVEWlESJkSf1D2LSAiQ9gkGI6Svgl+cGCjC2po1PN0CN801
	 ioVnw+acNvgMg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D868F80C5A; Fri, 24 Jan 2025 16:26:11 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D59DC809D2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Lk+mbJOz"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 64C61108860C0; Fri, 24 Jan 2025 16:26:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/fC9AsdjYX16AUC7UHdLbd4KuMDuYnH3gAYT/jGjDU=;
 b=Lk+mbJOzCN4oJ8HxaRFfc482xDcD8Fu7+TGJBPFZIxpccf8yRBKzFsTuGQGXhBWUJvjwar
 hPhrIfrg9bCoNG1Snz+2pQl/wtMOOSbE/0NU4f1aMo4E8Im5EyznBiwak/h1Mx88pLKrCh
 DqFC3GFFPN3UfrrgCh8ZF0t+6K0l2Zrv8a0D3PWn4B/iNcMg8m6CSJhjVvv59ytfhQ5iYL
 sTCZW1isIHGTRF2m41JtZqq2X7RXkZC+jHVUIGaMqBJy/dLcngWY2+e5PXkXhrk3202MHf
 CELnlS8tPuk0lAnfLzXbuYnNHHx3+g/4LhlLYN7N3UusWTHOULqgHro4Llq5gA==
Message-ID: <1e4a5b64-be51-4504-bb1b-897149dceda9@denx.de>
Date: Fri, 24 Jan 2025 12:06:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/20] firmware: scmi: smt: Interrupt communication
 enable
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo
 <alice.guo@nxp.com>, Viorel Suman <viorel.suman@nxp.com>,
 Ye Li <ye.li@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-2-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-2-93b28a514dea@oss.nxp.com>
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

On 1/15/25 2:28 PM, Alice Guo wrote:
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
>   drivers/firmware/scmi/smt.c   |  3 +++
>   drivers/firmware/scmi/smt.h   | 10 ++++++++++
>   3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/firmware/scmi/Kconfig b/drivers/firmware/scmi/Kconfig
> index 8cf85f0d7a12c9e58dc249539727081ec25dd7b3..eb62b88615b5cd95635571556e79ba40d1a387e9 100644
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
> index 67d2f45002490ab64a6bc997eda93a8f4681d99b..ee7ae5d50b226b92a3961c181de83c730a621401 100644
> --- a/drivers/firmware/scmi/smt.c
> +++ b/drivers/firmware/scmi/smt.c
> @@ -48,6 +48,9 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
>   	if (!smt->buf)
>   		return -ENOMEM;
>   
> +	if (IS_ENABLED(CONFIG_SCMI_TRANSPORT_SMT_INTR))
> +		scmi_smt_enable_intr(smt, true);
> +
>   #ifdef CONFIG_ARM
>   	if (dcache_status())
>   		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, MMU_SECTION_SIZE),
> diff --git a/drivers/firmware/scmi/smt.h b/drivers/firmware/scmi/smt.h
> index 9d669a6c922666c48e7dce4c0affd7b47cb137e4..768b0f4c8a8d1cc7966530e724d278d72c2a167b 100644
> --- a/drivers/firmware/scmi/smt.h
> +++ b/drivers/firmware/scmi/smt.h
> @@ -84,6 +84,16 @@ static inline void scmi_smt_put_channel(struct scmi_smt *smt)
>   	hdr->channel_status &= ~SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR;
>   }
>   
> +static inline void scmi_smt_enable_intr(struct scmi_smt *smt, bool enable)

Is this expected to be called from somewhere else except 
drivers/firmware/scmi/smt.c ? If not, please move it into 
drivers/firmware/scmi/smt.c .

Drop the 'inline' , compiler can figure that out.

> +{
> +	struct scmi_smt_header *hdr = (void *)smt->buf;

The cast should be (struct scmi_smt_header *) instead of (void *)

> +	if (enable)
> +		hdr->flags |= SCMI_SHMEM_FLAG_INTR_ENABLED;
> +	else
> +		hdr->flags &= ~SCMI_SHMEM_FLAG_INTR_ENABLED;
> +}
> +
>   int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt);
