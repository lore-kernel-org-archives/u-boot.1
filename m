Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71E3D10C11
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 645C8890F6;
	Mon, 28 Oct 2024 13:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hNivARM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C62D890F6; Mon, 28 Oct 2024 13:48:31 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E37B890CE
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso511514466b.3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119708; x=1730724508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aypvXJz0tWt9r8gg3LW2icRulKABKf6RI2MDhNP5h7w=;
 b=hNivARM7NoJWbbIAS3GnZhTY0/7VBah4utcwWGBVHVncyLGyylIP93zsPkMprWfL1x
 wiydnZ+FC0t0/rb7CQNm1qwxFPUaneY1I8nV/zX7KqKM9QcyKYircszOFV5y7v5K6Sn1
 h2vei//Lql8Y/be/ZYSviD+d5k/MfwjxcUB4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119708; x=1730724508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aypvXJz0tWt9r8gg3LW2icRulKABKf6RI2MDhNP5h7w=;
 b=ZTPhAsvgQuW0Lv55izwSrmC+4d26d9k+vxSB7vLRfv+1OKlAwych4cYnfWyu4tmgSv
 GPLoFSaQtHLfwRWFTk3+S/MaeOG/wBfFKop2Y+qtz31oFYDtNM90/EvXpfX8mnooS4nI
 73lg6FNMs03U7j7x1mjS1uxqPw/ReTXz5fldjtFFBK3hTutL2ajfGA6iaA3jTdFrHIEk
 DtNCJOo7JZ1TmUNBcT6iqG3Lr3slDx9iagi6hiNBd/d0yHmACGCAmKbLfURNmW8XH1so
 zV7kN2WyPqJqSO6ing3Hd40DQFxkbgH6tApzsOpm6G0ssAoExJhjACySYXFpvZ0U/1R1
 focQ==
X-Gm-Message-State: AOJu0YzxTnGKbEUcz/wKQuwJ7veWke90bucsmRRo1wxJo1ZfGSk31tCj
 vgtwraaSzljU38rwUtruKAGbVRL5RjIRzg1GZhrcFZuR50AQR9EhIqLJ422FLBBjQXIg1a+yPPx
 Qvg==
X-Google-Smtp-Source: AGHT+IHI1D+GoqZnBolGKFheHh/9OyCMS0PSoFk6Skmu+YooO/cftehydOjRRhsYChkkiLjdPFL3eg==
X-Received: by 2002:a17:907:9807:b0:a99:ed0c:1d6 with SMTP id
 a640c23a62f3a-a9de61cf1a5mr687225066b.49.1730119708165; 
 Mon, 28 Oct 2024 05:48:28 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH 03/15] bloblist: test: Mark tests with UTF_BLOBLIST
Date: Mon, 28 Oct 2024 13:47:54 +0100
Message-ID: <20241028124815.47262-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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

Mark bloblist tests with this flag so that other tests which use
bloblist remain unaffected.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/common/bloblist.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index dbd174299fd..4ff0234ca00 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -87,7 +87,7 @@ static int bloblist_test_init(struct unit_test_state *uts)
 
 	return 1;
 }
-COMMON_TEST(bloblist_test_init, 0);
+COMMON_TEST(bloblist_test_init, UFT_BLOBLIST);
 
 static int bloblist_test_blob(struct unit_test_state *uts)
 {
@@ -127,7 +127,7 @@ static int bloblist_test_blob(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(bloblist_test_blob, 0);
+COMMON_TEST(bloblist_test_blob, UFT_BLOBLIST);
 
 /* Check bloblist_ensure_size_ret() */
 static int bloblist_test_blob_ensure(struct unit_test_state *uts)
@@ -161,7 +161,7 @@ static int bloblist_test_blob_ensure(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(bloblist_test_blob_ensure, 0);
+COMMON_TEST(bloblist_test_blob_ensure, UFT_BLOBLIST);
 
 static int bloblist_test_bad_blob(struct unit_test_state *uts)
 {
@@ -177,7 +177,7 @@ static int bloblist_test_bad_blob(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(bloblist_test_bad_blob, 0);
+COMMON_TEST(bloblist_test_bad_blob, UFT_BLOBLIST);
 
 static int bloblist_test_checksum(struct unit_test_state *uts)
 {
@@ -250,7 +250,7 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(bloblist_test_checksum, 0);
+COMMON_TEST(bloblist_test_checksum, UFT_BLOBLIST);
 
 /* Test the 'bloblist info' command */
 static int bloblist_test_cmd_info(struct unit_test_state *uts)
@@ -271,7 +271,7 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(bloblist_test_cmd_info, UTF_CONSOLE);
+COMMON_TEST(bloblist_test_cmd_info, UFT_BLOBLIST | UTF_CONSOLE);
 
 /* Test the 'bloblist list' command */
 static int bloblist_test_cmd_list(struct unit_test_state *uts)
@@ -293,7 +293,7 @@ static int bloblist_test_cmd_list(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(bloblist_test_cmd_list, UTF_CONSOLE);
+COMMON_TEST(bloblist_test_cmd_list, UFT_BLOBLIST | UTF_CONSOLE);
 
 /* Test alignment of bloblist blobs */
 static int bloblist_test_align(struct unit_test_state *uts)
@@ -351,7 +351,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(bloblist_test_align, 0);
+COMMON_TEST(bloblist_test_align, UFT_BLOBLIST);
 
 /* Test relocation of a bloblist */
 static int bloblist_test_reloc(struct unit_test_state *uts)
@@ -385,7 +385,7 @@ static int bloblist_test_reloc(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(bloblist_test_reloc, 0);
+COMMON_TEST(bloblist_test_reloc, UFT_BLOBLIST);
 
 /* Test expansion of a blob */
 static int bloblist_test_grow(struct unit_test_state *uts)
@@ -438,7 +438,7 @@ static int bloblist_test_grow(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(bloblist_test_grow, 0);
+COMMON_TEST(bloblist_test_grow, UFT_BLOBLIST);
 
 /* Test shrinking of a blob */
 static int bloblist_test_shrink(struct unit_test_state *uts)
@@ -488,7 +488,7 @@ static int bloblist_test_shrink(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(bloblist_test_shrink, 0);
+COMMON_TEST(bloblist_test_shrink, UFT_BLOBLIST);
 
 /* Test failing to adjust a blob size */
 static int bloblist_test_resize_fail(struct unit_test_state *uts)
@@ -523,7 +523,7 @@ static int bloblist_test_resize_fail(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(bloblist_test_resize_fail, 0);
+COMMON_TEST(bloblist_test_resize_fail, UFT_BLOBLIST);
 
 /* Test expanding the last blob in a bloblist */
 static int bloblist_test_resize_last(struct unit_test_state *uts)
@@ -574,7 +574,7 @@ static int bloblist_test_resize_last(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(bloblist_test_resize_last, 0);
+COMMON_TEST(bloblist_test_resize_last, UFT_BLOBLIST);
 
 /* Check a completely full bloblist */
 static int bloblist_test_blob_maxsize(struct unit_test_state *uts)
@@ -597,4 +597,4 @@ static int bloblist_test_blob_maxsize(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(bloblist_test_blob_maxsize, 0);
+COMMON_TEST(bloblist_test_blob_maxsize, UFT_BLOBLIST);
-- 
2.43.0

