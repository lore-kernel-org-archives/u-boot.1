Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAC2D111A8
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 05:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA33D8307F;
	Sun, 30 Nov 2025 06:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CHI8WgL3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OYTUuz6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC22E83885; Sun, 30 Nov 2025 06:01:17 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F24E083015
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 06:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dJvy31pQZz9t1D;
 Sun, 30 Nov 2025 06:01:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764478875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIS2cX0f6/C86NPhadq+mPcFjqZ/aaxC/dcrWONqmRE=;
 b=CHI8WgL36TU0xs/ZFibbbCM12D5EZpH+i7RkFDbp3FeoeW5JbTx6y93Ez/fI2l7lv5ztp7
 vQzopAtyG2PwLnublqtyEPN2B2Wx237ZLXBvxVsnuYZer9KQ7sJQATQGYdu1LtA/pXv6ZY
 WQzGWlzirZEY6ATrIMWdtJE6JSl6ZaE5/kPgxqvp2wRfOTeSyh1FltvNjxJ8mEWHnCRXI/
 8PO+3krt/7QbtQ9Uj7GbAAdCIH4ADF7cME7fHqMjNuZE/y2jOzOeJaHswBbTXoEL9B41Xm
 RffSAGU5CB63+5Jeidh49hFOGpLZaa2FEP1YAP2hJCX1zOGYTAWAeT8KrbgUDQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=OYTUuz6Z;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <7880adeb-e210-4c9a-801e-8c3db5e87d12@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764478873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIS2cX0f6/C86NPhadq+mPcFjqZ/aaxC/dcrWONqmRE=;
 b=OYTUuz6ZUnqecey0/uval/sXEPxJyWXx3wWScqQhCHtnlyHtCBwSeE9zci0LqGZO1OyVmg
 h3q4jlNq1/pHeQEb5WNTpgSQ/Ba9deO3nzZmaJl7+WsVeQcZ05j5p/D6G/nsx06tU2G2OY
 NiXXowcv4Yv6v/sMs2yuJY6+grDzrLjMo14ijCtb8JRkB3efB/ZNRMClJVsdDzLGkZsjlQ
 2PFulU4cYmoNRWddvhmK8uEBDxpiQNXUj2p8mqOKUU+Xaad/VOPzeIuTh4U74izEVA8fKd
 6682+rzlsbrriw8fgLHvIw71bN87IC8KixbLMg0CGV93NpAAdVMOUTq+v/hkPg==
Date: Sun, 30 Nov 2025 02:06:14 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/4] ehci-mx6: Update USB host driver for iMX8ULP
To: alice.guo@oss.nxp.com, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
References: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
 <20251128-usb2-v1-2-25ec5ac127ff@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251128-usb2-v1-2-25ec5ac127ff@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9f6d8860e00a982ba93
X-MBO-RS-META: 6eogcjcguhcu3y5ek6ke64w5q93mqeph
X-Rspamd-Queue-Id: 4dJvy31pQZz9t1D
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

On 11/28/25 2:16 PM, alice.guo@oss.nxp.com wrote:

[...]

> -#if defined(CONFIG_MX7ULP) && !defined(CONFIG_PHY)
> +#if (defined(CONFIG_MX7ULP) || defined(CONFIG_IMX8ULP)) && !defined(CONFIG_PHY)
>   static void usb_power_config_mx7ulp(struct usbphy_regs __iomem *usbphy)
>   {
> -	if (!is_mx7ulp())
> +	if (!(is_mx7ulp() || is_imx8ulp()))
>   		return;
>   
>   	writel(ANADIG_USB2_CHRG_DETECT_EN_B |
>   	       ANADIG_USB2_CHRG_DETECT_CHK_CHRG_B,
>   	       &usbphy->usb1_chrg_detect);
>   
> +#if IS_ENABLED(CONFIG_IMX8ULP)

if (IS_ENABLED(...)) , but really , can we avoid the ifdeffery altogether ?

> +	enable_usb_pll((ulong)usbphy);
> +#else
>   	scg_enable_usb_pll(true);
> +#endif


[...]

> @@ -620,13 +632,15 @@ static int mx6_parse_dt_addrs(struct udevice *dev)
>   	if (misc_off < 0)
>   		return -EINVAL;
>   
> -	addr = (void __iomem *)fdtdec_get_addr(blob, phy_off, "reg");
> +	addr = (void __iomem *)fdtdec_get_addr_size_auto_noparent(blob, phy_off,
> +								  "reg", 0, NULL, false);
Separate patch please . Also, why this change ?
