Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37F0D5B868
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 20:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961A980077;
	Mon, 15 Dec 2025 21:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gVCw83DJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7492800D0; Mon, 15 Dec 2025 21:27:32 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 194838003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 21:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a12ed4d205so3752165ad.0
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 12:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765830448; x=1766435248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mp5RCnSshpDdT33S5grNkl5zhLor8wFejGJPzSckbQI=;
 b=gVCw83DJkva3gCPbssfOKPpwAaMKKBg/qJ8j8IB/4diD8Jg81u8Ymbo3o+Eykjxm4g
 ImiTQHgHyfk6PE51NjQK15Z8e+ERBSrLro++0PuD/pU3DCwQgTMIDgCFVXk8N4M8vCvO
 Ba2NQNAgFiBi/LDOJmM987i2RFQbchVeRSLZm+a9M2zp4j7ex6LPpbjwpiDDsQKPLk3X
 t3ZxAguRjND9yvgVehxOfdCq7Qw8MfJ5cG3ShGEsIM9D3gvtrEAx+4vXG/EIBJWrhatD
 LhqcTfESiESKlpGvWdxYF8zJyprz7WbZfrNeS7RF+2ivfybh7T9czJLK8jldv/R474/q
 3nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765830448; x=1766435248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mp5RCnSshpDdT33S5grNkl5zhLor8wFejGJPzSckbQI=;
 b=Mqjz3rcfsOlx4XyBAyUPWW28tdCsfo5KLTW6MM1IvwOOuT7GMoajej6dnONYnnaKeH
 Ugf1tQgKbM1Ov7wMlggUJ1vrvrC0dx7AljSo3Yxbxa16Ea1ga29/VBqIDjd9eh2SWOl9
 573hIU4ZllXuB0E/gOD7S4CmXcsbWEVBJsdCMNUbsw9FSacqyNkQVQd+sWU+o3Hzi3hR
 3tWCUtnJVTXzji/iuS+Iu/1DQAS5uMoj8yxhubgNYd5itPil/9MIlXjxMbx78S0ba4aN
 O3XA7gLR5HTVN4e8lkh7IZoRfzTUhtO7wBdBHP/zA8ZwIeA2PcfGGzxIDnoKYXmI4V9R
 InoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvA4OyEYz81uI4dCebBSefF3Ez1UGHuoqVfZi84QCrSN5cgwYXT8+pnEE4fDE090jKrGdKfnw=@lists.denx.de
X-Gm-Message-State: AOJu0YzRQe4M/lYaGiCq3YmhKLQZ4vB46a90UXwDp9/S/JtB8EM8nTf7
 0X9a5qI2A0/uZIHuruyO2VlZUpLBwqvy3/eqCodeQYYk5BQCuhVysWLY
X-Gm-Gg: AY/fxX7r2Lzt0DKZBbLCOg+56Po5twzHRgNCAeDHxpPUTURtMcSS4LSQL1pKduqgSCJ
 07K2jgJKGh8Cwj8FjzCTvltusYiakx/fcS362uKmMzYHKxJ71nxifqFjc3cWy6aJrzyscCsZqWY
 6Otlzp/WXIZC4cwAl4UsCRfsEOn2sP6DD1H8fcX0mDTajNYFIJOmTln3myKtdbVSSYzqkzIKo4n
 Vv9CX/EjTPYJHNMj0VnaXCZrmQv7p6JUHxhPGYVlzNwRJmQJ4Tg9Hg2korH2gAsY0sbj9Qrbj4g
 4+U4PhS+7274og4oM0iYsuxLDggE3Reu0ds+ff7Sq9bAUDlmqdjazEbbjjbmH83XwldnSNzIeHw
 YYaSq4TQf/UX2e4HxkIpGnmtdElhTHaVKdIXXH/mLCWesy1uHtz/1RgbZNNwBrrzZXLQXn9QYFI
 xb6NW1RnSkx3r/VqwRkNw7jo9/+/3K3YgTE6PJCQ==
X-Google-Smtp-Source: AGHT+IHo6M5fjTVIoJb5iFnfUQAr1mAdu0d3XwMZlVFKvVYaG0UWvA8LX7wfVxJ1p5BPfVXz2Q8w8g==
X-Received: by 2002:a17:902:d48d:b0:2a0:9e6f:2ce2 with SMTP id
 d9443c01a7336-2a09e6f2df3mr71643415ad.41.1765830448462; 
 Mon, 15 Dec 2025 12:27:28 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29efd74f5e1sm127427705ad.16.2025.12.15.12.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:27:28 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1 1/3] sync sdram ecc support to mainstream
Date: Tue, 16 Dec 2025 04:27:10 +0800
Message-ID: <20251215202712.175-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
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

It is been a while that the DDR ECC is missing.
Pull from Altera trunk and sync to mainstream.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 drivers/ddr/altera/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
index 7ed43965be5..b9e3302d714 100644
--- a/drivers/ddr/altera/Makefile
+++ b/drivers/ddr/altera/Makefile
@@ -7,8 +7,8 @@
 # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
 
 ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
-obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
-obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_arria10.o
+obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_soc32.o sdram_gen5.o sequencer.o
+obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_soc32.o sdram_arria10.o
 obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
 obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
 obj-$(CONFIG_TARGET_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
-- 
2.34.1

