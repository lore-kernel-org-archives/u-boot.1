Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F486D12699
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 12:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E32188E69;
	Tue,  5 Nov 2024 13:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NKIhjiQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C42048862E; Tue,  5 Nov 2024 13:07:11 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EB0F88E17
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 13:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so41594445e9.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 04:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730808429; x=1731413229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kr5b4Z2KsFYWaFASfYrLqEcfxS/BrtIZ/h9NP5/4wPI=;
 b=NKIhjiQgYiYVXWZvX10vGG/ac8LdLD5R1RaQS5sqbS9jeOOuBjBCxdU+H+TaIQVOko
 JhddV7ghHaKQL9skra7HalkkXClfbBOOq8+kkPOVMRG6GJq2CQEzZ9JU8AkfCujgJdUd
 /y0L25cgEV8l7VhqFks05nqkcIq7Z77i5DSFrl53I/jfzKXfWzdai5aQte/LAPQOoal5
 nAkwfVarqZ+JK4V37BGWJEA0r56vgJpRqqHpSd/28NfyqU/eu66YRCLKJs2xnz1zAyIL
 33LoA0BdXUCgAT+dJXwKF8nHRtK6gTj6R7OtFVV5sfs8wQA+ujw5lqpYCm+pDML5iv1u
 dN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730808429; x=1731413229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kr5b4Z2KsFYWaFASfYrLqEcfxS/BrtIZ/h9NP5/4wPI=;
 b=XCRLZvDBfxWxsFAjupZfSsU6Ko/2R/wt9g9unOg5zIxqchbTn8rzNP81lGAqNyBfpC
 RKkaRfvOZQEoM9Fh1ygFysqDbXElZ/0R5H8koxI1WW6BB2CAegeFOdLujP288gEmIrmt
 Vq0hvPHkw1jB3F7Mh0QReRsjXRZ8/pf7LQ5BCj2i+c9eAaYTjEFygTtxtwuvjKa+hwsy
 3y/0re9KjKkoYcS/X05OAxNKOszWEdKllkq1Vlpx07ocobk9n2LEctuY1IQ6AsSV5L8G
 XWeSTJsJbKNwo26+toxZIaC7LbTBR9asSH8EDH2lIrFVutSBS1fCgCmlsDMwoO0cT0BW
 aQYQ==
X-Gm-Message-State: AOJu0YzlnL69+SQOzqA/2zPyI8Qe6W9cGSBpEDt8Rw7rGm1bj/zDPP08
 a7JltsHAaug74j1jPR8NC6gm3m7tOJ4z7WPZhbuHNfVWesoyInSbbiI7r4EECCfEybFM19UG+um
 BXdyjQZJz
X-Google-Smtp-Source: AGHT+IGrvWP7/4/0nuA5vuvVjjYZ12qt74TSitRVvjRMR0LPgO/goso5yGzWSN6L/NILlYMf2p+S2g==
X-Received: by 2002:a05:600c:354e:b0:431:55c1:f440 with SMTP id
 5b1f17b1804b1-431bb9de8a9mr211553245e9.30.1730808427605; 
 Tue, 05 Nov 2024 04:07:07 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a9984sm217572145e9.32.2024.11.05.04.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 04:07:07 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
Subject: [PATCH] test/cmd/wget.c: move net_test_wget() to the cmd test suite
Date: Tue,  5 Nov 2024 13:06:53 +0100
Message-Id: <20241105120653.99438-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

Since net_test_wget() is testing a command and is in test/cmd it
should be in the 'cmd' test suite, not 'lib'.

Reported-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 test/cmd/wget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index fe26fee54c9..9dde699db58 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -19,6 +19,7 @@
 #include <dm/test.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
+#include <test/cmd.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -225,4 +226,4 @@ static int net_test_wget(struct unit_test_state *uts)
 
 	return 0;
 }
-LIB_TEST(net_test_wget, UTF_CONSOLE);
+CMD_TEST(net_test_wget, UTF_CONSOLE);
-- 
2.40.1

