Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F7EC4167D
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 13:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2595D87006;
	Sat, 11 Nov 2023 14:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YEUNPqhN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23D78714C; Sat, 11 Nov 2023 14:42:42 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 418A186FDE
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 14:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9DF5F4170D; 
 Sat, 11 Nov 2023 13:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699710158;
 bh=xOmdRdaTX755iBdLAVRca4TzdKvjZlF7apwTXxCvFcQ=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=YEUNPqhNHEsF0PObJtv9l7yi9y0JN95sRe1hTYpAT+v5bphcNCEOoXB2h8MHzIJQf
 CnaUkOi4Cxb16iGCmZRLQH6lTCG5V1JbrN1+TQIJKMorQjI2oip/u0NqQDNhCbDlmU
 NlMv2R+sXmQMuU0P4Ijwg/09geLp78eoUspU3FWYQnb4ykaK7J2odq/tV2EY0wdfaI
 Uxx22Hoh+eYIcHfu9qzjyQCS2Swa2z5FlVYpP8/jltvBik40M18tIcnCv5FRblTOow
 B6TL59ZauO99ZApOth95LNygKPcIX+gaN8JmR12ZGuwgVUuX/UwtDii/sANmbmUDxB
 Be/fP6ngfIdpg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] cmd: acpi: fix acpi list command
Date: Sat, 11 Nov 2023 14:41:11 +0100
Message-Id: <20231111134112.165377-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231111134112.165377-1-heinrich.schuchardt@canonical.com>
References: <20231111134112.165377-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

ACPI tables may comprise either RSDT, XSDT, or both. The current code fails
to check the presence of the RSDT table before accessing it. This leads to
an exception if the RSDT table is not provided.

The XSDT table takes precedence over the RSDT table.

Addresses in the XSDT table are 64-bit. Adjust the output accordingly.

The ACPI specification does not require that the sequence of tables are the
same in XSDT and RSDT. Comparing entries with the same index makes no
sense.

The FACS table header does not provide revision information. Correct the
description of dump_hdr().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/acpi.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/cmd/acpi.c b/cmd/acpi.c
index 7e397d1a74..d02108d821 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -17,7 +17,8 @@ DECLARE_GLOBAL_DATA_PTR;
 /**
  * dump_hdr() - Dump an ACPI header
  *
- * If the header is for FACS then it shows the revision information as well
+ * Except for the Firmware ACPI Control Structure (FACS)
+ * additionally show the revision information.
  *
  * @hdr: ACPI header to dump
  */
@@ -25,7 +26,7 @@ static void dump_hdr(struct acpi_table_header *hdr)
 {
 	bool has_hdr = memcmp(hdr->signature, "FACS", ACPI_NAME_LEN);
 
-	printf("%.*s  %08lx  %5x", ACPI_NAME_LEN, hdr->signature,
+	printf("%.*s  %016lx  %5x", ACPI_NAME_LEN, hdr->signature,
 	       (ulong)map_to_sysmem(hdr), hdr->length);
 	if (has_hdr) {
 		printf("  v%02d %.6s %.8s %x %.4s %x\n", hdr->revision,
@@ -43,7 +44,7 @@ static int dump_table_name(const char *sig)
 	hdr = acpi_find_table(sig);
 	if (!hdr)
 		return -ENOENT;
-	printf("%.*s @ %08lx\n", ACPI_NAME_LEN, hdr->signature,
+	printf("%.*s @ %016lx\n", ACPI_NAME_LEN, hdr->signature,
 	       (ulong)map_to_sysmem(hdr));
 	print_buffer(0, hdr, 1, hdr->length, 0);
 
@@ -62,26 +63,34 @@ static int list_rsdt(struct acpi_rsdt *rsdt, struct acpi_xsdt *xsdt)
 {
 	int len, i, count;
 
-	dump_hdr(&rsdt->header);
-	if (xsdt)
+	if (rsdt)
+		dump_hdr(&rsdt->header);
+	if (xsdt) {
 		dump_hdr(&xsdt->header);
-	len = rsdt->header.length - sizeof(rsdt->header);
-	count = len / sizeof(u32);
+		len = xsdt->header.length - sizeof(xsdt->header);
+		count = len / sizeof(u64);
+	} else if (rsdt) {
+		len = rsdt->header.length - sizeof(rsdt->header);
+		count = len / sizeof(u32);
+	} else {
+		return 0;
+	}
+
 	for (i = 0; i < count; i++) {
 		struct acpi_table_header *hdr;
 
-		if (!rsdt->entry[i])
-			break;
-		hdr = map_sysmem(rsdt->entry[i], 0);
+		if (xsdt) {
+			if (!xsdt->entry[i])
+				break;
+			hdr = map_sysmem(xsdt->entry[i], 0);
+		} else {
+			if (!rsdt->entry[i])
+				break;
+			hdr = map_sysmem(rsdt->entry[i], 0);
+		}
 		dump_hdr(hdr);
 		if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN))
 			list_fadt((struct acpi_fadt *)hdr);
-		if (xsdt) {
-			if (xsdt->entry[i] != rsdt->entry[i]) {
-				printf("   (xsdt mismatch %llx)\n",
-				       xsdt->entry[i]);
-			}
-		}
 	}
 
 	return 0;
@@ -92,10 +101,11 @@ static int list_rsdp(struct acpi_rsdp *rsdp)
 	struct acpi_rsdt *rsdt;
 	struct acpi_xsdt *xsdt;
 
-	printf("RSDP  %08lx  %5x  v%02d %.6s\n", (ulong)map_to_sysmem(rsdp),
+	printf("RSDP  %016lx  %5x  v%02d %.6s\n", (ulong)map_to_sysmem(rsdp),
 	       rsdp->length, rsdp->revision, rsdp->oem_id);
 	rsdt = map_sysmem(rsdp->rsdt_address, 0);
 	xsdt = map_sysmem(rsdp->xsdt_address, 0);
+
 	list_rsdt(rsdt, xsdt);
 
 	return 0;
@@ -111,8 +121,8 @@ static int do_acpi_list(struct cmd_tbl *cmdtp, int flag, int argc,
 		printf("No ACPI tables present\n");
 		return 0;
 	}
-	printf("Name      Base   Size  Detail\n");
-	printf("----  --------  -----  ------\n");
+	printf("Name  Base               Size  Detail\n"
+	       "----  ----------------  -----  ----------------------------\n");
 	list_rsdp(rsdp);
 
 	return 0;
-- 
2.40.1

