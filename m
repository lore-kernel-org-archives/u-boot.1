Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E35C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 344E587655;
	Mon,  4 Dec 2023 01:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P4DDQV3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A69AA87499; Mon,  4 Dec 2023 01:27:14 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B1A2875BD
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cfabcbda7bso16782725ad.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649630; x=1702254430; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zc2Px65Y39Y4A8X4QTkj42bX2t5hx0DrIHhdkJ6yuIA=;
 b=P4DDQV3fGpGiv6iitdsH77zZv9+63SuDXZObOevM9AcCUvCX9X0lkdkzWiw1LIAdsZ
 zmM6iJcR9ZBJtnn52OAfSuhPOOGMtM6PKfc2fCOTDvc7rHylnzvJ39d+g3KcAEMmzwx3
 uxCNSf/yU6KQzTys2Jc3YIJm9Nkbg31HqkfZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649630; x=1702254430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zc2Px65Y39Y4A8X4QTkj42bX2t5hx0DrIHhdkJ6yuIA=;
 b=CkZ2Ssq4kw3golBbLf/djMxtjN5AavSPvY5zRTlg+WcBH2QoL3RgHaL7jTUkKVvHSs
 bN9S9lY5prIAnr7WF5LuAIpe0nxx4lYE74MJ77hNr3mt9XKJvOKszHuCaZE39P8UgSAt
 NyV2I4ANRlKY0jq1cf8SPTMVpc4pMdG5Ci4kNn6rB8XWZwoeB3tD1j2iEGEr1BNQzkSN
 83iTQONXiY6I2kxYBh+2XDgFrSben2HytBDYJVOhzkdog+Ab7opp2LVBY30XUTlBsfOi
 5olx7q3ecdw48czfop2JtYIoe/GeXH4ySh1SgfA4+kYKQv8LiToAMrUfQSD25YXKsu29
 /akw==
X-Gm-Message-State: AOJu0YxRZmXK5JlRmfkr6Ix8o3wL4+C+RFNxFjw87icrM0dLZJEcVxrJ
 sw8sGx/g/LwcNQDjdtnHDosim9DcGaWAxjTsXSB6LA==
X-Google-Smtp-Source: AGHT+IGvU5PeUUWJVCzhxrLr9fFyOUdieOiGfXlo/POrv1U1me+sZWyQYu5WZXh5HOsqu2Qds4PFjA==
X-Received: by 2002:a17:902:d3c4:b0:1d0:9979:7be5 with SMTP id
 w4-20020a170902d3c400b001d099797be5mr1123911plb.31.1701649630626; 
 Sun, 03 Dec 2023 16:27:10 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 03/18] bootm: qnxelf: Drop passing of arguments
Date: Sun,  3 Dec 2023 17:26:19 -0700
Message-ID: <20231204002642.895926-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002642.895926-1-sjg@chromium.org>
References: <20231204002642.895926-1-sjg@chromium.org>
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

It isn't clear how useful it is to pass the arguments of bootm to the
OS. For example, if "bootm 1000 2000 3000" is used, the '1000' argument
is passed to QNX. This seems like a strange approach, since the argument
have already been parsed by U-Boot and processed.

Rely instead on the "bootargs" mechanism, which is the standard
approach.

Also make sure that the argument list is NULL-terminated.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm_os.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 4aa1db848d6c..598671e576c6 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -333,7 +333,7 @@ int do_bootm_vxworks(int flag, int argc, char *const argv[],
 static int do_bootm_qnxelf(int flag, int argc, char *const argv[],
 			   struct bootm_headers *images)
 {
-	char *local_args[2];
+	char *local_args[3];
 	char str[16];
 	int dcache;
 
@@ -348,8 +348,9 @@ static int do_bootm_qnxelf(int flag, int argc, char *const argv[],
 #endif
 
 	sprintf(str, "%lx", images->ep); /* write entry-point into string */
-	local_args[0] = argv[0];
-	local_args[1] = str;	/* and provide it via the arguments */
+	local_args[0] = "qnxelf";
+	local_args[1] = env_get("bootargs");
+	local_args[2] = NULL;
 
 	/*
 	 * QNX images require the data cache is disabled.
@@ -358,7 +359,7 @@ static int do_bootm_qnxelf(int flag, int argc, char *const argv[],
 	if (dcache)
 		dcache_disable();
 
-	do_bootelf(NULL, 0, 2, local_args);
+	do_bootelf(NULL, 0, local_args[1] ? 2 : 1, local_args);
 
 	if (dcache)
 		dcache_enable();
-- 
2.43.0.rc2.451.g8631bc7472-goog

