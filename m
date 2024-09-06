Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0467ACE7AFD
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 10:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73578888A7;
	Fri,  6 Sep 2024 12:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AM49T+j5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57DCA88CC9; Fri,  6 Sep 2024 12:15:55 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 540FF888A7
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 12:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c26311c6f0so2355791a12.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725617753; x=1726222553; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZoBAg0D8LWJ4TZjDJccsl4+GEn88ZXAzV6kfLctJk88=;
 b=AM49T+j5MwoSPU9cAkRzsI5a4JBfE7es34V3vih1HWEAPF8KpbziTsCVUz2jVjge1J
 +DJUtRbbuvrwtQ6hUnmq6RvGsD2YV/MdiGac6PVis0mP4xp2maJzJulcwSsfaypexeJ0
 9ym9Ng1IINlPF49XNWzNz5cDWgX/gRuwANw8pTB+MT54YdNIeNEpWIi3ggfp+lEm20l8
 radGX9uxdi2zy3wrnKkVoVdF71cCTOK1Fo/9JFOIxI/CJCdkK4SZvfSjPh5+YQDxBmxN
 Z98QXLbGUV2gOL75qK1CshjF7e4j24oYeVN+Q7snIi6XdJXL3SdB8UEsmL36zyaiLfdQ
 tAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725617753; x=1726222553;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoBAg0D8LWJ4TZjDJccsl4+GEn88ZXAzV6kfLctJk88=;
 b=wEw/P8ND0dzMzLi2XbAVoHvW/G73DemlO8wQiqy2vcsIACpQVHoBHE7WUW9b/YFTfw
 MZ1SNdoboWVygCyNkv5efeqLFFCe4XMfBTGv/PFIExBQtBx3yTtxf2Rz3rJgj7xGT8d0
 RnUQykBkvpuxz70TG8lVtCJr+sKgzaKVVV5/Uf6QWUtKnDhN7r29upPKc0XUwhAsrxdo
 KdGppySf6FzmIbLivZnOAXFrbn4qiFGQJyqEEBYKm/eeB9dpaXn5xqd2RdMbk4qkAW8o
 HbUkuOhI5UIU5YM/qCmzI+PuGTWxkCP9CdnVyGxAmDiZV4QydfvBc+UfxLKet0ug/X8z
 B+5g==
X-Gm-Message-State: AOJu0YyvN0oxoi2iToMMRoR+Bd3JwngxJl9MV8ytSjUMBIANYZOnzNWH
 gWiAtDHvklDUK/oL3qLn5vDXR8GhEmImFFhcbnbjZUJhZy4T/JvtvgGyF68mPU8=
X-Google-Smtp-Source: AGHT+IHnhmt9XgRFvvLDJfWAHn470ulOZmYzAVC4K7ZtLqW3lPTmcUrV3aChXqhiCHsok8hMFMiJdw==
X-Received: by 2002:a17:907:72d1:b0:a89:ffd0:3637 with SMTP id
 a640c23a62f3a-a8a88870f17mr165642566b.61.1725617752036; 
 Fri, 06 Sep 2024 03:15:52 -0700 (PDT)
Received: from hera (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a61fbb093sm259372266b.11.2024.09.06.03.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 03:15:51 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:15:48 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, bmeng.cn@gmail.com,
 trini@konsulko.com, sr@denx.de, pbrobinson@gmail.com,
 mbrugger@suse.com, maximilian.brune@9elements.com
Subject: Re: [PATCH v2 14/28] efi_loader: Install ACPI tables
Message-ID: <ZtrWVOdnu0Py7KRs@hera>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
 <20240906072231.2531491-15-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906072231.2531491-15-patrick.rudolph@9elements.com>
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

Hi Patrick,

On Fri, Sep 06, 2024 at 09:22:16AM +0200, Patrick Rudolph wrote:
> Install ACPI tables inside the efi_loader similar to SMBIOS tables.
> When ACPI is enabled and wasn't installed in other places, install
> the ACPI table in EFI. Since EFI is necessary to pass the ACPI
> table location when FDT isn't used, there's no need to install it
> separately.
>
> When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
> bloblist.
>
> TEST: Booted QEMU SBSA using EFI and ACPI only.
>

Why none of the EFI maintainers were CC'ed into that?

> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  lib/efi_loader/efi_acpi.c        | 57 ++++++++++++++++++++++++++++++--
>  test/py/tests/test_event_dump.py |  1 +
>  2 files changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index 67bd7f8ca2..9262f21ea6 100644
> --- a/lib/efi_loader/efi_acpi.c
> +++ b/lib/efi_loader/efi_acpi.c
> @@ -6,15 +6,23 @@
>   */
>
>  #include <efi_loader.h>
> -#include <log.h>
> -#include <mapmem.h>
>  #include <acpi/acpi_table.h>
>  #include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <bloblist.h>
> +#include <linux/sizes.h>
> +#include <linux/log2.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <mapmem.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
>  static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
>
> +enum {
> +	TABLE_SIZE	= SZ_64K,
> +};
>  /*
>   * Install the ACPI table as a configuration table.
>   *
> @@ -47,3 +55,48 @@ efi_status_t efi_acpi_register(void)
>  	return efi_install_configuration_table(&acpi_guid,
>  					       (void *)(ulong)addr);
>  }
> +
> +static int install_acpi_table(void)

This function doesn't install anything.  efi_acpi_register()
nstalls the config tables for ACPI. This is just preparing and setting up
correctly table_start_high/table_end_high AFAICT

> +{
> +	u64 rom_addr, rom_table_end;
> +	void *addr;
> +
> +	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE) ||
> +	    IS_ENABLED(CONFIG_X86) ||
> +	    IS_ENABLED(CONFIG_QFW_ACPI))
> +		return 0;
> +
> +	/* Align the table to a 4KB boundary to keep EFI happy */
> +	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> +		addr = bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
> +				    ilog2(SZ_4K));
> +	else
> +		addr = memalign(SZ_4K, TABLE_SIZE);

The alignment is already taken care of in efi_acpi_register(). Also an

> +
> +	if (!addr)
> +		return log_msg_ret("mem", -ENOBUFS);
> +
> +	rom_addr = virt_to_phys(addr);
> +
> +	gd->arch.table_start_high = rom_addr;
> +
> +	rom_table_end = write_acpi_tables(rom_addr);
> +	if (!rom_table_end) {
> +		log_err("Can't create ACPI configuration table\n");
> +		return -EINTR;
> +	}
> +
> +	debug("- wrote 'acpi' to %llx, end %llx\n", rom_addr, rom_table_end);
> +	if (rom_table_end - rom_addr > TABLE_SIZE) {
> +		log_err("Out of space for configuration tables: need %llx, have %x\n",
> +			rom_table_end - rom_addr, TABLE_SIZE);
> +		return log_msg_ret("acpi", -ENOSPC);
> +	}
> +	gd->arch.table_end_high = rom_table_end;
> +
> +	debug("- done writing tables\n");
> +
> +	return 0;
> +}
> +
> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_acpi_table);

Why is this an event and how do you make sure it runs before
efi_acpi_register()?. This should just run explicitly before that to prepare
the ACPI tables and if it fails we shouldn't even try to install the config
table

/Ilias
> diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
> index e282c67335..88bbf34f71 100644
> --- a/test/py/tests/test_event_dump.py
> +++ b/test/py/tests/test_event_dump.py
> @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
>  --------------------  ------------------------------  ------------------------------
>  EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
>  EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
> +EVT_LAST_STAGE_INIT   install_acpi_table              .*lib/efi_loader/efi_acpi.c:.*
>  EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
>  EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
>  EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
> --
> 2.45.2
>
