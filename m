Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA92AC4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 00:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BBFD86FD0;
	Sun,  5 Nov 2023 01:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jG/vaHgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2559786FD0; Sun,  5 Nov 2023 01:10:33 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C304E86FA7
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 01:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6d319933f9fso1988200a34.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 17:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699143021; x=1699747821; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sTB4KPpTJ4Gk6xrQjIj4AcrSRtKUm7iByD7Jg91sClo=;
 b=jG/vaHgPVrPVvHN9/1F7JvmUCmA3iUUa5w8KEiEyP3xYtXHnf3s/hmxumXFBhrI8U0
 ucFRVs1sTvtolNFOqLzbT7rYBqtxI+y5jR+aRdYgrDSQGPK+PcWm1sl43gXtC8L/XENs
 ohCnWyAX0uzQqTpSZpDpCkZWsSSv+1oH2ZN3vj+9pzHrGcAqm8b4h297PNjDfZcUAsKR
 GKS5tGRmKQqsx32bXWyo286IwW1I60D7+5dGJofbWsul5/Afl0DO/VwylLagoay7TwFm
 OLutKGzuVFey0u0H+KcVMa6nwcDhzY4BgjHdjZkeaULmdVUR0bn4jM8fbIbIOF75KKAq
 kbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699143021; x=1699747821;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sTB4KPpTJ4Gk6xrQjIj4AcrSRtKUm7iByD7Jg91sClo=;
 b=PKZxbGXKazbZdBcCQk3GSKvqz2OCIxV5g4Kh8QlIvPKuajqdXLlY9o3zsrBbc/RDq5
 o++2qCahl4pFI/spHbKBdDzlGlPE0rofT1hOYCwlZZZVhIkkjf4FjRCgQMYtfqp4kYcv
 G0v4w6BLiZqzPDGheCP1gF87CrCiNq5KDoFGYMXfqNePIcBJ6e+7FOO8ThrmmZ+XwLEA
 WE53GD3EVLARelGmHMuPMhX4mB2NmXdfJ2H0z/nD2X3cBInoXZZEwwyo4GO+bBxJWfBh
 Ao5l0CoVMfK0GREYACMpxScoAfc4/2NOpOK5V4xVoWAGqfklIvWrGz3laouRbcJn6Z0a
 8Syg==
X-Gm-Message-State: AOJu0YwSf2Xzk+hPnj/EruHGiTVmQIkitA5gfGzB+V2C3CdLpnMRE8He
 6JO7DygHiWQqTrSrZj9m+8w=
X-Google-Smtp-Source: AGHT+IGla3E12gwCxoM5ECxc/9XXzJlpZC/W5tX/E/uMXaGUd/+OEnQfc49ibP+PAWajh1d/GVSLBQ==
X-Received: by 2002:a05:6808:98b:b0:3a8:75f8:540a with SMTP id
 a11-20020a056808098b00b003a875f8540amr24718511oic.44.1699143020944; 
 Sat, 04 Nov 2023 17:10:20 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 k6-20020ad44206000000b00668eb252523sm2056391qvp.63.2023.11.04.17.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 17:10:20 -0700 (PDT)
Message-ID: <b0f8fa1e-2e0a-fd5d-6c50-b00b37618cdc@gmail.com>
Date: Sat, 4 Nov 2023 20:10:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: imx8mp: Inhibit DTC warning on DH i.MX8MP DHCOM
 rev.100 DTO
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
References: <20231105000440.273177-1-marex@denx.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231105000440.273177-1-marex@denx.de>
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

On 11/4/23 20:04, Marek Vasut wrote:
> Inhibit DTC warning in imx8mp-dhcom-pdk3-overlay-rev100.dts:
> "
> arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtbo: Warning (reg_format): /fragment@0/__overlay__:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtbo: Warning (avoid_default_addr_size): /fragment@0/__overlay__: Relying on default #address-cells value
> arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtbo: Warning (avoid_default_addr_size): /fragment@0/__overlay__: Relying on default #size-cells value
> "
> 
> The DTO overwrites the 'reg' property of an ethernet PHY and is only
> used on specific combination of old prototype SoM and old prototype
> PDK3 carrier board, which had incorrectly placed pull resistor, which
> made the PHY change its MDIO address in that specific combination and
> which is already fixed on production hardware.
> 
> The DTO is implemented in this simple manner because if it contained a
> full MDIO bus node reference to define #address-cells and #size-cells,
> it would also require a full new copy of the PHY node, i.e.
> ethernet-phy@5 { ... reg = <5>; ... }, to avoid DTC warnings about
> mismatch between node unit and reg value. The node unit in SoM DT is
> ethernet-phy@7 { ... }; .
> 
> This simpler approach avoids unnecessary duplication without adverse
> side effects.
> 
> Reported-by: Fabio Estevam <festevam@denx.de>
> Reported-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: u-boot@dh-electronics.com
> ---
>   arch/arm/dts/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 66862a70be1..70845c7ac8c 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1481,6 +1481,8 @@ targets += $(dtb-y)
>   # Add any required device tree compiler flags here
>   DTC_FLAGS += -a 0x8
>   
> +DTC_FLAGS_imx8mp-dhcom-pdk3-overlay-rev100 += -Wno-avoid_default_addr_size -Wno-reg_format
> +
>   PHONY += dtbs
>   dtbs: $(addprefix $(obj)/, $(dtb-y))
>   	@:

Tested-by: Sean Anderson <seanga2@gmail.com>
