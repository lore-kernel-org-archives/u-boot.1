Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D60C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574E98789A;
	Mon,  4 Dec 2023 01:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aRbilgl6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EB76876E0; Mon,  4 Dec 2023 01:30:15 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D1D8784C
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b84e328327so2008929b6e.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649811; x=1702254611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAmu10X/ImlrN7I73s3pTlic5gtEFux7cUoctE67Fak=;
 b=aRbilgl6/1/gaOJEbU9Jhhg+vOMnAQLzKkWax7U2VkTLZkAMSUCzkwZTDZbH/bB/pZ
 yGa0iM3zV26sM2m5GG5vkMZYQLEc31L6+e/4aKt8QGq/zSKOwrW2Xact8zSNrNXXXsqg
 gVMXQJffuWiNFmCrVwz/Czf6Z1xQZlgSMBsJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649811; x=1702254611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAmu10X/ImlrN7I73s3pTlic5gtEFux7cUoctE67Fak=;
 b=jd2MyRFzbcjHkKYlNW4zNxmqYcqSUpsXh8AdpvwPj0ZA/Gth5TR0BF0cUFHnE1Mnhz
 +KBEm1GSlv4na31yC//sTGRdY8Q58Cll/qwjYPZ/7pCvX5sYxufS7jOW7vXCtzUJ3+FT
 1mdnHCKqnUKaU9tng7cEuJRVnquXptG82RWH2ScadTJto1eETH4r8B5EYFqdTAxSXeBr
 I1gqqTPzJ3y1+3yYRS/kA9yJ9ukAS4pXfyHvvPwcMDvPQpuaSbeyH6/zr8zp5byVTlXA
 qIxnEjtCvOvKtA5q051hW5lvYHRupS6X3ib71n6oqOHo01Z18nx2JwWQD5F+4GyK67AF
 v7yQ==
X-Gm-Message-State: AOJu0Yz1AcuwVz5kqj/ccmNAMaayUui55dtC0ZxXSGNL3oWChz1vD4k8
 Lsye/6o+nu+VSVTbrG0PowLktu4APwP5SwSMjc3NgQ==
X-Google-Smtp-Source: AGHT+IH4Q1YmseQB3goMcK5Pw6m/UmvXeJaDDJY6CXtpSzNeWG+fWCRsGzAjTOgKFsM18JWB9Knb5g==
X-Received: by 2002:a05:6808:180b:b0:3a7:d566:8b5e with SMTP id
 bh11-20020a056808180b00b003a7d5668b5emr4175360oib.44.1701649811249; 
 Sun, 03 Dec 2023 16:30:11 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:30:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 04/13] x86: zboot: Avoid iteration in do_zboot_states()
Date: Sun,  3 Dec 2023 17:29:29 -0700
Message-ID: <20231204002944.897949-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002944.897949-1-sjg@chromium.org>
References: <20231204002944.897949-1-sjg@chromium.org>
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

Drop the iteration and write out each state in full. This will allow
the arguments to be reduced and adjusted in future patches.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/zboot.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index c9375fb417c1..03cab1d67ebf 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -136,19 +136,20 @@ U_BOOT_SUBCMDS(zboot,
 int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[], int state_mask)
 {
-	int i;
-
-	for (i = 0; i < ZBOOT_STATE_COUNT; i++) {
-		struct cmd_tbl *cmd = &zboot_subcmds[i];
-		int mask = 1 << i;
-		int ret;
-
-		if (mask & state_mask) {
-			ret = cmd->cmd(cmd, flag, argc, argv);
-			if (ret)
-				return ret;
-		}
-	}
+	int ret;
+
+	if (flag & ZBOOT_STATE_START)
+		ret = do_zboot_start(cmdtp, flag, argc, argv);
+	if (!ret && (flag & ZBOOT_STATE_LOAD))
+		ret = do_zboot_load(cmdtp, flag, argc, argv);
+	if (!ret && (flag & ZBOOT_STATE_SETUP))
+		ret = do_zboot_setup(cmdtp, flag, argc, argv);
+	if (!ret && (flag & ZBOOT_STATE_INFO))
+		ret = do_zboot_info(cmdtp, flag, argc, argv);
+	if (!ret && (flag & ZBOOT_STATE_GO))
+		ret = do_zboot_go(cmdtp, flag, argc, argv);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog

