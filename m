Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD751C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 02:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97B1784A3E;
	Sun, 12 Jul 2026 04:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TkA/bMre";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZA1qKpWa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F12284A3E; Sun, 12 Jul 2026 04:15:17 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E291184A3C
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 04:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gyTg64bLfzMlGc;
 Sun, 12 Jul 2026 04:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783822514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z03VTo8mMp/DX0vqUG00271Z0abZ7fSrgBjYbkZPfBU=;
 b=TkA/bMre1w0m3O2FSUY9fJ4oqJadZG/o84UnmLOLMJTNkpkCRpEqXXKNTbMN18Nbf0JWNm
 JGBCmDdBXcDmH9+bW+ekSDwVC1KcX07/2RreVVlRKmAyvIWxL5MfeQKvotz27UOMsX/YDT
 jjMk/0yDj1vHTnmhl4hLLJNPvCQ53+bYpMUunsMjgUfB+juwEKBmVhZYh6pyAnqZTrv55q
 tztHQrFps0bLVERbRvULbDn7Jrt3hbbhiqQml1cxkUUclCcuF2Jd+NoZXJvodzDVrUpxvk
 wJ+rYliPpgKKE0HSICYwp//eGyLx/UOFTibdLlYoqpZc2NJOfPrfQGe0jkqsuQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ZA1qKpWa;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <74b9d259-b180-4ca7-9cf6-1c93e175e1f4@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783822513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z03VTo8mMp/DX0vqUG00271Z0abZ7fSrgBjYbkZPfBU=;
 b=ZA1qKpWajxc5R0DWNMUARthHjMy7luXOLu1e2G6osNo4cECOQB20ZqSTkFEsfPbDUEYHXr
 14KT+/96XS5j4blNKKFZ6ktywbPNnc3AOGgLuMCeDczFjDkpyxdTGSuM4ADrTS7UevWWAw
 YrpKgo2rWe7DLezBUUWiJTjCKTM/ERLz5dHcUWLfOhHKKKrkbk18wH8NUNHsq9s0kD8Kp/
 YQ8h4UcVM5iK22O39wvMRQakG+0WJNc1IfosPMjql3bwnzIBw19L0db50NKuKZn6Ahya9f
 uUO2NtqsfA0nCYPhyfSKabdvlLiineNvwHMLUDB0UGwpxpzzzH/L+bMp58hzlA==
Date: Sat, 11 Jul 2026 22:00:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/10] usb: dwc3: generic: add board_usb_init/cleanup
 hooks
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Fabio Estevam <festevam@gmail.com>, Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
 <20260621-tcpci-dwc3-v2-7-990ecacc111c@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260621-tcpci-dwc3-v2-7-990ecacc111c@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: zobe7siyjydp3w6y3u9djucreh7kco3n
X-MBO-RS-ID: 5b8a653a888b0de2a86
X-Rspamd-Queue-Id: 4gyTg64bLfzMlGc
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

On 6/21/26 4:06 AM, Peng Fan (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> Call board_usb_init() during dwc3_generic_probe() and
> board_usb_cleanup() during dwc3_generic_remove() to allow
> board-level USB configuration (e.g. Type-C CC role, SS mux,
> VBUS control) before DWC3 core initialization.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 2356b3bc0aa..2c6f8e6d8ba 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -9,6 +9,7 @@
>   
>   #include <dm.h>
>   #include <reset.h>
> +#include <usb.h>
>   #include <asm/gpio.h>
>   #include <dm/device_compat.h>
>   #include <dm/lists.h>
> @@ -118,6 +119,11 @@ static int dwc3_generic_probe(struct udevice *dev,
>   	if (device_is_compatible(dev->parent, "rockchip,rk3399-dwc3"))
>   		reset_deassert_bulk(&glue->resets);
>   
> +	if (mode == USB_DR_MODE_HOST)
> +		board_usb_init(dev_seq(dev), USB_INIT_HOST);
> +	else if (mode == USB_DR_MODE_PERIPHERAL)
> +		board_usb_init(dev_seq(dev), USB_INIT_DEVICE);

Pass udevice into the callbacks directly, dev_seq() is a backward 
compatibility workaround and the board code could always call it if needed.

> +
>   	priv->base = map_physmem(plat->base, DWC3_OTG_REGS_END, MAP_NOCACHE);
>   	dwc3->regs = priv->base + DWC3_GLOBALS_REGS_START;
>   
> @@ -134,6 +140,7 @@ static int dwc3_generic_remove(struct udevice *dev,
>   			       struct dwc3_generic_priv *priv)
>   {
>   	struct dwc3 *dwc3 = &priv->dwc3;
> +	enum usb_dr_mode mode = dwc3->dr_mode;
>   
>   	if (CONFIG_IS_ENABLED(DM_GPIO) &&
>   	    device_is_compatible(dev->parent, "xlnx,zynqmp-dwc3") &&
> @@ -147,6 +154,11 @@ static int dwc3_generic_remove(struct udevice *dev,
>   	dwc3_shutdown_phy(dev, &priv->phys);
>   	unmap_physmem(dwc3->regs, MAP_NOCACHE);
>   
> +	if (mode == USB_DR_MODE_HOST)
> +		board_usb_cleanup(dev_seq(dev), USB_INIT_HOST);
> +	else if (mode == USB_DR_MODE_PERIPHERAL)
> +		board_usb_cleanup(dev_seq(dev), USB_INIT_DEVICE);
> +
This is supposed to be generic DT based glue code, can we avoid the 
board-specific callbacks entirely ?
