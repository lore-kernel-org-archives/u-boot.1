Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A77FC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F89878A4;
	Mon,  4 Dec 2023 01:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KroUxCAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A23878A2; Mon,  4 Dec 2023 01:30:19 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D536287655
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6d84d9e55c7so1834569a34.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649814; x=1702254614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLrBFOfwA0wbskBltSnIOdCR1xUfIiDTEIqwck27kyQ=;
 b=KroUxCApMHS2JqnKThnsVNnnP8FAPOYs2qq6iGEF30Mz0KBc9uw65NXX161E552u8W
 prTv0jwX1ww8JfsvAqDOqeF8lyBSqLVPPe2dElHfe18NRY+Eah9HeMuBlmZ/kVCx1VYu
 RXk5XhpxIPIxk2dar11YJbPtAjpQS1nyUgTUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649814; x=1702254614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLrBFOfwA0wbskBltSnIOdCR1xUfIiDTEIqwck27kyQ=;
 b=qNryoq5q4JqchRc/TwaB9mnAEdeLjy1TXLsHqRI5+igA1PvwrELa8P1c6kzfIEI/cQ
 j9YbOim4H5Ohpi3My4NeXvA6w5Iqyla5ht5t7VRQjLOgBlnMKanzFOGaSwQQMDSxnJNd
 5X+dy6Rez9WFE16P0Zg8fqDPnC6fm3DZfbFujHyG9MHFCs+l0draVrjF/NhXkqXFQccx
 AFlu9b1A1hUCF7ufj96Nkor4zolILKO67tjYZc3lAokim33Zb+2Msil6hbz6Y0/KGCi4
 jYCIQuxiKlOLDv6HIX+x5hqSegEv9p9LC0PdtOsRJ/s9IBo0maNFn+e4Q2IkpgXXy/VQ
 Ot6w==
X-Gm-Message-State: AOJu0Yzv0SW7wYqs9I+GpXXbsVrGgerRudM+63stDYhhk2S5RwVEOPbz
 Dgd61b2CgwJ/QNd0m9yp1+22Ctib+zSzbFqLDzDjEw==
X-Google-Smtp-Source: AGHT+IGyVA2kKoRnrkF3cPxmXUUOhCpMn64V4TQG6XQUdCsYawxWZ0TzVz+Hcx9A+t6AsrW+rPANGg==
X-Received: by 2002:a9d:6c85:0:b0:6d9:a1d8:4f63 with SMTP id
 c5-20020a9d6c85000000b006d9a1d84f63mr559467otr.31.1701649814448; 
 Sun, 03 Dec 2023 16:30:14 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:30:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 05/13] x86: zboot: Create separate functions for the logic
Date: Sun,  3 Dec 2023 17:29:30 -0700
Message-ID: <20231204002944.897949-6-sjg@chromium.org>
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

Separate out the commands from the logic. This will eventually allow
the logic to be used when CONFIG_CMDLINE is not enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/zboot.c | 66 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 03cab1d67ebf..f5c90a8ba896 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -10,8 +10,7 @@
 #include <vsprintf.h>
 #include <asm/zimage.h>
 
-static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
-			  char *const argv[])
+static void zboot_start(int argc, char *const argv[])
 {
 	const char *s;
 
@@ -53,6 +52,27 @@ static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 	if (argc >= 7)
 		state.cmdline = env_get(argv[6]);
+}
+
+static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	zboot_start(argc, argv);
+
+	return 0;
+}
+
+static int _zboot_load(void)
+{
+	int ret;
+
+	ret = zboot_load();
+	if (!ret)
+		ret = env_set_hex("zbootbase", map_to_sysmem(state.base_ptr));
+	if (!ret)
+		ret = env_set_hex("zbootaddr", state.load_address);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -60,18 +80,13 @@ static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_zboot_load(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
-	if (zboot_load())
-		return CMD_RET_FAILURE;
-
-	if (env_set_hex("zbootbase", map_to_sysmem(state.base_ptr)) ||
-	    env_set_hex("zbootaddr", state.load_address))
+	if (_zboot_load())
 		return CMD_RET_FAILURE;
 
 	return 0;
 }
 
-static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
-			  char *const argv[])
+static int _zboot_setup(void)
 {
 	struct boot_params *base_ptr = state.base_ptr;
 
@@ -87,24 +102,47 @@ static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-static int do_zboot_info(struct cmd_tbl *cmdtp, int flag, int argc,
-			 char *const argv[])
+static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return _zboot_setup();
+}
+
+static void zboot_info(void)
 {
 	printf("Kernel loaded at %08lx, setup_base=%p\n",
 	       state.load_address, state.base_ptr);
+}
+
+static int do_zboot_info(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	zboot_info();
 
 	return 0;
 }
 
+static int _zboot_go(void)
+{
+	int ret;
+
+	ret = zboot_go();
+
+	return ret;
+}
+
 static int do_zboot_go(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
 {
 	int ret;
 
-	ret = zboot_go();
-	printf("Kernel returned! (err=%d)\n", ret);
+	ret = _zboot_go();
+	if (ret) {
+		printf("Kernel returned! (err=%d)\n", ret);
+		return CMD_RET_FAILURE;
+	}
 
-	return CMD_RET_FAILURE;
+	return 0;
 }
 
 static int do_zboot_dump(struct cmd_tbl *cmdtp, int flag, int argc,
-- 
2.43.0.rc2.451.g8631bc7472-goog

