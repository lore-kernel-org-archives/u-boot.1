Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E954CE8D68
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 17:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA916842A1;
	Fri, 14 Nov 2025 18:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YM9ikfNP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BBFD83EAC; Fri, 14 Nov 2025 05:41:59 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C88E783E86
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 05:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=geraldogabriel@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-ba2450aba80so915370a12.1
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 20:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763095315; x=1763700115; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jYITvpqCiW1DtaQqw+zoQjW9fGy8Lts1f9UcjxkD50s=;
 b=YM9ikfNPt1yPCVy8ZCN+RHY9yxyMRsbUdvP4vvwgLCLDF8ixbFr9/tKGLL10pvvEZg
 bMw6MGXrEsfZZ2bxkYWNBpzJP+FrkUv7f1/AIZK3yEcP5vZ2PyNt3W4CZRiOz8D2G1LW
 ZBX50dCiQ1mSM1ut26v0dMu4yEdKS6KudhdckgO4ZnHcGINReDAgB1efQ4nHCinGO9bt
 mqsbzXfamwLY9uPAT9XeJtaKvTF2vSLijAh00/NNqL88N8bifh7S8hjVT0VZNRTxZlB7
 uQjvbDjmg4hm0Oox4Tgf5QH1lA4kdqSuXi/Iw9aLcgTDJli2jPkE3P0c5IkzB21BllNz
 zIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763095315; x=1763700115;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYITvpqCiW1DtaQqw+zoQjW9fGy8Lts1f9UcjxkD50s=;
 b=kbX6dzgcDpkm/Ms91uGbaLVsLvhBt5r+d602Gb2XcIGHt8x6jhshzd1jbxt8adA1vc
 GxFggGiu7Takj9kD/ER8XZ2XT4t/b+YPD1qiisZxKXXFMNVoF/hHbDLRvpnte7UCVbbq
 zp5GCOM87IG+c53ULVCdA3BgqWGJYfciIIQFFqXINCnYrct6Xs5Owhof/MKDGrUC1DeX
 DIW0TOQSBY5Jye9Tek98HlexelXzzt73ef6c3jh7Y7U52KNiSy0sb1TBJarWTORpvaDb
 0R6dD80HOOBNcLM0bqPuV69LIVZo9RbE37MXtuEBX247Gs8OIhaxEQ6I/aPIcHY/2LT5
 ssHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwQcbkTO1zKcWNeJsnZQeh3rjFwUaUo1e/gLiDZzI1CMdU0l8OlZt+zJ2LNdcQGtuDOTXupiM=@lists.denx.de
X-Gm-Message-State: AOJu0YzikP2Xzo3RGMNPJ74vBrvnL6cnjlxCQuTo62ffUc8jzoHEkU92
 jVCyVW2S6/NBFAaONyFXz9A+vTdnqhIdWeoOJ1+T67qhypIiRA5T0De4
X-Gm-Gg: ASbGncusxP0COo+uthDe8OYGUrER/l5IeFb90GimQwZxzPobH37suSDoF1TMZx8zyYY
 NUqSqPh7Xek+Y1+knUvZcbxfK7OqD39mxW6Kd398hunK1aWyJ43Mr+jZCz6GerMato1hs+V1vau
 DQNamk7r41hRnso2QipCATD4P/78uX0u9oK9lw1Z0M6VZGISr22yPpgSprhEK4mCa/UFopjIcq1
 Xg6HUm819ULfizH43W5pl4IXyj8Xvwb4kiOIDgSbGeraoJLX3MGw0pZW/JcY66GrxttqDWprL8p
 GPrxZvs7xggTh4tBal7NSjq8log17BYUipv4wBZelgHAvm8DSPHzMc3EUs3vrKNirmyUxYhx5cP
 gICKk44+HtnYuApehJ2R40G95+DRMlth+4NBp9dpVgb8eJwTJ5eRJkG7HLGfDhYo+A9kUzoMfWv
 D0ZlAv2rPg
X-Google-Smtp-Source: AGHT+IEYHLOamGM5/rhDQ8pIrx2agy7W4DgZWwY06i1uk7cuxizAxZJhIaEBAx3eQH7DJBOHIqA7NQ==
X-Received: by 2002:a05:7022:5f09:b0:119:e56b:989c with SMTP id
 a92af1059eb24-11b40f82b10mr512024c88.3.1763095314813; 
 Thu, 13 Nov 2025 20:41:54 -0800 (PST)
Received: from geday ([2804:7f2:8082:36cd::1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b060885cdsm5676123c88.6.2025.11.13.20.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 20:41:53 -0800 (PST)
Date: Fri, 14 Nov 2025 01:41:46 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: =?utf-8?B?5byg54Oo?= <ye.zhang@rock-chips.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci <linux-pci@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
 Johan Jonker <jbx6244@gmail.com>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <aRazCssWVdAOmy7D@geday>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
 <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
 <aQ1c7ZDycxiOIy8Y@geday>
 <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
 <aRLEbfsmXnGwyigS@geday>
 <AGsAmwCFJj0ZQ4vKzrqC84rs.3.1762847224180.Hmail.ye.zhang@rock-chips.com>
 <aRQ_R90S8T82th45@geday> <aRUvr0UggTYkkCZ_@geday>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRUvr0UggTYkkCZ_@geday>
X-Mailman-Approved-At: Fri, 14 Nov 2025 18:51:51 +0100
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

On Wed, Nov 12, 2025 at 10:09:15PM -0300, Geraldo Nascimento wrote:
> Hi Ye, Shawn,
> 
> Here's more contained workaround without resorting to clearing DDR to
> INPUT for every GPIO:
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index ee1822ca01db..1d89131ec6ac 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -315,7 +315,8 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  			    PCIE_CLIENT_CONFIG);
>  
>  	msleep(PCIE_T_PVPERL_MS);
> -	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
> +	gpiod_direction_input(rockchip->perst_gpio);
> +	gpiod_direction_output(rockchip->perst_gpio, 1);
>  
>  	msleep(PCIE_RESET_CONFIG_WAIT_MS);
>  
> This results in working PCIe for me, pass initial link training.

Sorry for the inconvenience of more mail, but I'm providing as much
detail as I can.

This hack has been confirmed to work in U-boot also.

diff --git a/drivers/pci/pcie_rockchip.c b/drivers/pci/pcie_rockchip.c
index 19f9e58a640..5702b607ee6 100644
--- a/drivers/pci/pcie_rockchip.c
+++ b/drivers/pci/pcie_rockchip.c
@@ -329,8 +329,10 @@ static int rockchip_pcie_init_port(struct udevice *dev)
 	writel(PCIE_CLIENT_LINK_TRAIN_ENABLE,
 	       priv->apb_base + PCIE_CLIENT_CONFIG);
 
-	if (dm_gpio_is_valid(&priv->ep_gpio))
-		dm_gpio_set_value(&priv->ep_gpio, 1);
+	if (dm_gpio_is_valid(&priv->ep_gpio)) {
+		dm_gpio_set_dir_flags(&priv->ep_gpio, (priv->ep_gpio.flags & ~GPIOD_IS_OUT) | GPIOD_IS_IN);
+		dm_gpio_set_dir_flags(&priv->ep_gpio, (priv->ep_gpio.flags & ~GPIOD_IS_IN) | GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+	}
 
 	ret = readl_poll_sleep_timeout
 			(priv->apb_base + PCIE_CLIENT_BASIC_STATUS1,

So my report suggests this is not specific to Linux and because same
workaround works in U-boot simplified driver model I suggest you check
from your side.

Previously PCIe link training timeout, not working. Now I'm very happy
with working PCIe in Linux and U-boot.

Thanks,
Geraldo Nascimento
