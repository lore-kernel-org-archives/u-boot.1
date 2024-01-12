Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A05EC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FDE5879B0;
	Fri, 12 Jan 2024 22:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mYVI83WS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D7D87831; Fri, 12 Jan 2024 22:14:56 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2BEA807A7
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CLEkxt070184;
 Fri, 12 Jan 2024 15:14:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705094086;
 bh=4XVHAmC5/n/mFTquI2mKKvXJYUUtu8/0bfVY5IfZOPk=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=mYVI83WSPC1GL/g4s1ybXgOClGXZxpBMFXEkBT9Lra/jytfSqyWz+iWl5+U78EyLC
 5OCkPwEla/BFWHuyEDXbr6wumPvZaeeDxY629cipgq/o4YGEZzul9Zw/SGbRgCx/rb
 nojxCssJKjZvi0mH+03fwSozkXyYHGkAG+Ux7qNo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CLEkkT006349
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 15:14:46 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 15:14:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 15:14:46 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CLEktL033102;
 Fri, 12 Jan 2024 15:14:46 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Nikhil M Jain <n-jain1@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, <u-boot@lists.denx.de>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 05/10] board: ti: am65x: Set fdtfile from C code
 instead of findfdt script
In-Reply-To: <20240109191506.3820908-6-nm@ti.com>
References: <20240109191506.3820908-1-nm@ti.com>
 <20240109191506.3820908-6-nm@ti.com>
Date: Fri, 12 Jan 2024 15:14:46 -0600
Message-ID: <86wmseckzd.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 12 Jan 2024 22:26:42 +0100
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

Nishanth Menon <nm@ti.com> writes:

> We now can provide a map and have the standard fdtfile variable set from
> code itself. This allows for bootstd to "just work".
>
> While at this, replace findfdt in environment with a warning as it is no
> longer needed.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes from V1: None.
> I have retained the central call ti_set_fdt_env() to retain the
> population of fdtfile name using the CONFIG fall back logic and the
> population of (now deprecated) legacy variables for downstream script
> users.
>
> V1: https://lore.kernel.org/r/20240108173301.2692332-6-nm@ti.com
>  board/ti/am65x/am65x.env | 3 ---
>  board/ti/am65x/evm.c     | 2 ++
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/board/ti/am65x/am65x.env b/board/ti/am65x/am65x.env
> index 286b9c300c05..814374d68cf0 100644
> --- a/board/ti/am65x/am65x.env
> +++ b/board/ti/am65x/am65x.env
> @@ -5,9 +5,6 @@
>  #include <env/ti/k3_rproc.env>
>  #endif
>  
> -findfdt=
> -	setenv name_fdt ti/k3-am654-base-board.dtb;
> -	setenv fdtfile ${name_fdt}
>  name_kern=Image
>  console=ttyS2,115200n8
>  args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
> diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
> index df209021c1b7..3109c9a2acac 100644
> --- a/board/ti/am65x/evm.c
> +++ b/board/ti/am65x/evm.c
> @@ -22,6 +22,7 @@
>  #include <linux/printk.h>
>  
>  #include "../common/board_detect.h"
> +#include "../common/fdt_ops.h"
>  
>  #define board_is_am65x_base_board()	board_ti_is("AM6-COMPROCEVM")
>  
> @@ -141,6 +142,7 @@ static void setup_board_eeprom_env(void)
>  
>  invalid_eeprom:
>  	set_board_info_env_am6(name);
> +	ti_set_fdt_env(NULL, NULL);
>  }
>  
>  static int init_daughtercard_det_gpio(char *gpio_name, struct gpio_desc *desc)
> -- 
> 2.43.0

Reviewed-by: Jonathan Humphreys <j-humphreys@ti.com>
