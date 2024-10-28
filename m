Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F81D10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED2FE890D9;
	Mon, 28 Oct 2024 13:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hgRNXdfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14353890C5; Mon, 28 Oct 2024 13:41:52 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23811890CA
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so707253366b.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119309; x=1730724109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcJAJVJiQk6IsZxruzUT8UG9XBl9MiqIP/md3aq3vH0=;
 b=hgRNXdfZieTShesVnMz/wgQUOlVXpR18LntkV0PkD4uJ5EV78FTd7ht3Tdoer4qK/V
 +gkyWr9ptWlLABqbbYo0UItlNiHXLw7iS/VUHCmPW/LW8YJII5lZrRMO4B5hO4i87izl
 npxWJGNHWgUziChAV0n6QwXmJKE3C+IXAOQb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119309; x=1730724109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcJAJVJiQk6IsZxruzUT8UG9XBl9MiqIP/md3aq3vH0=;
 b=nix5bGtqw58QHEOvQJZee+nCftISpgCO2tAQPe6xSGPcGdaHmaixo87xLEGa/aFguG
 pVRze7gvdaQ05j8QVI9TC4p7UiyebNnwq4OF93+AmptomkfCl033TBeFkQXeaD863Hoi
 Q5P/85LpcqYNn/EVMIhLt0P7WUdKIWuhq1w+IxflcUX0ZsrJq3UXJfr1a0p03lyLHriZ
 fhlSaOiQq8xfxL4wy6k0h67bwXydvmt3oRkPi4qwFsiYs9MBEYxgWU0miZA5SBsDkJTp
 v+t8/BIYG1IEVrW99TAFmU4LD+XDSFwkB6j+WwIuoKtO8SJEpucpk7slFR5F9ykEWM9a
 nHAw==
X-Gm-Message-State: AOJu0YxQePJQD/A1z28kokk969FR5HBWAGmw7o7My+yJSpjx7Yn2Oynj
 IW5Aj/W6++68K3mh+fVbT9/L7E8uQvV+4NDWUg/+reYN+e+5IuqX95xSBg4zI0Cykn4PWSs5nq+
 74Q==
X-Google-Smtp-Source: AGHT+IEN61szqQ0qMWptbSrCRq8st1ZwlTbPFBp3ruGLHfqYrE6FQ2mIGvSOwUBIR09cLeYGlEEb3w==
X-Received: by 2002:a17:907:7fa5:b0:a86:94e2:2a47 with SMTP id
 a640c23a62f3a-a9de5cea1f7mr716137666b.15.1730119309059; 
 Mon, 28 Oct 2024 05:41:49 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/21] command: test: Move into the cmd suite
Date: Mon, 28 Oct 2024 13:41:13 +0100
Message-ID: <20241028124130.32072-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

The command test was the very first test written in U-Boot, some 12
years ago. It predates the unit-test subsystem and was never converted
over.

There is no particular need for the command test to have its own
command. It is also confusing to have it separate from the normal test
suites. At present this test is not run in CI.

Move it into the cmd suite instead, updating it to become a unit test.
One of the checks is dropped to avoid an error.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd/command.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/test/cmd/command.c b/test/cmd/command.c
index 2b8d28d7ae3..77800687ec3 100644
--- a/test/cmd/command.c
+++ b/test/cmd/command.c
@@ -10,13 +10,14 @@
 #include <log.h>
 #include <string.h>
 #include <linux/errno.h>
+#include <test/cmd.h>
+#include <test/ut.h>
 
 static const char test_cmd[] = "setenv list 1\n setenv list ${list}2; "
 		"setenv list ${list}3\0"
 		"setenv list ${list}4";
 
-static int do_ut_cmd(struct cmd_tbl *cmdtp, int flag, int argc,
-		     char *const argv[])
+static int command_test(struct unit_test_state *uts)
 {
 	char long_str[CONFIG_SYS_CBSIZE + 42];
 
@@ -72,8 +73,12 @@ static int do_ut_cmd(struct cmd_tbl *cmdtp, int flag, int argc,
 	assert(run_commandf("'") == 1);
 
 	assert(run_commandf("env %s %s", "delete -f", "list") == 0);
-	/* Expected: "Error: "list" not defined" */
-	assert(run_commandf("printenv list") == 1);
+	/*
+	 * Expected: "## Error: "list" not defined"
+	 * (disabled to avoid pytest bailing out)
+	 *
+	 * assert(run_commandf("printenv list") == 1);
+	 */
 
 	memset(long_str, 'x', sizeof(long_str));
 	assert(run_commandf("Truncation case: %s", long_str) == -ENOSPC);
@@ -93,12 +98,10 @@ static int do_ut_cmd(struct cmd_tbl *cmdtp, int flag, int argc,
 	/* Clean up before exit */
 	run_command("env default -f -a", 0);
 
+	/* put back the FDT environment */
+	ut_assertok(env_set("from_fdt", "yes"));
+
 	printf("%s: Everything went swimmingly\n", __func__);
 	return 0;
 }
-
-U_BOOT_CMD(
-	ut_cmd,	5,	1,	do_ut_cmd,
-	"Very basic test of command parsers",
-	""
-);
+CMD_TEST(command_test, 0);
-- 
2.43.0

