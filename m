Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058AFC54791
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 22:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB97C87E8E;
	Sat,  9 Mar 2024 22:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N6g37802";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 959EA87D5F; Sat,  9 Mar 2024 17:56:07 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B73AB87861
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 17:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5d81b08d6f2so1571936a12.0
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 08:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710003357; x=1710608157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5b38u8dmQccEnmp6JU69/Z2/7N2ryBTX50MHkj6EsMY=;
 b=N6g37802Rwi+4Ctts4p8sk2uIw+Tv1Cm8e8YtCTbTQ6pH8oBcRt8/6Iv2UGPm00DUI
 TEyqKe49Qj1XdgV2CZ+Rum6sgvHfRh6h9gTaGfShFWNB/bjCyMYcXxrvdDmS9A9QlN09
 3demntXx+D9GhUaM1jtzjAHaiJzyJYuigj/mFICcN9bis4QAdSBo1FzibaGwy90eWQdN
 kXwECCK7+vVHdA5dGUKPtSC3IXXLtkFhVB5WwW9uJv235xsPIvTLoaf9YwR0jGU01Qp/
 n7+Yq7aJyX6g/JlEUSArUWOALNYyaVZX5RSFCcsNzK8W+ukym+soUuCudwc6HPH06afv
 cRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710003357; x=1710608157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5b38u8dmQccEnmp6JU69/Z2/7N2ryBTX50MHkj6EsMY=;
 b=qpA/SIhvDzyF7nj9bwsBc/kluV6Xek0F4e0f2eJyKMF499vcEzFmbeTxF/yeoI3MT7
 e61M2kaeXWYGPFqiUc0exSVKPzYtrgNFCPax29yUNDFGpw0VNF+kZZgpYFvgPA2pUslZ
 iHBfdCsCx7yTM2eyOEfAE5fqCBmm/oe0Papo5dPwFb0110NAi/rHEWHflgQUrSM+HUCm
 KSsiFEq3yfYfYVqCfSwg4y1FGw4Ptbo1JmDeHwdi6/HHsII4zRWYphHYG/x8YHveNVN0
 xKlLjuqZasTGdXxoXjUb9bS05zpKyNEPenKamPiVbZQMt/TqcgZwaQvfMh1zbww9rAQ1
 YCcg==
X-Gm-Message-State: AOJu0YwtNmzzKqL2hqvhUKCqnhkK+yqLiqqEZ/c58dh2juVP/cANbPAf
 a1W7dzwQQ+38Q6qRypr1TNID2nAv8zXWRxZZf7i7mnb4QF5xVi6M9ZS1lGmvOiSEPw==
X-Google-Smtp-Source: AGHT+IHkX/4kXJsMd/OeTU5LzgkrohqiFcWGvkyyCeyJ99NL69iIiNNh8g2EsKAVmgKuMSTi0bAhjw==
X-Received: by 2002:a17:902:f687:b0:1dc:69ab:7dc0 with SMTP id
 l7-20020a170902f68700b001dc69ab7dc0mr2566400plg.27.1710003356519; 
 Sat, 09 Mar 2024 08:55:56 -0800 (PST)
Received: from localhost.localdomain ([117.135.91.249])
 by smtp.gmail.com with ESMTPSA id
 ju11-20020a170903428b00b001dd5ba34f3esm1529252plb.278.2024.03.09.08.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 08:55:56 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] riscv: cache: Implement dcache for cv1800b
Date: Sun, 10 Mar 2024 00:54:57 +0800
Message-ID: <20240309165533.48795-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309165533.48795-1-seashell11234455@gmail.com>
References: <20240309165533.48795-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 Mar 2024 22:59:37 +0100
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

(no changes since v1)

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

