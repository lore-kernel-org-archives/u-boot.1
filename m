Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B03CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 08:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6508F8366F;
	Fri,  3 Oct 2025 10:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HvGrYUZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9746783693; Fri,  3 Oct 2025 10:25:08 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BABD8349B
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 10:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2078A60055;
 Fri,  3 Oct 2025 08:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19703C4CEF5;
 Fri,  3 Oct 2025 08:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759479904;
 bh=pJs+dxp0eWAF1V+vamThuoIK3tOUWcMW+dv3vNLK9VY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=HvGrYUZpUxt46rXWxVjpDHJlvLojTybxJhHhrePy14jNHihP3DTNdzsp6aGS1O6Kf
 P9d8/knR+CwkZNWqM4E5cI5kzQ/XkR6Q/qZLnd1GzpPB71bPKd1D2pIEOd7T7YYF8X
 NNQBhAWFfYN7ccl/lI6PngGo/NKyWH27bUj1+dfmzB0MPlrzOyeceri3Ao43PyeN7d
 Tppru2wDWrvSp8w8E+piDEdfC7uxQBGv7+srxFRWAOBB/5CXQo/M/ndAm22brqvvcR
 cwkA3ejQtznXyCg+CQbnjda62KFNXXX42KHBnb/OOYjkzo/aisNPQ9TDkgPBeMyAW6
 ZEa1WRTFYRBxg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Kory Maincent <kory.maincent@bootlin.com>, Andrew
 Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH 2/3] usb: musb-new: Limit check array index before use
In-Reply-To: <20250930-usb_musb-new-v1-2-be0c9b79a8a0@linaro.org>
References: <20250930-usb_musb-new-v1-0-be0c9b79a8a0@linaro.org>
 <20250930-usb_musb-new-v1-2-be0c9b79a8a0@linaro.org>
Date: Fri, 03 Oct 2025 10:25:01 +0200
Message-ID: <87tt0gqtnm.fsf@kernel.org>
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

Hi Andrew,

Thank you for the patch.

On Tue, Sep 30, 2025 at 16:52, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:

> epnum is used as an index into an array. The limit check for this index
> should be performed before using it to access an element in the array to
> prevent possible bounds overrun.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/musb-new/musb_gadget_ep0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/musb-new/musb_gadget_ep0.c b/drivers/usb/musb-new/musb_gadget_ep0.c
> index ea65326ab6264492ea668ddd047b360965a5ad19..25b1de6e58f9e2028e9b93a600d532ae0f5efcc1 100644
> --- a/drivers/usb/musb-new/musb_gadget_ep0.c
> +++ b/drivers/usb/musb-new/musb_gadget_ep0.c
> @@ -96,6 +96,9 @@ static int service_tx_status_request(
>  		if (!epnum) {
>  			result[0] = 0;
>  			break;
> +		} else if (epnum >= MUSB_C_NUM_EPS) {
> +			handled = -EINVAL;
> +			break;
>  		}
>  
>  		is_in = epnum & USB_DIR_IN;
> @@ -107,7 +110,7 @@ static int service_tx_status_request(
>  		}
>  		regs = musb->endpoints[epnum].regs;
>  
> -		if (epnum >= MUSB_C_NUM_EPS || !ep->desc) {
> +		if (!ep->desc) {
>  			handled = -EINVAL;
>  			break;
>  		}
>
> -- 
> 2.47.3
