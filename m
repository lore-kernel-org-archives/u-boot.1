Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923FCC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 07:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D21F4833D7;
	Tue,  5 Aug 2025 09:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="d484D9Qp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E483E84137; Tue,  5 Aug 2025 09:50:13 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93723833D1
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 09:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 0016e4c0-71d1-11f0-9a8c-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 0016e4c0-71d1-11f0-9a8c-005056994fde;
 Tue, 05 Aug 2025 09:51:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=trjcBJ0kPi2+hvLo8Qa8kKD+j7nE3OQfqPhADqAac4g=;
 b=d484D9Qp/WQVQ5WVn5njSL4sIpzDUfGuAM9E/ZOrrea4Zvudmqx7csNhXNgQ5Y5ge3QGGdKWn0jS2
 GeCMfvBUUNQ7B7AREU8ymIQgtpdz7Ss9LzLNIk4lNl7EyRpusUMkDzVJdpPieX/+FzDQmxVt2q2e0d
 BFXnEz3lKb3+WNQr93MRCLoM8NYEYG8FuoGietSfhNXgXtHw1PhK+fKqM4GdBMo3lb3WAssBS7/1OM
 IC7eVSnss/414OyaoKOzilPuxNmowVvonNpoJb1C7/OzShloa+f3PoE0gdboQ7bG3UFRNW5h9Bidxl
 atN8WYp8MB1ysvE0sad/GYKu7p3tG0w==
X-KPN-MID: 33|tIpXSuxV8ARewWPYWk78OYfuJfU2q2AgW1+HT7TjiZngEOJG8wAKge3z0U7hKzU
 jgOKNGD6ml7ytSvaaTz51yh4KGCTTLoN5SiNSZMYTKII=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|U+MjddextgevJG3VCHrNpGxvrqTBP2Nj8VQ/1Hqpz+RH6ba2rHQFP5mD6BGdOVW
 CPrxeSs+y5so2P/MD/UDSGw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id cc572b65-71d0-11f0-8d53-00505699b758;
 Tue, 05 Aug 2025 09:50:05 +0200 (CEST)
Date: Tue, 05 Aug 2025 09:50:04 +0200
Message-Id: <87qzxqmclv.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, sjg@chromium.org,
 adrianox@gmail.com, kettenis@openbsd.org,
 u-boot@lists.denx.de, heinrich.schuchardt@canonical.com
In-Reply-To: <20250805054614.5555-1-heinrich.schuchardt@canonical.com>
 (message from Heinrich Schuchardt on Tue, 5 Aug 2025 07:46:14 +0200)
Subject: Re: [PATCH v2 1/1] efi_loader: Support loading a ramdisk with bootefi
References: <20250805054614.5555-1-heinrich.schuchardt@canonical.com>
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

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Date: Tue,  5 Aug 2025 07:46:14 +0200
> 
> From: Simon Glass <sjg@chromium.org>
> 
> It is sometimes useful to be able to boot via EFI using a Linux initrd.
> Add support for this.
> 
> Fix a 'specifiy' typo while here.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	consistently refer to Linux initrd instead of RAM disk

Thanks!

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  cmd/bootefi.c             | 33 +++++++++++++++++++++++++--------
>  doc/usage/cmd/bootefi.rst | 37 ++++++++++++++++++++++++++++++-------
>  2 files changed, 55 insertions(+), 15 deletions(-)
> 
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index 8e8752127ed..b8f5bb35950 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -136,22 +136,39 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
>  {
>  	efi_status_t ret;
>  	char *p;
> -	void *fdt, *image_buf;
> -	unsigned long addr, size;
> +	void *fdt, *initrd = NULL, *image_buf;
> +	unsigned long addr, size, rd_len = 0, fdt_addr = 0;
>  	void *image_addr;
>  	size_t image_size;
> +	int fdt_arg = 2;
>  
>  	if (argc < 2)
>  		return CMD_RET_USAGE;
>  
>  	if (argc > 2) {
> -		uintptr_t fdt_addr;
> +		ulong rd_addr = 0;
> +		char *end = strchr(argv[2], ':');
>  
> -		fdt_addr = hextoul(argv[2], NULL);
> +		if (end) {
> +			rd_addr = hextoul(argv[2], NULL);
> +			if (!rd_addr)
> +				return CMD_RET_USAGE;
> +
> +			rd_len = hextoul(++end, NULL);
> +			initrd = map_sysmem(rd_addr, rd_len);
> +			++fdt_arg;
> +		}
> +	}
> +
> +	if (argc > fdt_arg + 1)
> +		return CMD_RET_USAGE;
> +	if (argc == fdt_arg + 1)
> +		fdt_addr = hextoul(argv[fdt_arg], NULL);
> +
> +	if (fdt_addr)
>  		fdt = map_sysmem(fdt_addr, 0);
> -	} else {
> +	else
>  		fdt = EFI_FDT_USE_INTERNAL;
> -	}
>  
>  	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
>  	    !strcmp(argv[1], "bootmgr")) {
> @@ -215,7 +232,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
>  		}
>  	}
>  
> -	ret = efi_binary_run(image_buf, size, fdt, NULL, 0);
> +	ret = efi_binary_run(image_buf, size, fdt, initrd, rd_len);
>  
>  	if (ret != EFI_SUCCESS)
>  		return CMD_RET_FAILURE;
> @@ -224,7 +241,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
>  }
>  
>  U_BOOT_LONGHELP(bootefi,
> -	"<image address>[:<image size>] [<fdt address>]\n"
> +	"<image address>[:<size>] [<initrd address>:<size>] [<fdt address>]\n"
>  	"  - boot EFI payload\n"
>  #ifdef CONFIG_CMD_BOOTEFI_HELLO
>  	"bootefi hello\n"
> diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
> index d6e4e62e383..7c5448586b7 100644
> --- a/doc/usage/cmd/bootefi.rst
> +++ b/doc/usage/cmd/bootefi.rst
> @@ -12,7 +12,7 @@ Synopsis
>  
>  ::
>  
> -    bootefi <image_addr>[:<image_size>] [<fdt_addr>]
> +    bootefi <image_addr>[:<image_size>] [<initrd_addr>:<initrd_size>] [<fdt_address>]
>      bootefi bootmgr [<fdt_addr>]
>      bootefi hello [<fdt_addr>]
>      bootefi selftest [<fdt_addr>]
> @@ -44,6 +44,16 @@ command sequence to run a UEFI application might look like
>      load mmc 0:1 $kernel_addr_r /EFI/grub/grubaa64.efi
>      bootefi $kernel_addr_r $fdt_addr_r
>  
> +or
> +
> +::
> +
> +    setenv bootargs root=/dev/vda1
> +    load mmc 0:1 $fdt_addr_r dtb
> +    load mmc 0:1 $kernel_addr_r vmlinux
> +    load mmc 0:1 $initrd_addr_r intird
> +    bootefi $kernel_addr_r $initrd_addr_r:$filesize $fdt_addr_r
> +
>  The last UEFI binary loaded defines the image file path in the loaded image
>  protocol.
>  
> @@ -51,21 +61,34 @@ The value of the environment variable *bootargs* is converted from UTF-8 to
>  UTF-16 and passed as load options in the loaded image protocol to the UEFI
>  binary.
>  
> +.. note::
> +
> +    The bootefi command accepts one to three arguments.
> +    If the second argument contains a colon ':', it is assumed to specify the
> +    initial RAM disk.
> +
>  image_addr
>      Address of the UEFI binary.
>  
> -fdt_addr
> -    Address of the device-tree or '-'. If no address is specifiy, the
> -    environment variable $fdt_addr is used as first fallback, the address of
> -    U-Boot's internal device-tree $fdtcontroladdr as second fallback.
> -    When using ACPI no device-tree shall be specified.
> -
>  image_size
>      Size of the UEFI binary file. This argument is only needed if *image_addr*
>      does not match the address of the last loaded UEFI binary. In this case
>      a memory device path will be used as image file path in the loaded image
>      protocol.
>  
> +initrd_addr
> +    Address of the Linux initial RAM disk or '-'. If no address is specified,
> +    no RAM disk is used when booting.
> +
> +initrd_size
> +    Size of the Linux initial RAM disk.
> +
> +fdt_addr
> +    Address of the device-tree or '-'. If no address is specified, the
> +    environment variable $fdt_addr is used as first fallback, the address of
> +    U-Boot's internal device-tree $fdtcontroladdr as second fallback.
> +    When using ACPI no device-tree shall be specified.
> +
>  Note
>      UEFI binaries that are contained in FIT images are launched via the
>      *bootm* command.
> -- 
> 2.50.0
> 
> 
