Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2C1D6ACED
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 11:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF89A83DA7;
	Thu, 18 Dec 2025 12:44:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26D7683C54; Thu, 18 Dec 2025 12:44:52 +0100 (CET)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AF2083D5D
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 12:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dX83P5bqCzH5g;
 Thu, 18 Dec 2025 12:44:49 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dX83P1kNFzcqy; Thu, 18 Dec 2025 12:44:49 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 18 Dec 2025 12:44:41 +0100
Subject: [PATCH v2 1/3] cmd: bdinfo: provide long help with all options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-bdinfo-doc-v2-1-2fb328750026@cherry.de>
References: <20251218-b4-bdinfo-doc-v2-0-2fb328750026@cherry.de>
In-Reply-To: <20251218-b4-bdinfo-doc-v2-0-2fb328750026@cherry.de>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Document the bdinfo -a, -e and -m options in the long help, but only
when they can be used. The string concatenation is a bit odd with two
newlines, but it does render properly once in U-Boot CLI.

Tested-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 cmd/bdinfo.c      | 16 +++++++++++++++-
 test/cmd/bdinfo.c | 11 +++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 09fe8067642..f36c6123ca7 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -212,5 +212,19 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 U_BOOT_CMD(
 	bdinfo,	2,	1,	do_bdinfo,
 	"print Board Info structure",
-	""
+// Long help prepended with command's name, and `bdinfo` is a valid command
+	"\n"
+#if CONFIG_IS_ENABLED(GETOPT)
+	"bdinfo -a\n"
+#endif
+	"  - print all Board Info structure"
+#if CONFIG_IS_ENABLED(GETOPT)
+	"\n"
+#if IS_ENABLED(CONFIG_NET) || IS_ENABLED(CONFIG_NET_LWIP)
+	"bdinfo -e\n"
+	"  - print Board Info related to network\n"
+#endif
+	"bdinfo -m\n"
+	"  - print Board Info related to DRAM"
+#endif
 );
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 2ba57edc685..5112c399931 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -254,6 +254,17 @@ static int bdinfo_test_help(struct unit_test_state *uts)
 		ut_assert_nextline_empty();
 		ut_assert_nextlinen("Usage:");
 		ut_assert_nextlinen("bdinfo");
+		if (CONFIG_IS_ENABLED(GETOPT))
+			ut_assert_nextlinen("bdinfo -a");
+		ut_assert_nextlinen("  - print all Board Info structure");
+		if (CONFIG_IS_ENABLED(GETOPT)) {
+			if (IS_ENABLED(CONFIG_NET) || IS_ENABLED(CONFIG_NET_LWIP)) {
+				ut_assert_nextlinen("bdinfo -e");
+				ut_assert_nextlinen("  - print Board Info related to network");
+			}
+			ut_assert_nextlinen("bdinfo -m");
+			ut_assert_nextlinen("  - print Board Info related to DRAM");
+		}
 	}
 	ut_assert_console_end();
 

-- 
2.52.0

