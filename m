Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F61BC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 05:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1E2587B40;
	Thu, 26 Oct 2023 07:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ICLZhNb8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8560987B24; Thu, 26 Oct 2023 07:31:50 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E08787B27
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6bcdfcde944so109762b3a.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698298306; x=1698903106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfuXMOte++LWMschC/mgpQI0os8sthmLuLMLob48M3U=;
 b=ICLZhNb8b9pUSwMIljvtVxQYfeclkOQqRkxicFgDdV1BrXq9KPhole/9yS3fGWtIkN
 g+EFylgTtrJB+OSBE625yWwo4YQVRxTuFGtLoohIKNvrhxgvSGD8J9/0ZwrriwLfhKFd
 izzKv8qtjRWfSXJnU70zc5SFV1mnxYRqVdgiT5FMt/ZXTLydsoDx2aURCk3Dn20xG4ul
 TBIP6HId+gYZKdcx4wLDg8kI8aSv1p/xn83uRlM9Y3ZXU8oRGTng+ADhHqnq8Qs1wCsK
 6j3pRS4+KDi6Vla4v3FUi0A2KTUcGE8kPc/0R6FJ58YDwiMDFLq/t0iz2zzkoXFzaKC3
 qTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698298306; x=1698903106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfuXMOte++LWMschC/mgpQI0os8sthmLuLMLob48M3U=;
 b=Z4HYXNvBBztek0ogC5kb/RmFZhqlemob3fRtRd6GsJMsawaL271e9NZR6Pbu01ClTY
 2hvRQJ2DzaUAqd9TjdFxZakrThHX5rhbtpycByE5TQtcdUyD2WUjsD3sVTiwTB7H51OM
 ZXN2h6uVo739UTKlVUNQnvJeO3yollKS5+g8VjA7ShbOau+1mRH3z3WRuAuKZe+CGQ0k
 Z5lJaq1e8gm7IuDYzG0rLFbDU5twXbeqcxNqWOYn5opV/KMroo5r4stLoQ472ojFEG2n
 uIdekvfaWOsnabxj9JT0mvGJgXo54WR6lUXFDHdkQ8qgStEIFI5i4pZMYkbsqr6BKC/S
 SSog==
X-Gm-Message-State: AOJu0YxrNp3E6VfkqqmMCPN2LKXGBWlT+Qog98jZ/NsKe+DHJ2JRm2UX
 LCXtvGNMXiVRa6yL1QSip9pjmA==
X-Google-Smtp-Source: AGHT+IFIdSTMJNyuQMT2c2HaEVGR1F7FKKSZv/gneKfi42M3vWSL+H24dYIRAyvqhE14dxNP+4zNTA==
X-Received: by 2002:a05:6a21:33a4:b0:163:c167:964a with SMTP id
 yy36-20020a056a2133a400b00163c167964amr21430176pzb.1.1698298306544; 
 Wed, 25 Oct 2023 22:31:46 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006c06804cd39sm440715pfb.153.2023.10.25.22.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:31:46 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: jbx6244@gmail.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 12/13] lib: uuid: move CONFIG_RANDOM_UUID
Date: Thu, 26 Oct 2023 14:30:51 +0900
Message-Id: <20231026053052.622453-13-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026053052.622453-1-takahiro.akashi@linaro.org>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
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

This option is independent from any commands and should be managed
under lib. For instance, drivers/block/rkmtd.c is a user.

It would be better to remove this configuration.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/Kconfig | 7 -------
 lib/Kconfig | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 3a8483f7d042..c42745d06b39 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1143,13 +1143,6 @@ config CMD_GPT
 	  Enable the 'gpt' command to ready and write GPT style partition
 	  tables.
 
-config RANDOM_UUID
-	bool "GPT Random UUID generation"
-	select LIB_UUID
-	help
-	  Enable the generation of partitions with random UUIDs if none
-	  are provided.
-
 config CMD_GPT_RENAME
 	bool "GPT partition renaming commands"
 	depends on CMD_GPT
diff --git a/lib/Kconfig b/lib/Kconfig
index f6ca559897e7..b6d580c30615 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -74,6 +74,13 @@ config HAVE_PRIVATE_LIBGCC
 config LIB_UUID
 	bool
 
+config RANDOM_UUID
+	bool "GPT Random UUID generation"
+	select LIB_UUID
+	help
+	  Enable the generation of partitions with random UUIDs if none
+	  are provided.
+
 config SPL_LIB_UUID
 	depends on SPL
 	bool
-- 
2.34.1

