Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA653C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC83C8714F;
	Sat, 18 Nov 2023 22:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AcpOsCeV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95552874C5; Sat, 18 Nov 2023 22:57:47 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0AA88714F
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0B8F23FB46; 
 Sat, 18 Nov 2023 21:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700344653;
 bh=pyTFOpVTzkaoAOeHeLFrFq3hFM2tbjhu4GZMrIVF/8s=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=AcpOsCeV0/jwpXWKBT+mWPMCxuX0xyfwOuWem3WffUwZScg9MnWhtZxvKPRDApS82
 W1LhmOMvnEX4tuQESUb7VBJ16Z6rl4UwTXSpvX88Yx1KkqH5COU4HlxGgjIUy2ttpC
 a02TClgwI3OYnSNVHlRjOAlgaX8VSj3kOUY8F7DpNV5rd3GYAaXZJpCHacSeLu8ip+
 5dnkHC5k/VtQJuvIpkJ6d7cfonaDCFG9etOveYoVhnT08bfvZ4GnB6N8D4yw5z+z0u
 eOkbMTFFqG4WUbwibFFRbIwN9O2HNGZBMartf3qvHlHHj/hz58Nw6kVDChR4ev3aha
 A0bB4z8oz35Sg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] acpi: consider XSDT in acpi_find_table()
Date: Sat, 18 Nov 2023 22:57:26 +0100
Message-Id: <20231118215727.95086-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118215727.95086-1-heinrich.schuchardt@canonical.com>
References: <20231118215727.95086-1-heinrich.schuchardt@canonical.com>
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
v2:
	consider that map_sysmem(0, 0) != NULL
---
 lib/acpi/acpi.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/acpi/acpi.c b/lib/acpi/acpi.c
index 14b15754f4..f21e509461 100644
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
+	if (rsdp->xsdt_address) {
+		xsdt = map_sysmem(rsdp->xsdt_address, 0);
+		len = xsdt->header.length - sizeof(xsdt->header);
+		count = len / sizeof(u64);
+	} else {
+		if (!rsdp->rsdt_address)
+			return NULL;
+		rsdt = map_sysmem(rsdp->rsdt_address, 0);
+		len = rsdt->header.length - sizeof(rsdt->header);
+		count = len / sizeof(u32);
+	}
 	for (i = 0; i < count; i++) {
 		struct acpi_table_header *hdr;
 
-		hdr = map_sysmem(rsdt->entry[i], 0);
+		if (rsdp->xsdt_address)
+			hdr = map_sysmem(xsdt->entry[i], 0);
+		else
+			hdr = map_sysmem(rsdt->entry[i], 0);
 		if (!memcmp(hdr->signature, sig, ACPI_NAME_LEN))
 			return hdr;
 		if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN)) {
-- 
2.40.1

