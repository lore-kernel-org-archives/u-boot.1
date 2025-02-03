Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6EBC02195
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 15:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE65801BE;
	Mon,  3 Feb 2025 16:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MWOqI4Kw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E35EE800D7; Mon,  3 Feb 2025 16:10:50 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A43806C9
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 16:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ECA773FA56
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738595445;
 bh=hGqPd+txiDlpRpkhhXY1F9phfekEwZYJ/VMe8GPaQS4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=MWOqI4KwrzXmC+3YgXlZKAZ2RBeJJVP4F5Afxu5YzrheKR4PxdAsYQ+XjoFuHKkl7
 Q65gfi5A95J4zNFV2XjZStoHkXNx9qGw6gH6Mft3xdw2KeGelVlk4wMqZ7DSbhdZiT
 0dwQQG4D2dFNZwbcud5TnKPewYxrsMJdKYVqi3IM0IlDut/DiX+sRGBVhq3jBcZH/Z
 9esLxp2vG9cNDwGy1UjhYstna8zL/kYBY+Bdu55KFFPej+pg4Zh5h+UZlZUSH2cwMj
 4Amr7P23Rg5CAU1iIT3mPpd4ohbU8ZwexZ02TeIC1AYhiIi3KrGnDMwbjIpXR/Wlal
 pqk9Rs05zJL4A==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361efc9dc6so24101925e9.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 07:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738595443; x=1739200243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGqPd+txiDlpRpkhhXY1F9phfekEwZYJ/VMe8GPaQS4=;
 b=rpqv2LhRaE5llaXy1EiqJ1m2Fb5HHEaiQRgCYG+mC/u1/k0bL8/fMscNtb8EGoiez/
 CB/FlcDrQZSygPyAhXu9LXFY4ue5ZDDhG3yM9d9pCNs9W/q5ToayiQRE0uhMRVdY7ZDj
 XBJ9BqQzPCc3oBx8noB3ar1oheBSJ6oiT1hQYWPFg5fo2+jkBwXleqoXGHwoa1Zw0hBz
 eLo51GQxAamA1qcPkn+u07V6iQ+ZbdUQK19zlrp6IAvkI6AM0CwUXO4bKQVCLHVFrMKb
 7jmdd7wxnfxpWurxKLlKi/4KOMgO688Srp8xAJsIRGNdbr4T8X/x6NdiSEj3zc/LPy/w
 fP0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9lR/WTf17NotcS2/RJ5penDs/vfaTrHPdFwcrfxORL+JkaE7hsid8epL0uCHtSsuCXhW3Pz8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywtdn6aLGEhz6OUnumVak5xjupn4zNfgoK+d28UnEFpO9Lr8Qf5
 LHd3SaUoWqEZO7zWutKTA3zPU2u73HwAOO8r3ovgqDJ7ffOGBMQKjpVOhHn6ovwvB1czYbH4J28
 85ri6UW9okcRERtYd7Y3A7JheSxClYOCp3VqLDNqrIKEsiOYgkPTEQhJe67ref1wCG6k=
X-Gm-Gg: ASbGncsMd93H5BlODDIeh1VUiU8HG7SWifhMvlaRCZEr5+HVMwdWbN47wekIpRZDq8T
 E3rBeF9KyzfVSwZ3OJHlVG1VLb2GC8D9RUqYm7tyk3T69Yb+uROpasnBAd9M0LuyQmRiDhYN4gD
 MUX5NBsmd5W8CAzwYcRN3IDJ//rvDV/UwXMsdxQuucztCjINBlb+K1oXbPArpsC7wvfJZpNfYkj
 Q5XMtIOUurtmxxqBzdVzR7vOhB2oADpEIaAfwblEw94PglzXUaK6wSvjhANE+rXc/+k2ASuZDeH
 cJs2P8GMC6ji/s5glTjIgntNX7H1ERshpZDtBuc=
X-Received: by 2002:a5d:5f44:0:b0:385:e411:c894 with SMTP id
 ffacd0b85a97d-38c520938eemr21259931f8f.43.1738595443520; 
 Mon, 03 Feb 2025 07:10:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7VQcUbf9UIH63ma4F0R/2yEVqc2iN2h4I/5QagiCElbUAOABEFepBz/PM9WI6KnEk8e1xvQ==
X-Received: by 2002:a5d:5f44:0:b0:385:e411:c894 with SMTP id
 ffacd0b85a97d-38c520938eemr21259899f8f.43.1738595443143; 
 Mon, 03 Feb 2025 07:10:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:4aa6:8ee1:4638:a26c:daf2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102f7dsm13235419f8f.30.2025.02.03.07.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 07:10:42 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Massimiliano Minella <massimiliano.minella@se.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 4/4] cmd/setexpr: support concatenation of direct strings
Date: Mon,  3 Feb 2025 16:10:29 +0100
Message-ID: <20250203151029.60265-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250203151029.60265-1-heinrich.schuchardt@canonical.com>
References: <20250203151029.60265-1-heinrich.schuchardt@canonical.com>
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
v3:
	no change
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
index 650fbc8ebee..5e9b577fe36 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -303,7 +303,8 @@ static int setexpr_test_str(struct unit_test_state *uts)
 	memset(buf, '\xff', BUF_SIZE);
 
 	ut_assertok(env_set("fred", "x"));
-	ut_asserteq(1, run_command("setexpr.s fred 0", 0));
+	ut_asserteq(0, run_command("setexpr.s fred 0", 0));
+	ut_asserteq_str("0", env_get("fred"));
 
 	strcpy(buf, "hello");
 	ut_assertok(env_set("fred", "12345"));
@@ -321,6 +322,10 @@ static int setexpr_test_str_oper(struct unit_test_state *uts)
 {
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

