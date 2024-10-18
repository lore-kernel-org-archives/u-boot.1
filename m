Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C8ED2127B
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 08:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3DB489254;
	Fri, 18 Oct 2024 10:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="SKRhAEO5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ty7dhM4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C832289139; Fri, 18 Oct 2024 10:30:16 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2C968917E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.spranger@linutronix.de
From: Benedikt Spranger <b.spranger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1729240213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXlIWlaN6pq3omPm91KlLaODADD8Ht90RZvPTK1/spk=;
 b=SKRhAEO5QiX9XKAEGovxLvKYt9o8zRzqfeH9nzF5rKcyo+RY3zhgnO3ch1cZlId+BKEGIa
 TcR8NACBHX1w1vBbS+OFfIaBGR1Xh3TTqJStBhxOzUzIn7MuurZ8IIAPnUiN6IXP2BnkDF
 CaoMLUYSpFdIWW3NPXdhzsyplWdk4083zw4PJ193M49W8HGSpg/ScL116biUQlsF23rjtS
 iYH6/JpNbjZhSoJQswDGS3tL/c4ppFmcAfXYtHjJ4cj4hWkgLeOhYHv39if7718aJWP6Gw
 H+llBUzqcTPdVUxGOG031NoyhRMit/MhUlkkujnncnGrAlrB+ZzdyHHYZXrrPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1729240213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXlIWlaN6pq3omPm91KlLaODADD8Ht90RZvPTK1/spk=;
 b=Ty7dhM4H/c7MirRvnSeImOuaMvEO/834n0yJdAQZG1l7KUTEezeSHRj0C8/7S96ICye0x8
 bI9o/0+kI5sXx9Dw==
To: u-boot@lists.denx.de
Cc: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 3/5] mtd: nand: raw: Fix potential NULL pointer dereference
Date: Fri, 18 Oct 2024 10:30:04 +0200
Message-ID: <20241018083006.10349-5-b.spranger@linutronix.de>
In-Reply-To: <20241018083006.10349-1-b.spranger@linutronix.de>
References: <20241018083006.10349-1-b.spranger@linutronix.de>
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

A NAND manufacture ID may not be found in nand_manuf_ids[] database.
In case of an ONFI or JEDEC NAND a crutial NULL pointer check is missing
and printing out the manufacture name result in a NULL pointer
dereference. Instead of adding additional NULL pointer checks ensure
a valid nand_menufacture_desc and remove the checks entirely.

Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/mtd/nand/raw/nand_base.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 4401bdcdb90..5dbc47bfe5f 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4241,7 +4241,7 @@ static bool find_full_id_nand(struct mtd_info *mtd, struct nand_chip *chip,
  * @id: manufacturer ID
  *
  * Returns a nand_manufacturer_desc object if the manufacturer is defined
- * in the NAND manufacturers database, NULL otherwise.
+ * in the NAND manufacturers database, "Unknown" entry otherwise.
  */
 static const struct nand_manufacturer *nand_get_manufacturer_desc(u8 id)
 {
@@ -4252,7 +4252,7 @@ static const struct nand_manufacturer *nand_get_manufacturer_desc(u8 id)
 			return &nand_manuf_ids[i];
 	}
 
-	return NULL;
+	return &nand_manuf_ids[i];
 }
 
 /*
@@ -4425,13 +4425,13 @@ ident_done:
 	else if (chip->jedec_version)
 		pr_info("%s %s\n", manufacturer_desc->name,
 			chip->jedec_params.model);
-	else if (manufacturer_desc)
+	else
 		pr_info("%s %s\n", manufacturer_desc->name, type->name);
 #else
 	if (chip->jedec_version)
 		pr_info("%s %s\n", manufacturer_desc->name,
 			chip->jedec_params.model);
-	else if (manufacturer_desc)
+	else
 		pr_info("%s %s\n", manufacturer_desc->name, type->name);
 #endif
 
-- 
2.45.2

