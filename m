Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5293FCAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA248837B9;
	Fri, 26 Sep 2025 17:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jIxWSzrf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6EB683817; Fri, 26 Sep 2025 17:31:34 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D314837B6
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3627a1979a0so1933551fac.1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900691; x=1759505491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2skdgr+pgxoPK/fuzKlcxfVJnHCR6G3jiXWCmUHgJjA=;
 b=jIxWSzrf3Y7SGWW6cA33iWUOBeITCpB6cc54uiNKifqu/fLi9rGIQrZxAfCbvX5vPV
 0puhcZkDID/o+BU1E+N+RWj0KWoIOOFC/UJgikJWpGdt/7Wt2bxYJ4Fs2vfHxeeB7ybd
 hxsb9LNkaeOFP5aGcqtaSj4D2yA7d8KciOz8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900691; x=1759505491;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2skdgr+pgxoPK/fuzKlcxfVJnHCR6G3jiXWCmUHgJjA=;
 b=Wj2m2vPuFgHJW+7jweN2MYUAiT780FwGK5uKAS0uSXiJTGHVYHazGTmXiXEW57N59H
 pPNcWjYbgTZDJFUysF8JtuRhD/Iw5gNQAVDjG30TIpk/3P+R1ViaqVDEzkp2jJvNRUd2
 XySTIRxbN9uL0t3L+cZ5KBYZIIR9KL1TNZAqRwDnssuZ2GqvJK88YM2fH5yYS8eYVs2c
 p32wVHPu9+N3WiZ4scjXWJWgXoXxFuBKMhhvBlwlJlBln952soyPOikobT2HQHycKxVw
 kmJWLLuVBU+vUDUC9tztNtgkJIwkThBGON7SYVOK2xRJX8mYv8znHm31krKyQZa70eJq
 BUyA==
X-Gm-Message-State: AOJu0YyFKPHiT3Yr/Ri0i797ccTxzEd7k/u7TnWOs+ftmNEdpSB925Dn
 w3CIia4djo44SXw+n48gIy3u3UzLw0X1lXccW7rp/oQlckc1LavuPBvIaFJ8ZgXKpfT+q1+/B3P
 cv9U1NaA=
X-Gm-Gg: ASbGncshy+BxHHKJHA9VF6Vl1fXhvwjMsN1BDgtECygjaiMzhombT+EYssV2OstyuvV
 QQW4q48Z3k3303e0CVMm00tdYOqZ6IBWtQUbP0cD31+vxwa/mAu0unb/HBOfhwheZTIbAgOG6Wz
 2qHGePWVIdXD0WVVJPjJFRL5C+fHvTQHPZEaFrgp7VidObaRt/wy6him5q/crTxxdn4VtPbShzX
 7QzNGK1cTkTuqtu0F1krSqhxrib1c8vXdDINvWH8MTM+g4tgXAL+hzlXjgp8Gzvq8iMN0tSSoJM
 OdvKiYNOxJVcIoexBYXKcBJ48Qm54jXMzOpfGHQhfHn0VaP5eS1/wwg871OKbnOIXzkL61riOsF
 P4KL7MdafFOYYQPRkcRBgQc9ILiGLJ16epsd4EWGO3wJaRXhanJkKy8lYFoq3KdI/1XYgShuIKz
 p1Y6vN
X-Google-Smtp-Source: AGHT+IF7LWbcr2axVZp51M6WC4fml6kP3J2OLp8k7UQwT2CcxrfE3zbMs0oxHWURn2wfuQs6oAYArw==
X-Received: by 2002:a05:6808:1507:b0:438:35f2:1b11 with SMTP id
 5614622812f47-43f4ccd950bmr1760304b6e.22.1758900690165; 
 Fri, 26 Sep 2025 08:31:30 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56ec37d61a7sm203047173.10.2025.09.26.08.31.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:31:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] include: completion.h: Convert the rest of the dummy
 functions to macros
Date: Fri, 26 Sep 2025 09:31:28 -0600
Message-ID: <20250926153128.3680800-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

While we declare some of our dummy functions as "inline" we do not also
declare them as "static" and so it is possible for the compiler to
decide to make these as global functions instead. This can lead to link
time failures in some cases, such as "allyesconfig". As these are just
dummy functions, convert them to a macro instead.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/linux/completion.h | 44 +++++++-------------------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 9835826d285e..d99ac450e8cd 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -129,42 +129,14 @@ extern void complete_all(struct completion *);
 #define wait_for_completion(x)		do {} while (0)
 #define wait_for_completion_io(x)	do {} while (0)
 
-inline int wait_for_completion_interruptible(struct completion *x)
-{
-	return 1;
-}
-inline int wait_for_completion_killable(struct completion *x)
-{
-	return 1;
-}
-inline unsigned long wait_for_completion_timeout(struct completion *x,
-						 unsigned long timeout)
-{
-	return 1;
-}
-inline unsigned long wait_for_completion_io_timeout(struct completion *x,
-						    unsigned long timeout)
-{
-	return 1;
-}
-inline long wait_for_completion_interruptible_timeout(struct completion *x,
-						      unsigned long timeout)
-{
-	return 1;
-}
-inline long wait_for_completion_killable_timeout(struct completion *x,
-						 unsigned long timeout)
-{
-	return 1;
-}
-inline bool try_wait_for_completion(struct completion *x)
-{
-	return 1;
-}
-inline bool completion_done(struct completion *x)
-{
-	return 1;
-}
+#define wait_for_completion_interruptible(x)			1
+#define wait_for_completion_killable(x)				1
+#define wait_for_completion_timeout(x, timeout)			1
+#define wait_for_completion_io_timeout(x, timeout)		1
+#define wait_for_completion_interruptible_timeout(x, timeout)	1
+#define wait_for_completion_killable_timeout(x, timeout)	1
+#define try_wait_for_completion(x)				1
+#define completion_done(x)					1
 
 #define complete(x)		do {} while (0)
 #define complete_all(x)		do {} while (0)
-- 
2.43.0

