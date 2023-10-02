Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651C6E776CE
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 22:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D33786E07;
	Tue,  3 Oct 2023 00:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="icZ9i7Jh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCCC286E07; Tue,  3 Oct 2023 00:27:37 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C11B86D62
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 00:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 68E343F227; 
 Mon,  2 Oct 2023 22:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696285652;
 bh=hti1+fgqZNCUplLTPJsE7qCkdmGcTYvShUtoi9dhmVM=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=icZ9i7Jh1F4uKfQNv6wHdLZ/ERVqRpEDlgNQzGYE3zWHWC3xmHehnOfsvpaRyzT3o
 ggHFu+SrK19tAK3a191YED1G0hz4n2OhQcRq80ONTDPO7JhcgkP3VyCt1SZPq0PU/0
 T2dkA/R1eneWQqbyHnmKb+iA7VyKs2Eg1ErvlmRyBh6XWIIKHKvyj0JLB41q4/mhgX
 H1n2WpBRA6sb4n6ZnJGljbXvjRCwU+wFl0vmjacx1GnAIO6xCpDxRKYmD62wGVvbv1
 e4626QtPh4kr78O4v9lTyK5OzqvnQy7ZxUg21lTZexH8lNbq6qRcuFcOqf/9MkOvoe
 y2/gPpj/4vTRw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@google.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] input: avoid NULL dereference
Date: Tue,  3 Oct 2023 00:27:25 +0200
Message-Id: <20231002222725.25125-1-heinrich.schuchardt@canonical.com>
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Avoid #if.
---
 drivers/input/input.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index a4341e8c7c..de62189782 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -669,17 +669,19 @@ int input_stdio_register(struct stdio_dev *dev)
 	int error;
 
 	error = stdio_register(dev);
-#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
-	/* check if this is the standard input device */
-	if (!error && strcmp(env_get("stdin"), dev->name) == 0) {
-		/* reassign the console */
-		if (OVERWRITE_CONSOLE ||
-				console_assign(stdin, dev->name))
-			return -1;
+	if ((IS_ENABLED(SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)) &&
+	    !error) {
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

