Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C271D609AA
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 15:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 535AD8392C;
	Tue, 16 Dec 2025 16:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="E7j83VRU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vnG0hZTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D615D80107; Tue, 16 Dec 2025 16:40:34 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9EBB83956
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 16:40:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dW1NJ20mMz9txG;
 Tue, 16 Dec 2025 16:40:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765899632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZN/XfsuUf3HMcbkvrZOWbuXEZorqzGiDMVxlm6jeHU=;
 b=E7j83VRUjPLjQx9rlDOnb7UAUP9sfZ1/s1Hl1N+Yp33/UD8nTtSBVhRodNcOrfNQUuaaPj
 zyVHyNCPTpJYJ9wJBpy+G5OYBWcSMEjSDYcBUFOlZNx6/PHB7r1PYKwUVHjXnI/nf7Dgi0
 12VL9MQWO4kBS/LydhAjCOJ/1w1eJdBkkGAoqOhU/wKF8MunLHCx5K2VwUrXiyjk5C0ZQq
 XhCXv/xKl3gNBN8k+iOgLSEsg44TGSYvqXAjKoT3rwq9TmhvJua4FfoMgAYXxEVO9+VMjx
 uHG1u8othRB3b8nkKhrk6l3RZJxflEOzF7hoDcX7UR7BX3tByXYJ/VeoQ5YyRQ==
Message-ID: <e314692d-452c-452e-ba44-1469a8bcd9b5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765899629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZN/XfsuUf3HMcbkvrZOWbuXEZorqzGiDMVxlm6jeHU=;
 b=vnG0hZTRZjc9vnv6nxyNffyCtSfbDWpCXpeL6BAOATBiTNwE0bDbyejNXsWPICGCYNrAWM
 0fDi0+WyNMIWm4L6U4cQVIt2d6zuM7lsAHYx/x4uiv2gekwXLLNZuqDA3YaRAMmdQl1EGW
 CKF9W0MMIwqgumHXfa7M9LVnSaIA9Adw+nZTRS55H8ZAAALAB0y2mh6L7XxoZIZKYKBXeW
 tAuyK67RE5uihso+rwkQa4TwXTmuqvP2j+QcrueC8GZCvchoXHMma0oThiRt3+M3AWrhtp
 R+s/4fjl5CXFKpUcHiPKF2AzI3pcHXZeJAEbZs5OJ36OHFP6JVfTYdCEKXzQ6Q==
Date: Tue, 16 Dec 2025 12:15:43 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/7] usb: ehci-mx6: Fix usb_oc_config() for
 i.MX7/8M/9/7ULP/8 and 8ULP platforms
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
 <20251216-imx8ulp-v1-2-504115a53020@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251216-imx8ulp-v1-2-504115a53020@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: jofupd35ujjootzo5ub3p971o1t6a8zf
X-MBO-RS-ID: 01b7630d81da58363f6
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
> The usb_oc_config() function previously assumed that the overcurrent
> control register index always matches the USB controller index, which is
> true for i.MX6 but not for i.MX7/8M/9/7ULP/8/8ULP. On these platforms,
> the overcurrent control is located in the USB OTG Control 1 register,
> which is always at index 0.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>   drivers/usb/host/ehci-mx6.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
> index cfaf49d67f0..03ff4ce10d5 100644
> --- a/drivers/usb/host/ehci-mx6.c
> +++ b/drivers/usb/host/ehci-mx6.c
> @@ -280,7 +280,12 @@ static void ehci_mx6_powerup_fixup(struct ehci_ctrl *ctrl, uint32_t *status_reg,
>   /* Should be done in the MXS PHY driver */
>   static void usb_oc_config(struct usbnc_regs *usbnc, int index)
>   {
> +#if defined(CONFIG_MX6)
>   	void __iomem *ctrl = (void __iomem *)(&usbnc->ctrl[index]);
> +#elif defined(CONFIG_USB_EHCI_MX7) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMX8) || \
> +      defined(CONFIG_IMX8ULP)
> +	void __iomem *ctrl = (void __iomem *)(&usbnc->ctrl[0]);
> +#endif
Can we simply pass 0 to this function as index for non-MX6 instead of 
this ifdeffery ?
