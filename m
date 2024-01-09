Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1C2C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 16:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E139687807;
	Tue,  9 Jan 2024 17:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fFEjvEO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 453088785D; Tue,  9 Jan 2024 17:20:13 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E59186E82
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 17:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id DADB8B81B7B;
 Tue,  9 Jan 2024 16:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5BFC433F1;
 Tue,  9 Jan 2024 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704817210;
 bh=Hh00nS/dIH9X2YMwFoE17OtGfmz5ujkUekUGvUIQyJs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fFEjvEO+7L1NMMnvIobbADRA/f9qs3F506FoiUk3VE2pOX+2HUvnxmmUGZDm/OSTi
 qROMH8B3ZGXB+0t0yfLCl0JFERZ3pw0GeCZVLo6RxhbDfBvWnNWBugXbNcqkSPM4q/
 gSr2DE7VvXZNjIO7yBgsseMlnlg2Js3fX3nNL7y7cHr9+kkG4boBbzHfNE+Y/262YV
 0XYnU3eYKL8u9jmia/s970+PjIZ/5lUzatPEniVM/WhWM9pVc4M73zrRPDp7nLmiiP
 ++tggG1FQGGuE+KexIPc8N37OO5W2lwcYL4aZAK7WXjTc5Jvp1pLDUmRDyqDpgrlQh
 gnLz4UNyCI6AA==
Message-ID: <b72e518a-dc63-4e98-ad3b-20c589e3ae8d@kernel.org>
Date: Tue, 9 Jan 2024 18:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] board: ti: j721e: Set fdtfile from C code instead
 of findfdt script
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 u-boot@lists.denx.de, Jon Humphreys <j-humphreys@ti.com>
References: <20240108173301.2692332-1-nm@ti.com>
 <20240108173301.2692332-7-nm@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240108173301.2692332-7-nm@ti.com>
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



On 08/01/2024 19:32, Nishanth Menon wrote:
> We now can provide a map and have the standard fdtfile variable set from
> code itself. This allows for bootstd to "just work".
> 
> While at this, replace findfdt in environment with a warning as it is no
> longer needed.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  board/ti/j721e/evm.c     |  8 ++++++++
>  board/ti/j721e/j721e.env | 10 ----------
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index c541880107ec..ad6ef4553e04 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -16,6 +16,7 @@
>  #include <dm.h>
>  
>  #include "../common/board_detect.h"
> +#include "../common/fdt_ops.h"
>  
>  #define board_is_j721e_som()	(board_ti_k3_is("J721EX-PM1-SOM") || \
>  				 board_ti_k3_is("J721EX-PM2-SOM"))
> @@ -424,6 +425,12 @@ void configure_serdes_sierra(void)
>  }
>  
>  #ifdef CONFIG_BOARD_LATE_INIT
> +static struct ti_fdt_map ti_j721e_evm_fdt_map[] = {
> +	{"j721e", "k3-j721e-common-proc-board.dtb"},
> +	{"j721e-sk", "k3-j721e-sk.dtb"},

You missed "j721e-eaik"

> +	{"j7200", "k3-j7200-common-proc-board.dtb"},
> +	{ /* Sentinel. */ }
> +};
>  static void setup_board_eeprom_env(void)
>  {
>  	char *name = "j721e";
> @@ -443,6 +450,7 @@ static void setup_board_eeprom_env(void)
>  
>  invalid_eeprom:
>  	set_board_info_env_am6(name);
> +	ti_set_fdt_env(name, ti_j721e_evm_fdt_map);
>  }
>  
>  static void setup_serial(void)
> diff --git a/board/ti/j721e/j721e.env b/board/ti/j721e/j721e.env
> index cb27bf5e2b24..38bfd7d49634 100644
> --- a/board/ti/j721e/j721e.env
> +++ b/board/ti/j721e/j721e.env
> @@ -7,16 +7,6 @@
>  #include <env/ti/k3_rproc.env>
>  #endif
>  
> -default_device_tree=ti/k3-j721e-common-proc-board.dtb
> -findfdt=
> -	setenv name_fdt ${default_device_tree};
> -	if test $board_name = j721e; then
> -		setenv name_fdt ti/k3-j721e-common-proc-board.dtb; fi;
> -	if test $board_name = j7200; then
> -		setenv name_fdt ti/k3-j7200-common-proc-board.dtb; fi;
> -	if test $board_name = j721e-eaik || test $board_name = j721e-sk; then
> -		setenv name_fdt ti/k3-j721e-sk.dtb; fi;
> -	setenv fdtfile ${name_fdt}
>  name_kern=Image
>  console=ttyS2,115200n8
>  args_all=setenv optargs earlycon=ns16550a,mmio32,0x02800000

-- 
cheers,
-roger
