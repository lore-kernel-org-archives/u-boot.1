Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC97C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 11:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F16D287988;
	Wed, 27 Dec 2023 12:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pDE5u/ZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B44F8798B; Wed, 27 Dec 2023 12:05:49 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E1318795F
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 12:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e81761e43so1405056e87.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 03:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703675146; x=1704279946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ONl5B9I/NTVa4mCYYEgPnOqCsr3sKu2E1rxeslr6G70=;
 b=pDE5u/ZP5rypE9ET5LUndg96F89yO+XLDiG1RL3OUbRRlP0Yb3dV4EfqYGiitwCxTd
 t8a2U0c9gHKJmYj5RXsmGNR7OqR00gWByQDdWnDTdBiEyGyCWU864A1btsRKeritndQV
 KFTrstb9vCdfMVllFSuMchHkS8ggUutlSTlZY/pIBvGdbPPWcp0UmP/jpQ03tdkT3Btj
 GnK7kg1gx7mJU6e1q23PIema4ekM9/UgGdSLEONDkh9WIvixkcWIctUosYTon5jFfEz+
 mbU9y3iXkS33vN1I96H/lHsYCxSeRhHsRA7DaLJ4YNt8QzHyGfgQQPDiao/UExRnouFp
 un6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703675146; x=1704279946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ONl5B9I/NTVa4mCYYEgPnOqCsr3sKu2E1rxeslr6G70=;
 b=WaReEeCugycm+Ah5kNa+Q9PZf0dPCimrWkgJFFMlca+ZDI5Llh1V/3N+lz6cNxZ12g
 2CjCPfTwCAQ2Blw51Z/3ltOlX/VhuzBEIZuFT86qlglorrbEy3GLULF+7nkVHU0JPZkB
 8myHmmHqF+aCMxVIwY4/BzI+/B7bVGSLQO0LgGEYvsWlDx1sO8862qFElzddRyatpESL
 Y1dINjp0XVIwHquPYPZZvcv76bKN5EKsuT4SO0JKAVlkRvkVq+TZE/PKodGIBxG9obKM
 T5rhnThw3qBpOSpnvxjZhhho5ucIKpJNOJyoXF4WmCStB0AxVFNm7Z1HVHYdefdUUp+B
 JLEQ==
X-Gm-Message-State: AOJu0YzwQc3rgjeWMBcckSp5GSxyn3xVCyx63OHsxSPQrCO+eyYepfE1
 8TWSPQOqdAsh74x4qNx7VKE5vSEekI7IIZN3etf2iBthGKwXLw==
X-Google-Smtp-Source: AGHT+IETMlT5yT0lRj/NudQWaIqjjcoPulJEm6h/gY8c5ccvHoZ2w46Lvihw6UqXfQ6W7jdsWvPEDW7g1gISjaGbhls=
X-Received: by 2002:a05:6512:419:b0:50e:2f29:4794 with SMTP id
 u25-20020a056512041900b0050e2f294794mr3106321lfk.86.1703675146391; Wed, 27
 Dec 2023 03:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-5-sjg@chromium.org>
In-Reply-To: <20231227074025.2178825-5-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 13:05:10 +0200
Message-ID: <CAC_iWj+yGhUVFh+vJ14C2htibdd289SrPjz0Y_r3GL4uF4Zdog@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] smbios: Use SMBIOS 3.0 to support an address above
 4GB
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Peter Robinson <pbrobinson@gmail.com>
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

On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
>
> When the SMBIOS table is written to an address above 4GB a 32-bit table
> address is not large enough.
>
> Use an SMBIOS3 table in that case.

Maybe I missed this on the previous revisions, but is there a reason
we don't always use SMBIOS3 now? And perhaps try to install SMBIOS2 if
1. we fail
2. and the address is < 4GB

Thanks
/Ilias
>
> Note that we cannot use efi_allocate_pages() since this function has
> nothing to do with EFI. There is no equivalent function to allocate
> memory below 4GB in U-Boot. One solution would be to create a separate
> malloc() pool, or just always put the malloc() pool below 4GB.
>
> - Use log_debug() for warning
> - Rebase on Heinrich's smbios.h patch
> - Set the checksum for SMBIOS3
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v4:
> - Check the start of the table rather than the end
>
> Changes in v2:
> - Check the end of the table rather than the start.
>
>  include/smbios.h |  6 +++++-
>  lib/smbios.c     | 30 +++++++++++++++++++++++++-----
>  2 files changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/include/smbios.h b/include/smbios.h
> index e601283d293..77be58887a2 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -12,7 +12,7 @@
>
>  /* SMBIOS spec version implemented */
>  #define SMBIOS_MAJOR_VER       3
> -#define SMBIOS_MINOR_VER       0
> +#define SMBIOS_MINOR_VER       7
>
>  enum {
>         SMBIOS_STR_MAX  = 64,   /* Maximum length allowed for a string */
> @@ -80,6 +80,10 @@ struct __packed smbios3_entry {
>         u64 struct_table_address;
>  };
>
> +/* These two structures should use the same amount of 16-byte-aligned space */
> +static_assert(ALIGN(16, sizeof(struct smbios_entry)) ==
> +             ALIGN(16, sizeof(struct smbios3_entry)));
> +
>  /* BIOS characteristics */
>  #define BIOS_CHARACTERISTICS_PCI_SUPPORTED     (1 << 7)
>  #define BIOS_CHARACTERISTICS_UPGRADEABLE       (1 << 11)
> diff --git a/lib/smbios.c b/lib/smbios.c
> index eea72670bd9..7f79d969c92 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -567,7 +567,11 @@ ulong write_smbios_table(ulong addr)
>         addr = ALIGN(addr, 16);
>         start_addr = addr;
>
> -       addr += sizeof(struct smbios_entry);
> +       /*
> +        * So far we don't know which struct will be used, but they both end
> +        * up using the same amount of 16-bit-aligned space
> +        */
> +       addr += max(sizeof(struct smbios_entry), sizeof(struct smbios3_entry));
>         addr = ALIGN(addr, 16);
>         tables = addr;
>
> @@ -590,16 +594,32 @@ ulong write_smbios_table(ulong addr)
>          * We must use a pointer here so things work correctly on sandbox. The
>          * user of this table is not aware of the mapping of addresses to
>          * sandbox's DRAM buffer.
> +        *
> +        * Check the address of the end of the tables. If it is above 4GB then
> +        * it is sensible to use SMBIOS3 even if the start of the table is below
> +        * 4GB (this case is very unlikely to happen in practice)
>          */
>         table_addr = (ulong)map_sysmem(tables, 0);
> -       if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulong)UINT_MAX) {
> +       if (sizeof(table_addr) > sizeof(u32) && addr >= (ulong)UINT_MAX) {
> +               struct smbios3_entry *se;
>                 /*
>                  * We need to put this >32-bit pointer into the table but the
>                  * field is only 32 bits wide.
>                  */
> -               printf("WARNING: SMBIOS table_address overflow %llx\n",
> -                      (unsigned long long)table_addr);
> -               addr = 0;
> +               log_debug("WARNING: Using SMBIOS3.0 due to table-address overflow %lx\n",
> +                         table_addr);
> +               se = map_sysmem(start_addr, sizeof(struct smbios_entry));
> +               memset(se, '\0', sizeof(struct smbios_entry));
> +               memcpy(se->anchor, "_SM3_", 5);
> +               se->length = sizeof(struct smbios3_entry);
> +               se->major_ver = SMBIOS_MAJOR_VER;
> +               se->minor_ver = SMBIOS_MINOR_VER;
> +               se->doc_rev = 0;
> +               se->entry_point_rev = 1;
> +               se->max_struct_size = len;
> +               se->struct_table_address = table_addr;
> +               se->checksum = table_compute_checksum(se,
> +                                               sizeof(struct smbios3_entry));
>         } else {
>                 struct smbios_entry *se;
>
> --
> 2.34.1
>
