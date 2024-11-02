Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B8FE677E8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6674E89341;
	Sat,  2 Nov 2024 20:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EKSZbSJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 724FB890C4; Sat,  2 Nov 2024 20:38:10 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5340B89321
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cc03b649f2so21678736d6.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576287; x=1731181087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQEu3DfnFqhehGva0ekVgSE/eRNuiLF7Qh4NbkOC+/4=;
 b=EKSZbSJLZWjQFfbt+6Pbbvp/ITW0uvizdZ49fKIsA/6wN3l2+MRb2d9eSXMAG7b02s
 C1Aevs1jG69eS4rnVkqB/T3qO0hhEafMdmxxs1SXzbTIo2CVzgwGyWfZ6rLV5ynk6EQr
 p693vc9hGwQoA5pk6Rkg3Vlc06Xw65kAQ3ic8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576287; x=1731181087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQEu3DfnFqhehGva0ekVgSE/eRNuiLF7Qh4NbkOC+/4=;
 b=ictWLPOsIwqTzcx0v4y444mBSJQMlOQaWR+GZbmcLqGig7BYFQWAO84f9Ufto37quV
 mnnUKweNsBmLfP5kMkHFCrrEstLqSTOyPFqc4CpU9BtAl1xnrSdSs0yB/EHZobq/N41u
 hTKsB1xrcwkZHJIZ9FQNuWUfRc13IOr90C/9wACTiXYQDKd/1+DhXygHID4nZVVz8Ace
 ARc1E20P4MKCpdYAdlNz/4feRvZEJ7S1ZA0Vd+3IqF6lUU5qll/b3r3QjhhPlN05cJcp
 0hCW7O7DbRjsv6KeglD+v0nsuDVnDrF8XObphKTAY4oHm+VbPzpi6fMBOlxEqG4hURf8
 5zRw==
X-Gm-Message-State: AOJu0YynKEU964AVnjZQ+APaXDP27R9zTvKoHllSnGvQ5AtmsRpZhj3n
 qu1CKPeL1nMNQhQPfjqJwesahzq6bYNgI4EESEwyBk5LIqwPAZVG1+LMCNQSvAtwS5kNwAJhmiQ
 OXfaP
X-Google-Smtp-Source: AGHT+IFXBHY2m8Sxe578F7xyLGXNrb+uorAXM7Hv3TOQB1Ab8Gm5Rb4sbcG1szBHe9Og1BnSkwkkJg==
X-Received: by 2002:a05:6214:4a08:b0:6cd:f6de:8ad2 with SMTP id
 6a1803df08f44-6d351b2f72amr143420896d6.45.1730576286754; 
 Sat, 02 Nov 2024 12:38:06 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:38:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 20/20] test: Quote test names
Date: Sat,  2 Nov 2024 13:37:05 -0600
Message-ID: <20241102193715.432529-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

When mentioning a test name, add single quotes to make it easier to see.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Drop patch to move bloblist into the common suite

 test/test-main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/test-main.c b/test/test-main.c
index e4f42689da4..c825f9c7797 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -594,14 +594,14 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 			 */
 			len = strlen(test_name);
 			if (len < 6 || strcmp(test_name + len - 6, "_norun")) {
-				printf("Test %s is manual so must have a name ending in _norun\n",
+				printf("Test '%s' is manual so must have a name ending in _norun\n",
 				       test_name);
 				uts->fail_count++;
 				return -EBADF;
 			}
 			if (!uts->force_run) {
 				if (select_name) {
-					printf("Test %s skipped as it is manual (use -f to run it)\n",
+					printf("Test '%s' skipped as it is manual (use -f to run it)\n",
 					       test_name);
 				}
 				continue;
@@ -612,7 +612,7 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 		if (one && upto == pos) {
 			ret = ut_run_test_live_flat(uts, one);
 			if (uts->fail_count != old_fail_count) {
-				printf("Test %s failed %d times (position %d)\n",
+				printf("Test '%s' failed %d times (position %d)\n",
 				       one->name,
 				       uts->fail_count - old_fail_count, pos);
 			}
@@ -622,7 +622,7 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 		for (i = 0; i < uts->runs_per_test; i++)
 			ret = ut_run_test_live_flat(uts, test);
 		if (uts->fail_count != old_fail_count) {
-			printf("Test %s failed %d times\n", test_name,
+			printf("Test '%s' failed %d times\n", test_name,
 			       uts->fail_count - old_fail_count);
 		}
 		found++;
-- 
2.43.0

