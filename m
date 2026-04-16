Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E78F8A145
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 08:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D9FE840AB;
	Thu, 16 Apr 2026 10:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mhOL4pS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53CDC84105; Thu, 16 Apr 2026 10:47:24 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 552DF84105
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso3718615e9.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776329242; x=1776934042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OQzSckePx/MAGXW8zkDhFDD7+iffyF3SDq4Cg2uauA=;
 b=mhOL4pS0L8NP+bF04ORxRrg532TQ1GDSGIKNdMmpxX7k6ZdlkctVEhiayVQbXzZA5L
 3IfLtRUsUq+cy7aXlPd12ygIjkvqSqakT7nGHQQ8Sl/ExKV4Ic+SL0FaxgK6KdkztcgQ
 +hmjAxE1fbKWD8oAInsp8ZSDr2Cta/s3Apt9d12OkjEqlX1zYzao+450iRT4AqMRuC4c
 a0GKxcQj5bx4gTAIEe0DQeSprSptHNiHzncziW20B0G4K8+ncapVaN1L78Rct66YwKXp
 JcYfS5WLBQ4d2D5cXJhvWKqyUeaX+4n7EsOKV2QOJ8+KjqwhRsaVye6Ksvd0cCYMfiHl
 WEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776329242; x=1776934042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3OQzSckePx/MAGXW8zkDhFDD7+iffyF3SDq4Cg2uauA=;
 b=YqAKJvMQelLuQIdBOPvGm+wTSFLq6hrph3IVk/bbpUWenYPgUwtd0bDk+gbqO9S4WI
 iiNYZrKxbhZ//bih+Rrskx0AYnRrHLFMm+tefZIfX9pp7GcevRSS9FJisoQl5OAKLOf3
 S8d667UwXeZ6bAc5c8FJin4AFZVbTOAGWX317OzdiRbhVdaNY5MV0CSXfXlOkbJlpDEF
 +IkxA2XTay9bmyyiQNHQG/5LjKx5uXwpuPl93t0TphQHhldK1msNjN0U0vJOuU2KBxxN
 mv+8o53gvdoMkBI2oC1FuChBIWmbJ2vOFnWN0Sm1A4wJEAVay2mEWqOeJGlOFBsm0qAU
 Y3Sw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8spPA4MA8j5fGrpMsEOXsBHMyHzVotfgzeUvG+ZnWIZQX3l7q88lFPUEKrXziwWB38KTXliNI=@lists.denx.de
X-Gm-Message-State: AOJu0YzDX/AaG1xEaEvcl0Mu6nD+nEYB1N/JyzGyozpZXetXPq0vKTxU
 FGsqO3aZI27m6onUYu5HLmvLA32z2+8OqXhqyNVGMTHKVvOnBDHfMZjO
X-Gm-Gg: AeBDietUPU0coL9FNRF/kUOFBvNZb2YFsN8IcF0np4vdIQi2Zj4zRvM/XW5R5n2I8Nk
 DnG8AIAMuJtWcNmhqvaoXeW+BIu8CVSUM4ymGaPnLD9AMmor24gAFD3wJOHOEKQnaqpkPnuHf11
 SLQWqXm7i86xPQE0R/hMwtMwooR+7vPcHKUVa8dQIWKE8AXAte1PJztdL1xrn+x4/tHEjYGcAB5
 XM3M5oim7YCQkuOPgGrObCw5Qv68uhAxTvCDk/K8n4qW+QpjdWXCyQvE8plLHo9kL3tvvFSblD/
 sPNF7BYNgj70d7E+qSeVXg8QLEm83rRWVxv6EHfzC+cVKpfEcokUs2gTj5V25bxtRIkuXM8LHTP
 4fCmNfsJvzEUZjwVTymzntNfGTzZqzMABHaPvOwy0+TCp/6StmwrqsTH0PfHd5RkTrzNo4ZCiIC
 L1hx3zNBM0M4jKLNH8Ob6Vih3+6uHe1j296ysM1oSIqWJUfDkUdYbQuzoWl57xcTK/6fS8t+OwN
 6XtfEq6dkYma6iRRznE7EcMtltv6KHiJfWSCjKl41fNnagW
X-Received: by 2002:a05:600c:40d2:b0:488:e10c:d17f with SMTP id
 5b1f17b1804b1-488f4800189mr26969805e9.16.1776329241428; 
 Thu, 16 Apr 2026 01:47:21 -0700 (PDT)
Received: from emanueleg-nb.homenet.telecomitalia.it
 (host-87-2-163-213.retail.telecomitalia.it. [87.2.163.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3564d8sm13391674f8f.10.2026.04.16.01.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 01:47:21 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Alice Guo" <alice.guo@nxp.com>,
 "Sumit Garg" <sumit.garg@oss.qualcomm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH v1 1/3] common: memsize: add RAM size probe based on alias
 detection
Date: Thu, 16 Apr 2026 10:45:23 +0200
Message-ID: <20260416084535.1490476-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416084535.1490476-1-ghidoliemanuele@gmail.com>
References: <20260416084535.1490476-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add probe_ram_size_by_alias() to detect RAM size by checking whether a
write to one address aliases to another address.

Compared to get_ram_size(), this function allows the caller to:
- limit probing to a small set of required accesses
- avoid touching reserved or already used memory regions
- handle non-linear alias patterns

On the iMX95 SoC, when used with LPDDR5, accesses beyond the end of an 8GB DDR
configuration do not alias to the expected linear wrap-around addresses.
Instead, the aliased addresses appears to follow a pattern related to the
DDRC bank and bank-group addresses mapping. Experimentally, the observed
pattern is:

Write        Read
y00000000 -> x0001c000
y00004000 -> x00018000
y00008000 -> x00014000
y0000c000 -> x00010000
y00010000 -> x0000c000
y00014000 -> x00008000
y00018000 -> x00004000
y0001c000 -> x00000000

This helper makes it possible to probe RAM size by explicitly specifying
the probed address and the expected alias address for each size check.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 common/memsize.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/init.h   |  7 ++++++
 2 files changed, 63 insertions(+)

diff --git a/common/memsize.c b/common/memsize.c
index 1abf3fc47d73..cf46a6b17872 100644
--- a/common/memsize.c
+++ b/common/memsize.c
@@ -127,6 +127,62 @@ long get_ram_size(long *base, long maxsize)
 	return (maxsize);
 }
 
+/**
+ * probe_ram_size_by_alias() - Detect RAM size using known alias addresses
+ * @checks: Array of RAM alias probe descriptors, terminated by a NULL
+ *	    @probe_addr entry
+ *
+ * Probe RAM size by writing a test pattern to each @probe_addr and checking
+ * whether the same pattern does not appear at the corresponding @alias_addr.
+ * This is useful on systems where address wrap-around does not alias to the
+ * base of memory in a linear way, so get_ram_size() cannot be used directly.
+ * It is also useful on systems where the base of the physical memory cannot
+ * be safely accessed, so get_ram_size() cannot be used at all.
+ *
+ * Return: The size associated with the first matching entry, or 0 if no match
+ * is found.
+ */
+long probe_ram_size_by_alias(const struct ram_alias_check *checks)
+{
+	long save[2];
+	int dcache_en = dcache_status();
+	long ret = 0;
+
+	while (checks->probe_addr && !ret) {
+		volatile long *d = checks->probe_addr;
+		volatile long *s = checks->alias_addr;
+
+		save[0] = *s;
+		save[1] = *d;
+		/* Ensure s is written and not cached */
+		if (dcache_en)
+			dcache_flush_invalidate(s);
+
+		*d = ~save[0];
+		sync();
+		if (dcache_en)
+			dcache_flush_invalidate(d);
+
+		if (*s != ~save[0])
+			ret = checks->size;
+
+		/* Restore content */
+		*d = save[1];
+		sync();
+		if (dcache_en)
+			dcache_flush_invalidate(d);
+
+		*s = save[0];
+		sync();
+		if (dcache_en)
+			dcache_flush_invalidate(s);
+
+		checks++;
+	}
+
+	return ret;
+}
+
 phys_size_t __weak get_effective_memsize(void)
 {
 	phys_size_t ram_size = gd->ram_size;
diff --git a/include/init.h b/include/init.h
index 1e375da48936..c31ebd83b85e 100644
--- a/include/init.h
+++ b/include/init.h
@@ -14,6 +14,12 @@
 
 #include <linux/types.h>
 
+struct ram_alias_check {
+	void *probe_addr;
+	void *alias_addr;
+	long size;
+};
+
 /*
  * In case of the EFI app the UEFI firmware provides the low-level
  * initialisation.
@@ -88,6 +94,7 @@ int dram_init(void);
 int dram_init_banksize(void);
 
 long get_ram_size(long *base, long size);
+long probe_ram_size_by_alias(const struct ram_alias_check *checks);
 phys_size_t get_effective_memsize(void);
 
 int testdram(void);
-- 
2.43.0

