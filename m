Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6103DC2A069
	for <u-boot@archiver.kernel.org>; Sun,  4 Jan 2026 04:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6720983AB7;
	Sun,  4 Jan 2026 05:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qVZtU3To";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D770283C54; Sun,  4 Jan 2026 05:34:14 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B29A83AAD
 for <u-boot@lists.denx.de>; Sun,  4 Jan 2026 05:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dkPhf1VbCz9spq;
 Sun,  4 Jan 2026 05:34:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767501250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MPboXRffdHgqH1x9ctg3DJaD0Sv8s8hIqBccW9bPmCM=;
 b=qVZtU3ToES0jDk2DNpSOmwNnyiFizfi2rDU7HSUg7qedJbAbOyXJKVTIk81GWX0E64TnQm
 5yHfRzkOLc0E3MZJslFkG2Zmc+i4D+mTDQ76ulxe4snDPWVhFsgxP62ytc9hyljTjQF/IH
 21xSyQvZKrxjTa+Ksb2tAg/CN5V3b/Aqgm5N7obDfl7z2ex4XZiohFbn3PdQI4uvuVFIwC
 B+MTILAJ8JqEUuFwefk63Ke2wKrwH+qungP6mUxOgIHkcr/iSTIgHZmv7zXMV3ZC1M46TR
 kjhlt8/R2qr7UQySnqvMyunAdYy51sP1X8rjdGOLYS4NpSGR0cZDX8WVNmfjJw==
Message-ID: <2c9bb8b6-d919-442d-8336-95158cb6865b@mailbox.org>
Date: Sat, 3 Jan 2026 19:06:27 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] usb: dwc3-generic: allow fallback of dr_mode
 property to "otg"
To: Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260103-usb-dwc3-exynos7870-v2-0-67441680d287@disroot.org>
 <20260103-usb-dwc3-exynos7870-v2-1-67441680d287@disroot.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260103-usb-dwc3-exynos7870-v2-1-67441680d287@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b9821ac908c21349ee4
X-MBO-RS-META: w9g18iy1x8u1cmdequ44pxmai3rcebz4
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

On 1/3/26 1:28 PM, Kaustabh Chakraborty wrote:
> Documentation [1] states that the default value of the dr_mode property
> is "otg". It also isn't marked a mandatory node, so it may or may not be
> set. So, accordingly if dr_mode is not mentioned in the devicetree node,
> OTG mode must be assumed.
> 
> In this driver however, this case is not handled. If dr_mode is not
> mentioned, USB_DR_MODE_UNKNOWN is set. The logic implemented raises an
> error, instead of falling back to USB_DR_MODE_OTG. Correct this to
> conform to the specification.
> 
> Link: https://elixir.bootlin.com/u-boot/v2025.10/source/dts/upstream/Bindings/usb/usb-drd.yaml#L23 [1]

Please update the link to point to git.kernel.org , that's where the DT 
bindings reside.

> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index c09014aec60..1967594f48a 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -173,8 +173,8 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
>   		node = dev_ofnode(dev->parent);
>   		plat->dr_mode = usb_get_dr_mode(node);
>   		if (plat->dr_mode == USB_DR_MODE_UNKNOWN) {
> -			pr_err("Invalid usb mode setup\n");
> -			return -ENODEV;
> +			pr_info("No USB mode specified. Using 'otg'\n");

dev_info(dev, ...

> +			plat->dr_mode = USB_DR_MODE_OTG;
>   		}
>   	}
>   
> @@ -516,6 +516,10 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>   	if (!dr_mode)
>   		dr_mode = usb_get_dr_mode(node);
>   
> +	/* usb mode must fallback to peripheral if not known */
> +	if (dr_mode == USB_DR_MODE_UNKNOWN)
> +		dr_mode = USB_DR_MODE_OTG;
With those two fixed:

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks
