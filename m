Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF5710A3D78
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2223883FA3;
	Thu, 26 Mar 2026 12:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qdc7EIPz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 528B383FC6; Thu, 26 Mar 2026 12:58:15 +0100 (CET)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8A0E83E76
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ae222d978so929454d50.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:58:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774526290; cv=none;
 d=google.com; s=arc-20240605;
 b=JpBqo2O/wHLT5/XxmMJfWb0OHPegokQjOmi526D5g6nEtCOTqtByhuEnq35UdO5Lo9
 67SV/beFID7gffVVFJv7W5brDAb0h0nrqbbwCdmu3T5vBfJlX4HwuRr99e8ersNz9Qb8
 aF2T98wPEhqbwFJ3xFD6+wHAWnE7IG+ncAmjpbYr/BDdO+1rQ9axnyYZql1lPg9YSsfA
 fNiRq1tJFWt/517JFV48fSiMFNDyrbZY8i6nLZnVSiXqNYolDI1A+4+f8UhdttOW3KWa
 osPpJ+JrP9wwaWurrs2rGtJgxe/bSGROPthw44jg/HK/HtXTOByUReO5mZn/YkMl7Fcv
 5KTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cyUR2SLvMzR2qiFSmy4GQYdt3rM4QWN1bAqyzbE2uR4=;
 fh=TTftz3sP+CYSrQjSVFQafD6TiMF5UIi9AxXolSmGrak=;
 b=PCIT9xW92KO5vAGH1Ei+WONW3HC7WLW76NZa3Z1FWMr0sHzm2KNv65gGW6D2ql/eUS
 hrchRFL1ZzpvZrZYdn0koUIU0A+p0e3W2lqdkWDnpKhcVNRlnG44p4FKk6CRCyuHZE3T
 jivYN+i67+//SrrvGahAojAFJouKQTOfUtNB6q2NwYXj+Zx1FCWuoQUd2aRYmAXUJEgA
 pGajN4JAF1nIcU6F3PAEOMJAUdxmCwAIBsq9MOkoKbhM/fG9IuGBBK4wZ5AobYUGu7BL
 BfNP6+S7PHPNu/Lo18sxDdSO8nV8qIWqXOIyc1426CoGi1yAMOXvmC5J4ovw6FEzeYlt
 ju+Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774526290; x=1775131090; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cyUR2SLvMzR2qiFSmy4GQYdt3rM4QWN1bAqyzbE2uR4=;
 b=Qdc7EIPzUGntkZIlwQJTghRS9W31iszJ7PYVgZCflRtEY+AKagjPD16djJIkWyESff
 dywsPljDKgxrMf1fN2DO8BQBitE0sbXkfLWRwc3As/2FxDEreZ04QqFMERbHrtRkxLuM
 CkBsD2YIqojglTmLSrmQ1yMbEUxTba7U0SRFllqH7CwaYUiXiikLe0ax6KwTMlOHZbl3
 6pAH/C/5+nukZ1fxqNod4u3PewuAw096UyK9x+kJFMZrIKHqkjQW75MwyfnQkOjphc1+
 B0gfIZUHf40uerNWPOR0pCk+N4s5Sy5HS64yOwMjfjMfH9cpnZRmSiTgADw5d7OFjkzp
 Qxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774526290; x=1775131090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyUR2SLvMzR2qiFSmy4GQYdt3rM4QWN1bAqyzbE2uR4=;
 b=ONBF/ZrUvOnAE4rN9oQbJ+lIDD/Xigu4P8xAan6vw50Zd1rVCkH68g998hPlw4dA7s
 KbPAxS1o4EUcX+nrCH99TXtuAptxfDBzTBg2Lrrbhox5bxa8GVun9aK/mxeRuQ3nW+jQ
 jzKLhfYYmSXtafcIVLFUWM7aBgzpoueve4F5xC76zLOWL5y5MrFs2Ri0I9yABIZe1WC8
 vk0YJ5hGk9TaNMXltKVyYnYckw1bBb6Y6S3Al7XZGUHoaWqfyK5MdophxseFfxRDT7gX
 ocMwY3/y9qjnfgSrDi8UfQuisU0o+osR/EvbMGGOL6DzpvrAHmOqTG+O5+M708LhOvRX
 RU6w==
X-Gm-Message-State: AOJu0Yyztz9qm/9B0c/F+JQnTtb1QniKQD1pE/FPl52B6e2+bViYCMi+
 iYbVM9fv0VfdMKI9FLEB+8osee+/Q6Mzf/uwVvPXlBGUXaaXycCxQ/gHORtroB9gBAbHmHTnK9H
 NuXj3rL8dpHAvqvpqyrEJdGQchwFlVFmv156Emagqbw==
X-Gm-Gg: ATEYQzxnhfmwm4EGscZ/JXCG/Y439WRSR+G/cvTeu+aqfUz5It2+4kPRrbeIaZNMHgb
 DIK6DbbL4wCupPsSqaEQK/6NPSM1Lcj7bwpuzyR69XnP3F1m6V9vjSqxH2M1Ssjmtu+iQg4/idu
 0lvzycUW0DzqtYBZhQeeauv4QTHmxdwJjpI+4BlIh8cHM0TSuv6Sv+Q4bUNckKjqS14QOqSmZ7w
 1DiRE5PCWquymFZxhMf2oEruvkHO5aMr+ABjyT796GS3RZ/nShTRrRuoeRYQ6YWMSmxhY3VMctT
 eAplpiAdr+P+kvKguKokIsL/A0BXxd5i8tLNxBoNXafP9/PetkSDK/qOF8Vd5Vf9tLjMPMLGfg4
 q+4k/KiLgMofW/PI7NmARHTnCkD8cL15oALg5q3BXmgdxPyM8qQ/guKhwpuR8BgvUl+M2omAkCZ
 tXufX81vVJtzWVDwfxbrBnTygzN+GL4gRSL4HdmBsxlieFpgJz6biFXs1ToammhTAF4ThF0gbrv
 ZaLqT9Nb1nZO7PgaZ/lUxxd5S8nSQGS+uBywowPlvuj+ZNleVgfY9HTcgKQJjjd8GDQ74a79gxV
 VfuchJXDtUFBRJTeEERYyOfxqVt5Ix/+avSdR0dW5rK9
X-Received: by 2002:a05:690e:43ce:b0:64c:ed24:13d8 with SMTP id
 956f58d0204a3-64ee613cd37mr5372734d50.48.1774526290369; Thu, 26 Mar 2026
 04:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260326115500.955388-1-sjg@chromium.org>
In-Reply-To: <20260326115500.955388-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Mar 2026 13:57:33 +0200
X-Gm-Features: AaiRm50az1itpUOi-BPH31gwDw3szRfa2q9r1NAm-pUMomKzAR2_oNwdxnZzPA4
Message-ID: <CAC_iWjKZwoxAxeXpPPw7wpNuj8SDTjNOc1S4AcGYWSKW8ox2GQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: Move U-Boot .incbin rules to
 Makefile.lib-u-boot
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Greg Malysa <malysagreg@gmail.com>, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Edwards <cfsworks@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tien Fong Chee <tien.fong.chee@altera.com>
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

On Thu, 26 Mar 2026 at 13:55, Simon Glass <sjg@chromium.org> wrote:
>
> The font, splash-screen and EFI .incbin wrapper rules are U-Boot
> additions that do not exist in the upstream Linux kbuild. Keeping them
> in scripts/Makefile.lib makes re-syncing with Linux harder than it needs
> to be, as every sync must manually preserve the U-Boot additions.
>
> Move these rules into a new scripts/Makefile.lib-u-boot and include it
> from Makefile.build and Makefile.xpl, right after the existing
> Makefile.lib include.
>
> This is a pure code-move with no functional change.
>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Changes in v2:
> - Split out of the relative-path patch as requested by Tom Rini
>
>  scripts/Makefile.build      |  1 +
>  scripts/Makefile.lib        | 94 ------------------------------------
>  scripts/Makefile.lib-u-boot | 96 +++++++++++++++++++++++++++++++++++++
>  scripts/Makefile.xpl        |  1 +
>  4 files changed, 98 insertions(+), 94 deletions(-)
>  create mode 100644 scripts/Makefile.lib-u-boot
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 8da9851d430..e625f99986e 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -65,6 +65,7 @@ ccflags-y  += $(PLATFORM_CPPFLAGS)
>  cppflags-y += $(PLATFORM_CPPFLAGS)
>
>  include $(srctree)/scripts/Makefile.lib
> +include $(srctree)/scripts/Makefile.lib-u-boot
>
>  # Do not include hostprogs rules unless needed.
>  # $(sort ...) is used here to remove duplicated words and excessive spaces.
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 7386353e0cc..b8969b7de54 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -508,100 +508,6 @@ $(multi-dtb-y): FORCE
>         $(call if_changed,fdtoverlay)
>  $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
>
> -# Fonts
> -# ---------------------------------------------------------------------------
> -
> -# Generate an assembly file to wrap the font data
> -quiet_cmd_S_ttf= TTF     $@
> -# Modified for U-Boot
> -cmd_S_ttf=                                             \
> -(                                                      \
> -       echo '.section .rodata.ttf.init,"a"';           \
> -       echo '.balign 16';                              \
> -       echo '.global __ttf_$(*F)_begin';               \
> -       echo '__ttf_$(*F)_begin:';                      \
> -       echo '.incbin "$<" ';                           \
> -       echo '__ttf_$(*F)_end:';                        \
> -       echo '.global __ttf_$(*F)_end';                 \
> -       echo '.balign 16';                              \
> -) > $@
> -
> -$(obj)/%.S: $(src)/%.ttf
> -       $(call cmd,S_ttf)
> -
> -# Splash logos
> -# ---------------------------------------------------------------------------
> -
> -# Generate an assembly file to wrap the splash data
> -quiet_cmd_S_splash= TTF     $@
> -# Modified for U-Boot
> -cmd_S_splash=                                          \
> -(                                                      \
> -       echo '.section .rodata.splash.init,"a"';                \
> -       echo '.balign 16';                              \
> -       echo '.global __splash_$(*F)_begin';            \
> -       echo '__splash_$(*F)_begin:';                   \
> -       echo '.incbin "$<" ';                           \
> -       echo '__splash_$(*F)_end:';                     \
> -       echo '.global __splash_$(*F)_end';                      \
> -       echo '.balign 16';                              \
> -) > $@
> -
> -$(obj)/%.S: $(src)/%.bmp
> -       $(call cmd,S_splash)
> -
> -# EFI applications
> -# A Makefile target *.efi is built as EFI application.
> -# A Makefile target *_efi.S wraps *.efi as built-in EFI application.
> -# ---------------------------------------------------------------------------
> -
> -# Generate an assembly file to wrap the EFI app
> -cmd_S_efi=                                     \
> -(                                              \
> -       echo '.section .rodata.$*.init,"a"';    \
> -       echo '.balign 16';                      \
> -       echo '.global __efi_$*_begin';          \
> -       echo '__efi_$*_begin:';                 \
> -       echo '.incbin "$<" ';                   \
> -       echo '__efi_$*_end:';                   \
> -       echo '.global __efi_$*_end';            \
> -       echo '.balign 16';                      \
> -) > $@
> -
> -$(obj)/%_efi.S: $(obj)/%.efi
> -       $(call cmd,S_efi)
> -
> -quiet_cmd_efi_objcopy = OBJCOPY $@
> -cmd_efi_objcopy = $(OBJCOPY) -j .header -j .text -j .sdata -j .data \
> -               -j .dynamic -j .dynstr  -j .dynsym -j .rel* -j .reloc \
> -               $(if $(EFI_TARGET),$(EFI_TARGET),-O binary) $^ $@
> -
> -$(obj)/%.efi: $(obj)/%_efi.so
> -       $(call cmd,efi_objcopy)
> -
> -KBUILD_EFILDFLAGS = -nostdlib -zexecstack -znocombreloc -znorelro
> -KBUILD_EFILDFLAGS += $(call ld-option,--no-warn-rwx-segments)
> -quiet_cmd_efi_ld = LD      $@
> -cmd_efi_ld = $(LD) $(KBUILD_EFILDFLAGS) -L $(srctree) -T $(EFI_LDS_PATH) \
> -               -shared -Bsymbolic -s $^ $(PLATFORM_LIBGCC) -o $@
> -
> -EFI_LDS_PATH = arch/$(ARCH)/lib/$(EFI_LDS)
> -
> -$(obj)/efi_crt0.o: $(srctree)/arch/$(ARCH)/lib/$(EFI_CRT0:.o=.S) FORCE
> -       $(call if_changed_dep,as_o_S)
> -
> -$(obj)/efi_reloc.o: $(srctree)/arch/$(ARCH)/lib/$(EFI_RELOC:.o=.c) $(recordmcount_source) FORCE
> -       $(call cmd,force_checksrc)
> -       $(call if_changed_rule,cc_o_c)
> -
> -$(obj)/%_efi.so: $(obj)/%.o $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_freestanding.o
> -       $(call cmd,efi_ld)
> -
> -targets += $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_freestanding.o
> -
> -CFLAGS_REMOVE_efi_reloc.o := $(LTO_CFLAGS)
> -CFLAGS_REMOVE_efi_freestanding.o := $(LTO_CFLAGS)
> -
>  # ACPI
>  # ---------------------------------------------------------------------------
>  #
> diff --git a/scripts/Makefile.lib-u-boot b/scripts/Makefile.lib-u-boot
> new file mode 100644
> index 00000000000..c55f8d8e0c3
> --- /dev/null
> +++ b/scripts/Makefile.lib-u-boot
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# U-Boot-specific rules for embedding binary data via .incbin
> +# These are split out of Makefile.lib to simplify kbuild re-syncs.
> +
> +# Fonts
> +# ---------------------------------------------------------------------------
> +
> +# Generate an assembly file to wrap the font data
> +quiet_cmd_S_ttf= TTF     $@
> +cmd_S_ttf=                                             \
> +(                                                      \
> +       echo '.section .rodata.ttf.init,"a"';           \
> +       echo '.balign 16';                              \
> +       echo '.global __ttf_$(*F)_begin';               \
> +       echo '__ttf_$(*F)_begin:';                      \
> +       echo '.incbin "$<" ';                           \
> +       echo '__ttf_$(*F)_end:';                        \
> +       echo '.global __ttf_$(*F)_end';                 \
> +       echo '.balign 16';                              \
> +) > $@
> +
> +$(obj)/%.S: $(src)/%.ttf
> +       $(call cmd,S_ttf)
> +
> +# Splash logos
> +# ---------------------------------------------------------------------------
> +
> +# Generate an assembly file to wrap the splash data
> +quiet_cmd_S_splash= TTF     $@
> +cmd_S_splash=                                          \
> +(                                                      \
> +       echo '.section .rodata.splash.init,"a"';        \
> +       echo '.balign 16';                              \
> +       echo '.global __splash_$(*F)_begin';            \
> +       echo '__splash_$(*F)_begin:';                   \
> +       echo '.incbin "$<" ';                           \
> +       echo '__splash_$(*F)_end:';                     \
> +       echo '.global __splash_$(*F)_end';              \
> +       echo '.balign 16';                              \
> +) > $@
> +
> +$(obj)/%.S: $(src)/%.bmp
> +       $(call cmd,S_splash)
> +
> +# EFI applications
> +# A Makefile target *.efi is built as EFI application.
> +# A Makefile target *_efi.S wraps *.efi as built-in EFI application.
> +# ---------------------------------------------------------------------------
> +
> +# Generate an assembly file to wrap the EFI app
> +cmd_S_efi=                                     \
> +(                                              \
> +       echo '.section .rodata.$*.init,"a"';    \
> +       echo '.balign 16';                      \
> +       echo '.global __efi_$*_begin';          \
> +       echo '__efi_$*_begin:';                 \
> +       echo '.incbin "$<" ';                   \
> +       echo '__efi_$*_end:';                   \
> +       echo '.global __efi_$*_end';            \
> +       echo '.balign 16';                      \
> +) > $@
> +
> +$(obj)/%_efi.S: $(obj)/%.efi
> +       $(call cmd,S_efi)
> +
> +quiet_cmd_efi_objcopy = OBJCOPY $@
> +cmd_efi_objcopy = $(OBJCOPY) -j .header -j .text -j .sdata -j .data \
> +               -j .dynamic -j .dynstr  -j .dynsym -j .rel* -j .reloc \
> +               $(if $(EFI_TARGET),$(EFI_TARGET),-O binary) $^ $@
> +
> +$(obj)/%.efi: $(obj)/%_efi.so
> +       $(call cmd,efi_objcopy)
> +
> +KBUILD_EFILDFLAGS = -nostdlib -zexecstack -znocombreloc -znorelro
> +KBUILD_EFILDFLAGS += $(call ld-option,--no-warn-rwx-segments)
> +quiet_cmd_efi_ld = LD      $@
> +cmd_efi_ld = $(LD) $(KBUILD_EFILDFLAGS) -L $(srctree) -T $(EFI_LDS_PATH) \
> +               -shared -Bsymbolic -s $^ $(PLATFORM_LIBGCC) -o $@
> +
> +EFI_LDS_PATH = arch/$(ARCH)/lib/$(EFI_LDS)
> +
> +$(obj)/efi_crt0.o: $(srctree)/arch/$(ARCH)/lib/$(EFI_CRT0:.o=.S) FORCE
> +       $(call if_changed_dep,as_o_S)
> +
> +$(obj)/efi_reloc.o: $(srctree)/arch/$(ARCH)/lib/$(EFI_RELOC:.o=.c) $(recordmcount_source) FORCE
> +       $(call cmd,force_checksrc)
> +       $(call if_changed_rule,cc_o_c)
> +
> +$(obj)/%_efi.so: $(obj)/%.o $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_freestanding.o
> +       $(call cmd,efi_ld)
> +
> +targets += $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_freestanding.o
> +
> +CFLAGS_REMOVE_efi_reloc.o := $(LTO_CFLAGS)
> +CFLAGS_REMOVE_efi_freestanding.o := $(LTO_CFLAGS)
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index c5ddf64c73f..862a8e6f231 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -88,6 +88,7 @@ include $(srctree)/config.mk
>  include $(srctree)/arch/$(ARCH)/Makefile
>
>  include $(srctree)/scripts/Makefile.lib
> +include $(srctree)/scripts/Makefile.lib-u-boot
>
>  # Enable garbage collection of un-used sections for SPL
>  KBUILD_CFLAGS += -ffunction-sections -fdata-sections
> --
> 2.43.0
>
> base-commit: 1ffc541eafc96d5eebcf837ab892dccec3b93568
> branch: font-us2
