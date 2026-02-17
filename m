Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4ABCE68149
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 09:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D42483C32;
	Tue, 17 Feb 2026 10:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="evP79hMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 733B083C61; Tue, 17 Feb 2026 10:28:04 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 475178063E
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 10:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.gantois@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id ACC594E40EF7;
 Tue, 17 Feb 2026 09:28:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 789BB606D1;
 Tue, 17 Feb 2026 09:28:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 73A4B10368945; Tue, 17 Feb 2026 10:27:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771320479; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=yJGomfxQTxejRa9DS/2OpPxmIQgsHLeQboKCBeMID10=;
 b=evP79hMiR7yV7ga1oFtaF0wiRrm5zoqsidvoGhazxZsGdD+iSRnnTXrs1h1gCVSVaRu0Xl
 E2doP2ziRpAb+expphD0KuwXwPNeTUH+zdToBCxBr2kwjrCkVt0rdqCkI1Yudh7E0mWEZU
 dyashwoeiR7I3faby5aqzZ9snjj5NnKxLX4GSv/WxjRWoMmvoewGY2scNYT70/SF5FNCmb
 pQxlRU9Yaq8Ovfr/+QmzWfZuCYiH+rp9mrtElvwkfknQuEyUAIJKPwCZnSjxgpIgyXZ2pL
 TfGR0gXhmidEGVxFXML1FKVKUf5yOp0uJJonT1lUPo1YWdgzYULVid55fP9qCg==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 17 Feb 2026 10:27:52 +0100
Subject: [PATCH v2] dm: core: Don't allow ofnode_to_fdt() to return NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260217-ofnode-to-fdt-null-v2-1-915e627d201b@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAJc0lGkC/32NQQ6CMBBFr0Jm7Zi2CoIr72FYAJ3KJNghbSUaw
 t2tHMDle8l/f4VIgSnCtVgh0MKRxWcwhwKGsfMPQraZwShTKaMVivNiCZOgswn9a5qwKbvGncp
 LrRuCPJwDOX7v0XubeeSYJHz2j0X/7N/colHjuSdr6qpWOXzrRdLE/jjIE9pt276thxmgtgAAA
 A==
X-Change-ID: 20260210-ofnode-to-fdt-null-95a9f357819e
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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

The ofnode_to_fdt() function may return a NULL pointer in multiple cases.
Or, this function's return value is often passed directly to functions such
as fdt_getprop() which end up dereferencing it, thus causing a NULL pointer
exception.

Don't allow ofnode_to_fdt() to return NULL, to avoid a NULL pointer
dereference.

Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Changes in v2:
- Added back a dropped cast from cont void* to void*
- Link to v1: https://lore.kernel.org/r/20260210-ofnode-to-fdt-null-v1-1-4bed28680f35@bootlin.com
---
 drivers/core/ofnode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index cf1cf8abfbe..3a36b6fdd03 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -164,15 +164,20 @@ void *ofnode_lookup_fdt(ofnode node)
 
 void *ofnode_to_fdt(ofnode node)
 {
+	void *fdt;
+
 #ifdef OF_CHECKS
 	if (of_live_active())
-		return NULL;
+		panic("%s called with live tree in use!\n", __func__);
 #endif
 	if (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) && ofnode_valid(node))
-		return ofnode_lookup_fdt(node);
+		fdt = ofnode_lookup_fdt(node);
+	else
+		fdt = (void *)gd->fdt_blob;
+
+	assert(fdt);
 
-	/* Use the control FDT by default */
-	return (void *)gd->fdt_blob;
+	return fdt;
 }
 
 /**

---
base-commit: 8666b16015d4212facacc514e2eb626f3630dcf0
change-id: 20260210-ofnode-to-fdt-null-95a9f357819e

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>

