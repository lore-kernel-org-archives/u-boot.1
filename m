Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C234C3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11ECE8887A;
	Tue, 30 Jul 2024 16:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K4a8aD9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C12F48887A; Tue, 30 Jul 2024 16:40:04 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B585888847
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-39949ebafc2so18505065ab.1
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722350400; x=1722955200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiorbJr5W30iyqHwCPgZi6RbEbcE4DwrMZBLGDyP3qw=;
 b=K4a8aD9pnk7kdp41ZwV+RMt+SUd5wU/iPbqGRD3ZlNpsrLIHtg/VDHvWv5CVYgQ3Aa
 1HpcgoWOtz2JIGpA1XKzQxVvmL50sKeLqQFjd7n00GeYgI0wVZZJTD5rjZCdLLXr+UQL
 TDY/xhCL4gVsWjeebXSFKK9fCsogWLfFP7hPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722350400; x=1722955200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LiorbJr5W30iyqHwCPgZi6RbEbcE4DwrMZBLGDyP3qw=;
 b=soIyEHUyZ1wvbO082XTC+SwMalOZeUH6BS4ZqmEYWSJ5W0JeTUyYrMJwZ5+Jcypy6y
 qWqACGX/pej8q7NNj9+638UN8y09CHdD6eUqF5xxKI2XmrNSwRzceOzPZmUo/PDw6PKz
 mhjeXMDxkt79UKpuSH9phD75b7BQGHRle5p84tqpHLZ/H65h7YrTWbFmomQtQa3uN477
 PSwbbLUj4NLvcff6oMDb89qXGr+k7vZxlaoYurSXNDQxsqDizMZ728dO2aHbZgU+ZFgi
 ++57brqAz+QHFTrPtaFd0Reqxk5blwPV1/CIKXgtne1zxF9xwQPrJQrBX/lmWIASeuyh
 cgZQ==
X-Gm-Message-State: AOJu0YzEJr1UlNOOby0REk4PNX3ygDRsPI5LWNMlGGBOcNC0+Ehb/lm2
 kVKVIHL+JNDO3m6g4JqX8c5upo68fsaC1MoJEgTki06h0W2E0O00BO85m5EKl6uXi6cDcKMBWHw
 =
X-Google-Smtp-Source: AGHT+IHf6RcvypAAUz4n2JoQRcu2K6W0h5h8AxcChXHUbNV4g4SHlBVcgDskLaNwLn96FTQkxxj7Ag==
X-Received: by 2002:a92:c245:0:b0:375:ab93:5062 with SMTP id
 e9e14a558f8ab-39aec2cd898mr141309915ab.2.1722350400352; 
 Tue, 30 Jul 2024 07:40:00 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39af4bb209fsm23369925ab.5.2024.07.30.07.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 07:40:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 2/4] lib: Handle a special case with str_to_list()
Date: Tue, 30 Jul 2024 08:39:36 -0600
Message-Id: <20240730143938.3991937-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730143938.3991937-1-sjg@chromium.org>
References: <20240730143938.3991937-1-sjg@chromium.org>
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

(no changes since v1)

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

