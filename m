Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C93E7AD4B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B25108747F;
	Tue,  3 Oct 2023 15:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Owdxq/SL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ti21tFOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 422C387494; Tue,  3 Oct 2023 15:41:00 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62C3B8747E
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S0Jqt11fdz9sTH;
 Tue,  3 Oct 2023 15:40:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7aeRUJidMCD2ssFNkDkbrn7n0J5/x9R5wkBxLppQXk=;
 b=Owdxq/SLgm4h30mTbIMkLBFfDojSJFgELib/Cy1fbuemc0OsE4erPgJmmGZZg/026l+bBT
 An0rA/aZF9QtxlPzaM61EhiCmG4CJG4rFYrVsIHzccBNabSi4/D0Iphjr5I0bR56wJP84G
 lQkbGix8t415Y48rl7xdBrcqWSNEwFW0qCwsjmpKCYX2AH4iVrNC2faUa4rnu/u72F82N7
 xBF6Ug/OBrumsYREHb1Ga01kUMp8uk8+MCohUvUH7g6FaqOEwp747H+dfANVehX6wwqAGc
 V5H4pXhEskV8IoNQl+nNge7Od2incHOnPMYgZxdCEvJpe6A7C06p/OTYmgxqkA==
Message-ID: <94bd4c16-67c4-828d-7eb2-fe6a68df4800@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7aeRUJidMCD2ssFNkDkbrn7n0J5/x9R5wkBxLppQXk=;
 b=Ti21tFOdq9qFX96NYEv/+KZMx2me6yjXPbOGKIUZP0YKbscMXXmAmfKNHZn+tKct+d3nn4
 jVqwMnfFwP5bypkrgSdH4NgpRK4/T0yJDiMnwRm0nOmprUQ6zkeo6UiVt/DE83CPyw3gG5
 sj5RiiOlkqntSzUKoARnO/eiCh/tTySMnDd5mcnZyvdW33g74obzZxS0REycBf30SH5XER
 4AwzqOeBc/sy5tbIXn4jcUoL3K0vR7fna0J2Q1qktPzq0zfADTb1bWbIDED+r6wHdgIh5n
 kfFiAzl0VEwQsEJwn1sKcfOEae1CKAwscNpS7hM3UEtM7NxdRYgKHwJDJQxrYg==
Date: Tue, 3 Oct 2023 15:23:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 10/16] serial: sh: Add RZ/G2L SCIF support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-11-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-11-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4ucsa4t579dyxgey8s88wfkbj64jcxmi
X-MBO-RS-ID: 5c0d7dcf7f04fb6a91a
X-Rspamd-Queue-Id: 4S0Jqt11fdz9sTH
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

On 9/20/23 14:42, Paul Barker wrote:
> Extend the existing driver to support the SCIF serial ports on the
> Renesas RZ/G2L (R9A07G044) SoC. This also requires us to ensure that the
> relevant reset signal is de-asserted before we try to talk to the SCIF
> module.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   arch/arm/mach-rmobile/Kconfig |  1 +
>   drivers/serial/serial_sh.c    | 32 ++++++++++++++++++++++++++++++--
>   drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
>   3 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
> index 973e84fcf7ba..0ab22356aee5 100644
> --- a/arch/arm/mach-rmobile/Kconfig
> +++ b/arch/arm/mach-rmobile/Kconfig
> @@ -77,6 +77,7 @@ config RZG2L
>   	imply RENESAS_SDHI
>   	imply CLK_RZG2L
>   	imply PINCTRL_RZG2L
> +	imply SCIF_CONSOLE
>   	help
>   	  Enable support for the Renesas RZ/G2L family of SoCs, including the
>   	  the RZ/G2L itself (based on the R9A07G044 SoC).
> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
> index 5e543dbf3d58..a2e9a57137a6 100644
> --- a/drivers/serial/serial_sh.c
> +++ b/drivers/serial/serial_sh.c
> @@ -17,6 +17,8 @@
>   #include <linux/compiler.h>
>   #include <dm/platform_data/serial_sh.h>
>   #include <linux/delay.h>
> +#include <dm/device_compat.h>
> +#include <reset.h>
>   #include "serial_sh.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
> @@ -79,8 +81,16 @@ sh_serial_setbrg_generic(struct uart_port *port, int clk, int baudrate)
>   
>   static void handle_error(struct uart_port *port)
>   {
> -	sci_in(port, SCxSR);
> -	sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
> +	/* The RZ/G2L datasheet says that error conditions are cleared by
> +	 * resetting the error bits in the FSR register to zero.

Can you be more specific here ?

It doesn't seem Linux sh-sci.c driver does anything special for G2L, so 
is this special case really needed ?

> +	 */
> +	if (IS_ENABLED(CONFIG_RZG2L)) {
> +		unsigned short status = sci_in(port, SCxSR);
> +		sci_out(port, SCxSR, status & ~SCIF_ERRORS);
> +	} else {
> +		sci_in(port, SCxSR);
> +		sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
> +	}
>   	sci_in(port, SCLSR);
>   	sci_out(port, SCLSR, 0x00);
>   }
> @@ -193,6 +203,23 @@ static int sh_serial_probe(struct udevice *dev)
>   	priv->type	= plat->type;
>   	priv->clk_mode	= plat->clk_mode;
>   
> +	if (IS_ENABLED(CONFIG_RZG2L)) {
> +		struct reset_ctl rst;
> +		int ret;
> +
> +		ret = reset_get_by_index(dev, 0, &rst);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to get reset line\n");
> +			return ret;
> +		}
> +
> +		ret = reset_deassert(&rst);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to de-assert reset line\n");
> +			return ret;
> +		}
> +	}

devm_reset_control_get_optional() or something should do here too , right ?

Note that R-Car does have SCIF reset too, so this can be generic code.
