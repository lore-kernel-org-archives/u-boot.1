Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5A7C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B237C81100;
	Tue, 25 Feb 2025 00:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GZnFOLSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF5EF810F1; Tue, 25 Feb 2025 00:07:42 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 659B1810FC
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d2f7257181so2882665ab.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438458; x=1741043258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iohuVO4My52CdTvgGOb0r4a5TEf38GEbG5RaMd3hC1E=;
 b=GZnFOLSPa2ZqcmJdsnfa8GBaz+anm4DN1Zw1d7l9mprRunpRRDmB6owBXd6P9QEyFc
 aw8G3BXP5K3nW61WxBzLk3mBeo6hc4wD/YSS9ZjZtt9IVjEOUB5DOG7uBeiL4A/D0e1s
 r+K5uow8iQco4KaOPz4QWJlBZWoHm5rhwzl2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438458; x=1741043258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iohuVO4My52CdTvgGOb0r4a5TEf38GEbG5RaMd3hC1E=;
 b=WpW0qk454DvTfe5Eo15wqSTe/4QZsOZNKuTLsHp7UqOPkE/Cupbm25FpFnfoZGKQZk
 OiKUItPb7o3AH16axZEBBdCsCDHAxTJGAXc76FIEc2GB64o5xvnuJPJr8Y8Y/63Ijduq
 h7wQqQK5KIwhxooVQ1pVCuoLRows/yo+Kx0UiWm9TpmZyqXgJqkaPAXns3QR2MJ9VnVr
 kJ3Xg5hCVy7rmTyDoTVy7oSI43FI9zFcejp9IHBF0T+fTdLxCQsMMclwYYziRQ115pV+
 Ht2MwXpHNpjCKyMdxZevsBc375dUn8U5PedtAmpQV0bgLEOobZdNrP7WX+7ea7PEuZS4
 y5xQ==
X-Gm-Message-State: AOJu0YxpbX5myN76G8KuY+6qzEPVQsJ26/HzGZcKzOpV/R9PuVbU5dMK
 7qrbRzMQAELGpQ2fVWy1IImRD54Ekjn7pM0acmlhQj4o/icclqmP2bcbJCLNFl7H+yT/9iW3hT4
 =
X-Gm-Gg: ASbGnctam7TbW2dM/QNjmabK/tIge5MTA0S5ihk6AGUKMg9nxE/QuiTzNyQih66OGda
 LIPkQzLkk0XGja31HmW8E8wfENSCw93kAcWLRqd+xD5HClBQ4d+zu7i9i7TW1K87FvvVICGbOyY
 CDGrZAf/fNlDcJaB2JMTcSL+5qdn6uF+haGDLJUvRDGEVtr0wUkvrcc0MOvpMdulo5wobRxOY6m
 /IWCy1wbT+Jw0N/j7P9dsnSGthrF8THpJ4rac1K1kZ4vmvgvX2diHkgTq9TfNchg+hjphsUU5gU
 wngU9OWloMGI8zJBEfqDZGx1vXSjeSr3YqsJjgdg8/Us26KPLTE03GH4rFH1Mro=
X-Google-Smtp-Source: AGHT+IGuQlLpnP4XgryjJsVorxusIMOsg44el/Dix7Tu4lgBn+AIDQ7fDlNApcKriBPYlDjyf2/aqQ==
X-Received: by 2002:a05:6e02:13ac:b0:3cf:c773:6992 with SMTP id
 e9e14a558f8ab-3d2cae87c65mr169265225ab.12.1740438458606; 
 Mon, 24 Feb 2025 15:07:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 20/44] x86: Add functions to convert between mtrr size and
 mask
Date: Mon, 24 Feb 2025 16:06:09 -0700
Message-ID: <20250224230640.2665206-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

