Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8631C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4256988685;
	Tue, 11 Jun 2024 20:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="laarP0N1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61471886F0; Tue, 11 Jun 2024 20:51:01 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C2F28839D
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7ea0b5e0977so286439539f.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131858; x=1718736658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sdx3aaLQf2MdtvWEaj2rkEAZOFpgDbI7En5nH6j1bdk=;
 b=laarP0N1NPsyBSLIpAowfUS3y2TlP9pGPg6qcVdkB6K3aqQsWyahxWpuR9EjnHOIVu
 IB68++sZVGK+GRnQv9i70Ev0jizY3eGL8HOsEzf2HxwNSc9xZ9Q/qRBO++TikSoLA5P0
 FCyMkHj5WHjw5lw3vxTJLpWF9nrlWQV9h/caQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131858; x=1718736658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sdx3aaLQf2MdtvWEaj2rkEAZOFpgDbI7En5nH6j1bdk=;
 b=KA0TaiUnoy1DsAg2xWg20f29afIznz3k15qu9wx6dXaP5MjgFif3xVzfPIG+AJ9+cb
 DJExBKLSyZAwG0ZlYFf+avpLtkmDRBGyy/ua3qGo3VzBkKF5uO/8fCFJKa8+1b0k4J7W
 BjL+B7vzstfVGifHhm1ySmPtTQI1vob7CwEZqGxt4Ttlq7Ac+MvqnbiqDZkQ7rhEfQF1
 zb7TajVwBpXyqZebIMtWM9FR/ugXT6U0KpS/aBWbP4zj1IPI55ETlfDDIauDZdfAzT8N
 JvPraEmYBkccpG202rjkMtAvo6BTI3mX9813aRkXkg+G0YXOO3FrisOknzs7JA2FZ93b
 Vplw==
X-Gm-Message-State: AOJu0Yx6QLUCseQsBQ/33eVMT0GMIbL9Tb75GErAgDdrGIn+jcK4VvZq
 9Z3WsKrvEJzNLSWYpYBZCyc7LJJ1iYSFEukA+atQgjo+2bixI3io9sIbk+upnuSbXtLO+kEjnfz
 Mjg==
X-Google-Smtp-Source: AGHT+IFMXiqY+Se5qO4jSgqXaD9913nNXEFiMldbGSMRWYqctA/n0tpWI6gQY1yUmysJsw+zTBsNsQ==
X-Received: by 2002:a05:6602:60ce:b0:7eb:708a:3264 with SMTP id
 ca18e2360f4ac-7eb708a3721mr1201745339f.10.1718131857863; 
 Tue, 11 Jun 2024 11:50:57 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-37594285ca5sm19645715ab.42.2024.06.11.11.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 11:50:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] lib: Handle a special case with str_to_list()
Date: Tue, 11 Jun 2024 12:50:49 -0600
Message-Id: <20240611185051.2223452-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611185051.2223452-1-sjg@chromium.org>
References: <20240611185051.2223452-1-sjg@chromium.org>
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

The current implementation can return an extra result at the end when
the string ends with a space. Fix this by adding a special case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/strto.c   | 4 +++-
 test/str_ut.c | 4 +---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/strto.c b/lib/strto.c
index 5157332d6c1..f83ac67c666 100644
--- a/lib/strto.c
+++ b/lib/strto.c
@@ -236,12 +236,14 @@ const char **str_to_list(const char *instr)
 		return NULL;
 
 	/* count the number of space-separated strings */
-	for (count = *str != '\0', p = str; *p; p++) {
+	for (count = 0, p = str; *p; p++) {
 		if (*p == ' ') {
 			count++;
 			*p = '\0';
 		}
 	}
+	if (p != str && p[-1])
+		count++;
 
 	/* allocate the pointer array, allowing for a NULL terminator */
 	ptr = calloc(count + 1, sizeof(char *));
diff --git a/test/str_ut.c b/test/str_ut.c
index 389779859a3..96e048975d8 100644
--- a/test/str_ut.c
+++ b/test/str_ut.c
@@ -342,9 +342,7 @@ static int test_str_to_list(struct unit_test_state *uts)
 	ut_asserteq_str("space", ptr[3]);
 	ut_assertnonnull(ptr[4]);
 	ut_asserteq_str("", ptr[4]);
-	ut_assertnonnull(ptr[5]);
-	ut_asserteq_str("", ptr[5]);
-	ut_assertnull(ptr[6]);
+	ut_assertnull(ptr[5]);
 	str_free_list(ptr);
 	ut_assertok(ut_check_delta(start));
 
-- 
2.34.1

