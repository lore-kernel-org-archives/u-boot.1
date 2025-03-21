Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6966DC35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 10:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D3D808A2;
	Fri, 21 Mar 2025 11:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="R5mZPCQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C4FE805C8; Fri, 21 Mar 2025 11:49:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6E6E810FE
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 11:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1742554170; x=1743158970; i=xypron.glpk@gmx.de;
 bh=D68O4gE4ovgw47h/keLF+bp5eh8TKMjn3zctuIq/LxI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=R5mZPCQrqinUfSXfb/tFtojxBAJh2S64qfzY/PVow6h02eO3sweFe4JzSB68G8p+
 kORJz9LHZu8QjWeBdnRecwSuauTb1srjzMx/V2KR7llorKo71N3Si29BCKNfuUCYt
 MPEoaAiCc6PjVUaRK50Bq/CsDBeekV/RcRWrLp2IcQrlSC2uzV5KRWjTwp+i/KGYA
 egMd/woZ5FQOrb7prvR77ScYHqaad7S9bxUvKvdig1wU5R/gIj9+u5AdAU9hpFQRd
 i9Nr0t3pxvXeHkpTDr7yXhNIFZjIC18sgqpFIW/2Bc1gMFmefAFjD4wA+FgL3GLxX
 eCTxvj+7MZaPQXaC1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKYx-1tatUc05c7-00QxTN; Fri, 21
 Mar 2025 11:49:29 +0100
Message-ID: <0fd6b834-9e74-4919-9d62-19ec6cdcba69@gmx.de>
Date: Fri, 21 Mar 2025 11:49:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 45/46] acpi: Support checking checksums
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-46-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250315142643.2600605-46-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vr1KPRmbj6nLIAxtTg6XX1pb714tzDoZzzF1rNMRLmL67IBYllr
 YI0S3TEs0S64KxkjVsRJY81ri/s1K75omp6PqwIz4UfBq137taoWbSvbMWYX9xBKUi7HVdq
 ie2dfxbY7+7I9oCwqUdImMjx39GBLFQS0t290FfSxhAMDqcseaMklzFrqW3wZ2oUtQ+kF+5
 vhRib0RYgocj2UA6IEOhw==
UI-OutboundReport: notjunk:1;M01:P0:on5/x6QMDa0=;2mSAmhIKhEOm92hBw3MCyME70Al
 btj8PdudhZBoakhBG4VFkwHMOMRg5LSQ1t2DgeUXksrcJ4Zoy92E7VrgfVtk4DD4jlzxL+4bY
 yvRyJOLi6LQXWFFlJiH0R8VgcfKE0HaJk0Tfy+mmxjJzlo/rFzBrvQvF4PEJk8FZBtQ7k+2DX
 FNV8LLtX65lfTarf/TD5SfItrRJLb/uK1wEkboGMztdjP9twiRUSUEopXIrbutfg+/xE2eH4a
 OOHl0/9stJGNSVacD+ukiTaLXslQINi09C4/JKrsjxilp66ZujM6Iz2Q+b13uRJh06bkm3nOH
 aTsU+8Jb4T9XWuytJ3gKWQ+6cbI6aMG2cvbmGr7ffpFLdZblUeXT4n3gTp0n2Fy3AtWgmmRoB
 4JccFQwokdNmDzMVmiqYebAF2R5FRflXGDNSNv9Mt7GNixMJg341AENoot/cdHu1VO7MTE0bZ
 aqVUIjfGnb1AD23w4TjrwhYqesnkx4boT3nvGahqz34/MjrdbOvTLNJLmUhiUZIBLabtfGPJV
 SnQUbN4hctBt7HCAHQtV31h3YuBxTbo2CXll6jwIWxYjk6UcnhrV3f5tBhihjK4Z/DguUaBG2
 gYsBQ64mddD3zTaLY6rDpTVhoRjCgWELt4CYE26q7hga6iqq38AfsbcRxRR0+4OhKXzH8v5iK
 GyZiij8icQhP1zfCEITgh6+DlsmSSfPBbLF9sIm4Xk3EE46GxETCn2aE7vlmFbcO51X03rlcC
 Zi8LMSLMsyH4fl3vb8V0P45FF5naz0brLQvauFWSuORHUFBPRit96Bw9UgujdCEeLZkEP1ZdT
 6X91OTS8VsIz508IW3XGpzc4UciBep3oA8CdJhkdBcDSFa4bYI+40nkIf2mSdgLEl14lD5dEo
 bixrH5biEOZOuUJVUP2AtIuvv8Fit6GYz2gIKN1SPYdSKB9id7/ChO9uyewjXRgShob+KDe56
 U8J9Lw1VsPODCxal5hMNaXlgmokQj5ce5bsleQi38Ob+6xtpOYYZTQqjencumRoFob4cwqiBv
 m+F4nXOcxk5bcuILB24Xz7arVEgoiqirHM/Bxqh1ZUK8KWGwbPoSGg+AtclcoHofXl+6ZZFSB
 YNK7dFFbSYJLhQ2fLODaRjlKVeTWWL0i4etDzXOpAjaYmDng6qmFfYz1p4DqmAfD/KvdHeerH
 T5gfF4jvmDvR1DUkScC9xG8Ahl/6QIW8LookQ5pvnt2soMmrYc4D8Sjns13Q8sm2q9hONsuNW
 aDTOSugH1cmbFy1nw+xpemNop6u14CMHhl/6n4F838xxlCnRNXWY7LIH1v+8mPOrNfzP9smrm
 MFFQkxv5qvDk97LtzAUInwfdA0iMlcTK08jYgbDtS+E+GhDYT89HUfBii7tFMWLh+7Xhx4HJC
 9mwtGcyEmR9xxQzdZk5M2BsRa0y486uC27ntV7A+EkIytc4+VGIUf/LF/GCr1RkAnObijHf6W
 BDf1ljNwrRyeUOCx274zB5E8Nm78=
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

On 15.03.25 15:26, Simon Glass wrote:
> When the ACPI tables come from an earlier bootloader it is helpful to
> see whether the checksums are correct or not. Add a -c flag to the
> 'acpi list' command to support that.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Add new patch to support checking checksums with ACPI command
>
>   cmd/acpi.c             | 57 +++++++++++++++++++++++++++---------------
>   doc/usage/cmd/acpi.rst | 20 ++++++++++++++-
>   test/dm/acpi.c         | 46 ++++++++++++++++++++++++++++++++++
>   3 files changed, 102 insertions(+), 21 deletions(-)
>
> diff --git a/cmd/acpi.c b/cmd/acpi.c
> index 2273176f106..bb243202009 100644
> --- a/cmd/acpi.c
> +++ b/cmd/acpi.c
> @@ -7,6 +7,7 @@
>   #include <display_options.h>
>   #include <log.h>
>   #include <mapmem.h>
> +#include <tables_csum.h>
>   #include <acpi/acpi_table.h>
>   #include <asm/acpi_table.h>
>   #include <asm/global_data.h>
> @@ -15,6 +16,17 @@
>
>   DECLARE_GLOBAL_DATA_PTR;
>
> +static const char *show_checksum(void *ptr, uint size, bool chksums)
> +{
> +	uint checksum;
> +
> +	if (!chksums)
> +		return "";
> +	checksum =3D table_compute_checksum(ptr, size);
> +
> +	return checksum ? "  bad" : "  OK";

Please, move the leading spaces to the printf statements below.

> +}
> +
>   /**
>    * dump_hdr() - Dump an ACPI header
>    *
> @@ -23,16 +35,17 @@ DECLARE_GLOBAL_DATA_PTR;
>    *
>    * @hdr: ACPI header to dump
>    */
> -static void dump_hdr(struct acpi_table_header *hdr)
> +static void dump_hdr(struct acpi_table_header *hdr, bool chksums)
>   {
>   	bool has_hdr =3D memcmp(hdr->signature, "FACS", ACPI_NAME_LEN);
>
>   	printf("%.*s  %16lx  %5x", ACPI_NAME_LEN, hdr->signature,
>   	       (ulong)map_to_sysmem(hdr), hdr->length);
>   	if (has_hdr) {
> -		printf("  v%02d %.6s %.8s %x %.4s %x\n", hdr->revision,
> +		printf("  v%02d %.6s %.8s %x %.4s %x%s\n", hdr->revision,

%x results in variable length output. To avoid ragged layout, please,
define the output length.

Best regards

Heinrich

>   		       hdr->oem_id, hdr->oem_table_id, hdr->oem_revision,
> -		       hdr->creator_id, hdr->creator_revision);
> +		       hdr->creator_id, hdr->creator_revision,
> +		       show_checksum(hdr, hdr->length, chksums));
>   	} else {
>   		printf("\n");
>   	}
> @@ -52,22 +65,22 @@ static int dump_table_name(const char *sig)
>   	return 0;
>   }
>
> -static void list_fadt(struct acpi_fadt *fadt)
> +static void list_fadt(struct acpi_fadt *fadt, bool chksums)
>   {
>   	if (fadt->header.revision >=3D 3 && fadt->x_dsdt)
> -		dump_hdr(nomap_sysmem(fadt->x_dsdt, 0));
> +		dump_hdr(nomap_sysmem(fadt->x_dsdt, 0), chksums);
>   	else if (fadt->dsdt)
> -		dump_hdr(nomap_sysmem(fadt->dsdt, 0));
> +		dump_hdr(nomap_sysmem(fadt->dsdt, 0), chksums);
>   	if (!IS_ENABLED(CONFIG_X86) && !IS_ENABLED(CONFIG_SANDBOX) &&
>   	    !(fadt->flags & ACPI_FADT_HW_REDUCED_ACPI))
>   		log_err("FADT not ACPI-hardware-reduced-compliant\n");
>   	if (fadt->header.revision >=3D 3 && fadt->x_firmware_ctrl)
> -		dump_hdr(nomap_sysmem(fadt->x_firmware_ctrl, 0));
> +		dump_hdr(nomap_sysmem(fadt->x_firmware_ctrl, 0), chksums);
>   	else if (fadt->firmware_ctrl)
> -		dump_hdr(nomap_sysmem(fadt->firmware_ctrl, 0));
> +		dump_hdr(nomap_sysmem(fadt->firmware_ctrl, 0), chksums);
>   }
>
> -static void list_rsdt(struct acpi_rsdp *rsdp)
> +static void list_rsdt(struct acpi_rsdp *rsdp, bool chksums)
>   {
>   	int len, i, count;
>   	struct acpi_rsdt *rsdt;
> @@ -75,11 +88,11 @@ static void list_rsdt(struct acpi_rsdp *rsdp)
>
>   	if (rsdp->rsdt_address) {
>   		rsdt =3D nomap_sysmem(rsdp->rsdt_address, 0);
> -		dump_hdr(&rsdt->header);
> +		dump_hdr(&rsdt->header, chksums);
>   	}
>   	if (rsdp->xsdt_address) {
>   		xsdt =3D nomap_sysmem(rsdp->xsdt_address, 0);
> -		dump_hdr(&xsdt->header);
> +		dump_hdr(&xsdt->header, chksums);
>   		len =3D xsdt->header.length - sizeof(xsdt->header);
>   		count =3D len / sizeof(u64);
>   	} else if (rsdp->rsdt_address) {
> @@ -100,24 +113,28 @@ static void list_rsdt(struct acpi_rsdp *rsdp)
>   		if (!entry)
>   			break;
>   		hdr =3D nomap_sysmem(entry, 0);
> -		dump_hdr(hdr);
> +		dump_hdr(hdr, chksums);
>   		if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN))
> -			list_fadt((struct acpi_fadt *)hdr);
> +			list_fadt((struct acpi_fadt *)hdr, chksums);
>   	}
>   }
>
> -static void list_rsdp(struct acpi_rsdp *rsdp)
> +static void list_rsdp(struct acpi_rsdp *rsdp, bool chksums)
>   {
> -	printf("RSDP  %16lx  %5x  v%02d %.6s\n", (ulong)map_to_sysmem(rsdp),
> -	       rsdp->length, rsdp->revision, rsdp->oem_id);
> -	list_rsdt(rsdp);
> +	printf("RSDP  %16lx  %5x  v%02d %.6s%s%s\n",
> +	       (ulong)map_to_sysmem(rsdp), rsdp->length, rsdp->revision,
> +	       rsdp->oem_id, show_checksum(rsdp, 0x14, chksums),
> +	       show_checksum(rsdp, rsdp->length, chksums));
> +	list_rsdt(rsdp, chksums);
>   }
>
>   static int do_acpi_list(struct cmd_tbl *cmdtp, int flag, int argc,
>   			char *const argv[])
>   {
>   	struct acpi_rsdp *rsdp;
> +	bool chksums;
>
> +	chksums =3D argc >=3D 2 && !strcmp("-c", argv[1]);
>   	rsdp =3D map_sysmem(gd_acpi_start(), 0);
>   	if (!rsdp) {
>   		printf("No ACPI tables present\n");
> @@ -125,7 +142,7 @@ static int do_acpi_list(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>   	}
>   	printf("Name              Base   Size  Detail\n"
>   	       "----  ----------------  -----  ----------------------------\n=
");
> -	list_rsdp(rsdp);
> +	list_rsdp(rsdp, chksums);
>
>   	return 0;
>   }
> @@ -187,13 +204,13 @@ static int do_acpi_dump(struct cmd_tbl *cmdtp, int=
 flag, int argc,
>   }
>
>   U_BOOT_LONGHELP(acpi,
> -	"list  - list ACPI tables\n"
> +	"list [-c] - list ACPI tables [check checksums]\n"
>   	"acpi items [-d]   - List/dump each piece of ACPI data from devices\n=
"
>   	"acpi set [<addr>] - Set or show address of ACPI tables\n"
>   	"acpi dump <name>  - Dump ACPI table");
>
>   U_BOOT_CMD_WITH_SUBCMDS(acpi, "ACPI tables", acpi_help_text,
> -	U_BOOT_SUBCMD_MKENT(list, 1, 1, do_acpi_list),
> +	U_BOOT_SUBCMD_MKENT(list, 2, 1, do_acpi_list),
>   	U_BOOT_SUBCMD_MKENT(items, 2, 1, do_acpi_items),
>   	U_BOOT_SUBCMD_MKENT(set, 2, 1, do_acpi_set),
>   	U_BOOT_SUBCMD_MKENT(dump, 2, 1, do_acpi_dump));
> diff --git a/doc/usage/cmd/acpi.rst b/doc/usage/cmd/acpi.rst
> index 9f30972fe53..e652968d584 100644
> --- a/doc/usage/cmd/acpi.rst
> +++ b/doc/usage/cmd/acpi.rst
> @@ -11,7 +11,7 @@ Synopsis
>
>   ::
>
> -    acpi list
> +    acpi list [-c]
>       acpi items [-d]
>       acpi dump <name>
>       acpi set <address>
> @@ -38,6 +38,9 @@ List the ACPI tables that have been generated. Each ta=
ble has a 4-character
>   table name (e.g. SSDT, FACS) and has a format defined by the
>   `ACPI specification`_.
>
> +The `-c` flag tells U-Boot to verify the checksums and print 'OK' or 'B=
AD' next
> +to each table.
> +
>   U-Boot does not currently support decoding the tables. Unlike devicetr=
ee, ACPI
>   tables have no regular schema and also some include bytecode, so decod=
ing the
>   tables requires a lot of code.
> @@ -259,5 +262,20 @@ pointer::
>       WAET  bff76a3b     28  v01 BOCHS  BXPC     1 BXPC 1
>       SSDT  bff95040     c5  v02 COREv4 COREBOOT 2a CORE 20221020
>
> +This shows checking that the checksums are correct for each table::
> +
> +    =3D> acpi list -c
> +    Name              Base   Size  Detail
> +    ----  ----------------  -----  ----------------------------
> +    RSDP          bec9a000     24  v00 BOCHS   OK OK
> +    RSDT          bec9bd4a     38  v01 BOCHS  BXPC     1 BXPC 1  OK
> +    FACP          bec9bb46     74  v01 BOCHS  BXPC     1 BXPC 1  OK
> +    DSDT          bec9a080   1ac6  v01 BOCHS  BXPC     1 BXPC 1  OK
> +    FACS          bec9a040     40
> +    APIC          bec9bbba     78  v03 BOCHS  BXPC     1 BXPC 1  OK
> +    HPET          bec9bc32     38  v01 BOCHS  BXPC     1 BXPC 1  OK
> +    SRAT          bec9bc6a     b8  v01 BOCHS  BXPC     1 BXPC 1  OK
> +    WAET          bec9bd22     28  v01 BOCHS  BXPC     1 BXPC 1  OK
> +
>
>   .. _`ACPI specification`: https://uefi.org/sites/default/files/resourc=
es/ACPI_6_3_final_Jan30.pdf
> diff --git a/test/dm/acpi.c b/test/dm/acpi.c
> index f98f9d1e74b..db012b6d2f1 100644
> --- a/test/dm/acpi.c
> +++ b/test/dm/acpi.c
> @@ -439,6 +439,52 @@ static int dm_test_acpi_cmd_list(struct unit_test_s=
tate *uts)
>   }
>   DM_TEST(dm_test_acpi_cmd_list, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CON=
SOLE);
>
> +/* Test 'acpi list -c' command */
> +static int dm_test_acpi_cmd_list_chksum(struct unit_test_state *uts)
> +{
> +	struct acpi_ctx ctx;
> +	ulong addr;
> +	void *buf;
> +
> +	buf =3D memalign(16, BUF_SIZE);
> +	ut_assertnonnull(buf);
> +	addr =3D map_to_sysmem(buf);
> +	ut_assertok(setup_ctx_and_base_tables(uts, &ctx, addr));
> +
> +	ut_assertok(acpi_write_dev_tables(&ctx));
> +
> +	run_command("acpi list -c", 0);
> +	ut_assert_nextline("Name              Base   Size  Detail");
> +	ut_assert_nextline("----  ----------------  -----  -------------------=
---------");
> +	ut_assert_nextline("RSDP  %16lx  %5zx  v02 U-BOOT  OK  OK", addr,
> +			   sizeof(struct acpi_rsdp));
> +	addr =3D ALIGN(addr + sizeof(struct acpi_rsdp), 16);
> +	ut_assert_nextline("RSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  =
OK",
> +			   addr, sizeof(struct acpi_table_header) +
> +			   3 * sizeof(u32), OEM_REVISION);
> +	addr =3D ALIGN(addr + sizeof(struct acpi_rsdt), 16);
> +	ut_assert_nextline("XSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  =
OK",
> +			   addr, sizeof(struct acpi_table_header) +
> +			   3 * sizeof(u64), OEM_REVISION);
> +	addr =3D ALIGN(addr + sizeof(struct acpi_xsdt), 64);
> +	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  =
OK",
> +			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
> +	addr =3D ALIGN(addr + sizeof(struct acpi_dmar), 16);
> +	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  =
OK",
> +			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
> +	addr =3D ALIGN(addr + sizeof(struct acpi_dmar), 16);
> +	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  =
OK",
> +			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
> +	ut_assert_console_end();
> +	ut_assert_console_end();
> +	unmap_sysmem(buf);
> +	free(buf);
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_acpi_cmd_list_chksum,
> +	UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
> +
>   /* Test 'acpi dump' command */
>   static int dm_test_acpi_cmd_dump(struct unit_test_state *uts)
>   {

