Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050E0C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 08:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D5D987666;
	Tue, 19 Mar 2024 09:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="RUm87Yyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D4BF879E0; Tue, 19 Mar 2024 09:11:16 +0100 (CET)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 982DB87BF1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 09:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SCNlTa0Tn98SUordomZ287EqiHtK5JIApahkvVwoMzM=; b=RUm87YynEyecDvCsscruIxG3/T
 E8zPW6Iy5v1LEHcx6Y167XTmgmpM9TTl2IO2KiebH4ofrsByGBvZ+4CeXok3GT0Ev/TorK73N/sQ4
 6gCCi7mlwJHJPDLDDJTqp0TXxDM/URS/NPx+hyd+0tINEdFJ7eu79QcWcTzHyTYnx9HYUvSP1BXqm
 ECK9NFZWOzyO7qbX9JP3DM/25JfzW1Ph4rsWtbfOorG7/G7hGnVn9HYDOrzT2FI4/7C9j/H0yCGRa
 3vwxXcOW/+UUnHbtZCyssmDYlJDx5QrVyhDCML+HHsa1/AAjIyXdRr6pjnO8dU1S6E/VB7GkLr4yZ
 O7w4kH8Q==;
Received: from [89.212.21.243] (port=35674 helo=[192.168.69.116])
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1rmUYx-000wpQ-2o;
 Tue, 19 Mar 2024 09:11:11 +0100
Message-ID: <66045bb1-8d7c-4af1-bd0f-2b0ac2f419f6@norik.com>
Date: Tue, 19 Mar 2024 09:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] configs: imx93-phyboard-segin: Add USB support.
Content-Language: en-US
To: Mathieu Othacehe <othacehe@gnu.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Yannic Moog <y.moog@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20240318171637.12664-1-othacehe@gnu.org>
 <20240318171637.12664-3-othacehe@gnu.org>
From: Primoz Fiser <primoz.fiser@norik.com>
Organization: Norik systems d.o.o.
In-Reply-To: <20240318171637.12664-3-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Hi Mathieu,

On 18. 03. 24 18:16, Mathieu Othacehe wrote:
> Enable the `usb` command and some USB drivers.
> 

I would rephrase commit msg to something like this:

Add USB support by enabling `usb` command and required USB drivers.


> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>  configs/imx93-phyboard-segin_defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/configs/imx93-phyboard-segin_defconfig b/configs/imx93-phyboard-segin_defconfig
> index 24f9bd553aa..5acb987b817 100644
> --- a/configs/imx93-phyboard-segin_defconfig
> +++ b/configs/imx93-phyboard-segin_defconfig
> @@ -23,6 +23,7 @@ CONFIG_SPL_STACK=0x20519dd0
>  CONFIG_SPL=y
>  CONFIG_ENV_OFFSET_REDUND=0x720000
>  CONFIG_CMD_DEKBLOB=y
> +CONFIG_CMD_USB=y

Can you run

$ make savedefconfig && cp defconfig configs/imx93-phyboard-segin_defconfig

to re-order CONFIG_CMD_USB please?


>  CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
>  CONFIG_SYS_LOAD_ADDR=0x80400000
>  CONFIG_SYS_MEMTEST_START=0x80000000
> @@ -132,6 +133,13 @@ CONFIG_SPL_SYSRESET=y
>  CONFIG_SYSRESET_WATCHDOG=y
>  CONFIG_DM_THERMAL=y
>  CONFIG_IMX_TMU=y
> +CONFIG_USB=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="FSL"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
> +CONFIG_CI_UDC=y
>  CONFIG_ULP_WATCHDOG=y
>  CONFIG_LZO=y
>  CONFIG_BZIP2=y


-- 
Primoz Fiser                    | phone: +386-41-540-545
<tel:+386-41-390-545> |
---------------------------------------------------------|
Norik systems d.o.o.            | https://www.norik.com
<https://www.norik.com>  |
Your embedded software partner  | email: info@norik.com
<mailto:info@norik.com> |
Slovenia, EU                    | phone: +386-41-540-545
<tel:+386-41-540-545> |

