Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09B6C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63FD3878AF;
	Mon,  4 Dec 2023 01:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lz3eSQTJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA3F878AF; Mon,  4 Dec 2023 01:30:39 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15ECA87655
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6d9a1c13ea6so181732a34.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649835; x=1702254635; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mkkyLma/MHTvE7sdgkbwVWoLl2d4PA6dQWTgAMIWfs=;
 b=Lz3eSQTJBAG2bRjIhHOERiVNT/eHTXPimxN0CfABb0NQGGLI+PZuy9wVIugv5EpXaZ
 Bh3DY1SdjtB8NO4wxC+sOH8s0l49OwOTgBjBkSOur/+3+yL4R/C06kmAfNrZJs6Va5SQ
 nJWTKhC1g1frQFZWGqnv66KWErX3bnbRoLvko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649835; x=1702254635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3mkkyLma/MHTvE7sdgkbwVWoLl2d4PA6dQWTgAMIWfs=;
 b=A9z83FSijRQVBC7KEt8ynhtqbRI9A9cYVdsQJ6BYaYb+UOGq+azW/y4KcWG8yrcsQV
 sfGdgp4uPbsxBXmqGeU6piiVE4K2yqsxNpzTexgCnKQuQgamquJaYi/YQhdZ59QjN8h0
 edsvoevIlQFwv4el5ARbiglpgzuqF7H9Cza6BfbtdJB8GuZyum2ukDvr4LAzgCQ/GSei
 MAA9hSjJhzB5QLMY/CTQ921+HUvh92u3dt1oLFX2b1IxWNtjCo+/6pCyUFJGijVBs0m1
 ERqhc41qzsv1sot/D/O17vChjJZUYv8T5fO0hcRttziM8s4shFQye+mCIXZur8vD7UB0
 HlBw==
X-Gm-Message-State: AOJu0YxhvuN7zGvcdM/8aj94GXq3Siw1clT4OeNMoCeQRfHkMENXMBSJ
 HKewBcWgWcMsDuj+VNebT1WvuoPnsrYjiFkmdZPuXQ==
X-Google-Smtp-Source: AGHT+IF6/FeNd8sf7jpOQgA9ZL6VBj11R4lR2sblDgMer+3e6djN9tVEFmwtgw0qeWf4++fr3rNvow==
X-Received: by 2002:a9d:75c5:0:b0:6bc:f999:a544 with SMTP id
 c5-20020a9d75c5000000b006bcf999a544mr2963582otl.15.1701649835665; 
 Sun, 03 Dec 2023 16:30:35 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:30:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 12/13] x86: zboot: Use zboot_start() in zboot_run()
Date: Sun,  3 Dec 2023 17:29:37 -0700
Message-ID: <20231204002944.897949-12-sjg@chromium.org>
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

Now that we have a function to start the process of booting a zimage,
use it in zboot_run() to avoid duplicated logic.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/zimage.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index f2d4f3b50162..d7403876c13d 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -442,19 +442,7 @@ int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
 {
 	int ret;
 
-	memset(&state, '\0', sizeof(state));
-
-	if (base) {
-		state.base_ptr = map_sysmem(base, 0);
-		state.load_address = addr;
-	} else {
-		state.bzimage_addr = addr;
-	}
-	state.bzimage_size = size;
-	state.initrd_addr = initrd;
-	state.initrd_size = initrd_size;
-	state.cmdline = cmdline;
-
+	zboot_start(addr, size, initrd, initrd_size, base, cmdline);
 	ret = zboot_load();
 	if (ret)
 		return log_msg_ret("ld", ret);
-- 
2.43.0.rc2.451.g8631bc7472-goog

