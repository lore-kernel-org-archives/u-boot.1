Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA47BE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BAD4805D5;
	Mon,  6 Jan 2025 15:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="af9Hgz25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC71801E8; Mon,  6 Jan 2025 15:32:54 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA88805FC
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a7d7c1b190so50712635ab.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173969; x=1736778769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERfXSd7YiSS++3qmVhLnAmzOxsWyZRoAxr+Zqcuuf+c=;
 b=af9Hgz25uMGojTuFGW8RSW40ueAghTPxl0MHVi/AKf2usagU61e9IQEG47kryI/7XK
 8PPW7ixE32nQBr4mMO6eCySpMaOIgeH/6Q3iYLk7Gzdib369FYKJui7VXOJAS4zov7fD
 keBM7f+3enbyAejyWgaqrjGfSGD959E/rxcxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173969; x=1736778769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ERfXSd7YiSS++3qmVhLnAmzOxsWyZRoAxr+Zqcuuf+c=;
 b=aIe/+EpIy/vYp/uw9B4roXSN2bV8PnlMawPdjxg/ezmVjS9L9k3MMftO4W/kjAXC0j
 zFpXxEm+eeDA7ZCr9seOs9mjC9+bqzMvW8tzrZsvap0xUxWzsTVScqoCeaOCg3S+ClK3
 5F3sm2gV764GYJMXRoMoPJL9kd7JR2kC3/iFKo0tjeyedXbTQNnIvJ/D4VpAdUHHMjvi
 /5i7uX5bY2Fiocr3bIswNeXv8vJyf/RUNbAjGI5TBoAxA64gxv/8qRKxofgJJsIET/oT
 JsFaxrnPMKYge2kZTsMYepwnHe1mXskgkLdIDjrao3KDaP2HwkjFcTvxATvEpEw0X97s
 tl/w==
X-Gm-Message-State: AOJu0Yz6SqVrNL5o/HtX0j7ed6QlDUQEFedzUqD/cY3m+wSSUds60L7F
 Y+pwQmNtjW+tSlzXIFMhqflBy+Y6Wc9Mh6H7njfbptjGZSwt6nu1eEcxDw8Nnd45MSot28uAPJY
 =
X-Gm-Gg: ASbGncsBcLoq3S24olQmrOBcYTvWU9XQFHgNxUOgMsMsRdwINnyiakyBVAdtlRJgdGF
 CQP5+kzD6I7Xn5FKF4npbWVoogDKynnwctFeNVvf0g9yE8N9C/3V+HaAepgi4tsvFW/0dsL1Sbw
 0pDCA7lfF2QLxyYC6MXj9IRd98sZdM0cBijQGwmTixUzO/vVJoolHPxGkey5qn4g+NgiITt7R7U
 ZHxUQ2TH4JrbcwSDl5zubA//Uc2BWlSKfgubX5fWLaDii1+c06iP5fu9pQszq6MiShXWwtgSIX6
 r2bqyiHqCYc3cSbhsg==
X-Google-Smtp-Source: AGHT+IF97vW/kNwUOfeghalBu6mIiPiVIst6MRGk1rZttEx6dibwXU6l0JMsWlMJdChkCGp+izERqg==
X-Received: by 2002:a05:6e02:20ed:b0:3a7:e592:55ee with SMTP id
 e9e14a558f8ab-3c2d5724dbemr481908225ab.20.1736173969360; 
 Mon, 06 Jan 2025 06:32:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:32:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/33] abuf: Provide a way to get the buffer address
Date: Mon,  6 Jan 2025 07:32:00 -0700
Message-Id: <20250106143229.3023771-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

In many cases it is useful to get the address of a buffer, e.g. when
booting from it. Add a function to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/abuf.h  | 8 ++++++++
 lib/abuf.c      | 6 ++++++
 test/lib/abuf.c | 4 +++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/abuf.h b/include/abuf.h
index be98ec78c86..76e314b9a47 100644
--- a/include/abuf.h
+++ b/include/abuf.h
@@ -42,6 +42,14 @@ static inline size_t abuf_size(const struct abuf *abuf)
 	return abuf->size;
 }
 
+/**
+ * abuf_addr() - Get the address of a buffer's data
+ *
+ * @abuf: Buffer to check
+ * Return: address of buffer
+ */
+ulong abuf_addr(const struct abuf *abuf);
+
 /**
  * abuf_set() - set the (unallocated) data in a buffer
  *
diff --git a/lib/abuf.c b/lib/abuf.c
index 937c3df351e..8156177c773 100644
--- a/lib/abuf.c
+++ b/lib/abuf.c
@@ -26,6 +26,12 @@ void abuf_map_sysmem(struct abuf *abuf, ulong addr, size_t size)
 {
 	abuf_set(abuf, map_sysmem(addr, size), size);
 }
+
+ulong abuf_addr(const struct abuf *abuf)
+{
+	return map_to_sysmem(abuf->data);
+}
+
 #else
 /* copied from lib/string.c for convenience */
 static char *memdup(const void *src, size_t len)
diff --git a/test/lib/abuf.c b/test/lib/abuf.c
index 7c0481ab610..5d61f9261c6 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -46,7 +46,7 @@ static int lib_test_abuf_set(struct unit_test_state *uts)
 }
 LIB_TEST(lib_test_abuf_set, 0);
 
-/* Test abuf_map_sysmem() */
+/* Test abuf_map_sysmem() and abuf_addr() */
 static int lib_test_abuf_map_sysmem(struct unit_test_state *uts)
 {
 	struct abuf buf;
@@ -60,6 +60,8 @@ static int lib_test_abuf_map_sysmem(struct unit_test_state *uts)
 	ut_asserteq(TEST_DATA_LEN, buf.size);
 	ut_asserteq(false, buf.alloced);
 
+	ut_asserteq(addr, abuf_addr(&buf));
+
 	return 0;
 }
 LIB_TEST(lib_test_abuf_map_sysmem, 0);
-- 
2.34.1

