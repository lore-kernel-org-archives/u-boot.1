Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7138E7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 15:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC4D7803CB;
	Sat, 21 Dec 2024 16:14:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hyQoXJSv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED04803E0; Sat, 21 Dec 2024 16:14:48 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B4A8803B5
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 16:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AA3A63F47A
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1734794084;
 bh=Pd9gvG59Y91Lvmr4RnFji2QRzotGYO6YYnStpztmpQM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hyQoXJSv7DSEzz7HNRMw75bxarDVUQJuds3T7493ugHNF0zhEsoBtSvVhTAZRY0tG
 DfmUUryDT5MmqLYi+iyieRreFZqXIENbD45IakwFcCenaf49jKLdodz8plNeIcJtGW
 x8SPuFoyPR26ikr2ORB9K6ZH2V2xE0ZJ0eFdjI9V2npTMfFsh7j11a56I4Bf5lSSoI
 vQkPTiFCJ4paCA/Ji4QYQIvTo1wLQ45hmCnaEbTLtHgjNk1fdGqyAc5UeHb4JqeiaX
 WUZkNVqq0tONAqAiv6GxZmZzOye8z7wobdQeAJobv9lLAbWQGXDHrv4Fnt9ZLxRDxM
 FhJmo8uUA00TA==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3878ad4bf8cso1745360f8f.1
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 07:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734794084; x=1735398884;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pd9gvG59Y91Lvmr4RnFji2QRzotGYO6YYnStpztmpQM=;
 b=IMUEYrpqaBX59Vmw3oGsE7YEZ1ihqjdF5q4dcBZ1jT2nq3XBfsGL4wMfEKc+5wwIjO
 jwQonz2LcrCiXnb+NeVGzH1EIpxpQl7YytVEVdV0oefXKAWQhMwzVjg55YS4BjCe68cm
 ie2Pid3pZN68UoBkqAvdvNbTd1JvNJ4wcU+l+gCrTfb7WsavwEwU3A0tDOKp6NFbIzWY
 NED0qdQj2zVMrFhqu9uCUmvX3e6EvGaKFDLYLbkxM9vjCOvhf2G2ZngJa5GgWP9uuLlp
 nexkEn6h5DhFJERs9wP5b+ztXkTOFFxIu5a4BcCYpJ7FJZQ9FDNm1qpF97WwY8s8FtSs
 dpyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUodQ3O8p/a/MkvWiNLolnlFwgLtGhg2DCRkR1bOfiUmM4D1iuaYvlVXOdv3FZjnaJnxJW9aNw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5k2s6HAapgwhQmptm2hfdRyWD5fLda/H0BNDF4rLj6hO9wII/
 /bLk2AGu5UOK5TUdz88pnN1dILkhF1vulOQEhJAksEj6wAAiJFjgMhseOb6ES+XQ/Y/P6Dyyv9w
 wpAkqnH+bfxq7PftlY9ypMb6TxvS5bNwUq0AeKaG6JPHcSNP5ptNSihk3eYohONAolqk=
X-Gm-Gg: ASbGncu7/AKZVmrPbJ7duUbbaLWJg1Doygo0Zfq5Fw9Q1K0arIzWeSXlVqca3tod/yM
 7Efn7KUK5iqPMV4ulPVhfPXIauWe6zPaFJGO77Qox3/Rll8RHcXzb6W8qdnLGkWR8QlEwkHFbu9
 IpbocGTk0p/a1Dxttal+82ySLNn4NS3TOBtuKgqBwIhC1/o5o6+FU89rg6s/g+1r6aPA6NojOCv
 ZuMYNsIQWftrLiJsBHw+Ul4h6ajYiwNv9YN5NA5qVJlA+mwZOmMq8XV81xkBygNeiTfZNTFKWyp
 vv9GySZ9zXI=
X-Received: by 2002:a5d:5e09:0:b0:385:fb8d:8658 with SMTP id
 ffacd0b85a97d-38a223ffbf0mr7476825f8f.40.1734794084102; 
 Sat, 21 Dec 2024 07:14:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5qFtQK3qcvP3wDRhnf5iHcH5uwi1RLb+T/wXujsJpA6eP352BgPqeDCmiBBPLNy1zvXbZHA==
X-Received: by 2002:a5d:5e09:0:b0:385:fb8d:8658 with SMTP id
 ffacd0b85a97d-38a223ffbf0mr7476802f8f.40.1734794083655; 
 Sat, 21 Dec 2024 07:14:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:7955:43d4:28:a60b:2a9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c833149sm6642421f8f.39.2024.12.21.07.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Dec 2024 07:14:41 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Massimiliano Minella <massimiliano.minella@se.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd/setexpr: support concatenation of direct strings
Date: Sat, 21 Dec 2024 16:14:35 +0100
Message-ID: <20241221151435.43825-1-heinrich.schuchardt@canonical.com>
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

Up to now the setexpr command only supported concatenating string provided
by reference. Allow directly passing stings.

With this patch

    setexpr.s foo '1' + '3'

sets variable $foo to the value '13'.

Update the unit test for "setexpr.s fred 0".

Add a new unit test for "setexpr.s fred '1' + '3'".

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

