Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD342C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84ACB84C1B;
	Wed,  1 Jul 2026 13:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H18gulCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A96984BBD; Wed,  1 Jul 2026 13:47:31 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5456384C1B
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-448df16ab34so168090fac.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906448; x=1783511248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVFWzApbZWl2JdH7owo78O/ZTXO+XVS0dCyqU91j9is=;
 b=H18gulCNR1/6CGYMQkzqfovSrPz7jXZEnzHoXKhW7Zq3S8FfAD/EgFwBZtQ55N0hTe
 EzrWOuIAMMnWmd0r6lBtm83rdfeh/78kVAhx0EvpAULP+BPMxjKP583lQxUWlrJtxkt7
 qwaQ2cIrlDqi1tYRG/h4QJGWWEF0MPDMkG/c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906448; x=1783511248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rVFWzApbZWl2JdH7owo78O/ZTXO+XVS0dCyqU91j9is=;
 b=aKxqQzTnIKK0T5q9BTlRWIgd0eC9AxTS/Tf+lQLgh2JkbGQdqoQ7vnz4Zurcr2bvne
 YBk+uuLAGhdULcXNnZ524nhUeSLCfYnIV/WHeN+A+E0PlfP0uxfA7cGtIB26vG7/3s1F
 HuMD9DUoBGeiTTsjU3m5619VFfR+L8vtGQBtc3TY9Q5rQffioBD47/1K3hZrnRwfoMAj
 jVJHoTzfp78m1uibCNeYHnar28qQMXodz8UiCUr5VoxMIRrXYpASy2xlPY77QJxm4bap
 +G+pC/et0xPcvMpScct8i7UpSqzZEM151tybQG1waddeX+T1+t9h/pPt7Td4v1NsREOM
 FHag==
X-Gm-Message-State: AOJu0YxQ+LYT6UxPiSZjYFdP7MucAV/EWePUe7gYob/ukAaQa2KkAK5f
 gkne5IbGhKIZsmXh+mETC+3C0spcSXt2ebRV5cYbwKTCXzE/1+/esyfX0aeWzHlS6voonS1jILs
 Bxjc=
X-Gm-Gg: AfdE7cns7pQuo5q2/W8FwA1axwP5VhlQs1dzjAgUCwSrIB9mwMZBxscaDSPlxS6Olyq
 bgpu57TrRsaIr8h/YfVU1wvbSHj/W305OlWrowFBxC5ajoqpj5d8V5D9Foyqt/VlbASk/voKdNm
 UGzt2Fwp9EPUso4eYcJg0fzzJowzp9mwgDfz+TCfcIRKneJcrTXkm730cXRxP4kZzPwF7qsqxss
 yu8jAYL9wxIzcQIc+p5PUOIuyDjWIbpl0RpULaO5FVEMruRBM43rzTDYZdMqfR/E4K/QevOVNqD
 nwvo3Ye5xFwTeP5JGxJRTld9yQYBK6X+y28EYE4VbKFE6vF0CbfnWvjJS0ElT0SfWtVQlrQenq5
 +msojamIPwkDiUBu6fhWi9aI52fGyihGJi+u2y5T+GVDWrjERHs9Q47gzXBwYnry29DynM/Yax5
 aFMj3LmQT9x2+ELwEdHw==
X-Received: by 2002:a05:6808:1301:b0:486:4212:d728 with SMTP id
 5614622812f47-4960efede5dmr915324b6e.43.1782906447961; 
 Wed, 01 Jul 2026 04:47:27 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:47:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 11/14] cmd: nvedit: Use getopt() in env import
Date: Wed,  1 Jul 2026 05:42:31 -0600
Message-ID: <20260701114248.1396125-12-sjg@chromium.org>
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

do_env_import() is the other gnarly hand-rolled parser in nvedit.c, and
walks each - argument by hand, opens an inner while (*++arg) to split
grouped flags and tracks an fmt counter to reject a second -b/-c/-t.

Replace the parser with getopt(). Move do_env_import() to the
getopt-state command signature, declared with U_BOOT_CMD_MKENT_GETOPT().
Move the format-flag mutual-exclusion check after the option loop and
read the trailing positional list from gs->argv[gs->index].

Keep the + prefix on the optstring so getopt() stops at the first
non-option, exactly as the hand-rolled loop did. This matters here: the
size positional can be a literal - (meaning no size, rely on the '\0'
termination), which the permuting parser would otherwise consume. The
behaviour is otherwise unchanged; keep the messages and the
size/checksum handling as-is.

CMD_IMPORTENV selects GETOPT so the parser is linked in on boards that
do not already enable it.

Leave the himport_r() interface unchanged for now. It would benefit
from an API rethink at some point, since passing argc/argv is a bit
clunky now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Update commit message to mention himport_r()

 cmd/Kconfig  |  1 +
 cmd/nvedit.c | 67 ++++++++++++++++++++++++++--------------------------
 2 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index e3d92055f17..842afa2f390 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -711,6 +711,7 @@ config CMD_EXPORTENV
 config CMD_IMPORTENV
 	bool "env import"
 	default y
+	select GETOPT
 	help
 	  Import environments.
 
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index c74898a05fb..95d53ba5c32 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -760,8 +760,7 @@ sep_err:
  *		the environment at address 'addr'. Without arguments, the whole
  *		environment gets imported.
  */
-static int do_env_import(struct cmd_tbl *cmdtp, int flag,
-			 int argc, char *const argv[])
+static int do_env_import(struct getopt_state *gs)
 {
 	ulong	addr;
 	char	*cmd, *ptr;
@@ -772,40 +771,42 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 	int	crlf_is_lf = 0;
 	int	wl = 0;
 	size_t	size;
+	int	argc;
+	char	*const *argv;
+	int	opt;
 
-	cmd = *argv;
+	cmd = gs->argv[0];
 
-	while (--argc > 0 && **++argv == '-') {
-		char *arg = *argv;
-		while (*++arg) {
-			switch (*arg) {
-			case 'b':		/* raw binary format */
-				if (fmt++)
-					goto sep_err;
-				sep = '\0';
-				break;
-			case 'c':		/* external checksum format */
-				if (fmt++)
-					goto sep_err;
-				sep = '\0';
-				chk = 1;
-				break;
-			case 't':		/* text format */
-				if (fmt++)
-					goto sep_err;
-				sep = '\n';
-				break;
-			case 'r':		/* handle CRLF like LF */
-				crlf_is_lf = 1;
-				break;
-			case 'd':
-				del = 1;
-				break;
-			default:
-				return CMD_RET_USAGE;
-			}
+	while ((opt = getopt(gs, "+bcdrt")) > 0) {
+		switch (opt) {
+		case 'b':		/* raw binary format */
+			sep = '\0';
+			fmt++;
+			break;
+		case 'c':		/* external checksum format */
+			sep = '\0';
+			chk = 1;
+			fmt++;
+			break;
+		case 't':		/* text format */
+			sep = '\n';
+			fmt++;
+			break;
+		case 'r':		/* handle CRLF like LF */
+			crlf_is_lf = 1;
+			break;
+		case 'd':
+			del = 1;
+			break;
+		default:
+			return CMD_RET_USAGE;
 		}
 	}
+	if (fmt > 1)
+		goto sep_err;
+
+	argc = gs->argc - gs->index;
+	argv = &gs->argv[gs->index];
 
 	if (argc < 1)
 		return CMD_RET_USAGE;
@@ -1079,7 +1080,7 @@ static struct cmd_tbl cmd_env_sub[] = {
 	U_BOOT_CMD_MKENT(grep, CONFIG_SYS_MAXARGS, 1, do_env_grep, "", ""),
 #endif
 #if defined(CONFIG_CMD_IMPORTENV)
-	U_BOOT_CMD_MKENT(import, 5, 0, do_env_import, "", ""),
+	U_BOOT_CMD_MKENT_GETOPT(import, 5, 0, do_env_import, "", ""),
 #endif
 #if defined(CONFIG_CMD_NVEDIT_INDIRECT)
 	U_BOOT_CMD_MKENT(indirect, 3, 0, do_env_indirect, "", ""),
-- 
2.43.0

