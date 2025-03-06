Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44077C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133E781CDE;
	Thu,  6 Mar 2025 17:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OktQeJ96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DAF981CA4; Thu,  6 Mar 2025 17:05:43 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15C64819FF
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85add67e9c1so31783939f.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277139; x=1741881939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyCyNfvr7ekEAM/HrefntssbTGBF9fursFujLpQtXfM=;
 b=OktQeJ96XHZSoktwg9NJz6qEAGiT/uKg7407deTqF5GGCsyNe9QkOGdOnoVj+hOu9l
 2ChWZOrVbkGr7Spqi59k5aNM1jboddzUcx9G7iugBzJ1h2q0SBAXnLcvajIcZwla2m8y
 RCd5PvQY+5dmtADGfi62Vh4igwZ84C+72Ol8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277139; x=1741881939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyCyNfvr7ekEAM/HrefntssbTGBF9fursFujLpQtXfM=;
 b=QhPiVDMm5nNUn/ddhwWM46UIfZy4lMHjVfmXRmHgE6mnsVmQ/6QVkBzTxmH0hxDC/X
 XId2JTw1CIunhz2MdUSk3S4SaeUssJdOjxTLU1o9DuxEdjKFmrUIksVzRVVI5fS4+1YE
 oNfHA8fnpimEWgigJ9PRLovwHq2iBABiLlvsKyNA5JmQ9z+xNcBBzybVbux4xDHqepdn
 taGEl1VFJKMjAKzUdUculYbtUBdCY+yp5N8ROlUIAdNrYxFAx7Wr8Eionc7whpjlVG9X
 1z7zi4dQAigHUiMgAeQliIJWaJWZtxFAdE0NJzrwcXZ3q3+JiryXxTzv2TuqGU6/mhDC
 vVZA==
X-Gm-Message-State: AOJu0Yxp49+iHkF9B8uz0GOMH8P5gPQxVMFuEqzAtHezxns3264ggKMb
 wi7foE4J4BR+ur4/4srTRm7/XeZkp4SdSzBC0WpkQQM4h4DUVs8lO0HiFS2agS01HW+tNHxqpNQ
 =
X-Gm-Gg: ASbGnctgIOLFSxA42gL0Nl6/daVc30SeBtoZrnPAQ0+uVaBg3qtVzz4HR4oYuHVoRfd
 T6AkxknMGeVa6EglcJyKuxSRnirGbR8Wa+AqFWy0Hi9mgfHkVRAqn4w9HD+8jRr+XyAHpZiaYu9
 ENsI71oweW+ucsyWUz3kXiW8FeVnzwPkq6gJEgJ/hJBXCM2Tk7gmg3mNc7OvbX2vrTu3hj5LTEy
 L+9XexyXviNeQv6x0AOMLQQFLxBcd15zSRIPzXUw+pQwZlNWHPCxWqOD5GH7BPwcsQEE82MMs4x
 iwxRBnW0L5BVgAGGybMC23jIAynuQkfjFXfqk/a9T1gdnnI4r2pAe8Rp2r3feEW9lZNJnUlRCN+
 5lAIKeA==
X-Google-Smtp-Source: AGHT+IE35cwds38XLBsq4qVDFHy5CF96q/OEu8Gbv1e1955+1q1HXExnHNLikKYyJo7Ye/CU0KKxGA==
X-Received: by 2002:a05:6602:6a98:b0:855:5eba:404f with SMTP id
 ca18e2360f4ac-85b0eadad71mr421876339f.7.1741277138360; 
 Thu, 06 Mar 2025 08:05:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Philip Oberfichtner <pro@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 24/47] x86: Update cpuid_eax et al to work on amd64
Date: Thu,  6 Mar 2025 09:03:51 -0700
Message-ID: <20250306160428.3041057-25-sjg@chromium.org>
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

The existing functions work but the register clobbers are wrong, so
strange bugs results.

The original functions were taken from a very old version of Linux.
Update them from Linux 6.13

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to update cpuid_eax et al to work on amd64

 arch/x86/include/asm/cpu.h | 75 +++++++++++++-------------------------
 1 file changed, 25 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 1f1b545ea50..5d24c17f8a3 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -109,61 +109,36 @@ static inline struct cpuid_result cpuid_ext(int op, unsigned ecx)
 	return result;
 }
 
-/*
- * CPUID functions returning a single datum
- */
-static inline unsigned int cpuid_eax(unsigned int op)
+static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
+				unsigned int *ecx, unsigned int *edx)
 {
-	unsigned int eax;
-
-	__asm__("mov %%ebx, %%edi;"
-		"cpuid;"
-		"mov %%edi, %%ebx;"
-		: "=a" (eax)
-		: "0" (op)
-		: "ecx", "edx", "edi");
-	return eax;
+	/* ecx is often an input as well as an output. */
+	asm volatile("cpuid"
+	    : "=a" (*eax),
+	      "=b" (*ebx),
+	      "=c" (*ecx),
+	      "=d" (*edx)
+	    : "0" (*eax), "2" (*ecx)
+	    : "memory");
 }
 
-static inline unsigned int cpuid_ebx(unsigned int op)
-{
-	unsigned int eax, ebx;
-
-	__asm__("mov %%ebx, %%edi;"
-		"cpuid;"
-		"mov %%ebx, %%esi;"
-		"mov %%edi, %%ebx;"
-		: "=a" (eax), "=S" (ebx)
-		: "0" (op)
-		: "ecx", "edx", "edi");
-	return ebx;
+#define native_cpuid_reg(reg)					\
+static inline unsigned int cpuid_##reg(unsigned int op)	\
+{								\
+	unsigned int eax = op, ebx, ecx = 0, edx;		\
+								\
+	native_cpuid(&eax, &ebx, &ecx, &edx);			\
+								\
+	return reg;						\
 }
 
-static inline unsigned int cpuid_ecx(unsigned int op)
-{
-	unsigned int eax, ecx;
-
-	__asm__("mov %%ebx, %%edi;"
-		"cpuid;"
-		"mov %%edi, %%ebx;"
-		: "=a" (eax), "=c" (ecx)
-		: "0" (op)
-		: "edx", "edi");
-	return ecx;
-}
-
-static inline unsigned int cpuid_edx(unsigned int op)
-{
-	unsigned int eax, edx;
-
-	__asm__("mov %%ebx, %%edi;"
-		"cpuid;"
-		"mov %%edi, %%ebx;"
-		: "=a" (eax), "=d" (edx)
-		: "0" (op)
-		: "ecx", "edi");
-	return edx;
-}
+/*
+ * Native CPUID functions returning a single datum.
+ */
+native_cpuid_reg(eax)
+native_cpuid_reg(ebx)
+native_cpuid_reg(ecx)
+native_cpuid_reg(edx)
 
 #if CONFIG_IS_ENABLED(X86_64)
 static inline int flag_is_changeable_p(u32 flag)
-- 
2.43.0

