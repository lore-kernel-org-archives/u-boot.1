Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1040D5CC94
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 09:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FAF0833C6;
	Tue, 16 Dec 2025 10:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.b="fu2ADlIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BAA0838FA; Tue, 16 Dec 2025 10:53:01 +0100 (CET)
Received: from mail4.out.titan.email (mail4.out.titan.email [35.153.42.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C59A8334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 10:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dVsgF4hzBz9rxF;
 Tue, 16 Dec 2025 09:52:57 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=M0xBPvMjmYRD34CdVWnLdhS0yt3DjdWEld3lr2oRFLk=; 
 c=relaxed/relaxed; d=ziyao.cc;
 h=mime-version:cc:message-id:references:date:from:to:subject:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
 q=dns/txt; s=titan1; t=1765878777; v=1;
 b=fu2ADlIts5WPaJFkfZ8+TA7fg+4U1b5wwZQXEWoOjFLR5v6XkvLHnyVjbSxo9VB6B6Ua6D4v
 F6yhXhMcKC0yeAtGb4NVAjDY7GRArz23aCk8t2Ws7e+atWcYRNhlHXS36nnYsve0MJrVUgIQi2A
 XrhIJ114kA5O4RW3BDLTgT9o=
Received: from pie (unknown [117.171.66.90])
 by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dVsg71Hbyz9rvm;
 Tue, 16 Dec 2025 09:52:50 +0000 (UTC)
Date: Tue, 16 Dec 2025 09:52:41 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 George Chan <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>,
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 3/7] usb: ehci-mx6: Extract PHY initialization into
 reusable functionr
Message-ID: <aUEr6RsBi4-2yg64@pie>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
 <20251216-imx8ulp-v1-3-504115a53020@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216-imx8ulp-v1-3-504115a53020@nxp.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765878777493495756.21635.6394730170456639523@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=WtDRMcfv c=1 sm=1 tr=0 ts=69412bf9
 a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=8AirrxEcAAAA:8
 a=cu4Xikc6Xx-VJYLvizcA:9 a=CjuIK1q_8ugA:10 a=cVsMrA03MGg3mf7B7O_L:22
 a=ST-jHhOKWsTCqRlWije3:22 a=3z85VNIBY5UIEeAh_hcH:22
 a=NWVoK91CQySWRX1oVYDe:22
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

On Tue, Dec 16, 2025 at 02:38:35PM +0800, alice.guo@oss.nxp.com wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Extract USB PHY initialization code from ehci-mx6.c into a new function
> ehci_mx6_phy_init() that can be shared with the ChipIdea UDC driver.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  drivers/usb/host/ehci-mx6.c | 73 ++++++++++++++++++++++++++++++++++++++++++++-
>  include/usb/ci_udc.h        |  9 ++++++
>  2 files changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
> index 03ff4ce10d5..52f14e6eca0 100644
> --- a/drivers/usb/host/ehci-mx6.c
> +++ b/drivers/usb/host/ehci-mx6.c
> @@ -12,6 +12,7 @@
>  #include <asm/global_data.h>
>  #include <linux/compiler.h>
>  #include <linux/delay.h>
> +#include <usb/ci_udc.h>
>  #include <usb/ehci-ci.h>
>  #include <asm/io.h>
>  #include <asm/arch/imx-regs.h>
> @@ -168,6 +169,54 @@ static void __maybe_unused
>  usb_power_config_mx7ulp(void *usbphy) { }
>  #endif
>  
> +#if defined(CONFIG_IMX8)
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

We have readX_poll_timeout() defined in include/linux/iopoll.h, I think
it could simplify the code here.

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
> +	       &usbphy->usb1_pll_480_ctrl_set);
> +}

Regards,
Yao Zi
