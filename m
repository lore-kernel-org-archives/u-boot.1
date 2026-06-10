Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B03CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 15:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D7B84928;
	Wed, 10 Jun 2026 17:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="UKkWlXDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E99C84948; Wed, 10 Jun 2026 17:10:00 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16CED8491C
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 17:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-486304fa184so6027570b6e.1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781104197; x=1781708997; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wIz8HW+6E27KNYiWBXAf+CaK7otsIpJHSrdA/0g9sbc=;
 b=UKkWlXDbH0hE0a91lH55ZPIGBDwktykJXj8JBaWNewRRMx1YHKjsm4Dm1aJ9kRQSUL
 RRv0IF53YOnkxJ7oevwaOoCU97ef7jWMP/1RdRKveYHBT0FyvPB81VrxK4yC1QxMLead
 yy8B28l0PBiHr8kbFLAu6+KKrlUxChV7H1VmKZ0Wn+daLIHN8UCX6HCOfklP9iqkKGQu
 QVMg55XFZk6HrMkFp/4T4l7BfzY7QwEAfcrBvzHZnMvuTouAPjcQpZNkgl4m00pHQz5U
 jCJCgSCZ4PiNFhbN084mEjouNB02pxWQpk9/KHWSOIhYsJDAavLTZyqWcEp4UYvBjwNw
 4kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781104197; x=1781708997;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wIz8HW+6E27KNYiWBXAf+CaK7otsIpJHSrdA/0g9sbc=;
 b=BybaajdXnlO8g52UBKt3orpw9L9KET64U3LBISuu5QTEA2avj2d+zGjpDx8I5Rlwww
 SwuhIL202LRz4zb38fzJHKWdG0Lv6qPpFawW4IaoNQ2RWkSkyDk9gGj9sI04YsMYR7d3
 hhwDmryzYW/xHBdZDQRSVkvk7Ra2qOq8QB0G9u9g/1DvgS4+WyJcuRwDZtw9aZd9S2eK
 R5o9zlf/AOv0gOMg0Nen5L2ix1SMQsGrQURk7eS5OOOlecxTPiJuRI5VgQ/6HXUk58MK
 fsog6z7A1qdmYQQ4t6RK2zd9NZYIGZlIR6fcHVhd9X5BhEvyPbqQO0GZCj2Yn6hdkHLg
 e/1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ90HAPW3ZAkLDGJdRymGY8ghKjaNssDOOuYwb6ybmPdELq2NzTycL+f2ptM2DcBMFr9fcc4muc=@lists.denx.de
X-Gm-Message-State: AOJu0YwOByfQuRxm+5sLfvS9IlPZAqLL676TL+rfOsuEPPA3MuPdNa6w
 UDYRHB57TwSJgUqVUaVubf2iMdxzrO4VUMTMFsCR7tYkDasU8JOLDuzgbjHNrPpOW0Y=
X-Gm-Gg: Acq92OFpaHs/EVlpMNsFn6IxFZHs4o69+vu2OLjZRqQdF/klUJH4CFkgoJI0TNeqpKM
 8pIoYomejYRw8WCAjjzZ4RU8h8GWO5xJAACJ3XDHBB04yzrd7u9zMT2Dw6g7kU00P2hp3XOvLse
 t3l8o/dRmedZ8+kTiURRsz5td27339ysm3UEuqcMd2E6Dr7+LN9yiqkE0uZoUAzqOh8oIVy1rW2
 q0ivOp/SGtSBZ6rWHh7osl/qDSpdgI1YHwUT+GUq9LEYs3ZEAbAczNBMmEE3suoM++Vlrh1hQYN
 v3VM7/atC655drUmge6rIaoqaBroxEdvb3XSU/3L0yye2/NFK3oghJ2LRWgyGB/GJ2/dr2AgDTU
 /JkDhudFCmrCITHUtoMPXbK+YNNb2Qfh9/SHv8E8r9t9iaDMGF8+3rJ55AE6m6A15Z46kXcTN4X
 Ghml4I20IGSBEtgCiGT1R0wdrJItfZxfVdzf2liVPJY20F4v8jGOT7qT2sCFJihT+ZucGCoQLyf
 a8v2aLmK+UM
X-Received: by 2002:a05:6820:4d02:b0:69e:3d6d:375b with SMTP id
 006d021491bc7-69eac9f09e7mr5412778eaf.27.1781104196693; 
 Wed, 10 Jun 2026 08:09:56 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7a87:89cd:a5bc:a62f?
 ([2600:8803:e7e4:500:7a87:89cd:a5bc:a62f])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e4644ddc2sm12098570eaf.12.2026.06.10.08.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 08:09:56 -0700 (PDT)
Message-ID: <fd3f3d58-f498-43e6-9a8b-fdfaf1803da8@baylibre.com>
Date: Wed, 10 Jun 2026 10:09:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] spi: mtk_snor: Use dev_read_addr_ptr()
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, "Noah.Shen"
 <noah.shen@mediatek.com>, Meiker Gao <ot_meiker.gao@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20260602-devfdt-spi-v2-0-08374650778a@nxp.com>
 <20260602-devfdt-spi-v2-3-08374650778a@nxp.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260602-devfdt-spi-v2-3-08374650778a@nxp.com>
Content-Type: text/plain; charset=UTF-8
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

On 6/2/26 6:20 AM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use dev_read_addr_ptr() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Weijie Gao <weijie.gao@mediatek.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/spi/mtk_snor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
> index 40fc1826db6..a54eca8acda 100644
> --- a/drivers/spi/mtk_snor.c
> +++ b/drivers/spi/mtk_snor.c
> @@ -528,7 +528,7 @@ static int mtk_snor_probe(struct udevice *bus)
>  	u8 *buffer;
>  	int ret;
>  
> -	priv->base = devfdt_get_addr_ptr(bus);
> +	priv->base = dev_read_addr_ptr(bus);
>  	if (!priv->base)
>  		return -EINVAL;
>  
> 

Acked-by: David Lechner <dlechner@baylibre.com>

