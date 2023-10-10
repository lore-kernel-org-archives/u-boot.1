Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A29CD68F5
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 07:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93DC786B1B;
	Tue, 10 Oct 2023 09:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gjYYppif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4341D86D20; Tue, 10 Oct 2023 09:34:03 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5692986AF7
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 09:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=monakov.y@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-65af8d30b33so44261246d6.1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696923239; x=1697528039; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dyT5qJivSRZL27JWDrpKUGHsggIqZaRV5/dyavxasNo=;
 b=gjYYppifKSQAoi8wOomWpWrjptMtUEkQMYRSY7V+WeAyYTUcHuJgE76kr4pQtgEK5c
 Fhi7nNtITAwSnr+8xiGJaq7ParHnVQhoqPiMx5Lj5lI2ZSrRzsaNfu4YKI7V1cJWbAv5
 Zvj8uG5s3AsuN6pr5Ma2pFgX7ciEYAAXCWjotXBGWzW0gwQ7IYJCkmyLSWZWfMhl9JxI
 rQdH6YlrCzwwpBeFocwptSqVA7ZP81aoDe4SaXbuH9LNoAXuE0hCmxzpQCA8L+QjD6or
 wwQpVysON9QBhBJUB11RbLdI/WbH6MrmlcqJS1gGMPdK/j4aemXqYNmbLB17XJikJpV8
 VFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696923239; x=1697528039;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dyT5qJivSRZL27JWDrpKUGHsggIqZaRV5/dyavxasNo=;
 b=A4JqhsMNNLRP2DtfpGjZoY8Zra2BProzdkUTJMwgjvBWsST/ceSAaqBRtyUQ+Ez5U+
 XqSHl9sgL9T9jzTssjN/i6P9iy8WUT0yLeFyAIuA8pxhNC0GQNf6llFG6DdfM1hdBKWi
 6VFK9oPVDSPNSuVz73GUDCXgjmDRuy+hh3MBKYBJ7aRMMelXxtrtoqzEniX440DRuvp7
 TXyQ4lL3RsaSukemd0cN0ar/YT5GS5U45/Nfmj2IHr5gPmXjIP0K/L3PYTUOr5Nq4xe1
 f1CwmtUkv8UnL/1FSGEprQ8X+TFHlotiM8uXeQlWTX3JGdA6oMqUqS9/BLQzul2ofUeZ
 XGyw==
X-Gm-Message-State: AOJu0YygArTRgZjsqGtMzpfMLQsyzhnmIQbINHSxPk3iNblRr6bOImV1
 mbb1vOZvLhW6ooxJTVqu3YoPdXn2hPLEdusezpdSsekUJmc=
X-Google-Smtp-Source: AGHT+IFyRaKvBEp3QJJc9n33NMSMw8XVYz+7dRZySY9iUJAXeCZalqRGJFs1YhDR6HnlzkPj8rX5L30+mwK+pR6tAeo=
X-Received: by 2002:a0c:b20a:0:b0:668:e6f7:3d42 with SMTP id
 x10-20020a0cb20a000000b00668e6f73d42mr13126809qvd.9.1696923238959; Tue, 10
 Oct 2023 00:33:58 -0700 (PDT)
MIME-Version: 1.0
From: Yurii Monakov <monakov.y@gmail.com>
Date: Tue, 10 Oct 2023 10:33:48 +0300
Message-ID: <CAM-z4v6Q==7d8NY_8Tq6ZssrighO0YhHjnYzUTeud7Y96cVivA@mail.gmail.com>
Subject: [PATCH v2] cli: Consume invalid escape sequences early
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Unexpected 'Esc' key presses are accumulated internally, even if it is
already clear that the current escape sequence is invalid. This results
in weird behaviour. For example, the next character after 'Esc' key
simply disappears from input and 'Unknown command' is printed
after 'Enter'.

This commit fixes some issues with extra 'Esc' keys entered by user:

1. Sequence <Esc><Esc><Enter> right after autoboot stop gives:
=>
nknown command 'ry 'help'
=>
2. Sequence <Esc><p><r><i><Enter> gives:
=> ri
Unknown command 'ri' - try 'help'
=>
3. Extra 'Esc' key presses break backspace functionality.

Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
---
 common/cli_getch.c  |  2 ++
 test/common/cread.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/common/cli_getch.c b/common/cli_getch.c
index 61d4cb261b..0ee7908777 100644
--- a/common/cli_getch.c
+++ b/common/cli_getch.c
@@ -46,6 +46,8 @@ static int cli_ch_esc(struct cli_ch_state *cch, int ichar,
  case 1:
  if (ichar == '[' || ichar == 'O')
  act = ESC_SAVE;
+ else
+ act = ESC_CONVERTED;
  break;
  case 2:
  switch (ichar) {
diff --git a/test/common/cread.c b/test/common/cread.c
index 2fdd29a265..4edc773960 100644
--- a/test/common/cread.c
+++ b/test/common/cread.c
@@ -43,6 +43,12 @@ static int cli_ch_test(struct unit_test_state *uts)
  ut_asserteq('a', cli_ch_process(cch, 'a'));
  ut_asserteq(0, cli_ch_process(cch, 0));

+ /* unexpected 'Esc' */
+ ut_asserteq('a', cli_ch_process(cch, 'a'));
+ ut_asserteq(0, cli_ch_process(cch, '\e'));
+ ut_asserteq('b', cli_ch_process(cch, 'b'));
+ ut_asserteq(0, cli_ch_process(cch, 0));
+
  return 0;
 }
 COMMON_TEST(cli_ch_test, 0);
@@ -80,6 +86,12 @@ static int cread_test(struct unit_test_state *uts)
  ut_asserteq(7, cli_readline_into_buffer("-> ", buf, 1));
  ut_asserteq_str("abc\e[Xx", buf);

+ /* unexpected 'Esc' */
+ *buf = '\0';
+ ut_asserteq(7, console_in_puts("abc\eXx\n"));
+ ut_asserteq(5, cli_readline_into_buffer("-> ", buf, 1));
+ ut_asserteq_str("abcXx", buf);
+
  /* check timeout, should be between 1000 and 1050ms */
  start = get_timer(0);
  *buf = '\0';
-- 
2.34.1
