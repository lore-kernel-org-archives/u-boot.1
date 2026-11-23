Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F955606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DtQUQaWE;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=pM5LFAgv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A997405D2;
	Mon, 23 Nov 2026 18:19:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YSbJbXcS6t0h; Mon, 23 Nov 2026 18:19:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA905405DC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795457992;
	b=RDyA0EsoohJZnCkLLfzBsKP7q9xOYDTw3PQA668242XlbxO12F+qD+BwXnX8ufBffGD+
	 asqBFXd1dUG/HWj536kabMuBNNAQ/1+46ePEdfaSdjLKAxs9Ft/Qswj3u1IzmTeTHxtCb
	 h+ePRPKvE9LQQ0DMKfnrrtDmyaxN/JkWM6w0H1aardfEVvDGebHN4PprH1tl0bUU4+rUD
	 0wDDcu+DfWyjs8ZohvtZqd5aJ+zJ8e8Yqbd7H8IdIGmw1uEFwvp5HR6RfugAR8WdiXr2H
	 edkqnx2kEBjQChsKPkwS9iJEoz0p/ofJyWXMaHf1IuGtZBoX9OHBHUHJk+NmWEGm/IA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795457992;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=X3Uwu2eo8XtCCZ6KYSk+jHXdcWHZc1VuSbGKCfkvGtk=;
	b=eSQq/yFAjUmK+7j/+tUYcl2fjIN5DktNf90N+6ZOqyrNjE7GhGZMnfWYKpf4jRWjmdIY
	 Fk2ZaUKiHsPElTELSdhdUsIuQW4UE/+t1PtU5fz4uj+MBk632vAbYK+G+QMvJGFdAvBAr
	 H5/nFw+ej/arrVRS4xWub5KrCOzRDG+sqsdJ5fAGL4OK3WIdBpaYRkQRFUQpsOD/BXQl/
	 YRgJKBB9dBpCyqFnONvAvwib5OFn1b/yNvhKDAChU8CIgauNVBcw9yBKGXo1+mGlnzDPx
	 4JANGxd6wd9fUZNoCgn/y5JDyXCPVcLaX+hM0WBDroS6/iGyjr1I1BhojsCDkWpEDwg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795457992;
	bh=X3Uwu2eo8XtCCZ6KYSk+jHXdcWHZc1VuSbGKCfkvGtk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DtQUQaWE97gHqBmCz76/ayL/Fzlm9Bq1q5WKIzVl3NVXPzC2SsZ00Pu1jOCS9xi2j
	 aDVtX0FifUpOGv0j3UG8JdK68ZanD4D190HuTa6Zud29agertY+Jd9nQFFbLNkCUe+
	 jayMqElAgOZQJFoiDG6pVIXeVmJKTg7Q0Oxlf3U/elxa38xDHS4p6ZLQKMy9O9vmhH
	 0B1oupWxm1ukrrIUx/03GrEuTFbZ0Uldor9rG680uwXQnaamGu4u+xEMf38r+OJAot
	 uS5pR+ij/c+7F1Tp+OeSfWq+ZKSxpP5OZVRPehc6+PegrajKKZl3uFaQE+3T/EiVeP
	 RvvxVOmpRI+7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA905405DC;
	Mon, 23 Nov 2026 18:19:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 37612715
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:19:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 294CC605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:19:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XqaG-bbC5791 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:19:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4056D605EC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=pM5LFAgv
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4056D605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:19:49 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jYDkC2KGHz8tyM;
 Mon, 23 Nov 2026 19:19:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795457987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=X3Uwu2eo8XtCCZ6KYSk+jHXdcWHZc1VuSbGKCfkvGtk=;
 b=pM5LFAgvXPY8dEUQpg8S8yLUfkwxlr/8HDF1Y1rTih004A60CNRXXwi+X7IWHSCHE3FwYd
 QxPkchxKDu3eIHhLMeeQoQV8BGVUrWhQWz/mmVTh9coc2ipFKcqTfSBfeeAChJhElTiOvs
 6UsVNZf2XiJ+UYjuMFIdmLfpe7V67zEfVUnV59Z4wCa0iheSaG9tP90WpyW9ve/qVQm9i+
 V4ZwM8xZ/TL8/TXaFylfdm3yN7xWrsVbirQxecuwmTlFChDapJSTDD6xoxrsc5ckCHPs53
 Eg3vVDmpJCP/Or8zoWUchi5BVY+eu0k5+ld+0ZaCG/Nmn1pGM3VTLpRpJWpKxg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: scmi: Add scmi impl subcommand
Date: Mon, 23 Nov 2026 19:19:09 +0100
Message-ID: <20261123181945.168890-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 204906ebfa33a556203
X-MBO-RS-META: 4fm5s3q4k5kqfqb83u3uye937bzeywsf
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add "scmi impl" subcommand which stores the version of SCMI
implementation in U-Boot environment variable. This can be
used to script SCMI version specific quirks in U-Boot env
or boot scripts.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Michal Simek <michal.simek@amd.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 cmd/scmi.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/cmd/scmi.c b/cmd/scmi.c
index 72549745ffd..b3fc1cfd9d8 100644
--- a/cmd/scmi.c
+++ b/cmd/scmi.c
@@ -7,6 +7,7 @@
  */
 
 #include <command.h>
+#include <env.h>
 #include <exports.h>
 #include <scmi_agent.h>
 #include <scmi_agent-uclass.h>
@@ -425,6 +426,35 @@ static int do_scmi_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+/**
+ * do_scmi_impl() - get the implementation version of SCMI
+ *
+ * @cmdtp:	Command table
+ * @flag:	Command flag
+ * @argc:	Number of arguments
+ * @argv:	Argument array
+ *
+ * Get the implementation version of SCMI and store it into environment variable.
+ *
+ * Return:	CMD_RET_SUCCESS on success, CMD_RET_RET_FAILURE on failure
+ */
+static int do_scmi_impl(struct cmd_tbl *cmdtp, int flag, int argc,
+			char * const argv[])
+{
+	struct udevice *agent;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	agent = get_agent();
+	if (!agent)
+		return CMD_RET_FAILURE;
+
+	env_set_hex(cmd_arg1(argc, argv), scmi_impl_version(agent));
+
+	return CMD_RET_SUCCESS;
+}
+
 /**
  * do_scmi_set_dev() - set access permission to device
  *
@@ -602,6 +632,8 @@ static int do_scmi_reset(struct cmd_tbl *cmdtp, int flag, int argc,
 static struct cmd_tbl cmd_scmi_sub[] = {
 	U_BOOT_CMD_MKENT(info, CONFIG_SYS_MAXARGS, 1,
 			 do_scmi_info, "", ""),
+	U_BOOT_CMD_MKENT(impl, CONFIG_SYS_MAXARGS, 1,
+			 do_scmi_impl, "", ""),
 	U_BOOT_CMD_MKENT(perm_dev, CONFIG_SYS_MAXARGS, 1,
 			 do_scmi_set_dev, "", ""),
 	U_BOOT_CMD_MKENT(perm_proto, CONFIG_SYS_MAXARGS, 1,
@@ -644,6 +676,7 @@ U_BOOT_LONGHELP(scmi,
 	" - SCMI utility\n"
 	" info [-v] - get the info of SCMI services\n"
 	"   - -v ... print verbose information\n"
+	" impl <varname> - store implementation version in variable\n"
 	" perm_dev <agent-id in hex> <device-id in hex> <flags in hex>\n"
 	"   - set access permission to device\n"
 	" perm_proto <agent-id in hex> <device-id in hex> <protocol-id in hex> <flags in hex>\n"
-- 
2.53.0

