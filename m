Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33209C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B3C2877E5;
	Mon,  4 Dec 2023 01:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WMZaDscV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA6F87655; Mon,  4 Dec 2023 01:30:30 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0DEB877E5
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b8b463c7c6so758770b6e.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649826; x=1702254626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xz1vWXbilJ938mkaz+SP3BM6zNZhY5EnLykbz+f/vXU=;
 b=WMZaDscVksN7fLFXphWjLUSPyycHb201yphCFvUTELUVr3gVPDZfBqDi6u22/l7Edo
 FmFUnHqUCTBFTSs1o1oNyg6Lrf434Qvl4odWw268zG/QbybCHAYlhxBLJGe8W4SUvxdY
 9ySpZ5/FHc2wTIpPKcpv3CGAFz4LiTXYgJdEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649826; x=1702254626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xz1vWXbilJ938mkaz+SP3BM6zNZhY5EnLykbz+f/vXU=;
 b=PPV+sp6EYXCSCLLrGIshEVFObJ7bEUE/VwqWzuIoL0cY5Xh6suZO50IGMhjEFGU8Ic
 uXcMjFctgrJ6zqEJs6Z+jU5sS0kMpA6zTFPynn2BdcE4COUaCFW6kZF20pywP7cz+SDQ
 qTz3v3NEfbB1I37lOYKJcx63xkS/VEQlp2u8qsF5tt4GcSVPo+r8sckcBlBb26YsYExm
 lo+HqyerbQoMNkbGUOa9fX3bVNBrZ8Mb/32LwuOo2k4xm0PmAxrv3H5EaYKd11/bO1xa
 YngyJBVtWRZoiDiJM+3Ruw79oFTloJL6hYaa8W39184x1FLXDF18H4hjK6rVvN17DtkI
 4gaQ==
X-Gm-Message-State: AOJu0YxCcQiyBdgV7Q1f3PhisCbRTGQTUi6Wgtgf4YS2RZs9TNV1cXVN
 a5h9AqkjjQ8SyW5KL6jyaUQ362vzdnx+GycIzztP6A==
X-Google-Smtp-Source: AGHT+IGXwfbJd6Bc0Pa2tD2rWFCIiz1V/nh2UOMRRm4gx7Bo5/NsK3sU0SgJHyNLyyFDZwdncRaSgw==
X-Received: by 2002:a05:6808:10c8:b0:3ae:4ca9:cae5 with SMTP id
 s8-20020a05680810c800b003ae4ca9cae5mr3773601ois.21.1701649826543; 
 Sun, 03 Dec 2023 16:30:26 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:30:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 09/13] x86: zboot: Move argument processing outside
 zboot_start()
Date: Sun,  3 Dec 2023 17:29:34 -0700
Message-ID: <20231204002944.897949-9-sjg@chromium.org>
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

Process the arguments before calling zboot_start() so that we can
separate the command line from the internal logic.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/zboot.c | 67 +++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index f49cdd91a1f8..572b58a5537d 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -10,56 +10,45 @@
 #include <vsprintf.h>
 #include <asm/zimage.h>
 
-static void zboot_start(int argc, char *const argv[])
+static int zboot_start(ulong bzimage_addr, ulong bzimage_size,
+		       ulong initrd_addr, ulong initrd_size, ulong base_addr,
+		       const char *cmdline)
 {
-	const char *s;
-
 	memset(&state, '\0', sizeof(state));
-	if (argc >= 2) {
-		/* argv[1] holds the address of the bzImage */
-		s = argv[1];
-	} else {
-		s = env_get("fileaddr");
-	}
 
-	if (s)
-		state.bzimage_addr = hextoul(s, NULL);
-
-	if (argc >= 3) {
-		/* argv[2] holds the size of the bzImage */
-		state.bzimage_size = hextoul(argv[2], NULL);
+	state.bzimage_size = bzimage_size;
+	state.initrd_addr = initrd_addr;
+	state.initrd_size = initrd_size;
+	if (base_addr) {
+		state.base_ptr = map_sysmem(base_addr, 0);
+		state.load_address = bzimage_addr;
+	} else {
+		state.bzimage_addr = bzimage_addr;
 	}
+	state.cmdline = cmdline;
 
-	if (argc >= 4)
-		state.initrd_addr = hextoul(argv[3], NULL);
-	if (argc >= 5)
-		state.initrd_size = hextoul(argv[4], NULL);
-	if (argc >= 6) {
-		/*
-		 * When the base_ptr is passed in, we assume that the image is
-		 * already loaded at the address given by argv[1] and therefore
-		 * the original bzImage is somewhere else, or not accessible.
-		 * In any case, we don't need access to the bzImage since all
-		 * the processing is assumed to be done.
-		 *
-		 * So set the base_ptr to the given address, use this arg as the
-		 * load address and set bzimage_addr to 0 so we know that it
-		 * cannot be proceesed (or processed again).
-		 */
-		state.base_ptr = (void *)hextoul(argv[5], NULL);
-		state.load_address = state.bzimage_addr;
-		state.bzimage_addr = 0;
-	}
-	if (argc >= 7)
-		state.cmdline = env_get(argv[6]);
+	return 0;
 }
 
 static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
-	zboot_start(argc, argv);
+	ulong bzimage_addr = 0, bzimage_size, initrd_addr, initrd_size;
+	ulong base_addr;
+	const char *s, *cmdline;
 
-	return 0;
+	/* argv[1] holds the address of the bzImage */
+	s = cmd_arg1(argc, argv) ? : env_get("fileaddr");
+	if (s)
+		bzimage_addr = hextoul(s, NULL);
+	bzimage_size = argc > 2 ? hextoul(argv[2], NULL) : 0;
+	initrd_addr = argc > 3 ? hextoul(argv[3], NULL) : 0;
+	initrd_size = argc > 4 ? hextoul(argv[4], NULL) : 0;
+	base_addr = argc > 5 ? hextoul(argv[5], NULL) : 0;
+	cmdline = argc > 6 ? env_get(argv[6]) : NULL;
+
+	return zboot_start(bzimage_addr, bzimage_size, initrd_addr, initrd_size,
+			   base_addr, cmdline);
 }
 
 static int do_zboot_load(struct cmd_tbl *cmdtp, int flag, int argc,
-- 
2.43.0.rc2.451.g8631bc7472-goog

