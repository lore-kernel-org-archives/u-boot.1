Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D1ECA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 08:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E48BB86604;
	Tue, 12 Sep 2023 10:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C07E286604; Tue, 12 Sep 2023 10:26:14 +0200 (CEST)
Received: from fx.arvanta.net (unknown [109.72.52.77])
 by phobos.denx.de (Postfix) with ESMTP id CB51586400
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 10:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1 (m1pro.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id 232A324002;
 Tue, 12 Sep 2023 10:26:11 +0200 (CEST)
Date: Tue, 12 Sep 2023 10:26:10 +0200
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Jami Kettunen <jamipkettunen@gmail.com>
Cc: u-boot@lists.denx.de, Mason Huo <mason.huo@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Shengyu Qu <wiagn233@outlook.com>,
 Jami Kettunen <jami.kettunen@protonmail.com>
Subject: Re: [PATCH RFC 1/2] board: visionfive2: Select fdtfile based on
 revision
Message-ID: <20230912082610.GA16039@m1>
References: <20230911153253.20701-1-jamipkettunen@gmail.com>
 <20230911153253.20701-2-jamipkettunen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911153253.20701-2-jamipkettunen@gmail.com>
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

On Mon, 2023-09-11 at 18:32, Jami Kettunen wrote:
> From: Jami Kettunen <jami.kettunen@protonmail.com>
> 
> Linux mainline kernel device tree files[1] are named:
> - jh7110-starfive-visionfive-2-v1.2a
> - jh7110-starfive-visionfive-2-v1.3b
> 
> which should be selected accordingly by U-Boot to have a proper extlinux
> experience with fdtdir set by the distribution.
> 
> [1] https://github.com/torvalds/linux/tree/master/arch/riscv/boot/dts/starfive
> 
> Signed-off-by: Jami Kettunen <jami.kettunen@protonmail.com>

Tested-by: Milan P. Stanić <mps@arvanta.net>

> ---
>  .../visionfive2/starfive_visionfive2.c        | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
> index d609262b67..9244d4654b 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -10,6 +10,8 @@
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> +#include <asm/arch-jh7110/eeprom.h>
> +#include <env.h>
>  
>  #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
>  #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
> @@ -41,6 +43,29 @@ int board_init(void)
>  	return 0;
>  }
>  
> +int misc_init_r(void)
> +{
> +	u8 rev;
> +	const char *linux_dtb_file;
> +
> +	rev = get_pcb_revision_from_eeprom();
> +	switch (rev) {
> +	case 'a':
> +	case 'A':
> +		linux_dtb_file = "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
> +		break;
> +
> +	case 'b':
> +	case 'B':
> +	default:
> +		linux_dtb_file = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
> +		break;
> +	};
> +
> +	env_set("fdtfile", linux_dtb_file);
> +	return 0;
> +}
> +
>  void *board_fdt_blob_setup(int *err)
>  {
>  	*err = 0;
