Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A6FCD98CF
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 09:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CBB0846CF;
	Tue, 16 Jun 2026 11:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="go2vajt7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66FAE84704; Tue, 16 Jun 2026 11:30:27 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6873C846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 11:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C65C60132;
 Tue, 16 Jun 2026 09:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469D91F000E9;
 Tue, 16 Jun 2026 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781602223;
 bh=lHWRcYRNgUq5HFsf/E8ytKHQrsfrfq75+ZNjnnXiO+g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=go2vajt7UWicqLTjRh4CgaBVrz9tNZ73YZHpH9ovVu11y0X5vnEIgwmgEmwImkDfD
 Bq2fI6lxV8XHUzvPhcqi2pgMX6ixUugQO6uLpg7VxGs/oqGNPrQTX1WB9mGyK4AlLD
 7PbOP/gzbsmjxj3bQ7LqI+I67ayoSJ3uzTP5O6oFk4YIpx3Q0yEgSb15Sb02PinzGu
 dLjMdPvJhtrSnKDWMfJUh/rDKZlHc4Mt6Pstnw+B10TENl6S8RfxEgvPDjbAPnXvdi
 0KTxikOLA0w/5fdGRxwpuzPHWJqgM/gIL9es11eR2BBEFnAlnSA4DWPW3WokE/Cd0W
 zkpuwVJYnKUTg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ye Li <ye.li@nxp.com>, lukma@denx.de, mkorpershoek@kernel.org,
 u-boot@lists.denx.de
Cc: festevam@gmail.com, peng.fan@nxp.com, uboot-imx@nxp.com,
 ye.li@oss.nxp.com, xu.yang_2@nxp.com, jason.he_1@nxp.com
Subject: Re: [PATCH 3/3] usb: ci_udc: verify all dtds are inactive before
 completing request
In-Reply-To: <20260522075512.1291485-3-ye.li@nxp.com>
References: <20260522075512.1291485-1-ye.li@nxp.com>
 <20260522075512.1291485-3-ye.li@nxp.com>
Date: Tue, 16 Jun 2026 11:30:21 +0200
Message-ID: <87fr2mhlxu.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Ye,

Thank you for the patch.

On Fri, May 22, 2026 at 15:55, Ye Li <ye.li@nxp.com> wrote:

> From: Jason He <jason.he_1@nxp.com>
>
> According to device mode spec, the ACTIVE status field of dtds should
> be check to determine whether the transfers completed successfully.
> However, this is not implemented in handle_ep_complete.
> When two EPs are enabled and transferring, EPa requests with multiple dtds
> and EPb request with one dtd. Irq is triggred on EPb. The udc_irq handler
> finds both EPb's and EPa's ENDPTCOMPLETE=1 while not all of EPa's dtds
> have been completed. Because ACTIVE status is not checked, this case
> causes crash in ci_udc driver.
>
> Signed-off-by: Jason He <jason.he_1@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> ---
>  drivers/usb/gadget/ci_udc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
> index 0baad83ef90..53796887dac 100644
> --- a/drivers/usb/gadget/ci_udc.c
> +++ b/drivers/usb/gadget/ci_udc.c
> @@ -733,6 +733,17 @@ static void handle_ep_complete(struct ci_ep *ci_ep)
>  	ci_invalidate_qtd(num);
>  	ci_req = list_first_entry(&ci_ep->queue, struct ci_req, queue);
>  
> +	/* Check all dtd are completed, otherwise return for next irq process */
> +	next_td = item;
> +	for (j = 0; j < ci_req->dtd_count; j++) {
> +		ci_invalidate_td(next_td);
> +		if (next_td->info & INFO_ACTIVE)
> +			return;
> +		if (j != ci_req->dtd_count - 1)
> +			next_td = (struct ept_queue_item *)(unsigned long)
> +				next_td->next;
> +	}

A very similar loop (that walks all the dtds) is just below:

> +
>  	next_td = item;
>  	len = 0;
>  	for (j = 0; j < ci_req->dtd_count; j++) {

Can't we merge both loops together?

> -- 
> 2.37.1
