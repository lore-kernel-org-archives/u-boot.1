Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482CBC4828E
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 12:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFBF387CB7;
	Fri,  2 Feb 2024 13:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c7suW04A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8E0F8746C; Fri,  2 Feb 2024 10:38:14 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD2187061
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 10:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d91397bd22so15355325ad.0
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 01:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706866690; x=1707471490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCWVF8hn32JqV+eQrtUM3GpwL4Xtg3egKRsF4ccsqps=;
 b=c7suW04AzmEHjWKXGjjoSFftgwTfeYHCCIGpM8oKSxtUuDrfr+Kr6HImi4/FabS1pU
 cfmr/kWRLybraJC8/kjngIHdgUi94cymO4ugwA636D0kUoa6/HEmyJCw+u9txkbmkLii
 1EeDxr7DvSnQYXa609UI4j8b0+taewu0O+ttWcO0bKzp9K7CITuZagBDnAD7PNigyCbo
 r326h3Ws24CVdYrM54z5iq+Zuam1s7t5Inn+Ku8Pjdf/DiOcCHJ8OL2mEpOJU+oJogqy
 Ce+t+47k64RDW5eZxrxB23+R9dsscD1YaTiMt0pGXgM71ZVo1C75k93oQ/GoA6eLhuJW
 SgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706866690; x=1707471490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCWVF8hn32JqV+eQrtUM3GpwL4Xtg3egKRsF4ccsqps=;
 b=ihCGSGPUO4jg/iFWdNpZPKZfaZDKX38oIOXptxa8Zr3HCKyL6Y//QiNKODAtTEcKRJ
 YzEaODiyNxy89UIy5eYT5zd/LEdlrvVcK7YJp6gF/nmWS0DNWbgtsFNR678MoZBG2D9L
 FT1YIpm/kHVDaDZJ1iRMYaPsk7nfVc8k9ovUxddwigKYe1ALpALWMwdySn/UvW6wYMHD
 YDad+d6rnFaHupD+oiTFBUBgrzmUREhOCUP7gYHZvHigH8WTn+gXzbar3RKSY6GLYR0Q
 ZRFziTGRWl0QQxe7EiGzcFbW7UBJ0Tfjb5DxfnPyZrBMpNCIa1D3FSATDIrZViVUB3OS
 L//g==
X-Gm-Message-State: AOJu0YzotBIXXxBnqgv0GP5QOgjCwGdbnf/icB7409GEU861gaqAocGG
 TWpSaBD+UD3s0hQtUhSiwdyI2on7Go4HqbpW1BntsJmHYz2cPDa0DTRb67W9AYJp0GuS
X-Google-Smtp-Source: AGHT+IEst4Szcu2I+/7zjx68UdBR2242CFG+X325M5tDgKtpMTfoSDqlEDmxSFPlMiydi5Pl0UKT+g==
X-Received: by 2002:a17:90a:4591:b0:293:bdef:ce72 with SMTP id
 v17-20020a17090a459100b00293bdefce72mr7553358pjg.9.1706866689741; 
 Fri, 02 Feb 2024 01:38:09 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUqh0gNLFYFMnS5r2Xlki6/Mvg02RhLYI6JlKomtS/9AfmUeQAXl9FLZk5KsekxC8rDEtVf5cfDx1G59f8B5X9Z1WrOCtYAgP7/bN8XCuSmdDbh6mGpDw==
Received: from localhost.localdomain ([125.126.161.226])
 by smtp.gmail.com with ESMTPSA id
 mf7-20020a17090b184700b0028e2a0d297csm1331612pjb.41.2024.02.02.01.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 01:38:09 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] riscv: cache: Implement dcache for cv1800b
Date: Fri,  2 Feb 2024 17:37:19 +0800
Message-ID: <20240202093748.330658-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240202093748.330658-1-seashell11234455@gmail.com>
References: <20240202093748.330658-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Feb 2024 13:31:24 +0100
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

Add dcache operations invalidate_dcache_range and flush_dcache_range for
cv1800b.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 arch/riscv/cpu/cv1800b/Makefile |  1 +
 arch/riscv/cpu/cv1800b/cache.c  | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/riscv/cpu/cv1800b/cache.c

diff --git a/arch/riscv/cpu/cv1800b/Makefile b/arch/riscv/cpu/cv1800b/Makefile
index da12e0f64e..95beb34b51 100644
--- a/arch/riscv/cpu/cv1800b/Makefile
+++ b/arch/riscv/cpu/cv1800b/Makefile
@@ -4,3 +4,4 @@
 
 obj-y += dram.o
 obj-y += cpu.o
+obj-y += cache.o
diff --git a/arch/riscv/cpu/cv1800b/cache.c b/arch/riscv/cpu/cv1800b/cache.c
new file mode 100644
index 0000000000..b8051e29e0
--- /dev/null
+++ b/arch/riscv/cpu/cv1800b/cache.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+#include <cpu_func.h>
+
+/*
+ * dcache.ipa rs1 (invalidate)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01010      rs1       000      00000  0001011
+ *
+ * dcache.cpa rs1 (clean)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01001      rs1       000      00000  0001011
+ *
+ * dcache.cipa rs1 (clean then invalidate)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01011      rs1       000      00000  0001011
+ *
+ * sync.s
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000000    11001     00000      000      00000  0001011
+ */
+#define DCACHE_IPA_A0	".long 0x02a5000b"
+#define DCACHE_CPA_A0	".long 0x0295000b"
+#define DCACHE_CIPA_A0	".long 0x02b5000b"
+
+#define SYNC_S		".long 0x0190000b"
+
+void invalidate_dcache_range(unsigned long start, unsigned long end)
+{
+	register unsigned long i asm("a0") = start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
+	for (; i < end; i += CONFIG_SYS_CACHELINE_SIZE)
+		__asm__ __volatile__(DCACHE_IPA_A0);
+	__asm__ __volatile__(SYNC_S);
+}
+
+void flush_dcache_range(unsigned long start, unsigned long end)
+{
+	register unsigned long i asm("a0") = start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
+	for (; i < end; i += CONFIG_SYS_CACHELINE_SIZE)
+		__asm__ __volatile__(DCACHE_CPA_A0);
+	__asm__ __volatile__(SYNC_S);
+}
-- 
2.41.0

