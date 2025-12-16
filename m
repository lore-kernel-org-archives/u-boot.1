Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4A6D609B1
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 15:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C1E839B7;
	Tue, 16 Dec 2025 16:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rG0jL4xA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sbcs0V0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBB5980107; Tue, 16 Dec 2025 16:40:39 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3012839A5
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 16:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dW1NP2gwsz9tdl;
 Tue, 16 Dec 2025 16:40:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765899637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7sccV6bMrJUMR742kFpUDrkg27R+phrQIFFU+Iy1wI=;
 b=rG0jL4xALayg7bkMwt19b+ZbNpPkd8aVoqpQpiE1RaNJT9CKvmNEiYDTtYxuGCIgKfPfme
 HOQb0S2GW8Sf8hmHV4ZB3ktAh4VRFnDEWf5bdKi2rlPpxUA+udm101EnKjIOwwWwCDlDzo
 26MuBa5VqQvd3pF7T6NB7oHIGwbEpRR9aRUIXoyriap1k6geqLRbjRExedAupYy4YVnOKI
 SAykq5BjZGBvAzUwYClJYCp4UBJL3nyZdRpaSUq/TVo4KiKR7nTbL+rapjpVV1UZ38hr2q
 LVZSvugqTxKQXngPwF5jkTM5AZlxjWi2Lx+3Cx9m7C3uNG89N/gmnXj5t5YXwA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=sbcs0V0T;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <3b1738d4-7163-4f2a-95ec-4f0c6e401948@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765899635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7sccV6bMrJUMR742kFpUDrkg27R+phrQIFFU+Iy1wI=;
 b=sbcs0V0TVO+bQgeV2VuxM5M+m5pBLgw7NYlvwl8wDQ3EEmCx4y6DUnksrVbyaUVoWUT+DX
 ckTyG50fluAf73rzKetb7j6NcOJdHJeba/HIlMFFjf/oe6zTSuVPY0y7K20jHU+qbtuf2t
 XNW2USA2JgLda70x1JOr5j+p1nYskR7u5Jv1sDi8mLblBIIRB7mh1aO7t/T8bm56Vy4Umh
 9SAfZ9P7rPsPN/wzAPZzPsMtc3SSPTvWg5ED6DAiwGuDoGbAoY6Pad6/Z8tX7dGy/Q5s14
 Hj/B6p9POw0bfablh2eNaJVkpNZc7YZYoyyqIk6uuadmIDQOh4Q3ll5pjmRZng==
Date: Tue, 16 Dec 2025 12:17:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 3/7] usb: ehci-mx6: Extract PHY initialization into
 reusable function
To: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, George Chan
 <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>,
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
 <20251216-imx8ulp-v1-3-504115a53020@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251216-imx8ulp-v1-3-504115a53020@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cc905858f81b8da779f
X-MBO-RS-META: 65eyj6onrs9dxhosnmwdoycj14mtqexu
X-Rspamd-Queue-Id: 4dW1NP2gwsz9tdl
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

On 12/16/25 7:38 AM, alice.guo@oss.nxp.com wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Extract USB PHY initialization code from ehci-mx6.c into a new function
> ehci_mx6_phy_init() that can be shared with the ChipIdea UDC driver.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>   drivers/usb/host/ehci-mx6.c | 73 ++++++++++++++++++++++++++++++++++++++++++++-
>   include/usb/ci_udc.h        |  9 ++++++
>   2 files changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
> index 03ff4ce10d5..52f14e6eca0 100644
> --- a/drivers/usb/host/ehci-mx6.c
> +++ b/drivers/usb/host/ehci-mx6.c
> @@ -12,6 +12,7 @@
>   #include <asm/global_data.h>
>   #include <linux/compiler.h>
>   #include <linux/delay.h>
> +#include <usb/ci_udc.h>
>   #include <usb/ehci-ci.h>
>   #include <asm/io.h>
>   #include <asm/arch/imx-regs.h>
> @@ -168,6 +169,54 @@ static void __maybe_unused
>   usb_power_config_mx7ulp(void *usbphy) { }
>   #endif
>   
> +#if defined(CONFIG_IMX8)

Can we avoid more ifdeffery ?

> +static void usb_power_config_imx8(void __iomem *usbphy_base)
> +{
> +	struct usbphy_regs __iomem *usbphy = (struct usbphy_regs __iomem *)usbphy_base;
> +
> +	if (!is_imx8())
> +		return;
> +
> +	int timeout = 1000000;
> +
> +	if (!(readl(&usbphy->usb1_pll_480_ctrl) & PLL_USB_LOCK_MASK)) {
> +		/* Enable the regulator first */
> +		writel(PLL_USB_REG_ENABLE_MASK,
> +		       &usbphy->usb1_pll_480_ctrl_set);
> +
> +		/* Wait at least 25us */
> +		udelay(25);
> +
> +		/* Enable the power */
> +		writel(PLL_USB_PWR_MASK, &usbphy->usb1_pll_480_ctrl_set);
> +
> +		/* Wait lock */
> +		while (timeout--) {
> +			if (readl(&usbphy->usb1_pll_480_ctrl) &
> +			    PLL_USB_LOCK_MASK)
> +				break;
> +			udelay(10);
> +		}

readl_poll*() instead of hand-rolled polling.

> +		if (timeout <= 0) {
> +			/* If timeout, we power down the pll */
> +			writel(PLL_USB_PWR_MASK,
> +			       &usbphy->usb1_pll_480_ctrl_clr);
> +			return;
> +		}
> +	}
> +
> +	/* Clear the bypass */
> +	writel(PLL_USB_BYPASS_MASK, &usbphy->usb1_pll_480_ctrl_clr);
> +
> +	/* Enable the PLL clock out to USB */
> +	writel((PLL_USB_EN_USB_CLKS_MASK | PLL_USB_ENABLE_MASK),

Parenthesis () not needed.

> +	       &usbphy->usb1_pll_480_ctrl_set);
> +}
> +#else
> +static void __maybe_unused usb_power_config_imx8(void __iomem *usbphy_base) { }
> +#endif
> +
>   #if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMXRT) || \
>       defined(CONFIG_IMX8ULP)
>   static const ulong phy_bases[] = {
> @@ -276,7 +325,6 @@ static void ehci_mx6_powerup_fixup(struct ehci_ctrl *ctrl, uint32_t *status_reg,
>   	*reg = ehci_readl(status_reg);
>   }
>   
> -#if !defined(CONFIG_PHY)
>   /* Should be done in the MXS PHY driver */
>   static void usb_oc_config(struct usbnc_regs *usbnc, int index)
>   {
> @@ -298,7 +346,30 @@ static void usb_oc_config(struct usbnc_regs *usbnc, int index)
>   	clrbits_le32(ctrl, UCTRL_PWR_POL);
>   #endif
>   }
[...]
