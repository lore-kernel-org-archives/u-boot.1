Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5096EC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8049F88A61;
	Tue, 30 Apr 2024 15:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fKOzA50W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5333C88A6B; Tue, 30 Apr 2024 15:36:29 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 371A588A44
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-78f0e3b6feeso196217385a.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484186; x=1715088986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSkcq150suzJg0MKGOzXBqxFew+tXPQ7PqTWVD1Lg+8=;
 b=fKOzA50WrEzMZzczE01KMxY6UNjg4n00sI20rBuEpUp8TBTThWUp2gbyhW1j8CYqmZ
 20VO6U5v/9Lo2aSDlmMcTx+8JQBiwYsA+P7nXTyGcTRtygRGrHyxjP9U/pTbQ+oNecMs
 f1ww2jG91xQddpTTgOS2ROI5fp9XYWGL17sXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484186; x=1715088986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iSkcq150suzJg0MKGOzXBqxFew+tXPQ7PqTWVD1Lg+8=;
 b=RwVB7MAGWQfICdjWntaF+xZIJHpf8/AMBJyA3L21K8KK2oyYxLfs5R8WmeiVLB9/l2
 eZlyBp30/hZpyQsdjMCmKkAWikl8Ugdky1UxKL42iUT69DTekxG1C6etTmAg9M75rROU
 kdOORqO4ssgWSKo0reaGZ9JJOaa5GF63YYPT/YyHGLeeWxLLGeX7NItqSXjgEFVxqAlt
 ZFFet/NT2Y8yGwo2AtN+ggwHmmLaFZwpaHpGUIK+i7Fre3J/YE5C3xgMieLKkLiZyZVQ
 ABZTq2xuSv/uXwmcejnQ67WtNIr/J26xl2Y8+T8z8iBUm+iD8u0FX/8Q1o0xeU3KTK71
 tICQ==
X-Gm-Message-State: AOJu0YwfmMXmwZltcmlM6E9HfZecd82Exthi9M08o8YQnk/aewb0X6fN
 hpK5ko9UqPlHSsXDPVoqdpAg5Qw60lRm1Pi2/ljKdHWWZECqsM6bWGOpsWVvydGXOgbKhfqRJ2Z
 r77Aceg==
X-Google-Smtp-Source: AGHT+IFdN4gvz8PIPti/HUaYt5z8zZjDbVZXgeCGjBfszxP5FtHZG1nS6L/kd/74KTvEdGD19pBv9A==
X-Received: by 2002:a05:6214:20a5:b0:6a0:d465:6088 with SMTP id
 5-20020a05621420a500b006a0d4656088mr6105823qvd.34.1714484185889; 
 Tue, 30 Apr 2024 06:36:25 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>
Subject: [PATCH 22/33] arm: kirkwood: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:48 -0600
Message-Id: <20240430133559.1836389-22-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

Remove <common.h> from all mach-kirkwood files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <sr@denx.de>
---
 arch/arm/mach-kirkwood/cache.c | 1 -
 arch/arm/mach-kirkwood/cpu.c   | 1 -
 arch/arm/mach-kirkwood/mpp.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/mach-kirkwood/cache.c b/arch/arm/mach-kirkwood/cache.c
index 009b7deeca64..acd2e8b1145e 100644
--- a/arch/arm/mach-kirkwood/cache.c
+++ b/arch/arm/mach-kirkwood/cache.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2012 Michael Walle
  * Michael Walle <michael@walle.cc>
  */
-#include <common.h>
 #include <asm/arch/cpu.h>
 #include <asm/cache.h>
 
diff --git a/arch/arm/mach-kirkwood/cpu.c b/arch/arm/mach-kirkwood/cpu.c
index 2b493b36c20d..a432abe615d3 100644
--- a/arch/arm/mach-kirkwood/cpu.c
+++ b/arch/arm/mach-kirkwood/cpu.c
@@ -5,7 +5,6 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <env.h>
diff --git a/arch/arm/mach-kirkwood/mpp.c b/arch/arm/mach-kirkwood/mpp.c
index 4fdad99cadef..7938820e513f 100644
--- a/arch/arm/mach-kirkwood/mpp.c
+++ b/arch/arm/mach-kirkwood/mpp.c
@@ -9,7 +9,6 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
-- 
2.34.1

