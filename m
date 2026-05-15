Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F607CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 140618486D;
	Fri, 15 May 2026 22:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M2XVjqK2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C5C8486D; Fri, 15 May 2026 22:33:51 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D26408483F
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso227905a34.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778877227; x=1779482027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uz1GGs6xG2mxBM5mMa5jZ3tgQsjYqpGEVRQ7+XZJiy0=;
 b=M2XVjqK2RUIC1Ijq+hlYzuLfAdybG8tb+qJNUFNOAI6umc3vEWUB5WyuLl5xNRSuVy
 ILxJ5EFSFrmtXlM6NxASfWEAbk5aOr5U2fdcfSj1ISvaR8cOmWGvAmBNdP7NXJ0S08I2
 rR4hzAsO2AqZD4mY4LEzm9mh65/BcJmPz9v/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778877227; x=1779482027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uz1GGs6xG2mxBM5mMa5jZ3tgQsjYqpGEVRQ7+XZJiy0=;
 b=fDIlfHLRRJw0+vRAQOGJV3fIQl9LhYdUxOb4nKO0lf+GkH9HJ1sexIwfFeBLdvPona
 TJpofxB00KM4PUfoTxVIrJCwuXOgY0nqhGZ60swOM0jFkDm5iQu+pP1MXjt8hDNqCsCi
 2b33kBlG1P3K9sXlzTeaxi9ejK0HJ2J80KqLKjx8Jtyiv81JnyMu+Q9e53rILAa0SoCe
 HsB8N8jvKa7Wk/W4v1pb4mvZ6HqeNYZ6QOFjrfoC7otCSMJ1p9vUXcv54zf91hnz/oxI
 DtBTOTO6vVEZwIrvkgEtcFwqr+yKZHoZGLxz8eHi48XQPeJtj6eeOkMN3EjB40z9TyqL
 1gug==
X-Gm-Message-State: AOJu0YzZL5+6Zjf/28ZJcQuY6wcRJXQi/eSpE0sjOkzeKZfNLA2nXdYg
 O5k+XaMuHdCMfA7x4e3pHoNaQ5YRr5MbsU/djVoI3dw5cIKD4zmjMbBulwfxw+2Ugg10y5LXuPv
 SS0tbZA==
X-Gm-Gg: Acq92OFIJkEPnDhsidjFtriXsI7paAABq4k/VIjOkreQvz9v9PPYZVsyG4AtJRlF5Vv
 GadSx4i4s37FWzMKYeYZ0WsbLiWxZzLiJFwCjR1/mVlB0+FNS6s8nQLpIHYdVGdty1ir09+1GiH
 /KkVMI2KwWsCoXWWuxDjv6EdphGd+lQLSSKAGXit3tYKLsBx5UaEWnlU/5cnI0qBvKucCQCb50s
 Xzd/SQPHd2rOyFo2qa3agpVwFPU867JUUh4mwYqC4BbH09reEY3A9/63N0tpcbHiTFlUzOTNLE4
 6STdkt1KVdKOp/CYVxt337YtN71Upv5SgfMA4/CVTJoeYPxE29A93cp5CP9XCMJzJ6aHqaGHz0N
 bR6Us1BsDCDVnFmFLV1TfbZlMTeVVVYOSgKM3mGQeNfT8OuTYVpcrOnpkfTU7wXbHf76r1nB/Dv
 c3xkm6YGePksAP7pa/PI6ULk4+Z7ST
X-Received: by 2002:a9d:4f15:0:b0:7dc:e43f:4b31 with SMTP id
 46e09a7af769-7e3f14c8d19mr4112390a34.12.1778877226747; 
 Fri, 15 May 2026 13:33:46 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm2414906a34.12.2026.05.15.13.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:33:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 08/11] cmd: hash: Use getopt() for option parsing
Date: Fri, 15 May 2026 14:32:59 -0600
Message-ID: <20260515203311.2555651-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515203311.2555651-1-sjg@chromium.org>
References: <20260515203311.2555651-1-sjg@chromium.org>
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

The open-coded check for -v only matches it as the first argument, so
'hash sha256 -v 0 4 <expected>' treats -v as the algorithm name and
fails. Replace with getopt(), which also lets -v appear anywhere in the
command line.

Guard the option-parsing loop with IS_ENABLED(CONFIG_HASH_VERIFY) so it
is compiled out when verification is disabled. After parsing,
getopt_pop() pulls the algorithm off the positional list, strlower()
normalises it, and the tail is forwarded to hash_command() unchanged.

CMD_HASH selects GETOPT so the parser is linked in on boards that did
not already enable it.

Tweak the var declarations to use Reverse Christmas Tree.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig |  1 +
 cmd/hash.c  | 37 +++++++++++++++++++++----------------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 709696c3c41..eb7c85c1fe9 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2798,6 +2798,7 @@ config CMD_BLOB
 
 config CMD_HASH
 	bool "Support 'hash' command"
+	select GETOPT
 	select HASH
 	help
 	  This provides a way to hash data in memory using various supported
diff --git a/cmd/hash.c b/cmd/hash.c
index 96d0e443a5b..566bb617328 100644
--- a/cmd/hash.c
+++ b/cmd/hash.c
@@ -11,8 +11,9 @@
 
 #include <command.h>
 #include <env.h>
+#include <getopt.h>
 #include <hash.h>
-#include <linux/ctype.h>
+#include <linux/string.h>
 
 #if IS_ENABLED(CONFIG_HASH_VERIFY)
 #define HARGS 6
@@ -23,25 +24,29 @@
 static int do_hash(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
 {
-	char *s;
 	int flags = HASH_FLAG_ENV;
+	struct getopt_state gs;
+	char *algo;
 
-	if (argc < 4)
-		return CMD_RET_USAGE;
+	getopt_init_state(&gs, argc, argv);
+	if (IS_ENABLED(CONFIG_HASH_VERIFY)) {
+		int opt;
 
-#if IS_ENABLED(CONFIG_HASH_VERIFY)
-	if (!strcmp(argv[1], "-v")) {
-		flags |= HASH_FLAG_VERIFY;
-		argc--;
-		argv++;
+		while ((opt = getopt(&gs, "v")) > 0) {
+			if (opt != 'v')
+				return CMD_RET_USAGE;
+			flags |= HASH_FLAG_VERIFY;
+		}
 	}
-#endif
-	/* Move forward to 'algorithm' parameter */
-	argc--;
-	argv++;
-	for (s = *argv; *s; s++)
-		*s = tolower(*s);
-	return hash_command(*argv, flags, cmdtp, flag, argc - 1, argv + 1);
+
+	/* Need at least: algorithm address count */
+	if (gs.nonopts < 3)
+		return CMD_RET_USAGE;
+
+	algo = strlower(getopt_pop(&gs));
+
+	return hash_command(algo, flags, cmdtp, flag,
+			    gs.nonopts, &gs.args[gs.index]);
 }
 
 U_BOOT_CMD(
-- 
2.43.0

