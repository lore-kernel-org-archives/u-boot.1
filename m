Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FCBCCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 16:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19BD283655;
	Thu, 16 Oct 2025 18:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="P97EJgLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC2F836A3; Thu, 16 Oct 2025 18:59:04 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08F80835FD
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 18:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D28A53F475
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760633937;
 bh=jYifiCC7/Mbl//mcoOAMbOYjubhgMbcz9etzlg/0eVs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=P97EJgLYMsbP9IG/pFeCpQI2FB+CV9KqFOc/zEnM2qYpbxBCUniYz/jDi5E2RfITu
 s93MH5PiLwmdYUvE2KIpiGJjhIHmXiKUVAngQFcQqkKK6xEJM6ekte8LTi1NRNns2g
 qrnTRY2VCVN90U1F0BNiB0aaFzlxNfEQdxX4tqnioBEGgwxnrY3EUsmy2Yhvcoh/ph
 /NP97WeDMbFqzmfeX/K76mLxwdnbT1lFE7BvcRkePNq7LL81uheXf6Mml59GG2Y0rf
 vuVA9401hEO64kUdyqhsppehsqIWIn+sj8wsyILJL1j6iWd98B+XCk5wkjRv2TFAvk
 3YupdYymPG47bwla0cpwyAHQmDjT9CbfCk2NVON20d1Qi09Y3szWZIMxG/OzC6Yi/C
 8A3WUsg6T/bs2Qcpiuu4HuJnp4lyM7gM+NFfYB61Egp2qp/lwSS4S94yID9BVU6y6Z
 8rc31wdNg/g8NHQZSgFLIFx444yI1DH0iAD98fjy8/IB1I+RlAZSYfnU1FMoGCTR+Y
 lcDpCHIH1cf3dEK7H2arLo9udLLR2KWWtoniLerm2zlUuyNEJyQt2kaaLX2RD2rx5C
 LN0xm7x9pJC+3CSqTfUEnHU4SJuLOOCYGCmAVyq5lmeLw2QzGrk0YgF68UOmAcl5Z2
 MEDFbP7mmjOURQbfy0Mn0uXQ=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdf7b5c46so693125f8f.2
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 09:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760633937; x=1761238737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jYifiCC7/Mbl//mcoOAMbOYjubhgMbcz9etzlg/0eVs=;
 b=n2IfLCKtXLvlHIAMZjePkq8SKAS1RrB4z5AhsErUNKPxxBE5ofwaf5atXmDfEAGeKc
 ntDWb4R3n+vdThyiL877KSSAalBft0OCp+JjQyzb55pOPEjMjpuqRA43dSIH1Sl7qlG1
 fIdITgPwgXPhnY5rDP12bzUuDH3F1jJvlM2D06eu0VYNs02Wuhej7HvHR5AQJVYZBbgD
 PgOBFOHljZZLUYf6NR33GWa3OZc+1JkMGvhKfuAxDHyxI2hdfQDZPB7BHiqzEtXGnBqX
 I2H7PxRWQVnYBObkK74+UU/GD1KBtIAvxBmTQ+WooTZmlMHH2UHhGqcipOvgoAY57NJu
 i2LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU4MJZslwfjtyrZfxCpM8iZPxxv3Aa8v8XzHpRazVSfJAEnQo8Ym1boksC36plBRnR0E0tCfw=@lists.denx.de
X-Gm-Message-State: AOJu0YwPnOJlAZN1CxQ5Ylnm5mk0wGnjDiUIWa2/VGpE2Z7mAC/ttLA5
 CVYDKtGFmxtAw4yTmijpQHT2Yaa9YhDLYyBrFlWlMA/ZQc4RMqMnOzyLayrJGIyojX7I5dCSh4O
 ykNiKn0gh2c2nGyGbNfNO+2+PgfTEtdjRBaOT5KUCewdBe3KgsFxiEkULRDQEUGxjdDbW8Q4=
X-Gm-Gg: ASbGncsWbIitgOtqmo1EpZ83E0mpUEMerETp+SgC8lK26mIGjET+cMcju9N68huvANE
 QW6+KcPi7aqDD8IxdvJyBQ0+zpx+Z7LcVuZSRXIesD2qgVMKuSyBW9+RLwHIDiDwApIvBDedqJU
 xQ2I6GMsbffdXr9iRgB8ZomKzbSpL1fioKD8fbtdOHKQmA6WmhmTBwSZuq7CKY3dEeUidKRwtUZ
 +KfE5rx5yAsSNj0h2/7ETaoKe6wX77oZqZxxC7514I8YYecZOTDamm/pVG2Z4tgi0eZexMEEFmr
 1cnpjARvdY4zyr0+rLydTbO1fQyo7jJPEjVKcQYhvswWwnSX1uI+sDrAb+nnAvMkrf3BDdp3vuv
 qs9EFm5BDRAUa0I7RtBf/hXsCAbGZYjYFTSXXSVkPrPVMrJx9pt66fEAHoGkkeYjaJw==
X-Received: by 2002:a5d:5f82:0:b0:426:d54a:67e with SMTP id
 ffacd0b85a97d-42704dc9bffmr714796f8f.44.1760633937400; 
 Thu, 16 Oct 2025 09:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvtLHZRsI1AV1fvN2VTmvDP4mEaR61CXBNZVxtLs23ber+rGvIm0Wb74ot1Ct2S56XPnDOEA==
X-Received: by 2002:a5d:5f82:0:b0:426:d54a:67e with SMTP id
 ffacd0b85a97d-42704dc9bffmr714775f8f.44.1760633936969; 
 Thu, 16 Oct 2025 09:58:56 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1284sm35458369f8f.45.2025.10.16.09.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 09:58:56 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: consider CONFIG_RISCV_ISA_ZAAMO in SPL too
Date: Thu, 16 Oct 2025 18:58:50 +0200
Message-ID: <20251016165851.45311-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Commit a681cfecb434 ("riscv: Add a Zalrsc-only alternative for
synchronization in start.S") changed the hart synchronization in start.S.
It uses CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO) to determine which method to
use. If the macro evaluates to true the old behavior is maintained.

The macro evaluates to false for SPL builds which was unintended. Use
IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO) instead.

This fixes a boot failure on StarFive JH7110 based boards.

Fixes: a681cfecb434 ("riscv: Add a Zalrsc-only alternative for synchronization in start.S")
Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/cpu/start.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 6324ff585d4..87b3ff0f93f 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -151,7 +151,7 @@ call_harts_early_init:
 	 */
 	la	t0, hart_lottery
 	li	t1, 1
-#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
+#if IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO)
 	amoswap.w s2, t1, 0(t0)
 	bnez	s2, wait_for_gd_init
 #else
@@ -184,7 +184,7 @@ call_harts_early_init:
 #if !CONFIG_IS_ENABLED(XIP)
 #ifdef CONFIG_AVAILABLE_HARTS
 	la	t0, available_harts_lock
-#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
+#if IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO)
 	amoswap.w.rl zero, zero, 0(t0)
 #else
 	fence	rw, w
@@ -203,7 +203,7 @@ wait_for_gd_init:
 	la	t0, available_harts_lock
 	li	t1, 1
 1:
-#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
+#if IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO)
 	amoswap.w.aq t1, t1, 0(t0)
 #else
 	lr.w.aq	t1, 0(t0)
@@ -219,7 +219,7 @@ wait_for_gd_init:
 	or	t2, t2, t1
 	SREG	t2, GD_AVAILABLE_HARTS(gp)
 
-#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
+#if IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO)
 	amoswap.w.rl zero, zero, 0(t0)
 #else
 	fence	rw, w
-- 
2.51.0

