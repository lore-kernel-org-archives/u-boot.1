Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B49C3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 14:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B76988715;
	Wed, 10 Jul 2024 16:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TXdTFb0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A64BA882F0; Wed, 10 Jul 2024 16:39:03 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 954138851E
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 16:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so5809095e9.1
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720622340; x=1721227140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiorbJr5W30iyqHwCPgZi6RbEbcE4DwrMZBLGDyP3qw=;
 b=TXdTFb0qBaDRpgTJ+gaw3LQjv2V/hSypiNrlhnglfaVmHUJ6A/8E/lGTIzlBxIOCuI
 YaKKfEvs0f+rpvaGWODGXqMN8JvpTZxrfCnDnyWLjJBxYpoKjEP1INw4jlw9S7BQufmD
 aSO83HyAsGE45DwD4g1/CVOmGS/fGGDY0/hvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720622340; x=1721227140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LiorbJr5W30iyqHwCPgZi6RbEbcE4DwrMZBLGDyP3qw=;
 b=tnW0RrxyT3j8GLfCxmEbpaoqHR9Kp3B7Lm2KlwV/LZzzRm4taPA2pzuxo+PItg97Lb
 YXAIOIN/pir7c8FCiWSaiOCCzJPDEg7sV0PcoOu4StMmm00y7f8xwI3Y6r7iZo5gz+M4
 MUpgYIr4J/IyGQz4f/UZiM5QYVb17xxYhYUuM5C7qPkisKrdb4ROXcVxgl6VR6Qnnaf1
 fcLFlwbwT1ZnDCdnIsNmpViZc+wTZ1FvhMb6+Cv7gzNyBAJnQkaR89cBR9dz+ERvF21H
 OdMwxHRLOuYIStpS9oa+Cl9IO2QWmpxJMluXv8ulAFCxFW2jE8MqEn5ZepvHIUHSzIe8
 JIlw==
X-Gm-Message-State: AOJu0YwSYmAxQ2aXoSBjfRWX0Sd8q9ZebHJxfha3CDVd7uDLmTMZH912
 4hq9k35fyoAS09Z1/hB3gnV+7lNptoHamUDJa4kpKdTJ332WnUnkiv3NGS2epoffX+TALJBYqOY
 =
X-Google-Smtp-Source: AGHT+IGEBKr2WHVZCqGDvxi497VCtZtgljXj+CPbCRoTYFXCskmvUyUOq2/qJmkF4JnSDE1rwoNKgg==
X-Received: by 2002:a05:600c:63ce:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-426722c5b9emr52871005e9.4.1720622339746; 
 Wed, 10 Jul 2024 07:38:59 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa07dasm5471374f8f.87.2024.07.10.07.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 07:38:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/4] lib: Handle a special case with str_to_list()
Date: Wed, 10 Jul 2024 15:38:52 +0100
Message-Id: <20240710143854.3905259-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710143854.3905259-1-sjg@chromium.org>
References: <20240710143854.3905259-1-sjg@chromium.org>
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

