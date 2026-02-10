Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E2CEB26E3
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 16:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B15E783CBD;
	Tue, 10 Feb 2026 17:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XtQz5S9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1189683CE3; Tue, 10 Feb 2026 17:29:11 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D318367F
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 17:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.gantois@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7DE504E40BFD
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:29:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3A259606BD;
 Tue, 10 Feb 2026 16:29:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C00A510B92008; Tue, 10 Feb 2026 17:29:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1770740947; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=mKymJRuZ61AWtYQqVbP3HLpXlGlbDKXfzs8Y7yVub7s=;
 b=XtQz5S9pnOR9X85DAr0Zd02g3IMZWQEHHkaMDXLU3+c1OdeFfrb9fR8oaZtJ8AQzZG7dxh
 vU3G6lAqT3iNrgQGEkATcEXv9BjpVsEMHg90nYhlQ8bG+pcRRLdPG+57odaqgWV7cAidIV
 ABhlX672LtIfwx25c/sgjOAe7rZO8fDC5ko/Da32rIMpA+kbIkx9WonhVZkYK2Nvfqgu0P
 14s1jgPVtWwMuUpSETPLMDhs4TE473frSjF2S6xQL1yQtJq6NbBwEhpuZ7Xc9IJWRQrsoE
 beKYRQExxd5ssmCj4smKg/myT7Ep21noqag8WbRagk6md0tTw7NbUgFaw79j5w==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 10 Feb 2026 17:29:01 +0100
Subject: [PATCH] dm: core: Don't allow ofnode_to_fdt() to return NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-ofnode-to-fdt-null-v1-1-4bed28680f35@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAMxci2kC/x3MTQqAIBBA4avErBtQox+7SrSIHGsgNLQiEO+et
 PwW7yWIFJgijFWCQA9H9q5A1hWs++I2QjbFoITqhJICvXXeEF4erbnQ3ceBul20bdp+kJqghGc
 gy+8/neacPzpITvlkAAAA
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

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/core/ofnode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index cf1cf8abfbe..af24a2c533c 100644
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
+		fdt = gd->fdt_blob;
+
+	assert(fdt);
 
-	/* Use the control FDT by default */
-	return (void *)gd->fdt_blob;
+	return fdt;
 }
 
 /**

---
base-commit: b99da05e1538b8fa153322da82917af2aa27e1d6
change-id: 20260210-ofnode-to-fdt-null-95a9f357819e

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>

