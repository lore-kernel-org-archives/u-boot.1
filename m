Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8D3C83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 17:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55A9683669;
	Fri, 18 Jul 2025 19:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="e7kc/WVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2A4E83678; Fri, 18 Jul 2025 19:12:21 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 by phobos.denx.de (Postfix) with ESMTP id B548C834B6
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 19:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1752858460;
 bh=iec9RvdyGi9uT/tEDfzXVbP56aRYdMeb48Q+GnCUwI8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=e7kc/WVh53o2x14kdNvG3XbG9xWIFkwlJB63QUq1XBgB5B4Zvcmv2c8CYJtLqL1lZ
 hRaCfirzvuV1JmIhWpLexs7uee2Hm9SI5GCmuCmKFr7gG5stHvHrBviyYYlB4PMzzD
 buRpfo1ypwIo9tPSbjG5FXUnUx7Jev+4OG8UR5agtX0DU/hDJ28VoCwOb+8k6oDLT1
 mCxjlivV/fkKDgQrBNEfWyRYxf7gQEnyW/Dybcw3sB3/hUcHvlqWB3Ta7XNo/+pyBS
 GUZH66RsiP6gdTLpwFMSKO48rGg3LwiecXcDu+nA7AM/y+4YUUL7ojNW3EPf5MH+/V
 ujng9N8XpzS8g==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Casey Connolly
 <casey.connolly@linaro.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Varadarajan Narayanan
 <quic_varada@quicinc.com>, =?UTF-8?q?Vincent=20Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH V5 4/4] cmd: env: select: Add output for available environment
 targets
Date: Fri, 18 Jul 2025 19:06:02 +0200
Message-ID: <20250718170602.10746-5-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20250718170602.10746-1-cniedermaier@dh-electronics.com>
References: <20250718170602.10746-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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

Add parameter "-l" for printing available environment targets. The
active target is marked with an asterisk. This is done by adding
the function env_select_print_list().

If "env select" is called without a target parameter the result is
"Select Environment on <NULL>: driver not found". Replace this not
so useful output by showing the env usage message instead.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: "Vincent Stehlé" <vincent.stehle@arm.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
---
V2: - Showing available environment targets by parameter "-l"
    - Showing env usage message if env select is called without a target
V3: - Convert the parsing of arguments to getopt()
V4: - No changes
V5: - No changes
---
 cmd/nvedit.c  | 18 +++++++++++++++++-
 env/env.c     | 16 ++++++++++++++++
 include/env.h |  7 +++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 945db536bf2..604ce71f269 100644
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
index 7a9c96b4078..fb55215254c 100644
--- a/env/env.c
+++ b/env/env.c
@@ -353,6 +353,22 @@ int env_init(void)
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

