Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3447D1356F
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6DB88E78;
	Sun, 27 Oct 2024 17:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="q2GWHA3F";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cTlBQ7Wb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3313788B1F; Sun, 27 Oct 2024 17:32:20 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52DAA88F6C
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Xc29M0mLLz9sWY;
 Sun, 27 Oct 2024 17:32:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQZCSRrTPCLkLFZm9qmhX1AntJvBYZYqD7KsC3FRukI=;
 b=q2GWHA3F5f8idswJVxFASL3255Q436u3PAt7yFmgF423GLaQst2Xri0L9HDGq7X9KAEW9K
 WEc/uLnSRgYtWoC+yK35STGqHitg748/4YtCBzP1q97h4UR+1QaWaWFCVm+Q2Fr1s4RQPI
 CxqX6vNGkH/8V5rZFyMY5DUAS9e0axQFUiY4/Dq0Vr2ZHcsbBWt8Dsgjhs+0rj61qf8jNl
 9NPBxL7b6D6AnwYnJTkLWn4ZFPcidMhaC7g8HlTOUCR/zT04MX9Ct9s+jksD22tPzUZkwz
 1UyQyu3t98t6CLdyLjX1Egx3chpZSOQGnswERoV7kYo6R8rGl4Z9QlNa3g1amg==
Message-ID: <73609bce-143a-4da2-9e8c-87ac7646a72d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQZCSRrTPCLkLFZm9qmhX1AntJvBYZYqD7KsC3FRukI=;
 b=cTlBQ7WbyUh4jGmzEj5HNC3JkMiulLQwHwR4yocbztnKo+EBYhCYWZPMZZC6O9/NI7DPj5
 BxVabQ/d7yoVB0vkZcTNjedyM9INTRTCo/sjDX88S609vI5Nl/OUy6B/OQRZiEvg3XSjFW
 DhxuxCBAK8CYa1+PSzxCXYLjc/RU4aF4Aptv9VtkekS5Yh1tuGONz6S44hrPJwPzTISW04
 ukeSiKULcViD5oXfSnSboM2wXc8N40ElxQ38BRy34TaXNYrHcUccmxL4OYWt2fBRluXfQY
 goBrJyMVCV0UmWOPOUY6jEzZnTNePU+HG1+FpxepYmuqbK2GHga1frh78F1V6w==
Date: Sun, 27 Oct 2024 17:20:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 08/14] net: phy: ksz90x1: Simplify
 ksz9131_config_rgmii_delay
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-9-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241024152448.102-9-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fbrqmzw9mb1z38wgphwysona6yxuk8cr
X-MBO-RS-ID: 8113ed10270e6286e97
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

On 10/24/24 5:24 PM, Paul Barker wrote:
> We can call phy_modify_mmd() instead of manually calling drv->readext()
> and drv->writeext().
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>   drivers/net/phy/micrel_ksz90x1.c | 26 ++++++++------------------
>   1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
> index b64046e0bc72..6515d8feb9be 100644
> --- a/drivers/net/phy/micrel_ksz90x1.c
> +++ b/drivers/net/phy/micrel_ksz90x1.c
> @@ -502,8 +502,7 @@ static int ksz9131_of_load_all_skew_values(struct phy_device *phydev)
>   
>   static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
>   {
> -	struct phy_driver *drv = phydev->drv;
> -	u16 rxcdll_val, txcdll_val, val;
> +	u16 rxcdll_val, txcdll_val;
>   	int ret;
>   
>   	switch (phydev->interface) {
> @@ -527,24 +526,15 @@ static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
>   		return 0;
>   	}
>   
> -	val = drv->readext(phydev, 0, KSZ9131RN_MMD_COMMON_CTRL_REG,
> -			   KSZ9131RN_RXC_DLL_CTRL);
> -	val &= ~KSZ9131RN_DLL_CTRL_BYPASS;
> -	val |= rxcdll_val;
> -	ret = drv->writeext(phydev, 0, KSZ9131RN_MMD_COMMON_CTRL_REG,
> -			    KSZ9131RN_RXC_DLL_CTRL, val);
> -	if (ret)
> +	ret = phy_modify_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> +			     KSZ9131RN_RXC_DLL_CTRL, KSZ9131RN_DLL_CTRL_BYPASS,
> +			     rxcdll_val);
> +	if (ret < 0)
>   		return ret;
>   
> -	val = drv->readext(phydev, 0, KSZ9131RN_MMD_COMMON_CTRL_REG,
> -			   KSZ9131RN_TXC_DLL_CTRL);
> -
> -	val &= ~KSZ9131RN_DLL_CTRL_BYPASS;
> -	val |= txcdll_val;
> -	ret = drv->writeext(phydev, 0, KSZ9131RN_MMD_COMMON_CTRL_REG,
> -			    KSZ9131RN_TXC_DLL_CTRL, val);
> -
> -	return ret;
> +	return phy_modify_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> +			      KSZ9131RN_TXC_DLL_CTRL, KSZ9131RN_DLL_CTRL_BYPASS,
> +			      txcdll_val);
>   }
Can't you set both bitfields at the same time ? They seem to be in the 
same register.
