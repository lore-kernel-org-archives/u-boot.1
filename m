Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25198C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 03:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63B4E86D33;
	Mon, 13 Nov 2023 04:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699845047;
	bh=Z0/PowHjfANCEP1LQ9WK2CGIhPE9JEEbEaqdk3dhjVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y46tZVfPHKKipTLkK72Ykr4/11a94WVbDP9c2dZ6OCcJuDGVve+HRddFo1i3TaNOs
	 G9HjEXC3AkSW1YUWv/Ghi7SsyHYccbPk3Wr2NGmBMtew7Ko6LbsjmWnMdF4njX3c+c
	 CgXgPoGebZMEJHpPOt+c9dVP3hPEDbdA9zumRmhLPP7knfmfBFpcD5g7xYpc76g25x
	 gJiaFeTnedWfZ8e0lRyLlSHYbhMIRrooNtn3aUJpzhCNHb5ZxGRr1VPK2icKNrobvs
	 R4BOGPZ1BuyUTDvI3Cd+0LIAsli3x1xxCdf++cJGWEBI0omutiHnYUdDhbMaXr4U9k
	 psRUhQz3zOomw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 95897869DA;
 Mon, 13 Nov 2023 04:10:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699845045;
 bh=Z0/PowHjfANCEP1LQ9WK2CGIhPE9JEEbEaqdk3dhjVw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nlkYsHm+zbY+Bl6ve0kPUYbUJsGE3jDIh0f0YcGc+MW6RrLDMABDksZshOooQcSWr
 /ZLkT1LqCNnlWMY17grw/lp8Ngla8YNuImVW+HwVpg6S776Xv3N+etj8WiYmshN0QK
 Y9ce0Y5BvkeuJaTdW5dbRVk1mK7rOt5hDdZdzRYHh1RD1EruTPdc6ht1ioNdnB7HYU
 jkcX59YWoVsLJUdCQ1pvMX3wBKdfpI6R7wELt8z7q/k4QzJ0IV9L3Remot2r9ZB0rG
 OlPYNGLIYMsFD+ZnY0u+bVS8WB0wM3H8PE/Z6ihbsaRwrNeZQC4KvrYFnchbAuDoFW
 H/p9nY5uEX2eg==
Message-ID: <60b7ef44-0074-4e0b-9abd-62781d9052da@denx.de>
Date: Mon, 13 Nov 2023 04:10:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] configs: rockchip: Use dwc3-generic driver on
 RK3328 and RK3399
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Xiaobo Tian <peterwillcn@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Levin Du
 <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: u-boot@lists.denx.de
References: <20231112174904.1581187-1-jonas@kwiboo.se>
 <20231112174904.1581187-2-jonas@kwiboo.se>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231112174904.1581187-2-jonas@kwiboo.se>
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

On 11/12/23 18:48, Jonas Karlman wrote:

> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index b501ea514bca..d92d87af52ef 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -39,7 +39,6 @@ config USB_XHCI_DWC3
>   config USB_XHCI_DWC3_OF_SIMPLE
>   	bool "DesignWare USB3 DRD Generic OF Simple Glue Layer"
>   	depends on DM_USB
> -	default y if ARCH_ROCKCHIP
>   	default y if DRA7XX
>   	help
>   	  Support USB2/3 functionality in simple SoC integrations with

For this part:

Reviewed-by: Marek Vasut <marex@denx.de>
