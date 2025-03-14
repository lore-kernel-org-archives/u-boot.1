Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFBDC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 13:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3182881CC5;
	Fri, 14 Mar 2025 14:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xHEIvT93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83DCC81D65; Fri, 14 Mar 2025 14:57:36 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A6A780F9C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=f-akthar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52EDvWqk1695781
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 14 Mar 2025 08:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741960652;
 bh=SdTgS3FnrFSzgHDuyNTz4eddH+FYzzSrmVJKXWnwrSg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xHEIvT93PMxafMKZ5uLmWFNZc9x56Zyt53VDwb5ixFaV1Ix3UY/qxY+8+VE2cGrtW
 4nBg+F9tXd0TmOno5kJd4t/xsDd/iNDN6Gxik1PwezdkZp/wxhbwvuUxRv4kb3ZUEb
 EzODTcgYNM3YHpDJwHdSSvaP2JlmoOjnK82cPumE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52EDvW0n114885;
 Fri, 14 Mar 2025 08:57:32 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 08:57:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 08:57:31 -0500
Received: from localhost (fayaz-hp-z2-tower-g4-workstation.dhcp.ti.com
 [172.24.227.181] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52EDvUs9049311;
 Fri, 14 Mar 2025 08:57:31 -0500
From: Harsha Vardhan V M <h-vm@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>
Subject: [RFC PATCH v2 3/5] cmd: fuse: Add fuse writebuff sub-system command
Date: Fri, 14 Mar 2025 19:27:04 +0530
Message-ID: <20250314135706.184807-4-h-vm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314135706.184807-1-h-vm@ti.com>
References: <20250314135706.184807-1-h-vm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Add CMD_FUSE_WRITEBUFF config option to add and enable fuse writebuff
sub-system command. Add fuse_writebuff function to be invoked on
writebuff command.

Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig    |  8 ++++++++
 cmd/fuse.c     | 26 ++++++++++++++++++++++----
 include/fuse.h |  9 +++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index cd391d422ae..81c59becc2d 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1236,6 +1236,14 @@ config CMD_FUSE
 	  which control the behaviour of the device. The command uses the
 	  fuse_...() API.
 
+config CMD_FUSE_WRITEBUFF
+	bool "Support for the fuse writebuff"
+	depends on CMD_FUSE
+	help
+	  This allows programming fuses, which control the behaviour of
+	  the device, using a structured buffer in memory. The command
+	  uses the fuse_writebuff() API.
+
 config CMD_GPIO
 	bool "gpio"
 	help
diff --git a/cmd/fuse.c b/cmd/fuse.c
index 9f489570634..2d53e6bf2c4 100644
--- a/cmd/fuse.c
+++ b/cmd/fuse.c
@@ -43,9 +43,14 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 	argc -= 2 + confirmed;
 	argv += 2 + confirmed;
 
-	if (argc < 2 || !(str2long(argv[0], (ulong *)&bank)) ||
-			!(str2long(argv[1], (ulong *)&word)))
-		return CMD_RET_USAGE;
+	if (IS_ENABLED(CONFIG_CMD_FUSE_WRITEBUFF) && !strcmp(op, "writebuff")) {
+		if (argc != 1 || !(str2long(argv[0], &addr)))
+			return CMD_RET_USAGE;
+	} else {
+		if (argc < 2 || !(str2long(argv[0], (ulong *)&bank)) ||
+				!(str2long(argv[1], (ulong *)&word)))
+			return CMD_RET_USAGE;
+	}
 
 	if (!strcmp(op, "read")) {
 		if (argc == 2)
@@ -153,6 +158,15 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 			if (ret)
 				goto err;
 		}
+	} else if (IS_ENABLED(CONFIG_CMD_FUSE_WRITEBUFF) && !strcmp(op, "writebuff")) {
+		printf("Programming fuses using a structured buffer in memory "
+				"starting at addr 0x%lx\n", addr);
+		if (!confirmed && !confirm_prog())
+			return CMD_RET_FAILURE;
+
+		ret = fuse_writebuff(addr);
+		if (ret)
+			goto err;
 	} else {
 		return CMD_RET_USAGE;
 	}
@@ -178,5 +192,9 @@ U_BOOT_CMD(
 	"fuse prog [-y] <bank> <word> <hexval> [<hexval>...] - program 1 or\n"
 	"    several fuse words, starting at 'word' (PERMANENT)\n"
 	"fuse override <bank> <word> <hexval> [<hexval>...] - override 1 or\n"
-	"    several fuse words, starting at 'word'"
+	"    several fuse words, starting at 'word'\n"
+#ifdef CONFIG_CMD_FUSE_WRITEBUFF
+	"fuse writebuff [-y] <addr> - program fuse data\n"
+	"    using a structured buffer in memory starting at 'addr'\n"
+#endif /* CONFIG_CMD_FUSE_WRITEBUFF */
 );
diff --git a/include/fuse.h b/include/fuse.h
index 4519821af7e..902b5f56a74 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -12,6 +12,7 @@
 #define _FUSE_H_
 
 #include <linux/types.h>
+#include <linux/errno.h>
 
 /*
  * Read/Sense/Program/Override interface:
@@ -25,5 +26,13 @@ int fuse_read(u32 bank, u32 word, u32 *val);
 int fuse_sense(u32 bank, u32 word, u32 *val);
 int fuse_prog(u32 bank, u32 word, u32 val);
 int fuse_override(u32 bank, u32 word, u32 val);
+#ifdef CONFIG_CMD_FUSE_WRITEBUFF
+int fuse_writebuff(ulong addr);
+#else
+static inline int fuse_writebuff(ulong addr)
+{
+	return -EPERM;
+}
+#endif	/* CONFIG_CMD_FUSE_WRITEBUFF */
 
 #endif	/* _FUSE_H_ */
-- 
2.34.1

