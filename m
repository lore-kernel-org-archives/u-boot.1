Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A12BC46CD2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C408987BA2;
	Mon, 22 Jan 2024 23:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pr4PPRNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A0F87B77; Mon, 22 Jan 2024 23:39:34 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B7587C0B
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5ffd5620247so17615617b3.0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963171; x=1706567971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ls/N0tWyzPus4HfY/dZSNJSFRq7T9GY2FxdT7cxCEDA=;
 b=pr4PPRNYpXbqZTdnul6XimHdfaw/a/Je5bqyQwpNlbQgDYyehmOocP/gyJ6SQUqup9
 CI9j950B4pWHwgG9U9SaQczEQO/Xzx7xGcAv4pKQdzgVycLeqZnc4jRUbyrUzqBiBhST
 WBA142D6QXz7RsHWOGdEp5w6rX6G/prX/nsZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963171; x=1706567971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ls/N0tWyzPus4HfY/dZSNJSFRq7T9GY2FxdT7cxCEDA=;
 b=kai4JBQLfnwHVrII/tFYhNGJIqh9qV4D6N62c9ggY/isgUFVxT08B61pcSLGnkueqX
 CFbrZEZiSuq1eCIG9Y/XpMqzYhqIrAv6shn6KzxwOum2Egwi6GBKclmaPK1AHmASmAwt
 niIR71japuTZm++Icv/IsJOk7UryE0eLNBaHGSvfQIvAbwratTvdb0ZeizaLRIg4SE/y
 +unMiRvZypXOnA0ubaeaEucbDG9nCrA+t5N5mCxl1oES5hxX3BWqCGKceh0eNBRwy/M7
 9YnbVvpAGlNSxZ6+EnHzO+gZbNJ8ezDLb3fQJzTWbocok3qPDAr348LcbDYTR2x5dE7F
 JrzA==
X-Gm-Message-State: AOJu0Yw2d8Enl/RJ++6TiF7y2U/cW5ftaX4l24xfybQiLqa/3b5dxUcY
 Io57lqddEsT1cMoHgwJ9ApXSzy24wcylC0P7DtApDtAb/40YqXVEDiSMFymX48Gojxspox694HR
 A
X-Google-Smtp-Source: AGHT+IFb31ri43M6X9qVO2iKMYP8QKEoMxm6+uCkJQE2Z3lZnq2sksxAX3zDmT8Ba3E7EjIk9wuquw==
X-Received: by 2002:a25:aa72:0:b0:dc2:4103:e0ac with SMTP id
 s105-20020a25aa72000000b00dc24103e0acmr3174487ybi.89.1705963170777; 
 Mon, 22 Jan 2024 14:39:30 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 11/16] galileo: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:15 -0500
Message-Id: <20240122223920.3630168-11-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122223920.3630168-1-trini@konsulko.com>
References: <20240122223920.3630168-1-trini@konsulko.com>
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

Now that we support having CONFIG_SYS_CONFIG_NAME be unset to indicate a
lack of board.h file, unset this on the galileo platform and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 board/intel/galileo/Kconfig     | 3 ---
 board/intel/galileo/MAINTAINERS | 1 -
 include/configs/galileo.h       | 4 ----
 3 files changed, 8 deletions(-)
 delete mode 100644 include/configs/galileo.h

diff --git a/board/intel/galileo/Kconfig b/board/intel/galileo/Kconfig
index 4c0451da48da..15c8d1254089 100644
--- a/board/intel/galileo/Kconfig
+++ b/board/intel/galileo/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "quark"
 
-config SYS_CONFIG_NAME
-	default "galileo"
-
 config TEXT_BASE
 	default 0xfff10000
 
diff --git a/board/intel/galileo/MAINTAINERS b/board/intel/galileo/MAINTAINERS
index dbbc82e8a1db..a5dcde7ad09d 100644
--- a/board/intel/galileo/MAINTAINERS
+++ b/board/intel/galileo/MAINTAINERS
@@ -2,5 +2,4 @@ INTEL GALILEO BOARD
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
 F:	board/intel/galileo/
-F:	include/configs/galileo.h
 F:	configs/galileo_defconfig
diff --git a/include/configs/galileo.h b/include/configs/galileo.h
deleted file mode 100644
index 9b0f5cedcd79..000000000000
--- a/include/configs/galileo.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
- */
-- 
2.34.1

