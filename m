Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994AEC28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8395D81DDF;
	Sat, 15 Mar 2025 15:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EpCBTr5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2042481D4F; Sat, 15 Mar 2025 15:28:01 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C01081DB4
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-394780e98easo1929216f8f.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048875; x=1742653675; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNuzJfPDaZaB7ecS5GRPPbVXmgD5XgLjxuFZewrYlIg=;
 b=EpCBTr5P79gwcRE7RpXpHYtJDBPRBTBirjE4DtrxQKOFdsKFkDh0ZwGFh1TN5g347C
 Q6l3CdyNmNbs1z2lJPoKS+GK1Rs6XfI9OIvzpiXcsDB+18kTRmkLwWeG2cEQx9ekmGFR
 8w+sP1GNwNe8VMnmmOCVuPpIMis1RVv3m7dxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048875; x=1742653675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bNuzJfPDaZaB7ecS5GRPPbVXmgD5XgLjxuFZewrYlIg=;
 b=JWIlCpAUEzrD/ceohSadIvkazMOqR1X1yWXPkZgo28OPxidMdJK6Ab1/hrhUSUvGgZ
 m2rTh38oQJ27fe2JV0UwOUWAzdIIKK2vCeOBnFY4XHkyD+ArQbt+95Sz6MebU73vjpAO
 uky41Uv8ccujWjnPwZQXTpwDUsvWeGiHm+sD5R5sobL7XIuh8O/fQIB7AKUJ/6Ewaz57
 p6RLYqPuWjYoTkCd2TECLaounO0Koma20qHG9wzQ7UqmQJGGIcjJ/4TRDW+YDvUgNL/O
 kMGFhPAbWI7SXp7azmGUWOXV9EXfKDHrxuMgMdKAh7W+UKphcN7wYmZF29yDoTbo+cj9
 eUCw==
X-Gm-Message-State: AOJu0Yw5rGdp9YkTiToIiK7UwsRADxh0XF8Dm0N0ggUZ7snuxioWg7tY
 56iiBeW5ahBBb+A+4jt6U4RUwjppwX9aHEZ7jGbXECHG4yQSlbsYT3Q9V1dqqD441FvXZfkMdCS
 2VA==
X-Gm-Gg: ASbGncvg9VOAlzkg5nE1OteOyhUgclvFJ3kjAKa6D7htsNOu9kHdUkyvhW3wE6XUZux
 NcJTdQUhLDTdL3CoZksvLyc91jDr7rNJ926sJVjhP8z435iraoFGkpOE90x7ObYFoxyGaFYZJtg
 gbzZ0mJEJmsp8OjvUY3o9ps0kibLPGqQ4tHxc/iR4hdCGiS/PyLadsyBL9v69++S+Zqk2bJIPnk
 SrSPyWm7wcEBqNMe9nUSCcyIPtyrj7K12efxYf5VS1C7unu1k2E4nXEOuG2d2oguHQet49LARZS
 2dlI3fiNM4zj9pa0y8UY0gKdiR5WAZ2TkND/paqAsGJa0eMshzKM
X-Google-Smtp-Source: AGHT+IEOLAsq3pBrZ0CGkvfyMhHNy1ffqi/2LO2cei8/JBJPPNTDrgbVs0GoGmRqn9LAF1dGdKeQvA==
X-Received: by 2002:a5d:47cf:0:b0:391:412b:e23f with SMTP id
 ffacd0b85a97d-3971d333492mr9054459f8f.15.1742048874930; 
 Sat, 15 Mar 2025 07:27:54 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 22/46] x86: Add functions to convert between mtrr size and
 mask
Date: Sat, 15 Mar 2025 14:25:42 +0000
Message-ID: <20250315142643.2600605-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

Rather than repeating the same code in several places, add some
functions which can do the conversion.

Use the cpu_phys_address_size() function to obtain the physical-address
size, since it is more reliable with kvm, where the host CPU may have a
different value from the emulation CPU.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch with functions to convert between mtrr size and mask

 arch/x86/cpu/mtrr.c         | 33 +++++++++++++++++++++++++--------
 arch/x86/include/asm/mtrr.h | 16 ++++++++++++++++
 cmd/x86/mtrr.c              |  5 ++---
 3 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/arch/x86/cpu/mtrr.c b/arch/x86/cpu/mtrr.c
index 07ea89162de..fca7b28f815 100644
--- a/arch/x86/cpu/mtrr.c
+++ b/arch/x86/cpu/mtrr.c
@@ -16,6 +16,7 @@
  * since the MTRR registers are sometimes in flux.
  */
 
+#include <cpu.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <sort.h>
@@ -39,6 +40,27 @@ static const char *const mtrr_type_name[MTRR_TYPE_COUNT] = {
 	"Back",
 };
 
+u64 mtrr_to_size(u64 mask)
+{
+	u64 size;
+
+	size = ~mask & ((1ULL << cpu_phys_address_size()) - 1);
+	size |= (1 << 12) - 1;
+	size += 1;
+
+	return size;
+}
+
+u64 mtrr_to_mask(u64 size)
+{
+	u64 mask;
+
+	mask = ~(size - 1);
+	mask &= (1ull << cpu_phys_address_size()) - 1;
+
+	return mask;
+}
+
 /* Prepare to adjust MTRRs */
 void mtrr_open(struct mtrr_state *state, bool do_caches)
 {
@@ -68,11 +90,9 @@ void mtrr_close(struct mtrr_state *state, bool do_caches)
 
 static void set_var_mtrr(uint reg, uint type, uint64_t start, uint64_t size)
 {
-	u64 mask;
+	u64 mask = mtrr_to_mask(size);
 
 	wrmsrl(MTRR_PHYS_BASE_MSR(reg), start | type);
-	mask = ~(size - 1);
-	mask &= (1ULL << CONFIG_CPU_ADDR_BITS) - 1;
 	wrmsrl(MTRR_PHYS_MASK_MSR(reg), mask | MTRR_PHYS_MASK_VALID);
 }
 
@@ -204,8 +224,7 @@ int mtrr_add_request(int type, uint64_t start, uint64_t size)
 	req->size = size;
 	debug("%d: type=%d, %08llx  %08llx\n", gd->arch.mtrr_req_count - 1,
 	      req->type, req->start, req->size);
-	mask = ~(req->size - 1);
-	mask &= (1ULL << CONFIG_CPU_ADDR_BITS) - 1;
+	mask = mtrr_to_mask(req->size);
 	mask |= MTRR_PHYS_MASK_VALID;
 	debug("   %016llx %016llx\n", req->start | req->type, mask);
 
@@ -360,9 +379,7 @@ int mtrr_list(int reg_count, int cpu_select)
 
 		base = info.mtrr[i].base;
 		mask = info.mtrr[i].mask;
-		size = ~mask & ((1ULL << CONFIG_CPU_ADDR_BITS) - 1);
-		size |= (1 << 12) - 1;
-		size += 1;
+		size = mtrr_to_size(mask);
 		valid = mask & MTRR_PHYS_MASK_VALID;
 		type = mtrr_type_name[base & MTRR_BASE_TYPE_MASK];
 		printf("%d   %-5s %-12s %016llx %016llx %016llx\n", i,
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 2e995f54061..67e897daa25 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -90,6 +90,22 @@ struct mtrr_info {
 	struct mtrr mtrr[MTRR_MAX_COUNT];
 };
 
+/**
+ * mtrr_to_size() - Convert a mask to a size value
+ *
+ * @mask: Value of the mask register
+ * Return: associated size
+ */
+u64 mtrr_to_size(u64 mask);
+
+/**
+ * mtrr_to_mask() - Convert a size to a mask value
+ *
+ * @size: Value of the size register
+ * Return: associated mask, without MTRR_PHYS_MASK_VALID
+ */
+u64 mtrr_to_mask(u64 size);
+
 /**
  * mtrr_open() - Prepare to adjust MTRRs
  *
diff --git a/cmd/x86/mtrr.c b/cmd/x86/mtrr.c
index b2afb598c73..93be84f74b8 100644
--- a/cmd/x86/mtrr.c
+++ b/cmd/x86/mtrr.c
@@ -14,7 +14,7 @@ static int do_mtrr_set(int cpu_select, uint reg, int argc, char *const argv[])
 {
 	const char *typename = argv[0];
 	uint32_t start, size;
-	uint64_t base, mask;
+	u64 base, mask;
 	int type = -1;
 	bool valid;
 	int ret;
@@ -31,8 +31,7 @@ static int do_mtrr_set(int cpu_select, uint reg, int argc, char *const argv[])
 
 	base = start | type;
 	valid = native_read_msr(MTRR_PHYS_MASK_MSR(reg)) & MTRR_PHYS_MASK_VALID;
-	mask = ~((uint64_t)size - 1);
-	mask &= (1ULL << CONFIG_CPU_ADDR_BITS) - 1;
+	mask = mtrr_to_mask(size);
 	if (valid)
 		mask |= MTRR_PHYS_MASK_VALID;
 
-- 
2.43.0

