Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394B5C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1155984C24;
	Wed,  1 Jul 2026 13:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fid/wfd4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F7D584C24; Wed,  1 Jul 2026 13:47:36 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CA5E84BAA
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7eb42a2f5feso141746a34.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906453; x=1783511253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SL3R9EddxBQ+2ieryAf9p5YiitRESZEYkVzmPhRUCz4=;
 b=fid/wfd4w1jRdHD2sh2kTezfGE9v5cjljPq6v/p7U2QLV5YCIjvshMq//VKVlP/yqu
 JHui8Ux15D19MwPRwyfOpodaDGPXeZQG06jLDmH5KSHrC/3tAgxrW6IjDM5IC7whBITH
 uvLNfgfFR+9YqdDHAp+0KR6Eb9Em/BOgYk6CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906453; x=1783511253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SL3R9EddxBQ+2ieryAf9p5YiitRESZEYkVzmPhRUCz4=;
 b=bjl2NuHniC9ypptfN6HZf52I4AQ/+6rk94Ehe2cGXy7mffuDUt777s5UUhiYJ1Mscb
 I2KHjlRXkAWpyCnaNpjBXKdhDdmKPZeHfqePI1+xdBTTPk/XtDsTjtmgmJHjuXdqBw+v
 zEbgwnaDPJuRe2U2UaQB8QvWBqGf2Mw9xLs3YIF7+ptWpjqVMqPsb8C5ZznBqTtjUD8x
 xe5kktcInbkTGs09K72b32B0S2j31LTK9gGuh/LiaEz3Ys8T54qrd9lQoKo+Z7mGXF5s
 FlWrB/mhzhONfXW7bcGSV2lvZqFmUqLG+mpF9k+MyuLVYTOJh6EXhT5bw5VL30GyOmtv
 lzKw==
X-Gm-Message-State: AOJu0YzFMJ6pdo3eaXegRZRitIofF1rL6nbAadWvMTS/X20nLlUhePyB
 cZVS2mK+bnYE2JKrHJm4PG+GGPk+jCaKfDvYnVRxMhq8dopsisIXQgZRroz51LKzYTQ4cn4xirI
 Hlrw=
X-Gm-Gg: AfdE7cnG663FSPVHIjV0F8svAPX2IJAi7E9grMVM580DU6TAvwO9hSs3bZ+WSW2chsr
 a3Y4P9lUjAvx47WhFq/ddDR6BahH1BvHwk2BUlf/xC7+lAHvSC/toB2NZc0gAhgWi6mcv6fOaM9
 QkxxYYjB4SIJhcLoLgPMXzlUlMKEWDrCJRQtFykvVy0S+quwyuGMBQlF/ZgzGNQD6ffiO5Qufn3
 7JqfRgCtEXtLTpXo/qhYd0PMXPGXEojrqBwLlRuzMrgZ6M/gyDO40Uo/2BKhFeyYBYueNdQLGgW
 5TaEGcoWovPtmSTS10uDEkKlcc4CxgAWUOp+inRcmaGrhB6Ei2/nSQLPxiEUz/9yD414o4ujxcj
 shuRyc2HIHI7iL4gPOU0Tc5cFFBt1vEvYxpzTiTppkp+wQXvW8bhuXwSH3hlKkA52v+tSeJIySL
 emHAPImQ0=
X-Received: by 2002:a05:6808:1789:b0:48a:ddd4:d36f with SMTP id
 5614622812f47-4960ed039b2mr938270b6e.8.1782906453088; 
 Wed, 01 Jul 2026 04:47:33 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:47:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 13/14] cmd: fastboot: Use getopt() for option parsing
Date: Wed,  1 Jul 2026 05:42:33 -0600
Message-ID: <20260701114248.1396125-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701114248.1396125-1-sjg@chromium.org>
References: <20260701114248.1396125-1-sjg@chromium.org>
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

do_fastboot() hand-rolls the same shape as the gnarliest env parsers:
an outer loop over - arguments, an inner while (*++arg) to split
grouped flags, and a goto NXTARG to skip the rest of the element after
-l or -s has consumed the following argument for its address or size.

Replace it with getopt(). do_fastboot() does not use cmdtp or flag, so
move it to the getopt-state command signature, declared with
U_BOOT_CMD_GETOPT(); -l and -s take their arguments from gs->arg. Keep
the + prefix on the optstring so getopt() stops at the first
non-option, exactly as the hand-rolled loop did, and hand the transport
and controller arguments that follow to the do_fastboot_{usb,udp,tcp}()
helpers unchanged via gs->argv[gs->index - 1] (which keeps argv[1]
pointing at the first positional, as before). The - only
controller-index case still falls through to the same error.

CMD_FASTBOOT selects GETOPT so the parser is linked in on boards that
do not already enable it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch to convert fastboot

 cmd/Kconfig    |  1 +
 cmd/fastboot.c | 48 +++++++++++++++++++++---------------------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 9cafeb5d07c..e100a08d271 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1202,6 +1202,7 @@ config CMD_DM
 config CMD_FASTBOOT
 	bool "fastboot - Android fastboot support"
 	depends on FASTBOOT
+	select GETOPT
 	help
 	  This enables the command "fastboot" which enables the Android
 	  fastboot mode for the platform. Fastboot is a protocol for
diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index f3929f88dfa..c780927ac72 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -10,6 +10,7 @@
 #include <console.h>
 #include <g_dnl.h>
 #include <fastboot.h>
+#include <getopt.h>
 #include <net.h>
 #include <usb.h>
 #include <watchdog.h>
@@ -126,41 +127,34 @@ exit:
 	return ret;
 }
 
-static int do_fastboot(struct cmd_tbl *cmdtp, int flag, int argc,
-		       char *const argv[])
+static int do_fastboot(struct getopt_state *gs)
 {
 	uintptr_t buf_addr = (uintptr_t)NULL;
 	size_t buf_size = 0;
+	int argc;
+	char *const *argv;
+	int opt;
 
-	if (argc < 2)
+	if (gs->argc < 2)
 		return CMD_RET_USAGE;
 
-	while (argc > 1 && **(argv + 1) == '-') {
-		char *arg = *++argv;
-
-		--argc;
-		while (*++arg) {
-			switch (*arg) {
-			case 'l':
-				if (--argc <= 0)
-					return CMD_RET_USAGE;
-				buf_addr = hextoul(*++argv, NULL);
-				goto NXTARG;
-
-			case 's':
-				if (--argc <= 0)
-					return CMD_RET_USAGE;
-				buf_size = hextoul(*++argv, NULL);
-				goto NXTARG;
-
-			default:
-				return CMD_RET_USAGE;
-			}
+	while ((opt = getopt(gs, "+l:s:")) > 0) {
+		switch (opt) {
+		case 'l':
+			buf_addr = hextoul(gs->arg, NULL);
+			break;
+		case 's':
+			buf_size = hextoul(gs->arg, NULL);
+			break;
+		default:
+			return CMD_RET_USAGE;
 		}
-NXTARG:
-		;
 	}
 
+	/* Step past the parsed options to the transport/controller args */
+	argc = gs->argc - (gs->index - 1);
+	argv = &gs->argv[gs->index - 1];
+
 	/* Handle case when USB controller param is just '-' */
 	if (argc == 1) {
 		pr_err("Error: Incorrect USB controller index\n");
@@ -183,7 +177,7 @@ NXTARG:
 	return do_fastboot_usb(argc, argv, buf_addr, buf_size);
 }
 
-U_BOOT_CMD(
+U_BOOT_CMD_GETOPT(
 	fastboot, CONFIG_SYS_MAXARGS, 1, do_fastboot,
 	"run as a fastboot usb or udp device",
 	"[-l addr] [-s size] usb <controller> | udp\n"
-- 
2.43.0

