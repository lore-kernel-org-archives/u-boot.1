Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737CDE674B9
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 14:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C008883B99;
	Mon, 22 Dec 2025 15:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mhScXMTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4839E83C28; Mon, 22 Dec 2025 15:28:02 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F98683B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 15:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-34a4078f669so3990997a91.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 06:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766413678; x=1767018478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pkqoCtmiUVMeDeURZQ6LK1OSYPfV/X6P5LRj1DI5lEQ=;
 b=mhScXMTAbJ2JSJD8nRXb3P8H0VBhmYm79bTKv4wvfazTWlvVahU15oiskDhPrsopiR
 jLlHCoyEh0YbBxbY+0N63m5xP3hE7gK1pO6Tfau1YGW5TSJp09In8+gELORu6fPx6qTB
 npjR9OLgGwYh23EOezOrR+Ux6PPdK+SqgQ+4n7TzFsvEz0aSe5Djmo9M4YxXBgOZ93aB
 BvJiWsLhINpXrKKN64kpNH86Fhdt4Dd5XssZDvqBpeABlODZ1PfY6Q/mOdK/ikKSdi2u
 UBdMZpEn2GnhnFutQpq1+BD/TCP3sVh1C+gGPX1ts/a1wAVRiAhjw2cIQ/9t3S/U9Z/u
 iYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766413678; x=1767018478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkqoCtmiUVMeDeURZQ6LK1OSYPfV/X6P5LRj1DI5lEQ=;
 b=j/TfJBbp8pewIu0AM1FibHpz2Xq/jhjvJNpfyXTbpGIenJRUsU4VXd7pTs9/wTSHQQ
 zcFnlS8Raqi7ort2E7VzpYZT2MW9LMF8Rc77sctEJF37955e9g2S7i5dKX2wkCSNC6dP
 jhiiJiWAKfSS6cE5P2+z1YZjocI/EerMqmmIdPuBdSzhE+T8f9gJRCc7x1FHbFAhSAtJ
 YfznGUyXfg0HhG14+GW7WOqu5xvXtECWC3CWuGbN4WMopi/a+FgpzH80SVRjIP+PBzxs
 wSa/0hr7gFRoemMKzSwYvGTLTFpjG/068/OHx99KoKXwcoWXWBUf+9TCKZ+VjdePveN6
 pO1Q==
X-Gm-Message-State: AOJu0YzLpcFaJ0kPUGKgd4QCmPiOJFUNiMLhQPGppAtWBuIAWhf/wE4f
 EKWbKyMPwXjNAE2HzLVtZ5carwkcHBZQ0t2Z72l4TFNrJmVBJltiQvoEvRLUbTy3908=
X-Gm-Gg: AY/fxX7ClWnpizgsbcSwIsxjVXb4SJs0prrP/KnHAg9pQ9ywspTuwb1Q+50ecuh7DkJ
 izjMHs/MoRQx+MankhUQvokOaFQKUL1l2D6gkWdD7aUHZB85VaUS4iqjhX1YdsAm3QRWCVPfsuT
 fBTKnKh34oESkGVYF6XkuxlW4BJ78qnQDjguHxRpJsdKEb9siK1GgtC6A6d6PQElVFOZCf8T2G3
 I6Xm2j305gM/2nXQ+xze0VRVwCDOdcu3fN3m1pCeXx2WosNo8FTOzVKIhsuUiW3uFW4Oa7UkBBu
 HJMC18HPsrTTiJ6vTTJUIV5nIulJlyP8b0PKYxcl66TwaVV1TRMS0ko4fT4yMcqC/grF4c90Fis
 XTaOtKRrmwEoRu/Cc3bpCB+VtW5gbawuhhd5ZAnNW0gvWi6Rqo0NIONKHZCTFWfWrue9RuuEHla
 YZO6mC17w0zyU4oSTlm6vnXnX0N5l9ya8U
X-Google-Smtp-Source: AGHT+IHC/5kHbFs2E66Sjbh/mfqZA+BhxqlCQgTFWsDr2/T6J5BP4XKWssvxL/qGMfx/U3LkaC8C+w==
X-Received: by 2002:a17:90b:2f05:b0:340:b912:536 with SMTP id
 98e67ed59e1d1-34e921f5816mr8471280a91.31.1766413677966; 
 Mon, 22 Dec 2025 06:27:57 -0800 (PST)
Received: from intel-VirtualBox.. ([94.156.205.87])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e920c9a7csm10156674a91.0.2025.12.22.06.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 06:27:57 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Brian Sune <briansune@gmail.com>
Subject: [PATCH v1] fix PL330 CMD supported target
Date: Mon, 22 Dec 2025 22:27:44 +0800
Message-Id: <20251222142744.74707-1-briansune@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The config is wrongly written, result
in only support socdk board.

Fixes: 92dcb3ad5d98 ("cmd/dma: implement dmareset command")
Signed-off-by: Brian Sune <briansune@gmail.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5b9c13d85e7..5c611fb3016 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1849,7 +1849,7 @@ menu "Shell scripting commands"
 
 config CMD_C5_PL330_DMA
 	bool "Release Reset DMA Channels for PL330 Handshake"
-	depends on TARGET_SOCFPGA_CYCLONE5_SOCDK
+	depends on TARGET_SOCFPGA_CYCLONE5
 	help
 	  Provides access to Reset Manager Per2ModRst. Enables DMA
 	  channels for ARM PrimeCell PL330 via reset release.
-- 
2.34.1

