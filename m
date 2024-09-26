Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CAACCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68CC888D7D;
	Thu, 26 Sep 2024 10:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="O/Dd9neg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE3B88E11; Thu, 26 Sep 2024 10:03:49 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B82988E21
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8a7903cb7dso46610766b.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337817; x=1727942617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9RXJDhEv5QVglcEIAyBAJ4b2YbP9XJ6oelNgllPBsw=;
 b=O/Dd9neg81T3U6qCQUrAzWUhjDsrPdF9vzg8crtwPduTwq3KKuxQ2crDYMJhSVevNW
 ol5wJQ5d+ZZ27dDQ7/C1rlBNvYn/aL9LYs4v7saryLi2MGN8EcOawDYLjrGiLVNIhCTd
 +CBMO4Iymc6brme3a70k6/jsfZwqAshwwDBAkhEEDanq4ImjWI6vimJ6r1jD9mkdKiIO
 MJkAiK4PVs5nEZ4S8P5tLSQgUIDPb0m4OmY6vc+A9dceVn5viv/dApPywENrIWC13yFc
 gCzpc8psb/glwIi9jWecPIsLLe/6SLdRX37mKrrUKnSt199fjdbNgDCXg5LDUYu1sdmt
 AX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337817; x=1727942617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9RXJDhEv5QVglcEIAyBAJ4b2YbP9XJ6oelNgllPBsw=;
 b=j3S7EF3lovDVQTE7aZuSMCK67px6Z28Uyxk+/FuFbC+E+1UcvCRm9+xZlb1K2/4TFH
 9uYox5B2Qo8akABKHl6GR/RjiGgGAW3+a3ucZiSM7yqzWvd9ERXQBvT1aIT9MMX0PmON
 Y3+laITvLtjrgqx5gWbhPyVeLLhxuADr7GgyXisP4ofWAPgdg3Hfi+ZvcxeTT5wZZ1nT
 8GftOrEkvRDjHnX24siBpaRgu7kq6OxTi7aTgKKqKn+f+mbUV7i+c8AzOftUBovV973C
 +iqYefGNuUS1sRSbN+nWlrKyzkqdWjYZbnq3GCytOTT/nOdlARF13tEN5LSpquHdeKWO
 J3rA==
X-Gm-Message-State: AOJu0YzcLDrBuJna5YxtdzD740pSGMwjqIHbX9hWBoZVDSzgj0EE8AnC
 B6dD9S0l010CmTIfHcy9fU2tQISl0tgzBHKbNs25VysLPr79duVX9GbVTVPw0XYOWf0Rc3mJo2V
 0FBU=
X-Google-Smtp-Source: AGHT+IHk0x2C04tD4R7xlrLnA+RMGGzpP9AtamqlKVtJbzaCqzt5DdWGZPnHtk3Srm8M7GS5vo3IvQ==
X-Received: by 2002:a05:6402:2808:b0:5c4:2fca:b11 with SMTP id
 4fb4d7f45d1cf-5c72075609fmr4874880a12.35.1727337816623; 
 Thu, 26 Sep 2024 01:03:36 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:03:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 34/36] bloblist: Fix use of uninitialized variable
Date: Thu, 26 Sep 2024 09:59:22 +0200
Message-ID: <20240926080021.148031-35-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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

Initialize addr to zero which allows to build on the CI
which is more strict.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2008ab4d25..cf1a3b8b62 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -499,7 +499,7 @@ int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
-	ulong addr, size;
+	ulong addr = 0, size;
 	/*
 	 * If U-Boot is not in the first phase, an existing bloblist must be
 	 * at a fixed address.
-- 
2.46.0

