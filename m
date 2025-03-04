Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155E9C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3089F81433;
	Tue,  4 Mar 2025 16:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vaaot1e/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5828142E; Tue,  4 Mar 2025 16:32:21 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB0E281253
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso1895443f8f.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102287; x=1741707087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DpPsgcrT0/Z4oAyeFytZ0N3HH8jEv4dIyLAVNWv2CKY=;
 b=Vaaot1e/Gpt1LgucX6ZkXJt+HqkwrqIhkyaqw9VxtdcvUh5YgFUycco32T6ESMcgcO
 H/ulJvWC87KVSh0AH0k05R/32GnQZUqgEgNBGvAhmDcSwHtCzgk4u/kbXkwy0po1POp/
 aXaHIULKPEY2qd3uXf78yOVrvSWW+EY1NHK13UXZde6kVqBcInxKK4byi2zVlzofAHLZ
 P1s37GRh4AbVURWCakS+Xui8zovliLBU7kTlp2QTNKYkMbEu8wY+FT1FS4G96wxxzKPE
 HBlkJQUZRywBryvIlj2ZUl30vrAg7X8zLskwfVad5gz2VII+QeYB7AK2Y1FO55iWII2U
 tPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102287; x=1741707087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DpPsgcrT0/Z4oAyeFytZ0N3HH8jEv4dIyLAVNWv2CKY=;
 b=H7q9RdqWpUbz7JrhbqnpWRrFGjG+zTcLnQqcBughr2NrLKNMfBTm3jl+WZfSVxTj9C
 mLaZ/uX+HKiHkvE7kJi8V/Is880XnjG99qp2vf1Qa0l+DU1o7MVw8AMp5+1nRQlFzuVA
 l2YSreuwRHxA/UfGnKnI4H7BoOJzwc8/XjhfaCZFjdimjn50ZViLBqzBx9NQJMe10aiN
 7knOlK+kpasyDUj7UR7Mv1ewZGNfxD1vJK0CArndEhEzgWgzL69hzUDVmPMkpNz6BFDH
 x0kMaMmpx3gh+lrrG7GLk2rsKdJ720S9JFFWdfBoqzDPIkRWp/91aDKZwvMxoAg1lBbx
 or8A==
X-Gm-Message-State: AOJu0Yy9o9q0RwvJG2/flRsRbVFRFoO83utJKTA5g16nv/SzLIBb/PtM
 eueyQLKqzOzf/z3vR5JGH9Mcv5gyvkchunJbUmu8ce1Ck/dEHzyUoyBNGae+2swJ3pUydA5pyL/
 w
X-Gm-Gg: ASbGncvGag2cGDdEJYOFeoehB6d3MPz5zJyUkR2x9K1NXo/Y78huOQKUNj8xgK+q0sq
 jLxHw1bicu2zyBlGdXZl4uQK4qqkMK0bXtJUV4I2hT1L+6WtbmEgvG99nqd5I2EMg0KjkdadpNx
 CVInkBSeSpmOdjyb0YOIfQwHRKemCRvL2nKz5+H8Q3yPTx6B6DnEZALklfrpiPjeYvyuNyaZ+ev
 VNgvxpV/t0ZA7Hx0cj/HylNi5SaTjfOAjOg/z6dpgzVQAdpq20hrZ8SmvBnd58moVCelslb7Dmw
 TqFOY+7WplhoWR/jHVvV0yOSEvRKKuqfIKDR1ms7eoKmYEaBv9NzAw==
X-Google-Smtp-Source: AGHT+IHrwOsxyhjgVWp1G+RR3RM7rc/ZDYkpFjiATIOcJ8G9t/lP3nGKlY+KENMRpd3j8yX9BI0M8Q==
X-Received: by 2002:a5d:6da5:0:b0:390:f0f3:1396 with SMTP id
 ffacd0b85a97d-390f0f3186amr14253434f8f.15.1741102286821; 
 Tue, 04 Mar 2025 07:31:26 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:26 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 02/14] arm: add initjmp()
Date: Tue,  4 Mar 2025 16:24:50 +0100
Message-ID: <20250304152510.2832340-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304152510.2832340-1-jerome.forissier@linaro.org>
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
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

Implement initjmp() for Arm.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/Kconfig                  |  1 +
 arch/arm/lib/setjmp.S         | 11 +++++++++++
 arch/arm/lib/setjmp_aarch64.S |  9 +++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 14111ca14fb..7a3141e92b3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -95,6 +95,7 @@ config ARC
 config ARM
 	bool "ARM architecture"
 	select HAVE_SETJMP
+	select HAVE_INITJMP
 	select ARCH_SUPPORTS_LTO
 	select CREATE_ARCH_SYMLINK
 	select HAVE_PRIVATE_LIBGCC if !ARM64
diff --git a/arch/arm/lib/setjmp.S b/arch/arm/lib/setjmp.S
index 2f041aeef01..320ddea85f9 100644
--- a/arch/arm/lib/setjmp.S
+++ b/arch/arm/lib/setjmp.S
@@ -34,3 +34,14 @@ ENTRY(longjmp)
 	ret  lr
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	stm  a1, {v1-v8}
+	/* a2: entry point address, a3: stack top */
+	str  a3, [a1, #32]  /* where setjmp would save sp */
+	str  a2, [a1, #36]  /* where setjmp would save lr */
+	mov  a1, #0
+	ret  lr
+ENDPROC(initjmp)
+.popsection
diff --git a/arch/arm/lib/setjmp_aarch64.S b/arch/arm/lib/setjmp_aarch64.S
index 1b8d000eb48..074320d25fb 100644
--- a/arch/arm/lib/setjmp_aarch64.S
+++ b/arch/arm/lib/setjmp_aarch64.S
@@ -39,3 +39,12 @@ ENTRY(longjmp)
 	ret
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	/* x1: entry point address, x2: stack top */
+	stp x1, x2, [x0,#88]
+	mov  x0, #0
+	ret
+ENDPROC(initjmp)
+.popsection
-- 
2.43.0

