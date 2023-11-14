Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA66C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 16:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73D548703A;
	Tue, 14 Nov 2023 17:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="myZxb0op";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DE2E86FBC; Tue, 14 Nov 2023 17:39:36 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7833A8703A
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 17:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C9E843FB46; 
 Tue, 14 Nov 2023 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699979972;
 bh=xu2jZViHaV4/pPWpdrHdZ8hEf2WA4Ra069khgt7dxus=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=myZxb0op0L1cwjDDhIB5xTE9/5DZsyDD7NMZxXDep5vaym6g32d45kPK6uzrVzG7p
 NPr3C8D1jhz4KclIezmDsH2RLsJUQQhOo/suuU7a0+sZuexagY2/OJZr07wmPk0ZZp
 /3aKBg6T7C+XVLOuYHtGQemLZRv5Pn+43vYUFphNOEOUzBGJPxc3QQBTDKNuF4H7FJ
 SHjhXFBVKbBk8yY3Y+r3O4m2ZmeCpXRru5FBXx1gh3/pzFJehao4pEsgz5b1/UBFmG
 HYBIQQ8ovxsqf38ZkMmHcZFp2KL5m9F37+i6OYI2I7R6uawqSh2v9umQSYlMaTzqgN
 dF72UYCCLjlCQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] acpi: consider XSDT in acpi_find_table()
Date: Tue, 14 Nov 2023 17:39:24 +0100
Message-Id: <20231114163924.23225-1-heinrich.schuchardt@canonical.com>
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

The RSDT table is deprecated and does not exist on all systems.

By preference scan XSDT for the table to find. If no XSDT table exists, try
to use the RSDT table.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/acpi/acpi.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/acpi/acpi.c b/lib/acpi/acpi.c
index 14b15754f4..3938946fc6 100644
--- a/lib/acpi/acpi.c
+++ b/lib/acpi/acpi.c
@@ -16,18 +16,30 @@ struct acpi_table_header *acpi_find_table(const char *sig)
 {
 	struct acpi_rsdp *rsdp;
 	struct acpi_rsdt *rsdt;
+	struct acpi_xsdt *xsdt;
 	int len, i, count;
 
 	rsdp = map_sysmem(gd_acpi_start(), 0);
 	if (!rsdp)
 		return NULL;
-	rsdt = map_sysmem(rsdp->rsdt_address, 0);
-	len = rsdt->header.length - sizeof(rsdt->header);
-	count = len / sizeof(u32);
+	xsdt = map_sysmem(rsdp->xsdt_address, 0);
+	if (xsdt) {
+		len = xsdt->header.length - sizeof(xsdt->header);
+		count = len / sizeof(u64);
+	} else {
+		rsdt = map_sysmem(rsdp->rsdt_address, 0);
+		if (!rsdt)
+			return NULL;
+		len = rsdt->header.length - sizeof(rsdt->header);
+		count = len / sizeof(u32);
+	}
 	for (i = 0; i < count; i++) {
 		struct acpi_table_header *hdr;
 
-		hdr = map_sysmem(rsdt->entry[i], 0);
+		if (xsdt)
+			hdr = map_sysmem(xsdt->entry[i], 0);
+		else
+			hdr = map_sysmem(rsdt->entry[i], 0);
 		if (!memcmp(hdr->signature, sig, ACPI_NAME_LEN))
 			return hdr;
 		if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN)) {
-- 
2.40.1

