Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A599DE77197
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 10:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C878036D;
	Sun,  5 Jan 2025 11:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FNfcxoK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD63803DC; Sun,  5 Jan 2025 11:46:46 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 136D3800B2
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 11:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C9F763F2C6; 
 Sun,  5 Jan 2025 10:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1736074003;
 bh=AplhalHblOMuxxzXEZRS9wzLh8vtPgGcGTA191XX0YA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=FNfcxoK9gY5OGy5lcXYp8oPHMRcpf+U2EMd+l/De5TF3Rd2+IpuKCR/dxrxlh+by9
 6mwvn/k2WoXbpil3J3T5/T24CXqGgy8wochMAmCc58MCHXtZ9ulI16KEQLf+HaeOI2
 PvBbHmuDDazeIrSqac+6JlTcxYdlMEqP8jZJWRRqOqzrzvyp+gBC2wLFQ7tO7zwshB
 N2gSUTUAqdEpYJBACN9Hhi7l7GhkG367+rRV+ZDbdE8MilK3+n55uXLupT6DD+Bsg0
 rD58Ei9/Q2qhTsTjeprllzGytQodfXA4P8Pqyq90mkb/eBY0ebpaaWMACZvpDtaYuh
 Iex3TJgiZvUXg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Massimiliano Minella <massimiliano.minella@se.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] cmd/setexpr: support concatenation of direct strings
Date: Sun,  5 Jan 2025 11:46:14 +0100
Message-ID: <20250105104614.7916-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

The setexpr.s command allows to concatenate two strings.

According to the description in doc/usage/cmd/setexpr.rst the parameters
value1 and value2 can be either direct values or pointers to a
memory location holding the values.

Unfortunately `setexpr.s <value1> + <value2>` fails if any of the values
is a direct value. $? is set to false.

* Add support for direct values in setexpr.s.
* Correct the unit test for "setexpr.s fred 0".
* Add a new unit test for "setexpr.s fred '1' + '3'" giving '13'.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Update the commit message to indicate that a bug is corrected.
---
 cmd/setexpr.c      | 54 ++++++++++++++++++++++++++++++++--------------
 test/cmd/setexpr.c |  7 +++++-
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/cmd/setexpr.c b/cmd/setexpr.c
index e111b8ba98a..c45fa85c887 100644
--- a/cmd/setexpr.c
+++ b/cmd/setexpr.c
@@ -35,9 +35,37 @@ struct expr_arg {
 	};
 };
 
+/**
+ * arg_set_str() - copy string to expression argument
+ *
+ * The string is truncated to 64 KiB plus NUL terminator.
+ *
+ * @p:		pointer to string
+ * @argp:	pointer to expression argument
+ * Return:	0 on success, -ENOMEM if out of memory
+ */
+static int arg_set_str(void *p, struct expr_arg *argp)
+{
+	int len;
+	char *str;
+
+	/* Maximum string length of 64 KiB plus NUL terminator */
+	len = strnlen((char *)p, SZ_64K) + 1;
+	str = malloc(len);
+	if (!str) {
+		printf("Out of memory\n");
+		return -ENOMEM;
+	}
+	memcpy(str, p, len);
+	str[len - 1] = '\0';
+	argp->sval = str;
+	return 0;
+}
+
 static int get_arg(char *s, int w, struct expr_arg *argp)
 {
 	struct expr_arg arg;
+	int ret;
 
 	/*
 	 * If the parameter starts with a '*' then assume it is a pointer to
@@ -47,8 +75,6 @@ static int get_arg(char *s, int w, struct expr_arg *argp)
 		ulong *p;
 		ulong addr;
 		ulong val;
-		int len;
-		char *str;
 
 		addr = hextoul(&s[1], NULL);
 		switch (w) {
@@ -66,18 +92,10 @@ static int get_arg(char *s, int w, struct expr_arg *argp)
 			break;
 		case CMD_DATA_SIZE_STR:
 			p = map_sysmem(addr, SZ_64K);
-
-			/* Maximum string length of 64KB plus terminator */
-			len = strnlen((char *)p, SZ_64K) + 1;
-			str = malloc(len);
-			if (!str) {
-				printf("Out of memory\n");
-				return -ENOMEM;
-			}
-			memcpy(str, p, len);
-			str[len - 1] = '\0';
+			ret = arg_set_str(p, &arg);
 			unmap_sysmem(p);
-			arg.sval = str;
+			if (ret)
+				return ret;
 			break;
 		case 4:
 			p = map_sysmem(addr, sizeof(u32));
@@ -93,9 +111,13 @@ static int get_arg(char *s, int w, struct expr_arg *argp)
 			break;
 		}
 	} else {
-		if (w == CMD_DATA_SIZE_STR)
-			return -EINVAL;
-		arg.ival = hextoul(s, NULL);
+		if (w == CMD_DATA_SIZE_STR) {
+			ret = arg_set_str(s, &arg);
+			if (ret)
+				return ret;
+		} else {
+			arg.ival = hextoul(s, NULL);
+		}
 	}
 	*argp = arg;
 
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 21a3268bd81..00d373f35ae 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -310,7 +310,8 @@ static int setexpr_test_str(struct unit_test_state *uts)
 	ut_assertok(env_set("fred", "x"));
 	start_mem = ut_check_free();
 	strcpy(buf, "hello");
-	ut_asserteq(1, run_command("setexpr.s fred 0", 0));
+	ut_asserteq(0, run_command("setexpr.s fred 0", 0));
+	ut_asserteq_str("0", env_get("fred"));
 	ut_assertok(ut_check_delta(start_mem));
 
 	ut_assertok(env_set("fred", "12345"));
@@ -335,6 +336,10 @@ static int setexpr_test_str_oper(struct unit_test_state *uts)
 	ulong start_mem;
 	char *buf;
 
+	/* Test concatenation of strings */
+	ut_assertok(run_command("setexpr.s fred '1' + '3'", 0));
+	ut_asserteq_str("13", env_get("fred"));
+
 	buf = map_sysmem(0, BUF_SIZE);
 	memset(buf, '\xff', BUF_SIZE);
 	strcpy(buf, "hello");
-- 
2.47.1

