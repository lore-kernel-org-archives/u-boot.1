Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784A7D637A8
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 18:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DFE98870D;
	Wed, 13 Nov 2024 19:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gc3581Vl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D578931D; Wed, 13 Nov 2024 19:53:57 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE2D8936F
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a3b8b34be9so24254845ab.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731524033; x=1732128833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmLRp7fU0BiNomCggLq0JwL7ZvNwMWVFWYgjLyF2XCQ=;
 b=Gc3581VlZE2i+v9G1QFFEpdx+9r4iYB/0NOo/2cN1GYgsP+v47duibk2vXLsnA/ftT
 Jf7IxpRlhgtEZH6oOk1wk28Xrcd00L9eZSkzZiPaDVffHxUE1rgiVtn1uvvHL5Sf6aQp
 B1qhRY22J1IZOW0uRcan6hkRAMyD08TCpemuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731524033; x=1732128833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JmLRp7fU0BiNomCggLq0JwL7ZvNwMWVFWYgjLyF2XCQ=;
 b=mBXzLOZn7tZPsQIa3bXPRq7L7KpOqInK9RlcJxqhybuH63jsHGSmaKA0vMIH9IUgct
 1Cfb9Eu0qcb1u5nHqBU1bHOzwXH/DWpRsi90NwvUYvCClwEBavjejBI4LHM+exceLHm/
 cAbZNkHKZq0i4sMGPwf+apcdVcIkVcGw82VLK+28rIRHWBm80qLEQQzirnklhLouDyey
 ZKoJeMXEtAYQOnf1ULu2Pbf7fi9gN8ysO29o77ukjxVXZrvWPAp9ii9y6zO7HoJtpg7v
 HBfZRAzPsLZ9yFRrqHjpKsZLaj7MI+44/XtgAYiHUvM3JANQNLsLJHgCW/yamu1bITd3
 e7PA==
X-Gm-Message-State: AOJu0YwhZSU1l2sDQlNk+r7dGL5hBiWSDzk79d4o/XUuGyaYg41+6dqj
 CUywWTIJ1LvMy4k+dImy58NNcJOKf0PH0Bauyakn/bSGtbOrd444qe3+944ldGWBykxM5CvUhMQ
 =
X-Google-Smtp-Source: AGHT+IEW8E7fQjOCvu3ZCRE9Z3mMiEBzFnPEwZY72VR7ybqxojbg6XInDfOAmg4/98hZDzVpfUsGww==
X-Received: by 2002:a05:6e02:1fef:b0:3a7:1d03:49b0 with SMTP id
 e9e14a558f8ab-3a71d034a82mr15025955ab.8.1731524032840; 
 Wed, 13 Nov 2024 10:53:52 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f9890ec4sm30733675ab.75.2024.11.13.10.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 10:53:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v4 2/9] test: Adjust print_ut test to use unsigned char
Date: Wed, 13 Nov 2024 11:53:33 -0700
Message-Id: <20241113185340.1661198-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113185340.1661198-1-sjg@chromium.org>
References: <20241113185340.1661198-1-sjg@chromium.org>
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
the start. Update the terminator-assert to use a character instead of a
byte.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v2)

Changes in v2:
- Use '\0' instead of 0

 test/print_ut.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/print_ut.c b/test/print_ut.c
index f5e607b21a3..7ab79e4617f 100644
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
-	ut_asserteq(0, linebuf[75]);
-	ut_asserteq(-1, linebuf[76]);
+	ut_asserteq('\0', linebuf[75]);
+	ut_asserteq(0xff, linebuf[76]);
 
 	unmap_sysmem(buf);
 
-- 
2.34.1

