Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463DBC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3847F87E45;
	Thu,  8 Feb 2024 15:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YEKX1xTJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CF6487E4B; Thu,  8 Feb 2024 15:59:50 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A77EF878F4
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimiliano.minella@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33b5cdbbe4dso139795f8f.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 06:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707404386; x=1708009186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qj/lo36OTDkzta7TTxxUVGPIhEVVehlXL+Wumk1noFs=;
 b=YEKX1xTJNkTZ8wJkmIEUIliOea9XwygMjg4Ug9Tyla2UQU5zRd/9QtnQWIXHa1r2Xt
 EKnwaLk7DqSl3FlF/p1kc7Rj85NIFm+YOwDTNhjzoBz1gDqT9dHGyr6/dzROphVNfXHE
 z8bS6etE+jXjPW1Os0pkB8DzFp3YS50BZ8VQF+JR7YO0VxW3hPmXuKbhsI3gvKfZm6Kf
 DI7hk69d87WpeW3I1cpaAkn/hkcejEGuuAxm5LUpKr7AADuvpo6DVbV4r2WLUJNY7BB/
 MuaUz4u3IONodeTY/bo6qVMvq0gyBIKDAI3D7pWP1XKdA/WE34dhYp2OurXOp/EXDjSG
 TlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707404386; x=1708009186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qj/lo36OTDkzta7TTxxUVGPIhEVVehlXL+Wumk1noFs=;
 b=XwwiVigyzc5o3elbLgss8EwBn1fcUvHgSNlMWMddDPBHoiomltIRhk2ncxf4H41+Qt
 qnVfgHzTgELwf1TZdce3ss1J0pdXE825BqvSM3d0xKrjHpPoGASv9UZCitGkh7iYcsht
 BHESuxnoJmdFZjgHHsXmIGLlkVQt4ZtlE2VFCVQ1DU+A1brYkOnf+oAE9YjNvEg+lAFe
 jttuS3iRPpLupf9mR1cYlOG8I59/Eb61JM/qWjrCLkoHxY1B/pyk5tY3nERomMtUje+8
 SUfkCSC/kKIzWO1YSXDUvYMwZK9CkQnRZZ1/yroI+wLpeGglKL5mUp+XTvwlvGwdzkS7
 FniQ==
X-Gm-Message-State: AOJu0YxN7zb+rWsXYP+v/S+EBBAnhLqn/ogBc0dk/xtHYwfeZC9U9QtJ
 m2ZJA/FyHu9fSBvhIKL7Xt1FJtuycZPAtTlw7w8pxG7Hb25nLCWIKTvuHQq7McNeCw==
X-Google-Smtp-Source: AGHT+IGIw/R8PpU10VboTcTlWPLgcRKvF4y1gyh2llh9T5oXio7b5M2MUXqXEcR3HSFUpo0qydW+vA==
X-Received: by 2002:a05:6000:24c:b0:33b:38ce:b237 with SMTP id
 m12-20020a056000024c00b0033b38ceb237mr5481246wrz.37.1707404386314; 
 Thu, 08 Feb 2024 06:59:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVA4v7KHWudlPHMjibvn01d3u9iEAHiz9s2X4ZlKghhE/twJNDhtqr1kxb5ZPWr7XVv92W+BgiO4+rGQQevopANdigJvV6vOH7Ksm0=
Received: from localhost ([165.225.20.119]) by smtp.gmail.com with ESMTPSA id
 i16-20020adff310000000b003392206c808sm3695343wro.105.2024.02.08.06.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 06:59:45 -0800 (PST)
From: Massimiliano Minella <massimiliano.minella@gmail.com>
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke-oss@weidmueller.com>,
 Massimiliano Minella <massimiliano.minella@se.com>
Subject: [PATCH v2] cmd: setexpr: fix no matching string in gsub return empty
 value
Date: Thu,  8 Feb 2024 15:58:27 +0100
Message-ID: <20240208145827.3547501-1-massimiliano.minella@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Massimiliano Minella <massimiliano.minella@se.com>

In gsub, when the destination string is empty, the string 't' is
provided and the regular expression doesn't match, then the final result
is an empty string.

Example:

=> echo ${foo}

=> setenv foo
=> setexpr foo gsub e a bar
=> echo ${foo}

=>

The variable ${foo} should contain "bar" and the lack of match shouldn't
be considered an error.

This patch fixes the erroneous behavior by removing the return
statement and breaking out of the loop in case of lack of match.

Also add a test for the no match case.

Signed-off-by: Massimiliano Minella <massimiliano.minella@se.com>
---
Changes in V2:
 - update documentation to describe the behavior

 cmd/setexpr.c             |  9 ++++-----
 doc/usage/cmd/setexpr.rst |  1 +
 test/cmd/setexpr.c        | 10 ++++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/cmd/setexpr.c b/cmd/setexpr.c
index 233471f6cb..ab76824a32 100644
--- a/cmd/setexpr.c
+++ b/cmd/setexpr.c
@@ -216,14 +216,12 @@ int setexpr_regex_sub(char *data, uint data_size, char *nbuf, uint nbuf_size,
 		if (res == 0) {
 			if (loop == 0) {
 				debug("%s: No match\n", data);
-				return 1;
 			} else {
-				break;
+				debug("## MATCH ## %s\n", data);
 			}
+			break;
 		}
 
-		debug("## MATCH ## %s\n", data);
-
 		if (!s)
 			return 1;
 
@@ -540,7 +538,8 @@ U_BOOT_CMD(
 	"    - For each substring matching the regular expression <r> in the\n"
 	"      string <t>, substitute the string <s>.  The result is\n"
 	"      assigned to <name>.  If <t> is not supplied, use the old\n"
-	"      value of <name>\n"
+	"      value of <name>. If no substring matching <r> is found in <t>,\n"
+	"      assign <t> to <name>.\n"
 	"setexpr name sub r s [t]\n"
 	"    - Just like gsub(), but replace only the first matching substring"
 #endif
diff --git a/doc/usage/cmd/setexpr.rst b/doc/usage/cmd/setexpr.rst
index d245a13ca8..593a0ea91e 100644
--- a/doc/usage/cmd/setexpr.rst
+++ b/doc/usage/cmd/setexpr.rst
@@ -39,6 +39,7 @@ setexpr name gsub <r> <s> [<t>]
      string <t>, substitute the string <s>.
      The result is assigned to <name>.
      If <t> is not supplied, use the old value of <name>.
+     If no substring matching <r> is found in <t>, assign <t> to <name>.
 
 setexpr name sub <r> <s> [<t>]
      Just like gsub(), but replace only the first matching substring
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 312593e1e3..ee329e94b8 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -179,6 +179,16 @@ static int setexpr_test_regex(struct unit_test_state *uts)
 	val = env_get("mary");
 	ut_asserteq_str("this is a test", val);
 
+	/* No match */
+	ut_assertok(run_command("setenv fred 'this is a test'", 0));
+	ut_assertok(run_command("setenv mary ''", 0));
+	ut_assertok(run_command("setexpr fred gsub us is \"${fred}\"", 0));
+	ut_assertok(run_command("setexpr mary gsub us is \"${fred}\"", 0));
+	val = env_get("fred");
+	ut_asserteq_str("this is a test", val);
+	val = env_get("mary");
+	ut_asserteq_str("this is a test", val);
+
 	unmap_sysmem(buf);
 
 	return 0;
-- 
2.43.0

