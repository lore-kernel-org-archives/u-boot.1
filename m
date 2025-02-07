Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047F2C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F5D80C7E;
	Fri,  7 Feb 2025 19:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kIGodctb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C8F080C69; Fri,  7 Feb 2025 19:32:30 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25E8180141
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-854e5dd5cf7so70135039f.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953145; x=1739557945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLcuxGhL0w1edORtsYsZDixyma1OShoA0zSGw4TCcW4=;
 b=kIGodctbMPFlQfx+V3oS+JO1PNMqxRuONM0UWZFOq77rYBlB5hADL4BWDCjxDnrwhQ
 zX8tP7AbCEFmSp153qJTbA42vnPa/zP8Tr4fHME+RrCYp9+LZ1rdfgYL3eU+Smi82efP
 G3XgtZKyuL5uABYVdNSeNWANRoDwSiM4EwAk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953145; x=1739557945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLcuxGhL0w1edORtsYsZDixyma1OShoA0zSGw4TCcW4=;
 b=VC4aDWg8EkrOE4tnP2+rPVVagjoCNqxnOG2/wdrx/ERR+fDLxxiqokskTP+McxcyAA
 lH5XFquZUxp1zT4REVmKfbjaz4UqvzV06f/sSAQNch9ySWQOo2TrakcaNANxHPbxuxOr
 wfTkauQpA1FAtDV1LlM3x6Z9/r2tty9VX5fDaS1QaLa77ITCSU2x5+TCyluGuoaeeEaT
 gDYNta9jx4+aumYizRBCSw9WUuHevQOanS/H11HeaswLIsavKw+2mKrPicvC5rcd4SUP
 B0heUD6QwfOSTwDJ4pXBNmkxkD/QCO1HXC5DQbZ4BeseA+PCdnilBxE0GeD6x6d+zrvq
 ousQ==
X-Gm-Message-State: AOJu0Ywz3z760EdfqgPsttN6Ot5vqMvYbEibUqDZqSJ1Z3o82ZMUk2qo
 +BwC12RprzcN5vZX8ODvF/1aQVhhiVkRWikzeb3nq085kJ1/Ur/0qsdqga7QGDSsIJU5IMekjg4
 =
X-Gm-Gg: ASbGncvTpRifFLO3zXbyFy1agat+GmtRoTlWoaJ2rZ0l/ILMH6wiNynuOpxP7zu6wJf
 XdqvIX44asfxdGU1t3uXSdt4w3vLQdzzeI1NRAhVwzI6sqsVsQzzqjS1djbJLbG3MAtI4xDHMW8
 UakvK1/jLf/8vgnFLuTSOz4vBwBdg6zNX9+5Na1Nc7bLZqRt10PMy/dMJpjRryu8l+l/i4/DUHm
 P76jEMKJTEKKkiOzD0w9mhrp59eoJowOWvTm/JK3vm4Bt563xcuZBPYkfbaK6Emnw4mJXatWWgS
 /XRmDryi9Pw6KBeM/kuEOpVdiJw6ADGvWkeyOHn/KYU+J+HMS3Bl
X-Google-Smtp-Source: AGHT+IHcgFZQCV9tNszVcxt5uT/20X5EeOAUAcwqrKyo5PgtrFXqRxFCpu56g2kl4mQ+ePOFMpVmLQ==
X-Received: by 2002:a05:6602:7210:b0:847:51e2:eac with SMTP id
 ca18e2360f4ac-854fd8b43f4mr497861139f.7.1738953145292; 
 Fri, 07 Feb 2025 10:32:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 24/29] test: Make cmd_ut_category() static
Date: Fri,  7 Feb 2025 11:30:55 -0700
Message-ID: <20250207183121.117663-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

This function is not used outside the cmd_ut file anymore, so make it
static.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/suites.h | 22 ----------------------
 test/cmd_ut.c         |  6 +++---
 2 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 687a8a13e7f..f817da747c2 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -7,26 +7,4 @@
 #ifndef __TEST_SUITES_H__
 #define __TEST_SUITES_H__
 
-struct unit_test;
-struct unit_test_state;
-
-/**
- * cmd_ut_category() - Run a category of unit tests
- *
- * @uts: Unit-test state, which must be ready for use, i.e. ut_init_state()
- *	has been called. The caller is responsible for calling
- *	ut_uninit_state() after this function returns
- * @name:	Category name
- * @prefix:	Prefix of test name
- * @tests:	List of tests to run
- * @n_ents:	Number of tests in @tests
- * @argc:	Argument count provided. Must be >= 1. If this is 1 then all
- *		tests are run, otherwise only the one named @argv[1] is run.
- * @argv:	Arguments: argv[1] is the test to run (if @argc >= 2)
- * Return: 0 if OK, CMD_RET_FAILURE on failure
- */
-int cmd_ut_category(struct unit_test_state *uts, const char *name,
-		    const char *prefix, struct unit_test *tests, int n_ents,
-		    int argc, char *const argv[]);
-
 #endif /* __TEST_SUITES_H__ */
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index b3821a0fe68..31ded16325f 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -35,9 +35,9 @@ static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
 static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[]);
 
-int cmd_ut_category(struct unit_test_state *uts, const char *name,
-		    const char *prefix, struct unit_test *tests, int n_ents,
-		    int argc, char *const argv[])
+static int cmd_ut_category(struct unit_test_state *uts, const char *name,
+			   const char *prefix, struct unit_test *tests,
+			   int n_ents, int argc, char *const argv[])
 {
 	const char *test_insert = NULL;
 	int runs_per_text = 1;
-- 
2.43.0

