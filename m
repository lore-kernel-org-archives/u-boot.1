Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF18C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 13:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7221187807;
	Tue,  9 Jan 2024 14:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j6xOCyOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C8AD87800; Tue,  9 Jan 2024 14:08:28 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E65E86E82
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 14:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id A9690B81A16;
 Tue,  9 Jan 2024 13:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70750C433C7;
 Tue,  9 Jan 2024 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704805705;
 bh=vQFMxnxdhO9+AGOwngSFiyR8Hlz+wZtLxv8qsp9UYC0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=j6xOCyOrMDkFHK77OC3E0EphNKZRaaAoJUoOudSpwtZMsTZUECEWFXAzNyNQyGFds
 dIHdtPO9wd5E3atnYJk6kQdvpl8zEjCm0hA0ZJD983k4AeQju8yZQ0oicF4kuJhKaH
 sMUL4QLYgX8AIk7bzhQ7TniUF+W9XbDMaE1dJUZaGWEjUfpZAKXz4NnBIYk/DyPgu4
 2udVFk08FYZShEFq5HeD1u5sQduxJjnbPY2BCmP2/BgPq+SVtGlpPZacX3eWpZSYHj
 QCORwRu36/FAt8vu96qIgk8fm/2+aUMtEr5rn2YR7aroCfc7tVi0buylf24Pyjld8R
 /AFAA6huFpjYQ==
Message-ID: <ec2ead48-0aaa-44fd-be71-545a7e3d59e1@kernel.org>
Date: Tue, 9 Jan 2024 15:08:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] board: ti: am64x: Set fdtfile from C code instead
 of findfdt script
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 u-boot@lists.denx.de, Jon Humphreys <j-humphreys@ti.com>
References: <20240108173301.2692332-1-nm@ti.com>
 <20240108173301.2692332-5-nm@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240108173301.2692332-5-nm@ti.com>
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
>  board/ti/am64x/am64x.env | 9 ---------
>  board/ti/am64x/evm.c     | 8 ++++++++
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/board/ti/am64x/am64x.env b/board/ti/am64x/am64x.env
> index efd736b99be4..9a8812d4ee54 100644
> --- a/board/ti/am64x/am64x.env
> +++ b/board/ti/am64x/am64x.env
> @@ -2,14 +2,6 @@
>  #include <env/ti/mmc.env>
>  #include <env/ti/k3_dfu.env>
>  
> -findfdt=
> -	if test $board_name = am64x_gpevm; then
> -		setenv name_fdt ti/k3-am642-evm.dtb; fi;
> -	if test $board_name = am64x_skevm; then
> -		setenv name_fdt ti/k3-am642-sk.dtb; fi;
> -	if test $name_fdt = undefined; then
> -		echo WARNING: Could not determine device tree to use; fi;
> -	setenv fdtfile ${name_fdt}
>  name_kern=Image
>  console=ttyS2,115200n8
>  args_all=setenv optargs earlycon=ns16550a,mmio32,0x02800000 ${mtdparts}
> @@ -43,7 +35,6 @@ get_fit_usb=load usb ${bootpart} ${addr_fit}
>  usbboot=setenv boot usb;
>  	setenv bootpart 0:2;
>  	usb start;
> -	run findfdt;
>  	run init_usb;
>  	run get_kern_usb;
>  	run get_fdt_usb;
> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
> index a6dcff2eb434..e2f506d2c6ea 100644
> --- a/board/ti/am64x/evm.c
> +++ b/board/ti/am64x/evm.c
> @@ -16,6 +16,7 @@
>  #include <env.h>
>  
>  #include "../common/board_detect.h"
> +#include "../common/fdt_ops.h"
>  
>  #define board_is_am64x_gpevm() (board_ti_k3_is("AM64-GPEVM") || \
>  				board_ti_k3_is("AM64-HSEVM"))
> @@ -180,6 +181,12 @@ int checkboard(void)
>  }
>  
>  #ifdef CONFIG_BOARD_LATE_INIT
> +static struct ti_fdt_map ti_am64_evm_fdt_map[] = {
> +	{"am64x_gpevm", "k3-am642-evm.dtb"},
> +	{"am64x_skevm", "k3-am642-sk.dtb"},

"am64x_gpevm" and "am64x_skevm" strings are used multiple times in this file.
see setup_board_eeprom_env()

Please use a MACRO for them.

What is the logic of choosing this name and can it be updated at this point?
e.g."gp" is misleading in the board name as the boards are now shipped with
HS-FS chip and are no longer GP.


> +	{ /* Sentinel. */ }
> +};
> +
>  static void setup_board_eeprom_env(void)
>  {
>  	char *name = "am64x_gpevm";
> @@ -197,6 +204,7 @@ static void setup_board_eeprom_env(void)
>  
>  invalid_eeprom:
>  	set_board_info_env_am6(name);
> +	ti_set_fdt_env(name, ti_am64_evm_fdt_map);
>  }
>  
>  static void setup_serial(void)

-- 
cheers,
-roger
