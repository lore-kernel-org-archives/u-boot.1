Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF3DD42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E1189442;
	Tue, 12 Nov 2024 15:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DJfbxN/e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 708AF8944D; Tue, 12 Nov 2024 15:11:18 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5761089246
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-83ac05206c9so211407439f.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420674; x=1732025474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmLRp7fU0BiNomCggLq0JwL7ZvNwMWVFWYgjLyF2XCQ=;
 b=DJfbxN/eAtVnxb7fOiV9zqfow5hRoFx96mC8mFC2zD3EixYnHRrJaIAUlw9IMuwVrP
 3vGMLv6X7AkqhEfNOEJOQMQuUP7w9BudSPTTSbBRyPNWR6lluftRqCj7Oz1vBSx9qW6l
 Tl/PbBS6q0k+U3lb54nxXXVBHPRUbHCwwGSoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420674; x=1732025474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JmLRp7fU0BiNomCggLq0JwL7ZvNwMWVFWYgjLyF2XCQ=;
 b=pm06WvTJNuUOBPPrMKffyUjqd/JT2W6+5kA/hqMxCNEaLQddasIqCvNQz685Xkph8B
 LYmGrTwOi9ymYQPYbDDnSpmTeKXjue6oxT7Mk/2AHcJxVfXs2HJPc39DBPqc7dWXhWnm
 pyegpPTGWk79Di/dhppOS4WcMZB4b+vbwCR1U9+YNMwxBFbvpllUivBv/ooGM5gChsgy
 2+vEIl4vtxXtroh8BtYchg6d+plA77BPTq82zNOzTq9oJhSnK+DrQ8i+TFJXtKtZpybO
 Dnl4LcYiHoZGkwUyf6v6gsUXLukkttGHkXNk81NPdytgDVlBpXVuqBeij3vYLIT58Dsf
 Zptg==
X-Gm-Message-State: AOJu0YxKyizKhq4+P2ZPX1YlbDO+Vpz2R8vU1MmulCp3RE4ahORcUawT
 IiqLfIhTgHyAUVjfQ6ByLNh8LB54hnVeVf3rz2gumfrYz3Uor+khyy0CD0rz9Q5Hl87Fyu+scvI
 =
X-Google-Smtp-Source: AGHT+IHujtatXezUhLWCyxyAGwgnnoWCOwhd+5hBZPs89hHSQWtGJsueW6e2SoS2r6AG7yh6e5ZLVQ==
X-Received: by 2002:a05:6602:1607:b0:83a:71c6:26fb with SMTP id
 ca18e2360f4ac-83e032a82c0mr2020980239f.6.1731420674450; 
 Tue, 12 Nov 2024 06:11:14 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de783d11f0sm1977776173.0.2024.11.12.06.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:11:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v3 2/9] test: Adjust print_ut test to use unsigned char
Date: Tue, 12 Nov 2024 07:10:58 -0700
Message-Id: <20241112141105.640189-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141105.640189-1-sjg@chromium.org>
References: <20241112141105.640189-1-sjg@chromium.org>
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

