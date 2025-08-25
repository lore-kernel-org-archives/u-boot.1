Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F49ACA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 14:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88CA383096;
	Mon, 25 Aug 2025 16:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sima.ai header.i=@sima.ai header.b="Z79vGXsd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB82C8309D; Mon, 25 Aug 2025 15:57:38 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFBFD83043
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikunj.kela@sima.ai
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-771ed4a839eso40948b3a.2
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sima.ai; s=google; t=1756130254; x=1756735054; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gnSCTVgUUqKVy2JFEWGEOf2Cv/OVaDx74fzSGiymRT8=;
 b=Z79vGXsdNCP30VuL5/nLr88MsF9Gi52lZL64E09oZgY5AjMEVhIx0J25OYLHRMpJYP
 GTS18Csi68fawQr1k/SAm1XbyDe5bRwKsi7ikSQGT/CX68uQvDhmvFSFhW5jyjNCefe0
 I79DIaEDrOWhW5coDZIXSit54XXmdamXzGKJQ02suQ6zN2ZysG64iymY8BQqNq9ohv5X
 gpILrAkG2Vpgmi6o3gfO7q8U2cIurIu0alyWwIzXedBABrkP6iur+Nj626Bi+A/T+HtY
 zzUzTkcMPlD1HpLGhhsw8wGW2Y2f8VWSUcdj9PAfNqdZIA+sImlIyWCbsxae4RAxPDIw
 1Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756130254; x=1756735054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gnSCTVgUUqKVy2JFEWGEOf2Cv/OVaDx74fzSGiymRT8=;
 b=JKhBHGxJP1O97twPhaWhes838MQvIpGW26ugqnYh3KTi0dkd7Tc3m/eZHwrKmpmqyG
 rLUJ4jz6OLZxA2lKbtatlJX7XvQfaSiw6s13Qgbyhfz9gr/le3W92w93YxvUcc1esOhX
 O7SOJPYGqVCsm8N9nHGl+XqlcVaVlVVv5DXjgu0ixvieo4daYpw7Yv6ihwV6szrDrAB1
 JHXR4El2XkHk7kaolbrxtaqSLM7kqhqo55uRCfhO549lFh31NEmI88qWD6JdDUHiPufR
 lU/VbKRahtWPrtqQODa+p2NxafRCFbPb3d7BkG/sNRBZyEqS8ZAmf0iIWeX72AjlYFZf
 +Daw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2lpjs3N3oHBGG7Nq48IbeDakpsiEqrF1LpGaAaV9VIOrGy8CdPOa7gUZev/qotLTzy/BJg/o=@lists.denx.de
X-Gm-Message-State: AOJu0YxDxkRLeyQuJGseNov4+6Jg5Uyu/cF5+WDGr8Hz1H2uNxBfjPOe
 /vXDfzJFFBU3alwNLyppbF6PZIF0O7gjtlkAXAZzUuPFUdTJ9AFZ1rULUjPWgLF8tYE=
X-Gm-Gg: ASbGncshradqMhMDa4iz9Hgr6yryu91ObPxJ4gGHfcaCY4u9mteXnmfXqSUibXBeO9Q
 MWxdru/Z2KQhyLMC6xXIfvUiOSdAqGveHdloQiPl8PtOYo9c5I7jgQWe97GsaGgMaoodXK82c/q
 55Rwfh8kJHjCKBja7iGKshKYMdin+TSFeBtyl95AyfLVUraYyy8jeymRb7My8JkqBriu69fpn56
 rNxPeWkYSaSmKVfrr0d8CkCClnvvzCeM9aH78scR8r1j/7SRcq8YdyWGzV+58VpE4llHhPSInVp
 dJ9dZd4DEAswrE85ZsLxXwngsUsOEtcDwaKAdsOasaTZay62RxoAY/21+7+OatM8M6X5p8iMPRd
 A+YMKR/ne24OOaNBLdZzQamGCa+qXyByFRVbVDI6SQxLoZZNENw==
X-Google-Smtp-Source: AGHT+IH6qhkR+YOEvvuY338MxtvXAd3XZD8iVvRYsd/Auq+jR0/QRm4k9Qb5ffzxgpSjZKZOdxrGbA==
X-Received: by 2002:a05:6a20:729a:b0:240:4400:838d with SMTP id
 adf61e73a8af0-24340e06856mr10410186637.5.1756130254236; 
 Mon, 25 Aug 2025 06:57:34 -0700 (PDT)
Received: from [172.16.1.17] ([45.62.187.227])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm428601b3a.93.2025.08.25.06.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 06:57:33 -0700 (PDT)
Message-ID: <c186daa2-2ad4-4a7b-9729-e6a3329b968a@sima.ai>
Date: Mon, 25 Aug 2025 06:57:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: xgmac: Augment mdio read/write with cl-45 format
 support
To: joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com,
 boon.khai.ng@altera.com
Cc: tien.fong.chee@intel.com, boon.khai.ng@intel.com, u-boot@lists.denx.de
References: <20250510041200.2552981-1-nikunj.kela@sima.ai>
Content-Language: en-US
From: Nikunj Kela <nikunj.kela@sima.ai>
In-Reply-To: <20250510041200.2552981-1-nikunj.kela@sima.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 25 Aug 2025 16:29:49 +0200
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

Gentle Reminder..

On 5/9/25 9:12 PM, Nikunj Kela wrote:
> Currently, clause-22 format is supported. This change adds
> support for clause-45 format.
>
> Signed-off-by: Nikunj Kela <nikunj.kela@sima.ai>
> ---
>   drivers/net/dwc_eth_xgmac.c | 67 +++++++++++++++++++++++++++----------
>   1 file changed, 49 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
> index 03959ea95a5..68c69b7b3df 100644
> --- a/drivers/net/dwc_eth_xgmac.c
> +++ b/drivers/net/dwc_eth_xgmac.c
> @@ -147,6 +147,7 @@ static int xgmac_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
>   	u32 val;
>   	u32 hw_addr;
>   	int ret;
> +	u32 c45 = 1;
>   
>   	debug("%s(dev=%p, addr=0x%x, reg=%d):\n", __func__, xgmac->dev, mdio_addr,
>   	      mdio_reg);
> @@ -159,19 +160,34 @@ static int xgmac_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
>   		return ret;
>   	}
>   
> -	/* Set clause 22 format */
> -	val = BIT(mdio_addr);
> -	writel(val, &xgmac->mac_regs->mdio_clause_22_port);
> +	if (mdio_devad == MDIO_DEVAD_NONE) {
> +		/* Set clause 22 format */
> +		c45 = 0;
> +		val = BIT(mdio_addr);
> +		writel(val, &xgmac->mac_regs->mdio_clause_22_port);
> +	} else {
> +		val = readl(&xgmac->mac_regs->mdio_clause_22_port);
> +		val &= ~BIT(mdio_addr);
> +		writel(val, &xgmac->mac_regs->mdio_clause_22_port);
> +	}
>   
> -	hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
> -		   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
> +	if (c45) {
> +		hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
> +			   (mdio_reg & 0xffff);
> +		hw_addr |= mdio_devad << XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
> +	} else {
> +		hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
> +			   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
> +	}
>   
>   	val = xgmac->config->config_mac_mdio <<
>   	      XGMAC_MAC_MDIO_ADDRESS_CR_SHIFT;
>   
> -	val |= XGMAC_MAC_MDIO_ADDRESS_SADDR |
> -	       XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_READ |
> -	       XGMAC_MAC_MDIO_ADDRESS_SBUSY;
> +	if (!c45)
> +		val |= XGMAC_MAC_MDIO_ADDRESS_SADDR;
> +
> +	val |= XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_READ |
> +		XGMAC_MAC_MDIO_ADDRESS_SBUSY;
>   
>   	ret = xgmac_mdio_wait_idle(xgmac);
>   	if (ret) {
> @@ -207,6 +223,7 @@ static int xgmac_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
>   	u32 val;
>   	u32 hw_addr;
>   	int ret;
> +	u32 c45 = 1;
>   
>   	debug("%s(dev=%p, addr=0x%x, reg=%d, val=0x%x):\n", __func__, xgmac->dev,
>   	      mdio_addr, mdio_reg, mdio_val);
> @@ -219,21 +236,35 @@ static int xgmac_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
>   		return ret;
>   	}
>   
> -	/* Set clause 22 format */
> -	val = BIT(mdio_addr);
> -	writel(val, &xgmac->mac_regs->mdio_clause_22_port);
> -
> -	hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
> -		   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
> +	if (mdio_devad == MDIO_DEVAD_NONE) {
> +		c45 = 0;
> +		/* Set clause 22 format */
> +		val = BIT(mdio_addr);
> +		writel(val, &xgmac->mac_regs->mdio_clause_22_port);
> +	} else {
> +		val = readl(&xgmac->mac_regs->mdio_clause_22_port);
> +		val &= ~BIT(mdio_addr);
> +		writel(val, &xgmac->mac_regs->mdio_clause_22_port);
> +	}
>   
> -	hw_addr |= (mdio_reg >> XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) <<
> -		    XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
> +	if (c45) {
> +		hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
> +			   (mdio_reg & 0xffff);
> +		hw_addr |= mdio_devad << XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
> +	} else {
> +		hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
> +			   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
> +		hw_addr |= (mdio_reg >> XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) <<
> +			    XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
> +	}
>   
>   	val = (xgmac->config->config_mac_mdio <<
>   	       XGMAC_MAC_MDIO_ADDRESS_CR_SHIFT);
>   
> -	val |= XGMAC_MAC_MDIO_ADDRESS_SADDR |
> -		mdio_val | XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_WRITE |
> +	if (!c45)
> +		val |= XGMAC_MAC_MDIO_ADDRESS_SADDR;
> +
> +	val |=	mdio_val | XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_WRITE |
>   		XGMAC_MAC_MDIO_ADDRESS_SBUSY;
>   
>   	ret = xgmac_mdio_wait_idle(xgmac);
