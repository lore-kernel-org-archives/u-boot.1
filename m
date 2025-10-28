Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544BFCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D921783A2B;
	Tue, 28 Oct 2025 09:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KLUnTWuR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C103C83A2F; Tue, 28 Oct 2025 09:17:53 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 866D8839D6
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so3653620f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761639471; x=1762244271; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=aNHa2N6zAWv6SgDziVBmyxMvoQr3fNFPTOREXLvKgY8=;
 b=KLUnTWuRlCD3NNM1bNax9BozaFDMJz42zOCLJquZECq9ZafIkzJN4ux/mzS2fqmFMc
 FMGeA7duVG2ofJzdLoFEK/vI9h42jzX7c6X03O2xEDRvvtO9bNkxJ+Uvb7Rd9kQY7UPL
 xTErR51YJ2ja5rTv5zdhrurWfr5+Ee2wxYNBIfwiCgx2voIKcHaeHu7wdD6C+Q0gLFvN
 TSe+bWkAIgB48RWMvzjkyCtHQ/RCVFlAe7zvWSGKRbWF6b7kGikxLZ/sVuwlf3q+UBXl
 aKE/S9DcR/Mgby/NnWog4xwsep2lW+7FfGjU4y9Nuco4FU035rkA6hVdutN7LxPVjhT6
 +AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761639471; x=1762244271;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aNHa2N6zAWv6SgDziVBmyxMvoQr3fNFPTOREXLvKgY8=;
 b=vLWViXHVia84r67L8c/XJRgsVQB5qFzXSARDa92x3tdhnA+QphW/0mqoD/QPLpf8nu
 c7Sa0/HpO4vMk4MLLqyqi00ZhaO2jpHN3I54vHDuO+Ekp7gFXtEBO2H8DJ6nIWMfDJhz
 2wyqohCmfd1uFAdorAT06zv8sNldbLi/OQ0Ernp1CDZvPg5YUsZtqYxWeb0Fg5iRBRMi
 FflhccUDNddQSAPmjyAq5tfRTVxANyNnB3Dp0LfQb4M6vIzw7IlrOodS7wHxzuTzhLLt
 5F1E5ulCwQ05Y0FAJCavLnc28jF1c0UPOOwZZjgDAuf9i71+oU7HwLK381Qb0EdzJX+k
 NDsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmvyK6INnJ7W6h8sZBDLL6k8vKk6NrTbxGMYDr2vyw2xIB8TMIndtVVcLAj56QfCDJDRuxAJE=@lists.denx.de
X-Gm-Message-State: AOJu0YwY8anb9VWCoQEC3vHLMQegsWotzo+L+YcTsxYj/kn70qV08jDz
 6HEj4ipTSfjwQZM1s1va0yLDJc2GUVLNdb5phszppSkKNVf8p40y1mtuz7wT8+4XPXA=
X-Gm-Gg: ASbGncv77mSvo3iiXj2RSe4pA6u7/1Os7DvF9tsknGJvXz/891ZqMyqyp2cgPXkCVG7
 BcW3YEhEIYVCdOa16YBW0C8binMuirtxN2ZCuPk0wyKRV5+0wnDdLBmCl7zgz93L4VsdfREv6JZ
 NGi482RzQd5DcHJI1qrg634eRZRxcSnoX+J7KKr3wC6441qQ6xlQTylsc/n4NaLQ8GxGcFXFtb7
 TBj06scuMiUQFJim/dI48E58BnnhS1PyHasqucg4fjjxdVL7qCQABb8HxY+l1aMw8Oc/DTLkDNO
 qYvW4+cnCIDb+AG1B+D1GwWOHUjsrTzt61JGuedb8I7fenGJRNLtGQgJ+X5T92zVC6UGtKVVftc
 oeTvW2yNsikI2umy8rdkRAkU7MwIf6eq281gpa+VMY4dPOb4roKLpm/FCWKqe2tDjKfw700CwWb
 4enkk37WYzMiQUO6Ln8Fsm4z/nWsNXZV4hvDkV4Itt13EHZLqDeaUEwG+NCgra
X-Google-Smtp-Source: AGHT+IEQpN99M3HfmCnILVfiuFt5M9IOw+UhWvPluEUXd2RPBAbKm3o4LQ7dhsOXAy+ISK8dRZWk7Q==
X-Received: by 2002:a05:6000:4013:b0:429:8d50:8d2 with SMTP id
 ffacd0b85a97d-429a7e37dfdmr1573217f8f.6.1761639470872; 
 Tue, 28 Oct 2025 01:17:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5?
 ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df6b9sm19635546f8f.44.2025.10.28.01.17.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:17:50 -0700 (PDT)
Message-ID: <425461f4-8be2-4e47-91a6-7424950afbe1@linaro.org>
Date: Tue, 28 Oct 2025 09:17:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 6/6] ufs: Add UFS driver for Renesas R-Car X5H
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sumit Garg
 <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot-qcom@groups.io
References: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
 <20251027170706.29302-6-marek.vasut+renesas@mailbox.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20251027170706.29302-6-marek.vasut+renesas@mailbox.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/27/25 18:06, Marek Vasut wrote:
> From: Tuyen Dang <tuyen.dang.xa@renesas.com>
> 
> Add UFS driver for UFS controller present on Renesas R-Car X5H R8A78000.
> The controller uses different initialization code compared to previous
> generation UFS controller present in Renesas R-Car S4 R8A779F0, and the
> majority of the driver is the initialization, hence a new driver.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Tuyen Dang <tuyen.dang.xa@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> [Marek: Clean driver up, add SCMI reset handling, use read_poll_timeout(),
>          pass error values out of ufs_renesas_pre_init(), change the
> 	compatible string to "renesas,r8a78000-ufs" to align with
> 	previous generation "renesas,r8a779f0-ufs"]
> ---
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.denx.de
> ---
>   drivers/ufs/Kconfig                 |   9 +
>   drivers/ufs/Makefile                |   1 +
>   drivers/ufs/ufs-renesas-rcar-gen5.c | 268 ++++++++++++++++++++++++++++
>   3 files changed, 278 insertions(+)
>   create mode 100644 drivers/ufs/ufs-renesas-rcar-gen5.c
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 4c6b08ad31c..363f53a6792 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -56,4 +56,13 @@ config UFS_RENESAS
>   	  platform driver. UFS host on Renesas needs some vendor
>   	  specific configuration before accessing the hardware.
>   
> +config UFS_RENESAS_GEN5
> +	bool "Renesas R-Car X5H UFS Controller support"
> +	depends on UFS
> +	select BOUNCE_BUFFER
> +	help
> +	  This selects the Renesas X5H specific additions to UFSHCD
> +	  platform driver. UFS host on Renesas needs some vendor
> +	  specific configuration before accessing the hardware.
> +
>   endmenu
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index 2ac410cf7c3..46866260b7b 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
>   obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
>   obj-$(CONFIG_UFS_PCI) += ufs-pci.o
>   obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
> +obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
> diff --git a/drivers/ufs/ufs-renesas-rcar-gen5.c b/drivers/ufs/ufs-renesas-rcar-gen5.c
> new file mode 100644
> index 00000000000..3c66022579f
> --- /dev/null
> +++ b/drivers/ufs/ufs-renesas-rcar-gen5.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Renesas UFS host controller driver
> + *
> + * Copyright (C) 2025 Renesas Electronics Corporation
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <ufs.h>
> +#include <asm/io.h>
> +#include <dm/device_compat.h>
> +#include <linux/iopoll.h>
> +#include <reset.h>
> +
> +#include "ufs.h"
> +
> +#define UFS_RENESAS_TIMEOUT_US		100000
> +
> +struct ufs_renesas_priv {
> +	struct clk_bulk		clks;
> +	struct reset_ctl_bulk	resets;
> +	fdt_addr_t		phy_base;
> +	/* The hardware needs initialization once */
> +	bool			initialized;
> +};
> +
> +static void ufs_dme_command(struct ufs_hba *hba, u32 cmd,
> +			    u32 arg1, u32 arg2, u32 arg3)
> +{
> +	ufshcd_writel(hba, arg1, REG_UIC_COMMAND_ARG_1);
> +	ufshcd_writel(hba, arg2, REG_UIC_COMMAND_ARG_2);
> +	ufshcd_writel(hba, arg3, REG_UIC_COMMAND_ARG_3);
> +	ufshcd_writel(hba, cmd, REG_UIC_COMMAND);
> +}
> +
> +static int ufs_renesas_pre_init(struct ufs_hba *hba)
> +{
> +	struct ufs_renesas_priv *priv = dev_get_priv(hba->dev);
> +	u32 val32;
> +	u16 val16;
> +	int ret;
> +
> +	writew(0x0001, priv->phy_base + 0x20000);

The driver looks good, but it's a shame there's not a single
register or field define to use instead of magic numbers !

Neil

> +	writew(0x005c, priv->phy_base + 0x20212);
> +	writew(0x005c, priv->phy_base + 0x20214);
> +	writew(0x005c, priv->phy_base + 0x20216);
> +	writew(0x005c, priv->phy_base + 0x20218);
> +	writew(0x036a, priv->phy_base + 0x201d0);
> +	writew(0x0102, priv->phy_base + 0x201d2);
> +	writew(0x001f, priv->phy_base + 0x20082);
> +	writew(0x000b, priv->phy_base + 0x20084);
> +	writew(0x0126, priv->phy_base + 0x201d2);
> +	writew(0x01dc, priv->phy_base + 0x20214);
> +	writew(0x01dc, priv->phy_base + 0x20218);
> +	writew(0x0000, priv->phy_base + 0x201cc);
> +	writew(0x0200, priv->phy_base + 0x201ce);
> +	writew(0x0000, priv->phy_base + 0x20212);
> +	writew(0x0000, priv->phy_base + 0x20216);
> +
> +	ret = readw_poll_timeout(priv->phy_base + 0x201ec, val16,
> +				 !(val16 & BIT(12)), UFS_RENESAS_TIMEOUT_US);
> +	if (ret)
> +		return ret;
> +
> +	ret = readw_poll_timeout(priv->phy_base + 0x201e4, val16,
> +				 !(val16 & BIT(12)), UFS_RENESAS_TIMEOUT_US);
> +	if (ret)
> +		return ret;
> +
> +	ret = readw_poll_timeout(priv->phy_base + 0x201f0, val16,
> +				 !(val16 & BIT(12)), UFS_RENESAS_TIMEOUT_US);
> +	if (ret)
> +		return ret;
> +
> +	writew(0x0000, priv->phy_base + 0x20000);
> +
> +	ufshcd_writel(hba, BIT(0), REG_CONTROLLER_ENABLE);
> +
> +	ret = read_poll_timeout(ufshcd_readl, val32, (val32 & BIT(0)),
> +				1, UFS_RENESAS_TIMEOUT_US,
> +				hba, REG_CONTROLLER_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = read_poll_timeout(ufshcd_readl, val32, (val32 & BIT(3)),
> +				1, UFS_RENESAS_TIMEOUT_US,
> +				hba, REG_CONTROLLER_STATUS);
> +	if (ret)
> +		return ret;
> +
> +	/* Skip IE because we cannot handle interrupts here */
> +	ufs_dme_command(hba, 0x00000002, 0x81010000, 0x00000000, 0x00000005);
> +	ufs_dme_command(hba, 0x00000002, 0x81150000, 0x00000000, 0x00000001);
> +	ufs_dme_command(hba, 0x00000002, 0x81180000, 0x00000000, 0x00000001);
> +	ufs_dme_command(hba, 0x00000002, 0x80090000, 0x00000000, 0x00000000);
> +	ufs_dme_command(hba, 0x00000002, 0x800a0000, 0x00000000, 0x000000c8);
> +	ufs_dme_command(hba, 0x00000002, 0x80090001, 0x00000000, 0x00000000);
> +	ufs_dme_command(hba, 0x00000002, 0x800a0001, 0x00000000, 0x000000c8);
> +	ufs_dme_command(hba, 0x00000002, 0x800a0004, 0x00000000, 0x00000000);
> +	ufs_dme_command(hba, 0x00000002, 0x800b0004, 0x00000000, 0x00000064);
> +	ufs_dme_command(hba, 0x00000002, 0x800a0005, 0x00000000, 0x00000000);
> +	ufs_dme_command(hba, 0x00000002, 0x800b0005, 0x00000000, 0x00000064);
> +	ufs_dme_command(hba, 0x00000002, 0xd0850000, 0x00000000, 0x00000001);
> +
> +	writew(0x0001, priv->phy_base + 0x20000);
> +
> +	clrbits_le16(priv->phy_base + 0x20022, BIT(0));
> +
> +	ret = readw_poll_timeout(priv->phy_base + (0x00198 << 1), val16,
> +				 (val16 & BIT(0)), UFS_RENESAS_TIMEOUT_US);
> +	if (ret)
> +		return ret;
> +
> +	writew(0x0368, priv->phy_base + 0x201d0);
> +
> +	ret = readw_poll_timeout(priv->phy_base + 0x201e4, val16,
> +				 !(val16 & BIT(11)), UFS_RENESAS_TIMEOUT_US);
> +	if (ret)
> +		return ret;
> +
> +	ret = readw_poll_timeout(priv->phy_base + 0x201e8, val16,
> +				 !(val16 & BIT(11)), UFS_RENESAS_TIMEOUT_US);
> +	if (ret)
> +		return ret;
> +
> +	ret = readw_poll_timeout(priv->phy_base + 0x201ec, val16,
> +				 !(val16 & BIT(11)), UFS_RENESAS_TIMEOUT_US);
> +	if (ret)
> +		return ret;
> +
> +	ret = readw_poll_timeout(priv->phy_base + 0x201f0, val16,
> +				 !(val16 & BIT(11)), UFS_RENESAS_TIMEOUT_US);
> +	if (ret)
> +		return ret;
> +
> +	priv->initialized = true;
> +
> +	return 0;
> +}
> +
> +static int ufs_renesas_init(struct ufs_hba *hba)
> +{
> +	hba->quirks |= UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS | UFSHCD_QUIRK_HIBERN_FASTAUTO |
> +		       UFSHCD_QUIRK_BROKEN_LCC;
> +
> +	return 0;
> +}
> +
> +static int ufs_renesas_hce_enable_notify(struct ufs_hba *hba,
> +					 enum ufs_notify_change_status status)
> +{
> +	struct ufs_renesas_priv *priv = dev_get_priv(hba->dev);
> +	int ret;
> +
> +	if (priv->initialized)
> +		return 0;
> +
> +	if (status == PRE_CHANGE) {
> +		ret = ufs_renesas_pre_init(hba);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	priv->initialized = true;
> +
> +	return 0;
> +}
> +
> +static int ufs_renesas_link_startup_notify(struct ufs_hba *hba,
> +					   enum ufs_notify_change_status status)
> +{
> +	if (status == PRE_CHANGE)
> +		return ufshcd_dme_set(hba, UIC_ARG_MIB(PA_LOCAL_TX_LCC_ENABLE), 0);
> +
> +	return 0;
> +}
> +
> +static int ufs_renesas_get_max_pwr_mode(struct ufs_hba *hba,
> +					struct ufs_pwr_mode_info *max_pwr_info)
> +{
> +	max_pwr_info->info.gear_rx = UFS_HS_G5;
> +	max_pwr_info->info.gear_tx = UFS_HS_G5;
> +	max_pwr_info->info.pwr_tx = FASTAUTO_MODE;
> +	max_pwr_info->info.pwr_rx = FASTAUTO_MODE;
> +	max_pwr_info->info.hs_rate = PA_HS_MODE_A;
> +
> +	max_pwr_info->info.lane_rx = 1;
> +	max_pwr_info->info.lane_tx = 1;
> +
> +	dev_info(hba->dev, "Max HS Gear: %d\n", max_pwr_info->info.gear_rx);
> +
> +	return 0;
> +}
> +
> +static struct ufs_hba_ops ufs_renesas_vops = {
> +	.init			= ufs_renesas_init,
> +	.hce_enable_notify	= ufs_renesas_hce_enable_notify,
> +	.link_startup_notify	= ufs_renesas_link_startup_notify,
> +	.get_max_pwr_mode	= ufs_renesas_get_max_pwr_mode,
> +};
> +
> +static int ufs_renesas_pltfm_probe(struct udevice *dev)
> +{
> +	struct ufs_renesas_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	priv->phy_base = dev_read_addr_name(dev, "phy");
> +	if (priv->phy_base == FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	ret = reset_get_bulk(dev, &priv->resets);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = clk_get_bulk(dev, &priv->clks);
> +	if (ret < 0)
> +		goto err_clk_get;
> +
> +	ret = clk_enable_bulk(&priv->clks);
> +	if (ret)
> +		goto err_clk_enable;
> +
> +	reset_assert_bulk(&priv->resets);
> +	reset_deassert_bulk(&priv->resets);
> +
> +	ret = ufshcd_probe(dev, &ufs_renesas_vops);
> +	if (ret) {
> +		dev_err(dev, "ufshcd_probe() failed %d\n", ret);
> +		goto err_ufshcd_probe;
> +	}
> +
> +	return 0;
> +
> +err_ufshcd_probe:
> +	reset_assert_bulk(&priv->resets);
> +	clk_disable_bulk(&priv->clks);
> +err_clk_enable:
> +	clk_release_bulk(&priv->clks);
> +err_clk_get:
> +	reset_release_bulk(&priv->resets);
> +	return ret;
> +}
> +
> +static int ufs_renesas_pltfm_remove(struct udevice *dev)
> +{
> +	struct ufs_renesas_priv *priv = dev_get_priv(dev);
> +
> +	reset_release_bulk(&priv->resets);
> +	clk_disable_bulk(&priv->clks);
> +	clk_release_bulk(&priv->clks);
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id ufs_renesas_pltfm_ids[] = {
> +	{ .compatible = "renesas,r8a78000-ufs" },
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(ufs_renesas) = {
> +	.name		= "ufs-renesas-gen5",
> +	.id		= UCLASS_UFS,
> +	.of_match	= ufs_renesas_pltfm_ids,
> +	.probe		= ufs_renesas_pltfm_probe,
> +	.remove		= ufs_renesas_pltfm_remove,
> +	.priv_auto	= sizeof(struct ufs_renesas_priv),
> +};

