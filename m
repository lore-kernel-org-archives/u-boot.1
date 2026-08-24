Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F011C61DB4
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 09:48:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12E74405E6;
	Tue, 25 Aug 2026 09:48:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TtWmw5aCbn-c; Tue, 25 Aug 2026 09:48:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787651310;
	bh=1fCBdUXX75G/39thtil4tjduZ4D1179lig3PxFiuL24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IWIiuMXr8+uGiiQoUZu4HxHFNajqeVXachEvkHF6jLcxxsmEChnW7bfdFcoCHu8bR
	 ODX5LZRyWkBjSrcRvBDa9PA9DxfdcUYc32CbphmVqDAwHjSKFovTnbBjwZx8dxMb6z
	 lWJXQ/FGSsqlPfQxRUQqu9VQTY3hyyUxXoRS6b/bd3XompKmNPBdwxzbgV49XH9xXb
	 nZT3c6yUDHad4AmVinIz3SOld4Xq8CeqY/yGczDlAHVd4vIx8Lrt+UJBLpxaLzwv1E
	 FsZ53smWskfS6ryjev9uh617rXiN1quA9yEsAxZsIU/T0Nul8XtUnJz2MCE7s9yO5C
	 MkSFzX21QP8Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EF34405AD;
	Tue, 25 Aug 2026 09:48:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B45F9118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 09:48:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9AE9F80C72
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 09:48:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j8yAsd1AYF1L for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 09:48:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=oS8P5Uyh; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=jnze9xWw
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D271B80CA4
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 09:48:27 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hTjdj52qDzMl2r;
 Tue, 25 Aug 2026 11:48:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787651305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fCBdUXX75G/39thtil4tjduZ4D1179lig3PxFiuL24=;
 b=oS8P5Uyh665QMxzFTAvVF/G256YuSflszx7FUS70YWijgkz2rG8TpSl+DeTUa6f1k3EzFY
 7j0QuZ1iTtIGVyc1kdmmzTvpd+gQYmP1DTO8JXBgB4pywT321ZQNBBNIbmycjIln6++uCE
 0ibT823q8qq+Cyhlz3d7mXHnT/nlNZS3Er3ZZLQCeymUhAGUydlz0qCqDfQIYyxFkgzI9J
 dVhYlnQ3XRbiVata4ZyS+6kueDkVqHd9+F9czazcZzA+piJI7obJwgGYQD7psOSZrpfrA9
 s0m6qkJjBS29bQTlcx+2WStsj35jG8Zn0kUMY3Is9g5JhmZucWSqgssKhMM/aA==
Message-ID: <e8ad2e6c-1852-4ae3-bb4d-6b76b9a0aee2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787651303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fCBdUXX75G/39thtil4tjduZ4D1179lig3PxFiuL24=;
 b=jnze9xWw/DFLZ0CDUUuSf1mgJvktvtPwZJM7R8PVoyRj+9vN/RHwfuNXTMqlfpbL32C55s
 eXCFxHUkJcRyKQubxZG3MN0oaLgLJMGVEdRn46fWk8mvTaCG3RIzq+ZK+Z6tqadK01/rwi
 bF4ELYGQCX9lMegL9gDGQ25QNUT8IfOEp3WhOiQ0TSGugUch8zvXz/QY+bxURBqTydu2CB
 MSqeht2VQszUbKoNJ8x+5jPR/Lo2N0nGaMCBvb/oJlBa2E+Ox0570t0JXDHBVz7V+pYw4A
 apJfL6ISPtC6AuxZSvuAMj5WsPw+R9HOjVCRn9v4Grl9wkQCjPG3PTTFl8IrUw==
Date: Tue, 25 Aug 2026 01:40:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/6] usb: dwc3-generic: fix ref clock lookup indexing
 wrong clk_bulk array
To: Stefan Eichenberger <eichest@gmail.com>, francesco.dolcini@toradex.com,
 trini@konsulko.com, ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, marek.vasut+usb@mailbox.org,
 alice.guo@nxp.com, antoine.gouby@toradex.com,
 stefan.eichenberger@toradex.com, emanuele.ghidoli@toradex.com,
 franz.schnyder@toradex.com, balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev, sjg@chromium.org,
 ernest.vanhoecke@toradex.com
Cc: u-boot@lists.u-boot-project.org
References: <20260824183048.419198-1-eichest@gmail.com>
 <20260824183048.419198-3-eichest@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260824183048.419198-3-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 279876b89f165745562
X-MBO-RS-META: mihyrkkien7qfwufwxxgpjmbfimg5urk
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/24/26 8:29 PM, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> On Verdin iMX95, with a USB hub permanently attached to the DWC3 host
> port the hub itself enumerates fine but a USB stick plugged into it
> fails intermittently:
> 
>    Verdin iMX95 # usb start
>    starting USB...
>    USB XHCI 1.10
>    Device not responding to set address.
> 
>          USB device not accepting new address (error=80000000)
>    Bus usb@4c100000: 2 USB Device(s) found
>           scanning usb for storage devices... 0 Storage Device(s) found
>    Verdin iMX95 # usb reset
>    resetting USB...
>    USB XHCI 1.10
>    WARN endpoint is halted
>    WARN endpoint is halted
>    unable to get device descriptor (error=-22)
> 
> Commit c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in
> both controller DT nodes") added a fallback that searches the DWC3
> child node's "clock-names" for "ref"/"ref_clk" when it isn't found on
> the parent glue node, but always resolves the found index against
> glue->clks, a clk_bulk populated only from the parent glue node's own
> clock-names list. This is wrong since the child node's clock-names list
> is not guaranteed to be in the same order as the parent's, and indeed on
> Verdin iMX95 the child node has a different order than the parent node.
> 
> Fix it by resolving the index against the child node's clk and ensure to
> enable the clock before using it.
> 
> Fixes: c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in both controller DT nodes")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 2356b3bc0aa..e16d236bd9d 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -31,6 +31,7 @@ struct dwc3_generic_priv {
>   	struct dwc3 dwc3;
>   	struct phy_bulk phys;
>   	struct gpio_desc *ulpi_reset;
> +	struct clk ref_clk;
>   };
>   
>   struct dwc3_generic_host_priv {
> @@ -76,9 +77,28 @@ static int dwc3_generic_probe(struct udevice *dev,
>   		index = ofnode_stringlist_search(node, "clock-names", "ref");
>   		if (index < 0)
>   			index = ofnode_stringlist_search(node, "clock-names", "ref_clk");
> -	}
> -	if (index >= 0)
> +		/*
> +		 * glue->clks was populated from the parent glue node's own
> +		 * clock-names list, which can differ in length/order from
> +		 * this child node's list (e.g. i.MX95: glue has "hsio",
> +		 * "suspend", the dwc3 child has "bus_early", "ref",
> +		 * "suspend"). Reusing this index against glue->clks would
> +		 * silently resolve to the wrong clock, so fetch it directly
> +		 * from this node instead.
> +		 */
> +		if (index >= 0) {
> +			if (!clk_get_by_index(dev, index, &priv->ref_clk)) {

Would it be possible to call clk_get_by_name(dev, ...) and 
clk_get_by_name(dev->parent, ...) instead, until one of them succeeds ? 
That could make the code simpler.

> +				clk_enable(&priv->ref_clk);
> +				dwc3->ref_clk = &priv->ref_clk;
> +			} else {
> +				debug("%s: failed to get ref_clk from DT\n", dev->name);

dev_dbg()

> +			}
> +		} else {
> +			debug("%s: no ref_clk found in DT\n", dev->name);

dev_dbg()

> +		}
> +	} else {
>   		dwc3->ref_clk = &glue->clks.clks[index];
> +	}
>   #endif
>   
>   	/*

