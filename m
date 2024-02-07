Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C21C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 00:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C663287C82;
	Wed,  7 Feb 2024 01:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="YqScsN27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8141087C8D; Wed,  7 Feb 2024 01:01:51 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7240C86F34
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 01:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51165a488baso44523e87.2
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 16:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707264107; x=1707868907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1KUH8xhcR44BcQGItXczMPQnW+XUJ40OfLWnL0CBK80=;
 b=YqScsN27uqyXIGfjqkAc4cDnHBN8wtGjVMTRalRpNp/mj5gqyZuGxWDi/h2pqr0lur
 Lq24hKotg+QMOhZRi1va0Vy2g3n52mWxsuHqCOhEy8rVXXQpwwh38h/joQ1T7grQ731l
 5CiVeJ0vcWi4QMZAm0n8BXEh0h2PDHePsneN2A4gRC6uWhZm1DLp75DQTMWHlOOpumwX
 7gWHXOtrcqd9P4citK1xLQBsSbD/YRMNNfnHx3jH1bWztUwXPLkx5AqFCeMFQPXJ9L0a
 z6BG1g5daAILhXzUARSjBpGU1n4XK+2gudWv77xT1tFUcjmEfcm+obWnCJcEjFSzFVeU
 HoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707264107; x=1707868907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1KUH8xhcR44BcQGItXczMPQnW+XUJ40OfLWnL0CBK80=;
 b=gtOqgHm9SRwz2p9mBp1tozZti89EHTz9u9TrpkHQb2LFw7y1jAEdq9GPG2XvVMOu2q
 CAQ92F9SN+hYbSjUB/fMiHrCWwI2iZY8fBl5c6CM/oZbSmofF9brx7eWvsiInvcZGxUd
 +6PTkUN0JyTkxnErQFHjMGL6t56UjOYH2nhR9GGgbSUwWCnSmG5xJpVTrFzSmOovr4o1
 fvDWtPvOG9bZTfcUD4l/NJ7XBhE58mLa0n3/qialorS4c3F9QkQzxf+vlwaWwmsUuwfF
 VzyaWdjDLsAqJveXQdNx6495tY8tQ9LVcDs/WdJyvOAt2UTi6XUFuykcXSZXL+7l1A80
 RQmw==
X-Gm-Message-State: AOJu0YwEaUuJpSW9X6qlYTNgXrY5PsTcrxXXVOptFXJGIJeSCPgmYYbx
 MhAi1I7r1Hc/itf4u/eFIbPvOXIG7PxsmNrw1thxqIvjJH+OOqtWmSxuKAmoOGjv0yObo9R9c3o
 ipVo=
X-Google-Smtp-Source: AGHT+IGxQCLDYb6DmsVpU2suvAgZJ6+XFZJS9p0kxm1faBy8uxBSe1EynFR9XnU3/Iy3h83v+ZCeKQ==
X-Received: by 2002:a05:6512:2118:b0:511:4175:8d16 with SMTP id
 q24-20020a056512211800b0051141758d16mr2526936lfr.55.1707264106902; 
 Tue, 06 Feb 2024 16:01:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXcJgczvaUwo33/A5twlBsnUDo3j+JoLnXwXNMId4OjoN82iOSlbx8zGER0t25kX5wffTCT76F48ILUsYHDu+BBxA8=
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 t25-20020a192d59000000b0050ef97ce785sm2645lft.179.2024.02.06.16.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 16:01:45 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] cmd: hash: fix param count check
Date: Wed,  7 Feb 2024 01:01:32 +0100
Message-Id: <20240207000132.3116094-1-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Add correct check for parameter count.

This fixes this issue when `hash` cmd is invoked without params:

=> hash
data abort
pc : [<bf739204>]	   lr : [<ba6effa8>]
reloc pc : [<60019204>]	   lr : [<5afcffa8>]
sp : ba6dd9c8  ip : bf7391f0	 fp : bf74ec14
r10: 00000001  r9 : ba6dfea0	 r8 : bf7ea030
r7 : 00000000  r6 : ba6effa8	 r5 : 00000000  r4 : ffffffff
r3 : bf7c257c  r2 : 00000001	 r1 : 00000000  r0 : bf7e6e34
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32
Code: e5934004 e1a0e003 e59f3050 e2444001 (e5f4c001)
Resetting CPU ...

resetting ...

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 cmd/hash.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/cmd/hash.c b/cmd/hash.c
index e163cd67742..5534a735fa7 100644
--- a/cmd/hash.c
+++ b/cmd/hash.c
@@ -14,15 +14,22 @@
 #include <hash.h>
 #include <linux/ctype.h>
 
+#if IS_ENABLED(CONFIG_HASH_VERIFY)
+#define HARGS 6
+#else
+#define HARGS 5
+#endif
+
 static int do_hash(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
 {
 	char *s;
 	int flags = HASH_FLAG_ENV;
 
-#ifdef CONFIG_HASH_VERIFY
-	if (argc < 4)
+	if (argc < (HARGS - 1))
 		return CMD_RET_USAGE;
+
+#if IS_ENABLED(CONFIG_HASH_VERIFY)
 	if (!strcmp(argv[1], "-v")) {
 		flags |= HASH_FLAG_VERIFY;
 		argc--;
@@ -37,18 +44,12 @@ static int do_hash(struct cmd_tbl *cmdtp, int flag, int argc,
 	return hash_command(*argv, flags, cmdtp, flag, argc - 1, argv + 1);
 }
 
-#ifdef CONFIG_HASH_VERIFY
-#define HARGS 6
-#else
-#define HARGS 5
-#endif
-
 U_BOOT_CMD(
 	hash,	HARGS,	1,	do_hash,
 	"compute hash message digest",
 	"algorithm address count [[*]hash_dest]\n"
 		"    - compute message digest [save to env var / *address]"
-#ifdef CONFIG_HASH_VERIFY
+#if IS_ENABLED(CONFIG_HASH_VERIFY)
 	"\nhash -v algorithm address count [*]hash\n"
 		"    - verify message digest of memory area to immediate value, \n"
 		"      env var or *address"
-- 
2.34.1

