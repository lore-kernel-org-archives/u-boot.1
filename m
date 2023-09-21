Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AA5E7D0A2
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 20:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C83386459;
	Thu, 21 Sep 2023 22:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CB9786466; Thu, 21 Sep 2023 22:29:37 +0200 (CEST)
Received: from fx.arvanta.net (93-87-244-166.static.isp.telekom.rs
 [93.87.244.166]) by phobos.denx.de (Postfix) with ESMTP id 49B33863DE
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 22:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1 (m1pro.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id 3628D7E3F;
 Thu, 21 Sep 2023 22:29:08 +0200 (CEST)
Date: Thu, 21 Sep 2023 22:29:33 +0200
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] riscv: set fdtfile on VisionFive 2
Message-ID: <20230921202933.GA22421@m1>
References: <20230907112128.342315-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230907112128.342315-1-heinrich.schuchardt@canonical.com>
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

On Thu, 2023-09-07 at 13:21, Heinrich Schuchardt wrote:
> Multiple revisions of the StarFive VisionFive 2 board exist. They can be
> identified by reading their EEPROM.
> 
> Linux uses two differently named device-tree files. To load the correct
> device-tree we need to set $fdtfile to the device-tree file name that
> matches the board revision.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Tested-by: Milan P. Stanić <mps@arvanta.net>
> ---
>  arch/riscv/Kconfig                            |  1 +
>  .../visionfive2/starfive_visionfive2.c        | 43 ++++++++++++++++++-
>  2 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6771d8d919..1c62c2345b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -26,6 +26,7 @@ config TARGET_SIFIVE_UNMATCHED
>  
>  config TARGET_STARFIVE_VISIONFIVE2
>  	bool "Support StarFive VisionFive2 Board"
> +	select BOARD_LATE_INIT
>  
>  config TARGET_TH1520_LPI4A
>  	bool "Support Sipeed's TH1520 Lichee PI 4A Board"
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
> index d609262b67..05d8d2d657 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -5,14 +5,20 @@
>   */
>  
>  #include <common.h>
> -#include <asm/io.h>
> -#include <asm/sections.h>
>  #include <cpu_func.h>
>  #include <dm.h>
> +#include <env.h>
> +#include <asm/arch/eeprom.h>
> +#include <asm/io.h>
> +#include <asm/sections.h>
>  #include <linux/bitops.h>
>  
>  #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
>  #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
> +#define FDTFILE_VISIONFIVE2_1_2A \
> +	"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
> +#define FDTFILE_VISIONFIVE2_1_3B \
> +	"starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
>  
>  /* enable U74-mc hart1~hart4 prefetcher */
>  static void enable_prefetcher(void)
> @@ -33,6 +39,31 @@ static void enable_prefetcher(void)
>  	}
>  }
>  
> +/**
> + * set_fdtfile() - set the $fdtfile variable based on the board revision
> + */
> +static void set_fdtfile(void)
> +{
> +	u8 version;
> +	const char *fdtfile;
> +
> +	version = get_pcb_revision_from_eeprom();
> +	switch (version) {
> +	case 'a':
> +	case 'A':
> +		fdtfile = FDTFILE_VISIONFIVE2_1_2A;
> +	        break;
> +
> +	case 'b':
> +	case 'B':
> +	default:
> +		fdtfile = FDTFILE_VISIONFIVE2_1_3B;
> +	        break;
> +	};
> +
> +	env_set("fdtfile", fdtfile);
> +}
> +
>  int board_init(void)
>  {
>  	enable_caches();
> @@ -41,6 +72,14 @@ int board_init(void)
>  	return 0;
>  }
>  
> +int board_late_init(void)
> +{
> +	if (CONFIG_IS_ENABLED(ID_EEPROM))
> +		set_fdtfile();
> +
> +	return 0;
> +}
> +
>  void *board_fdt_blob_setup(int *err)
>  {
>  	*err = 0;
