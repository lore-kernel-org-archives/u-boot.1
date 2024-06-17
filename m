Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD61CC27C6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 07:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B35838704E;
	Mon, 17 Jun 2024 09:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GuWUefbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C462C871C7; Mon, 17 Jun 2024 09:07:22 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51AE9831A1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 09:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6267778b3aso365524266b.3
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 00:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608040; x=1719212840; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fbtEIxXMcRh6kfeD7CGmIWzJndsRVgVNG4kXLZD9+VA=;
 b=GuWUefbHHGVIVTC1iILh6sDDl9KeiQ25uTTnfE7+aeazT3jAyd/qGok26gj2+rJNXP
 SrFvcXBieUE5WxJ2rNaxN/6TepI1x1ncITAuEo70bHA1jqKi7ecIUzQFTkw2gdpG2jy4
 yXFs3S4C5SxgDMTUPbCJtDTzEbMMgb+bH/kPM0lrT5vxg5GaS0XPwR5xNfefHkrE0BbA
 pY0Cgl5vmqXJ3CqM4H49CWNYB/vJjfC7yJU07+eJAofCs6Xq87pow4f+gEKHWmbalWIP
 iKxhwz8N9Bw9Bv2yxQLCxdQUtho8oUG6SO+7ItHhTTFKtUAw+oTdvoyhF2H7k0ZTR0X5
 Hupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608040; x=1719212840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fbtEIxXMcRh6kfeD7CGmIWzJndsRVgVNG4kXLZD9+VA=;
 b=D8e2eyTAPpg23jj0klXOSxDd5PTmCXPyXuaMcILr1lJF8jllvzEgHN4uDcG54zi6P5
 FT1Y7JF4tQWmga+MmULt+wtIPMenpQyow7GL2g06HtvBgRKAZPuWtSNJFAcJhs9X8ynB
 RU+FYY11B+FhRwuMRwXzpZkS3dkQC8YtCaJHpJbRpOWAuk5lvEhx1FKP0eehxkkoSXyI
 5QnE2RuA4Gk4rxXnAYsFdXa519GPuajT9Lpoxxv6IDJPe4UeZOkaIhhxAbO+GeBEQInk
 xIQ42EnuHCaaS8V8oDYJlDq5svkSXH8Yp6ZhPjC6Lh0C4XzFFerxk+hGOBNu9mkmRHO3
 aJqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdgARe++zU93fH5R6NCwmnySlRowqM1iQTzpBbXFtjoh3PoGQsl66ElG7T4wZZ2CM77Ud8hSouAzR3inZEV3bYYwFUxg==
X-Gm-Message-State: AOJu0YyH8+4A5KcgkpAwWMc78EIpIthJPhPML/JE4FU9pLQdHT1kLfCV
 rcnaBKoYSMvgBWCTfwojvG+xXB9nMMRRa7C5sbIPBxmrwvHpIkL6uW+99deAeTs=
X-Google-Smtp-Source: AGHT+IHIQ7HQKUI6vt5ECRaYtPaQebzpG3OMImsFOncI47nspWaW5Qsn1Ef/CRFWLcdCxoKFeI9CKw==
X-Received: by 2002:a17:906:6bcc:b0:a6f:27e6:8892 with SMTP id
 a640c23a62f3a-a6f60dc1f53mr507598466b.60.1718608039496; 
 Mon, 17 Jun 2024 00:07:19 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::52af? ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa67besm481195266b.208.2024.06.17.00.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 00:07:18 -0700 (PDT)
Message-ID: <1c0aa5da-468b-4d3f-9d90-6dba511afb69@linaro.org>
Date: Mon, 17 Jun 2024 09:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] phy: Extend generic_setup_phy() with PHY mode and
 submode
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, u-boot-qcom@groups.io
References: <20240616150426.36338-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240616150426.36338-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 16/06/2024 17:04, Marek Vasut wrote:
> Extend generic_setup_phy() parameter list with PHY mode and submode and
> call generic_phy_set_mode() in generic_setup_phy(), so the generic PHY
> setup function can configure the PHY into correct mode before powering
> the PHY up.
> 
> Update all call sites of generic_setup_phy() as well, all of which are
> USB host related, except for DM test which now behaves as a USB host
> test.
> 
> Note that if the PHY driver does not implement the .set_mode callback,
> generic_phy_set_mode() call returns 0 and does not error out, so this
> should not break any existing systems.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Caleb Connolly <caleb.connolly@linaro.org> # ehci-msm
> ---
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Mathieu Othacehe <othacehe@gnu.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Xavier Drudis Ferran <xdrudis@tinet.cat>
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.denx.de
> ---
>   drivers/phy/phy-uclass.c        | 7 ++++++-
>   drivers/usb/host/ehci-generic.c | 2 +-
>   drivers/usb/host/ehci-msm.c     | 2 +-
>   drivers/usb/host/ehci-mx6.c     | 2 +-
>   drivers/usb/host/ehci-pci.c     | 2 +-
>   drivers/usb/host/ohci-generic.c | 2 +-
>   include/generic-phy.h           | 5 ++++-
>   test/dm/phy.c                   | 8 ++++----
>   8 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
> index acdcda15b5b..bbaf95112c5 100644
> --- a/drivers/phy/phy-uclass.c
> +++ b/drivers/phy/phy-uclass.c
> @@ -508,7 +508,8 @@ int generic_phy_power_off_bulk(struct phy_bulk *bulk)
>   	return ret;
>   }
>   
> -int generic_setup_phy(struct udevice *dev, struct phy *phy, int index)
> +int generic_setup_phy(struct udevice *dev, struct phy *phy, int index,
> +		      enum phy_mode mode, int submode)
>   {
>   	int ret;
>   
> @@ -520,6 +521,10 @@ int generic_setup_phy(struct udevice *dev, struct phy *phy, int index)
>   	if (ret)
>   		return ret;
>   
> +	ret = generic_phy_set_mode(phy, mode, submode);
> +	if (ret)
> +		generic_phy_exit(phy);
> +
>   	ret = generic_phy_power_on(phy);
>   	if (ret)
>   		generic_phy_exit(phy);
> diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/ehci-generic.c
> index 23c3ed25554..1ae3619ce25 100644
> --- a/drivers/usb/host/ehci-generic.c
> +++ b/drivers/usb/host/ehci-generic.c
> @@ -94,7 +94,7 @@ static int ehci_usb_probe(struct udevice *dev)
>   	if (err)
>   		goto reset_err;
>   
> -	err = generic_setup_phy(dev, &priv->phy, 0);
> +	err = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_HOST, 0);
>   	if (err)
>   		goto regulator_err;
>   
> diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
> index a081f71b187..b0c060b8173 100644
> --- a/drivers/usb/host/ehci-msm.c
> +++ b/drivers/usb/host/ehci-msm.c
> @@ -56,7 +56,7 @@ static int ehci_usb_probe(struct udevice *dev)
>   	hcor = (struct ehci_hcor *)((phys_addr_t)hccr +
>   			HC_LENGTH(ehci_readl(&(hccr)->cr_capbase)));
>   
> -	ret = generic_setup_phy(dev, &p->phy, 0);
> +	ret = generic_setup_phy(dev, &p->phy, 0, PHY_MODE_USB_HOST, 0);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
> index 31cd8a50f4a..a93fa5d5455 100644
> --- a/drivers/usb/host/ehci-mx6.c
> +++ b/drivers/usb/host/ehci-mx6.c
> @@ -703,7 +703,7 @@ static int ehci_usb_probe(struct udevice *dev)
>   	usb_phy_enable(ehci, priv->phy_addr);
>   #endif
>   #else
> -	ret = generic_setup_phy(dev, &priv->phy, 0);
> +	ret = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_HOST, 0);
>   	if (ret)
>   		goto err_regulator;
>   #endif
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index 572686580cd..8d05b14e898 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -30,7 +30,7 @@ static int ehci_pci_init(struct udevice *dev, struct ehci_hccr **ret_hccr,
>   	int ret;
>   	u32 cmd;
>   
> -	ret = generic_setup_phy(dev, &priv->phy, 0);
> +	ret = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_HOST, 0);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
> index f1325cd4953..cc44226f5e0 100644
> --- a/drivers/usb/host/ohci-generic.c
> +++ b/drivers/usb/host/ohci-generic.c
> @@ -50,7 +50,7 @@ static int ohci_usb_probe(struct udevice *dev)
>   		goto reset_err;
>   	}
>   
> -	err = generic_setup_phy(dev, &priv->phy, 0);
> +	err = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_HOST, 0);
>   	if (err)
>   		goto reset_err;
>   
> diff --git a/include/generic-phy.h b/include/generic-phy.h
> index eaab7491660..47962023236 100644
> --- a/include/generic-phy.h
> +++ b/include/generic-phy.h
> @@ -415,10 +415,13 @@ int generic_phy_power_off_bulk(struct phy_bulk *bulk);
>    * @dev:	The consumer device.
>    * @phy:	A pointer to the PHY port
>    * @index:	The index in the list of available PHYs
> + * @mode:	PHY mode
> + * @submode:	PHY submode
>    *
>    * Return: 0 if OK, or negative error code.
>    */
> -int generic_setup_phy(struct udevice *dev, struct phy *phy, int index);
> +int generic_setup_phy(struct udevice *dev, struct phy *phy, int index,
> +		      enum phy_mode mode, int submode);
>   
>   /**
>    * generic_shutdown_phy() - Power off and de-initialize phy.
> diff --git a/test/dm/phy.c b/test/dm/phy.c
> index d14117f6f7a..a90881b12ab 100644
> --- a/test/dm/phy.c
> +++ b/test/dm/phy.c
> @@ -243,20 +243,20 @@ static int dm_test_phy_setup(struct unit_test_state *uts)
>   					      "gen_phy_user", &parent));
>   
>   	/* normal */
> -	ut_assertok(generic_setup_phy(parent, &phy, 0));
> +	ut_assertok(generic_setup_phy(parent, &phy, 0, PHY_MODE_USB_HOST, 0));
>   	ut_assertok(generic_shutdown_phy(&phy));
>   
>   	/* power_off fail with -EIO */
> -	ut_assertok(generic_setup_phy(parent, &phy, 1));
> +	ut_assertok(generic_setup_phy(parent, &phy, 1, PHY_MODE_USB_HOST, 0));
>   	ut_asserteq(-EIO, generic_shutdown_phy(&phy));
>   
>   	/* power_on fail with -EIO */
> -	ut_asserteq(-EIO, generic_setup_phy(parent, &phy, 2));
> +	ut_asserteq(-EIO, generic_setup_phy(parent, &phy, 2, PHY_MODE_USB_HOST, 0));
>   	ut_assertok(generic_shutdown_phy(&phy));
>   
>   	/* generic_phy_get_by_index fail with -ENOENT */
>   	ut_asserteq(-ENOENT, generic_phy_get_by_index(parent, 3, &phy));
> -	ut_assertok(generic_setup_phy(parent, &phy, 3));
> +	ut_assertok(generic_setup_phy(parent, &phy, 3, PHY_MODE_USB_HOST, 0));
>   	ut_assertok(generic_shutdown_phy(&phy));
>   
>   	return 0;

-- 
// Caleb (they/them)
