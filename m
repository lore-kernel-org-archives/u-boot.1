Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38409C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9FA180759;
	Mon, 20 Jan 2025 22:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fiu8IsPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85492807EE; Mon, 20 Jan 2025 22:26:46 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7001807E1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a9628d20f0so36902605ab.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408402; x=1738013202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AAQOQNImrJcDOqoOjqfz1RHpsoWzlJ3Hq1lP6f8RaA=;
 b=Fiu8IsPwKOGH4j6mqf5w+Sn20b/0gxJvPCm5h7ZW2ChLrPZ1yxTolEH4ptZsPpEKKd
 j63scfScVOF6x0Sy2FYIFUWMTRyEwqyS8iTI/CDNDMIMrsHCXNQdGQVVhb0O8Bm1g5sv
 a41D8GsqEbw4j/t0hR088rye4rmOD6kC/XaIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408402; x=1738013202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/AAQOQNImrJcDOqoOjqfz1RHpsoWzlJ3Hq1lP6f8RaA=;
 b=ck84XAALCMOCntzFYdxYeovX9vyWpnbeQnNCuwltvRpZT58G8ETPk0sPApnAb3UK8i
 g3+pyRNOl/+vXH6pzHcQgWGHAlgDqv9J119pJXea8yoLJKGElkBc1Ojc9wIB6vHg98pz
 M+A/S/Nx0vgRx2+uekqIXlaa24G3LvPABzTYM0fckAK41oGTgdgkiKLLcpoQefxfgCVQ
 4zW0nKbYbu0HARKPYYQKe8B09ykqBeAF0yywJq+g33LkchW/tz+bgkY0vyqmfI4SZ40K
 pE9wPJ7EQ5YgXneBEAbEq3nmOL05yJByunhyUhp8p1XirOcioofGF0AoowVvpY4PDwyT
 y8NA==
X-Gm-Message-State: AOJu0YxDn1gXHBykK0+p3QIP39jKMvD65cgSbOeNz/UEuwcsLG4IteYD
 BbMm6ifo+FTogL0TNNwZVdFcWaYL5pzgTKXDEyKoNk2/w3fPDhvkAZktK6piJYgm+W5Yl1pVDfo
 =
X-Gm-Gg: ASbGncuUaG93poIlShUYX7lNlPTqOJbXnqAWreZDn5ytZqXsRXuTDSAzqgtczZAtzny
 aJDoJCD4yNbY2w9+oHY8BxeUNZbYjOD43/cOPuIDXQvXi5lbak5QHhnmpX70iqV+ATQXsUGEGFe
 64caP22IkIZ2bh1WuXONTidXShQv/NYhev/JNtnKO3Vg5AHNaJPkwt1Amawzfb4eCt24PZ0v2f1
 ss8mOkLzrpcesm5g5hGnrzrCnjYpNTxpNcjBGX+vkglnDb1V4T2+WvsO2/wxgvitI23YpH04OcE
 9rrPbIYbbMHN7coAOc/acVoatsdur4E=
X-Google-Smtp-Source: AGHT+IFa20elLoUwHunjAE7r7ErI8Im7WK4StFxwFD3qOnAImfSaDe0a5Ucj+iy2uXNmji2lbGly3Q==
X-Received: by 2002:a05:6e02:1d13:b0:3cf:6463:41ed with SMTP id
 e9e14a558f8ab-3cf74402dd4mr103794745ab.9.1737408402072; 
 Mon, 20 Jan 2025 13:26:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/44] test: Update ut info to show suites
Date: Mon, 20 Jan 2025 14:25:30 -0700
Message-ID: <20250120212613.516664-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

It is helpful to see a list of available suites. At present this is
handled by the longhelp for the 'ut' command, but this is not in a
format which can be easily parsed by python tests.

Add a -s option to show this. At present it is not possible to show the
number of tests in each suite, but future work will address this. For
now, show a ?

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd_ut.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 69f0230e556..3e78d072b3d 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -153,9 +153,21 @@ static int do_ut_all(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
+	const char *flags;
+
 	printf("Test suites: %d\n", (int)ARRAY_SIZE(cmd_ut_sub));
 	printf("Total tests: %d\n", (int)UNIT_TEST_ALL_COUNT());
 
+	flags = cmd_arg1(argc, argv);
+	if (flags && !strcmp("-s", flags)) {
+		int i;
+
+		puts("\nTests  Suite\n");
+		puts("-----  -----\n");
+		for (i = 1; i < ARRAY_SIZE(cmd_ut_sub); i++)
+			printf("%5s  %s\n", "?", cmd_ut_sub[i].name);
+	}
+
 	return 0;
 }
 
@@ -186,7 +198,7 @@ U_BOOT_LONGHELP(ut,
 	"\n"
 	"\nOptions for <suite>:"
 	"\nall - execute all enabled tests"
-	"\ninfo - show info about tests"
+	"\ninfo [-s] - show info about tests [and suites]"
 #ifdef CONFIG_CMD_ADDRMAP
 	"\naddrmap - very basic test of addrmap command"
 #endif
-- 
2.43.0

