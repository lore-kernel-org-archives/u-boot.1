Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1B3C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 174FE81F44;
	Mon, 31 Mar 2025 14:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qp73UQcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6360981EDD; Mon, 31 Mar 2025 14:31:37 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 520D281E47
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so260403f8f.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424294; x=1744029094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4izsw6c41KId99iFvUt/6FPYmmeKcRDakIJ4Dk9JX8=;
 b=Qp73UQcDZaAAjvIuc0za9+a7iukE6nDSEKMV9xACJNnbsSXqwC1H4c5pQj4tMze95x
 JyrWd95IjhcCUpHcNoke5q2gNyIO9RvLLevOBZGDJuh62j3X6VLM8M8901wszO9fpZWZ
 3j4ahgimUQwRy4HK75MG/ESfJmUHADWik7BpL/IKQ8LH9MpErePCulrShUov71c8Vus0
 NFW1vi1k4YzZAYvFA11PPor6tWWgjn5pkA8wUTHr+AkEmg6BhIDw/dB4HvMLqpY3padj
 eG5+ccU2S01YAxbJvAeIhqAWWry9jNzNs0Ndgh8dqKnfHMineUoAnIqTN/vu3xohu9wS
 7ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424294; x=1744029094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4izsw6c41KId99iFvUt/6FPYmmeKcRDakIJ4Dk9JX8=;
 b=jp1myEIImFTyLYgexZ5fBJ+ZHDhg9LZ7+lp01hZ/JqG02CePL+yzYO2znCDUoaI+YH
 JwLOAHGW5mckuEZ6EySb07qTnBW1vzvKUD679ut5aKcehKG0E5fhfyw0pYmNSPqeiLpr
 MHODHixEyUsaKAVXDP/xFy7ozcM7gUoZ1cbl7RsJMYJ2dHkxiDzMOIlv/RZ/ytTJV4yQ
 dejmx7Z3Pr/GHHdVNXXQO7krIm+L+Qn9BSo3Lg0LjcJJNyFNMYpJBYFOgvE27aDwjQZS
 q1Ko8ZTBzI4YkhgeC8GObQ4LA+sADt2NdPS6ah3HfNuubM7dHbs9MAsOWkMt6zNaG0CH
 2rVQ==
X-Gm-Message-State: AOJu0YyQxsFB4Iig5wQJlZ5mVdakfhIFoi0coNTJE+zu1PiaOWpqmFBY
 LEh+A31PV/vzvdXTyzRCn6OfPWTwTcCW92V6Y6NA3bvgxXt21Ikx9KEDnV9ykqKatrFEUsZkkTT
 QEbM7iQ==
X-Gm-Gg: ASbGncv/pn/46rsL1RmerGqGCWfTPLKtzqqep7ezRWZqNe+ASidhHQCbWGdiMmmkarz
 yWS0Ndg3yb9sNuOgF+Ln5oPVBhFXZYhqaNNSIKjfNbO3F5GB25IOSuyrcnNzP7XD29YsM2oxEVn
 8XffLL2RlPN0K4BFPHqjDcJIv+HktTArme2PwQLDyHtPyhj/2Z11n8J/e0+msq4D2wbt19St+nj
 fdq2Eie6fN3m6liqCl2w8RMMnjSPuuacZauIJsDvG7StWIJmomOi8LXmp13NbE1uc998Uw+sWdV
 G4eDeP4X1xoT/rBNusfcFxYTH9LpUkXa6xppvvX/TjpxlcBiSTUA
X-Google-Smtp-Source: AGHT+IFpr6wNk+VbCa7/5C0yTSToPE5fh968ab37erleDLuPmh9/kd/WBulGJcesALvx2sPP/0Y9tg==
X-Received: by 2002:a05:6000:42c6:b0:391:2e97:5788 with SMTP id
 ffacd0b85a97d-39c1211ca8amr5871856f8f.55.1743424294612; 
 Mon, 31 Mar 2025 05:31:34 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:34 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [PATCH v5 02/16] arm: add initjmp()
Date: Mon, 31 Mar 2025 14:30:56 +0200
Message-ID: <20250331123120.2025062-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331123120.2025062-1-jerome.forissier@linaro.org>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
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

Implement initjmp() for Arm. a non-standard extension to setjmp()/
longjmp() allowing to initialize a jump buffer with a function pointer
and a stack pointer. This will be useful to later introduce threads.
With this new function it becomes possible to longjmp() to a particular
function pointer (rather than to a point previously reached during
program execution as is the case with setjmp()), and with a custom stack.
Both things are needed to spin off a new thread. Then the usual
setjmp()/longjmp() pair is enough to save and restore a context, i.e.,
switch thread.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/Kconfig                  |  1 +
 arch/arm/lib/setjmp.S         | 12 ++++++++++++
 arch/arm/lib/setjmp_aarch64.S | 10 ++++++++++
 3 files changed, 23 insertions(+)

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
index 2f041aeef01..81bef578719 100644
--- a/arch/arm/lib/setjmp.S
+++ b/arch/arm/lib/setjmp.S
@@ -34,3 +34,15 @@ ENTRY(longjmp)
 	ret  lr
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	stm  a1, {v1-v8}
+	/* a2: entry point address, a3: stack base, a4: stack size */
+	add  a3, a3, a4
+	str  a3, [a1, #32]  /* where setjmp would save sp */
+	str  a2, [a1, #36]  /* where setjmp would save lr */
+	mov  a1, #0
+	ret  lr
+ENDPROC(initjmp)
+.popsection
diff --git a/arch/arm/lib/setjmp_aarch64.S b/arch/arm/lib/setjmp_aarch64.S
index 1b8d000eb48..01193ccc426 100644
--- a/arch/arm/lib/setjmp_aarch64.S
+++ b/arch/arm/lib/setjmp_aarch64.S
@@ -39,3 +39,13 @@ ENTRY(longjmp)
 	ret
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	/* x1: entry point address, x2: stack base, x3: stack size */
+	add x2, x2, x3
+	stp x1, x2, [x0,#88]
+	mov  x0, #0
+	ret
+ENDPROC(initjmp)
+.popsection
-- 
2.43.0

