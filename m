Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8A5C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 22:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1318E8803E;
	Mon, 18 Mar 2024 23:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710801478;
	bh=I5GgG2kHsFfb56D2YqdhHgiIUG0cS41CfnotW7ptN1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KwT9yPXiCxN7CCDi4ymyLBaJdKx6qbfmkZyq+nMJo5cbUoJjq6qfMYHWEFJodsTM5
	 zHZzztrsf0ulC6gylzYlgHQ1up8lz0M+SfvljH+74ntxUV6szd/rnxzLLgGSBie6JS
	 scfJj/hCsWqlPa7afwgLC7+TrQD6cn22VtXcxUjbHYX7L0UhGsKG8h7Cpc4KtnxjCr
	 0/eF65Ldwf8rmF83J4nZNF8Gy3OGilTDidvhffvupzZ1MUL/VpTfnfxat2O6CayKp0
	 MyibgTI+Etl1v7m6jhV98nZnJ9Jl4KJUCl2WYfa/i1i0a6auEuM+ehxXW2MPdp8XsC
	 RTA9FiBGDsh7g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 594B188023;
 Mon, 18 Mar 2024 23:37:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710801474;
 bh=I5GgG2kHsFfb56D2YqdhHgiIUG0cS41CfnotW7ptN1Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=I4m+jzV7GHaHdNUDQ+PwwZQu4eTjLtSvA+dVQ0EE2nSipT0lbLjnXFFHhwr0sTyCA
 bz/7hWevVqKm22sf/cWkbQbmEMjPvnir9NEiZferzffuIW0Y/o61hynfDs9gOSF+aZ
 Sv4CxFXGukGWlvjwi7FYI7NwWTt5Sn4ym2p42OyRynOMeHCr5fLwcTQQ5BNatU6i1f
 ZMcGK3CmIDja5sBArT7uYM+jFgr+28Ap3IEiCeOmZiZPbwnUIPrEgB2RqVFxppwbrf
 Bm8xyaaTJGh4dLuhsu/n8CfJAHqSir0OmzmJ+FRJpNNfnIkvviYdWZ/S8sq2j25589
 bMuLTCjP/RwhA==
Message-ID: <ae1e53d1-cedc-4ef8-be42-b9d807640b55@denx.de>
Date: Mon, 18 Mar 2024 22:48:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] configs: imx93-phyboard-segin: Add USB support.
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
References: <20240318171637.12664-1-othacehe@gnu.org>
 <20240318171637.12664-3-othacehe@gnu.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240318171637.12664-3-othacehe@gnu.org>
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

On 3/18/24 6:16 PM, Mathieu Othacehe wrote:
> Enable the `usb` command and some USB drivers.
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>   configs/imx93-phyboard-segin_defconfig | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/configs/imx93-phyboard-segin_defconfig b/configs/imx93-phyboard-segin_defconfig
> index 24f9bd553aa..5acb987b817 100644
> --- a/configs/imx93-phyboard-segin_defconfig
> +++ b/configs/imx93-phyboard-segin_defconfig
> @@ -23,6 +23,7 @@ CONFIG_SPL_STACK=0x20519dd0
>   CONFIG_SPL=y
>   CONFIG_ENV_OFFSET_REDUND=0x720000
>   CONFIG_CMD_DEKBLOB=y
> +CONFIG_CMD_USB=y
>   CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
>   CONFIG_SYS_LOAD_ADDR=0x80400000
>   CONFIG_SYS_MEMTEST_START=0x80000000
> @@ -132,6 +133,13 @@ CONFIG_SPL_SYSRESET=y
>   CONFIG_SYSRESET_WATCHDOG=y
>   CONFIG_DM_THERMAL=y
>   CONFIG_IMX_TMU=y
> +CONFIG_USB=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="FSL"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x0152

Shouldn't this by Phytec or similar USB IDs ?
