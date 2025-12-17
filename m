Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE74D65C7D
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 16:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20DC883B99;
	Wed, 17 Dec 2025 17:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 571F283BBE; Wed, 17 Dec 2025 17:24:07 +0100 (CET)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [185.125.25.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B3BC83B99
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 17:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dWfJ511c4zVh2;
 Wed, 17 Dec 2025 17:24:05 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dWfJ44KghzLM7; Wed, 17 Dec 2025 17:24:04 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 17 Dec 2025 17:23:56 +0100
Subject: [PATCH 1/3] cmd: bdinfo: provide long help with all options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-b4-bdinfo-doc-v1-1-83bf7fdb1691@cherry.de>
References: <20251217-b4-bdinfo-doc-v1-0-83bf7fdb1691@cherry.de>
In-Reply-To: <20251217-b4-bdinfo-doc-v1-0-83bf7fdb1691@cherry.de>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 cmd/bdinfo.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

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

-- 
2.52.0

