Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB1CC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA5D0826B2;
	Fri, 28 Mar 2025 14:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ev6OqO4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B384F82836; Fri, 28 Mar 2025 14:08:54 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A9A68215E
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-85db7a3da71so202251039f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167331; x=1743772131; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwJiAVUtdNyKAK5Q5BjXIPlegxYlXRxhE71Fk2S3X3w=;
 b=Ev6OqO4BRdDWnsJOjzZBXJ5oN0vbQ9KOWzy3Kk8JVgKTsiEPW6c8+zXuxp/w/jHg1Q
 YWmkdBwYxlApLMV+lc27REpJ8JQv7ePiLNKojhGdqsJvH6kZcm1LjN6hEc+KElEvOa9g
 v6Hz5mQb9rXTu/qj44KPL/0w0AAQBV/JwIt7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167331; x=1743772131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwJiAVUtdNyKAK5Q5BjXIPlegxYlXRxhE71Fk2S3X3w=;
 b=BGYid0vw8KjwJ9HzivTnSV2jlwZVWJl8RqpnFEgtZqI0Fzvfq1BnFc/EuJGbXDvBcW
 LHAvE2wLENTXNGggSJI9ZnXThjR05QMUvBSri/2gvva6GqQRtxPwqiD7ZOAMbL5X46Dd
 gJdX02Ur52f6KP1hB+jCrQIgu5Nr+yWiXl4XtNbTUvEz6CFeyYlUKTRoDHmMHJd1jYWt
 O++aQBYjSTfN1dQ6FhJe3iBmxV3Mub9D5xC8fhyt2T7rhHVZThULRQUczeFYkhM4sluy
 6mXOhH3MuLHbmFwxEXOZZk6vUkCWGaaeA3Rr9ouGaiLfRk1rO5FNxZ0qW0mSZ/wY6JqB
 RlAw==
X-Gm-Message-State: AOJu0YxUOcI3KC7vAAODWMEi/iouySnOCDoRzxudT9mQXzD2kHHDjS1b
 2gbYwPuTQ5JNbIvpBJqt75fJsoj/dHq6WCHeiT3l+HBiwBZdtAMkV0rpI5P2yt09b4TAU90r5uk
 =
X-Gm-Gg: ASbGncsfpwraSQLU3AHxX+fQkYp4TzU/RM2+MWRKXzPoviD1ruBIvnhcNB2+vibxyoD
 WrrHTz8CQpGzTHcOqEJtCIf0cj0EbJXrOeZgUBYxMEqb2JVWJPtTmwv3TDGsQV2xlABysOxMewP
 omZLkoyXJSVyf6V85EI+rukeE9fWHEyzLEeZUjHoDdrbaD4wzbsC2mULZnT5hH+f2RPE4vzaAVH
 sWCAG8HT+oBxXzsF8+acwb7od6xkWYe31MpjK1IOju9tHP5HpFdWPAVfpahMbllioONSm6eYm49
 aSzkPFOKHspdw8qWzND6kYdt4B9o6ssPhM4jdk9vQGPlZzWj23uQg/l6DuzCmoIn/cg73XV8o+/
 GL5vz9HWS1bcoPz6R
X-Google-Smtp-Source: AGHT+IF5N+ocrjFt/PVuPLrK898taHkTe/KUVbu/gfDdRY8UYhHYk4aXmSMcm0OhgMak2xtq8DeHpQ==
X-Received: by 2002:a05:6e02:238a:b0:3d4:38a4:388e with SMTP id
 e9e14a558f8ab-3d5ccdc7580mr85537285ab.1.1743167330656; 
 Fri, 28 Mar 2025 06:08:50 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 49/56] expo: Adjust expo_poll() to avoid looping forever
Date: Fri, 28 Mar 2025 07:06:36 -0600
Message-ID: <20250328130713.2612648-50-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

If the user does not quickly provide some input, exit so that other
things can be done, such as searching for the next OS.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/boot/expo.c b/boot/expo.c
index 4e855f60d84..bf2f1dfc68a 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -324,12 +324,14 @@ int expo_poll(struct expo *exp, struct expo_action *act)
 
 	ichar = cli_ch_process(&exp->cch, 0);
 	if (!ichar) {
-		while (!ichar && !tstc()) {
+		int i;
+
+		for (i = 0; i < 10 && !ichar && !tstc(); i++) {
 			schedule();
 			mdelay(2);
 			ichar = cli_ch_process(&exp->cch, -ETIMEDOUT);
 		}
-		if (!ichar) {
+		while (!ichar && tstc()) {
 			ichar = getchar();
 			ichar = cli_ch_process(&exp->cch, ichar);
 		}
-- 
2.43.0

