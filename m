Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6CFC4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0932D879D2;
	Fri, 12 Jan 2024 22:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nHwkijM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA4C587831; Fri, 12 Jan 2024 22:15:31 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F0A2807A7
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CLFJdk007180;
 Fri, 12 Jan 2024 15:15:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705094119;
 bh=GgrvG7ZpGlQpMeqltL4Mn/ThoNEa/TmxhOOCyfi2RTE=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=nHwkijM+cl8iD96aTLLaSQMn3R+OwHGuRkKM5cE+1sQGVlogVKmR/HlCL6Y/hGZCI
 sgugPkR3etTdSgE+u2IV6zdE5BU4WlK5XnFE/3ddb94d6HdXxZfOmnOCOqHbob+jP8
 YSoq42VfPlOvM/JsosrwywjBwsXVmvzSeW3EbsvA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CLFJ1j082992
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 15:15:19 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 15:15:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 15:15:15 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CLFF5Y061908;
 Fri, 12 Jan 2024 15:15:15 -0600
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
Subject: Re: [PATCH V2 07/10] board: ti: j721s2: Set fdtfile from C code
 instead of findfdt script
In-Reply-To: <20240109191506.3820908-8-nm@ti.com>
References: <20240109191506.3820908-1-nm@ti.com>
 <20240109191506.3820908-8-nm@ti.com>
Date: Fri, 12 Jan 2024 15:15:15 -0600
Message-ID: <86o7dqckyk.fsf@udb0321960.dhcp.ti.com>
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
>
> V1: https://lore.kernel.org/r/20240108173301.2692332-8-nm@ti.com
>  board/ti/j721s2/evm.c      | 8 ++++++++
>  board/ti/j721s2/j721s2.env | 8 --------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
> index 1220cd84519b..5a0281d6b483 100644
> --- a/board/ti/j721s2/evm.c
> +++ b/board/ti/j721s2/evm.c
> @@ -23,6 +23,7 @@
>  #include <dm/root.h>
>  
>  #include "../common/board_detect.h"
> +#include "../common/fdt_ops.h"
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -114,6 +115,12 @@ int checkboard(void)
>  	return 0;
>  }
>  
> +static struct ti_fdt_map ti_j721s2_evm_fdt_map[] = {
> +	{"j721s2", "k3-j721s2-common-proc-board.dtb"},
> +	{"am68-sk", "k3-am68-sk-base-board.dtb"},
> +	{ /* Sentinel. */ }
> +};
> +
>  static void setup_board_eeprom_env(void)
>  {
>  	char *name = "j721s2";
> @@ -131,6 +138,7 @@ static void setup_board_eeprom_env(void)
>  
>  invalid_eeprom:
>  	set_board_info_env_am6(name);
> +	ti_set_fdt_env(name, ti_j721s2_evm_fdt_map);
>  }
>  
>  static void setup_serial(void)
> diff --git a/board/ti/j721s2/j721s2.env b/board/ti/j721s2/j721s2.env
> index 64e3d9da85f0..9a03b9f30aee 100644
> --- a/board/ti/j721s2/j721s2.env
> +++ b/board/ti/j721s2/j721s2.env
> @@ -7,14 +7,6 @@
>  #include <env/ti/k3_rproc.env>
>  #endif
>  
> -default_device_tree=ti/k3-j721s2-common-proc-board.dtb
> -findfdt=
> -	setenv name_fdt ${default_device_tree};
> -	if test $board_name = j721s2; then			\
> -		setenv name_fdt ti/k3-j721s2-common-proc-board.dtb; fi;
> -	if test $board_name = am68-sk; then
> -		setenv name_fdt ti/k3-am68-sk-base-board.dtb; fi;
> -	setenv fdtfile ${name_fdt}
>  name_kern=Image
>  console=ttyS2,115200n8
>  args_all=setenv optargs earlycon=ns16550a,mmio32,0x02880000
> -- 
> 2.43.0

Reviewed-by: Jonathan Humphreys <j-humphreys@ti.com>
