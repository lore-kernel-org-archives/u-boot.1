Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429ECC3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 22:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C00C8826B2;
	Fri,  4 Apr 2025 00:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o8La1++8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B4CA8272A; Fri,  4 Apr 2025 00:08:10 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B792C826AD
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 00:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 533M7xTL3660738
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Apr 2025 17:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743718079;
 bh=g2+OI+7c7xX+9PpD+VB5hlf+uUYiWBd45Te073JrbFQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=o8La1++8UlbDRLRv8syq3nouvcvmG0OiypAKIClWubLOG2paAjEprHIz+ECJpIx/w
 3YTXIZPW9qaniLq4jPpfc2yXX3CYYNEhTbzGLH3fi4pcraiu+YXi95phfE05zkalvf
 iJxoraMywyUNRh6VAkj5d77+RgXTCGyAgRBDk3dk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 533M7xTx006981
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 3 Apr 2025 17:07:59 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Apr 2025 17:07:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Apr 2025 17:07:59 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 533M7wlC100562;
 Thu, 3 Apr 2025 17:07:59 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 4 Apr 2025 03:37:49 +0530
Message-ID: <D8XCGUNXMB3R.QTEG81HJ8201@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>
Subject: Re: [PATCH v5] spl: remove usage of CMD_BOOT[IZ] from image parsing
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250314035505.4029331-1-anshuld@ti.com>
In-Reply-To: <20250314035505.4029331-1-anshuld@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Fri Mar 14, 2025 at 9:25 AM IST, Anshul Dalal wrote:
> Using CMD_* configs from spl doesn't make logical sense. Therefore this
> patch replaces the checks for CMD_BOOT[IZ] with newly added configs
> SPL_HAS_BOOT[IZ].
>
> SPL_HAS_BOOTZ is enabled by default for 32-bit ARM systems and
> SPL_HAS_BOOTI is enabled by default for 64-bit ARM and RISCV. This
> ensures configs relying on CMD_BOOT[IZ] in falcon boot still work.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Changes in v5:
>  * Remove imply clause for CMD_BOOTZ instead add default y for SPL_HAS_BO=
OTZ
>  * Update commit message to reflect the changes
>  * Remove 'More info' link
> v4: https://lore.kernel.org/u-boot/20250313032842.1189977-1-anshuld@ti.co=
m/
> Changes in v4:
>  * Don't set SPL_HAS_BOOTI for sandbox by default
>  * Updated prompts for SPL_HAS_BOOT[IZ]
>  * Removed check for SPL_HAS_FRAMEWORK from Makefile
> v3: https://lore.kernel.org/u-boot/20250312124757.789013-1-anshuld@ti.com=
/
> Changes in v3:
>  * Add imply clause for CMD_BOOTZ to enable SPL_HAS_BOOTZ
>  * Fix broken check for bootz_setup
> v2: https://lore.kernel.org/u-boot/20250312094241.629707-1-anshuld@ti.com=
/
> Changes in v2:
>  * Add SPL_HAS_BOOT[IZ] configs
> v1: https://lore.kernel.org/u-boot/20250311093709.3372104-1-anshuld@ti.co=
m/
> ---
>  arch/arm/lib/Makefile |  6 ++----
>  common/spl/Kconfig    | 14 ++++++++++++++
>  common/spl/spl.c      |  5 +++--
>  3 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 1c95dd6fed2..e409f7a7947 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -35,10 +35,8 @@ obj-$(CONFIG_CMD_BOOTM) +=3D bootm.o
>  obj-$(CONFIG_CMD_BOOTZ) +=3D bootm.o zimage.o
>  else
>  obj-$(CONFIG_$(PHASE_)FRAMEWORK) +=3D spl.o
> -ifdef CONFIG_SPL_FRAMEWORK
> -obj-$(CONFIG_CMD_BOOTI) +=3D image.o
> -obj-$(CONFIG_CMD_BOOTZ) +=3D zimage.o
> -endif
> +obj-$(CONFIG_SPL_HAS_BOOTI) +=3D image.o
> +obj-$(CONFIG_SPL_HAS_BOOTZ) +=3D zimage.o
>  obj-$(CONFIG_OF_LIBFDT) +=3D bootm-fdt.o
>  endif
>  ifdef CONFIG_ARM64
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 21a5cefee7a..1d690bee389 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1153,6 +1153,20 @@ config SPL_OS_BOOT
>  	  Enable booting directly to an OS from SPL.
>  	  for more info read doc/README.falcon
> =20
> +config SPL_HAS_BOOTZ
> +	bool "Allow booting a zImage style Linux kernel from SPL"
> +	depends on SPL_OS_BOOT
> +	default y if ARM && !ARM64
> +	help
> +	  Boot a linux zimage from memory in falcon boot.
> +
> +config SPL_HAS_BOOTI
> +	bool "Allow booting an Image style Linux kernel from SPL"
> +	depends on SPL_OS_BOOT
> +	default y if ARM64 || RISCV
> +	help
> +	  Boot an uncompressed linux kernel image from memory in falcon boot.
> +
>  config SPL_PAYLOAD_ARGS_ADDR
>  	hex "Address in memory to load 'args' file for Falcon Mode to"
>  	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 76fd56dfe4b..445c3ef24fe 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -335,7 +335,7 @@ int spl_parse_image_header(struct spl_image_info *spl=
_image,
>  		panic("** no mkimage signature but raw image not supported");
>  	}
> =20
> -	if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI)) {
> +	if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_SPL_HAS_BOOTI)) {
>  		ulong start, size;
> =20
>  		if (!booti_setup((ulong)header, &start, &size, 0)) {
> @@ -349,7 +349,8 @@ int spl_parse_image_header(struct spl_image_info *spl=
_image,
>  			      spl_image->load_addr, spl_image->size);
>  			return 0;
>  		}
> -	} else if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTZ)) =
{
> +	} else if (CONFIG_IS_ENABLED(OS_BOOT) &&
> +		   IS_ENABLED(CONFIG_SPL_HAS_BOOTZ)) {
>  		ulong start, end;
> =20
>  		if (!bootz_setup((ulong)header, &start, &end)) {

Superseded by v6:
https://lore.kernel.org/u-boot/20250403215522.1284502-1-anshuld@ti.com/

Anshul
