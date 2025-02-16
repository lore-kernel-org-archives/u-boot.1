Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002C6C021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F88A80FEC;
	Sun, 16 Feb 2025 21:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f7qREAb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41248801B0; Sun, 16 Feb 2025 21:45:42 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DBF680C7E
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8558d9ca0b5so9505639f.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738738; x=1740343538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2YbH97acA4DwB7ayBD7cVQfcN+bx6ndadxxE6jOlzg=;
 b=f7qREAb59U8Dlp2m72gjxC14zCuHw9MykSzMF7lx3cdEfVoZ+gadzYUWbxKcxlTF5e
 Nw+F6M22rscyOZJS+RF9X45B3v5NQpwpkg4mXN8Vc0yN/ROc2DNY1lg9ohVMYbUOeO0N
 lk9waS2DB9n/JD6lP5s5kcoGwFODIE3cHusIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738738; x=1740343538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2YbH97acA4DwB7ayBD7cVQfcN+bx6ndadxxE6jOlzg=;
 b=RiahmwkL/uk4HMkz8PF41v39tyRR/U2/B6sgHpt1ugCdQgWPr2qg7eU+DHppcmCWtI
 T5M+iN4kAIC9PP9eJ8VlMCwMMDK+cd9nhmJczqcP0cvkPyBXBdtpJxGkBJTpVdf1SIPe
 AklFICExCkPnJb/xMqwfEsomvu0mbTZdip6s4M0KLirHqP+Nw8oCtWBs/Wj6W2sB8IgC
 kYNVGU9WGiCP2c0xbm/JOk7ECzTdBgEG/xoNOXZB/wlXOc95OS13/x/fsMzA2frxqgCL
 4xRoCxmB+PQ0OASkCpzzkX9aoK+NjU05puRDEVrT7+DoDD9JFohLfay62g3McQZDu7fm
 rz1Q==
X-Gm-Message-State: AOJu0YxhcM3QpBFgEIHi+tt2q6Zt7QdwJJIVKhlGt8a1vj+MUX26pYcf
 CVMiyHyG+GIhCo8khUoqBMMOt9ZF0BXv/eTQFCXcdFVT6t+SEYptrxo2+tbPTrXZZteWZu73Pyw
 =
X-Gm-Gg: ASbGncuZS/5JeodHiApOYNslJr25/fE0NJHsUsPt1+V1aRYsjolG9ZeF6n9SNdF0ofr
 SAjloZH+AZ8n7OOT/U60GUjf81qq9E7lL/0NGOPLumss5BONddhUX8j3fhw0Dfz0GgyyCFb+JnF
 q1YR1rkTYcNpuET+mZeojL48vNzSVKAPVm7MGne6qFQHPlvvOq+jEmUW5qRGhOGOoH7faaKRuW9
 2vjW4AnJm60xGAu+bZDqggImM4MW2AhlkWYRdDRnTZeosoxh7wX59YmHoM1GkCbjhBfcUL61Jov
 FinD1sg2ShvN2/vG03pTMU/3WWRxa8PRySKzAt6Bbf1Jhi68cTPx
X-Google-Smtp-Source: AGHT+IH6Gtn7pOGPAp9ghfrGcTP1+PjHqoI4E5b15T6gFxoqDKlGB8b1M+b1ZPbhs7haifjG8XoQJg==
X-Received: by 2002:a05:6602:4a07:b0:855:95a1:91a6 with SMTP id
 ca18e2360f4ac-85595a19303mr17445939f.3.1739738738193; 
 Sun, 16 Feb 2025 12:45:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 20/28] x86: Tidy up address size in MTRR calculations
Date: Sun, 16 Feb 2025 13:44:05 -0700
Message-ID: <20250216204421.3560012-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

The CONFIG value should only be used when it cannot be read from the
CPU. This is particularly important when using kvm since the CPU size
depends on the host CPU.

Update set_var_mtrr() to use the correct function for this, which now
supports 64-bit operation. Ensure that the lower bits of the mask are
zeroed as required.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to tidy up address size in MTRR calculations

 arch/x86/cpu/mtrr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/cpu/mtrr.c b/arch/x86/cpu/mtrr.c
index 07ea89162de..d05263c8eab 100644
--- a/arch/x86/cpu/mtrr.c
+++ b/arch/x86/cpu/mtrr.c
@@ -16,6 +16,7 @@
  * since the MTRR registers are sometimes in flux.
  */
 
+#include <cpu.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <sort.h>
@@ -70,9 +71,10 @@ static void set_var_mtrr(uint reg, uint type, uint64_t start, uint64_t size)
 {
 	u64 mask;
 
-	wrmsrl(MTRR_PHYS_BASE_MSR(reg), start | type);
 	mask = ~(size - 1);
-	mask &= (1ULL << CONFIG_CPU_ADDR_BITS) - 1;
+	mask &= (1ull << cpu_phys_address_size()) - 1;
+
+	wrmsrl(MTRR_PHYS_BASE_MSR(reg), start | type);
 	wrmsrl(MTRR_PHYS_MASK_MSR(reg), mask | MTRR_PHYS_MASK_VALID);
 }
 
@@ -205,7 +207,7 @@ int mtrr_add_request(int type, uint64_t start, uint64_t size)
 	debug("%d: type=%d, %08llx  %08llx\n", gd->arch.mtrr_req_count - 1,
 	      req->type, req->start, req->size);
 	mask = ~(req->size - 1);
-	mask &= (1ULL << CONFIG_CPU_ADDR_BITS) - 1;
+	mask &= (1ULL << cpu_phys_address_size()) - 1;
 	mask |= MTRR_PHYS_MASK_VALID;
 	debug("   %016llx %016llx\n", req->start | req->type, mask);
 
@@ -360,7 +362,7 @@ int mtrr_list(int reg_count, int cpu_select)
 
 		base = info.mtrr[i].base;
 		mask = info.mtrr[i].mask;
-		size = ~mask & ((1ULL << CONFIG_CPU_ADDR_BITS) - 1);
+		size = ~mask & ((1ULL << cpu_phys_address_size()) - 1);
 		size |= (1 << 12) - 1;
 		size += 1;
 		valid = mask & MTRR_PHYS_MASK_VALID;
-- 
2.43.0

