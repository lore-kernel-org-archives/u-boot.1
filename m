Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C1CC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5910680E94;
	Thu,  6 Mar 2025 17:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lc+zj+K1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BA0581A10; Thu,  6 Mar 2025 17:05:39 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2213781A04
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d03ac846a7so2662405ab.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277134; x=1741881934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNuzJfPDaZaB7ecS5GRPPbVXmgD5XgLjxuFZewrYlIg=;
 b=lc+zj+K1WZH58RFQcUY9CSr4DO89OCYwPbedr6NY+Qmefb1PeHxOd+DT8T/AMZHtc6
 mlw44cy7mUYklfv71wCx0F80d/Izc0KKsMNwzKlBaCKxOcBT3p1IKbJ7TDq2iTRcHtcG
 flCtFD7EwFandZzMScUOc3E1uCwqnOqIyOffM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277134; x=1741881934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bNuzJfPDaZaB7ecS5GRPPbVXmgD5XgLjxuFZewrYlIg=;
 b=DZu8mQbfPgEoH4Q+qCu3r5F7kiUXB4SklKSBZlEipZVUjLONAZpp5Q8tPsoD6rFgsP
 H6ipb758JiUsCnpOK94VKQ+RyBCZNwMzFf+UtDRSa5h08cb7LajdRwofb2AG7FDR+UX2
 wdG22yVxcu4+8of7e2u/4jaKMbZtnL0bPuqRz5p/xsY4YYjFFkbUdXva28GhB6swgXq3
 1Qw+pdSUMVpYDlmzfu2Uwiu7PSlTWP1QRq4KJKXcw9Ovd9JcXcfTwSWGdiQ0oZkcA4L7
 fgrhr8fNCsqIxnWCZHC0MN/3Pvd8khpsnxkz9My/pRaqpROnQF62wHhTo55hw6cbUOIJ
 8cTg==
X-Gm-Message-State: AOJu0Yyr5ijLohWa+F6o+Lbfxf3SG9X0Vscp2mJMi+Va/6yKAImpIBmU
 3CssChJe2GQbs2XkLry5Qg9uEPhg0Gc8QpITE+JBigL6UDXW+eLMuUv+knFpXhZel6aLF5GomoM
 =
X-Gm-Gg: ASbGncvim2nilk/ceKFXAVKBguKTa/nbgz0gATXzYNFIhCKj7z/oC9c8s2DPBnorljW
 qN/zdQRSskvZTJYQQJUDmKejJDHTpYRbWPHHLmu/VWRk4UlelxV7It8dda2H+ZmGjUBi/MQiF+V
 iYHI8mDVX3CeQuxbur9uTDxo/oeUCGQx49LG/DjAThparc1c8PVpRtWVbjxxPNx3tKks/bvVRTp
 RhgT7j9wvV/8Mgq/g4vDqilGQIYZEJL26TIm1qwGdP3RIskoj04vmbL7lYAZznmLbp2f5HAY1b5
 aPLM2D+1ZjvLWC6D40u7NLaR3oXGI3RLtFwoABbjAeXojPmzVSt0/L/xnLIm8HoIesIRTBy3txf
 xZR1kTA==
X-Google-Smtp-Source: AGHT+IESnFTH6fSkR5NmbGziW3om2zMkdAcic/bSpjc0mkAVYwq2+uhQVRdcPDXPwE+bHXhtPbc3rQ==
X-Received: by 2002:a92:c543:0:b0:3d4:28c0:1692 with SMTP id
 e9e14a558f8ab-3d4418d5121mr540975ab.5.1741277134015; 
 Thu, 06 Mar 2025 08:05:34 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 22/47] x86: Add functions to convert between mtrr size and
 mask
Date: Thu,  6 Mar 2025 09:03:49 -0700
Message-ID: <20250306160428.3041057-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

