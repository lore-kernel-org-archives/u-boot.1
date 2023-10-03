Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C60DE776E9
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 01:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F47D86D60;
	Tue,  3 Oct 2023 03:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RRACYnTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 224828634D; Tue,  3 Oct 2023 03:09:12 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C00F86D60
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 03:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 826043F1FB; 
 Tue,  3 Oct 2023 01:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696295342;
 bh=bRZirjhVozR72KAlYj2r4dpIgK+1iniwz+5QbFpqoRM=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=RRACYnTUPfYtNlMbmcjQtIDR5gf4dU8nKIshmQxJ0Y7QFSULK/LNfluExzf59kiac
 yZad79zmKPRFgNuavDU3tY0Et960OeOheHipSeVcvBJ1unLwgL/C9ZiLT9vv7DAhyj
 RVre3aID7g82Gr6Fyc1yLccg2ek6SKu+AI2+tkpIZw36MU45dqXHRitLyDCciGX0UI
 0OdoAOTkVJvvkDS5vF3vApOX/PhyE2kt6s1ZrZWRdPorfK4WRvEOr4D1y2+SGKJOe/
 rtMH4e5LlEDSN5uFMC52yXUd4vSFcTF8w9AQgA62pmhF+qjLbZBIZ+RdbMalS3VmY0
 h60UWX31QJTfA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/1] input: avoid NULL dereference
Date: Tue,  3 Oct 2023 03:09:01 +0200
Message-Id: <20231003010901.98121-1-heinrich.schuchardt@canonical.com>
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

Before using the result of env_get("stdin") we must check if it is NULL.

Avoid #if. This resolves the -Wunused-but-set-variable issue and we don't
need a dummy assignment in the else branch. Anyway this warning is
disabled in the Makefile.

For sake of readability use an early return after the configuration check.

Checking CONFIG_SPL_BUILD is incorrect as env_get() is only defined if
CONFIG_$(SPL_TPL)ENV_SUPPORT=y.

Fixes: 985ca3945fa3 ("spl: input: Allow input in SPL and TPL")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	avoid #if

v3:
	use an early return after configuration check
	remove CONFIG_SPL_BUILD check
---
 drivers/input/input.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index a4341e8c7c..743ba89f77 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -669,17 +669,22 @@ int input_stdio_register(struct stdio_dev *dev)
 	int error;
 
 	error = stdio_register(dev);
-#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
-	/* check if this is the standard input device */
-	if (!error && strcmp(env_get("stdin"), dev->name) == 0) {
-		/* reassign the console */
-		if (OVERWRITE_CONSOLE ||
-				console_assign(stdin, dev->name))
-			return -1;
+
+	if (!CONFIG_IS_ENABLED(ENV_SUPPORT))
+		return 0;
+
+	if (!error) {
+		const char *cstdin;
+
+		/* check if this is the standard input device */
+		cstdin = env_get("stdin");
+		if (cstdin && !strcmp(cstdin, dev->name)) {
+			/* reassign the console */
+			if (OVERWRITE_CONSOLE ||
+			    console_assign(stdin, dev->name))
+				return -1;
+		}
 	}
-#else
-	error = error;
-#endif
 
 	return 0;
 }
-- 
2.40.1

