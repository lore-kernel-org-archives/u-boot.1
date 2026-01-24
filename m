Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53115D715CA
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 05:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7861D83BB1;
	Sat, 24 Jan 2026 06:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="adSP+1cf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B351839DF; Sat, 24 Jan 2026 06:51:05 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B5A683BB1
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 06:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CC69010F100; Sat, 24 Jan 2026 06:51:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769233862; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=GqVenm7JfiMNX1gYR56EfBAPSL5x3ObaGQQs1qc8hIQ=;
 b=adSP+1cfoi9RE6SaUz/t/cP/V3CTBztWliss4gkscrNo8tnqzYHLDS9nQAi404+bAIfz2+
 2Yb4mL8IINjVyMvq5PR88WKCHXI7KRFf+P2T6VZDhJOunw4kPHzQEVkZXpWCCO9zmJmf81
 4HT+2IVTgiadSgDTETUnqKn4wNGHH2U93ckxTYTbdJ0U9FnMT2mx6PAYg0/OwH+hKUgXrt
 TvpGirDOeSNRp/8y2WMOO6xnOAm1R05w4xvC4wn2wSFdYICD3TXGHNSnEe+xkhxvFBNNF4
 mxPYZ32sV8J3E9HmBhWya4+HpBYhBGtjBqT2YDYE/P1+vrYW6wWRiLEeLXYccA==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] imx8qx: misc: add command for getting boottype
Date: Sat, 24 Jan 2026 06:50:44 +0100
Message-Id: <20260124055044.8149-3-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260124055044.8149-1-hs@nabladev.com>
References: <20260124055044.8149-1-hs@nabladev.com>
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

 arch/arm/mach-imx/imx8/misc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-imx/imx8/misc.c b/arch/arm/mach-imx/imx8/misc.c
index c77104d0338..f233432f608 100644
--- a/arch/arm/mach-imx/imx8/misc.c
+++ b/arch/arm/mach-imx/imx8/misc.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
+#include <command.h>
+#include <env.h>
 #include <log.h>
 #include <firmware/imx/sci/sci.h>
 #include <asm/mach-imx/sys_proto.h>
@@ -62,3 +64,28 @@ void build_info(void)
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
+	   "[print] - print current boottype"
+);
-- 
2.20.1

