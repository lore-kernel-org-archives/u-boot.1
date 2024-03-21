Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D096C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 19:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F017288141;
	Thu, 21 Mar 2024 20:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711048637;
	bh=A0Tb8A2tzA0Esyj99VXxGJ9oOzAmNW1IghBYjjXQWgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H1NuyvQSGmvlSQPjUP7Co5YnRtD1li2ZJDKbErvhbdKw4cAO0UHN6hGhrjQk4MPuw
	 nZlxDjPgN9VyqwBS1hUKtjZIlbhLjDvU6JfDaThq9Y/M0N43VMn5z+o1uKLWNfpyuO
	 kMVSZqMG+KaTQ9sle5Hydn6T8IHjYlHeR8hnysInQQD2oXCDcCl+7rZyIk4lZkITbw
	 fa6soNna49+5Rj7a958yar/aa9VUZzabPTvLg3GENexBmVkIn90wJcPEN8+4/gBTus
	 yqLE3tR2h01dRBldHdAixs7S5ODFpT0cAPRng+ibEpmLNTcb9aVJmZeMrwbAwV8yOR
	 3gY5TOkrYY10Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 86F6E88137;
 Thu, 21 Mar 2024 20:17:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711048635;
 bh=A0Tb8A2tzA0Esyj99VXxGJ9oOzAmNW1IghBYjjXQWgU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fUohJ8X8BCrpjr3kiGp2UIbrEI7y12BgbWZETfUALWqSddK0Wo2UPwBkQYNby27uz
 RCkkd0gdYgCYYgQPJLrJukhJGercijWWhHHZ6r6b8pRdpvMbb9qoN/yJIGV0RJGEr0
 FP3b+3Pews9W524VbnjGdFEBWW1psDsevrPTHzehoVr7auIYWuwmNFpWY1xEzG5Ypp
 LGSoKk8jQinP5Oz5x4oO2+QmX1W0n5WFY8cZnXYqb7HncYrY2EnFowNvCFxRqqx1K9
 Q1gMFg5+afFq6dSfqOkqrjlZ2RmBGqo+Ydx11Co8x46VzfiTThhhM0TpdIxDI6q6Ws
 kgkVg8e9ZJf0A==
Message-ID: <dec314ce-d83a-4549-a2d6-f5604107bca5@denx.de>
Date: Thu, 21 Mar 2024 17:16:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] configs: imx93-phyboard-segin: Add USB support
Content-Language: en-US
To: Mathieu Othacehe <othacehe@gnu.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Yannic Moog <y.moog@phytec.de>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de
References: <20240321144541.15314-1-othacehe@gnu.org>
 <20240321144541.15314-3-othacehe@gnu.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240321144541.15314-3-othacehe@gnu.org>
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

On 3/21/24 3:45 PM, Mathieu Othacehe wrote:
> Add USB support by enabling `usb` command and required USB drivers.
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>   configs/imx93-phyboard-segin_defconfig | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/configs/imx93-phyboard-segin_defconfig b/configs/imx93-phyboard-segin_defconfig
> index 24f9bd553aa..0345e7deeab 100644
> --- a/configs/imx93-phyboard-segin_defconfig
> +++ b/configs/imx93-phyboard-segin_defconfig
> @@ -67,6 +67,7 @@ CONFIG_CMD_GPIO=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_POWEROFF=y
> +CONFIG_CMD_USB=y
>   CONFIG_CMD_SNTP=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
> @@ -132,6 +133,13 @@ CONFIG_SPL_SYSRESET=y
>   CONFIG_SYSRESET_WATCHDOG=y
>   CONFIG_DM_THERMAL=y
>   CONFIG_IMX_TMU=y
> +CONFIG_USB=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"

$ git grep -i usb.*phytec configs
configs/phycore_pcl063_defconfig:CONFIG_USB_GADGET_MANUFACTURER="Phytec"
configs/phycore_pcl063_ull_defconfig:CONFIG_USB_GADGET_MANUFACTURER="Phytec"

It would be good to be consistent.

Also, what is the vendor/product number those two boards use ?

Also, it would be good to fix the extra leading zero in those board 
boards vendor number, this, in both configs:

CONFIG_USB_GADGET_VENDOR_NUM=0x01b67
