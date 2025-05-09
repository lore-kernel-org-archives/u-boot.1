Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051A4C3ABC9
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 19:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C7928211F;
	Fri,  9 May 2025 21:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="pND4FFCE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCF3E82162; Fri,  9 May 2025 21:04:42 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 by phobos.denx.de (Postfix) with ESMTP id BC7878004F
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 21:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1746817342;
 bh=D/CG2bEhv80vDfz+XLe2EruX2Vvwp7UQomIG+ReKHoY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=pND4FFCEombreYBnv2A4Do/D4hEhF4VEe2X185GZQdMrDp+HVuRlRo2DDCQbXA03B
 uaY9yy4n3xyuduBV+ue+Go0AoTN+1vhRbbKMeRd1vUAQk8w5+w73gjxqD/vBq9jF6L
 KynCMmqTl+oWwW1ppXDXkF1P8pYGy54cfO7SSsaZmIFChSULmJcVWV6lBPMouiahd9
 yI8aYDxIDli8XCoCrvJYAsW+rVUmw+Jci8HfKfa3SkKAcEGc8NWvlwawPzQM0vSHua
 5Ec8c+KIDMevGqD8qx4PJR3AL4SOStgPzYiNZ/ddwopczE6yszzCoKVrpHXGQxnSpM
 nlVuedPJbkcHA==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Venkatesh
 Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH V3 3/3] cmd: env: select: Add output for available environment
 targets
Date: Fri, 9 May 2025 21:00:43 +0200
Message-ID: <20250509190043.28641-4-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20250509190043.28641-1-cniedermaier@dh-electronics.com>
References: <20250509190043.28641-1-cniedermaier@dh-electronics.com>
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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
V2: - Showing available environment targets by parameter "-l"
    - Showing env usage message if env select is called without a target
V3: - Convert the parsing of arguments to getopt()
---
 cmd/nvedit.c  | 18 +++++++++++++++++-
 env/env.c     | 16 ++++++++++++++++
 include/env.h |  7 +++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index e5e89b51e0a..10fd93d4a45 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -504,6 +504,22 @@ static int do_env_load(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_env_select(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
+	struct getopt_state gs;
+	int opt;
+
+	if (!argv[1])
+		return CMD_RET_USAGE;
+
+	getopt_init_state(&gs);
+	while ((opt = getopt(&gs, argc, argv, "l")) > 0) {
+		switch (opt) {
+		case 'l': /* list */
+			return env_select_print_list() ? 1 : 0;
+		default:
+			return CMD_RET_USAGE;
+		}
+	}
+
 	return env_select(argv[1]) ? 1 : 0;
 }
 #endif
@@ -1180,7 +1196,7 @@ U_BOOT_LONGHELP(env,
 	"env load - load environment\n"
 #endif
 #if defined(CONFIG_CMD_NVEDIT_SELECT)
-	"env select [target] - select environment target\n"
+	"env select [-l] [target] - list/select environment target(s)\n"
 #endif
 #if defined(CONFIG_CMD_NVEDIT_EFI)
 	"env set -e [-nv][-bs][-rt][-at][-a][-i addr:size][-v] name [arg ...]\n"
diff --git a/env/env.c b/env/env.c
index dbaeedc3c3b..f94976d4271 100644
--- a/env/env.c
+++ b/env/env.c
@@ -350,6 +350,22 @@ int env_init(void)
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

