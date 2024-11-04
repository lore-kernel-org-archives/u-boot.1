Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6EDD132C7
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B0B388D5D;
	Mon,  4 Nov 2024 14:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gZL/JZi3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD3C488D3A; Mon,  4 Nov 2024 14:40:08 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4629288D45
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:40:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-83aad8586d3so177521839f.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730727604; x=1731332404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWS1vB5shJVhAwh6dr2c75GxM5dKSk7hj7YE9Gs5Dpg=;
 b=gZL/JZi3PfeH6jXuwtAyC+mwCrvI7dooX/b82Y1A0b1oUafiu1vP2ePYlDljGA2C6j
 npNy4dMUuxecPbqvtJxoHeTU5VvXM0AANFFyexsX3NlGGTZ4xNKyM5L+M5BGr5T54EUZ
 DB/tHUJUCjBxO3l3vah0P8c1TlZ8qkprTdom0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727604; x=1731332404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWS1vB5shJVhAwh6dr2c75GxM5dKSk7hj7YE9Gs5Dpg=;
 b=e6imGEmZV8sLv42SfQ4L+/XGmm6O7jlkXr4o/SJazLOPpOxU9dsdQkrsbW42m7oHPM
 3Mn8Ncj5Sc/RTtnjaPssrq/OqIDa9pEI+YyR63J3aCra6IRXPF4x/qcLAnQoDgG/UlRf
 6KUFJjBQjuNT/wcaXTkk5p2VLMvruqZNxsFH0VzcncMebdbxhAAy9+ovoEIwnI0LpAjb
 QRItBQ9Bz3N67y1369zZMC9Ogk8hy4Ar4HTTDK0/KZxWIaXPDBEN3ebm86qJWPIxs2/0
 qRb44SJOsEAb0efrJauacOg4ZsIv7Arw2mhj1os1uEOI9n/u6ny8Xw09O4W8hK5TEbph
 dzcQ==
X-Gm-Message-State: AOJu0YxAFJPxoc9lsp3h5idIUgcLu4sBnW/dE9fZybFH0r7DmBhlt/UY
 zbY1nZpwrHgGM98GhVonCxOjy5tAroO7PgX3NOqW08/Ni+nGJwj6lRz6xZY3TA8yxtdkhtcpvhE
 =
X-Google-Smtp-Source: AGHT+IGlSRcd0KNC3oD4rKQC3l6Jcj/dUhNndZTKMN/wvRVkbGqjQ5hGL0oCxXxfmrbuUPkPDjizjA==
X-Received: by 2002:a05:6602:1492:b0:82a:a76a:1779 with SMTP id
 ca18e2360f4ac-83b71996903mr1319821739f.8.1730727604431; 
 Mon, 04 Nov 2024 05:40:04 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048895f3sm1935128173.12.2024.11.04.05.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:40:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH 2/9] test: Adjust print_ut test to use unsigned char
Date: Mon,  4 Nov 2024 06:39:46 -0700
Message-Id: <20241104133954.840994-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104133954.840994-1-sjg@chromium.org>
References: <20241104133954.840994-1-sjg@chromium.org>
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

Since char is unsigned on arm64, this test currently fails. It seems
better to use unsigned anyway, since 0xff is written into the string at
the start.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/print_ut.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/print_ut.c b/test/print_ut.c
index f5e607b21a3..7e5c015f3a7 100644
--- a/test/print_ut.c
+++ b/test/print_ut.c
@@ -242,7 +242,7 @@ PRINT_TEST(print_display_buffer, UTF_CONSOLE);
 
 static int print_hexdump_line(struct unit_test_state *uts)
 {
-	char *linebuf;
+	u8 *linebuf;
 	u8 *buf;
 	int i;
 
@@ -255,10 +255,10 @@ static int print_hexdump_line(struct unit_test_state *uts)
 	linebuf = map_sysmem(0x400, BUF_SIZE);
 	memset(linebuf, '\xff', BUF_SIZE);
 	ut_asserteq(-ENOSPC, hexdump_line(0, buf, 1, 0x10, 0, linebuf, 75));
-	ut_asserteq(-1, linebuf[0]);
+	ut_asserteq(0xff, linebuf[0]);
 	ut_asserteq(0x10, hexdump_line(0, buf, 1, 0x10, 0, linebuf, 76));
 	ut_asserteq(0, linebuf[75]);
-	ut_asserteq(-1, linebuf[76]);
+	ut_asserteq(0xff, linebuf[76]);
 
 	unmap_sysmem(buf);
 
-- 
2.34.1

