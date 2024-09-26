Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77070CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA9588FCB;
	Fri, 27 Sep 2024 00:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TyzWhIJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C21E87B77; Fri, 27 Sep 2024 00:42:38 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E676888FCB
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4581f44b9b4so9517991cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390555; x=1727995355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whqHPJHivPL376NCSJ2mLWzDeDV8+pWXwlZ3UMUvvmY=;
 b=TyzWhIJ9Zj4K9TjRYl5O1mvHbvfCEqnInV2PrewuV09k6I6stXp9P6jb6X690W1BRb
 scwfuZq6vxZkmMOJ+lxzCZKGgYhkWkrl02XGLrtW9Lm8Tnr8AO4KgKa4jZn3d+8HIahX
 6WaWoQyeboUZc89dJMnRwQ3bte78c/MMyd+fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390555; x=1727995355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whqHPJHivPL376NCSJ2mLWzDeDV8+pWXwlZ3UMUvvmY=;
 b=YniaoVWFTxK4foXFwpbgzSsFUawPq2YzT55rM62DQPop25e9qo26tVQhNcbwhLQRpN
 QTyPSLn416LD30B8NsGsK1sxwgxPjoMjg7wON82Kh86JlIWX/hM4rU+KOmzPQR+XdaPH
 fjIhZEa1X7f1MXOug5ORdQQ5cgUyNhzDdO00Gpg5cD2FRBzTibFtVft8pTvIKS0h4+JT
 o01P1cLX/KoNKv3wZ2ZK72tdd+b2QQ3M8nTGBYJuilfHNfJyvu6+l+sbGOcuTV+LdCtz
 JFlznR4cNTXusd525nC3MNrO05ygv0hQxVQV6HW+A9Fypsu/H+6lEIcR23K2sN3hrvWw
 x/EQ==
X-Gm-Message-State: AOJu0YxITfKbd3ygFYf7Uq5rRjDbRxFcrwM31QwPQbQ8cQlQErN2Z4+c
 oNODmdhYv7x7DoGhIsYbiGhXgRFOaIU+gTTwnZPbcSJEcT8KsntxAj2u9kpXvcdpN88i3RqtiCp
 dEPnvrmU=
X-Google-Smtp-Source: AGHT+IE8+4q+6mqiPzoXXcsE4mqNv0T2eHO9Ejf7fmIVhdR22FDKi5cJHDhuRLhv6XQfFuOUc4xL8Q==
X-Received: by 2002:ac8:5a49:0:b0:456:959d:ec3d with SMTP id
 d75a77b69052e-45c9f282e79mr17892151cf.43.1727390554755; 
 Thu, 26 Sep 2024 15:42:34 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:42:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH 18/42] freescale: Simplify check for SPL
Date: Fri, 27 Sep 2024 00:35:43 +0200
Message-ID: <20240926223814.1276764-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

Now that SPL means SPL (only) and is not defined for TPL, simplify some
checks for SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/congatec/common/Makefile        | 4 +---
 board/freescale/common/Makefile       | 4 +---
 board/freescale/p1010rdb/Makefile     | 4 +---
 board/freescale/p1_p2_rdb_pc/Makefile | 4 +---
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/board/congatec/common/Makefile b/board/congatec/common/Makefile
index f8170d9c653..d4ddfbf9716 100644
--- a/board/congatec/common/Makefile
+++ b/board/congatec/common/Makefile
@@ -7,13 +7,11 @@
 
 MINIMAL=
 
-ifdef CONFIG_XPL_BUILD
-ifndef CONFIG_TPL_BUILD
+ifdef CONFIG_SPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
 endif
 endif
-endif
 
 ifdef MINIMAL
 # necessary to create built-in.o
diff --git a/board/freescale/common/Makefile b/board/freescale/common/Makefile
index c491dc8b241..0e1dec49238 100644
--- a/board/freescale/common/Makefile
+++ b/board/freescale/common/Makefile
@@ -5,13 +5,11 @@
 
 MINIMAL=
 
-ifdef CONFIG_XPL_BUILD
-ifndef CONFIG_TPL_BUILD
+ifdef CONFIG_SPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
 endif
 endif
-endif
 
 ifdef MINIMAL
 # necessary to create built-in.o
diff --git a/board/freescale/p1010rdb/Makefile b/board/freescale/p1010rdb/Makefile
index df4e8001d38..c56ed82cb50 100644
--- a/board/freescale/p1010rdb/Makefile
+++ b/board/freescale/p1010rdb/Makefile
@@ -4,13 +4,11 @@
 
 MINIMAL=
 
-ifdef CONFIG_XPL_BUILD
-ifndef CONFIG_TPL_BUILD
+ifdef CONFIG_SPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
 endif
 endif
-endif
 
 ifdef MINIMAL
 obj-y	+= spl_minimal.o
diff --git a/board/freescale/p1_p2_rdb_pc/Makefile b/board/freescale/p1_p2_rdb_pc/Makefile
index 8c13813e3b0..38f2f53ff03 100644
--- a/board/freescale/p1_p2_rdb_pc/Makefile
+++ b/board/freescale/p1_p2_rdb_pc/Makefile
@@ -4,13 +4,11 @@
 
 MINIMAL=
 
-ifdef CONFIG_XPL_BUILD
-ifndef CONFIG_TPL_BUILD
+ifdef CONFIG_SPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
 endif
 endif
-endif
 
 ifdef MINIMAL
 obj-y	+= spl_minimal.o
-- 
2.43.0

