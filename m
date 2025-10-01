Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A920CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E84083693;
	Wed,  1 Oct 2025 23:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B0DPr3HX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54A0483677; Wed,  1 Oct 2025 23:29:48 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C55835D8
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-4256f0fac67so3498305ab.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354184; x=1759958984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNebsohU/HTH7+iRxjI+zEowgFXueFHuq1JRC66kvSU=;
 b=B0DPr3HXFvEyoPKrUBgPal/OCB5OxYWh+7/yCyKuG7NbxmrZtmlZM9bhAAe8/HDZsj
 mxJSwGX9ZiCf3y6WOVwacuquW/Lx8WeW7DMRgSVeXMm3WYCsbT8d92WI6lU3QWRnXWt6
 tT5oM2E4uOl3IgvPGm+3+awOh2a6grirzJS8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354184; x=1759958984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNebsohU/HTH7+iRxjI+zEowgFXueFHuq1JRC66kvSU=;
 b=NSqnyc3RGpGJZ8jw9raQJ4YoHtlnMSrcrC5Pnv94rARzgigE54+zKWQdnKMAUeQe3z
 i8/696rLrwWVw9SEzMFmChcbIFN1z30hbiy7M3CQtZPWOMpmdN3S1bKzg0R4R6NMqKS2
 WluI35FlPMMQGe4gMr4ilHIyJ7PBIU0nTXU33DkFG1iuoxHQV7p2yJLjrDMwr34QgFns
 GKa2JCI1nLyM01gDyvv0V6I3npq813Ij1x0r9oicWvRAMssBgDnMCzhxMsoD3WImUf3M
 jUBRJMxWR37+FX5UNIjP96UIbYwE9mot3T+Db1P4ZfyJ2aoGwHodMsmrEE74BmjKdhRJ
 o/kA==
X-Gm-Message-State: AOJu0YyG45ID+f1B0IoNLfDqqXsS9o90FI5+23ik2SLTc9iCMYjk3oeS
 vBi8M9oBygTKGrx6NfxEGHV3NujWcB5F/NMcx8mb2PH3QQFurc2nlrgRQT/kbTf7ldiyaDx1jSJ
 23cSpcwKY
X-Gm-Gg: ASbGncux8B2royaI8VEKte13LYs/Q5t6KMLi4W2rrf02yuYRqvVhGABTELedZEA3KrK
 j1WefCAnOLSeEM55RZZfwCumhfUCJfpvZ03naLM1UOpobp4qSRTIvYcJihfuEt5P7GqTHWTp9ho
 +a5CxDZrF16OgrN3KmIJG6lKLr+vzlVg0kFmgX8XEuKUufeuvmAcakaxnx8MevSBGkTeouN4o8l
 prFNGAGW7TcXeAnADKbp0m9cUSylQHaLNFCtp/LK/qILbCD1UAP7JoZrvpyhE5Yicdhb4+YwmXc
 Du+GuYK32a1vqmv28CJH20qsuuXRKe6a5goarbyRsBLUPg5iuIADGzzM7mKBxwFaPW6B8/n+uJ5
 qpL49kAMGz1sgKOlvknBSB6OzqwXpSK7F7ex2teu+
X-Google-Smtp-Source: AGHT+IF8UFBnKKOD4+qBcWldclTk8Q9UeS8yON6jq1espJ+smXO8nNgeqEO7n4B/tkG8A1LIAtmIdw==
X-Received: by 2002:a05:6e02:4408:20b0:42d:84ec:b5cb with SMTP id
 e9e14a558f8ab-42d84ecb8c8mr34584385ab.7.1759354184383; 
 Wed, 01 Oct 2025 14:29:44 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/17] boot: Update first_glob_method when dropping a
 bootmeth
Date: Wed,  1 Oct 2025 15:26:32 -0600
Message-ID: <20251001212649.3263574-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
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

For now we only support dropping non-global bootmeths from the
iteration. Update first_glob_method in that case and add a few checks
that things are correct.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c      | 6 ++++++
 test/boot/bootflow.c | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 9aa9d449b7f..cf7a3befe8d 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -167,11 +167,17 @@ int bootflow_iter_drop_bootmeth(struct bootflow_iter *iter,
 	    iter->method_order[iter->cur_method] != bmeth)
 		return -EINVAL;
 
+	log_debug("Dropping bootmeth '%s'\n", bmeth->name);
+
 	memmove(&iter->method_order[iter->cur_method],
 		&iter->method_order[iter->cur_method + 1],
 		(iter->num_methods - iter->cur_method - 1) * sizeof(void *));
 
 	iter->num_methods--;
+	if (iter->first_glob_method > 0) {
+		iter->first_glob_method--;
+		log_debug("first_glob_method %d\n", iter->first_glob_method);
+	}
 
 	return 0;
 }
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index f6661530848..a65fcd3d4e3 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -483,7 +483,11 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 	/* Try to boot the bootmgr flow, which will fail */
 	console_record_reset_enable();
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
+
+	/* at this point the global bootmeths are stranded above num_methods */
 	ut_asserteq(3, iter.num_methods);
+	ut_assert(!iter.doing_global);
+	ut_asserteq(3, iter.first_glob_method);
 	ut_asserteq_str("sandbox", iter.method->name);
 	ut_assertok(inject_response(uts));
 	ut_asserteq(-ENOTSUPP, bootflow_run_boot(&iter, &bflow));
@@ -493,9 +497,13 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 
 	/* Check that the sandbox bootmeth has been removed */
 	ut_asserteq(2, iter.num_methods);
+
 	for (i = 0; i < iter.num_methods; i++)
 		ut_assert(strcmp("sandbox", iter.method_order[i]->name));
 
+	/* the first global bootmeth is now down one place in the list */
+	ut_asserteq(2, iter.first_glob_method);
+
 	return 0;
 }
 BOOTSTD_TEST(bootflow_iter_disable, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.43.0

