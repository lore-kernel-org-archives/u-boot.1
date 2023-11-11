Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCF9C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 14:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED8F186CF2;
	Sat, 11 Nov 2023 15:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="in2EFnm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B3886E0E; Sat, 11 Nov 2023 15:28:56 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C155B86564
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 15:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CFAF53FDC1; 
 Sat, 11 Nov 2023 14:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699712933;
 bh=/4zXh5IRSWbe3hU8TH4KUu5yhYo6Q4ebJ3pVZuX74zQ=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=in2EFnm0z2jpWBomMvuKOaIEak9LjaGYbdOhMfyiUNEXQUalmlB04PsAmJ6TKzTGc
 5maf1uTgDr9JunaEhgMAc/Qfdy6IMOzoWqMiYUG2iNKMPZSr/nrbOoxeExZat4bmWR
 yDVH9TQuvye3F6qbQDVF2J/fMP8aZIstYSyu7YcKEAYKVBRteLICstjt/n4WYTIrrb
 BMaNph5crIdcHrxjnOO9PaGQXqDrtIPotdr/qdh7vsPN3pYQFJ94DNPIMoqGWlGhIc
 rYalLLNQ0nrFiskqZdrpyeLid3KR5+pzL58IYWH4aYoUY+rAlNXblwX8eItEiETaLE
 QpEhhq65h3bKA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] acpi: cannot have RSDT above 4 GiB
Date: Sat, 11 Nov 2023 15:28:46 +0100
Message-Id: <20231111142846.180442-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

The field RsdtAddress has only 32 bit. The RSDT table cannot be located
beyond 4 GiB.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/acpi/base.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/lib/acpi/base.c b/lib/acpi/base.c
index 2057bd2bef..128a76ad39 100644
--- a/lib/acpi/base.c
+++ b/lib/acpi/base.c
@@ -21,10 +21,17 @@ void acpi_write_rsdp(struct acpi_rsdp *rsdp, struct acpi_rsdt *rsdt,
 	memcpy(rsdp->signature, RSDP_SIG, 8);
 	memcpy(rsdp->oem_id, OEM_ID, 6);
 
-	rsdp->length = sizeof(struct acpi_rsdp);
-	rsdp->rsdt_address = map_to_sysmem(rsdt);
+	if (rsdt)
+		rsdp->rsdt_address = map_to_sysmem(rsdt);
+	else
+		rsdp->rsdt_address = 0;
+
+	if (xsdt)
+		rsdp->xsdt_address = map_to_sysmem(xsdt);
+	else
+		rsdp->xsdt_address = 0;
 
-	rsdp->xsdt_address = map_to_sysmem(xsdt);
+	rsdp->length = sizeof(struct acpi_rsdp);
 	rsdp->revision = ACPI_RSDP_REV_ACPI_2_0;
 
 	/* Calculate checksums */
@@ -68,11 +75,15 @@ static void acpi_write_xsdt(struct acpi_xsdt *xsdt)
 static int acpi_write_base(struct acpi_ctx *ctx,
 			   const struct acpi_writer *entry)
 {
-	/* We need at least an RSDP and an RSDT Table */
+	/* We need at least an RSDP and an XSDT Table */
 	ctx->rsdp = ctx->current;
 	acpi_inc_align(ctx, sizeof(struct acpi_rsdp));
-	ctx->rsdt = ctx->current;
-	acpi_inc_align(ctx, sizeof(struct acpi_rsdt));
+	if (map_to_sysmem(ctx->current) < UINT_MAX - 0x10000) {
+		ctx->rsdt = ctx->current;
+		acpi_inc_align(ctx, sizeof(struct acpi_rsdt));
+	} else {
+		ctx->rsdt = 0;
+	}
 	ctx->xsdt = ctx->current;
 	acpi_inc_align(ctx, sizeof(struct acpi_xsdt));
 
@@ -80,7 +91,8 @@ static int acpi_write_base(struct acpi_ctx *ctx,
 	memset(ctx->base, '\0', ctx->current - ctx->base);
 
 	acpi_write_rsdp(ctx->rsdp, ctx->rsdt, ctx->xsdt);
-	acpi_write_rsdt(ctx->rsdt);
+	if (ctx->rsdt)
+		acpi_write_rsdt(ctx->rsdt);
 	acpi_write_xsdt(ctx->xsdt);
 
 	return 0;
-- 
2.40.1

