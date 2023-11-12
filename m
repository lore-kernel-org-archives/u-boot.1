Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05CEC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 03:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A545A876E5;
	Sun, 12 Nov 2023 04:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uyiz55ZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 251C5870E6; Sun, 12 Nov 2023 04:09:03 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFD9A871E6
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so903570466b.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 19:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699758537; x=1700363337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9ct8+3m7fAh+3fTkK35n6ugOLjgOBvT/lJptChaoP/Y=;
 b=Uyiz55ZAQb/4bs0ajHSztCpJ34rdk98RIDbmfrVj9uC+82/rf9ZkDV5ZhjPgmGwE9r
 i4adtDwh9kj/aZGPrhTscon3nVIJKqgfCEeH96yPP3wLmIv9WORyRTHX1e1T20y8r2zD
 BrL2U/Yv3CS6kfdKfyjbJOIMOx+gRpXzFvws8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699758537; x=1700363337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ct8+3m7fAh+3fTkK35n6ugOLjgOBvT/lJptChaoP/Y=;
 b=A0xEqPgdNxyQIfUKc/tcG1TNmrBjgfRkS9rcjU3QKtlWqQx+uLPBXiJz/h/bhkhHvr
 CTUKNL0wcOLiHK4OaWjXt3SATr+fVqy7iESyXBj7HwbKIXlF74Oj+JRL1dOFL/cvK9jw
 QAxm2pje5CpJQFHJ8YrG/R3BB65+1FUAOLOgQ3oDUB3WuS9GDZr9dTUSP8DrvT6zI/29
 I2Figt+PvBMFFfbywrfmksIis7KRcWQKA8Dmc171Ls+xzhX4h4uCOlNhMHEENQmEzydq
 fM8vtxaStj+xervrT0b9a2vTg8q6vfuD0bj1/XVM+qKyvghVJ4+y4EQW4S213WCctM6f
 caKw==
X-Gm-Message-State: AOJu0Yz+X6sWLMiltPZ35Cuhw+o8+XYkV28InfOxTx0Yfm4xNhk0ueug
 yjLHv8A6A/718zanAf8/Avbu0bzSNEBbcVvv0ZVx746MbYLQZExDKik=
X-Google-Smtp-Source: AGHT+IGY/Hg9qGdyoX/8R0kAWB4gIdUnqZQihd/XdDafprw/lWSxx3yd8D5sU5SGs0VkVrUVYKYlTy5mbCbHIXEu0Fw=
X-Received: by 2002:a17:907:c07:b0:9e5:26b2:b38d with SMTP id
 ga7-20020a1709070c0700b009e526b2b38dmr3759025ejc.10.1699758537184; Sat, 11
 Nov 2023 19:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20231111134112.165377-1-heinrich.schuchardt@canonical.com>
 <20231111134112.165377-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231111134112.165377-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Nov 2023 20:08:40 -0700
Message-ID: <CAPnjgZ2jca7az3rgNmDoX0Zi5zSDFFKvaKkVvT-cTVEy3ktv7A@mail.gmail.com>
Subject: Re: [PATCH 2/3] cmd: acpi: fix acpi list command
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 11 Nov 2023 at 06:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> ACPI tables may comprise either RSDT, XSDT, or both. The current code fails
> to check the presence of the RSDT table before accessing it. This leads to
> an exception if the RSDT table is not provided.
>
> The XSDT table takes precedence over the RSDT table.
>
> Addresses in the XSDT table are 64-bit. Adjust the output accordingly.
>
> The ACPI specification does not require that the sequence of tables are the
> same in XSDT and RSDT. Comparing entries with the same index makes no
> sense.

Does it make any sense to have different sequences? Have you seen that
in the wild?

>
> The FACS table header does not provide revision information. Correct the
> description of dump_hdr().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/acpi.c | 48 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>
> diff --git a/cmd/acpi.c b/cmd/acpi.c
> index 7e397d1a74..d02108d821 100644
> --- a/cmd/acpi.c
> +++ b/cmd/acpi.c
> @@ -17,7 +17,8 @@ DECLARE_GLOBAL_DATA_PTR;
>  /**
>   * dump_hdr() - Dump an ACPI header
>   *
> - * If the header is for FACS then it shows the revision information as well
> + * Except for the Firmware ACPI Control Structure (FACS)
> + * additionally show the revision information.
>   *
>   * @hdr: ACPI header to dump
>   */
> @@ -25,7 +26,7 @@ static void dump_hdr(struct acpi_table_header *hdr)
>  {
>         bool has_hdr = memcmp(hdr->signature, "FACS", ACPI_NAME_LEN);
>
> -       printf("%.*s  %08lx  %5x", ACPI_NAME_LEN, hdr->signature,
> +       printf("%.*s  %016lx  %5x", ACPI_NAME_LEN, hdr->signature,
>                (ulong)map_to_sysmem(hdr), hdr->length);
>         if (has_hdr) {
>                 printf("  v%02d %.6s %.8s %x %.4s %x\n", hdr->revision,
> @@ -43,7 +44,7 @@ static int dump_table_name(const char *sig)
>         hdr = acpi_find_table(sig);
>         if (!hdr)
>                 return -ENOENT;
> -       printf("%.*s @ %08lx\n", ACPI_NAME_LEN, hdr->signature,
> +       printf("%.*s @ %016lx\n", ACPI_NAME_LEN, hdr->signature,

We really don't want 16 hex digits of output. It just isn't readable.

Should we add a way of writing a hex number with an underscore between
digits 8 and 9?

12345678_3846263d

Better I think (at least for now) would be to use %10lx and live with
the column misalignment in the unlikely event that very large
addresses are used.

>                (ulong)map_to_sysmem(hdr));
>         print_buffer(0, hdr, 1, hdr->length, 0);
>
> @@ -62,26 +63,34 @@ static int list_rsdt(struct acpi_rsdt *rsdt, struct acpi_xsdt *xsdt)
>  {
>         int len, i, count;
>
> -       dump_hdr(&rsdt->header);
> -       if (xsdt)
> +       if (rsdt)
> +               dump_hdr(&rsdt->header);
> +       if (xsdt) {
>                 dump_hdr(&xsdt->header);
> -       len = rsdt->header.length - sizeof(rsdt->header);
> -       count = len / sizeof(u32);
> +               len = xsdt->header.length - sizeof(xsdt->header);
> +               count = len / sizeof(u64);
> +       } else if (rsdt) {
> +               len = rsdt->header.length - sizeof(rsdt->header);
> +               count = len / sizeof(u32);
> +       } else {
> +               return 0;
> +       }
> +
>         for (i = 0; i < count; i++) {
>                 struct acpi_table_header *hdr;
>
> -               if (!rsdt->entry[i])
> -                       break;
> -               hdr = map_sysmem(rsdt->entry[i], 0);
> +               if (xsdt) {
> +                       if (!xsdt->entry[i])
> +                               break;
> +                       hdr = map_sysmem(xsdt->entry[i], 0);
> +               } else {
> +                       if (!rsdt->entry[i])
> +                               break;
> +                       hdr = map_sysmem(rsdt->entry[i], 0);
> +               }
>                 dump_hdr(hdr);
>                 if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN))
>                         list_fadt((struct acpi_fadt *)hdr);
> -               if (xsdt) {
> -                       if (xsdt->entry[i] != rsdt->entry[i]) {
> -                               printf("   (xsdt mismatch %llx)\n",
> -                                      xsdt->entry[i]);
> -                       }
> -               }
>         }
>
>         return 0;
> @@ -92,10 +101,11 @@ static int list_rsdp(struct acpi_rsdp *rsdp)
>         struct acpi_rsdt *rsdt;
>         struct acpi_xsdt *xsdt;
>
> -       printf("RSDP  %08lx  %5x  v%02d %.6s\n", (ulong)map_to_sysmem(rsdp),
> +       printf("RSDP  %016lx  %5x  v%02d %.6s\n", (ulong)map_to_sysmem(rsdp),
>                rsdp->length, rsdp->revision, rsdp->oem_id);
>         rsdt = map_sysmem(rsdp->rsdt_address, 0);
>         xsdt = map_sysmem(rsdp->xsdt_address, 0);
> +
>         list_rsdt(rsdt, xsdt);
>
>         return 0;
> @@ -111,8 +121,8 @@ static int do_acpi_list(struct cmd_tbl *cmdtp, int flag, int argc,
>                 printf("No ACPI tables present\n");
>                 return 0;
>         }
> -       printf("Name      Base   Size  Detail\n");
> -       printf("----  --------  -----  ------\n");
> +       printf("Name  Base               Size  Detail\n"
> +              "----  ----------------  -----  ----------------------------\n");
>         list_rsdp(rsdp);
>
>         return 0;
> --
> 2.40.1
>

Regards,
Simon
