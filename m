Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E89D0C5F8
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 09:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C30E788E65;
	Fri, 25 Oct 2024 11:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FCxWeSYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0487388D47; Fri, 25 Oct 2024 11:57:13 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 416CA88E65
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 11:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5ebc1af9137so993714eaf.2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729850226; x=1730455026; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pVbOKhHg62KiEbQjc64v5erbGTVsTPom7tIiGC4Jhdw=;
 b=FCxWeSYDHjpZKAfVYUfS0j3dsoCesOtJOac5okj41Ab7G8jbBzscRTR7G4s71eyH+3
 /WdZ2CtJMySD97jz3bu06u2+5IP75jfoDckQZgn3DkBzaN2F1ZqcEXwzDqvIvaiwQock
 RUPNeNZfHZ3/+oVjVdvz7CBDm5xguMGIB5guQfkrSfaW8lmapsQBOJZp622aIeeHGN4W
 svxrJwKgt/U+Mvz10o5N+cPvKvMO/0afUTYR0dh3W18VMR8YUNXttwHFO0N0Nfquly9i
 yNNiWylcrx5HnYT1yk6+2V42qrE37+s2Q4Oj3qCft3lS5khFqKRxSRUQMwyhDLhvO/qG
 74Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729850226; x=1730455026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pVbOKhHg62KiEbQjc64v5erbGTVsTPom7tIiGC4Jhdw=;
 b=MXFcfDC6E0XkC1T3oSCAnqwXAmQN/k+h7LmOUsgenLOHr60kCxVvewpa/KgFKQwgkv
 +HAgcXoOrZNhfPKA2IioMpOvxDNhnWWHXCQyGpEgVRcKlGuota7Lu9N0asixlFJ+WW99
 Cg0evT5i2rQ+iBvvnhU/fUdmv/7Dh7O8PIHnnJ57iz38Uzy9t0qw9FOHTqFDgEQKIdU4
 RkSq5a/KAz3S72SIDPzxEtl4pphI5IaedcJkwZPH/q5CvXPxj8nTBktSQ5kNVnkJHMW6
 IscQ36kpH9wYGlqtVE9IYZuY0vc7dDKoj2YsHBe7Mse8goiTSVHlhVmxXMy9v6wkSK19
 ao9w==
X-Gm-Message-State: AOJu0YwMgHdPCD4lqF6tuUmYHX4fqVZbuPy/VSJGGc4ZVQaHutK+r9jP
 ooAsQvTlQ5pP1HPj4xpBIWlrdkxNenbZ2+3bL1fR5oATYHHT5LlbwSm8gxHAR6oiYsgnE+5EHtP
 beAvykS0AoEe3cSuZZc4qFJpTJDgnLicP5sTG5Q==
X-Google-Smtp-Source: AGHT+IHEShbu+Tblvs16QWCslU6swoPsD+9gUZs09g0zjJuT4b90GwA76OFtWH7k4pPc0MWYuo902Tj9zWvvS9x9p/w=
X-Received: by 2002:a05:6870:7251:b0:260:eae3:5ec2 with SMTP id
 586e51a60fabf-28ced2e5efamr4144691fac.26.1729850225833; Fri, 25 Oct 2024
 02:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-6-sjg@chromium.org>
In-Reply-To: <20241022120032.196311-6-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 25 Oct 2024 12:56:29 +0300
Message-ID: <CAC_iWjKUjsMdqXa2YZGiu1FSsjx_aH6cDQsi+2Ng5i-+9obQhQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] sandbox: Report host default-filename in native
 mode
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Simon,


On Tue, 22 Oct 2024 at 15:00, Simon Glass <sjg@chromium.org> wrote:
>
> When the --native flag is given, pretend to be running the host
> architecture rather than sandbox.
>
> Add an 'efidebug filename' command to report it.

Heinrich does this allow you to continue your testing in native archs?

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v8:
> - Add new patch to report host default-filename in native mode
>
>  boot/bootmeth_efi.c | 25 ++------------------
>  boot/efi_fname.c    | 57 +++++++++++++++++++++++++++++++++------------
>  cmd/efidebug.c      | 25 ++++++++++++++++++++
>  include/efi.h       | 25 ++++++++++++++++++++
>  4 files changed, 94 insertions(+), 38 deletions(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 371b36d550b..f836aa655f5 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -25,32 +25,11 @@
>
>  #define EFI_DIRNAME    "/EFI/BOOT/"
>
> -static int get_efi_pxe_arch(void)
> -{
> -       /* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
> -       if (IS_ENABLED(CONFIG_ARM64))
> -               return 0xb;
> -       else if (IS_ENABLED(CONFIG_ARM))
> -               return 0xa;
> -       else if (IS_ENABLED(CONFIG_X86_64))
> -               return 0x6;
> -       else if (IS_ENABLED(CONFIG_X86))
> -               return 0x7;
> -       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
> -               return 0x19;
> -       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
> -               return 0x1b;
> -       else if (IS_ENABLED(CONFIG_SANDBOX))
> -               return 0;       /* not used */
> -
> -       return -EINVAL;
> -}
> -
>  static int get_efi_pxe_vci(char *str, int max_len)
>  {
>         int ret;
>
> -       ret = get_efi_pxe_arch();
> +       ret = efi_get_pxe_arch();
>         if (ret < 0)
>                 return ret;
>
> @@ -239,7 +218,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
>         ret = get_efi_pxe_vci(str, sizeof(str));
>         if (ret)
>                 return log_msg_ret("vci", ret);
> -       ret = get_efi_pxe_arch();
> +       ret = efi_get_pxe_arch();
>         if (ret < 0)
>                 return log_msg_ret("arc", ret);
>         arch = ret;
> diff --git a/boot/efi_fname.c b/boot/efi_fname.c
> index a6b11383bba..790f9e2fa36 100644
> --- a/boot/efi_fname.c
> +++ b/boot/efi_fname.c
> @@ -9,29 +9,34 @@
>   */
>
>  #include <efi.h>
> +#include <errno.h>
>  #include <host_arch.h>
>
> -#ifdef CONFIG_SANDBOX
> -
>  #if HOST_ARCH == HOST_ARCH_X86_64
> -#define BOOTEFI_NAME "BOOTX64.EFI"
> +#define HOST_BOOTEFI_NAME "BOOTX64.EFI"
> +#define HOST_PXE_ARCH 0x6
>  #elif HOST_ARCH == HOST_ARCH_X86
> -#define BOOTEFI_NAME "BOOTIA32.EFI"
> +#define HOST_BOOTEFI_NAME "BOOTIA32.EFI"
> +#define HOST_PXE_ARCH 0x7
>  #elif HOST_ARCH == HOST_ARCH_AARCH64
> -#define BOOTEFI_NAME "BOOTAA64.EFI"
> +#define HOST_BOOTEFI_NAME "BOOTAA64.EFI"
> +#define HOST_PXE_ARCH 0xb
>  #elif HOST_ARCH == HOST_ARCH_ARM
> -#define BOOTEFI_NAME "BOOTARM.EFI"
> +#define HOST_BOOTEFI_NAME "BOOTARM.EFI"
> +#define HOST_PXE_ARCH 0xa
>  #elif HOST_ARCH == HOST_ARCH_RISCV32
> -#define BOOTEFI_NAME "BOOTRISCV32.EFI"
> +#define HOST_BOOTEFI_NAME "BOOTRISCV32.EFI"
> +#define HOST_PXE_ARCH 0x19
>  #elif HOST_ARCH == HOST_ARCH_RISCV64
> -#define BOOTEFI_NAME "BOOTRISCV64.EFI"
> +#define HOST_BOOTEFI_NAME "BOOTRISCV64.EFI"
> +#define HOST_PXE_ARCH 0x1b
>  #else
> -#error Unsupported UEFI architecture
> +#error Unsupported Host architecture
>  #endif
>
> -#else
> -
> -#if defined(CONFIG_ARM64)
> +#if defined(CONFIG_SANDBOX)
> +#define BOOTEFI_NAME "BOOTSBOX.EFI"
> +#elif defined(CONFIG_ARM64)
>  #define BOOTEFI_NAME "BOOTAA64.EFI"
>  #elif defined(CONFIG_ARM)
>  #define BOOTEFI_NAME "BOOTARM.EFI"
> @@ -47,9 +52,31 @@
>  #error Unsupported UEFI architecture
>  #endif
>
> -#endif
> -
>  const char *efi_get_basename(void)
>  {
> -       return BOOTEFI_NAME;
> +       return efi_use_host_arch() ? HOST_BOOTEFI_NAME : BOOTEFI_NAME;
> +}
> +
> +int efi_get_pxe_arch(void)
> +{
> +       if (efi_use_host_arch())
> +               return HOST_PXE_ARCH;
> +
> +       /* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
> +       if (IS_ENABLED(CONFIG_ARM64))
> +               return 0xb;
> +       else if (IS_ENABLED(CONFIG_ARM))
> +               return 0xa;
> +       else if (IS_ENABLED(CONFIG_X86_64))
> +               return 0x6;
> +       else if (IS_ENABLED(CONFIG_X86))
> +               return 0x7;
> +       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
> +               return 0x19;
> +       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
> +               return 0x1b;
> +       else if (IS_ENABLED(CONFIG_SANDBOX))
> +               return 0;       /* not used */
> +
> +       return -EINVAL;
>  }
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index e040fe75fa1..02f1e080e88 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -511,6 +511,27 @@ static int do_efi_show_images(struct cmd_tbl *cmdtp, int flag,
>         return CMD_RET_SUCCESS;
>  }
>
> +/**
> + * do_efi_show_defaults() - show UEFI default filename and PXE architecture
> + *
> + * @cmdtp:     Command table
> + * @flag:      Command flag
> + * @argc:      Number of arguments
> + * @argv:      Argument array
> + * Return:     CMD_RET_SUCCESS on success, CMD_RET_RET_FAILURE on failure
> + *
> + * Implement efidebug "defaults" sub-command.
> + * Shows the default EFI filename and PXE architecture
> + */
> +static int do_efi_show_defaults(struct cmd_tbl *cmdtp, int flag,
> +                               int argc, char *const argv[])
> +{
> +       printf("Default boot path: EFI\\BOOT\\%s\n", efi_get_basename());
> +       printf("PXE arch: 0x%02x\n", efi_get_pxe_arch());
> +
> +       return CMD_RET_SUCCESS;
> +}
> +
>  static const char * const efi_mem_type_string[] = {
>         [EFI_RESERVED_MEMORY_TYPE] = "RESERVED",
>         [EFI_LOADER_CODE] = "LOADER CODE",
> @@ -1561,6 +1582,8 @@ static struct cmd_tbl cmd_efidebug_sub[] = {
>                          "", ""),
>         U_BOOT_CMD_MKENT(dh, CONFIG_SYS_MAXARGS, 1, do_efi_show_handles,
>                          "", ""),
> +       U_BOOT_CMD_MKENT(defaults, CONFIG_SYS_MAXARGS, 1, do_efi_show_defaults,
> +                        "", ""),
>         U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_show_images,
>                          "", ""),
>         U_BOOT_CMD_MKENT(memmap, CONFIG_SYS_MAXARGS, 1, do_efi_show_memmap,
> @@ -1653,6 +1676,8 @@ U_BOOT_LONGHELP(efidebug,
>         "  - show UEFI drivers\n"
>         "efidebug dh\n"
>         "  - show UEFI handles\n"
> +       "efidebug defaults\n"
> +       "  - show default EFI filename and PXE architecture\n"
>         "efidebug images\n"
>         "  - show loaded images\n"
>         "efidebug memmap\n"
> diff --git a/include/efi.h b/include/efi.h
> index 1b8093bd4d3..70bb47e742f 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -678,4 +678,29 @@ void efi_show_tables(struct efi_system_table *systab);
>   */
>  const char *efi_get_basename(void);
>
> +#ifdef CONFIG_SANDBOX
> +#include <asm/state.h>
> +#endif
> +
> +static inline bool efi_use_host_arch(void)
> +{
> +#ifdef CONFIG_SANDBOX

#if IS_ENABLED(CONFIG_SANDBOX) is preferred no ?

> +       struct sandbox_state *state = state_get_current();
> +
> +       return state->native;
> +#else
> +       return false;
> +#endif
> +}
> +
> +/**
> + * efi_get_pxe_arch() - Get the architecture value for PXE
> + *
> + * See:
> + * http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml
> + *
> + * Return: Architecture value
> + */
> +int efi_get_pxe_arch(void);
> +
>  #endif /* _LINUX_EFI_H */
> --
> 2.43.0
>

Thanks
/Ilias
