Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE926C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 21:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9F7F80C1C;
	Tue, 25 Aug 2026 21:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37kWccdlScMO; Tue, 25 Aug 2026 21:34:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787693681;
	bh=zZ6LCtUpwF4QxkMRMzh6TV7ObQe8AbZZKet5XbaYHco=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lmW39VUf/Dl1CG9PsNEdcmItBhspsri7NRzFX5T5YPr6ETRhg8w6PIYq48RGHDK23
	 2DXb+zQbJDyujeCg/rK8+gBRkeSspWjx80MsC0uYFAuCaAqt0DFo0OR6OFuIOCjRA9
	 33Vj8jMheVAjjuPxcam/DsMbZDrtJZ9vk5j4AeDp1E8owWuRIDRzS/+oKsnDzbmPUp
	 DhmK/Fap3nw6OYIdYq/ScveYJ/wKWuTl58MZ8pl33gqoiCMj24qgxwMFSIkmuzz5cq
	 KTC/tnmYcdoy+U1Rh21QxR8uiVKIjlJ7dFIBru8bBYqqyYMrVIiFuaf/E4+kFqF/Mg
	 g8sCBOXSOrQhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4DBC80C0C;
	Tue, 25 Aug 2026 21:34:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3AD2396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A98994008B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EVYjuuEScjN7 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 21:34:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=efT097Qe
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 225BA40055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:34:38 +0000 (UTC)
Received: from LT2ubnt (dynamic-176-006-060-003.176.6.pool.telefonica.de
 [176.6.60.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7F44D415D2; 
 Tue, 25 Aug 2026 21:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787693675;
 bh=zZ6LCtUpwF4QxkMRMzh6TV7ObQe8AbZZKet5XbaYHco=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=efT097Qe0NP5m03FRGkFMepgie/K9nSwVWMHdg4/k2vmQoTrl9vg3bEzcN34aOFLk
 KHye1jVDiAD/YaXNwe8tJV35gWxdN4AKxifB5uGM8FEDhqoxQawQxOnGAOR+j2Nvtd
 X1CwUidm6ohzT8ZDrU6djSU74f0egY9cjRdjDAsDms5rC5HUNGT3KWH71I/ZawGdEW
 5twEz+1zDKbxoSokzAXvcqy33AHD/DuelJLVij4YvmwXmi/SCpMluhzqYQ65sbS322
 Z/LpwndGmARZC5uJV5o04+7E7Oof5qW4G2YVFOm879bwdfXkiJLccOrGtdmKZUBpUD
 Oa1irh0Z16awPfKvFA3kVbQVe3BfSsZpF23NF+KmWsTN70WYX9IV0fH02716JkDE6x
 JGv+EN3z1nFnCfrM/2dtzgMeH297c6wpgLir0unFvm6gh4ksPIZ7GH4mJ9qAzrBLHL
 5r2NXnV8LHcrApzRiS8YcJRKJPCyj/eQnl9VBBWduIZRf2/33Mw8phBgPdld/oDLw2
 Ouoz1awYq1r53PwIOZnlVaoyqtE2LmMQCxeYGe66ArVsLdQDSNMP1ZfjR2fQN9Zu2C
 Pm5PfV/Nyzl16kLii+HQhcSYanT9hA7MLmG/RDJZOb6eOWJOJ5xxkBv39nK9bc+Ew6
 wAl26gVvzuC5E2r0ExGlX5fA=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd/host: allow to retrieve sequence number for label
Date: Tue, 25 Aug 2026 23:34:28 +0200
Message-ID: <20260825213428.123317-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

When binding a host device the assigned sequence number depends on which
host device sequence numbers or unused. Only the label is well known.

This sequence number is used in most other commands. For reliable
scripting and testing it is therefore necessary to retrieve the sequence
number for the label.

Add a variant of the `host info` command with a variable name.
Write the sequence number for the label to the variable.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/host.c             | 5 +++++
 doc/usage/cmd/host.rst | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/cmd/host.c b/cmd/host.c
index 47a59f5ff20..51f2b1e3f6e 100644
--- a/cmd/host.c
+++ b/cmd/host.c
@@ -5,6 +5,7 @@
 
 #include <command.h>
 #include <dm.h>
+#include <env.h>
 #include <fs.h>
 #include <part.h>
 #include <sandbox_host.h>
@@ -175,6 +176,9 @@ static int do_host_info(struct cmd_tbl *cmdtp, int flag, int argc,
 			return CMD_RET_FAILURE;
 	}
 
+	if (argc >= 3)
+		return env_set_hex(argv[2], dev_seq(dev));
+
 	printf("%3s %12s %6s %-15s %s\n",
 	       "dev", "blocks", "blksz", "label", "path");
 	if (dev) {
@@ -264,6 +268,7 @@ U_BOOT_CMD(
 	"     -r = mark as removable\n"
 	"host unbind <label>     - unbind file from \"host\" device\n"
 	"host info [<label>]     - show device binding & info\n"
+	"host info <label> <var> - write device number to variable\n"
 	"host dev [<label>]      - set or retrieve the current host device\n"
 	"host commands use the \"hostfs\" device. The \"host\" device is used\n"
 	"with standard IO commands such as fatls or ext2load"
diff --git a/doc/usage/cmd/host.rst b/doc/usage/cmd/host.rst
index 672d8f2112b..21ad0c955c2 100644
--- a/doc/usage/cmd/host.rst
+++ b/doc/usage/cmd/host.rst
@@ -14,6 +14,7 @@ Synopsis
     host bind [-r] <label> [<filename>]
     host unbind <label|seq>
     host info [<label|seq>]
+    host info <label|seq> <varname>
     host dev [<label|seq>]
 
 Description
@@ -61,6 +62,9 @@ host info
 
 Provides information about a particular host binding, or all of them.
 
+If a variable name <varname> is provided, the sequence number is written to
+the variable and no output is written to the console.
+
 
 host dev
 ~~~~~~~~
-- 
2.53.0

