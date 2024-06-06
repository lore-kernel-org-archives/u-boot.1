Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750B8C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 07:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6DF787D9B;
	Thu,  6 Jun 2024 09:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Dj+WmbZq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B487788027; Thu,  6 Jun 2024 09:02:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9258187C86
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 09:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717657367; x=1718262167; i=xypron.glpk@gmx.de;
 bh=/GFACUajyxF3PymvifMmLSjosqeUchX6lMecTXEFa1A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Dj+WmbZqV+TVAvB/BwrkrIKlEUy8jvbM1C/Z7WG65XSLighcY1BwetarH4dj4Bfk
 8hBwOnDDyJM3/+C8vtdC7t0sbnPpiatjj65SpcjPV2qCSWyBIcnQOlVHhtL9MXeQ0
 /a7OUc490L+XUzB41S+6m3fc1sgymQlUy0vK8kitveWPCWGMSzf+3Al3+3jkVKadG
 C0zwmD5kPloCKqLosG2HDTlpjAZOuAKSCgkPQ32pHghWFhj/IegRxM6ebgBESkoxQ
 Wh4aCeTDEddJ2av53FSIYGvUBMZT0Fn6c78hXFT6YOpD5CzGhcaiAXdbnQb+Jl+5K
 EZEHcL2zHiDpOuGOGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.178.114]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDj4-1sABTN2N3e-009eEw; Thu, 06
 Jun 2024 09:02:47 +0200
Message-ID: <b95386ab-ec35-4912-934d-c3b611953b55@gmx.de>
Date: Thu, 6 Jun 2024 09:02:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cmd: move ELF load and boot to lib/elf.c
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim.Moskalets@kaspersky.com, quentin.schulz@theobroma-systems.com,
 sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de
References: <20240605184334.13973-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240605184334.13973-1-Maxim.Moskalets@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qVMVoLAif4f3sFNRMc4/E6IRogZn52jyRVbVF7NQ9gjPUjfVyT2
 6Ts+RWZInRdVIDVbKPwRALi5j+ArtEhXogU1hqa+nQoRZJPzOPg63eYu8QqpVfD9/zSZUGx
 wVTHOF8hUfodQvuudKsfBR8d/gM4pUdHnugg/rfjnNnkTTwObNZS4VtIy5F2GTKY1CIL5fb
 d1SUW2p/b/YQKlwieeV5g==
UI-OutboundReport: notjunk:1;M01:P0:/3zuuAWIDWs=;GSwyi3QBQmelWV2cR4vBW+rmUK1
 3sNOXKzr+YC1ji46IMqyFDEumoRjg7oJa/h1RRSzAJLBDZb6pFLevl9DSNfms61tkzvDxQajL
 1h7n9/hNxcuUeLFpnMpm2TwNuRb1WtW9UylKoI8/oq2oCjRjkqu9U6mifMKxNkvmZW79vmBIk
 JITS6Rbl9k7t+8Yx3KpZYn2dLUbZyeAE8UqKYWKV+DVsJ55O8c1TQLIx7DvIv0MS9DSH2w50W
 vt+zJHbTeRjmwaWcGjCdvvJosSy39LUVroo7FiYM0YiOMqmPK019p14DDYuyx3HoOxJAhCx1F
 gYLfS6Csb33FBoVwpwZB/46dqMhzqG5lRTcY17+Vnl720ScrROspwUcEfpxKwwGkaG0R/EMto
 Q1FP2JX9uLwkc4Yq+qIjEo2vmIMBk80gGe+6OlVnbNSEmQVx55DVQJf9YChoFcu6YKe3pDK67
 TUCn1syZi8uEyItkYKgcMJdwKaGjzap/cmIeXKg0hIAn5M8rzNg/sYglSsMSdGTH9xK/Z5EVp
 jgjq7fQPHU1idM7ZgENv2DYiD7PDPL5kw3XVtmVqX34JJsmejv2aaWhtflf++ul6qEdNJAGij
 1SCr8SfbJeOJn9AzrbrZ3oxEoVUDWUe9RLGWxVHHYQ0M+vgd0q9lBQQS/QJu6HuDSPOzhTsto
 5Ei6/fYzckspuIGfvtzXFVHLt0m386K9hTsbKBTML+pf3ntV+I/Ceff2F4hC7xGtnCGlgNlKL
 K32+GnsdER4erhdLM/U9ZmBNH1RUo6CW9E1esAWn/luxyPdYtt0lwXnU+71+xGDnszomOskr9
 pJ6sJjxRcGeCaSXDw/ucn5Q3qohnx+smecRPeA21MXlGk=
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

On 6/5/24 20:43, Maxim Moskalets wrote:
> From: Maxim Moskalets <maximmosk4@gmail.com>
>
> Loading and running the ELF image is the responsibility of the
> library and should not be associated with the command line interface.
>
> It is also required to run ELF images from FIT with the bootm command
> so as not to depend on the command line interface.
>
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>

In future versions please, include a change log separated from the
commit message by ---, e.g.

=2D--
v6:
	foo changed to bar
v5:
	xxx removed
=2D--

Best regards

Heinrich

> ---
>   cmd/elf.c     | 58 +++++++++++++++++++--------------------------------
>   include/elf.h | 10 +++++++++
>   lib/elf.c     | 54 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 86 insertions(+), 36 deletions(-)
>
> diff --git a/cmd/elf.c b/cmd/elf.c
> index a02361f9f5..32b7462f92 100644
> --- a/cmd/elf.c
> +++ b/cmd/elf.c
> @@ -19,21 +19,6 @@
>   #include <linux/linkage.h>
>   #endif
>
> -/* Allow ports to override the default behavior */
> -static unsigned long do_bootelf_exec(ulong (*entry)(int, char * const[]=
),
> -				     int argc, char *const argv[])
> -{
> -	unsigned long ret;
> -
> -	/*
> -	 * pass address parameter as argv[0] (aka command name),
> -	 * and all remaining args
> -	 */
> -	ret =3D entry(argc, argv);
> -
> -	return ret;
> -}
> -
>   /* Interpreter command to boot an arbitrary ELF image from memory */
>   int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const =
argv[])
>   {
> @@ -43,8 +28,8 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char *const argv[])
>   #endif
>   	unsigned long addr; /* Address of the ELF image */
>   	unsigned long rc; /* Return value from user code */
> -	char *sload =3D NULL;
> -	int rcode =3D 0;
> +	int rcode =3D CMD_RET_SUCCESS;
> +	Bootelf_flags flags =3D {0};
>
>   	/* Consume 'bootelf' */
>   	argc--; argv++;
> @@ -52,7 +37,10 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int a=
rgc, char *const argv[])
>   	/* Check for [-p|-s] flag. */
>   	if (argc >=3D 1 && (argv[0][0] =3D=3D '-' && \
>   				(argv[0][1] =3D=3D 'p' || argv[0][1] =3D=3D 's'))) {
> -		sload =3D argv[0];
> +		if (argv[0][1] =3D=3D 'p')
> +			flags.phdr =3D 1;
> +		log_debug("Using ELF header format %s\n",
> +				flags.phdr ? "phdr" : "shdr");
>   		/* Consume flag. */
>   		argc--; argv++;
>   	}
> @@ -75,17 +63,9 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int a=
rgc, char *const argv[])
>   	} else
>   		addr =3D image_load_addr;
>
> -	if (!valid_elf_image(addr))
> -		return 1;
> -
> -	if (sload && sload[1] =3D=3D 'p')
> -		addr =3D load_elf_image_phdr(addr);
> -	else
> -		addr =3D load_elf_image_shdr(addr);
> -
>   #if CONFIG_IS_ENABLED(CMD_ELF_FDT_SETUP)
>   	if (fdt_addr) {
> -		printf("## Setting up FDT at 0x%08lx ...\n", fdt_addr);
> +		log_debug("Setting up FDT at 0x%08lx ...\n", fdt_addr);
>   		flush();
>
>   		if (image_setup_libfdt(&img, (void *)fdt_addr, NULL))
> @@ -93,21 +73,27 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int =
argc, char *const argv[])
>   	}
>   #endif
>
> -	if (!env_get_autostart())
> -		return rcode;
> -
> -	printf("## Starting application at 0x%08lx ...\n", addr);
> -	flush();
> +	if (env_get_autostart()) {
> +		flags.autostart =3D 1;
> +		log_debug("Starting application at 0x%08lx ...\n", addr);
> +		flush();
> +	}
>
>   	/*
>   	 * pass address parameter as argv[0] (aka command name),
> -	 * and all remaining args
> +	 * and all remaining arguments
>   	 */
> -	rc =3D do_bootelf_exec((void *)addr, argc, argv);
> +	rc =3D bootelf(addr, flags, argc, argv);
>   	if (rc !=3D 0)
> -		rcode =3D 1;
> +		rcode =3D CMD_RET_FAILURE;
>
> -	printf("## Application terminated, rc =3D 0x%lx\n", rc);
> +	if (flags.autostart)
> +	{
> +		if (ENOEXEC =3D=3D errno)
> +			log_err("Invalid ELF image\n");
> +		else
> +			log_debug("## Application terminated, rc =3D 0x%lx\n", rc);
> +	}
>
>   	return rcode;
>   }
> diff --git a/include/elf.h b/include/elf.h
> index a4ba74d8ab..b88e6cf403 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -12,6 +12,12 @@
>   #ifndef __ASSEMBLY__
>   #include "compiler.h"
>
> +/* Flag param bits for bootelf() function */
> +typedef struct {
> +	unsigned phdr      : 1; /* load via program (not section) headers */
> +	unsigned autostart : 1; /* Start ELF after loading */
> +} Bootelf_flags;
> +
>   /* This version doesn't work for 64-bit ABIs - Erik */
>
>   /* These typedefs need to be handled better */
> @@ -700,6 +706,10 @@ unsigned long elf_hash(const unsigned char *name);
>   #define R_RISCV_RELATIVE	3
>
>   #ifndef __ASSEMBLY__
> +unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
> +			   int argc, char *const argv[]);
> +unsigned long bootelf(unsigned long addr, Bootelf_flags flags,
> +		      int argc, char *const argv[]);
>   int valid_elf_image(unsigned long addr);
>   unsigned long load_elf64_image_phdr(unsigned long addr);
>   unsigned long load_elf64_image_shdr(unsigned long addr);
> diff --git a/lib/elf.c b/lib/elf.c
> index 9a794f9cba..dc13935e10 100644
> --- a/lib/elf.c
> +++ b/lib/elf.c
> @@ -7,6 +7,7 @@
>   #include <cpu_func.h>
>   #include <elf.h>
>   #include <env.h>
> +#include <errno.h>
>   #include <net.h>
>   #include <vxworks.h>
>   #ifdef CONFIG_X86
> @@ -15,6 +16,59 @@
>   #include <linux/linkage.h>
>   #endif
>
> +/**
> + * bootelf_exec() - start the ELF image execution.
> + *
> + * @entry: address of entry point of ELF.
> + *
> + * May by used to allow ports to override the default behavior.
> + */
> +unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
> +			   int argc, char *const argv[])
> +{
> +	return entry(argc, argv);
> +}
> +
> +/**
> + * bootelf() - Boot ELF from memory.
> + *
> + * @addr:  Loading address of ELF in memory.
> + * @flags: Bits like ELF_PHDR to control boot details.
> + * @argc: May be used to pass command line arguments (maybe unused).
> + *	  Necessary for backward compatibility with the CLI command.
> + *	  If unused, must be 0.
> + * @argv: see @argc. If unused, must be NULL.
> + * Return: Number returned by ELF application.
> + *
> + * Sets errno =3D ENOEXEC if the ELF image is not valid.
> + */
> +unsigned long bootelf(unsigned long addr, Bootelf_flags flags,
> +		      int argc, char *const argv[])
> +{
> +	unsigned long entry_addr;
> +	char *args[] =3D {"", NULL};
> +
> +	errno =3D 0;
> +
> +	if (!valid_elf_image(addr)) {
> +		errno =3D ENOEXEC;
> +		return 1;
> +	}
> +
> +	entry_addr =3D flags.phdr ? load_elf_image_phdr(addr)
> +					    : load_elf_image_shdr(addr);
> +
> +	if (!flags.autostart)
> +		return 0;
> +
> +	if (!argc && !argv) {
> +		argc =3D 1;
> +		argv =3D args;
> +	}
> +
> +	return bootelf_exec((void *)entry_addr, argc, argv);
> +}
> +
>   /*
>    * A very simple ELF64 loader, assumes the image is valid, returns the
>    * entry point address.

