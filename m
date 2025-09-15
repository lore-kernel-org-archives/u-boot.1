Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A18CAC597
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 13:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E40A834D4;
	Mon, 15 Sep 2025 15:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="dDR+Lcyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AFB882C84; Mon, 15 Sep 2025 09:44:53 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A49D28317B
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 09:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jimmy.ho@sifive.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2445824dc27so33765745ad.3
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757922288; x=1758527088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=chPgoWzRq5DYntczAVxdc3aehsH7UExofh9sxKY60VU=;
 b=dDR+LcytwmlW+385nfF5jTu+Z4Hd0DX3n/hvnBuJeGa0FzPCthtqmeKHsuSOHvVkv3
 OBlX2S58pmQRYvDrj7wqqykPV7x8cISEXcwtj3r0pIE5h414yBysAf1zqA2QsLKrEgsN
 RKQIiSc13SAVkZP9JDH1IRHjuTMNSHXVsmOv4drebdFneMwiNgytjaEYEvXvmBtcWX9/
 XuhtZj4ySYEQ9tsykD+PAHieo6x5RuynGBWcDzGdQlQ0JjUG9f/q7wveAEVQs3xhGvSJ
 +IPK2iDqn9kg9eEJ1/+tqBPKh/16ocAjuS+z5VnglTjwDPrVXHjiczc1IbEyzvH5ZhjY
 JwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757922288; x=1758527088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=chPgoWzRq5DYntczAVxdc3aehsH7UExofh9sxKY60VU=;
 b=G6ZLCT59F4xXs/ejZavtyanwAGy+O84hUR99WRKM5LYbM34sOhvfCzTDT/8dH8SkzX
 ZT/dXRI2KuEL93X/lbQHE6nDzDb+dr+uuTN9yQnBE2VFF1Y4IdUt9WYGG3GcgMkAhzLN
 yMDqvqmEibz7S7EvqrSgf9sNIh/3qlbJrblQb/4WN9bp+1Dn+mYwMzYL4+DKabWmrs4E
 cPSgh9RowYZ3K/Sh6T8z0oka4P9ZHYkrt/TwnFK9fdKBNTrgz627qT8bS9lpG5h/Qw0R
 VIBl0ckEZ+C9++fhUgwIki/d6BTgyvqjhJUctDx6wZGsnzReMs1ufFlxNCKak/+qewzN
 MX0A==
X-Gm-Message-State: AOJu0Yx7HfIjofVaCUMGICKSLoj4McdKYCcwIKfwKq2KPMVcoTnuXXwP
 DCT4VVgxQxCwb4dx/XZV32+iiSa6NLdkU63xwGa+7EbQJKgMKe/GwO9IVtAF9O2IMGaghI486u1
 uAp8H5yp1Sj1HPlCcDsOs7tUF2eRAFw0ZctEqRYivej5w7GxDVZUzXX8Is41MgbBMhgU3wUJY07
 UGCWjmOgb/P831uGy8hcaDbH+fARLMLdqne3mC4wMR
X-Gm-Gg: ASbGncsH4h3gOS5w6Ek6S2hwCXpu7miejgHuflmovx9oNYH2x8fguQBJ6+XmZOEHy8/
 WPyIqlWHphNf2U2SwQ3tURO6N8KnXQv+1syw0gF/bnsCEyyxd1da+zRpW5xZAAVXPZGtzqZ53j8
 +9GF8tykpIxGumVj+hen+huhTB8FYnmpfqaCoxd2pD4mrC4mD1zpYqg7BvmO/TjQHKwn+XjunFE
 ndrKD0z14UfpekobDbta1YQsAhuBaEfZoTG8q9lHrQflZiHfUeF0Dqkl68EBaFozqjaYFi4o0rs
 2MxdF2z3ZtnenhAERbAj6WWldMb8xp5TmU1Kl73gZUCezplhTsbzIBBJ/urj1/T00RL1iqT9c94
 k5kJPiZBJ6E9zkbN+VVfIdJ+OVO8uqQx6NGdP2PtHeATKQw==
X-Google-Smtp-Source: AGHT+IE51vhJ86Es5vUVSKoRqc/BC09Nzn/0JFcPdIHoFRYrEZEoeCDWLtM4mISdIwa/V7yTLXNr2A==
X-Received: by 2002:a17:902:ec86:b0:267:6649:ec10 with SMTP id
 d9443c01a7336-2676649f0ecmr18319105ad.4.1757922287620; 
 Mon, 15 Sep 2025 00:44:47 -0700 (PDT)
Received: from hsinchu01.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25e2fb546f9sm86056175ad.127.2025.09.15.00.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 00:44:47 -0700 (PDT)
From: Jimmy Ho <jimmy.ho@sifive.com>
To: u-boot@lists.denx.de
Cc: Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH] arch/riscv: Remove unused macro in encoding.h
Date: Mon, 15 Sep 2025 15:44:27 +0800
Message-ID: <20250915074427.31985-1-jimmy.ho@sifive.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Sep 2025 15:06:01 +0200
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

From: Greentime Hu <greentime.hu@sifive.com>

This patch remove the unused macro DRAM_BASE.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/encoding.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/include/asm/encoding.h b/arch/riscv/include/asm/encoding.h
index 56c5da86e86..ae3e5bce5c1 100644
--- a/arch/riscv/include/asm/encoding.h
+++ b/arch/riscv/include/asm/encoding.h
@@ -95,7 +95,6 @@
 #define DEFAULT_MTVEC		0x00001010
 #define CFG_STRING_ADDR	0x0000100C
 #define EXT_IO_BASE		0x40000000
-#define DRAM_BASE		0x80000000
 
 // page table entry (PTE) fields
 #define PTE_V		0x001 // Valid
-- 
2.39.3

