Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1093EC52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 03:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEB0988ADE;
	Fri, 16 Aug 2024 05:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WCu2MZjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 801AF88AFF; Fri, 16 Aug 2024 05:49:12 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7A0A88AC0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 05:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-704466b19c4so894355a34.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 20:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723780147; x=1724384947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZW5lId1+mAltzpUcM20liFbXTz1rs9zvTQ3IXruThkM=;
 b=WCu2MZjj9I6y9oKm0vbtG50CZHjIyP3ATeIAbC+yHO2W0xM8NKWVkt3PHsUXxcO64s
 ec/UVgf5J7sT7p5KP1w7OH7bYhYX6M9nHqsctYeqER9RfKBQj+/XDVSE3LrwJPgA8fo3
 qhBCH9Lw66+h4+emnS86vill32lbuDIKkxRnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723780147; x=1724384947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZW5lId1+mAltzpUcM20liFbXTz1rs9zvTQ3IXruThkM=;
 b=tuvA8N/WfVflrcabSCi2eSnUVy3p4K6OL/x7YIgfjL1IKyQvLrnVk1SYxSmDYI3gVX
 0Io4wD0hDh8TZG5ZUXAyse1A8KfsaAsR7cAuIrhz2x/jsqmWyAcKE7Cm/5KE4yPHcqwL
 gDrYcyJY5G9dQjCAt+DGWsV0gNh9lTJ1ODPIbrH7t+fonGfwpW93oi3aalJUqx2AJ++L
 mmbOsaGFPcU3IC0iKDFU5+A9rlHPWA6JgIhNfs5FxGGNqlTw7ZWnjqa8C8tDkIuQKpL+
 AOamTcWhAArNkQILVgWOHqG2byVSNcX+s8POvU63gcW9TIm8Je0KwiKfBp5MQ1tE5A+0
 ooqA==
X-Gm-Message-State: AOJu0YzILokbil9vFm3SX7SvyVoNZj/98AQnTrmkH25XwpDq1QZGfZ7K
 kd/mvC1ki9maHuoFTGTqTdk+87NpFQA3fTSjd2p00Mn2NTNCwW+kPReuDDW+1CdJfhWpuzPKvy3
 r9LY=
X-Google-Smtp-Source: AGHT+IFcMilGRwlQqu+Pca9x8bGEE9fzf0N4Hm3Phf4BoL8XgxDnZjv8xUHYt6O6u3P9jV4QngT4mw==
X-Received: by 2002:a05:6830:2641:b0:703:61ea:f289 with SMTP id
 46e09a7af769-70cac8b615dmr1460020a34.28.1723780147616; 
 Thu, 15 Aug 2024 20:49:07 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-97-236.totalplay.net. [189.203.97.236])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca65af728sm550730a34.37.2024.08.15.20.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 20:49:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/3] test/boot: Make BOOTSTD tests depend on UT_BOOTSTD
Date: Thu, 15 Aug 2024 21:49:04 -0600
Message-Id: <20240816034905.3541020-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816034905.3541020-1-trini@konsulko.com>
References: <20240816034905.3541020-1-trini@konsulko.com>
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

While we have a symbol for controlling if we will be testing BOOTSTD or
not, and it depends on SANDBOX, we do not control the building of
test/boot/ content correctly. Guard the current bootstd tests with
a check for UT_BOOTSTD and leave the measurement test available.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>

I'm unsure about the VPL and UPL tests, but they aren't causing failure
to build yet, so they can be sorted out later if they're a problem.
---
 test/boot/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/boot/Makefile b/test/boot/Makefile
index 8ec5daa7bfe7..d8eded20d4ff 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -2,12 +2,15 @@
 #
 # Copyright 2021 Google LLC
 
+ifdef CONFIG_UT_BOOTSTD
 obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
 obj-$(CONFIG_FIT) += image.o
-obj-$(CONFIG_MEASURED_BOOT) += measurement.o
 
 obj-$(CONFIG_EXPO) += expo.o
 obj-$(CONFIG_CEDIT) += cedit.o
+endif
+
+obj-$(CONFIG_MEASURED_BOOT) += measurement.o
 
 ifdef CONFIG_OF_LIVE
 obj-$(CONFIG_BOOTMETH_VBE_SIMPLE) += vbe_simple.o
-- 
2.34.1

