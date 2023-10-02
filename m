Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10088E74901
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 17:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F91386D82;
	Mon,  2 Oct 2023 19:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Euy+9xka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE5886DD1; Mon,  2 Oct 2023 19:26:26 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FFDA84003
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 19:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4DE723F708; 
 Mon,  2 Oct 2023 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696267583;
 bh=nbb0HeaJzTRYNQFd55H8YztNMEAOaUK1cL3aTjAwdvI=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=Euy+9xkaBCYzSyOpRXezsP0NJNKqzqgXzPPqDCr/pvKMza964h0uSK6hzLXndi6MV
 bD+vdcH64qeAYUmx9Z2wX5XJMQ4PiQrASWNNrTym2o7qYe8etB9knTI1AoqANexbai
 pk4UHuMfJHIMb6VR3RMYYxhOnnZb8+E4F3H0H8TK2dR1o5XlCozIjuxpliQhJa7krX
 eSb8DGHsS5AGlfgNJcf4nU23hvSare+rqZEQJ89xvM9ctoxbUXj/PEyehPmaXqCwE3
 YD7puHTNqVINIzcEPqQAT+bq8Cc8wVNyvPTLDBMcRXuwB4gCA7TkOptr5kDwhJKdZ7
 qk1Oek7AzlAwg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] input: avoid NULL dereference
Date: Mon,  2 Oct 2023 19:26:14 +0200
Message-Id: <20231002172614.11162-1-heinrich.schuchardt@canonical.com>
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

Use attribute __maybe unused instead of dummy assignment.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/input/input.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index a4341e8c7c..2330b21f71 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -666,19 +666,22 @@ int input_init(struct input_config *config, int leds)
 
 int input_stdio_register(struct stdio_dev *dev)
 {
-	int error;
+	__maybe_unused int error;
 
 	error = stdio_register(dev);
 #if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
-	/* check if this is the standard input device */
-	if (!error && strcmp(env_get("stdin"), dev->name) == 0) {
-		/* reassign the console */
-		if (OVERWRITE_CONSOLE ||
-				console_assign(stdin, dev->name))
-			return -1;
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
 #endif
 
 	return 0;
-- 
2.40.1

