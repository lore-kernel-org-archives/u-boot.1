Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74321C83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 07:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A223A81FEE;
	Thu,  3 Jul 2025 09:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dZ/2YQ4k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EFF282063; Thu,  3 Jul 2025 09:25:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53EE280194
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 09:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751527528; x=1752132328; i=xypron.glpk@gmx.de;
 bh=iZaEJKCQekjeI15NdtNMfQrDdGbzfo+vqkDv7IfhJzA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dZ/2YQ4kZ45f/xciFDnreRmrz6AGBo0BR/8BBrHl9eolnb89PnD8tHne1X1OmOMM
 9bMljiRcagoe6vUw65/2usJ0zt8/mGB7G8+xus2akuAhY513M16c8enp0z5zQNDTP
 i5KuWcsZEgZvh9Dj46dW6LnALGELTqVF3XbeRDrj9gKY13kiKOt5AdneM/ktjVrtL
 8jTZk7VlVGTVveEInksuNwM2kHbwUStStiQ/NoPlChzb1TYzWkdNjg6Lm7UCxtM4n
 W8qdxDTHuhocEPzz2h3C1p6S5E3IcZPhgakjjEDT7VJ5XhtHQDEnWzeeQjfr0y/fc
 q1ldK7/f1uOVqbPNZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDywo-1uNIgd3Wui-00CkFO; Thu, 03
 Jul 2025 09:25:27 +0200
Message-ID: <1e2e7d6d-2704-467a-b2a0-58a99600378f@gmx.de>
Date: Thu, 3 Jul 2025 09:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/5] efi: add EFI_SYSTEM_TABLE_POINTER for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250703062811.72871-1-paulliu@debian.org>
 <20250703062811.72871-2-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250703062811.72871-2-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:crZ4iUh1rHdoBGt90SDRWPxkw9kNcRVoAnT0hq3mqdo5EFu6Whi
 Iex/UgcvqdsmMgUW5Cqd0BWmDC4W8o3A/6OB63k6/86owORO6LKW+rlz8cYwjNrMbBUHxnE
 T4zI6oAYqNM7vjuYX4ov3lriGukSKM9nl9mTlnAS0uo8l7AXXLpr6FsM03mc3EEp/AQpmLf
 yveERSfvTZoEvQPVFTF8g==
UI-OutboundReport: notjunk:1;M01:P0:OesIOEc4Cmc=;MPf4qj8xpVzxwEYoPdQabkxd/xo
 954+Srfaa62ROi+ejeSyFtVoPGhW+Po1tUG1iA/lCXYdJNovH3KXaUksxv8avoq06L716h1KL
 Fe2QFIVyeQ7yzShIfOP1hXkbljpR0qSR/iWk0zz1pSFGsEkusnokCP9Q8HMwM4t0CfNHpv+vV
 hVJpe9A5llp2sNTJ1D/C2oG7cOtdmJpW/JS5f/iU5wtLXf45/CJ4S1dRAQ03saRxGnvoOhFmU
 OrWkEQs4NUBwosqAu6Rco/8TzBDGUX3QwBbuoWR7A9rC8JJMdaG4DrN5/itVDVJDzP2ZUr4A0
 wGym97i0dL4Ahne1oyW8Z4D4IXK3h9QSUMXtT/CEgVu8Z+cxDdOG4gfDzwRg7lVad1nBVTJls
 aV4aBLsB7uU5QjfyHILiFVxdUOS0zq4sdY50SWjgSo+mIczpU79/NmOUbOgQhisUVWh1IFa4H
 K/3/e08dKq0PlW1Z6F5XH+QAsVI007FWf8Vg9kKjoBqzfZtIRQ+0SZp0iDwiKgmSQpwx9/5R7
 o+AN69GNCQhONn5QxcHLoZSSyu1WZvLQOQZPZsgqwp5jueCAl9aBpgHN1F1/bSb9kdNivWkPl
 ePEq7MHcUIX1wzqE8izBfnOZIDoaUe8uzsvSLIxbJd9nl4cPwybD9sb2Y4//cs6zJN+Tl2QGg
 8rh55Ef2Hw0j7Bz0aRFb7RjzEfc32VUTYpIk2zHaDUID6B7x+RKAsjYROZe4t+X8bezpE47/y
 dE5+uAc/w2ZlgSnCmzKIQp96Rh5inJahrw/bFSdvYYgUIQDFXLXrGqUSN1DbTw2AQSqb7KRn/
 9lSta+XXq+0AGPlkYt7IKftqjqmgVDwTw9coIy/EIsSmcGiZStYRHH6T9oA32TW6ER0dsOQVS
 89gmLAAt9wPuooLPYy2zMXKe0PtblWW6Ui/vzDURaxRhWI7MN9yY9XrQlq8s5VXje1BlkeskC
 hHfOfkra0VD2TK8kuWxHhT28pM7rQg7ZOfM6MeD5w3T6Qk6KkpQ8jFAxS2y0eaI1qedZBwROJ
 IreKVm2FCvyTBNqCleOIa8UwaTo0kfuPnQWH7q6UfzdRsAY8XQEBhkg/6Cr8lrV3S1OeLRHuM
 z8XCcw4SPlcBoQSIOdDSqH36S1guC7nIqwC1GFCd40sGrbBlMBbwHsPt8w9JfAqxz693zXwvs
 UmpWXi7PSOHwP7k0VD7Js8tA1rNprCi8pPqPRS6QDcQ0ZdFSTT/3Dwgx08In24k0oS9BopnGv
 Mm9Q5VtSguB71mxGP668shVC4ENiQ6hu7NdZOc6iFVco+pBmCIpCnGzzyc2rnszjfwGdszpaH
 kftzMndiFH1REwVGQfeJp0wO51RqhegGsVGsWvDvtq85otccOiibBS+Xj+9utSNXrU8KBxqap
 GUHeHpIZBAs360y6NxNlQXpB0A5+UL2TKvUuIRZ4AWOrW6ZGMzYwGn+I2Gs2stAROB23a9J1G
 cHvzTWssNc3VZKW2B8zQaBCLIdnqO/8rlJZuQpV0dR0g6oIuBjeIQtDU5rTtyONvKYDVDHnwO
 HL3kaD1smjNKExm2el7S71K68FqL3ztLb+wDoXPIj5BLRi38ht1BPJ6iZGg1Z5toiywM7n7JO
 A+0oFFsorBjo4XhZlq4aJ1ECUKsh8jyS398IBqOfqcrH8E0bNFO6IRQrbtGZMetm17XrWog8H
 rVvhdUE0noycyVKupQeUrW3o6z5Gnt/KnGqzYNj+qw73Il3rrEoIYc98P0AGwn4o4ksW+HloW
 rJTKsLaodSuLkhoK2HzxIIqF9qhrVQHloHMCqp9lxiFfGFrS6RVaaJsQ+4dO0gugKXgxaOeum
 lzS7yAR886ud1X9Py13NZLON49KKkreTdkDK6CLZPBzkPTxYCotD+/9okJH+qm3YtGZjegDBq
 jFlDjnnL+5q3G/SDI/AtAgmhfrIxl6jrl407qKF1mtAZW5Pwvk4kvbPFHdTloAsQekDlpieVP
 KPw8z8Xb3isj0C2v7c+BF3zE8i0kBFmhtKMgTgBRHq9cqRBUFNOiP2ld5mdIFSeCr60sCX0YJ
 BKIBIiQihwSVKtGT++BW0tZIe30jYF5f1+h+daNug6a0BKx9iGAk+zKsYrbBnGrCUCRWzLsTe
 J/g+uS/6NdUn3P3h0yeEuKSFeLRMD+49bXhQCJteOzZdRjR9nEaPJC/POUuN28OXFfBalTlus
 25Kta73tJeu4LBBfINtzLx0vXDetaBFM4jIKafhkIM+93PjepRX1dRd6zpE6pvMgWhih01xao
 acuPUxTLI71EL4Vvb+THRiTRTKwdPKMrp76fSmzVw3hc3IceXgAYy9Dpxtk5GHJucvTsecyns
 c+pV7TylGQ1eywKT+iqzQbKUclJYzepKrIj9xrznOaOj2tCAZT9SIkwAmWdTJku8LV4seWY/m
 9bn/OKX9XkOUHwZI2M7fHC+0pfyGuHJC03avk9fHdMkNxJB21qC9OrJ979LUSlsb62aTWlfEK
 LgG89DpBRlsCO4PYgA6AzoVuLIiQXiUEHn+iYNnhVA8Nw1+rPjSkiZCOCFi57Ybxp8cwni2JW
 JKujy2JOFR1xt2NJlP3aicfX8PwMP0aSWm5zvNOSjeb+o+EGiaYJTGuPKJ1YHptO/J5Qd0OUY
 /EiOzWdg7Q1dhaZYgQ+O59FSMJAXjYMPYsC+ESCj/lsBdODcjScMpD2+mY4bhVLXWJYcrMBhL
 ZTmS+c23js4fREw7klfjgrWpEX6cfFDuoH6L0kKwxZTi+HCTuRUzklWNktkvmybh6g2jiiUTc
 fc5qAC9iRaG8wq3gTXaTZ8MUYei5pnXGjAiN2R2YXBoYkbS6SnhqtYlTmNOcROl0Ij7ilUOVI
 p+rawkHFMezIbI/ea49uebWntDCgfgt2cX8acPQ9bZygu7giiuALfCwQ7GWMllwU+O1CSx2p3
 AqpE7E/XE1a9Fzreb32t5M/ORcOmA785Ubgvq9w21SVAGyfjgPYlm6iGP39wJuEZnVb78z0rm
 XbIKW0w9d0+A795Yrgit7VS7Q2b4sVQV0+FOOcO91Z8e3tUdGaD4rh9w5jHCUdsiCBGbahjFn
 4kdU5nt/Y3IebSWDDT6SF7PjIK47fHMdYz+C1t0q/jR36YMZl3xtgzQ8mD3OAflzScZhunVXt
 3kSs5CbM+WrsXFgiccCDrhhXImu/n+syG9iG8/LRPkRrCtu5nIwYgU6ngNPF6/MO+x9sKpkgf
 4KqjDKDEQ0w+Xyyx+3OGmaz4ciHXNsF7PwSXqOp/TcA57rjqL/QMp4AnMH/vl5vpYlm5tSDTu
 8UxjzbtbHhw0aAa4OzEQ4dVV7LvzuyuLJHca+eE5Tf+c+0w4etfDkL4M4spDV8q0q0qGavHG5
 +b7xh6L2MFsRyUzPgfxe4cWXSWPFlw0VUBNU3/kGf5KUg6bK7F4t5EI3a+tLAluw4r2URbBVa
 M0CSjeyGaCOh7uqY4J409PII2GsD3pUFqd1phuuJIqEjGEFV9dQvHYoeuGkObuLAp+vIKsk0e
 XxeitNvYcEiuR5PTdPXu11tzFGjlXbRA=
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

On 03.07.25 08:28, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>=20
> Add EFI_SYSTEM_TABLE_POINTER structure for remote debugger to locate
> the address of EFI_SYSTEM_TABLE.
>=20
> This feature is described in UEFI SPEC version 2.10. Section 18.4.2.
> The implementation ensures support for hardware-assisted debugging and
> provides a standardized mechanism for debuggers to discover the EFI
> system table.
>=20
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V2: add Kconfig options to turn on/off this feature.
> V3: make efi_initialize_system_table_pointer() do the job as described.
> V4: use efi_alloc_aligned_pages() for system_table_pointer.
> V5: move the code into a separate module.
> V6: Use macros to replace size_4MB
> V7: Fix the code based on the review. Update license field.
> V8: Fix pointer casting that causes qemu_arm_defconfig failed. Modify KC=
onfig
>      so that more defconfigs enabled by default.
> ---
>   include/efi_api.h                  | 16 ++++++++++++
>   include/efi_loader.h               |  2 ++
>   lib/efi_loader/Kconfig             |  9 +++++++
>   lib/efi_loader/Makefile            |  1 +
>   lib/efi_loader/efi_debug_support.c | 40 ++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_setup.c         |  7 ++++++
>   6 files changed, 75 insertions(+)
>   create mode 100644 lib/efi_loader/efi_debug_support.c
>=20
> diff --git a/include/efi_api.h b/include/efi_api.h
> index eb61eafa028..6c4c1a0cc7b 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -259,6 +259,22 @@ struct efi_capsule_result_variable_header {
>   	efi_status_t capsule_status;
>   } __packed;
>  =20
> +/**
> + * struct efi_system_table_pointer - struct to store the pointer of sys=
tem
> + * table.
> + * @signature: The signature of this struct.
> + * @efi_system_table_base: The physical address of System Table.
> + * @crc32: CRC32 checksum
> + *
> + * This struct is design for hardware debugger to search through memory=
 to
> + * get the address of EFI System Table.
> + */
> +struct efi_system_table_pointer {
> +	u64 signature;
> +	efi_physical_addr_t efi_system_table_base;
> +	u32 crc32;
> +};
> +
>   struct efi_memory_range {
>   	efi_physical_addr_t	address;
>   	u64			length;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 8f9f2bcf1cb..8f065244d8e 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -646,6 +646,8 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb);
>   efi_status_t efi_root_node_register(void);
>   /* Called by bootefi to initialize runtime */
>   efi_status_t efi_initialize_system_table(void);
> +/* Called by bootefi to initialize debug */
> +efi_status_t efi_initialize_system_table_pointer(void);
>   /* efi_runtime_detach() - detach unimplemented runtime functions */
>   void efi_runtime_detach(void);
>   /* efi_convert_pointer() - convert pointer to virtual address */
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 7f02a83e2a2..621db8b5c79 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -71,6 +71,15 @@ config EFI_SECURE_BOOT
>   config EFI_SIGNATURE_SUPPORT
>   	bool
>  =20
> +config EFI_DEBUG_SUPPORT
> +	bool "EFI Debug Support"
> +	default y if !HAS_BOARD_SIZE_LIMIT
> +	help
> +	  Select this option if you want to setup the EFI Debug Support
> +	  Table and the EFI_SYSTEM_TABLE_POINTER which is used by the debug
> +	  agent or an external debugger to determine loaded image information
> +	  in a quiescent manner.
> +
>   menu "UEFI services"
>  =20
>   config EFI_GET_TIME
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index cf050e5385d..51ccf1cd87e 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_EFI_RISCV_BOOT_PROTOCOL) +=3D efi_riscv.o
>   obj-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D efi_load_initrd.o
>   obj-$(CONFIG_EFI_SIGNATURE_SUPPORT) +=3D efi_signature.o
>   obj-$(CONFIG_EFI_ECPT) +=3D efi_conformance.o
> +obj-$(CONFIG_EFI_DEBUG_SUPPORT) +=3D efi_debug_support.o
>  =20
>   EFI_VAR_SEED_FILE :=3D $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
>   $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
> diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_deb=
ug_support.c
> new file mode 100644
> index 00000000000..7dc5fa93af9
> --- /dev/null
> +++ b/lib/efi_loader/efi_debug_support.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * EFI debug support
> + *
> + * Copyright (c) 2025 Ying-Chun Liu, Linaro Ltd. <paul.liu@linaro.org>
> + */
> +
> +#include <efi_loader.h>
> +#include <linux/sizes.h>
> +#include <u-boot/crc.h>
> +
> +struct efi_system_table_pointer __efi_runtime_data * systab_pointer =3D=
 NULL;
> +
> +/**
> + * efi_initialize_system_table_pointer() - Initialize system table poin=
ter
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_initialize_system_table_pointer(void)
> +{
> +	/* Allocate efi_system_table_pointer structure with 4MB alignment. */
> +	systab_pointer =3D efi_alloc_aligned_pages(sizeof(struct efi_system_ta=
ble_pointer),
> +						 EFI_RUNTIME_SERVICES_DATA,
> +						 SZ_4M);
> +
> +	if (!systab_pointer) {
> +		log_err("Installing EFI system table pointer failed\n");
> +		return EFI_OUT_OF_RESOURCES;
> +	}
> +
> +	memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));

systab_pointer->crc32 =3D 0;

would have been an alternative. Maybe Ilias wants to change that when=20
merging.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +
> +	systab_pointer->signature =3D EFI_SYSTEM_TABLE_SIGNATURE;
> +	systab_pointer->efi_system_table_base =3D (uintptr_t)&systab;
> +	systab_pointer->crc32 =3D crc32(0,
> +				      (const unsigned char *)systab_pointer,
> +				      sizeof(struct efi_system_table_pointer));
> +
> +	return EFI_SUCCESS;
> +}
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 48f91da5df7..78c5059256a 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -278,6 +278,13 @@ efi_status_t efi_init_obj_list(void)
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>  =20
> +	/* Initialize system table pointer */
> +	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
> +		ret =3D efi_initialize_system_table_pointer();
> +		if (ret !=3D EFI_SUCCESS)
> +			goto out;
> +	}
> +
>   	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
>   		ret =3D efi_ecpt_register();
>   		if (ret !=3D EFI_SUCCESS)

