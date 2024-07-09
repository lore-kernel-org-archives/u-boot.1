Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7F3C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD46187B77;
	Tue,  9 Jul 2024 11:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tEOL82kl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 188F2884FF; Tue,  9 Jul 2024 11:20:25 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8813883AC
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2eaae2a6dc1so71048221fa.0
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720516822; x=1721121622;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=F51ho0h1Duz9Tz/Y9ywizR/3mZ+s3dScnrJmX8EFXkQ=;
 b=tEOL82kldtyj7KVnikY0U/FxEw3OQhNdF934p8CPDE/c4rAuinX91v1EweGyOgD5tO
 02X1VTM8ZIIMyCc0xRv7MKzYCpDivhMawZe2795z6WMBLiHrowi4o9O82TJtUIMMVf//
 GQ3hfzLjcfubiEZ6bb0LfeBS5X/SCop32Qq7nc1jkTETqlp7avdyFzxfmkcE33pp63dc
 r/5rcLDf4C4pErIbEWz3/HJXvbzIeBKUmrI1dKZ+7O7qOAS9TOW+44jNrL7sIMmNh4x6
 P9S/1W2/MvNCKe4AGXxVEc/6eWTKpwedrWb1nGy5ZZmBE260w3Ql8wWkxGBHcYAN/wA4
 +w/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720516822; x=1721121622;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F51ho0h1Duz9Tz/Y9ywizR/3mZ+s3dScnrJmX8EFXkQ=;
 b=IRCKAPN+kOVPsYTmSHQUYF6YeeuFy7rpCIER0517/pPsreen5BDsuVwShzwgO/NbMf
 bKiQO0WgN6NdfAPR/at/MtDi1qc1IjwW08UBEHlUEM3tnvPdFyfJRf21e+xQwxGWwpxl
 RPe20Z4h2iDX5I/iXlyvuZTr1q9xUraVOWv2muUO7z3KdKjl88nMCoQjUaB9OG1PcrkY
 wJPJKU4AObZm24kUf5Qmd1soXMdfrG6nky1fo8A8SJueNsDkeC1Zpd8yFDlJSKRn3Toj
 1h0Z0jjJMngveIm5P5zDT3qnYIkU4Kw9mOIcRoBg0NFG7T2FENmNJV5Mu8ZEnqHI6V81
 Sbaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcYZXTQu4h8y3Uy9uWXvdOH3PAjo18wvX+X8vEUrCcolDrwGOCZcAht/qx8Nx7MtH4llA1T5AMx3lmlrjStvM8OMoO9w==
X-Gm-Message-State: AOJu0YwKSQPLjQ+4u+dhDEgT5E5Vf3UZnf0COn8abe9mTuWoce88tFKP
 otbgmgN7bdRVb7UsYQw0Srww4hQZ3oA0QOZUKlj92Y31i9wSuY1QoFmi+756O68=
X-Google-Smtp-Source: AGHT+IF3iKomzKMTeI3ZCXjrrLoqT60NsIU/FH5yIe//qt/p+k3R7aGSjR4CieC0/D0qzaRrM8V4WQ==
X-Received: by 2002:a2e:a4ad:0:b0:2ee:5ed4:7930 with SMTP id
 38308e7fff4ca-2eeb316afaemr16410321fa.37.1720516821737; 
 Tue, 09 Jul 2024 02:20:21 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa06f4sm1965066f8f.89.2024.07.09.02.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:20:21 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Fabio Estevam <festevam@gmail.com>, Fabrice
 Gasnier <fabrice.gasnier@foss.st.com>, Jonas Karlman <jonas@kwiboo.se>,
 Mathieu Othacehe <othacehe@gnu.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Tim Harvey
 <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, Xavier Drudis
 Ferran <xdrudis@tinet.cat>, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 1/3] phy: Extend generic_setup_phy() with PHY mode
 and submode
In-Reply-To: <20240617173740.80822-1-marek.vasut+renesas@mailbox.org>
References: <20240617173740.80822-1-marek.vasut+renesas@mailbox.org>
Date: Tue, 09 Jul 2024 11:20:18 +0200
Message-ID: <87sewij50t.fsf@baylibre.com>
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

Hi Marek,

Thank you for the patch.

On lun., juin 17, 2024 at 19:36, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

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
> V2: Add failpath to return errno from generic_phy_set_mode()
> ---
>  drivers/phy/phy-uclass.c        | 13 +++++++++++--
>  drivers/usb/host/ehci-generic.c |  2 +-
>  drivers/usb/host/ehci-msm.c     |  2 +-
>  drivers/usb/host/ehci-mx6.c     |  2 +-
>  drivers/usb/host/ehci-pci.c     |  2 +-
>  drivers/usb/host/ohci-generic.c |  2 +-
>  include/generic-phy.h           |  5 ++++-
>  test/dm/phy.c                   |  8 ++++----
>  8 files changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
> index acdcda15b5b..777d952b041 100644
> --- a/drivers/phy/phy-uclass.c
> +++ b/drivers/phy/phy-uclass.c
> @@ -508,7 +508,8 @@ int generic_phy_power_off_bulk(struct phy_bulk *bulk)
>  	return ret;
>  }
>  
> -int generic_setup_phy(struct udevice *dev, struct phy *phy, int index)
> +int generic_setup_phy(struct udevice *dev, struct phy *phy, int index,
> +		      enum phy_mode mode, int submode)
>  {
>  	int ret;
>  
> @@ -520,10 +521,18 @@ int generic_setup_phy(struct udevice *dev, struct phy *phy, int index)
>  	if (ret)
>  		return ret;
>  
> +	ret = generic_phy_set_mode(phy, mode, submode);
> +	if (ret)
> +		goto phys_mode_err;
> +
>  	ret = generic_phy_power_on(phy);
>  	if (ret)
> -		generic_phy_exit(phy);
> +		goto phys_mode_err;
> +
> +	return 0;
>  
> +phys_mode_err:
> +	generic_phy_exit(phy);
>  	return ret;
>  }
>  
> diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/ehci-generic.c
> index 23c3ed25554..1ae3619ce25 100644
> --- a/drivers/usb/host/ehci-generic.c
> +++ b/drivers/usb/host/ehci-generic.c
> @@ -94,7 +94,7 @@ static int ehci_usb_probe(struct udevice *dev)
>  	if (err)
>  		goto reset_err;
>  
> -	err = generic_setup_phy(dev, &priv->phy, 0);
> +	err = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_HOST, 0);
>  	if (err)
>  		goto regulator_err;
>  
> diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
> index a081f71b187..b0c060b8173 100644
> --- a/drivers/usb/host/ehci-msm.c
> +++ b/drivers/usb/host/ehci-msm.c
> @@ -56,7 +56,7 @@ static int ehci_usb_probe(struct udevice *dev)
>  	hcor = (struct ehci_hcor *)((phys_addr_t)hccr +
>  			HC_LENGTH(ehci_readl(&(hccr)->cr_capbase)));
>  
> -	ret = generic_setup_phy(dev, &p->phy, 0);
> +	ret = generic_setup_phy(dev, &p->phy, 0, PHY_MODE_USB_HOST, 0);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
> index 31cd8a50f4a..a93fa5d5455 100644
> --- a/drivers/usb/host/ehci-mx6.c
> +++ b/drivers/usb/host/ehci-mx6.c
> @@ -703,7 +703,7 @@ static int ehci_usb_probe(struct udevice *dev)
>  	usb_phy_enable(ehci, priv->phy_addr);
>  #endif
>  #else
> -	ret = generic_setup_phy(dev, &priv->phy, 0);
> +	ret = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_HOST, 0);
>  	if (ret)
>  		goto err_regulator;
>  #endif
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index 572686580cd..8d05b14e898 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -30,7 +30,7 @@ static int ehci_pci_init(struct udevice *dev, struct ehci_hccr **ret_hccr,
>  	int ret;
>  	u32 cmd;
>  
> -	ret = generic_setup_phy(dev, &priv->phy, 0);
> +	ret = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_HOST, 0);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
> index f1325cd4953..cc44226f5e0 100644
> --- a/drivers/usb/host/ohci-generic.c
> +++ b/drivers/usb/host/ohci-generic.c
> @@ -50,7 +50,7 @@ static int ohci_usb_probe(struct udevice *dev)
>  		goto reset_err;
>  	}
>  
> -	err = generic_setup_phy(dev, &priv->phy, 0);
> +	err = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_HOST, 0);
>  	if (err)
>  		goto reset_err;
>  
> diff --git a/include/generic-phy.h b/include/generic-phy.h
> index eaab7491660..47962023236 100644
> --- a/include/generic-phy.h
> +++ b/include/generic-phy.h
> @@ -415,10 +415,13 @@ int generic_phy_power_off_bulk(struct phy_bulk *bulk);
>   * @dev:	The consumer device.
>   * @phy:	A pointer to the PHY port
>   * @index:	The index in the list of available PHYs
> + * @mode:	PHY mode
> + * @submode:	PHY submode
>   *
>   * Return: 0 if OK, or negative error code.
>   */
> -int generic_setup_phy(struct udevice *dev, struct phy *phy, int index);
> +int generic_setup_phy(struct udevice *dev, struct phy *phy, int index,
> +		      enum phy_mode mode, int submode);
>  
>  /**
>   * generic_shutdown_phy() - Power off and de-initialize phy.
> diff --git a/test/dm/phy.c b/test/dm/phy.c
> index d14117f6f7a..a90881b12ab 100644
> --- a/test/dm/phy.c
> +++ b/test/dm/phy.c
> @@ -243,20 +243,20 @@ static int dm_test_phy_setup(struct unit_test_state *uts)
>  					      "gen_phy_user", &parent));
>  
>  	/* normal */
> -	ut_assertok(generic_setup_phy(parent, &phy, 0));
> +	ut_assertok(generic_setup_phy(parent, &phy, 0, PHY_MODE_USB_HOST, 0));
>  	ut_assertok(generic_shutdown_phy(&phy));
>  
>  	/* power_off fail with -EIO */
> -	ut_assertok(generic_setup_phy(parent, &phy, 1));
> +	ut_assertok(generic_setup_phy(parent, &phy, 1, PHY_MODE_USB_HOST, 0));
>  	ut_asserteq(-EIO, generic_shutdown_phy(&phy));
>  
>  	/* power_on fail with -EIO */
> -	ut_asserteq(-EIO, generic_setup_phy(parent, &phy, 2));
> +	ut_asserteq(-EIO, generic_setup_phy(parent, &phy, 2, PHY_MODE_USB_HOST, 0));
>  	ut_assertok(generic_shutdown_phy(&phy));
>  
>  	/* generic_phy_get_by_index fail with -ENOENT */
>  	ut_asserteq(-ENOENT, generic_phy_get_by_index(parent, 3, &phy));
> -	ut_assertok(generic_setup_phy(parent, &phy, 3));
> +	ut_assertok(generic_setup_phy(parent, &phy, 3, PHY_MODE_USB_HOST, 0));
>  	ut_assertok(generic_shutdown_phy(&phy));
>  
>  	return 0;
> -- 
> 2.43.0
