Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B18F8E497
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AAE48426C;
	Fri, 17 Apr 2026 04:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kQYg2VSa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3A784262; Fri, 17 Apr 2026 04:57:47 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE948422D
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fxfgr02qPz9v7t;
 Fri, 17 Apr 2026 04:57:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776394664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dO1EUKkf5Jq7VaNXyXePTAQn8c469nhJO3xECJk6lNY=;
 b=kQYg2VSaVRV+QkXoGDxhVN7dMVsBrm+CMe0QbTOOeVDSmDy1F6VunGoEPw+AYa8wOjBa2d
 DXkFH+YNSA3L45+2ZrMSfyuo/wt4gZIwTG2P339Q/4IWqMfH7zqOkoFC/H+6pCmNwLimmC
 UIFf+YQAc4n/Dc7PzzOdlNfjCxJqhr5LbtZqeio5QVHOnt5buDZg4uVugRD9xRovoFzVcg
 JypEh3frjyCFwdmi3xI8RrkQeXifKojIk0xTKBcoceAYrZv/5adDUr5Hd+VhNHUcvpX3ty
 TCp8zPqned3zBA9elfCJrES9C+M+omDi6rYVaglUpWD2Y/7QnIYXo7nh2oxk2w==
Message-ID: <86d99f5c-5476-448f-849a-ff68b4bb1068@mailbox.org>
Date: Thu, 16 Apr 2026 20:03:42 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] regulator: rzg2l: implement connectivity
 notification
To: Michele Bisogno <micbis.openwrt@gmail.com>, u-boot@lists.denx.de,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: paul@pbarker.dev, jh80.chung@samsung.com, peng.fan@nxp.com,
 lukma@denx.de, mkorpershoek@kernel.org, trini@konsulko.com
References: <20260416153827.14256-1-micbis.openwrt@gmail.com>
 <20260416153827.14256-2-micbis.openwrt@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260416153827.14256-2-micbis.openwrt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: okw9tzcsng7sjwnqw8hkkwazrri4t87m
X-MBO-RS-ID: 932b68d6e3c98ba96a0
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

On 4/16/26 5:38 PM, Michele Bisogno wrote:
> Implement CON_CTRL manual connectivity notification.
> By setting SEL_CONNECT and CONNECT_1, the UTM+ core is notified of
> connection status in peripheral mode.
> 
> Signed-off-by: Michele Bisogno <micbis.openwrt@gmail.com>
> ---
>   drivers/power/regulator/rzg2l-usbphy-regulator.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/regulator/rzg2l-usbphy-regulator.c b/drivers/power/regulator/rzg2l-usbphy-regulator.c
> index 0354555d0b5..03f8dec4f08 100644
> --- a/drivers/power/regulator/rzg2l-usbphy-regulator.c
> +++ b/drivers/power/regulator/rzg2l-usbphy-regulator.c
> @@ -9,16 +9,22 @@
>   #include <renesas/rzg2l-usbphy.h>
>   
>   #define VBENCTL			0x03c
> +#define CON_CTRL		0x020
>   #define VBENCTL_VBUS_SEL	BIT(0)
> +#define SEL_CONNECT		BIT(4)
> +#define CONNECT_1		BIT(0)
>   
>   static int rzg2l_usbphy_regulator_set_enable(struct udevice *dev, bool enable)
>   {
>   	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(dev->parent);
>   
> -	if (enable)
> +	if (enable) {
>   		clrbits_le32(priv->regs + VBENCTL, VBENCTL_VBUS_SEL);
> -	else
> +		setbits_le32(priv->regs + CON_CTRL, SEL_CONNECT | CONNECT_1);
> +	} else {
>   		setbits_le32(priv->regs + VBENCTL, VBENCTL_VBUS_SEL);
> +		clrbits_le32(priv->regs + CON_CTRL, SEL_CONNECT | CONNECT_1);
> +	}
>   
>   	return 0;
>   }

Why does Linux not need a change like this to 
drivers/reset/reset-rzg2l-usbphy-ctrl.c ?
