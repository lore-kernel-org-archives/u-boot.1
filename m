Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3E8CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 23:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9A4A87030;
	Thu, 19 Oct 2023 01:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697672700;
	bh=pdnPKiH9nKlzCwCVI/sVbwjsLPuZZ+nT+rOjKf5AFPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AGRuwOPVbuxVR62lyLLGXQlTiZiFAzgQMzSn2+a+ITdxO6a2V4urp1QzGzU91uprz
	 f2HiWBHLOOlmDWkSEy6EmDWGKMY5kb9I7sX8fHC/a2X68XgtnexrKeu68CDlDlTOai
	 zjxnQaraPPO9b9d/4mj4hAoFKeFi+gkqyqoZXM0CHcvPqDsYG9uMvJb06Yr+Z7Nl8a
	 wfygvmLWOrVFZyum05nGEQoeMxoDbGBp5gj3X4Y9acaQYGaIy/Q5oztdcFYhRnheS1
	 GFeUS20fOqdishr0M9nCxwMRWK9PLNJoXpR1nzQVbMK48rGWgQF5NH71aVl59yfcbR
	 lAD4o2B5E218Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2D49386E7E;
 Thu, 19 Oct 2023 01:44:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697672700;
 bh=pdnPKiH9nKlzCwCVI/sVbwjsLPuZZ+nT+rOjKf5AFPY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=C3N1s/ujvBZR3x0kIWkTSdVmXLpy1P+glCOMPbNPtcEm3iW6dwxop3G3SAZOmje2P
 lZGTpUIBVpHWMrln5UUxACPjtwUrhmOapCDTTzjtTzxMFu6zWewrs194gilGY8Fd9Y
 u3q1gO9rzbjW7sK2hyhga9oF5h42f6rXVOHDms9hauG9/vDgQoh+nnCT87dCoYMHaB
 XOhDWY2/mQz7GVeoNAOvoT53F10gVBZadt5IYjgYz34r3pqOCCIEp02IAPDpntmjqK
 M6br/fYZNyY0kZKQ95Tuuye1l16FBMY0KuXfbElpyocZcfdhEnRagdV5YMZH0WKZnl
 V9Y0txEaQ5kEA==
Message-ID: <0799d3c2-7997-4e78-aefb-fe571ebc53a4@denx.de>
Date: Thu, 19 Oct 2023 01:44:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs: rockchip: Use dwc3-generic driver on RK3328
 and RK3399
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Xiaobo Tian <peterwillcn@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: u-boot@lists.denx.de
References: <20231018223058.2081052-1-jonas@kwiboo.se>
 <20231018223058.2081052-2-jonas@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231018223058.2081052-2-jonas@kwiboo.se>
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

On 10/19/23 00:30, Jonas Karlman wrote:

[..]

> +++ b/configs/rock960-rk3399_defconfig
> @@ -50,6 +50,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_SYS_MMC_ENV_DEV=1
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -70,12 +71,12 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y

Why not add 'default y if ROCKCHIP' into the Kconfig instead ? This will 
have the same effect, without requiring such massive modification of 
config files.

(seems some of the CC domains are not even working, so CC list clipped)
