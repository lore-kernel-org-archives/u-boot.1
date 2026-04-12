Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F232BE937E1
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9B7841D7;
	Sun, 12 Apr 2026 13:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dXn3lKVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D95BF841E6; Sun, 12 Apr 2026 13:24:10 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9089841CD
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-40f387a688dso2369282fac.0
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775993047; x=1776597847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbOQItx370W3yIuamNCAXxkBc00v6bztmsRJlNSZaUY=;
 b=dXn3lKVSobe3oSaPrDwfQ6k6j5TK2rkwtMiVxA/Cd6I4zvyhHvFlVNyf3iSrsC5YRn
 GcOm3pmMEVqh1HA3wHDaQd5nJimBW08Kkb536xZzPIGdeVT2oKzX5aMhrQu17nhf4idZ
 EG/IfviR3el3ZkmyBkdt/T2zmLCSk0CpMo+no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775993047; x=1776597847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KbOQItx370W3yIuamNCAXxkBc00v6bztmsRJlNSZaUY=;
 b=jMBU7rPIMT7D3kvydV+80E7McMAjlL7pQpRIjfcXhPDX6FYrCi4EMOfV6b0wQ6Zt9d
 j4w7mn0TXPeSaSjo6yTb0NVCpuCXp1sz/LDCvTj3NbiO0l2uaTlwkvpyH4QrJim2WOzL
 z+m/WDAYWGEATLGhBkfH9vDuk7+LsHB1dq9Lwsg6vE3Ro7wwvG9w1Uv6wMUVD8JMQ2w1
 DkN0Proj4ZUMm3FyGtla+FM2Bya6w9hodIyNeG9WCLVztZgmgp6iX+Hgjn/yJqZj1X4j
 GFEnY0nTqYJB3rFqV+rxAvfI0AHATXKUs/sV6iYxWNAhuZgfm4RboPQ07a4ebV+9VRg9
 Sqng==
X-Gm-Message-State: AOJu0YwT3zz5rV8gvZaKTJvnD+RZINIee1kIt55AcCum3LSQoto9+6Fd
 Xpm+S3+CmgMB1djRvGOMgill4P65Pqn8Ou/XhQ1dQTQJRPNhqek3v2yOYgYRHr1Tbj12b7/bICn
 dCYC4zg==
X-Gm-Gg: AeBDiet5brH6lZND8WkH0g2kJvHhmwCM8eq8lWZh8cIn4ewzVEO+WfLzs9Gg3QAxUvA
 zulgjH9BrPhu+UTv10fJWIOq6jvuo0bQYIZxPTI+75+Na+TjkUNP09p1eL6ff34jfSqH0RLByfB
 9iam5gR6Ssdl1tnR0SGW6n5EMvCgX+NNUBmo8FGcIdF0OeeypIb4zqnimOgyEqeA0cVBqsfdZ47
 /JhgvpQxilnhTIq5BXng+VOt6a1baQP4CPPOJTIz14g3PtbOlVnnZMq0Fmsytgq216zaGlSLttT
 yI1zsS5U/4aBKg0/j5lwAFvnF3HHg3Z83+pUTH2tXAg73CfjpdRNsFWTaoXnUQOV8MMOnNe/NkE
 lWFB1gAABWhFg2XKFtdsWVIVd3AZsgTa4ETgZZdY/F3r9lc9jxSsxkumO7CVP4xWlX7WvqiRlEl
 A2hS/a1cLMnMIzpfhFUw==
X-Received: by 2002:a05:6870:3043:b0:423:a084:b675 with SMTP id
 586e51a60fabf-423e10e1dfbmr5127760fac.34.1775993046897; 
 Sun, 12 Apr 2026 04:24:06 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd395606sm6622071fac.1.2026.04.12.04.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:24:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 03/12] test: Add a private buffer for tests
Date: Sun, 12 Apr 2026 05:19:40 -0600
Message-ID: <20260412111958.943933-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412111958.943933-1-sjg@chromium.org>
References: <20260412111958.943933-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Add a priv[] buffer to struct unit_test_state that tests can use for
their own data. This avoids the need to allocate memory or use global
variables for test-specific state.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 include/test/test.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/test/test.h b/include/test/test.h
index 0f2b68a5dee..f8a80a88959 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -9,6 +9,8 @@
 #include <malloc.h>
 #include <linux/bitops.h>
 
+#define UT_PRIV_SIZE	256
+
 /**
  * struct ut_stats - Statistics about tests run
  *
@@ -53,6 +55,7 @@ struct ut_stats {
  * @old_bloblist: stores the old gd->bloblist pointer
  * @expect_str: Temporary string used to hold expected string value
  * @actual_str: Temporary string used to hold actual string value
+ * @priv: Private data for tests to use as needed
  */
 struct unit_test_state {
 	struct ut_stats cur;
@@ -78,6 +81,7 @@ struct unit_test_state {
 	void *old_bloblist;
 	char expect_str[512];
 	char actual_str[512];
+	char priv[UT_PRIV_SIZE];
 };
 
 /* Test flags for each test */
-- 
2.43.0

