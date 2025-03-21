Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D29C36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 18:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3579F808A2;
	Fri, 21 Mar 2025 19:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="Z4/Vj4OL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DAE1809A4; Fri, 21 Mar 2025 19:45:37 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 by phobos.denx.de (Postfix) with ESMTP id ECF4B806D8
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 19:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1742582723;
 bh=JNAkx9LtRQhxqcZGysmAl82e7tRYE3FogoFY517688w=;
 h=From:To:CC:Subject:Date:From;
 b=Z4/Vj4OLQLpKr4YwH2MW1qjmrKlXKZ2ECDj0hq76AlVku870aegCxYqBzu11iXCto
 2BtxdjIFJ1dpCIFDbRzxY3ShcZtqWZvrB0ppfCxB4tzGh1MBF7wTreqdMgDnXDcOSb
 J51wz3EUUSYK6akOlwATMb8OX5bUXp1NBU7sqA5MHStLrih2T12BnwbHUW4NKORYMl
 U4w8i7BiptIjnIj92pB6BkIob0z2SBk8tmLe1urK1AskR1RzOlverNuKI9btxGAoDU
 CxqaezFOSGSk1+UH0rskLdRowijzodDuOitDzw9oNIcq6TftWiagyW0GmbjXme6afa
 BBivuhmXQpr9A==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Marek Vasut
 <marex@denx.de>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH V2] cmd: env: select: Add output for available evironment
 targets
Date: Fri, 21 Mar 2025 19:43:57 +0100
Message-ID: <20250321184357.4079845-1-cniedermaier@dh-electronics.com>
X-klartext: yes
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add parameter "-l" for printing available environment targets. The
active target is marked with an asterisk. This is done by adding
the function env_select_print_list().

If "env select" is called without a target parameter the result is
"Select Environment on <NULL>: driver not found". Replace this not
so useful output by showing the env usage message instead.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Marek Vasut <marex@denx.de>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Tom Rini <trini@konsulko.com>
---
V2: - Showing available environment targets by parameter "-l"
    - Showing env usage message if env select is called without a target
---
 cmd/nvedit.c  | 19 ++++++++++++++++++-
 env/env.c     | 16 ++++++++++++++++
 include/env.h |  7 +++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 1f259801293..de64094db4d 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -499,6 +499,23 @@ static int do_env_load(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_env_select(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
+	if (!argv[1])
+		return CMD_RET_USAGE;
+
+	while (argc > 1 && **(argv + 1) == '-') {
+		char *arg = *++argv;
+
+		--argc;
+		while (*++arg) {
+			switch (*arg) {
+			case 'l': /* list */
+				return env_select_print_list() ? 1 : 0;
+			default:
+				return CMD_RET_USAGE;
+			}
+		}
+	}
+
 	return env_select(argv[1]) ? 1 : 0;
 }
 #endif
@@ -1189,7 +1206,7 @@ U_BOOT_LONGHELP(env,
 	"env load - load environment\n"
 #endif
 #if defined(CONFIG_CMD_NVEDIT_SELECT)
-	"env select [target] - select environment target\n"
+	"env select [-l] [target] - list/select environment target(s)\n"
 #endif
 #if defined(CONFIG_CMD_NVEDIT_EFI)
 	"env set -e [-nv][-bs][-rt][-at][-a][-i addr:size][-v] name [arg ...]\n"
diff --git a/env/env.c b/env/env.c
index bcc189e14db..c73b53a2c62 100644
--- a/env/env.c
+++ b/env/env.c
@@ -347,6 +347,22 @@ int env_init(void)
 	return ret;
 }
 
+int env_select_print_list(void)
+{
+	struct env_driver *drv;
+	int prio;
+
+	printf("Available Environment targets:\n");
+	for (prio = 0; (drv = env_driver_lookup(ENVOP_INIT, prio)); prio++) {
+		if (gd->env_load_prio == prio)
+			printf("* ");
+		else
+			printf("  ");
+		printf("%s\n", drv->name);
+	}
+	return 0;
+}
+
 int env_select(const char *name)
 {
 	struct env_driver *drv;
diff --git a/include/env.h b/include/env.h
index 01c3eeae7e2..4553c7bc109 100644
--- a/include/env.h
+++ b/include/env.h
@@ -286,6 +286,13 @@ int env_save(void);
  */
 int env_erase(void);
 
+/**
+ * env_select_print_list() - Print available environment targets
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int env_select_print_list(void);
+
 /**
  * env_select() - Select the environment storage
  *
-- 
2.30.2

