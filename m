Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B85C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 20:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F5887253;
	Tue, 21 Nov 2023 21:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S5E+Gyv9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB9C87253; Tue, 21 Nov 2023 21:50:52 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C4F870F4
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:50:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50aab3bf71fso4155914e87.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700599849; x=1701204649; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I0/ECv5Yx+I26A4h3mRW4dTELvt6xjgOh2UnqCesQxc=;
 b=S5E+Gyv9to6qHLCh9jwk/4vqHsm9EqvNvr0Q9QloQTY9SUEbO7XRw7jRKceI6ir2xL
 VTmIBKpt5UNCxFZWCtBxOCqX/Euzpwchfs2PsRMZPKQs9j2qDvtzAxyzuaa4md/KeSss
 apE2L1onHhIbuSskbgh3ELHUai6NGCnlfH6QKIrqqmb/sh+2o7ZrQ/inv0IpowgUcXu9
 y3lUrKB06btLNgBQgG78CW+ScFFzEghUiI16tqIJf2e/czPTjO4Q3LE9JsjXEof0XnYX
 YcnyU9Iwr1ApIB6lcNBBGQcjYeqRjM9Vae0omrHscS9AgdMic0mvOLwmIAsXFlJE95SO
 RYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700599849; x=1701204649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I0/ECv5Yx+I26A4h3mRW4dTELvt6xjgOh2UnqCesQxc=;
 b=o9cZ+FaAIHH19LdbM/UxdvANxY2I6CoMR1KN3Ep+6uZdbqCOsfkBdtY1cK+6KImHY+
 vFqSd8kR+s8XE/uztahH8Bc7WVR1x01YMdtxNShrGrHbrKc65EnjYtrQL+MRIimYqTgp
 Rcc4scH6ajvBdYAel0/9BNJ++GV75xqN0heoCvZ24XZzDTzLxwJBmBFYLEpMW1UWLowl
 m0guGwVS3pfZL/F5QUWUbwFg59/vPmfq+W1OvBA+zy5HmfWlnMxflEx86xML43WM1YSc
 TI2lxGPp8X3jAGgoJX8MH99DI4vgHs4+Btl5s8s0M0Vp3GCzemuVjrdbwwDFFwOfcpF1
 /Uhg==
X-Gm-Message-State: AOJu0Yyl0ut/alyu9/VaZsrWm9HcRkx/UQcqKwTfvfREOOrcYi8GW+Og
 u63LV0lS+M0fWSPlLkDDjjN6SpEcFvWMgXRedCn/0g==
X-Google-Smtp-Source: AGHT+IGKkLCLip/xZ2BLDonuHQJKshH9clFrLSmlLM032SnaVO4uNDUWSC1Jbyr4R9iU2Vg8FKTZqxuxOwlS+PenBE4=
X-Received: by 2002:a19:8c14:0:b0:507:9ae6:6913 with SMTP id
 o20-20020a198c14000000b005079ae66913mr243631lfd.28.1700599848872; Tue, 21 Nov
 2023 12:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20231121025818.741258-1-sjg@chromium.org>
In-Reply-To: <20231121025818.741258-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 Nov 2023 22:50:12 +0200
Message-ID: <CAC_iWjK-N9_uq1W=c_rrJ4wdQ0aqLEAXeu84XDN_petXQYY7=w@mail.gmail.com>
Subject: Re: [PATCH v3] smbios: arm64: Ensure table is written at a good
 address
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
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

On Tue, 21 Nov 2023 at 04:58, Simon Glass <sjg@chromium.org> wrote:
>
> U-Boot typically sets up its malloc() pool near the top of memory. On
> ARM64 systems this can result in an SMBIOS table above 4GB which is
> not supported by SMBIOSv2.
>
> Work around this problem by automatically choosing an address below 4GB
> (but as high as possible), if needed.
>
> Tell efi_loader about the address in the same way as we do for ACPI
> tables.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> Please see previous discussion here:
>
>   https://patchwork.ozlabs.org/project/uboot/patch/
>   20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid/
>
> Changes in v3:
> - Add RISC-V to the condition, too
> - Update the commit message
>
> Changes in v2:
> - Update to search for a suitable area automatically, if enabled
>
>  lib/Kconfig                 | 13 ++++++++
>  lib/efi_loader/efi_smbios.c | 63 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 75 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 19649517a39b..c70faeeebed5 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -998,6 +998,19 @@ config GENERATE_SMBIOS_TABLE
>           See also SMBIOS_SYSINFO which allows SMBIOS values to be provided in
>           the devicetree.
>
> +config SMBIOS_TABLE_FIXED
> +       bool "Place the SMBIOS table at a special address"
> +       depends on GENERATE_SMBIOS_TABLE && SMBIOS && EFI_LOADER
> +       depends on ARM64 || RISCV
> +       default y
> +       help
> +         Use this option to place the SMBIOS table at a special address.
> +
> +         U-Boot typically sets up its malloc() pool near the top of memory. On
> +         ARM64 systems this can result in an SMBIOS table above 4GB which is
> +         not supported by SMBIOSv2. This option works around this problem by
> +         chosing an address just below 4GB, if needed.
> +
>  endmenu
>
>  config LIB_RATIONAL
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index 48446f654d9b..566f206af5b6 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -47,6 +47,60 @@ efi_status_t efi_smbios_register(void)
>                                                map_sysmem(addr, 0));
>  }
>
> +/**
> + * find_addr_below() - Find a usable region below the given max_addr
> + *
> + * Check if *addrp is suitable to define a memory region which finishes below
> + * @max_addr + @req_size. If so, do nothing and return 0
> + *
> + * As a backup, if CONFIG_SMBIOS_TABLE_FIXED is enabled, search for a
> + * 4KB-aligned DRAM region which is large enough. Make sure it is below U-Boot's
> + * stack space, assumed to be 64KB.
> + *
> + * @max_addr: Maximum address that can be used (region must finish before here)
> + * @req:size: Required size of region
> + * @addrp: On entry: Current proposed address; on exit, holds the new address,
> + *     on success
> + * Return 0 if OK (existing region was OK, or a new one was found), -ENOSPC if
> + * nothing suitable was found
> + */
> +static int find_addr_below(ulong max_addr, ulong req_size, ulong *addrp)
> +{
> +       struct bd_info *bd = gd->bd;
> +       ulong max_base;
> +       int i;
> +
> +       max_base = max_addr - req_size;
> +       if (*addrp <= max_base)
> +               return 0;
> +
> +       if (!IS_ENABLED(CONFIG_SMBIOS_TABLE_FIXED))
> +               return -ENOSPC;
> +
> +       /* Make sure that the base is at least 64KB below the stack */
> +       max_base = min(max_base,
> +                      ALIGN(gd->start_addr_sp - SZ_64K - req_size, SZ_4K));
> +
> +       for (i = CONFIG_NR_DRAM_BANKS - 1; i >= 0; i--) {
> +               ulong start = bd->bi_dram[i].start;
> +               ulong size = bd->bi_dram[i].size;
> +               ulong addr;
> +
> +               /* chose an address at most req_size bytes before the end */
> +               addr = min(max_base, start - req_size + size);
> +
> +               /* check this is in the range */
> +               if (addr >= start && addr + req_size < start + size) {
> +                       *addrp = addr;
> +                       log_warning("Forcing SMBIOS table to address %lx\n",
> +                                   addr);
> +                       return 0;
> +               }
> +       }
> +
> +       return -ENOSPC;
> +}

This function doesn't really belong here. We should move it to the mem
subsystem.
AFAICT this is a hotfix for 2024.01. So I prefer picking this [0]
instead, since the smbios table generation is still controlled by EFI

[0] https://lore.kernel.org/u-boot/20231120222558.32014-1-heinrich.schuchardt@canonical.com/

Thanks
/Ilias
> +
>  static int install_smbios_table(void)
>  {
>         ulong addr;
> @@ -61,7 +115,14 @@ static int install_smbios_table(void)
>                 return log_msg_ret("mem", -ENOMEM);
>
>         addr = map_to_sysmem(buf);
> -       if (!write_smbios_table(addr)) {
> +
> +       /*
> +        * Deal with a fixed address if needed. For simplicity we assume that
> +        * the SMBIOS-table size is <64KB. If a suitable address cannot be
> +        * found, then write_smbios_table() returns an error.
> +        */
> +       if (find_addr_below(SZ_4G - 1, SZ_64K, &addr) ||
> +           !write_smbios_table(addr)) {
>                 log_err("Failed to write SMBIOS table\n");
>                 return log_msg_ret("smbios", -EINVAL);
>         }
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
