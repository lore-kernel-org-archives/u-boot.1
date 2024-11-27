Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECC2D6ACF4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C5AB897EC;
	Wed, 27 Nov 2024 18:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WEruIX9m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A58F189807; Wed, 27 Nov 2024 18:23:03 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2579A896DC
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b15d7b7a32so508983685a.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732728177; x=1733332977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWBdcIEgr5qwAVHUJ5m17h7G1APKnwNOit1EqCpgVio=;
 b=WEruIX9mGxM6L8fwieoLyPlbkXeYNELWYt5CWyeKNRGnhw8yZnkvdN9jQFrFa+iRRu
 M50NjSEveVKVIE4wUxlPlCIndB3Cfysuzom/GALlmGO0+gQJhiVrJ4lEuEsrENs4LoiN
 NDv1Zq/6+2OCU+wEdMm5IUqCLiivL2QF1mwbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732728177; x=1733332977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWBdcIEgr5qwAVHUJ5m17h7G1APKnwNOit1EqCpgVio=;
 b=TyKLj3YsduHn21BdAxPCrRjN/jkBZOF5B28NeNuPr+TGER/DLZpXubdEGHU8NrRIqT
 1hCAwtolIn9avykltfk+PvPJ+6nJdMP1ReeRHUP8ks+8Qy5LLnCGlOEf31rBrPa1AMAx
 I7lkF4zvo7z918iXT4m/+g83wYNY2K/CkHFLLm8fsrrMNQXQPTcjN+T/LiVmf0dcb+RZ
 jb0d7L21HTdHl0v7R4wQd3MOHCnvjgpMicCAw2iHheIuSB4mBCUIg3nzel9Xyht9F/MN
 //blwoRMt6KqUzgES6yyv8dkMCjIvNmTEpCajc8ykStQZrjTndAPka+2rHPp3ovhPptK
 bNHQ==
X-Gm-Message-State: AOJu0Yzp3O/oVDVg//eUIvMI9ROF/dffjwMsxmYsHMm3yzg8p+O9BRU2
 nkGTmBhXLJFVbdi79IRFfDaeFMXCkpnW9xLdKZ3NFbm46HPWwPPFeZeiWo0cGehRABOAETtih+Y
 IEng=
X-Gm-Gg: ASbGncvhe/4NKfE6XkUE5cFMiA5m+SFsZd4dMOEHE802VZSoikkUdzmvaXN7LggU+zW
 jchZqabX1t71ftwUtOVZSZGbg5t92miY66fityZDAP3MQnM3CpGnccBzYzcss1DHWgQMPNE/yIl
 8JeM+5ooFZMuwCpH28rcS9KeeM21HP7C+xx+DXSvbHpwB1OcxNAm9dR2dIiTncywo82Q3EWGNcq
 JyA57cI80QMXgM4c42ZOk33QDrBTc0dh+bSKUWTVzJmbB2I3ZiA5H1Z4cASJ77gVM7q4p1R
X-Google-Smtp-Source: AGHT+IG+w+3Fokg5V0aZZHamDv1RZ56MzyCvJLv0b5hp5FOD0aLCGw/VvCYZ2ewmzluqRs+iQebzXw==
X-Received: by 2002:a05:6214:27c1:b0:6d4:19a0:1fa with SMTP id
 6a1803df08f44-6d864d96912mr49441546d6.29.1732728177053; 
 Wed, 27 Nov 2024 09:22:57 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e25sm67160976d6.89.2024.11.27.09.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:22:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [v6 02/12] test: Adjust print_ut test to use unsigned char
Date: Wed, 27 Nov 2024 11:17:20 -0600
Message-ID: <20241127172247.1488685-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127172247.1488685-1-trini@konsulko.com>
References: <20241127172247.1488685-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

Since char is unsigned on arm64, this test currently fails. It seems
better to use unsigned anyway, since 0xff is written into the string at
the start. Update the terminator-assert to use a character instead of a
byte.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Changes in v6:
- Re-introduce

Changes in v2:
- Use '\0' instead of 0

 test/print_ut.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
---
 test/common/print.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/common/print.c b/test/common/print.c
index 464e425edee5..e3711b108091 100644
--- a/test/common/print.c
+++ b/test/common/print.c
@@ -241,7 +241,7 @@ COMMON_TEST(print_display_buffer, UTF_CONSOLE);
 
 static int print_hexdump_line(struct unit_test_state *uts)
 {
-	char *linebuf;
+	u8 *linebuf;
 	u8 *buf;
 	int i;
 
@@ -254,10 +254,10 @@ static int print_hexdump_line(struct unit_test_state *uts)
 	linebuf = map_sysmem(0x400, BUF_SIZE);
 	memset(linebuf, '\xff', BUF_SIZE);
 	ut_asserteq(-ENOSPC, hexdump_line(0, buf, 1, 0x10, 0, linebuf, 75));
-	ut_asserteq(-1, linebuf[0]);
+	ut_asserteq(0xff, linebuf[0]);
 	ut_asserteq(0x10, hexdump_line(0, buf, 1, 0x10, 0, linebuf, 76));
-	ut_asserteq(0, linebuf[75]);
-	ut_asserteq(-1, linebuf[76]);
+	ut_asserteq('\0', linebuf[75]);
+	ut_asserteq(0xff, linebuf[76]);
 
 	unmap_sysmem(buf);
 
-- 
2.43.0

