Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40BDC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3B8C8847B;
	Mon, 26 Aug 2024 12:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lmZ/F2k7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B4B8847B; Mon, 26 Aug 2024 12:23:36 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D121C889C5
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fec34f94abso38207345ad.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724667812; x=1725272612; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xo9lbkVGyssTrX8N4giD41H8rjynwSadbaIFe02MgwE=;
 b=lmZ/F2k7qscKU+jpYyCKeZU6k97J6KoxMRikz2lKN95xdpBstvhzpvqvE03hKEfnSO
 yR6Ihab1s5rK5ipbHEMgNTjyMySFVEb+16+lxVsBJLptr78M9fJ9bg73GzaBiqE7TdO+
 mq6NUGZmmesCj2QduES+seQPMCjyg1E4QMfpIVvRX7p0Pnuljkiv48Wavnyt+btgHWhH
 XSyqmX+BBAHnkXdCJDaUWB/K7lbvjgY79FKBOF1J3q5PbUY3CSBX1XrUKrimmYpE3tQM
 Oxcovt/tDQ0PohjnxebQ3t075XiD+/v7ODTy4OaXdEnvi4w8ghKXKEU/XQl0o0wJBnAf
 C54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724667812; x=1725272612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xo9lbkVGyssTrX8N4giD41H8rjynwSadbaIFe02MgwE=;
 b=xRqU/4QJetJ17e8PmhOkK7z2BtYuBbZh4QdE3Hhbzp5X0thoQODZ0I7mfydww6oVRn
 ECb3W6eouAXHNuafitFZnu2lel9quf8fbsSVFGgfYHKZ78qa00n9WsfIX1vO366HqSVO
 boZyP3NBgRWAdl/GvXRpEODPkJeTLsfUw6pRM2FHFUTSsblzsEV4o7r8XRCRYWR5ZmAG
 3kAFC2hTsBstMWdZr4k1quIkL/rIhCpk04E4W4jKRF1/vcVVFkblwxnd8pg0Uza0tykj
 PT3YX2779YkCwJqSpgHQbcnst0JtK1p5NGoPXkf8geyjKuUuWcTkbv0zSybgWU2J04Sp
 CcOQ==
X-Gm-Message-State: AOJu0YzeHrpUXMLUEXRqCtfwPfMhLp0Mj/2MqXfl9P3g9q3TjKTjJMm1
 lWv1O6Se6ko4/x+TPNxuOikhBtnXhPg4+5Df+4HdfSoADQrVClUiXUmoyWVPXWcLgKJ0lcfQMIg
 i5wT5XmpEMrlM1pB8ElFjO/ooMq3IiC/D9G0kxA==
X-Google-Smtp-Source: AGHT+IFsiCqL00a+9da9IXsshRAr4JdkdPdz0QnSGUfm1N6zExEQzngOmXRW9URsljLB3wGinPlP3xsgIVpYQMGPs1A=
X-Received: by 2002:a17:902:e888:b0:1fb:6d12:2c1c with SMTP id
 d9443c01a7336-2039e47a4cemr97706405ad.19.1724667811973; Mon, 26 Aug 2024
 03:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-4-sjg@chromium.org>
In-Reply-To: <20240815202424.766778-4-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 13:22:55 +0300
Message-ID: <CAC_iWjKW_aKXFH1CKqVOk6Y3WdM8b1CNDnXhv49N659G2M_hFA@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] efi_loader: Rename and move
 CMD_BOOTEFI_HELLO_COMPILE
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Thu, 15 Aug 2024 at 23:24, Simon Glass <sjg@chromium.org> wrote:
>
> This is not actually a command so the name is confusing. Use
> BOOTEFI_HELLO_COMPILE instead. Put it in the efi_loader directory
> with the other such config options.
>
> The link rule (for $(obj)/%_efi.so) in scripts/Makefile.lib handles
> pulling in efi_crt0.o and efi_reloc.o so drop the 'extra' rules.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Drop the extra- rules since scripts/Makefile.lib takes care of it
>
>  arch/arm/lib/Makefile            |  1 -
>  arch/riscv/lib/Makefile          |  1 -
>  arch/x86/lib/Makefile            |  2 +-
>  cmd/Kconfig                      | 14 +-------------
>  configs/octeontx2_95xx_defconfig |  2 +-
>  configs/octeontx2_96xx_defconfig |  2 +-
>  configs/octeontx_81xx_defconfig  |  2 +-
>  configs/octeontx_83xx_defconfig  |  2 +-
>  doc/develop/uefi/uefi.rst        |  2 +-
>  lib/efi_loader/Kconfig           | 12 ++++++++++++
>  lib/efi_loader/Makefile          |  2 +-
>  test/py/tests/test_efi_fit.py    |  2 +-
>  test/py/tests/test_efi_loader.py |  2 +-
>  13 files changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 67275fba616..4e54c577cc3 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -130,7 +130,6 @@ CFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
>  CFLAGS_$(EFI_RELOC) := $(CFLAGS_EFI)
>  CFLAGS_REMOVE_$(EFI_RELOC) := $(CFLAGS_NON_EFI)
>
> -extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) += $(EFI_CRT0) $(EFI_RELOC)
>  # TODO: As of v2019.01 the relocation code for the EFI application cannot
>  # be built on ARMv7-M.
>  ifndef CONFIG_CPU_V7M
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index 65dc49f6fa5..4f6272aab6e 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -36,7 +36,6 @@ CFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
>  CFLAGS_$(EFI_RELOC) := $(CFLAGS_EFI)
>  CFLAGS_REMOVE_$(EFI_RELOC) := $(CFLAGS_NON_EFI)
>
> -extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) += $(EFI_CRT0) $(EFI_RELOC)
>  extra-$(CONFIG_CMD_BOOTEFI_SELFTEST) += $(EFI_CRT0) $(EFI_RELOC)
>  extra-$(CONFIG_EFI) += $(EFI_CRT0) $(EFI_RELOC)
>
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index 8fc35e1b51e..8bc8d92172b 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -97,7 +97,7 @@ endif
>  else
>
>  ifndef CONFIG_SPL_BUILD
> -ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST)$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE),)
> +ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST),)
>  extra-y += $(EFI_CRT0) $(EFI_RELOC)
>  endif
>  endif
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 8af136d2bd4..f8a7e03400a 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -438,21 +438,9 @@ config CMD_BOOTEFI_BOOTMGR
>           This subcommand will allow you to select the UEFI binary to be booted
>           via UEFI variables Boot####, BootOrder, and BootNext.
>
> -config CMD_BOOTEFI_HELLO_COMPILE
> -       bool "Compile a standard EFI hello world binary for testing"
> -       default y
> -       help
> -         This compiles a standard EFI hello world application with U-Boot so
> -         that it can be used with the test/py testing framework. This is useful
> -         for testing that EFI is working at a basic level, and for bringing
> -         up EFI support on a new architecture.
> -
> -         No additional space will be required in the resulting U-Boot binary
> -         when this option is enabled.
> -
>  config CMD_BOOTEFI_HELLO
>         bool "Allow booting a standard EFI hello world for testing"
> -       depends on CMD_BOOTEFI_BINARY && CMD_BOOTEFI_HELLO_COMPILE
> +       depends on CMD_BOOTEFI_BINARY && BOOTEFI_HELLO_COMPILE
>         default y if CMD_BOOTEFI_SELFTEST
>         help
>           This adds a standard EFI hello world application to U-Boot so that
> diff --git a/configs/octeontx2_95xx_defconfig b/configs/octeontx2_95xx_defconfig
> index c5dc4f4dfa6..23c313375ac 100644
> --- a/configs/octeontx2_95xx_defconfig
> +++ b/configs/octeontx2_95xx_defconfig
> @@ -38,7 +38,7 @@ CONFIG_SYS_PBSIZE=1050
>  CONFIG_BOARD_EARLY_INIT_R=y
>  CONFIG_HUSH_PARSER=y
>  CONFIG_SYS_PROMPT="Marvell> "
> -# CONFIG_CMD_BOOTEFI_HELLO_COMPILE is not set
> +# CONFIG_BOOTEFI_HELLO_COMPILE is not set
>  CONFIG_CMD_MD5SUM=y
>  CONFIG_MD5SUM_VERIFY=y
>  CONFIG_CMD_MX_CYCLIC=y
> diff --git a/configs/octeontx2_96xx_defconfig b/configs/octeontx2_96xx_defconfig
> index ad61b80300f..197e72acd1f 100644
> --- a/configs/octeontx2_96xx_defconfig
> +++ b/configs/octeontx2_96xx_defconfig
> @@ -38,7 +38,7 @@ CONFIG_SYS_PBSIZE=1050
>  CONFIG_BOARD_EARLY_INIT_R=y
>  CONFIG_HUSH_PARSER=y
>  CONFIG_SYS_PROMPT="Marvell> "
> -# CONFIG_CMD_BOOTEFI_HELLO_COMPILE is not set
> +# CONFIG_BOOTEFI_HELLO_COMPILE is not set
>  CONFIG_CMD_MD5SUM=y
>  CONFIG_MD5SUM_VERIFY=y
>  CONFIG_CMD_MX_CYCLIC=y
> diff --git a/configs/octeontx_81xx_defconfig b/configs/octeontx_81xx_defconfig
> index 1d39bce6abd..b501d653c27 100644
> --- a/configs/octeontx_81xx_defconfig
> +++ b/configs/octeontx_81xx_defconfig
> @@ -39,7 +39,7 @@ CONFIG_SYS_PBSIZE=1050
>  CONFIG_BOARD_EARLY_INIT_R=y
>  CONFIG_HUSH_PARSER=y
>  CONFIG_SYS_PROMPT="Marvell> "
> -# CONFIG_CMD_BOOTEFI_HELLO_COMPILE is not set
> +# CONFIG_BOOTEFI_HELLO_COMPILE is not set
>  CONFIG_CMD_MD5SUM=y
>  CONFIG_MD5SUM_VERIFY=y
>  CONFIG_CMD_MX_CYCLIC=y
> diff --git a/configs/octeontx_83xx_defconfig b/configs/octeontx_83xx_defconfig
> index ba9fc5f9553..4a537f5cbbe 100644
> --- a/configs/octeontx_83xx_defconfig
> +++ b/configs/octeontx_83xx_defconfig
> @@ -37,7 +37,7 @@ CONFIG_SYS_PBSIZE=1050
>  CONFIG_BOARD_EARLY_INIT_R=y
>  CONFIG_HUSH_PARSER=y
>  CONFIG_SYS_PROMPT="Marvell> "
> -# CONFIG_CMD_BOOTEFI_HELLO_COMPILE is not set
> +# CONFIG_BOOTEFI_HELLO_COMPILE is not set
>  CONFIG_CMD_MD5SUM=y
>  CONFIG_MD5SUM_VERIFY=y
>  CONFIG_CMD_MX_CYCLIC=y
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index d450b12bf80..9aeee23a32e 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -693,7 +693,7 @@ Executing the built in hello world application
>
>  A hello world UEFI application can be built with::
>
> -    CONFIG_CMD_BOOTEFI_HELLO_COMPILE=y
> +    CONFIG_BOOTEFI_HELLO_COMPILE=y
>
>  It can be embedded into the U-Boot binary with::
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 1179c31bb13..ab2c1c44364 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -516,4 +516,16 @@ config EFI_HTTP_BOOT
>           Enabling this option adds EFI HTTP Boot support. It allows to
>           directly boot from network.
>
> +config BOOTEFI_HELLO_COMPILE
> +       bool "Compile a standard EFI hello world binary for testing"
> +       default y
> +       help
> +         This compiles a standard EFI hello world application with U-Boot so
> +         that it can be used with the test/py testing framework. This is useful
> +         for testing that EFI is working at a basic level, and for bringing
> +         up EFI support on a new architecture.
> +
> +         No additional space will be required in the resulting U-Boot binary
> +         when this option is enabled.
> +
>  endif
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 2af6f2066b5..27dbd9e760d 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -27,7 +27,7 @@ always += boothart.efi
>  targets += boothart.o
>  endif
>
> -ifneq ($(CONFIG_CMD_BOOTEFI_HELLO_COMPILE),)
> +ifneq ($(CONFIG_BOOTEFI_HELLO_COMPILE),)
>  always += helloworld.efi
>  targets += helloworld.o
>  endif
> diff --git a/test/py/tests/test_efi_fit.py b/test/py/tests/test_efi_fit.py
> index 0ad483500f8..550058a30fd 100644
> --- a/test/py/tests/test_efi_fit.py
> +++ b/test/py/tests/test_efi_fit.py
> @@ -119,7 +119,7 @@ FDT_DATA = '''
>  '''
>
>  @pytest.mark.buildconfigspec('bootm_efi')
> -@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> +@pytest.mark.buildconfigspec('BOOTEFI_HELLO_COMPILE')
>  @pytest.mark.buildconfigspec('fit')
>  @pytest.mark.notbuildconfigspec('generate_acpi_table')
>  @pytest.mark.requiredtool('dtc')
> diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
> index 85473a9049b..ef1f1f1afb3 100644
> --- a/test/py/tests/test_efi_loader.py
> +++ b/test/py/tests/test_efi_loader.py
> @@ -148,7 +148,7 @@ def fetch_tftp_file(u_boot_console, env_conf):
>      return addr
>
>  @pytest.mark.buildconfigspec('of_control')
> -@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> +@pytest.mark.buildconfigspec('BOOTEFI_HELLO_COMPILE')
>  def test_efi_helloworld_net(u_boot_console):
>      """Run the helloworld.efi binary via TFTP.
>
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
