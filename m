Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9154C25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 09:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E7E8865B;
	Sat, 18 May 2024 11:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WGAV72V+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AA7C88666; Sat, 18 May 2024 11:40:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 310E588657
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 11:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716025246; x=1716630046; i=xypron.glpk@gmx.de;
 bh=CXselaLZX36o9iR8IhhRF0KoLiVOm8OHucDoZvrPsh0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WGAV72V+ErJyK/Hbv70l6GKWZV5JmDdf8oCviMX211R/h5+wWOrP4V9xJHU/5yV6
 it8zTJg1PnA7JxjzHSSuVBhXLwG50bPlxrTfoBeixx36tyJDutlzqEgG3chcwC4Zd
 lb+ijHssaF9l2Os69yaijrH90xb83ZedkfJRa25b0Shzou0045c555fpKhAa9G2wk
 v5otyNegDFtBq04IgxrmdY6eoeeJR/jlms6/fjR42faP4EP/nhxwoQ5qV8KO0XBt5
 AjSd+9v1I4/NyAzgSvpHxoYcWcbrtT8hlhFnjLR8XrShSOO9rMVq99NO5gCJMQsoD
 14C3fdx4tjbzyAXLNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1sABQn1Fmp-0037le; Sat, 18
 May 2024 11:40:46 +0200
Message-ID: <673897a4-4887-4ca0-9dbb-a6d94ebed335@gmx.de>
Date: Sat, 18 May 2024 11:40:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cmd: move ELF load and boot to lib/elf.c
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim.Moskalets@kaspersky.com, quentin.schulz@theobroma-systems.com,
 sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de
References: <20240513181757.84898-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240513181757.84898-1-Maxim.Moskalets@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u9gw+AZQMa8HU5akuEaSQ1HM5vuFDxOmdyhwJrYxd57+m4aPpzL
 IZcSpweCgwfvcHmZulJEUINRAY7YZYrmnljG2OIA/3dYjBWqZ7fF8mk9nVM8qish3W7+ykQ
 K5TgnuHIqFbStOcZtKlZK5hGUmVDbqO76Um/TTkE/1zBtlBg/rDXOUG79lX+f9Xff+mxwWH
 YOV+Xc+rZXgzlftxbGDKA==
UI-OutboundReport: notjunk:1;M01:P0:i67NTxFmDCY=;X6Nz+lfqCylRblbLD2IiWnYs8wA
 ah5BRIg7JTFS4pFiRey3eHwPM+NCZevb66vAZP0EwUq2duEbJrTNUrzLzn4w2Hh3a0kNZgEba
 2QMSSC2Lsn5Tm453qc502yhMT/SGq7Ycu7CUavoy4NGaJfqIbtonLR5WK8+mNWo0A81c9TC+2
 YlwNq1lrYNuWp42Iyk8+wIKfr8CE8iw6Juwq1gljOyFuygUuPuKsGWGsZT0MQ4Uz86zicHLGS
 7LEjq4vKx4ZhstBFhPEX3BR2s3dYvp+j7YCYE9xbckYyDoq8+sM6v1PprmWBNduYGdOfU7nZk
 uOwBPkTlVeI6Ax/qhOaJUd8JaM4yTRW+sP8m0fQl72sxBEB83frsYvvCSWcvVPcXi4A64n2qO
 EIa8Whtm75Facf3NzuvbTEUTn1Vh5BEFSgrNFRV3+jLNJnbI5tt/nEwloJnyBk4SNONECrHre
 ex0eJ0NP6tEo+BoqRN3DAEBSyE6T+1vZx7H/aqMi1b9qL/FLTHk1G7PjpwRU1MOfrD+v28fgd
 J1ZaSpyjstJAhz0FdC63PFSbWlxmQN00UZVrCnKSnx0Q+L49lswb5vBTZF407YIBC0EE+Qeiw
 WV+YiDhhlPNQBIdmCW8I5wPrOWtzmNWwivWwppt7Wjt+ReFxNs/IVoh4EcZa/DsDoB71uW2Bj
 NDyFiSBCf7goVZxBqaiaiFxKw5XsOmQLXU2Mdawm1v6PcHm5sY/A7mzFjwYxzUNcZ/f8SXcxu
 e9AadsJw694sIU4GML0O+oXcJHLvKSnQcGn9h/VXC0XUaGJbrIHYrRINWVkfX8ZNANkqiVBVt
 7VHq8gA7AXkRQcrs3KyEl/ARmy0tdrhNq4YksHo4ZS8Yo=
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

On 5/13/24 20:17, Maxim Moskalets wrote:
> From: Maxim Moskalets <maximmosk4@gmail.com>
>
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
>   lib/elf.c     | 38 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 65 insertions(+), 32 deletions(-)
>
> diff --git a/cmd/elf.c b/cmd/elf.c
> index a02361f9f5..1fb955ae41 100644
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

Carving out the library function is a good idea.

Nits

%s/args/arguments/

> -	 */
> -	ret =3D entry(argc, argv);
> -
> -	return ret;
> -}
> -
>   /* Interpreter command to boot an arbitrary ELF image from memory */

Please, document functions fully:

https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-=
documentation

The preferred place for documenting exported functions is in the header
file.

>   int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const =
argv[])
>   {
> @@ -43,8 +28,8 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char *const argv[])
>   #endif
>   	unsigned long addr; /* Address of the ELF image */
>   	unsigned long rc; /* Return value from user code */
> -	char *sload =3D NULL;
>   	int rcode =3D 0;

Maybe

%s/0/CMD_RET_SUCCESS/

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
> +		printf("## Try to elf hdr format %s\n",
> +				flags.phdr ? "phdr" : "shdr");

Please, use log_debug() for debug messages and avoid the '## ' noise.

Do you mean:

log_debug("Using ELF header format %s\n",

>   		/* Consume flag. */
>   		argc--; argv++;
>   	}
> @@ -75,14 +63,6 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int a=
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

This looks like a debug message too.

> @@ -93,21 +73,26 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int =
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

log_debug("Starting application at 0x%08lx ...\n", addr);

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

%s/1/CMD_RET_FAILURE/

>
> -	printf("## Application terminated, rc =3D 0x%lx\n", rc);
> +	if (flags.autostart) {
> +		if (ENOEXEC =3D=3D errno)

if (rc && ENOEXEC =3D=3D errno)

> +			printf("## Invalid ELF image\n");

log_err("Invalid ELF image\n");

> +		else
> +			printf("## Application terminated, rc =3D 0x%lx\n", rc);

This message is only relevant if the application failed:

else if (rc)
     log_err("Application failed, rc =3D 0x%lx\n", rc);

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

If the elf command does not work in certain ABIs we need to ensure via
Kconfig that it is not build for these.

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
> index 9a794f9cba..f8eeceef3d 100644
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
> @@ -15,6 +16,43 @@
>   #include <linux/linkage.h>
>   #endif
>
> +/* Allow ports to override the default behavior */

Please, fully document the function.

> +unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
> +			   int argc, char *const argv[])
> +{
> +	return entry(argc, argv);
> +}
> +
> +/*
> + * @brief Boot ELF from memory
> + *
> + * @param addr       Loading address of ELF in memory
> + * @param flags      Bits like ELF_PHDR to control boot details
> + * @param argc, argv May be used to pass command line arguments (maybe =
unused)
> + *		     Necessary for backward compatibility with the CLI command
> + * @retuen Number returned by ELF application

This does not match our documentation style, see

https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-=
documentation

> + *
> + * Sets errno =3D ENOEXEC if ELF image is not valid

%s/if ELF/if the ELF/

> + */
> +unsigned long bootelf(unsigned long addr, Bootelf_flags flags,
> +		      int argc, char *const argv[])
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

Please, return early. We don't need entry_addr here.

> +
> +	return bootelf_exec((void *)entry_addr, argc, argv);;

Duplicate ';'.

An ELF binary may expect that argc >=3D 1 and argv[0] being the binary
name. How do we ensure this?

We should describe in a man-page doc/usage/cmd/elf.rst that the first
extraneous argument passed to the elf command is argv[0]?

On some paths we have not set errno which means it has a random value
set in unrelated functions. How would we able to evaluate errno in the
caller if the return value is non-zero?

Please, initialize errno to 0 at the start of the function.

We need a test case. E.g. we could build an ELF binary returning the
CRC32 of the concatenated arguments.

Best regards

Heinrich

> +}
> +
>   /*
>    * A very simple ELF64 loader, assumes the image is valid, returns the
>    * entry point address.

