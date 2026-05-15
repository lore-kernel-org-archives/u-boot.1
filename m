Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B3DCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42E978484C;
	Fri, 15 May 2026 22:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=l4re.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=l4re.org header.i=@l4re.org header.b="vlRmsb4x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3DC184855; Fri, 15 May 2026 22:47:35 +0200 (CEST)
Received: from os.inf.tu-dresden.de (os.inf.tu-dresden.de [141.76.48.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1E898483C
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=l4re.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=adam@l4re.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=l4re.org;
 s=mx; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 Content-Transfer-Encoding:References:In-Reply-To:Reply-To:Content-ID:
 Content-Description; bh=CtBlBAzeQS24KDHhooAEFPROFGXdqvP1CTQ+KkO/XK4=; b=vlRms
 b4xQ6kfMBiqPGZqAWNXoLdCWOM2po31d6mR98I6h4meJP6d7hvF6KZ3YOLsOLpxFUfGmWyVMWsd5w
 lE9FnldwlBOhaMoxnviIIZEbHrI9t39d90tiyj/8zbxjBJFl642h1umdNSk3d1Vozjj1LQvey7VyI
 PCTf764QKBjfUmVGQpq7jSwfTQS3a4HYcBqdFgpf48QSYCOo1YDf32xtoPq4eODe471JE5VtOFcVh
 sZjB9wb8t373w3CX0nXf9sI/ZQallIySG2OqIiBa7P+g1qdvmwS3wk/XWh6bdV6sOaHuyKzOZiZFA
 5HBcLIrvTjSy8a3BC6jc+/E7cjDog==;
Received: from erwin.inf.tu-dresden.de ([141.76.48.80]
 helo=os.inf.tu-dresden.de)
 by os.inf.tu-dresden.de with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256) (Exim
 4.99.3) id 1wNzRV-000000012Pt-1qa2; Fri, 15 May 2026 22:47:33 +0200
Date: Fri, 15 May 2026 22:47:30 +0200
From: Adam Lackorzynski <adam@l4re.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] common/command.c: Avoid NULL pointer use in
 cmd_auto_complete
Message-ID: <ageGYp5K7a2hanTC@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)
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

Avoid using ps_prompt having a NULL pointer. For that, use the same
approach as in uboot_cli_readline().

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Adam Lackorzynski <adam@l4re.org>
---
 common/command.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/common/command.c b/common/command.c
index 0f9dd06d72b..eb2c2123534 100644
--- a/common/command.c
+++ b/common/command.c
@@ -367,11 +367,15 @@ int cmd_auto_complete(const char *const prompt, char *buf, int *np, int *colp)
 	int i, j, k, len, seplen, argc;
 	int cnt;
 	char last_char;
-#ifdef CONFIG_CMDLINE_PS_SUPPORT
-	const char *ps_prompt = env_get("PS1");
-#else
-	const char *ps_prompt = CONFIG_SYS_PROMPT;
-#endif
+	const char *ps_prompt;
+
+	if (IS_ENABLED(CONFIG_CMDLINE_PS_SUPPORT)) {
+		ps_prompt = env_get("PS1");
+
+		if (!ps_prompt)
+			ps_prompt = CONFIG_SYS_PROMPT;
+	} else
+		ps_prompt = CONFIG_SYS_PROMPT;
 
 	if (strcmp(prompt, ps_prompt) != 0)
 		return 0;	/* not in normal console */
-- 
2.53.0

