Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5FAC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D28BC81D25;
	Sat, 15 Mar 2025 15:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YcFsgy2N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2796A81A02; Sat, 15 Mar 2025 15:28:03 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F1A81D25
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so3191135e9.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048880; x=1742653680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyCyNfvr7ekEAM/HrefntssbTGBF9fursFujLpQtXfM=;
 b=YcFsgy2NRb6YDCAtBOwMtHO0BjvrgmjxdCXkdhNry8/HVIzE3Dgc4LZLPeeok/8VH1
 SrCFo0doqNN1xK4KUM3n0V9d1ijyL+AhngP3QQHq/qNpVnRcS/SFtjgStLJ3aMskkGDP
 j4eyR0RUPtrQ4ogYRKhC29NErqe+nHOgcnh6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048880; x=1742653680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyCyNfvr7ekEAM/HrefntssbTGBF9fursFujLpQtXfM=;
 b=uxKVdPVxy0UztIfaiKhybp4fjQsZIZLPFM8KW5QmGoknv0Kwdoct3/RfGOOH8rN0uT
 88BwEqt7fVR4UAykmtZMzXIn3GYTD9YxTeq+L2BZ2LEEijqOcrkErkLdY33dPZ9QXVLc
 yc/SYOYa60BXKCVxxwbd6RneVicbkb1ZGYOTbL4XIDUf7PPGUcp81BUNaVXow5+DdDtn
 DIeS4IDe3x4JdQz7wYS6mwufhAU7URJPpOdztz2odhvEFZf/g8KrfBZPlCpC5+7JQHnI
 9jYwKbGC1NmiicHoQ5aUrl8F1SYtNig8Otn48HU4aUVPPPIrRcu3xJoDgHCFANP69i/c
 cDAg==
X-Gm-Message-State: AOJu0Yx9QH8hAtUC4g5Z2nEgZ9AfEtMwXZLASFFR5KwU6qdi3JSFEdN1
 Vvs2tMHSXYTIc/7XNuZzIo4gIFhrDb3KsTv2VkVHyvdxDHWNTJ8DafF32aKeCaomRbvMjIDr6p/
 5RQ==
X-Gm-Gg: ASbGnculEkYlLGl4ccsb5naNMnyIGdRYL18NzWs3BI/ajLnZn0GT8KgmIwtDqH54Cbo
 GGgfIMlnT0ntLPRdOdZ0HZy/jXPElbTbzH94Pzq8uog2BO/6vV31PSEc+ZR/3Nl+diRhIsqiDEk
 DGZAbhBxrBfZrzq7g3mMEEallXhatD8kWn09zssDeOwFvi2T2pZ9givU47RR+iGcu0ROrcfXACv
 CPQSrnrjWQC7YeqiqnLzkeL9fBrSMj891n+lg9fkdX44xj8QpzDyXuz845RlD0fUxx9qUdPiXlT
 oO3ExCYj5UBAAUj+7+yBAV1GtjQYnbg0Zl0fN37nRw==
X-Google-Smtp-Source: AGHT+IFNAHZyEeGDlbgz9ZX9Penv0NMB8k0hClPf7zaiCCf3vaJAV6pXBKOKouTI7ngyaqudSai3HQ==
X-Received: by 2002:a05:600c:4693:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-43d1ece17d8mr85263645e9.30.1742048879661; 
 Sat, 15 Mar 2025 07:27:59 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Philip Oberfichtner <pro@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 24/46] x86: Update cpuid_eax et al to work on amd64
Date: Sat, 15 Mar 2025 14:25:44 +0000
Message-ID: <20250315142643.2600605-25-sjg@chromium.org>
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

