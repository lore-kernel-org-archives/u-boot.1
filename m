Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A61C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6351480F12;
	Tue, 25 Feb 2025 00:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bmhIctyr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF99F81191; Tue, 25 Feb 2025 00:07:46 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 764C581111
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-855a095094fso131569939f.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438463; x=1741043263; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfscgqLHR/xm9RlouW9/pjWWn4xci3XXQ3+jaK5WMCQ=;
 b=bmhIctyresDwAK3vBWNPFxiXLNWkM6W4N1mDRHhxIRE57grwDYmu5lcTXDry9p0VzR
 tysEZwVcqZKxCz8w3WiiDpb6JmwGz3D1/5EVKN+8ihxMKhOPoqrIXeJ+pydxlgjcID/u
 3y+W+Z9tbdrbEqBr7p6YLrBNYDIf0LYHdqZxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438463; x=1741043263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LfscgqLHR/xm9RlouW9/pjWWn4xci3XXQ3+jaK5WMCQ=;
 b=R9mQRTDPJGrfwzuqFaYRlf0db4qbhqTCuylzxsn+lt6CAE50ce7MqHGFuvI9rlAKMP
 rct+KqwLUEXjiEQ5s6OQmfv18A/psXO/7DzH49aFSdYa3PW3vgNdc7QbhgO+ne2p3z2+
 ypxuwTtjzsK8q4QFpih/Sfx8YWe50vu5BJ9CXAboPLQ/gZdqB01kuEtuMez2okzxYrvi
 SbrzsDXZ4PT4VeXbKlRVPk9K4ylGS9EUygeaiI/ANDUQsIqYPG4OFTxmReBtIzJiS0hP
 c1RC+bz/2aYSE7B2m7m7+Joi1msih9sF4kpcQDNoeE/U5W2Ufg8YGd4DowHFgoTqzQQ0
 H+ng==
X-Gm-Message-State: AOJu0Yx4V63nMBbUXagzizu9wALlBkBcy+GR5eRRaCsdFzh/TbyKj9KY
 T1hNnKrpybiMbYurIlwgxodaHr99srm61qsbIpE71DuNDYyXvHArl0B6d4/KmV1ORpEImSvd0lg
 =
X-Gm-Gg: ASbGnctEWxbjsAALQyYdnCOdxO6Thv5L/YE1ELExd17R4gegjSdH/p5zjPUqqWbUSJV
 txDk7LodE7J+xN8ZkeaaXyOdxzB7VYogwp4owPENtXbdn+bqb70wGMeDTkLNjozvB8pAIfF5z/B
 J0HQpeqJy+dMEAMpkvNnBEGQjXyPWojw4DCuo5T/iITIwubgBVr8b20tA8KuB+Qjq4LmBC4RbB5
 WFnYS3bbRRUyoG4z5iUWESz8SUcglwhQvSVahc6jQwbGYt4fp0DDdd1ZF7PEHC8NlC6QWvJwDrp
 IuteUoQsijwray3LCy0+cIsWfNdd7HaM+hUTjZgrsZPNV0MGNgy0tjRkENU09y0=
X-Google-Smtp-Source: AGHT+IG/VsPiRtaxrytCXJVyyZ+ZtOdBon2egeaJGC5R4xi7nQdPgV6WPkQJxwhnc96oVhHx8l+0QA==
X-Received: by 2002:a05:6602:1649:b0:855:ac69:32b6 with SMTP id
 ca18e2360f4ac-855da99c962mr1772012939f.3.1740438462709; 
 Mon, 24 Feb 2025 15:07:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Philip Oberfichtner <pro@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 22/44] x86: Update cpuid_eax et al to work on amd64
Date: Mon, 24 Feb 2025 16:06:11 -0700
Message-ID: <20250224230640.2665206-23-sjg@chromium.org>
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

The existing functions work but the register clobbers are wrong, so
strange bugs results.

The original functions were taken from a very old version of Linux.
Update them from Linux 6.13

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

