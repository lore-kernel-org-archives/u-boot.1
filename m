Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B8AC47DDC
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F38387BC6;
	Mon, 22 Jan 2024 23:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jVHkVqiw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D1587B5D; Mon, 22 Jan 2024 23:39:28 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C968798B
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6002317a427so7555007b3.2
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963164; x=1706567964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MseZBEADDaOp4bJP1GnfYPVOTLeKmz51YHYiXb9lkM=;
 b=jVHkVqiwUOiEwFdpx3UyHhCz79xMqol8aMXyf2kqzh4QQTwY6p8ElJRyGy5Bxza0a8
 4pzdQ03Hr2aZgBicntqUNE7SyaRxwwhSZL8hlSgAgj86ys66ZGzdSqIvTuzIkjntWBLG
 Ki9xY93svFgar12b5O1sYOk105FpBe1ZqPFeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963164; x=1706567964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9MseZBEADDaOp4bJP1GnfYPVOTLeKmz51YHYiXb9lkM=;
 b=a+OHscERCbRYgkhZpI5Z+Xt1xJs6cdf1Cet1qyWk8/vFuAaNtvL3Yrvo+1LQ+fLzi3
 33BKDeUFj1XihWb222Y3zoiZeAtbY44rS/bvHuqqxZxMYUHY1MmftvNhbtbfGf6ziSX6
 8zK/Y1jNp7xqNDrA5yzTBmlb+EID6ya8XIGLMfHSRRjEjm1gjN6gLm+1WqVTf21Wr40F
 BRkWen4DwEMG5QNgrPCVtqzHLQH8cWETG+1QyNrv3W+rVNFhboRzXh2+1os4hzQMRAfa
 yLXH9h2w0ZI+KV1kAI1ha995XlTNfe9Yo881ERuTHGpApLsQV6qlDj4Cm0Ayra+8SvIS
 wIjQ==
X-Gm-Message-State: AOJu0Yznbv6HKq62+U+gqo5gsFk/uiRJZqGg2zXuwe9e9/Os+Mt/AcT+
 E6+5iISpjseacTrRxG53tUHhmY16Ct9HGpmm3DGwTwwm0ul0SutwKAaJua5lbqUY53NDJsfvzc4
 3
X-Google-Smtp-Source: AGHT+IEFc4BzZSQXW0BOJ+U+5dpWNBNo/ICxmhYAF0O6OrktDiVbnDyONJZhjpzZo/Z1cGcErJcYkQ==
X-Received: by 2002:a25:d092:0:b0:dbe:f203:7d5d with SMTP id
 h140-20020a25d092000000b00dbef2037d5dmr3298243ybg.97.1705963164716; 
 Mon, 22 Jan 2024 14:39:24 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 04/16] bayleybay: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:08 -0500
Message-Id: <20240122223920.3630168-4-trini@konsulko.com>
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
lack of board.h file, unset this on the bayleybay platform and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 board/intel/bayleybay/Kconfig     | 3 ---
 board/intel/bayleybay/MAINTAINERS | 1 -
 include/configs/bayleybay.h       | 4 ----
 3 files changed, 8 deletions(-)
 delete mode 100644 include/configs/bayleybay.h

diff --git a/board/intel/bayleybay/Kconfig b/board/intel/bayleybay/Kconfig
index 97228d630878..af08566014dc 100644
--- a/board/intel/bayleybay/Kconfig
+++ b/board/intel/bayleybay/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "baytrail"
 
-config SYS_CONFIG_NAME
-	default "bayleybay"
-
 config TEXT_BASE
 	default 0xfff00000
 
diff --git a/board/intel/bayleybay/MAINTAINERS b/board/intel/bayleybay/MAINTAINERS
index 85fa51626af7..5ab5d73f59e5 100644
--- a/board/intel/bayleybay/MAINTAINERS
+++ b/board/intel/bayleybay/MAINTAINERS
@@ -2,5 +2,4 @@ Intel Bayley Bay
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
 F:	board/intel/bayleybay
-F:	include/configs/bayleybay.h
 F:	configs/bayleybay_defconfig
diff --git a/include/configs/bayleybay.h b/include/configs/bayleybay.h
deleted file mode 100644
index 9b0f5cedcd79..000000000000
--- a/include/configs/bayleybay.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
- */
-- 
2.34.1

