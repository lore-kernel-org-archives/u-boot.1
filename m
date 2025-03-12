Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2412C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 12:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45372801FB;
	Wed, 12 Mar 2025 13:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JhoAK1hz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07C4880756; Wed, 12 Mar 2025 13:53:57 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC18801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 13:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52CCrqlk1496999
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Mar 2025 07:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741784032;
 bh=7OgyJQEvwoRtI2R/LaieyHOpMr2pO6u/b6B6BSZPgQM=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=JhoAK1hzIkDWYKYPJzSrPZp1vyLsS7LiUksXQNDNSiN0LwiEsD7SkCqbnWFOpxBFl
 7A6w+x24AJ2GrN3Aw75qBmBAnkAKmthlPmCfwy4nyGDb64lGMTJwWKLbA8oWZo8EXr
 /48vjIWyquXceQdLY0xju6aoFvri0qSOW8jNvLdI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52CCrqgM073874
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Mar 2025 07:53:52 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Mar 2025 07:53:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Mar 2025 07:53:51 -0500
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.196])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52CCroYO062647;
 Wed, 12 Mar 2025 07:53:51 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 Mar 2025 18:23:50 +0530
Message-ID: <D8EAWP9N9CEV.U2POOXX6G9OB@ti.com>
CC: <vigneshr@ti.com>, <trini@konsulko.com>
Subject: Re: [PATCH v2] spl: remove usage of CMD_BOOT[IZ] from image parsing
From: Anshul Dalal <anshuld@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.17.0
References: <20250312094241.629707-1-anshuld@ti.com>
In-Reply-To: <20250312094241.629707-1-anshuld@ti.com>
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

On Wed Mar 12, 2025 at 3:12 PM IST, Anshul Dalal wrote:
> Using CMD_* configs from spl doesn't make logical sense. Therefore this
> patch replaces the checks for CMD_BOOT[IZ] with newly added configs
> SPL_HAS_BOOT[IZ].
>
> More info:
> https://lore.kernel.org/u-boot/20250310135544.GV2640854@bill-the-cat/
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Changes in v2:
>  * Add SPL_HAS_BOOT[IZ] configs
> v1: https://lore.kernel.org/u-boot/20250311093709.3372104-1-anshuld@ti.co=
m/
> ---
>  arch/arm/lib/Makefile |  4 ++--
>  common/spl/Kconfig    | 13 +++++++++++++
>  common/spl/spl.c      |  6 +++---
>  3 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 1c95dd6fed2..e857adddd03 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -36,8 +36,8 @@ obj-$(CONFIG_CMD_BOOTZ) +=3D bootm.o zimage.o
>  else
>  obj-$(CONFIG_$(PHASE_)FRAMEWORK) +=3D spl.o
>  ifdef CONFIG_SPL_FRAMEWORK
> -obj-$(CONFIG_CMD_BOOTI) +=3D image.o
> -obj-$(CONFIG_CMD_BOOTZ) +=3D zimage.o
> +obj-$(CONFIG_SPL_HAS_BOOTI) +=3D image.o
> +obj-$(CONFIG_SPL_HAS_BOOTZ) +=3D zimage.o
>  endif
>  obj-$(CONFIG_OF_LIBFDT) +=3D bootm-fdt.o
>  endif
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 21a5cefee7a..36c0fb063d0 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1153,6 +1153,19 @@ config SPL_OS_BOOT
>  	  Enable booting directly to an OS from SPL.
>  	  for more info read doc/README.falcon
> =20
> +config SPL_HAS_BOOTZ
> +	bool "Allow booting to kernel zimage from SPL"
> +	depends on SPL_OS_BOOT
> +	help
> +	  Boot a linux zimage from memory in falcon boot.
> +
> +config SPL_HAS_BOOTI
> +	bool "Allow booting to kernel image from SPL"
> +	depends on SPL_OS_BOOT
> +	default y if ARM64 || RISCV || SANDBOX
> +	help
> +	  Boot an AArch64 Linux Kernel image from memory in falcon boot.
> +
>  config SPL_PAYLOAD_ARGS_ADDR
>  	hex "Address in memory to load 'args' file for Falcon Mode to"
>  	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 76fd56dfe4b..8905c776ea5 100644
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
> @@ -349,9 +349,9 @@ int spl_parse_image_header(struct spl_image_info *spl=
_image,
>  			      spl_image->load_addr, spl_image->size);
>  			return 0;
>  		}
> -	} else if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTZ)) =
{
> +	} else if (CONFIG_IS_ENABLED(OS_BOOT) &&
> +		   IS_ENABLED(CONFIG_SPL_HAS_BOOTI)) {
>  		ulong start, end;
> -
>  		if (!bootz_setup((ulong)header, &start, &end)) {
>  			spl_image->name =3D "Linux";
>  			spl_image->os =3D IH_OS_LINUX;

Superseded by v3:
https://lore.kernel.org/u-boot/20250312124757.789013-1-anshuld@ti.com/

Anshul
