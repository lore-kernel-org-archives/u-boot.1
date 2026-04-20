Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28077F5A8C5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B6B784505;
	Tue, 21 Apr 2026 00:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YcMcsLHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B73B844F4; Tue, 21 Apr 2026 00:08:14 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704F5844E5
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DB4DB40D85; 
 Mon, 20 Apr 2026 22:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776722887;
 bh=0/iQs213IY7C2t9c7xtR5FjFqFW06mSlSrpy5PTDLus=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=YcMcsLHum9trxPKFdqDysl362ozpDLq4ujiIGo0B4Qgfn3FAB4vJ1m2/mGrEF4kJ3
 j5HMPVPSgg2QSe7y2yn7jalsJoCn8BjrWcu4vr5tnnDoarXhqpYkycvQxOPyWA9ZMu
 JD0wCAgs5IfiKzNxAX0hdK1tImy8gO8NurublLjYow8hly2+2/b8fOIo8ue2NHXpYa
 n1Tny8Fil1xpPI+4bIk01ijKShpTjFEe7aE1LPDaNWPfEbvGU52zCqqMJy16yQ4b3R
 5My/X8rx3vz7fQjM5lFO01BQPLKLahH2CnKJaM1e2r5oZSMT69y6b+btRlZQq0jCib
 nVigJJB0qsyhWIaiP2W8xxYPjIMe9jp4yK0l5ypQjewUWwi6nkIBsQhz/rOdhlrk3H
 bPHWY5VgFzrlMQ2Q0hlD3m9/4/txdr4RIvy0GpsU5QPTFLBOW/DISKWevvxy45JcIr
 wA4aEU8x+pCg9dNg4UyjgVZGyOHnmjiRfasdtVCPYd0oLLJlcmI/swoD/fN9dM+HG0
 GzuitGa+qAbThquu1hExH8TCktVFqHQQu3Z2XTKA0NPOGz/hzkyFVdMrDjkdcqFRsP
 mdduZjltbQOFj5cZSBmxtyjNAYKaIKSR2kIF9O9HjBUGNe3TBMN140sB4HXHa8Xhat
 dKgNotj6xdNLXst7KJJUxKLs=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/4] cmd/acpi: add optional index parameter to acpi dump
Date: Tue, 21 Apr 2026 00:08:02 +0200
Message-ID: <20260420220804.71564-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420220804.71564-1-heinrich.schuchardt@canonical.com>
References: <20260420220804.71564-1-heinrich.schuchardt@canonical.com>
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

Add an optional index parameter defaulting to the `acpi dump`
sub-command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/acpi.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/cmd/acpi.c b/cmd/acpi.c
index a88cd995460..3aba9ed7a16 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -12,6 +12,7 @@
 #include <asm/acpi_table.h>
 #include <asm/global_data.h>
 #include <linux/errno.h>
+#include <limits.h>
 #include <dm/acpi.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -51,11 +52,11 @@ static void dump_hdr(struct acpi_table_header *hdr, bool chksums)
 	}
 }
 
-static int dump_table_name(const char *sig)
+static int dump_table_name(const char *sig, ulong idx)
 {
 	struct acpi_table_header *hdr;
 
-	hdr = acpi_find_table(sig, 0);
+	hdr = acpi_find_table(sig, idx);
 	if (!hdr)
 		return -ENOENT;
 	printf("%.*s @ %16lx\n", ACPI_NAME_LEN, hdr->signature,
@@ -183,9 +184,11 @@ static int do_acpi_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	const char *name;
 	char sig[ACPI_NAME_LEN];
+	char *endp;
+	ulong idx = 0;
 	int ret;
 
-	if (argc < 2)
+	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 
 	name = argv[1];
@@ -193,8 +196,12 @@ static int do_acpi_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 		printf("Table name '%s' must be four characters\n", name);
 		return CMD_RET_FAILURE;
 	}
+
+	if (argc >= 3)
+		idx = hextoul(argv[2], &endp);
+
 	str_to_upper(name, sig, ACPI_NAME_LEN);
-	ret = dump_table_name(sig);
+	ret = dump_table_name(sig, idx);
 	if (ret) {
 		printf("Table '%.*s' not found\n", ACPI_NAME_LEN, sig);
 		return CMD_RET_FAILURE;
@@ -207,10 +214,10 @@ U_BOOT_LONGHELP(acpi,
 	"list [-c] - list ACPI tables [check checksums]\n"
 	"acpi items [-d]   - List/dump each piece of ACPI data from devices\n"
 	"acpi set [<addr>] - Set or show address of ACPI tables\n"
-	"acpi dump <name>  - Dump ACPI table");
+	"acpi dump <name> [<index>] - Dump ACPI table instance");
 
 U_BOOT_CMD_WITH_SUBCMDS(acpi, "ACPI tables", acpi_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 2, 1, do_acpi_list),
 	U_BOOT_SUBCMD_MKENT(items, 2, 1, do_acpi_items),
 	U_BOOT_SUBCMD_MKENT(set, 2, 1, do_acpi_set),
-	U_BOOT_SUBCMD_MKENT(dump, 2, 1, do_acpi_dump));
+	U_BOOT_SUBCMD_MKENT(dump, 3, 1, do_acpi_dump));
-- 
2.53.0

