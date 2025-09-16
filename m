Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE71CCAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 06:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF80F80B9B;
	Tue, 16 Sep 2025 08:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lDOlBOQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 606FB80B9B; Tue, 16 Sep 2025 08:29:48 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D2380422
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 08:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58G6Th6g1727135;
 Tue, 16 Sep 2025 01:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758004183;
 bh=EuQGibL66lQ1JFM0YNYr2BTSMioS2UY7z8BOuq6Kovo=;
 h=Date:Subject:From:To:References:In-Reply-To;
 b=lDOlBOQqumcYGalm6sl9krhh4Xmo0cAVtkwcyHELxpROlJJpXcbMk7xWpAr92bHiI
 SjI0sZXBKkDa2kxzCthvRez4KOUeP5/RYshYSwXPwWiaToYs2pZR1NMYoyvx8YY9QP
 gLF326gOrT02t5p6CDF4ieQ3+wGvbTlBHT4lXQX8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58G6ThK31318481
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 01:29:43 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 01:29:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 01:29:43 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58G6Tfnh1174722;
 Tue, 16 Sep 2025 01:29:42 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Sep 2025 11:59:41 +0530
Message-ID: <DCU0GZQN2183.FPGUJYH3KQ7V@ti.com>
Subject: Re: [PATCH] cmd: spl: Remove ATAG support from this command
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250915190548.446942-1-trini@konsulko.com>
In-Reply-To: <20250915190548.446942-1-trini@konsulko.com>
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

On Tue Sep 16, 2025 at 12:35 AM IST, Tom Rini wrote:
> While we continue to have some systems which support extremely legacy
> OS booting methods, we do not have use cases for supporting this in
> Falcon mode anymore. Remove this support and references from the
> documentation.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  cmd/spl.c               | 18 ---------
>  doc/README.commands.spl | 14 ++-----
>  doc/develop/falcon.rst  | 84 ++++-------------------------------------
>  include/cmd_spl.h       |  3 +-
>  4 files changed, 11 insertions(+), 108 deletions(-)
>
> diff --git a/cmd/spl.c b/cmd/spl.c
> index 379b512f1ffd..90193b43abf4 100644
> --- a/cmd/spl.c
> +++ b/cmd/spl.c
> @@ -27,19 +27,6 @@ static const char **subcmd_list[] =3D {
>  		"cmdline",
>  		"bdt",
>  		"prep",
> -#endif
> -		NULL,
> -	},
> -	[SPL_EXPORT_ATAGS] =3D (const char * []) {
> -#ifdef CONFIG_SUPPORT_PASSING_ATAGS
> -		"start",
> -		"loados",
> -#ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
> -		"ramdisk",
> -#endif
> -		"cmdline",
> -		"bdt",
> -		"prep",
>  #endif
>  		NULL,
>  	},
> @@ -96,7 +83,6 @@ static int call_bootm(int argc, char *const argv[], con=
st char *subcommand[])
> =20
>  static struct cmd_tbl cmd_spl_export_sub[] =3D {
>  	U_BOOT_CMD_MKENT(fdt, 0, 1, (void *)SPL_EXPORT_FDT, "", ""),
> -	U_BOOT_CMD_MKENT(atags, 0, 1, (void *)SPL_EXPORT_ATAGS, "", ""),
>  };
> =20
>  static int spl_export(struct cmd_tbl *cmdtp, int flag, int argc,
> @@ -128,10 +114,6 @@ static int spl_export(struct cmd_tbl *cmdtp, int fla=
g, int argc,
>  #endif
>  			break;
>  #endif
> -		case SPL_EXPORT_ATAGS:
> -			printf("Argument image is now in RAM at: 0x%p\n",
> -				(void *)gd->bd->bi_boot_params);
> -			break;
>  		}
>  	} else {
>  		/* Unrecognized command */
> diff --git a/doc/README.commands.spl b/doc/README.commands.spl
> index ecfd3ca9ee58..54cc5b1ec421 100644
> --- a/doc/README.commands.spl
> +++ b/doc/README.commands.spl
> @@ -5,24 +5,16 @@ SUBCOMMAND EXPORT
>  To execute the command everything has to be in place as if bootm should =
be
>  used. (kernel image, initrd-image, fdt-image etc.)
> =20
> -export has two subcommands:
> -	atags: exports the ATAGS
> +export has one subcommand:
>  	fdt: exports the FDT

Why do we even need the fdt subcommand anymore? Can't we just have the
command be 'spl export [kernel_addr] [initrd_addr] [fdt_addr]' now?

> =20
>  Call is:
> -spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if fdt]
> +spl export fdt [kernel_addr] [initrd_addr] [fdt_addr if fdt]
> =20

Also, we should just drop the 'if fdt' from the command help.

> =20

[snip] =20

> diff --git a/include/cmd_spl.h b/include/cmd_spl.h
> index 51ec12edb906..45ea91e9bce6 100644
> --- a/include/cmd_spl.h
> +++ b/include/cmd_spl.h
> @@ -8,7 +8,6 @@
>  #define SPL_EXPORT	(0x00000001)
> =20
>  #define SPL_EXPORT_FDT		(0x00000001)
> -#define SPL_EXPORT_ATAGS	(0x00000002)
> -#define SPL_EXPORT_LAST		SPL_EXPORT_ATAGS
> +#define SPL_EXPORT_LAST		SPL_EXPORT_FDT
> =20
>  #endif /* _NAND_SPL_H_ */

The below diff should also be part of the patch:

diff --git a/arch/arm/lib/spl.c b/arch/arm/lib/spl.c
index c43a63f1819..6c7d1fb5629 100644
--- a/arch/arm/lib/spl.c
+++ b/arch/arm/lib/spl.c
@@ -46,8 +46,7 @@ void __weak board_init_f(ulong dummy)
 }

 /*
- * This function jumps to an image with argument. Normally an FDT or ATAGS
- * image.
+ * This function jumps to an image with argument, usually an FDT.
  */
 #if CONFIG_IS_ENABLED(OS_BOOT)
 #ifdef CONFIG_ARM64
diff --git a/arch/powerpc/lib/spl.c b/arch/powerpc/lib/spl.c
index 3a24cbfff3b..a2bf52c5adc 100644
--- a/arch/powerpc/lib/spl.c
+++ b/arch/powerpc/lib/spl.c
@@ -9,8 +9,7 @@
 #include <linux/compiler.h>

 /*
- * This function jumps to an image with argument. Normally an FDT or ATAGS
- * image.
+ * This function jumps to an image with argument, usually an FDT.
  */
 #ifdef CONFIG_SPL_OS_BOOT
 void __noreturn jump_to_image_linux(struct spl_image_info *spl_image)
diff --git a/cmd/spl.c b/cmd/spl.c
index 90193b43abf..f591dc07fb6 100644
--- a/cmd/spl.c
+++ b/cmd/spl.c
@@ -158,11 +158,10 @@ static int do_spl(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[])

 U_BOOT_CMD(
 	spl, 6 , 1, do_spl, "SPL configuration",
-	"export <img=3Datags|fdt> [kernel_addr] [initrd_addr] [fdt_addr]\n"
-	"\timg\t\t\"atags\" or \"fdt\"\n"
+	"export fdt [kernel_addr] [initrd_addr] [fdt_addr]\n"
 	"\tkernel_addr\taddress where a kernel image is stored.\n"
 	"\t\t\tkernel is loaded as part of the boot process, but it is not starte=
d.\n"
 	"\tinitrd_addr\taddress of initial ramdisk\n"
 	"\t\t\tcan be set to \"-\" if fdt_addr without initrd_addr is used.\n"
-	"\tfdt_addr\tin case of fdt, the address of the device tree.\n"
+	"\tfdt_addr\tthe address of the device tree.\n"
 	);

---

Regards,
Anshul

