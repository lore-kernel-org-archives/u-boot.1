Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B95C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F085A8082A;
	Fri, 28 Mar 2025 13:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UiegCwcT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5608E810EA; Fri, 28 Mar 2025 13:01:38 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A687F805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2255003f4c6so40413035ad.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743163294; x=1743768094; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Oc4qO7DPX+fi8ZKpD66i9Gv3PH0JKG3hDHI3B5c0K84=;
 b=UiegCwcTGlCZaAh9YbMvrkcC+LELVXbsk9l2Rzx20vYc/gHL7oSLhbNEaXRjieIpIs
 I+jhZOcAtdJ9yknvmmEE0H4H8Fb3WVH0arapWhZf8gxG92dabB023nf4INhpwfE3ZrH8
 j25rR5nPpACGAe8R0KG+EBRkg+pJJiaYGDR34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743163294; x=1743768094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oc4qO7DPX+fi8ZKpD66i9Gv3PH0JKG3hDHI3B5c0K84=;
 b=H2me6McKEAOn69gtbn0EbMCBpMRFDvKJVSpnFgT6e/xHhQD216HaWbKTF0Wg/QATse
 ywnSaHlHeqENOfJ9kCJljIby0O+SCpFidR/Tlj/wEjrPMBkgDcgE+0WlpcOKJnFwiE28
 B4c2BGbrC9XumR44AeRcpDmV9MrCCmSrzpxvUmFbaAZ4UnEy/hyTZgMZQ0B1J/Gr5m+G
 an9duv1Co1LG0MHm5mbS3XnhBgTZVHPONKmpx/EdCmwwBy7zQ5+wiuUywLx2PUVbhRKy
 Lf+gup9MD4Cnjm2PEvrd6riyualviL5+oj6ecWtect5Xa42JXfqGXpvRDBzqEGCmPc5L
 mDWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA+wu+9rG3VxtZd/qQihTXAPaymSxntIgFQTFlixk+Ug2MCPKaUGVaBiSKXBA6rqEs/DSvWd4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4DkPHi+varWZG+SSrTNpZb6dKp4dkoom5QiYxXwtF1cUoM2cl
 sziXRa7Aux5e79Dr/gSXJL9gW3asn2dbiIw3Lf47eITTj5WlKTs8RWKUFqT6OPUhWjLtzd/y59Y
 xAYUBapofa1fbqy+qo7GAIhevXhWDMfWbG8Jb
X-Gm-Gg: ASbGncteXfSB/3mVhdr/0w5zE8sk9CRIiXmfpcN/JbwAdWdMXb29HvRfogDYY7E6Din
 /YCQ1aBbN7ewvzuLGe86JRndG1BtjBvhajw7A8PahcnkjWkR/6Cy0i89xvtlu0R2FE70hpTsFYA
 0Pzfr8FDcLZKWrza4YDbu122Z42Fw=
X-Google-Smtp-Source: AGHT+IFdE+Ow0SgX9UklyG5qLmoKMPeVaqxipSHbtBAIBg4UZCKTuGPgEB0RjOGB2ci7DpsnygB3QnLfVa0NvUpm8qI=
X-Received: by 2002:a05:6a00:1784:b0:736:5e28:cfba with SMTP id
 d2e1a72fcca58-739610bde82mr11627441b3a.18.1743163293723; Fri, 28 Mar 2025
 05:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-46-sjg@chromium.org>
 <0fd6b834-9e74-4919-9d62-19ec6cdcba69@gmx.de>
 <448d550b-1a2b-4fbe-a24a-292ba1037b44@gmx.de>
In-Reply-To: <448d550b-1a2b-4fbe-a24a-292ba1037b44@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 06:01:18 -0600
X-Gm-Features: AQ5f1JqNzIlq_s69JWIOusBZlOEEQ-K3hxCjHD9GQ8mUCPZx6LwJO0QcsBLQtHU
Message-ID: <CAFLszTiQrbhL1_t-deqd-Afw8Srvi5g7zOuvgaOCBGf1vnodKQ@mail.gmail.com>
Subject: Re: [PATCH v5 45/46] acpi: Support checking checksums
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, 21 Mar 2025 at 06:24, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 21.03.25 11:49, Heinrich Schuchardt wrote:
> > On 15.03.25 15:26, Simon Glass wrote:
> >> When the ACPI tables come from an earlier bootloader it is helpful to
> >> see whether the checksums are correct or not. Add a -c flag to the
> >> 'acpi list' command to support that.
> >>
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >> ---
> >>
> >> (no changes since v3)
> >>
> >> Changes in v3:
> >> - Add new patch to support checking checksums with ACPI command
> >>
> >>   cmd/acpi.c             | 57 +++++++++++++++++++++++++++---------------
> >>   doc/usage/cmd/acpi.rst | 20 ++++++++++++++-
> >>   test/dm/acpi.c         | 46 ++++++++++++++++++++++++++++++++++
> >>   3 files changed, 102 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/cmd/acpi.c b/cmd/acpi.c
> >> index 2273176f106..bb243202009 100644
> >> --- a/cmd/acpi.c
> >> +++ b/cmd/acpi.c
> >> @@ -7,6 +7,7 @@
> >>   #include <display_options.h>
> >>   #include <log.h>
> >>   #include <mapmem.h>
> >> +#include <tables_csum.h>
> >>   #include <acpi/acpi_table.h>
> >>   #include <asm/acpi_table.h>
> >>   #include <asm/global_data.h>
> >> @@ -15,6 +16,17 @@
> >>
> >>   DECLARE_GLOBAL_DATA_PTR;
> >>
> >> +static const char *show_checksum(void *ptr, uint size, bool chksums)
> >> +{
> >> +    uint checksum;
> >> +
> >> +    if (!chksums)
> >> +        return "";
> >> +    checksum = table_compute_checksum(ptr, size);
> >> +
> >> +    return checksum ? "  bad" : "  OK";
> >
> > Please, move the leading spaces to the printf statements below.
> >
> >> +}
> >> +
> >>   /**
> >>    * dump_hdr() - Dump an ACPI header
> >>    *
> >> @@ -23,16 +35,17 @@ DECLARE_GLOBAL_DATA_PTR;
> >>    *
> >>    * @hdr: ACPI header to dump
> >>    */
> >> -static void dump_hdr(struct acpi_table_header *hdr)
> >> +static void dump_hdr(struct acpi_table_header *hdr, bool chksums)
> >>   {
> >>       bool has_hdr = memcmp(hdr->signature, "FACS", ACPI_NAME_LEN);
> >>
> >>       printf("%.*s  %16lx  %5x", ACPI_NAME_LEN, hdr->signature,
> >>              (ulong)map_to_sysmem(hdr), hdr->length);
> >>       if (has_hdr) {
> >> -        printf("  v%02d %.6s %.8s %x %.4s %x\n", hdr->revision,
> >> +        printf("  v%02d %.6s %.8s %x %.4s %x%s\n", hdr->revision,
> >
> > %x results in variable length output. To avoid ragged layout, please,
> > define the output length.
> >
> > Best regards
> >
> > Heinrich
> >
> >>                  hdr->oem_id, hdr->oem_table_id, hdr->oem_revision,
> >> -               hdr->creator_id, hdr->creator_revision);
> >> +               hdr->creator_id, hdr->creator_revision,
> >> +               show_checksum(hdr, hdr->length, chksums));
> >>       } else {
> >>           printf("\n");
> >>       }
> >> @@ -52,22 +65,22 @@ static int dump_table_name(const char *sig)
> >>       return 0;
> >>   }
> >>
> >> -static void list_fadt(struct acpi_fadt *fadt)
> >> +static void list_fadt(struct acpi_fadt *fadt, bool chksums)
> >>   {
> >>       if (fadt->header.revision >= 3 && fadt->x_dsdt)
> >> -        dump_hdr(nomap_sysmem(fadt->x_dsdt, 0));
> >> +        dump_hdr(nomap_sysmem(fadt->x_dsdt, 0), chksums);
> >>       else if (fadt->dsdt)
> >> -        dump_hdr(nomap_sysmem(fadt->dsdt, 0));
> >> +        dump_hdr(nomap_sysmem(fadt->dsdt, 0), chksums);
> >>       if (!IS_ENABLED(CONFIG_X86) && !IS_ENABLED(CONFIG_SANDBOX) &&
> >>           !(fadt->flags & ACPI_FADT_HW_REDUCED_ACPI))
> >>           log_err("FADT not ACPI-hardware-reduced-compliant\n");
> >>       if (fadt->header.revision >= 3 && fadt->x_firmware_ctrl)
> >> -        dump_hdr(nomap_sysmem(fadt->x_firmware_ctrl, 0));
> >> +        dump_hdr(nomap_sysmem(fadt->x_firmware_ctrl, 0), chksums);
> >>       else if (fadt->firmware_ctrl)
> >> -        dump_hdr(nomap_sysmem(fadt->firmware_ctrl, 0));
> >> +        dump_hdr(nomap_sysmem(fadt->firmware_ctrl, 0), chksums);
> >>   }
> >>
> >> -static void list_rsdt(struct acpi_rsdp *rsdp)
> >> +static void list_rsdt(struct acpi_rsdp *rsdp, bool chksums)
> >>   {
> >>       int len, i, count;
> >>       struct acpi_rsdt *rsdt;
> >> @@ -75,11 +88,11 @@ static void list_rsdt(struct acpi_rsdp *rsdp)
> >>
> >>       if (rsdp->rsdt_address) {
> >>           rsdt = nomap_sysmem(rsdp->rsdt_address, 0);
> >> -        dump_hdr(&rsdt->header);
> >> +        dump_hdr(&rsdt->header, chksums);
> >>       }
> >>       if (rsdp->xsdt_address) {
> >>           xsdt = nomap_sysmem(rsdp->xsdt_address, 0);
> >> -        dump_hdr(&xsdt->header);
> >> +        dump_hdr(&xsdt->header, chksums);
> >>           len = xsdt->header.length - sizeof(xsdt->header);
> >>           count = len / sizeof(u64);
> >>       } else if (rsdp->rsdt_address) {
> >> @@ -100,24 +113,28 @@ static void list_rsdt(struct acpi_rsdp *rsdp)
> >>           if (!entry)
> >>               break;
> >>           hdr = nomap_sysmem(entry, 0);
> >> -        dump_hdr(hdr);
> >> +        dump_hdr(hdr, chksums);
> >>           if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN))
> >> -            list_fadt((struct acpi_fadt *)hdr);
> >> +            list_fadt((struct acpi_fadt *)hdr, chksums);
> >>       }
> >>   }
> >>
> >> -static void list_rsdp(struct acpi_rsdp *rsdp)
> >> +static void list_rsdp(struct acpi_rsdp *rsdp, bool chksums)
> >>   {
> >> -    printf("RSDP  %16lx  %5x  v%02d %.6s\n", (ulong)map_to_sysmem(rsdp),
> >> -           rsdp->length, rsdp->revision, rsdp->oem_id);
> >> -    list_rsdt(rsdp);
> >> +    printf("RSDP  %16lx  %5x  v%02d %.6s%s%s\n",
> >> +           (ulong)map_to_sysmem(rsdp), rsdp->length, rsdp->revision,
> >> +           rsdp->oem_id, show_checksum(rsdp, 0x14, chksums),
> >> +           show_checksum(rsdp, rsdp->length, chksums));
> >> +    list_rsdt(rsdp, chksums);
> >>   }
> >>
> >>   static int do_acpi_list(struct cmd_tbl *cmdtp, int flag, int argc,
> >>               char *const argv[])
> >>   {
> >>       struct acpi_rsdp *rsdp;
> >> +    bool chksums;
> >>
> >> +    chksums = argc >= 2 && !strcmp("-c", argv[1]);
> >>       rsdp = map_sysmem(gd_acpi_start(), 0);
> >>       if (!rsdp) {
> >>           printf("No ACPI tables present\n");
> >> @@ -125,7 +142,7 @@ static int do_acpi_list(struct cmd_tbl *cmdtp, int
> >> flag, int argc,
> >>       }
> >>       printf("Name              Base   Size  Detail\n"
> >>              "----  ----------------  -----
> >> ----------------------------\n");
> >> -    list_rsdp(rsdp);
> >> +    list_rsdp(rsdp, chksums);
> >>
> >>       return 0;
> >>   }
> >> @@ -187,13 +204,13 @@ static int do_acpi_dump(struct cmd_tbl *cmdtp,
> >> int flag, int argc,
> >>   }
> >>
> >>   U_BOOT_LONGHELP(acpi,
> >> -    "list  - list ACPI tables\n"
> >> +    "list [-c] - list ACPI tables [check checksums]\n"
>
> Let's keep things simple for the user:
>
> Always check the checksums.
> Only print a notice if a checksum is wrong.

I found that one table was wrong so I wanted a positive ack that each
table is either OK or BAD. I made the check optional though.

If you like, we could always check checksums but only print the OK/BAD
if -c is provided?

BTW I see you send a cleanup series for ACPI checksums. Is that based
on top of this series?

Regards,
Simon
