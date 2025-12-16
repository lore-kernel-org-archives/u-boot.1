Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB8CD609B1
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 15:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D20CD839A5;
	Tue, 16 Dec 2025 16:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="e/MB5q5J";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Lw8pZ/UT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CA98839FA; Tue, 16 Dec 2025 16:40:46 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF32F80107
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 16:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dW1NW3BGBz9tQ8;
 Tue, 16 Dec 2025 16:40:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765899643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXKab9F3F3etWB1hFsv89qoG24NDmUafGPaM9hoc3y4=;
 b=e/MB5q5JXm2Ro7Hsq0MG3bqs/2615zvYejmMC3auV8VmZ6z5cUbUH6+iPA3I5HH5GMZew8
 s6qIE6/VFyUivDC0lUYVC6nCQTgLF2e3f3RblPQ+2XdZqFlaz7MQ0Zikk6VVMOJC8LIKTG
 WuCUsoxXntw4uwwIFtWaC4QiqXJktmgLWbclLYQL7sjnHOYl6kVC7IR0gXKuRO7aNNLdKh
 9JXXFvxz0/Z1mL+YYuYlPRMuoCYceI7hmwl7Fapm8OJ3dfVEX419TBjHrQiWwgwC3vhKC1
 4Am1M2Hb3t8zO3Vo2YDuFfjaHfdOD9tRpr+FB3e4GbC3pn6ysmD715TOp2gKJg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="Lw8pZ/UT";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <19f3a927-0fb9-4faf-a6a7-ee4a8e758bbc@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765899641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXKab9F3F3etWB1hFsv89qoG24NDmUafGPaM9hoc3y4=;
 b=Lw8pZ/UTntkBOT8mU4iYZaUWZQX6j7zJwOXFlJ3aypUA02PBJlGHGyF+uC013w3UwYr01u
 6sUpMzfnmo5oda+ixwc8x/TgYUFZYBrAinZf1f7jb/81H80og4UfGUAV50Ux7LkQBLYibR
 rS8CkdYM/1AX6UAjyjFIq9Z4hwYOTAK+eHElB7untE7nGDqMSlqeL55aXgWuar0p1zYA67
 ApPTl+MXqlBlHbWqnooTwS+iD2J6rXI5fUCQebuaA3N2tT006YMCw6bOLaTheAYDVZ2bGf
 PnfyQ1Nv58WUJDF3qv9UlGvPLQ4ac9aFSqF/P44htGbQ6H7EG2zowpNt9XUklw==
Date: Tue, 16 Dec 2025 12:19:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 4/7] usb: ci_udc: Convert driver to DM_USB_GADGET
To: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, George Chan
 <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>,
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
 <20251216-imx8ulp-v1-4-504115a53020@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251216-imx8ulp-v1-4-504115a53020@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 24d0a0643f3d1387845
X-MBO-RS-META: on8d8cfyy77kto8oh954rxj1z155atm1
X-Rspamd-Queue-Id: 4dW1NW3BGBz9tQ8
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

On 12/16/25 7:38 AM, alice.guo@oss.nxp.com wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> Convert the ci_udc driver to driver model by using the uclass
> UCLASS_USB_GADGET_GENERIC. The clk and power of USB controller and USB
> PHY both are initialized by parsing the device tree nodes.
> 
> If CONFIG_DM_USB_GADGET is defined, we use the ci_udc driver in DM way,
> if it does not defined, we can use ci_udc driver in its original Non-DM
> way.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>   drivers/usb/gadget/ci_udc.c | 352 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 348 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
> index 4bff75da759..154a3ab7f22 100644
> --- a/drivers/usb/gadget/ci_udc.c
> +++ b/drivers/usb/gadget/ci_udc.c
> @@ -7,9 +7,17 @@
>    * Murray.Jensen@cmst.csiro.au, 27-Jan-01.
>    */
>   
> +#include <asm/arch/sys_proto.h>
> +#include <asm/arch/clock.h>
> +#include <asm/mach-imx/regs-usbphy.h>
> +#include <clk.h>
>   #include <command.h>
>   #include <config.h>
>   #include <cpu_func.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/pinctrl.h>
> +#include <power-domain.h>
>   #include <net.h>
>   #include <malloc.h>
>   #include <wait_bit.h>
> @@ -22,6 +30,8 @@
>   #include <linux/types.h>
>   #include <linux/usb/ch9.h>
>   #include <linux/usb/gadget.h>
> +#include <linux/usb/otg.h>
> +#include <usb/ehci-ci.h>
>   #include <usb/ci_udc.h>
>   #include "../host/ehci.h"
>   #include "ci_udc.h"

Can we reduce the amount of headers included by this driver ?

[...]

> +#if defined(CONFIG_MX6)

Can we somehow reduce the ifdeffery ? Use if (IS_ENABLED(...)) for example ?

[...]
