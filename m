Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A0EC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB8DB885A5;
	Fri, 26 Apr 2024 16:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PgRtdGOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF21488651; Fri, 26 Apr 2024 16:33:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C64E98857A
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1714141977; x=1714746777; i=xypron.glpk@gmx.de;
 bh=QeafizGLWGEPvozI4qs/L3nAteuBJCVmEiE1U5h+oMA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PgRtdGOpMK4RK5vc6NeTxxvuTQQNSnW2uHD9WcLScV3MObEXgndr7mTFXh/Wjl07
 974/7N9j/88xjRE/htNVvqhVWd37sHmAtKPR1VHGXL6TRbnAjw7/GsP6Sb73UjBQe
 vrRXCzxXd8iors8xYsHZ+IYgSJ2EzbrgwU7bmx3angPeevOpghyyMO3Kci9vDH+wW
 vyyygG8sHb8BPU3FUOyXSJgjEIL5WSbkRanQwpyxXfu+8SY9GouMGjGraSxeZP4rD
 TowDyRqCv0vaYE73xOK0EPybw93McyHevXoU4CIlMoE7/o0d8n+zFBCTYCV5odhzN
 U+nkfcHHK3stVv6SOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3DM-1rthjN07Gy-00H7ld; Fri, 26
 Apr 2024 16:32:57 +0200
Message-ID: <98a5dfe3-f388-4cf0-89ae-5fc56c3dc729@gmx.de>
Date: Fri, 26 Apr 2024 16:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: move ELF load and boot to lib/elf.c
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim.Moskalets@kaspersky.com, u-boot@lists.denx.de, trini@konsulko.com,
 sjg@chromium.org, quentin.schulz@theobroma-systems.com
References: <20240426091102.50350-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240426091102.50350-1-Maxim.Moskalets@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NjO/1mQshgf//y8J8k8cbTqRxYrJEuYJGyqU/50g3VZLt/GtXp3
 0xPh5OrXT8aepzAbTqU+KjXXtPYz8CXOkIUFpZzfIvtGhC/OpaE18NEsBO6E1ndTx7tZLV3
 frYMJ/v8pw4+dmW8CuGsTCYuvtCl/fVGF2+gn+Mfucv5/7CnmNwvhXqX+18cepygngATdGU
 akAw4iJoj+KTAikkZ91Lg==
UI-OutboundReport: notjunk:1;M01:P0:657s2RbXpaE=;w94pBOgJ0XWG9012sdh+ZwpEvf1
 rp/JnpVzjpZp1XGBXl7B+Q0L1mo66mNTx7vcvTqjiG3y+vTGvjueIHWXWAJ4fqpM14nttaEq0
 IAr7R7Dz4nBdsLoUoPDcxmOG3hFEY3ekfEiIn3ZArk5B6Icv/BlsudGWZw/46GEdi9VLYxpNK
 gG1dETUSKgJ/AxR3mUo89dYSNn+HeoxFXKaQO+mxtDHSGNRFwY0z3x3XV3dwDCsi+HYfCZ0A+
 FgDzkm8rwnMKabKj/yxOGzHpnQUF/jd626yr9xFXKbC77nYJFsFCUcgpFtmWK7VyZggqdcqxV
 cJSpgSmv++qvj5cio+i7qTwgetFFt76jIbUYQ40JXLW3wo7bmXH9llHMsMoqBNipT3v4ErChG
 Vqx8GMeG/ruOrSfBvRziHIC5O9UW7r0Sr5NlVhG8lf1E5OvCp18zJlI9GHYkSrw88btOGIoWk
 73+DNMB8hIaJCw4hgZr6ac66oyCmE58dZsB3Uc/Lmw5KcNBqtg0RItGUZsyhL8PZNpuBSXlSD
 EvcjpS7rr5ugJrHrElIJxlMwmkP8M/V6NzVhoGdMme/HydtIcR1CjjdQFmUJeuLDVoYA7J9n8
 KTbMXmR/oCC2Dp0CF+DV8SyAVu3H/E2VygUO754MSg9+NUsGlgrEm4sOZc8pbbdBw/Bq5LEqA
 K4tOZ7RcN85kUrUmvNdK+Yiw+DCl2Xk57AyJkj4Uhn9vRbt0ZbX79pKkEeKjSSS5j39k3rk1t
 MnOJsfJI4EOJ868kTsOuSgRn/GwBFcH6njlHC/cWig56HvbJAl9jOY+0n2LDftRnUpEKYgBmw
 l/kRHsJXQK4PTRV9+q2URwxVfWe00ZgxYHKO7JkTg5Aec=
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

On 26.04.24 11:11, Maxim Moskalets wrote:
> Loading and running the ELF image is the responsibility of the
> library and should not be associated with the command line interface.
>
> It is also required to run ELF images from FIT with the bootm command
> so as not to depend on the command line interface.
>
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
> ---
>   cmd/elf.c     | 49 +++++++++++++++++--------------------------------
>   include/elf.h | 10 ++++++++++
>   lib/elf.c     | 36 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 63 insertions(+), 32 deletions(-)
>
> diff --git a/cmd/elf.c b/cmd/elf.c
> index df4354d374..8bbdc67db7 100644
> --- a/cmd/elf.c
> +++ b/cmd/elf.c
> @@ -20,21 +20,6 @@
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
> @@ -44,8 +29,8 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char *const argv[])
>   #endif
>   	unsigned long addr; /* Address of the ELF image */
>   	unsigned long rc; /* Return value from user code */
> -	char *sload =3D NULL;
>   	int rcode =3D 0;
> +	Bootelf_flags flags =3D {0};
>
>   	/* Consume 'bootelf' */
>   	argc--; argv++;
> @@ -53,7 +38,10 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int a=
rgc, char *const argv[])
>   	/* Check for [-p|-s] flag. */
>   	if (argc >=3D 1 && (argv[0][0] =3D=3D '-' && \
>   				(argv[0][1] =3D=3D 'p' || argv[0][1] =3D=3D 's'))) {
> -		sload =3D argv[0];
> +		if (argv[0][1] =3D=3D 'p')
> +			flags.phdr =3D 1;
> +		printf("## Try to elf hdr format %s\n",
> +				flags.phdr ? "phdr" : "shdr");
>   		/* Consume flag. */
>   		argc--; argv++;
>   	}
> @@ -76,14 +64,6 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int a=
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
>   		printf("## Setting up FDT at 0x%08lx ...\n", fdt_addr);
> @@ -94,21 +74,26 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int =
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
> +		printf("## Starting application at 0x%08lx ...\n", addr);
> +		flush();
> +	}
>
>   	/*
>   	 * pass address parameter as argv[0] (aka command name),
>   	 * and all remaining args
>   	 */
> -	rc =3D do_bootelf_exec((void *)addr, argc, argv);
> +	rc =3D bootelf(addr, flags, argc, argv);
>   	if (rc !=3D 0)
>   		rcode =3D 1;
>
> -	printf("## Application terminated, rc =3D 0x%lx\n", rc);
> +	if (flags.autostart) {
> +		if (ENOEXEC =3D=3D errno)
> +			printf("## Invalid ELF image\n");
> +		else
> +			printf("## Application terminated, rc =3D 0x%lx\n", rc);
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
> index 9a794f9cba..0f3d752758 100644
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
> @@ -15,6 +16,41 @@
>   #include <linux/linkage.h>
>   #endif
>
> +/* Allow ports to override the default behavior */
> +unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
> +			   int argc, char *const argv[])
> +{
> +	return entry(argc, argv);
> +}
> +
> +/*
> + * Boot ELF from memory
> + *
> + * addr       - loading address of ELF in memory
> + * flags      - bits like ELF_PHDR to control boot details
> + * argc, argv - may be used to pass command line arguments (maybe unuse=
d)
> + *
> + * Sets errno =3D ENOEXEC if ELF image is not valid
> + */
> +unsigned long bootelf(unsigned long addr, Bootelf_flags flags,
> +		      int argc, char *const argv[])

Moving bootelf functionality is a good idea as we want to be able to
build without command line interface.

We should define the library functions without usage of argc and argv.
The translation from argv[], argc to the library function parameters
should happen in cmd/elf.c.

Best regards

Heinrich

> +{
> +	unsigned long entry_addr;
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
> +	return bootelf_exec((void *)entry_addr, argc, argv);;
> +}
> +
>   /*
>    * A very simple ELF64 loader, assumes the image is valid, returns the
>    * entry point address.

