Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E41FC282EC
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D88D8209F;
	Sat, 15 Mar 2025 02:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B2vOI7zM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E1A820DE; Sat, 15 Mar 2025 02:28:35 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D3B982047
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7c560c55bc1so271310785a.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002112; x=1742606912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=w6WFHA34y0ofb6pD9NAY/OD+LBoGZfWxZesW58EvBwY=;
 b=B2vOI7zM8B/8nGCQqnuD/xVNpPJgsaY/sgk4LlbwHDbuxbBzagojTfePb58Yt9M1qM
 HLtbq34s9gP7o2VQ+cEEaOKBoXjVOZ8KyfPaQT/LWpSh1mpfULDlaQ7HNSTngZh6uC8w
 aNpEd3cKYQg3UudkbDqnoiBOCsHv03M3g/eko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002112; x=1742606912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w6WFHA34y0ofb6pD9NAY/OD+LBoGZfWxZesW58EvBwY=;
 b=fiwf5DRt5xkZyZahMruPJdPYznxGJtKKBspGDFK7YJVpgUGHjfcCY/hBpnsZ0QU9eB
 qNhaF70iXM1gX3SFQ7VIqxehZprsZTmU7P8IPFvVeyU3R3Kn/pAACKD7UhwX92mKF2d5
 4TvqfVS8AG8dhnNDaMlj0uQ6Im2Kjjo1MYg2YNng+iDPuRjiCeZeHTHVQfIbTCsRYPOk
 RC7rvu7K4zxxBemhwnb69pc30Ypch4KUU0zkN2+4CPiIISKUx0SXIe6uDRe1mYnlnNpr
 76lqgybAe8iOvmeoFES/+pQmk7pFNmPXj0isy5IORb6VxB9A11kcr/UWzazyEUnhBMTn
 Mn/Q==
X-Gm-Message-State: AOJu0YzPU9OzMmujt2HZFWYN7vVV5zvgM89oOY4oWU6rRpejqVhoPaG2
 JrHLTczJsHqgMv75BvkPPYP+clah/LnB7W1hUGLxRMoLq+M7lcnJAYHbjLKZUOfalDl9bs3YyEx
 g
X-Gm-Gg: ASbGnctDC9iGgaqTTgVzq4oy8wG8JoHqmUNbZ+5vHHyVQD9A97qTEGA5aca2MTiJ15z
 Dbi3DvWpVwLa4l/+mf3UT4p40wxx+Z1t5Wt5c38CJDkRJEXjuST2Hg9HLyw7X061otmuI2xUXec
 /1djSZfiFdIYr+3LKBev0u9s/8hf8Gut5eZNDnyVWPr2b+TDpt411zqA4I3W5bdKtbTaRlkOTl2
 KSaiCxYk397joqeu64Di71/8+ZK+Qqk3erQxTugYeUwUxPHIxQxaSG4xqJcSGfkh3qz0J4Yh+AT
 cjilqzWL4aiatKMl+rNM5/jiI8VeS/nttV6lWwhmZRucXHa9
X-Google-Smtp-Source: AGHT+IECSqnNyrukufM/qnf5r4D1T+N/k+UE6R4QqxM0lxTNokSMuOS8/6sJfT6C38QF3B9r6iXi1g==
X-Received: by 2002:a05:620a:2611:b0:7c5:4278:d161 with SMTP id
 af79cd13be357-7c57c8fd993mr646881585a.35.1742002112131; 
 Fri, 14 Mar 2025 18:28:32 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d9256asm320849885a.106.2025.03.14.18.28.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:28:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] mtd: nand: raw: Drop SYS_NAND_SOFT_ECC from NAND_SANDBOX
Date: Fri, 14 Mar 2025 19:28:28 -0600
Message-ID: <20250315012828.399259-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This option is only meaningful within the davinci nand driver, so drop
the statement here (which had no effect).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/mtd/nand/raw/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 609bdffbf779..3e0590a1d5d3 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -436,7 +436,6 @@ config NAND_SANDBOX
 	select SYS_NAND_SELF_INIT
 	select SPL_SYS_NAND_SELF_INIT
 	select SPL_NAND_INIT
-	select SYS_NAND_SOFT_ECC
 	select BCH
 	select NAND_ECC_BCH
 	imply CMD_NAND
-- 
2.43.0

