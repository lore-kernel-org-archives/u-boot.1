Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB14DF3ED67
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 01:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D66D1841C2;
	Sun, 12 Apr 2026 03:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Morzzdnh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F311C8418C; Sun, 12 Apr 2026 03:35:17 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA6DB841CD
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 03:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso3241606a34.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775957711; x=1776562511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=51Zbu+as9QPdTIi+ZwM+DK7wFdtCBdXGd+3dumyVnoA=;
 b=MorzzdnhblSmY7nvefpiS98z9rmiNYsVpfTsvrV+PtLvd4J5rGH/fXiieGHA6ZyPhz
 DuZao1v1qB5ZCjkfSiuh0nVVhsFooLoUh4vqvxNt7EUCadqfaNy9FqH+rx/05AQR5Mh7
 41MQfjQtmZgTcHeHJH14jwMJO4XnIRU89n7kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957711; x=1776562511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=51Zbu+as9QPdTIi+ZwM+DK7wFdtCBdXGd+3dumyVnoA=;
 b=JN09fXbqdQviVC9V3JiXhB7k29rRDrU4qgGmXsVMkiglUNW1CZU77gWj2MozYkIXCr
 GjcMu39uuZyfx6rnGKeB1OglVv3lQ5T+DfBcdO8mUxUy1E3kw1i9auL71vUaI0AVZ8HJ
 ICXQBSvf2HtzVMipJfY7LreF1oQ032TYEb2MktS6kHARk6PYJyu/QcRPQ7nf67K6GeN6
 Z1gU7rTrVovU9NiXWEFWQaJdqN6Q/adipo0Ss27gGjKNXkMg4wjzsxujyMZR4ASev1DN
 83cnVm1S+sVxtvR1KfEjdSnmOFImvFYva98fgdI8H8IQ1AWmK4ZnT5gh65umVV6e8kOp
 /Zbg==
X-Gm-Message-State: AOJu0YxpyKe4VfcnJOXbkoilVBD65joZfZdZ8dqgnlf/7um5MdexOG3E
 +YzFOF9xwhf2timewK/DAgrE0wdSo3ZriyCsZm9V/KvGneE3AkLeEXIWmd7Fd03XDdp+q0F1iHq
 J3qbJoA==
X-Gm-Gg: AeBDieuOrifHYqrocC/jg78jUOTSHmIpkTFVE8F3hST0JyHAVvHOmBAtzHpHj75/GF+
 XnNb36ei5b/jKTdfK3gxlmq3dTTEfhkqZrMU2gW+uQuhHqlOEzjT/tQnctNpKVEo1fMMfLDspDv
 SF2u1eKBVTJDmToutD2EFxvXUju1QkFHWb1D8ru7VLztA8AGkAvXb0agRHqbJRelZq3gqBrm7uQ
 37HC/lT7Gz2PogwrWKs6/b8jdESwjacw7Fm4xB9+KGDBHalLxKxDX7vHN/NFmqtbKqZLC3P4UtY
 x4kdd3UQlucV5vS5THJ7igmw+NU5MKKCWUycBJG92jjntMb/ueMZW9MeKIoGNzO0LmuDwdCK/X6
 iFfS6Vx8Ue4ek3SJLsc4VCbU/1MhG4KgEHnnWnL+4RirJa4x8JuQEqgp1kX6QT49WbAl9LgIGYB
 tSK/dP52ffMDJslFW9y1RGDdwW339c
X-Received: by 2002:a05:6830:67d7:b0:7d7:ef0a:1ce9 with SMTP id
 46e09a7af769-7dc27f0b2d3mr5699535a34.14.1775957711265; 
 Sat, 11 Apr 2026 18:35:11 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2d1aca3asm4242826a34.6.2026.04.11.18.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 18:35:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 03/12] test: Add a private buffer for tests
Date: Sat, 11 Apr 2026 19:34:31 -0600
Message-ID: <20260412013451.2929001-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412013451.2929001-1-sjg@chromium.org>
References: <20260412013451.2929001-1-sjg@chromium.org>
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
Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

