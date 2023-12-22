Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0F0C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 11:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B667877F1;
	Fri, 22 Dec 2023 12:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="DTua/zWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF84F876FC; Fri, 22 Dec 2023 12:47:03 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 557A1877F1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 12:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5534d8fcf7bso2086930a12.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 03:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1703245621; x=1703850421; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WoGK8inAt0qESbYw3F5cqyXNhfvswyUpojK9kGcKQes=;
 b=DTua/zWGXMR8/pWhacl37KVKVsX/zIMcYOhkTY0+5oHjU3CIx9D9o14+EeApSbIS7V
 /DsrIk4Arh7S5/xo+qFZ1LEXfIST+O3yKcAKl3bkaIPutzLQ3KYDpIarhUSq7LNxwqlp
 rrywbTUEPYSJj4iFfIneryKkUKYpxl5jYeQ3wQEUonQSZPaEWqhvzUiH4odzYPcYGmUA
 jFc/ueaLF4EZx6Bfa/zPlgg9zLklvfiCEQYILF1NMnNLmlpSqcaeVs60C9SeMpbcUDLx
 +PwmjXXTlexo7KTXAm8qpl95BB1HaqK7KK7Jo7mMuE6IdIM0MamNtPc24fxtU+uITIlE
 lCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703245621; x=1703850421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WoGK8inAt0qESbYw3F5cqyXNhfvswyUpojK9kGcKQes=;
 b=I/Ivh0/iHGG2DXud+9XBCn+OD5oCK3n83McN10fIsncM/m0LEjK+deHipconoqADMA
 jrbmWrKM3QdXQRmGCMfd8mOUbxKLWmM+p6d1ssYuPFanUMC04bamdgYtWLdeXozgA9lU
 y7dYcz/Ku0jSSFNzaEyoXxfTGlI4DO5FxQ1/XgSk72HS8pp3BQMaqFsmts6DgkDOe1L6
 c44nJRbedrziu4EUXl3VWo2WmqISw4X0QIvZHrAmjQ6Iguhr5EyDrrRKrRXM/9r93FZA
 yjbPZSIqffbrbcDThd/zmJ3RYDkAfcLFZiJjf0VB4nSNCzAo85bElwpR5/FKKQcEQS2P
 pSFA==
X-Gm-Message-State: AOJu0YzTD++rbyKhzJndf5hYpe00Rz+sQs3U+0n9YBWeTZRn2rW5uKp5
 ToHEqZGvjXW1Sz5u5tamHkUorRZgy7YD/w==
X-Google-Smtp-Source: AGHT+IEdSuWQ8qNXrFip2V2Ifa0XUkBuZ+lvMTr1T7dRBavb58lzZJyyokkoAeayqR0qBN9O7BCY+w==
X-Received: by 2002:a50:cc81:0:b0:553:2b04:14a2 with SMTP id
 q1-20020a50cc81000000b005532b0414a2mr480005edi.14.1703245620799; 
 Fri, 22 Dec 2023 03:47:00 -0800 (PST)
Received: from ?IPV6:2a02:810d:8400:17a8:8ea:59af:d317:9dff?
 ([2a02:810d:8400:17a8:8ea:59af:d317:9dff])
 by smtp.gmail.com with ESMTPSA id
 a5-20020aa7cf05000000b005537e39745csm2490378edy.47.2023.12.22.03.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Dec 2023 03:47:00 -0800 (PST)
Message-ID: <b085c2ec-85d1-4255-83af-8cdfcfb40896@suse.com>
Date: Fri, 22 Dec 2023 12:46:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] pci: pcie-brcmstb: Add bcm2712 PCIe controller
 support
Content-Language: en-US, ca-ES, es-ES
To: "Ivan T. Ivanov" <iivanov@suse.de>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-8-iivanov@suse.de>
From: Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20231218210341.30073-8-iivanov@suse.de>
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



On 18/12/2023 22:03, Ivan T. Ivanov wrote:
> PCIe controller have minor register map difference compared
> to bcm2711 variant. Handle this using device specific register
> offset.
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   drivers/pci/pcie_brcmstb.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
> index cd45f0bee9..d63e715b2e 100644
> --- a/drivers/pci/pcie_brcmstb.c
> +++ b/drivers/pci/pcie_brcmstb.c
> @@ -90,7 +90,6 @@
>   #define PCIE_MEM_WIN0_LIMIT_HI(win)	\
>   	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
>   
> -#define PCIE_MISC_HARD_PCIE_HARD_DEBUG			0x4204
>   #define  PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
>   
>   #define PCIE_MSI_INTR2_CLR				0x4508
> @@ -131,6 +130,10 @@
>   #define SSC_STATUS_PLL_LOCK_MASK			0x800
>   #define SSC_STATUS_PLL_LOCK_SHIFT			11
>   
> +struct pcie_cfg_data {
> +	unsigned long hard_debug_offs;
> +};
> +
>   /**
>    * struct brcm_pcie - the PCIe controller state
>    * @base: Base address of memory mapped IO registers of the controller
> @@ -141,6 +144,7 @@
>   struct brcm_pcie {
>   	void __iomem		*base;
>   
> +	struct pcie_cfg_data	*cfg;
>   	int			gen;
>   	bool			ssc;
>   };
> @@ -458,7 +462,7 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	/* Take the bridge out of reset */
>   	clrbits_le32(base + PCIE_RGR1_SW_INIT_1, RGR1_SW_INIT_1_INIT_MASK);
>   
> -	clrbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
> +	clrbits_le32(base + pcie->cfg->hard_debug_offs,
>   		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
>   
>   	/* Wait for SerDes to be stable */
> @@ -599,7 +603,7 @@ static int brcm_pcie_remove(struct udevice *dev)
>   	setbits_le32(base + PCIE_RGR1_SW_INIT_1, RGR1_SW_INIT_1_PERST_MASK);
>   
>   	/* Turn off SerDes */
> -	setbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
> +	setbits_le32(base + pcie->cfg->hard_debug_offs,
>   		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
>   
>   	/* Shutdown bridge */
> @@ -620,6 +624,8 @@ static int brcm_pcie_of_to_plat(struct udevice *dev)
>   	if (!pcie->base)
>   		return -EINVAL;
>   
> +	pcie->cfg = (struct pcie_cfg_data *)dev_get_driver_data(dev);
> +
>   	pcie->ssc = ofnode_read_bool(dn, "brcm,enable-ssc");
>   
>   	ret = ofnode_read_u32(dn, "max-link-speed", &max_link_speed);
> @@ -636,8 +642,17 @@ static const struct dm_pci_ops brcm_pcie_ops = {
>   	.write_config	= brcm_pcie_write_config,
>   };
>   
> +static const struct pcie_cfg_data bcm2711_cfg = {
> +	.hard_debug_offs	= 0x4204
> +};
> +
> +static const struct pcie_cfg_data bcm2712_cfg = {
> +	.hard_debug_offs	= 0x4304
> +};
> +
>   static const struct udevice_id brcm_pcie_ids[] = {
> -	{ .compatible = "brcm,bcm2711-pcie" },
> +	{ .compatible = "brcm,bcm2711-pcie", .data = (ulong)&bcm2711_cfg },
> +	{ .compatible = "brcm,bcm2712-pcie", .data = (ulong)&bcm2712_cfg },
>   	{ }
>   };
>   
