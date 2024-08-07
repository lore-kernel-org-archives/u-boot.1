Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E2AC49EA1
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 01:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C2E788AE3;
	Wed,  7 Aug 2024 03:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JVApKQOT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4084B88B07; Wed,  7 Aug 2024 03:02:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F83988A9E
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 03:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722992511; x=1723597311; i=xypron.glpk@gmx.de;
 bh=oywvAjY5XJxMhIoa2/n0U5tluSUPF3Ki/cQeycYExjw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JVApKQOT5HBJxleTtGF3H9X9rCDu5hRyvSp3Qe4oL6fVMms8cWlq1wslDhp62IUv
 cFLYRIl+5kjXEWJSPXa+x6HZkb+HnxGNMebPNAXE5PQYA6ye7NzIMWJGFUfwUa0sv
 JkpN3O2xaxBji9NJH8OG27qhsKbbGsi+4DAxJ4BLJPJ56vK50NpNLWnHzbEV92TZH
 Cs2vuBoOWdX7pG2n3K+uJCD58tfYEPWtwDnlTLIK/WxORjepMu/Huw5MwlzhXQpGk
 x2L7RbYsQgz7RDxZ8f1sR85AcJ4E+d1VZBnSp+oJaS5047QgOIF9tfeTSw1lR72Jq
 0GtT8Dz6QMh6JlBJZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oFz-1sGgLi1MV3-016npf; Wed, 07
 Aug 2024 03:01:51 +0200
Message-ID: <27fe6f78-1d93-463c-9701-e26c591d3dea@gmx.de>
Date: Wed, 7 Aug 2024 03:01:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/39] efi_loader: Rename and move
 CMD_BOOTEFI_HELLO_COMPILE
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Aaron Williams <awilliams@marvell.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Leo <ycliang@andestech.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-28-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240806125850.2316956-28-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X2FzswiPj1/8Bd3pAPVSlahraAeNi7At4+6FuiOzKrGorzu6Xov
 FVxPXfqvOMSIN9i4HKQkI6B1EUjpbyg/NAvCcEZzdNLqzjUqEvaV7usS26xoq0ay0rPrOyy
 CYy2zUPoLyJUcrlZ6C0BLjDOm3LJNQbZ7U6TTOf2AZ6tbfW/aUXydB2XzNVOuFrDt4vfGCr
 yx+dVeq3ZA2HWrE0YpJLA==
UI-OutboundReport: notjunk:1;M01:P0:ESnmj2uHdBs=;QrrdjPaQgQlHns5duJVUaNgpxjU
 zzt+IP+Xo9OOFrJ+PGHANsUjq/bM4XqZwKORgjbez3gID4qYptaZhJqZ+gQcCXZX2kCxOgl16
 Kiu68melpKqqMEDg9+yHoUFT2DOfaFORnOcgl/TRZaBwseZqe/D5Nf19B+77NwC+6bOrWMGe1
 sq2BHdPEB6lWy8IPii4tWQSzdNPaiyV2Dn1O3fdCw2/99m9G5deA+I7oSPPrzbwGopYlM6v64
 cabuqfvmJpBhDlTS3+3c6jT2j6fw1VDJJdoXwn7NVFhbzlXsXXI4XXVucsgyF8c29K+5xawvB
 0b0w3BIdDaLZyZVzqM93L+hTezKAF+NnpX7a1wDdSkUJuIvMkiesm7lIKxbLBzazbVLcJwZc4
 DYLt9Gup3BG55ov65/OGwNCn9P18wLI2qd268NU+emz1MDssD7VdpV+Vk4gMGVSRwB0sLw/z8
 l0rxw5oU1OQhtp1hUK6wIql/RIhh+zabAgsiUD8PdoAWsUhezSG2mXF+QpA97m1kh5DyP9mAG
 lj3/8o6E1w43GbPlJi05ySQs1xpswZyEYW8sFsZ2TDX9jmnkeEkA/Tut9CXHPfHdaULvj7MO6
 +rJ93+H75qnr5SYF5OvavfVZqbP0eLZFDdD0OfEksLVo24DeP5X+OV7cFgpv8vReVs+z6QicL
 tcKfrjd/WQ1d0tKwLoOkn+zNFmJrilWLh7l+K6658cPwSE2E/UtXb2ZZFORBMEMUnSgp9gaCp
 KBDujvfdftSUPL9e8unk+njyUzyTn78tyAp2MmJikiH4L4gUAYDzdwwIywxI5W6PBgDQ1o6yK
 WpNEyIBkasGkTk5HA4fCNdjw==
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

On 06.08.24 14:58, Simon Glass wrote:
> This is not actually a command so the name is confusing. Use
> BOOTEFI_HELLO_COMPILE instead. Put it in the efi_loader directory
> with the other such config options.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   arch/arm/lib/Makefile            |  2 +-
>   arch/riscv/lib/Makefile          |  2 +-
>   arch/x86/lib/Makefile            |  2 +-
>   cmd/Kconfig                      | 14 +-------------
>   configs/octeontx2_95xx_defconfig |  2 +-
>   configs/octeontx2_96xx_defconfig |  2 +-
>   configs/octeontx_81xx_defconfig  |  2 +-
>   configs/octeontx_83xx_defconfig  |  2 +-
>   doc/develop/uefi/uefi.rst        |  2 +-
>   lib/efi_loader/Kconfig           | 12 ++++++++++++
>   lib/efi_loader/Makefile          |  2 +-
>   test/py/tests/test_efi_fit.py    |  2 +-
>   test/py/tests/test_efi_loader.py |  2 +-
>   13 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 67275fba616..406797f998c 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -130,7 +130,7 @@ CFLAGS_REMOVE_$(EFI_CRT0) :=3D $(CFLAGS_NON_EFI)
>   CFLAGS_$(EFI_RELOC) :=3D $(CFLAGS_EFI)
>   CFLAGS_REMOVE_$(EFI_RELOC) :=3D $(CFLAGS_NON_EFI)
>
> -extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) +=3D $(EFI_CRT0) $(EFI_RELOC)
> +extra-$(CONFIG_BOOTEFI_HELLO_COMPILE) +=3D $(EFI_CRT0) $(EFI_RELOC)

In scripts/Makefile.lib we have this line:

$(obj)/%_efi.so: $(obj)/%.o $(obj)/efi_crt0.o $(obj)/efi_reloc.o
$(obj)/efi_freestanding.o

This is enough to build efi_crt0.o and efi_reloc.o when needed.

Please, remove the extra-* lines for these objects.

>   # TODO: As of v2019.01 the relocation code for the EFI application can=
not
>   # be built on ARMv7-M.
>   ifndef CONFIG_CPU_V7M
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index 65dc49f6fa5..3bd90c7a354 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -36,7 +36,7 @@ CFLAGS_REMOVE_$(EFI_CRT0) :=3D $(CFLAGS_NON_EFI)
>   CFLAGS_$(EFI_RELOC) :=3D $(CFLAGS_EFI)
>   CFLAGS_REMOVE_$(EFI_RELOC) :=3D $(CFLAGS_NON_EFI)
>
> -extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) +=3D $(EFI_CRT0) $(EFI_RELOC)
> +extra-$(CONFIG_BOOTEFI_HELLO_COMPILE) +=3D $(EFI_CRT0) $(EFI_RELOC)
>   extra-$(CONFIG_CMD_BOOTEFI_SELFTEST) +=3D $(EFI_CRT0) $(EFI_RELOC)
>   extra-$(CONFIG_EFI) +=3D $(EFI_CRT0) $(EFI_RELOC)

ditto

Best regards

Heinrich

>
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index 8fc35e1b51e..70dccd7f983 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -97,7 +97,7 @@ endif
>   else
>
>   ifndef CONFIG_SPL_BUILD
> -ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST)$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE=
),)
> +ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST)$(CONFIG_BOOTEFI_HELLO_COMPILE),)
>   extra-y +=3D $(EFI_CRT0) $(EFI_RELOC)
>   endif
>   endif
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 978f44eda42..fcf6bb73f88 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -431,21 +431,9 @@ config CMD_BOOTEFI_BOOTMGR
>   	  This subcommand will allow you to select the UEFI binary to be boot=
ed
>   	  via UEFI variables Boot####, BootOrder, and BootNext.
>
> -config CMD_BOOTEFI_HELLO_COMPILE
> -	bool "Compile a standard EFI hello world binary for testing"
> -	default y
> -	help
> -	  This compiles a standard EFI hello world application with U-Boot so
> -	  that it can be used with the test/py testing framework. This is usef=
ul
> -	  for testing that EFI is working at a basic level, and for bringing
> -	  up EFI support on a new architecture.
> -
> -	  No additional space will be required in the resulting U-Boot binary
> -	  when this option is enabled.
> -
>   config CMD_BOOTEFI_HELLO
>   	bool "Allow booting a standard EFI hello world for testing"
> -	depends on CMD_BOOTEFI_BINARY && CMD_BOOTEFI_HELLO_COMPILE
> +	depends on CMD_BOOTEFI_BINARY && BOOTEFI_HELLO_COMPILE
>   	default y if CMD_BOOTEFI_SELFTEST
>   	help
>   	  This adds a standard EFI hello world application to U-Boot so that
> diff --git a/configs/octeontx2_95xx_defconfig b/configs/octeontx2_95xx_d=
efconfig
> index c5dc4f4dfa6..23c313375ac 100644
> --- a/configs/octeontx2_95xx_defconfig
> +++ b/configs/octeontx2_95xx_defconfig
> @@ -38,7 +38,7 @@ CONFIG_SYS_PBSIZE=3D1050
>   CONFIG_BOARD_EARLY_INIT_R=3Dy
>   CONFIG_HUSH_PARSER=3Dy
>   CONFIG_SYS_PROMPT=3D"Marvell> "
> -# CONFIG_CMD_BOOTEFI_HELLO_COMPILE is not set
> +# CONFIG_BOOTEFI_HELLO_COMPILE is not set
>   CONFIG_CMD_MD5SUM=3Dy
>   CONFIG_MD5SUM_VERIFY=3Dy
>   CONFIG_CMD_MX_CYCLIC=3Dy
> diff --git a/configs/octeontx2_96xx_defconfig b/configs/octeontx2_96xx_d=
efconfig
> index ad61b80300f..197e72acd1f 100644
> --- a/configs/octeontx2_96xx_defconfig
> +++ b/configs/octeontx2_96xx_defconfig
> @@ -38,7 +38,7 @@ CONFIG_SYS_PBSIZE=3D1050
>   CONFIG_BOARD_EARLY_INIT_R=3Dy
>   CONFIG_HUSH_PARSER=3Dy
>   CONFIG_SYS_PROMPT=3D"Marvell> "
> -# CONFIG_CMD_BOOTEFI_HELLO_COMPILE is not set
> +# CONFIG_BOOTEFI_HELLO_COMPILE is not set
>   CONFIG_CMD_MD5SUM=3Dy
>   CONFIG_MD5SUM_VERIFY=3Dy
>   CONFIG_CMD_MX_CYCLIC=3Dy
> diff --git a/configs/octeontx_81xx_defconfig b/configs/octeontx_81xx_def=
config
> index 1d39bce6abd..b501d653c27 100644
> --- a/configs/octeontx_81xx_defconfig
> +++ b/configs/octeontx_81xx_defconfig
> @@ -39,7 +39,7 @@ CONFIG_SYS_PBSIZE=3D1050
>   CONFIG_BOARD_EARLY_INIT_R=3Dy
>   CONFIG_HUSH_PARSER=3Dy
>   CONFIG_SYS_PROMPT=3D"Marvell> "
> -# CONFIG_CMD_BOOTEFI_HELLO_COMPILE is not set
> +# CONFIG_BOOTEFI_HELLO_COMPILE is not set
>   CONFIG_CMD_MD5SUM=3Dy
>   CONFIG_MD5SUM_VERIFY=3Dy
>   CONFIG_CMD_MX_CYCLIC=3Dy
> diff --git a/configs/octeontx_83xx_defconfig b/configs/octeontx_83xx_def=
config
> index ba9fc5f9553..4a537f5cbbe 100644
> --- a/configs/octeontx_83xx_defconfig
> +++ b/configs/octeontx_83xx_defconfig
> @@ -37,7 +37,7 @@ CONFIG_SYS_PBSIZE=3D1050
>   CONFIG_BOARD_EARLY_INIT_R=3Dy
>   CONFIG_HUSH_PARSER=3Dy
>   CONFIG_SYS_PROMPT=3D"Marvell> "
> -# CONFIG_CMD_BOOTEFI_HELLO_COMPILE is not set
> +# CONFIG_BOOTEFI_HELLO_COMPILE is not set
>   CONFIG_CMD_MD5SUM=3Dy
>   CONFIG_MD5SUM_VERIFY=3Dy
>   CONFIG_CMD_MX_CYCLIC=3Dy
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index d450b12bf80..9aeee23a32e 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -693,7 +693,7 @@ Executing the built in hello world application
>
>   A hello world UEFI application can be built with::
>
> -    CONFIG_CMD_BOOTEFI_HELLO_COMPILE=3Dy
> +    CONFIG_BOOTEFI_HELLO_COMPILE=3Dy
>
>   It can be embedded into the U-Boot binary with::
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 1179c31bb13..ab2c1c44364 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -516,4 +516,16 @@ config EFI_HTTP_BOOT
>   	  Enabling this option adds EFI HTTP Boot support. It allows to
>   	  directly boot from network.
>
> +config BOOTEFI_HELLO_COMPILE
> +	bool "Compile a standard EFI hello world binary for testing"
> +	default y
> +	help
> +	  This compiles a standard EFI hello world application with U-Boot so
> +	  that it can be used with the test/py testing framework. This is usef=
ul
> +	  for testing that EFI is working at a basic level, and for bringing
> +	  up EFI support on a new architecture.
> +
> +	  No additional space will be required in the resulting U-Boot binary
> +	  when this option is enabled.
> +
>   endif
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 2af6f2066b5..27dbd9e760d 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -27,7 +27,7 @@ always +=3D boothart.efi
>   targets +=3D boothart.o
>   endif
>
> -ifneq ($(CONFIG_CMD_BOOTEFI_HELLO_COMPILE),)
> +ifneq ($(CONFIG_BOOTEFI_HELLO_COMPILE),)
>   always +=3D helloworld.efi
>   targets +=3D helloworld.o
>   endif
> diff --git a/test/py/tests/test_efi_fit.py b/test/py/tests/test_efi_fit.=
py
> index 0ad483500f8..550058a30fd 100644
> --- a/test/py/tests/test_efi_fit.py
> +++ b/test/py/tests/test_efi_fit.py
> @@ -119,7 +119,7 @@ FDT_DATA =3D '''
>   '''
>
>   @pytest.mark.buildconfigspec('bootm_efi')
> -@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> +@pytest.mark.buildconfigspec('BOOTEFI_HELLO_COMPILE')
>   @pytest.mark.buildconfigspec('fit')
>   @pytest.mark.notbuildconfigspec('generate_acpi_table')
>   @pytest.mark.requiredtool('dtc')
> diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_l=
oader.py
> index 85473a9049b..ef1f1f1afb3 100644
> --- a/test/py/tests/test_efi_loader.py
> +++ b/test/py/tests/test_efi_loader.py
> @@ -148,7 +148,7 @@ def fetch_tftp_file(u_boot_console, env_conf):
>       return addr
>
>   @pytest.mark.buildconfigspec('of_control')
> -@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> +@pytest.mark.buildconfigspec('BOOTEFI_HELLO_COMPILE')
>   def test_efi_helloworld_net(u_boot_console):
>       """Run the helloworld.efi binary via TFTP.
>

