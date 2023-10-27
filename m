Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7800C25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 00:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F11A4875E7;
	Fri, 27 Oct 2023 02:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V6rxxtA5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51B02871A5; Fri, 27 Oct 2023 02:44:46 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB31875E7
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 02:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6bd96cfb99cso1453533b3a.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698367481; x=1698972281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V9rCkfYECu9k5ceMFY8QFpwHqpO9k9M7pI03+QBk5iM=;
 b=V6rxxtA5qyX6Szo41j6lSNe/vs5O/+Z5omYpvmsq9/1xkFDC0fxs9LMzhg8beX8DCk
 4qP0FnOjmzuDjHWqu5qopsuPRFS9kSd0HUd1kY94uxIlCODFofOr1Hrl9KUDR0A0M9ol
 mBFaxp1WWq12ZukF5CWjtgu1VktZur8fkKmOlabTFiwEWU/5FQ2BqFfalhWD+tZeCggi
 z3mGPLIF0FxcBZ5H+GzktCzgLmNQq9RQuTWHKv6dSkOqryNmENpm9v1KSVpeMaHMHGZn
 JhbDAJ74L+pRVfdjZB7NkZDmRaOwUCSg5kXkxYAzWy9LyIGzWX0FG7OaRL4AKHobRhHM
 yo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698367481; x=1698972281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V9rCkfYECu9k5ceMFY8QFpwHqpO9k9M7pI03+QBk5iM=;
 b=gEysIZgmFdjVngOqwjv4BD9JHUUc/YR30H1tJpdx4b46ThrB+mb8wfGq9vnwDWmcYQ
 3JQNf87rv8n2iBqXuSVooiLV0yCSZe04JM04TiuXgx/mnE2xqbkiCWqs/jU3HEul8OVe
 1fKgRoRjkD0uaJU7qUJkEYsyzc78gA8KgOugH83wk07dw1hQHgwdM0rInqzw0O+ED0AU
 Z+2lRINaqb9x48mnxlPzhFo0hSkDalRIiVCvW0Q8e4nNVSyveW+n51L8MigD/IrkdiFL
 vX0vfZldfmkeAg7dHL74MOQsSk5M9bMXyTVaEPTGANjkWrtcd87UPSXNPqSlNjiOds9o
 zNpw==
X-Gm-Message-State: AOJu0YyBJestQOPOropIJZDtAg8JTkR4eXFxq6+eWv4bKCWakBZlKidb
 hq4jrOH4EfPjFZpR+r7yuKmDxOx2Zcf7fA==
X-Google-Smtp-Source: AGHT+IGLnMyQpLTvGwzuIUd2JWgbG3+9qlIg/E9LRQXXTicsBCripLRKnUkCMfq0CxrzukzJ6cU7AQ==
X-Received: by 2002:a05:6a00:24c8:b0:6bd:3ba8:e60e with SMTP id
 d8-20020a056a0024c800b006bd3ba8e60emr1230434pfv.22.1698367481069; 
 Thu, 26 Oct 2023 17:44:41 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:b6a2:eace:f54:1956])
 by smtp.gmail.com with ESMTPSA id
 h1-20020aa786c1000000b006b287c0ed63sm191850pfo.137.2023.10.26.17.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 17:44:40 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: mvebu: AC5: Use finer grained memory map
Date: Fri, 27 Oct 2023 13:44:11 +1300
Message-ID: <20231027004430.442136-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.42.0
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

The ATF implementation for AC5/AC5X ends up with bl31 living in some
internal SRAM. This is in the middle of the large MMIO region that we
were using. Adjust this to be finer grained blocks based on the address
map from the AC5X Family Control and Management Subsystem Functional
Datasheet.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 arch/arm/mach-mvebu/alleycat5/cpu.c | 66 ++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-mvebu/alleycat5/cpu.c b/arch/arm/mach-mvebu/alleycat5/cpu.c
index 8204d9627515..0f72ae1709be 100644
--- a/arch/arm/mach-mvebu/alleycat5/cpu.c
+++ b/arch/arm/mach-mvebu/alleycat5/cpu.c
@@ -16,7 +16,10 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define RAM_SIZE	SZ_1G
+#define AC5_PTE_BLOCK_DEVICE \
+	(PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) | \
+			 PTE_BLOCK_NON_SHARE | \
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN)
 
 static struct mm_region ac5_mem_map[] = {
 	{
@@ -31,30 +34,63 @@ static struct mm_region ac5_mem_map[] = {
 		.phys = 0x00000000,
 		.virt = 0xa0000000,
 		.size = 0x100000,
-
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+		.attrs = AC5_PTE_BLOCK_DEVICE,
 	},
 	{
 		/* MMIO regions */
 		.phys = 0x100000,
 		.virt = 0x100000,
 		.size = 0x3ff00000,
-
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+		.attrs = AC5_PTE_BLOCK_DEVICE,
 	},
 	{
-		/* MMIO regions */
 		.phys = 0x7F000000,
 		.virt = 0x7F000000,
-		.size = 0x21000000,
-
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+		.size = SZ_8M,
+		.attrs = AC5_PTE_BLOCK_DEVICE,
+	},
+	{
+		.phys = 0x7F800000,
+		.virt = 0x7F800000,
+		.size = SZ_4M,
+		.attrs = AC5_PTE_BLOCK_DEVICE,
+	},
+	{
+		.phys = 0x7FC00000,
+		.virt = 0x7FC00000,
+		.size = SZ_512K,
+		.attrs = AC5_PTE_BLOCK_DEVICE,
+	},
+	{
+		.phys = 0x7FC80000,
+		.virt = 0x7FC80000,
+		.size = SZ_512K,
+		.attrs = AC5_PTE_BLOCK_DEVICE,
+	},
+	{
+		.phys = 0x7FD00000,
+		.virt = 0x7FD00000,
+		.size = SZ_512K,
+		.attrs = AC5_PTE_BLOCK_DEVICE,
+	},
+	/* ATF region 0x7FE00000-0x7FE20000 not mapped */
+	{
+		.phys = 0x7FE80000,
+		.virt = 0x7FE80000,
+		.size = SZ_512K,
+		.attrs = AC5_PTE_BLOCK_DEVICE,
+	},
+	{
+		.phys = 0x7FFF0000,
+		.virt = 0x7FFF0000,
+		.size = SZ_1M,
+		.attrs = AC5_PTE_BLOCK_DEVICE,
+	},
+	{
+		.phys = 0x80000000,
+		.virt = 0x80000000,
+		.size = SZ_2G,
+		.attrs = AC5_PTE_BLOCK_DEVICE,
 	},
 	{
 		0,
-- 
2.42.0

