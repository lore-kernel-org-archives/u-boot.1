Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647A2D10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 660E0890C1;
	Mon, 28 Oct 2024 13:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="npX8nifR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A37CF890B3; Mon, 28 Oct 2024 13:41:41 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C56DD8909E
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so636468866b.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119299; x=1730724099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=heXBP8XQ3G2lDK1pOmGbQ8P1xcOJhAX8e62L7xE76zE=;
 b=npX8nifRu4Vb42SK+kXsZy0D2RbBy8eAf3ZpXRXNcq6AQ5vSj5Y6PomlidvEkppfhN
 vW4cQHATRlVWt3VtqizbRNQrjvwreg5S9bal7qrqsBRwGufJAun+Ze1/6NAUehYg9bhG
 yJnmr79IBcDt7mGRcpjeW/NtsBShPSPbYHzaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119299; x=1730724099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=heXBP8XQ3G2lDK1pOmGbQ8P1xcOJhAX8e62L7xE76zE=;
 b=dB6iTuwIg9JUSwKP9+aBZbgdZiKVf7K6z9/GLCPWrXc0b3vVY+u38KjqmMIoI6QBED
 UFcFlVykNOgSTc1q50y9Vgp472/D2ApH4CkIFQOlSZO45REANDJgSuiQNAxd70Xjlz6f
 JIYCcjMPFiSbrtxgQUSgSq6E4fk4suEXm22L2L4ICxeoDAQZ7qCN5kIB+0ze3owWnYvS
 MZ43if3iSMo7+/Qn5po0CIh17Y+35uNcG/jTWKzM3sMHn5qusZU+GAGwkd1PoOtO6H9H
 QivD/w6s02ziZ7xgE/ZaecrEVAuf3jTvYzfYSApt/l2YhkVAvmlQqBhOkLPOToXdettm
 taPQ==
X-Gm-Message-State: AOJu0YyL+UDdheApZlLkeHiarS8zd/TBJoIaSwyJEVJVc7NHNmuInRzf
 tNt/hqhuUE57UUZMVFi2WQn2UIbk3MaCHfO4v094Is9g2ZoCokR6JKuJKWnv5TE8exWFCMxARwY
 Udw==
X-Google-Smtp-Source: AGHT+IFr7g5gQKCKyuvLOZd3tIEa3k/rWArwVWtujjs/4ljfrajkG0sNRq4kOekw4gIRq15kJoaNWw==
X-Received: by 2002:a17:907:94cc:b0:a9a:bbcc:5092 with SMTP id
 a640c23a62f3a-a9de5ee23e6mr784120666b.39.1730119298404; 
 Mon, 28 Oct 2024 05:41:38 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/21] bloblist: test: Drop global_data declarations
Date: Mon, 28 Oct 2024 13:41:07 +0100
Message-ID: <20241028124130.32072-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

This pointer is not used any more, so drop the declarations.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/common/bloblist.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index fd85c7ab79e..7b90fa7f352 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -6,13 +6,10 @@
 #include <bloblist.h>
 #include <log.h>
 #include <mapmem.h>
-#include <asm/global_data.h>
 #include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Declare a new bloblist test */
 #define BLOBLIST_TEST(_name, _flags) \
 		UNIT_TEST(_name, _flags, bloblist_test)
-- 
2.43.0

