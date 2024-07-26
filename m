Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8818C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 14:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A81587CF8;
	Fri, 26 Jul 2024 16:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ko79Pord";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97357885BF; Fri, 26 Jul 2024 16:00:52 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E82088570
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 16:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39865a15900so6561995ab.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722002449; x=1722607249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiorbJr5W30iyqHwCPgZi6RbEbcE4DwrMZBLGDyP3qw=;
 b=Ko79PordScxRkhM38bQvXm7x1jmVqA9ZqkKIA9Y4JACw/uBUPxfbLtJQircKuLl5tI
 flbozbPDkH7VPraLuxPspliRQDDgzrBAlQgABrtivm3fQQI31y32WNTH9MXp3todM9aB
 5VjSLonNf681x+l8c83ECnKb6E+7rKIBdMsEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722002449; x=1722607249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LiorbJr5W30iyqHwCPgZi6RbEbcE4DwrMZBLGDyP3qw=;
 b=dCPH5YVp1GNqqwhy7Sixw3pcDyQ7XMbaW+GZTLAK9nlW5ypN72j8PJIXAGE4QE2onR
 Lfe2bVcOFCfns/HJKDs6i1m7ZWk6cYgyVZc5dMeSV7Vp4NW7afXNTGIBw/4Do9yk2mX2
 jX1pkRgjCsOUE2dnh94zhTVR2bfvqfWZI6Uy86/tO3UxnQ8Tt/6Z+TMHwqzkW2Un86oB
 GeLZNgfjNg8fHwrRBoX7sVXVhD6bfGie6kLhnKFI4CFuovHffeg1v657vJdhkP91H+Gd
 yzpWBawYLJZWByg4hoLDYp/uaj/IGJFY/dj+90Ie2FnZkeSlP57q/MIFRBtPsyAHswXz
 Xtng==
X-Gm-Message-State: AOJu0YxAbIV6+2dTfOv58rGnuLzpN43wl6KwISP3ySj08syLrH6U68pg
 8l7yLSq7d2lsVSCjtgWKs8eY/Ix5mUZ6Y9iaQV2Hd/D+Q+B6k2Dtws21Rm+IpLFgmIOQUPlH04A
 =
X-Google-Smtp-Source: AGHT+IH6bImRB4RzLxJpA5uQwAI3eG9yUYTIDqsVMi0kddoGy0UVDzLGEB69R7Xpgb5YJ8OpdFxfOQ==
X-Received: by 2002:a05:6e02:1c83:b0:399:df91:bf47 with SMTP id
 e9e14a558f8ab-39a21822a89mr73584575ab.18.1722002448982; 
 Fri, 26 Jul 2024 07:00:48 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a22e7ec25sm14411905ab.6.2024.07.26.07.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 07:00:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/4] lib: Handle a special case with str_to_list()
Date: Fri, 26 Jul 2024 08:00:36 -0600
Message-Id: <20240726140038.194946-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726140038.194946-1-sjg@chromium.org>
References: <20240726140038.194946-1-sjg@chromium.org>
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

