Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D23EF48CA
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 05:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8206983DAE;
	Fri, 13 Feb 2026 06:15:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="D7ZLDCLI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C41D83AA9; Fri, 13 Feb 2026 06:15:21 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6608D83CEE
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 06:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CAB7C110824; Fri, 13 Feb 2026 06:15:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1770959718; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=+oiMQ1Wf0InG+pCsI23T1R6CBkDfegjQTreIUhFmS2I=;
 b=D7ZLDCLIT/sO1amT0oVAvzFpkdKT1WfQYF2WkgUMCKBpA8BdNpP6kblw30KIlBMncmiDXE
 IWfEzda8MXKkVM5XNhrbbG2lRspkpRD459ueS/UDha5C7pZZCyd8xiZe9UYTa79uKYIbn/
 AbGCeeoPkLVavSceStLOZ0xo/eB0J0q8UvDRujrP8/NXtb7y1lKqHn2F0PwqIOem35rHz9
 wCPBP3fKNFUl3NTnGYn0YYTC/AiRX5NX37O2AoJecR4vn5/TNrPGxnaWQfS/22KEszzMtO
 T14MeC+UYXY58HLzRrHUw12qqpSPZbeuQN6PHdr8TNUvjzsQ0kaFRpWuKgYC9A==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Heiko Schocher <hs@nabladev.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] imx8qx: misc: add command for getting boottype
Date: Fri, 13 Feb 2026 06:15:07 +0100
Message-Id: <20260213051507.23466-3-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260213051507.23466-1-hs@nabladev.com>
References: <20260213051507.23466-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

add boottype command, which saves the boot_type
primary (0) or fallback (1) in environment
variable "boottype". If argument "print" is
passed, it also prints the boottype on console.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>

---

Changes in v2:
- add description for the values returned, as suggested from Peng

 arch/arm/mach-imx/imx8/misc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/mach-imx/imx8/misc.c b/arch/arm/mach-imx/imx8/misc.c
index c77104d0338..22d6959f74f 100644
--- a/arch/arm/mach-imx/imx8/misc.c
+++ b/arch/arm/mach-imx/imx8/misc.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
+#include <command.h>
+#include <env.h>
 #include <log.h>
 #include <firmware/imx/sci/sci.h>
 #include <asm/mach-imx/sys_proto.h>
@@ -62,3 +64,34 @@ void build_info(void)
 	printf("Build: SCFW %08x, SECO-FW %08x, ATF %s\n",
 	       sc_commit, seco_commit, (char *)&atf_commit);
 }
+
+int do_boottype(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	sc_misc_bt_t boot_type;
+
+	if (argc > 2)
+		return CMD_RET_USAGE;
+
+	if (sc_misc_get_boot_type(-1, &boot_type) != 0) {
+		puts("boottype cannot be retrieved\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc > 1)
+		printf("Boottype: %d\n", boot_type);
+
+	env_set_ulong("boottype", boot_type);
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(boottype, CONFIG_SYS_MAXARGS, 2, do_boottype,
+	   "save current boot-container in env variable 'boottype'",
+	   "possible values for boottype:\n"
+	   "0: SC_MISC_BT_PRIMARY\n"
+	   "1: SC_MISC_BT_SECONDARY\n"
+	   "2: SC_MISC_BT_RECOVERY\n"
+	   "3: SC_MISC_BT_MANUFACTURE\n"
+	   "4: SC_MISC_BT_SERIAL\n"
+	   "[print] - print current boottype"
+);
-- 
2.20.1

