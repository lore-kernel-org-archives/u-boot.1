Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A88CD98CF
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 08:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9A5846CF;
	Tue, 16 Jun 2026 10:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S/mMOVxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E8A8484C; Tue, 16 Jun 2026 10:44:46 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9574846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 10:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 482F4405CC;
 Tue, 16 Jun 2026 08:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8908B1F000E9;
 Tue, 16 Jun 2026 08:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781599483;
 bh=PJssEW7nYZ9EFVSZx5sObtWL/gRomcCkNDWpSS0DYOk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=S/mMOVxl5oLTw0f682Dw8xHQyUIq9wm2O/jPbVrTdi2rjR4puCFK7VN7LZF1x3IG0
 GCOyOLfbpg5qyGDo035C3kLhbC6hs6ag6WuWOVZXrndxQpY2PiYO97onw0LMlEMyrY
 OpuYfdSfOjjQeLjBVOOtyF21+ZMncJCypIH7sZR1X83mIZwSscklrDdq00EZ/pLQ2r
 FalN982ZA8RFf1DwHqPYRtRBfx7YmOXx25Yuz6EckCfO5bdGrFWNwBKOw87sVYGCWz
 U8k4eAsnqD6rgBDttqyJq/0RMYPmuCF3nfFBs4nvfxWqWTSUsT2l6LIAeRMoox2T2o
 Bm57P/aRqvuwg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ye Li <ye.li@nxp.com>, lukma@denx.de, mkorpershoek@kernel.org,
 festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com
Cc: uboot-imx@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH] usb: f_sdp: handle the spl load function failure
In-Reply-To: <20260522072705.1156220-1-ye.li@nxp.com>
References: <20260522072705.1156220-1-ye.li@nxp.com>
Date: Tue, 16 Jun 2026 10:44:40 +0200
Message-ID: <87o6haho1z.fsf@kernel.org>
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

On Fri, May 22, 2026 at 15:27, Ye Li <ye.li@nxp.com> wrote:

> Current implementation does not check the return value of spl load
> function. If the spl load is failed, SPL may meet crash due to
> spl_image variable is not initialized. Add the failure check,
> so SPL can print and stop with error.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>

We could add the following to the commit message:
Fixes: 2c72ead73874 ("usb: gadget: f_sdp: Allow SPL to load and boot FIT via SDP")

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/gadget/f_sdp.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
> index f72e27028b7..cd2c282247a 100644
> --- a/drivers/usb/gadget/f_sdp.c
> +++ b/drivers/usb/gadget/f_sdp.c
> @@ -75,6 +75,7 @@ struct hid_report {
>  #define SDP_HID_PACKET_SIZE_EP1 1024
>  
>  #define SDP_EXIT 1
> +#define SDP_FAIL 2
>  
>  struct sdp_command {
>  	u16 cmd;
> @@ -840,11 +841,14 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
>  #ifdef CONFIG_SPL_LOAD_FIT
>  			if (image_get_magic(header) == FDT_MAGIC) {
>  				struct spl_load_info load;
> +				int ret;
>  
>  				debug("Found FIT\n");
>  				spl_load_init(&load, sdp_load_read, header, 1);
> -				spl_load_simple_fit(spl_image, &load, 0,
> -						    header);
> +				ret = spl_load_simple_fit(spl_image, &load, 0,
> +							  header);
> +				if (ret)
> +					return SDP_FAIL;
>  
>  				return SDP_EXIT;
>  			}
> @@ -852,9 +856,13 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
>  			if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
>  			    valid_container_hdr((void *)header)) {
>  				struct spl_load_info load;
> +				int ret;
>  
>  				spl_load_init(&load, sdp_load_read, header, 1);
> -				spl_load_imx_container(spl_image, &load, 0);
> +				ret = spl_load_imx_container(spl_image, &load, 0);
> +				if (ret)
> +					return SDP_FAIL;
> +
>  				return SDP_EXIT;
>  			}
>  
> @@ -924,6 +932,8 @@ int spl_sdp_handle(struct udevice *udc, struct spl_image_info *spl_image,
>  
>  		if (flag == SDP_EXIT)
>  			return 0;
> +		else if (flag == SDP_FAIL)
> +			return -EIO;
>  
>  		schedule();
>  		dm_usb_gadget_handle_interrupts(udc);
> -- 
> 2.37.1
