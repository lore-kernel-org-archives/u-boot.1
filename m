Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B0AC3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D65582A7B;
	Tue, 29 Apr 2025 15:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="axHzKBLl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A35148296B; Tue, 29 Apr 2025 15:24:56 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57843828C2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c7336ed99so1484412a34.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933092; x=1746537892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RaVLpFm5ZRmDUkxIFlzPBtToSms4+7PDJfGN/uOumIY=;
 b=axHzKBLlYg2m3e/asN1WUVoSyJAUXrfcOoD5oLpoPVvnYQZIBtkNp4YGeVKopMc4lV
 yXLL1BPKNNhftMNFxp6nAfb/tGkooUMQ7EE9+w0+L0dQmohJ0XnGJInLjiOEgv71udh9
 eTmHd7lnxtqQ5ox6f8xNQUG8yrkXLXInHtg38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933092; x=1746537892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RaVLpFm5ZRmDUkxIFlzPBtToSms4+7PDJfGN/uOumIY=;
 b=RpngDoVKE35AgNAHnGR/El9rHdvhibXlA2gm1elwN24YbdMGcKHjq1J6ptGtLTizCL
 5tNcYKhP4mM6KAj/auRfFfkZ+j6oglOdMUCDnIi2LgyAEK9ajw+zFL/ZlAzYC1n2bdLM
 iMkhqET7cF5+NopGFZThmpBzEkSD72bKeTk0+mmNaAR9hYPDR748m2FbIhk9AfGmzs0T
 ULpBToBYCqO1RBtlNRP5LRVrw+019HOG5e8w39lxdWYaiOQgy3aHXwqX5jN6Nd3E2c81
 0MA7VoJewE3Xqrrp6YUwd3VjIc/i79zgcYeOdPWCQFwO9pl7lo807tvHXVVZOeYwKArs
 JK4A==
X-Gm-Message-State: AOJu0YxokcG5d66h7IwjKdGWraN0pdrDYCOTIXc1CivsOszSjFq14DEB
 /ewRAfWljR9p3NZ+UYt8NrqAQktV6PXQVjnYXlE7a9AmqR70QNvDnOhkTlzq9qscV+NT3mtlb2w
 =
X-Gm-Gg: ASbGncsUp+PoEwsT7L/dC+IvsgTFsPt+FmUtRsMTJaFa4/10rtqWIUFRGwsPgAoYK+r
 9GZVPxseXvzpxc9jqdCX65svz02jMgjHm04X/v6ehJPmcp1CPv9y3WgC6GK1PhV2XQApd2ROJI1
 4Me79hdjJldEY1f6884EE74KHBlNDsGeAZAYWin5R5uQOubUqjCQfkzbQ44BcwSoME6KOEC/P3K
 wsRRjXozmD49GcwUM0LKcbR4a1s1HsXASkJWpLGM90Zq4q+7MTPml6fUkSylnJkilkkHChJQSwA
 9cvTuvSveM2v33fu/rL/iwUD+Bcb4JaEI1uyzyydqoLUxzA2Dq4uPIZw8UpY5mK+hg5F964AnVo
 63Q==
X-Google-Smtp-Source: AGHT+IH80YGJzJk53IlJRhkc2xExXMz216bWb/ddF828Bj0gY6KouRhn9JMoazoZg8cEX6u3c2XMpQ==
X-Received: by 2002:a05:6808:4486:b0:3f9:aeb6:6eac with SMTP id
 5614622812f47-401fd79d3f8mr7188436b6e.30.1745933092147; 
 Tue, 29 Apr 2025 06:24:52 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 24/30] patman: Show patches in yellow
Date: Tue, 29 Apr 2025 07:22:21 -0600
Message-ID: <20250429132239.251756-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

When comments are shown below patches it can be hard to see the patch
subject. Use yellow instead of blue, since it stands out better.

Pass the colour object into show_responses() rather than creating a new
one, since that is tidier.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py |  8 ++++----
 tools/patman/status.py    | 15 ++++++++-------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 3f7573a41a8..47fbbe0cc3f 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -1043,7 +1043,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
                                      pwork)
         lines = iter(terminal.get_print_test_lines())
         col = terminal.Color()
-        self.assertEqual(terminal.PrintLine('  1 Subject 1', col.BLUE),
+        self.assertEqual(terminal.PrintLine('  1 Subject 1', col.YELLOW),
                          next(lines))
         self.assertEqual(
             terminal.PrintLine('    Reviewed-by: ', col.GREEN, newline=False,
@@ -1052,7 +1052,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         self.assertEqual(terminal.PrintLine(self.joe, col.WHITE, bright=False),
                          next(lines))
 
-        self.assertEqual(terminal.PrintLine('  2 Subject 2', col.BLUE),
+        self.assertEqual(terminal.PrintLine('  2 Subject 2', col.YELLOW),
                          next(lines))
         self.assertEqual(
             terminal.PrintLine('    Reviewed-by: ', col.GREEN, newline=False,
@@ -1359,7 +1359,7 @@ Reviewed-by: %s
                                      pwork)
         lines = iter(terminal.get_print_test_lines())
         col = terminal.Color()
-        self.assertEqual(terminal.PrintLine('  1 Subject 1', col.BLUE),
+        self.assertEqual(terminal.PrintLine('  1 Subject 1', col.YELLOW),
                          next(lines))
         self.assertEqual(
             terminal.PrintLine('  + Reviewed-by: ', col.GREEN, newline=False),
@@ -1380,7 +1380,7 @@ Reviewed-by: %s
             '    Here is my comment above the above...', None), next(lines))
         self.assertEqual(terminal.PrintLine('', None), next(lines))
 
-        self.assertEqual(terminal.PrintLine('  2 Subject 2', col.BLUE),
+        self.assertEqual(terminal.PrintLine('  2 Subject 2', col.YELLOW),
                          next(lines))
         self.assertEqual(
             terminal.PrintLine('  + Reviewed-by: ', col.GREEN, newline=False),
diff --git a/tools/patman/status.py b/tools/patman/status.py
index 5c75d7b10c6..c114a432bf3 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -203,10 +203,11 @@ def find_new_responses(new_rtag_list, review_list, seq, cmt, patch, pwork):
     new_rtag_list[seq] = new_rtags
     review_list[seq] = reviews
 
-def show_responses(rtags, indent, is_new):
+def show_responses(col, rtags, indent, is_new):
     """Show rtags collected
 
     Args:
+        col (terminal.Colour): Colour object to use
         rtags (dict): review tags to show
             key: Response tag (e.g. 'Reviewed-by')
             value: Set of people who gave that response, each a name/email string
@@ -216,14 +217,14 @@ def show_responses(rtags, indent, is_new):
     Returns:
         int: Number of review tags displayed
     """
-    col = terminal.Color()
     count = 0
     for tag in sorted(rtags.keys()):
         people = rtags[tag]
         for who in sorted(people):
             terminal.tprint(indent + '%s %s: ' % ('+' if is_new else ' ', tag),
-                           newline=False, colour=col.GREEN, bright=is_new)
-            terminal.tprint(who, colour=col.WHITE, bright=is_new)
+                           newline=False, colour=col.GREEN, bright=is_new,
+                           col=col)
+            terminal.tprint(who, colour=col.WHITE, bright=is_new, col=col)
             count += 1
     return count
 
@@ -357,14 +358,14 @@ def do_show_status(series, patch_for_commit, show_comments, new_rtag_list,
         if not patch:
             continue
         terminal.tprint('%3d %s' % (patch.seq, patch.subject[:50]),
-                       colour=col.BLUE)
+                       colour=col.YELLOW, col=col)
         cmt = series.commits[seq]
         base_rtags = cmt.rtags
         new_rtags = new_rtag_list[seq]
 
         indent = ' ' * 2
-        show_responses(base_rtags, indent, False)
-        num_to_add += show_responses(new_rtags, indent, True)
+        show_responses(col, base_rtags, indent, False)
+        num_to_add += show_responses(col, new_rtags, indent, True)
         if show_comments:
             for review in review_list[seq]:
                 terminal.tprint('Review: %s' % review.meta, colour=col.RED)
-- 
2.43.0

