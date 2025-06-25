Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED92C7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 09:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DE22803CC;
	Wed, 25 Jun 2025 11:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yhJdRwX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E32882CBC; Wed, 25 Jun 2025 11:50:50 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04CAE8006D
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 11:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so5547050f8f.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 02:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750845042; x=1751449842; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=giLqDnWpJ1nXKlUt0qaNNAsA2Gj3qyK7ztdBs7KrbeY=;
 b=yhJdRwX0EDzqBuzrMUnIY86x7JwiqLcNj2RS9MPMcSOuqsRVAgrKIS6xpyKnp4Kjgt
 oflnGIR67uZ+v/T6IUBSSnPFC71v2yXdrZ2C+eGX+9BPsBR0cyuK/SbBHoNiVdqt5U7Z
 XuOuim7+dnLcCpaB+uEo0rR/lSXLm2OikuzFzyIBQsOGz8EUWWzZHiIi5p7dugXloBbe
 v69ulCsjCPFS1ZuYtPZ+ZnVbf7wykUKNkK3M0d08kGC7UQ/K58GYBcxKjn0pmBiW+Utw
 zHztxEx/obsYeRZbL7+kAceBLoasTlZOAjAbs3OGApfeGm15sJtw75aQ59Sh8wTZEsaE
 cbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750845042; x=1751449842;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=giLqDnWpJ1nXKlUt0qaNNAsA2Gj3qyK7ztdBs7KrbeY=;
 b=iysvpVJxAC8rdJscIZf0TrULLf0Pe4Xr9Sf37Rvwq9Tsoe4B+112ix2wNZWTACPwoo
 AHuc4Wy/I0OgouImvqgtRMoI5LvP4Vo65OYKqgIDRZXrdnuw7hBTye8lB8bI2rk1WUlz
 m6wR+3VuEKbfWJNcHt+jPXZs0hC6ksVW4zONeEARurOCraK0JbZz+82rir2CEz/tycb3
 j+GETXL4RC8+YPiORRSy+9HnBBRg+D/bY+zWL9Q8ebH0LgLdd6yTEcwr99Qa9pxWFZs4
 FNTWh9zJP9c7Ko8yqF7QCnWuUs3POSWugwtj9Y9+xhQ3HTekImjc/vhf7xrDyy/46hew
 WJgg==
X-Gm-Message-State: AOJu0Yx6f6KIkoDY8HGzR0i7W3a4ZYI5fn25x2oftY6JAlCZJpgk6ofv
 DjRJKjs77Rbc8gpN6qOdeTvnLQvmGeM8n4JOApEqtMxvKwWj9XRj90fLzeWYtYliMn14fFW4KPi
 gu2SzVPI=
X-Gm-Gg: ASbGncsJNWxQMA/ZAD6Xbb0RaJ84z/b1b/bmEwuik/L9iV2XmvviMS8L/m9I8l8p4zv
 9QSpHOqKf1oG0E6R+TDWUQuBvDvAxUOCLNCmxWZ62nMgVNP6tkzg05r1aKyHaoZeIxXZyYQ8vwz
 MviDcg8hA2/CutJCPdSEm/sD/k6cjepfL8Lc1+CME/xiFKqXq8TapjDIcqWvEf0MdnE5OmE9pFT
 umc/kTqO4G+BqNINqMtgNr0sIWgIW+Op78ntyOGKrSVjPvf7x0If276ue1CvhnhVV9a2XjkmOH+
 TosjLx/RM2PRnnpaW4EJMeQ2ZH3OnYHNOQSVgUweXLBKo+dCnF9gc8ZYBq7m2DmvC6zl60XfRqH
 mVEdf9GC97LDo7A==
X-Google-Smtp-Source: AGHT+IHNxAP3lqQLRh8DyS0swad0rJax6sUEQMRjJQNiKSRLbxTzY/9a6C4jq3xTwTBNNtqEpmTXAQ==
X-Received: by 2002:a05:6000:1449:b0:3a4:f744:e01b with SMTP id
 ffacd0b85a97d-3a6ed64ba19mr1816335f8f.39.1750845042252; 
 Wed, 25 Jun 2025 02:50:42 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:8cc3:8d71:1fb:3fe5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e810caefsm4044231f8f.87.2025.06.25.02.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 02:50:41 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 25 Jun 2025 10:50:30 +0100
Subject: [PATCH] common: readline: Fix always true test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-readline_fix-v1-1-8585ffeae429@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGXGW2gC/x2N0QqCQBBFf0Xm2YVtW8P6FZEY3WsO2BYzEYH47
 60+Hs493JUMKjC6VSspvmLyygVOdUXjzPkBJ6kwBR8afwnRKTgtknGf5Oci+OqbNvpwTlSSgQ1
 uUM7jvEdPtg90F29F2R8/Xb9tfxfmVr93AAAA
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The variable base is unsigned so >= 0 is always true. Fix this test
so that it is actually useful. The fix prevents the code from causing
a segfault in the case where Ctrl-w is pressed on a line consisting
only of spaces.

Fixes: dcc18ce0dbaf ("cli: Implement delete-word in cread_line()")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
This bug was found using Smatch
---
 common/cli_readline.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 4e6797a1944..0cb43e62000 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -332,8 +332,8 @@ int cread_line_process_ch(struct cli_line_state *cls, char ichar)
 		if (cls->num) {
 			uint base, wlen;
 
-			for (base = cls->num - 1;
-			     base >= 0 && buf[base] == ' ';)
+			for (base = cls->num;
+			     base > 0 && buf[base - 1] == ' ';)
 				base--;
 			for (; base > 0 && buf[base - 1] != ' ';)
 				base--;

---
base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
change-id: 20250624-readline_fix-4ea90584023d

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

