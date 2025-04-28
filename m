Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B12EC36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 04:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 496B7820E1;
	Mon, 28 Apr 2025 06:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AWSkvLhh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 222EC820EB; Mon, 28 Apr 2025 06:49:11 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5A4580BAD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 06:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so3540829b3a.0
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 21:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745815747; x=1746420547; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LQf3ayroHFqqivgQhFOPb3sr8R1bTt6PkduMsz72ibQ=;
 b=AWSkvLhhRIadAf1KNa0D+tj4QRDHML6e4+MCJZD2G8XcNuEwN8pbF39tggMZId2HDv
 SbSuOqvVEfgiQIkZkWfA4P/WKo4BpDPtgZ2gPPI+ySNjJLxI4WzGTuLP4yIDGR9JQJ8x
 V2NgLqTnF7MycG3p3LVOWr0Rd01iFf5Rko0fsC5UgX2sfhbwpq/8ZtwdAE3oDkXNJu4F
 kvUMbV2/+DUjHhvbBs8kdBY8dLsqxqtl6wu8SLlhBTxLCV6HXgmLdk+QjU1ox1Y+/Fm9
 Vx8m6qOVepeFlhoSELcUAh4UwkGYkvRRsKxBvtT4Map/zWUDO0yngo15OVFTOhdYj/c8
 hOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745815747; x=1746420547;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LQf3ayroHFqqivgQhFOPb3sr8R1bTt6PkduMsz72ibQ=;
 b=BKtNr+DhvdCkuMmMJdKP7VZL8P8l/QoH8wOo70jZ8J4KXPUTLOhQzQEY3EHSVu9E7A
 CljwVb9rZ1xyIyrbDIduqK41TJwEP9vUzav/PzuAHogmZxi/YHhXbGXe+ZKzW5W9UsA9
 X4ieFEcFfo/neeSgzjpcP7HuyVNvRIsR9N6MJbZCwErXpj5yTELlsL8AF88o/jzhow5V
 LgWeL4ZzBfQGv28d1H5BvVeTAGt0kHuxr+zpBNnoOKVnLLIVZ590X1kNPPMRix1AYZOZ
 ZzR1qGNsSVCPbXR1FrZtA6YCTwlcskxPXxQbpymv3Sr49+SzOOAOyL4KrJ20WWMl3jWj
 CHYQ==
X-Gm-Message-State: AOJu0YyKBU/WIracTa1neYNUNqtGMdyAJcUOoqWRbMZ+FCs/s1EpKX1w
 F+vEq56NBufcvL744Qe/bnPRDcUnMxI/XRyLXnDBtkDU4/WtZ9bzRzQFJsZSEy5NZaaTs708qAx
 t
X-Gm-Gg: ASbGncszf8r9B9UxVwasNjj2+YvaWXEVjGPJXKNrtWBCSVo4Jal3JZDoQ/1ug/jXEPi
 PcxilsCJ54SwbXYSPOs+0vCsYu7kgEUYT8/v+2+/7oxsUUPXwXHGb6+n9mAbihGZvpl61PgWE3E
 +J155rNorVWMMBnXT903qbXk2vcjLCQHO2Z333mIGpqgjCY2rSdrCgs4zPJ4jBzSVmFWjqdJXkW
 ok0pFkSX6AAccOq5ACkiYYP4cvIb8Jdh4il2Ne4F6o4y+VkS3m4hsVq70Smdgi+YCK97on38f0T
 XUlETUlzErU8EviF/5eiMAbcVl/ycLKzHC+EtKOJKHw8NPLsYL33/pARdY1xkw==
X-Google-Smtp-Source: AGHT+IGr1KjMOXZ4bt+K7BnYauYWU42gMSO/wAIWo9IlR1oLk3uo0IDACGMX0OT5H1T/3Ch2Wr/OAA==
X-Received: by 2002:a05:6a20:2588:b0:1f5:520d:fb93 with SMTP id
 adf61e73a8af0-2045b76ef81mr17665285637.24.1745815746882; 
 Sun, 27 Apr 2025 21:49:06 -0700 (PDT)
Received: from localhost.localdomain ([103.97.166.196])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-b15f77032f9sm6347096a12.15.2025.04.27.21.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 21:49:06 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] riscv: insn-def.h: Fix header guard
Date: Mon, 28 Apr 2025 04:48:45 +0000
Message-ID: <20250428044848.1132018-1-mchitale@ventanamicro.com>
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

Fix the erroneous header guard for insn-def.h to reflect the correct
header name.

Fixes: bfc8ca3f7f6 ("riscv: Add support for defining instructions")
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/include/asm/insn-def.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
index 19a10cad84c..1869342b167 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -5,8 +5,8 @@
  * Ported from linux insn-def.h.
  */
 
-#ifndef _ASM_RISCV_BARRIER_H
-#define _ASM_RISCV_BARRIER_H
+#ifndef _ASM_RISCV_INSN_DEF_H
+#define _ASM_RISCV_INSN_DEF_H
 
 #define INSN_I_SIMM12_SHIFT		20
 #define INSN_I_RS1_SHIFT		15
@@ -36,4 +36,4 @@
 	__INSN_I(RV_##opcode, RV_##func3, RV_##rd,		\
 		 RV_##rs1, RV_##simm12)
 
-#endif /* _ASM_RISCV_BARRIER_H */
+#endif /* _ASM_RISCV_INSN_DEF_H */
-- 
2.43.0

