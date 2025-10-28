Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F227CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 15:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C21A82A9E;
	Tue, 28 Oct 2025 16:33:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DzebWP4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C9FF82E34; Tue, 28 Oct 2025 16:33:30 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B38F80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso3980663f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761665607; x=1762270407; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=FBPDSVJPhGk9OoLS8Pu2o5xaAvkUmx50hRG9iWzqhJc=;
 b=DzebWP4hfxC7r/BMMWz/pLeJFfLi+iOslZrAuHhEWi445E67AULElxwr/8wf2nWt+c
 VgS3JuEfp2YCKD8S33yNZHOCfRw7nf14B2VpdjMbokvDMvbQafUydCj12Qm4sqcQfchm
 BQXDg43eGWwNl61dsWedyo0LExzxG3b/fCuH8615FA1tCRokdZrmQIGwZQGKXjr7OUmT
 c9CjB8y4rgGfKuWixBvrn/lZg/WdRVEZYStd2RvOXRKC3FHeJk6CLUSfpfTnFVA65RaD
 YYypnhbf/7d7mxAzouuvXpocP6n+YnZrXPvm24QZz9yX/jPQtah8gQEaYQDOf/9IBsR+
 6RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761665607; x=1762270407;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FBPDSVJPhGk9OoLS8Pu2o5xaAvkUmx50hRG9iWzqhJc=;
 b=tcit4Q4fZYLlL7zbY3n5uE7NBgNqFrrK1NCNfVJyDb8vPZPFEpdxMGIQJ6yV1SRC7j
 eJSkSD4Kqi6ddN+bvbZA7xGpWQvYpauQ5nvh+SxzzTJS1rr4XRzT2I6bvK9C4ZGO5vSd
 QnNzDQV951G/4EkwawmiG162o9POQE0UcMHk9hnQyDIfuiSjOL9lGMeUiUiizF+7HLPh
 +3iXU4oqndPNoqSylYlrNwAT9fd5O7/UhR4OVL74yie0+EP7bXX7e1mkr4Fzu6C58l6o
 rz0vxxK9iyE0D6ZdkWO/MoTTfSQxPKg/+cU6hDT3x469tdsEXSb65pjmEBCgGGnwhWNO
 Qh7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSnuW8OdezFJl36ddIib3x79h9UTD3q7xaG+tI5TltpXK4mu+yGItICb/RbBCFdAhA2iAP+7I=@lists.denx.de
X-Gm-Message-State: AOJu0YxSp2B1GYZgyRjGNFU6TKUVA2HgJLtezPunKu9q3Tz0OUYCxg6o
 r1mlNqkQrxoQeItr6PO3wd+5shdVfWum8aGIKVkgGjO8bR1Jentyr0tayoE16kCc2N0=
X-Gm-Gg: ASbGncvB2jKtCKV3HIP1WFgXCky9XQDbx2teRH6QqC8shG+1JgguKQrvZRQjegvoSck
 OILqZTkzjbwu9f62LKNLgrBCA1UsOAKUKXyyRQOLZMgSX5Dru4yDiKBOF5XwiwtLvuKobCnSaHA
 hzxXPW6TWj7brqeMAy5ngrfyJsz5iWDB10kELNi5Z5H9JycRBRrBqlFkvuZFaXFFU9JCyms2dKt
 9AvP6Uv+GVYpo4VG2xUZSwCkI9LkEAvylih2HTRHfQUgS5UzJ9gaZfU1JIFw2XgHEz6j4vyQ3G6
 bjnYV1YRq4sIuWh1oUDDlzNDHRkmc0+Es6Ua3rdTxL5063nYxN63JRaHWi/2yRzIMF0ld/NODOy
 igoCXupM8QCMK+H+mne++Nb5IIImS/DEssJXlbbQEJfBgBwmhbPIfV57Q+J4ZfgSRosodj2XV4u
 53O29v2GOs5ybWA9m8cmZ6lrOPsnuw8bDSl8mlLOUYNWlpjS/SgWyvjItVm0SR
X-Google-Smtp-Source: AGHT+IEH2wjW12JvClqSC/uQiHDzfUTAx6dLBmC9MMWnY24G1PTGQcI1Q8NCYRbhYYh2E/Qhb0UENg==
X-Received: by 2002:a5d:5f43:0:b0:3ec:de3c:c56 with SMTP id
 ffacd0b85a97d-429a7e524edmr3255064f8f.16.1761665607348; 
 Tue, 28 Oct 2025 08:33:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5?
 ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db9d1sm20564351f8f.35.2025.10.28.08.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 08:33:26 -0700 (PDT)
Message-ID: <63913b16-0afb-4c8d-8efe-fae0b6134a31@linaro.org>
Date: Tue, 28 Oct 2025 16:33:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 7/7] ufs: Add UFS driver for Renesas R-Car X5H
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sumit Garg
 <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot-qcom@groups.io
References: <20251028142335.18125-1-marek.vasut+renesas@mailbox.org>
 <20251028142335.18125-7-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20251028142335.18125-7-marek.vasut+renesas@mailbox.org>
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

On 10/28/25 15:22, Marek Vasut wrote:
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
> V2: No change
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
> index 17ca89e886f..07c94f03429 100644
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

Shame we dont't have a single register define... but it seems accepted
with the older driver and from Linux... so LGTM

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
