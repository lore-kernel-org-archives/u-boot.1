Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C7BC282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 05:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C09080540;
	Sat,  8 Mar 2025 06:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CfK/Bael";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82EA78058A; Sat,  8 Mar 2025 06:07:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 411628003E
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 06:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741410433; x=1742015233; i=xypron.glpk@gmx.de;
 bh=oft+VUxdnG/RTEcuUwqXTUN4SCSkO1iANeyqhG9/8kU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=CfK/BaelJuZ3FKJi8VUw0jCOERuwz64PyTYExClHKNfiD4Bghi68bRAo4fHsPX4D
 fO8BnoybE4T7N7j2M9dkqNtVV0p4ZXlMmDc1bNzSLio8xf5jwZYDKhYiFHeSG7Yfs
 R1B2DfsNgSZ/xloFfpxrHW6t456zyxM6RNpwRuUp0UKwvk+hjSf7nA9AFSwryFogl
 uL/Se2AxlUzwAvAuoSUpszQNQmYbI1AKNvbZBo4bn6w9VTKJ865xhWdLcqrG143cr
 8CrzlIQU4RwP5I7V0fBMj2uYA0heay65Cc+GJxOfioYdPS8fnvDAcc9GXVc/WLn2c
 kWzNg37I/zX0NWQyPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.111.115]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGr8-1tkh5z22AQ-00W0Ez; Sat, 08
 Mar 2025 06:07:13 +0100
Message-ID: <b3fab4fc-7e4f-4359-bf15-813158d16b80@gmx.de>
Date: Sat, 8 Mar 2025 06:07:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/29] x86: Move the bootm state for zimage into cmd/
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250306002533.2380866-1-sjg@chromium.org>
 <20250306002533.2380866-7-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250306002533.2380866-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3KvnaAFwbimGdvkTOtb9tINCpWifcTkOSNiM9KdEkbXPVCbykiu
 2J9B0u24I0/8i1X6AterwdSOmixmhy3dRNwinm5S99IDThuOUmoX+xffIHVVLDk5gWAQUwH
 aY6YwUxixMTtL89RPjy/gP1vuIfZJ3loZq4V4k8/MQO4YGRnDY9eT1N9RIQxDA3TMIZrI19
 gr6nRdr4tefanSM8hsLKA==
UI-OutboundReport: notjunk:1;M01:P0:JeOJUdgCN78=;CHoiQXTjyVbfWz4dxH54Eo0kvUV
 Dmf6bjAfgRs3DHupXjOulds8gpkiDGLKk+m0glV671ZhxXa0czgF2WQZ4ncjDT189t7CaVxk5
 /VIPUk52gWykWw2oIfCDTwVR+9gvS7S0YFztSViD3ZQxxLYGwuPW43UUtLcehmkInrRjjBOe8
 0LtmfTDNUjZYzKc99OQaDceoPdcaja2FaFc+WKfSWRsojtw923lEVDtT9A+e3bSFtJX4O2kol
 qf1IawzulXOgtpVaFLmxwQ0DNBIW+7oNKE4SZ/JSv8J7/919IeZ5YYBodYAco66P0GhtUOsn6
 +TE5kxHln7/4Rtl9ynfgMRrWLGGb7KWl9k9HdgCYn++OrwieJUrKSZRzCEAixT7H1nv+PbXz3
 MmXQOfWWs/iIhrpqZKZSFI2cuTY4wyLmj6tU7yw5Qr13QFMx+UfjWub9Sd/9fda5jVXpXTChN
 wBmSYNJnHzU76u6Xvr4q3/QOpeGsgKwphCqUCUmHJF27Z5LOswsUR5TFIfSSiNmj3asWrFTPL
 9lJPIWAYhAETk77tDMgKibImATrp+1IKvigzTEomTW0V2XU2fBP9iBZCr1VjYqclC1UKH2Uyh
 +6QnzRPx02ZQHvuHZJMCAbIckwSrv6jmGuteZtNHoA+gg8mliE6VAZi3Em7+AGVtgQvoUvgkE
 5Ux3LPHUgJMTeEGfipgUwQ2snK81SKF3VTezITq3ZwSHZJonddK6O4+pbc+8gc6BNrsKeipOX
 SgH4EmQfR3r6uFwFNTnWmw4u7C2MrVODJY4t6cmo/GKcr/b3W+E9HQrwRaN0/TnMX1NaHOGsa
 ZheUBEPJu4OAKaF8hmcWxR6pY5y9lgC5Q6k08iR0uhYsVFBXKYJRhqHI2CNiRhXwK2QXRw3KU
 sbIWcFNr4mWSGcAjnPGJ/wDhiUgLG7PMqeKKdmHLyaRuXF1SptpiRLV6E2LQJ13+/rs7PWcL/
 ULd43gQXRVVlmc+23IM2ujnUJe77BxTI9cmH1jueR2Z85M/7W7+V/bEgTUkoydQGBKKbNhY9B
 4D6NWYBnfcCujspozb6cx2vlGVS+ZMFTrumrBcRyZudLtrYw8o/WRUH3Uvxk2KbZfgBPc0JkH
 GaDa/tm1wJlhMG8ytgzimlv+PFXLZYAd6vMNfqPYn/x4PG2JgDzQMcQahJQ0wG9V/wf1KbgdU
 vHmU4c61ufBgtdbtoWEsWARSBVAWBkA9voMf7cPhRKL2aUV3BL+KG7Txmoff2PFxweKdt+8my
 c7sE8HIOd9o2afHfmr0UY8p29GK+X5WnY45hvLc6u1SrJOxY5m0eP64qc31/j6IT62KlsZv/k
 TxYdJyLyafdzoHb7zNMlOp4MWHAwAT3Ad4V2tGCT9b/hmTfsGFKgIVil8NHxxQGrMEofKb0i+
 DRj5ihCQQhTVctEG9hp0LJluVP/AEcFJn8K8wOQfEh062BzboqCCm1b+humeWKyG9yBg2zFmZ
 VZPzNoA==
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

On 3/6/25 01:25, Simon Glass wrote:
> Rather than holding the state in the implementation code, move it to the
> command code. The state is now passed to the implementation functions
> and can there (with future work) be pass in from bootstd, without going

Nits
%s/pass/passsed/

> through the commands.

One of our (not yet achieved) development targets is to be able to build
without a command line interface. Moving the bootm state to cmd/ sounds
like going into a contrary direction.

Maybe it is just the commit message that is not clear enough.

Best regards

Heinrich

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   arch/x86/include/asm/zimage.h | 22 +++++-----
>   arch/x86/lib/zimage.c         | 75 +++++++++++++++++------------------
>   cmd/bootflow.c                |  5 ++-
>   cmd/x86/zboot.c               | 20 ++++++----
>   include/bootm.h               |  8 +++-
>   5 files changed, 73 insertions(+), 57 deletions(-)
>
> diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage=
.h
> index b592057e58b..4ed6d8d5cc2 100644
> --- a/arch/x86/include/asm/zimage.h
> +++ b/arch/x86/include/asm/zimage.h
> @@ -10,6 +10,8 @@
>   #include <asm/bootparam.h>
>   #include <asm/e820.h>
>
> +struct bootm_info;
> +
>   /* linux i386 zImage/bzImage header. Offsets relative to
>    * the start of the image */
>
> @@ -42,8 +44,6 @@ enum {
>   	ZBOOT_STATE_COUNT	=3D 5,
>   };
>
> -extern struct bootm_info bmi;
> -
>   /**
>    * zboot_load() - Load a zimage
>    *
> @@ -51,21 +51,21 @@ extern struct bootm_info bmi;
>    *
>    * Return: 0 if OK, -ve on error
>    */
> -int zboot_load(void);
> +int zboot_load(struct bootm_info *bmi);
>
>   /**
>    * zboot_setup() - Set up the zboot image reeady for booting
>    *
>    * Return: 0 if OK, -ve on error
>    */
> -int zboot_setup(void);
> +int zboot_setup(struct bootm_info *bmi);
>
>   /**
>    * zboot_go() - Start the image
>    *
>    * Return: 0 if OK, -ve on error
>    */
> -int zboot_go(void);
> +int zboot_go(struct bootm_info *bmi);
>
>   /**
>    * load_zimage() - Load a zImage or bzImage
> @@ -104,6 +104,7 @@ int setup_zimage(struct boot_params *setup_base, cha=
r *cmd_line, int auto_boot,
>    *
>    * Record information about a zimage so it can be booted
>    *
> + * @bmi: Bootm information
>    * @bzimage_addr: Address of the bzImage to boot
>    * @bzimage_size: Size of the bzImage, or 0 to detect this
>    * @initrd_addr: Address of the initial ramdisk, or 0 if none
> @@ -114,14 +115,17 @@ int setup_zimage(struct boot_params *setup_base, c=
har *cmd_line, int auto_boot,
>    * @cmdline: Environment variable containing the 'override' command li=
ne, or
>    *	NULL to use the one in the setup block
>    */
> -void zboot_start(ulong bzimage_addr, ulong bzimage_size, ulong initrd_a=
ddr,
> -		 ulong initrd_size, ulong base_addr, const char *cmdline);
> +void zboot_start(struct bootm_info *bmi, ulong bzimage_addr, ulong bzim=
age_size,
> +		 ulong initrd_addr, ulong initrd_size, ulong base_addr,
> +		 const char *cmdline);
>
>   /**
>    * zboot_info() - Show simple info about a zimage
>    *
> - * Shows wherer the kernel was loaded and also the setup base
> + * Shows where the kernel was loaded and also the setup base
> + *
> + * @bmi: Bootm information
>    */
> -void zboot_info(void);
> +void zboot_info(struct bootm_info *bmi);
>
>   #endif
> diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
> index 991d0c84006..7f4b117b403 100644
> --- a/arch/x86/lib/zimage.c
> +++ b/arch/x86/lib/zimage.c
> @@ -55,9 +55,6 @@ DECLARE_GLOBAL_DATA_PTR;
>
>   #define COMMAND_LINE_SIZE	2048
>
> -/* Current state of the boot */
> -struct bootm_info bmi;
> -
>   static void build_command_line(char *command_line, int auto_boot)
>   {
>   	char *env_command_line;
> @@ -366,13 +363,13 @@ int setup_zimage(struct boot_params *setup_base, c=
har *cmd_line, int auto_boot,
>   	return 0;
>   }
>
> -int zboot_load(void)
> +int zboot_load(struct bootm_info *bmi)
>   {
>   	struct boot_params *base_ptr;
>   	int ret;
>
> -	if (bmi.base_ptr) {
> -		struct boot_params *from =3D (struct boot_params *)bmi.base_ptr;
> +	if (bmi->base_ptr) {
> +		struct boot_params *from =3D (struct boot_params *)bmi->base_ptr;
>
>   		base_ptr =3D (struct boot_params *)DEFAULT_SETUP_BASE;
>   		log_debug("Building boot_params at 0x%8.8lx\n",
> @@ -380,41 +377,41 @@ int zboot_load(void)
>   		memset(base_ptr, '\0', sizeof(*base_ptr));
>   		base_ptr->hdr =3D from->hdr;
>   	} else {
> -		base_ptr =3D load_zimage((void *)bmi.bzimage_addr, bmi.bzimage_size,
> -				       &bmi.load_address);
> +		base_ptr =3D load_zimage((void *)bmi->bzimage_addr,
> +				       bmi->bzimage_size, &bmi->load_address);
>   		if (!base_ptr) {
>   			puts("## Kernel loading failed ...\n");
>   			return -EINVAL;
>   		}
>   	}
> -	bmi.base_ptr =3D base_ptr;
> +	bmi->base_ptr =3D base_ptr;
>
> -	ret =3D env_set_hex("zbootbase", map_to_sysmem(bmi.base_ptr));
> +	ret =3D env_set_hex("zbootbase", map_to_sysmem(bmi->base_ptr));
>   	if (!ret)
> -		ret =3D env_set_hex("zbootaddr", bmi.load_address);
> +		ret =3D env_set_hex("zbootaddr", bmi->load_address);
>   	if (ret)
>   		return ret;
>
>   	return 0;
>   }
>
> -int zboot_setup(void)
> +int zboot_setup(struct bootm_info *bmi)
>   {
> -	struct boot_params *base_ptr =3D bmi.base_ptr;
> +	struct boot_params *base_ptr =3D bmi->base_ptr;
>   	int ret;
>
>   	ret =3D setup_zimage(base_ptr, (char *)base_ptr + COMMAND_LINE_OFFSET=
,
> -			   0, bmi.initrd_addr, bmi.initrd_size,
> -			   (ulong)bmi.cmdline);
> +			   0, bmi->initrd_addr, bmi->initrd_size,
> +			   (ulong)bmi->cmdline);
>   	if (ret)
>   		return -EINVAL;
>
>   	return 0;
>   }
>
> -int zboot_go(void)
> +int zboot_go(struct bootm_info *bmi)
>   {
> -	struct boot_params *params =3D bmi.base_ptr;
> +	struct boot_params *params =3D bmi->base_ptr;
>   	struct setup_header *hdr =3D &params->hdr;
>   	bool image_64bit;
>   	ulong entry;
> @@ -422,7 +419,7 @@ int zboot_go(void)
>
>   	disable_interrupts();
>
> -	entry =3D bmi.load_address;
> +	entry =3D bmi->load_address;
>   	image_64bit =3D false;
>   	if (IS_ENABLED(CONFIG_X86_RUN_64BIT) &&
>   	    (hdr->xloadflags & XLF_KERNEL_64)) {
> @@ -430,7 +427,7 @@ int zboot_go(void)
>   	}
>
>   	/* we assume that the kernel is in place */
> -	ret =3D boot_linux_kernel((ulong)bmi.base_ptr, entry, image_64bit);
> +	ret =3D boot_linux_kernel((ulong)bmi->base_ptr, entry, image_64bit);
>
>   	return ret;
>   }
> @@ -438,16 +435,18 @@ int zboot_go(void)
>   int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_=
size,
>   		   ulong base, char *cmdline)
>   {
> +	struct bootm_info bmi;
>   	int ret;
>
> -	zboot_start(addr, size, initrd, initrd_size, base, cmdline);
> -	ret =3D zboot_load();
> +	bootm_init(&bmi);
> +	zboot_start(&bmi, addr, size, initrd, initrd_size, base, cmdline);
> +	ret =3D zboot_load(&bmi);
>   	if (ret)
>   		return log_msg_ret("ld", ret);
> -	ret =3D zboot_setup();
> +	ret =3D zboot_setup(&bmi);
>   	if (ret)
>   		return log_msg_ret("set", ret);
> -	ret =3D zboot_go();
> +	ret =3D zboot_go(&bmi);
>   	if (ret)
>   		return log_msg_ret("go", ret);
>
> @@ -555,7 +554,8 @@ static void show_loader(struct setup_header *hdr)
>   	printf("\n");
>   }
>
> -void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
> +void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
> +		 bool show_cmdline)
>   {
>   	struct setup_header *hdr;
>   	const char *version;
> @@ -596,7 +596,7 @@ void zimage_dump(struct boot_params *base_ptr, bool =
show_cmdline)
>   	print_num("Start sys seg", hdr->start_sys_seg);
>   	print_num("Kernel version", hdr->kernel_version);
>   	version =3D zimage_get_kernel_version(base_ptr,
> -					    (void *)bmi.bzimage_addr);
> +					    (void *)bmi->bzimage_addr);
>   	if (version)
>   		printf("   @%p: %s\n", version, version);
>   	print_num("Type of loader", hdr->type_of_loader);
> @@ -639,25 +639,24 @@ void zimage_dump(struct boot_params *base_ptr, boo=
l show_cmdline)
>   		print_num("Kernel info offset", hdr->kernel_info_offset);
>   }
>
> -void zboot_start(ulong bzimage_addr, ulong bzimage_size, ulong initrd_a=
ddr,
> -		 ulong initrd_size, ulong base_addr, const char *cmdline)
> +void zboot_start(struct bootm_info *bmi, ulong bzimage_addr, ulong bzim=
age_size,
> +		 ulong initrd_addr, ulong initrd_size, ulong base_addr,
> +		 const char *cmdline)
>   {
> -	bootm_init(&bmi);
> -
> -	bmi.bzimage_size =3D bzimage_size;
> -	bmi.initrd_addr =3D initrd_addr;
> -	bmi.initrd_size =3D initrd_size;
> +	bmi->bzimage_size =3D bzimage_size;
> +	bmi->initrd_addr =3D initrd_addr;
> +	bmi->initrd_size =3D initrd_size;
>   	if (base_addr) {
> -		bmi.base_ptr =3D map_sysmem(base_addr, 0);
> -		bmi.load_address =3D bzimage_addr;
> +		bmi->base_ptr =3D map_sysmem(base_addr, 0);
> +		bmi->load_address =3D bzimage_addr;
>   	} else {
> -		bmi.bzimage_addr =3D bzimage_addr;
> +		bmi->bzimage_addr =3D bzimage_addr;
>   	}
> -	bmi.cmdline =3D cmdline;
> +	bmi->cmdline =3D cmdline;
>   }
>
> -void zboot_info(void)
> +void zboot_info(struct bootm_info *bmi)
>   {
>   	printf("Kernel loaded at %08lx, setup_base=3D%p\n",
> -	       bmi.load_address, bmi.base_ptr);
> +	       bmi->load_address, bmi->base_ptr);
>   }
> diff --git a/cmd/bootflow.c b/cmd/bootflow.c
> index f88995a478f..72b06a42e4d 100644
> --- a/cmd/bootflow.c
> +++ b/cmd/bootflow.c
> @@ -380,7 +380,10 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, =
int flag, int argc,
>   	bflow =3D std->cur_bootflow;
>
>   	if (IS_ENABLED(CONFIG_X86) && x86_setup) {
> -		zimage_dump(bflow->x86_setup, false);
> +		struct bootm_info bmi;
> +
> +		bootm_init(&bmi);
> +		zimage_dump(&bmi, bflow->x86_setup, false);
>
>   		return 0;
>   	}
> diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
> index 0d0a8e53172..029ff4eb9fd 100644
> --- a/cmd/x86/zboot.c
> +++ b/cmd/x86/zboot.c
> @@ -13,6 +13,9 @@
>   #include <vsprintf.h>
>   #include <asm/zimage.h>
>
> +/* Current state of the boot */
> +static struct bootm_info bmi;
> +
>   static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
>   			  char *const argv[])
>   {
> @@ -21,6 +24,8 @@ static int do_zboot_start(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>   	ulong base_addr;
>   	int i;
>
> +	bootm_init(&bmi);
> +
>   	log_debug("argc %d:", argc);
>   	for (i =3D 0; i < argc; i++)
>   		log_debug(" %s", argv[i]);
> @@ -36,7 +41,7 @@ static int do_zboot_start(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>   	base_addr =3D argc > 5 ? hextoul(argv[5], NULL) : 0;
>   	cmdline =3D argc > 6 ? env_get(argv[6]) : NULL;
>
> -	zboot_start(bzimage_addr, bzimage_size, initrd_addr, initrd_size,
> +	zboot_start(&bmi, bzimage_addr, bzimage_size, initrd_addr, initrd_size=
,
>   		    base_addr, cmdline);
>
>   	return 0;
> @@ -47,7 +52,7 @@ static int do_zboot_load(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
>   {
>   	int ret;
>
> -	ret =3D zboot_load();
> +	ret =3D zboot_load(&bmi);
>   	if (ret)
>   		return ret;
>
> @@ -61,12 +66,13 @@ static int do_zboot_setup(struct cmd_tbl *cmdtp, int=
 flag, int argc,
>   		printf("base is not set: use 'zboot load' first\n");
>   		return CMD_RET_FAILURE;
>   	}
> -	if (zboot_setup()) {
> +
> +	if (zboot_setup(&bmi)) {
>   		puts("Setting up boot parameters failed ...\n");
>   		return CMD_RET_FAILURE;
>   	}
>
> -	if (zboot_setup())
> +	if (zboot_setup(&bmi))
>   		return CMD_RET_FAILURE;
>
>   	return 0;
> @@ -75,7 +81,7 @@ static int do_zboot_setup(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>   static int do_zboot_info(struct cmd_tbl *cmdtp, int flag, int argc,
>   			 char *const argv[])
>   {
> -	zboot_info();
> +	zboot_info(&bmi);
>
>   	return 0;
>   }
> @@ -85,7 +91,7 @@ static int do_zboot_go(struct cmd_tbl *cmdtp, int flag=
, int argc,
>   {
>   	int ret;
>
> -	ret =3D zboot_go();
> +	ret =3D zboot_go(&bmi);
>   	if (ret) {
>   		printf("Kernel returned! (err=3D%d)\n", ret);
>   		return CMD_RET_FAILURE;
> @@ -105,7 +111,7 @@ static int do_zboot_dump(struct cmd_tbl *cmdtp, int =
flag, int argc,
>   		printf("No zboot setup_base\n");
>   		return CMD_RET_FAILURE;
>   	}
> -	zimage_dump(base_ptr, true);
> +	zimage_dump(&bmi, base_ptr, true);
>
>   	return 0;
>   }
> diff --git a/include/bootm.h b/include/bootm.h
> index 5fa9761629e..fe7f80b88a5 100644
> --- a/include/bootm.h
> +++ b/include/bootm.h
> @@ -92,6 +92,8 @@ struct bootm_info {
>   /**
>    * bootm_init() - Set up a bootm_info struct with useful defaults
>    *
> + * @bmi: Bootm information
> + *
>    * Set up the struct with default values for all members:
>    * @boot_progress is set to true and @images is set to the global imag=
es
>    * variable. Everything else is set to NULL except @argc which is 0
> @@ -107,7 +109,7 @@ void bootm_init(struct bootm_info *bmi);
>    *  - disabled interrupts.
>    *
>    * @flag: Flags indicating what to do (BOOTM_STATE_...)
> - * bmi: Bootm information
> + * @bmi: Bootm information
>    * Return: 1 on error. On success the OS boots so this function does
>    * not return.
>    */
> @@ -340,11 +342,13 @@ const char *zimage_get_kernel_version(struct boot_=
params *params,
>    *
>    * This shows all available information in a zimage that has been load=
ed.
>    *
> + * @bmi: Bootm information
>    * @base_ptr: Pointer to the boot parameters, typically at address
>    *	DEFAULT_SETUP_BASE
>    * @show_cmdline: true to show the full command line
>    */
> -void zimage_dump(struct boot_params *base_ptr, bool show_cmdline);
> +void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
> +		 bool show_cmdline);
>
>   /*
>    * bootm_boot_start() - Boot an image at the given address

