Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855CCC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6796F829F5;
	Tue, 29 Jul 2025 17:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JS86u7At";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 410AF82BA7; Tue, 29 Jul 2025 17:52:27 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD5981E14
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4561607166aso39901285e9.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804344; x=1754409144; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OAU8u7dJ3enNuLl7+lbjMPH36mBB6d7JKMJPH8OPjp8=;
 b=JS86u7AtMFYxQOg55u8n6DkJsTJiBlH1qbxaA/vBiMpV49UuPWwubtekoYbFBsVvN5
 risfTznNnvjbyIHS60B3e4de/xfCa/Bb6u7L2QHC8pVk6IlJhrYkcavAwc25kaz/JOjJ
 IQThDsnwaeD4LPRkj+/FrnYzQrTbTaJfPcwoF16gaf8xHSYYUosjeQj9wNliJhfU+xt6
 4HAeOp6BYCWIt1OtHkMfmYCMk3CpNT50+a1QG8R0SPHZgM9p6ZWnZsd5kgDOJY0eFPvw
 0Js5aYJSjYbFQzIhVygWtdwy/7Kone9ern/Xf5ZE64WC2z6FR2dkDa1k/obypsxJiRAT
 jX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804344; x=1754409144;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OAU8u7dJ3enNuLl7+lbjMPH36mBB6d7JKMJPH8OPjp8=;
 b=Gj7GKsWUoqj65H8pZFJx2MBlixy5ff3EOPKcPpXF+eKa0K0Hi789Y21QxUqm8iZTnj
 Khb2ESSO8EKL18jOjWh81tNxx7PqD9O+6AWTLKKlsVRphOxf/amuvJq8d7HCm2tyRGTl
 PKxOU+qCHzqzdjV38wsX758B+GH3T7LKaqdRkhqcizlXzAXWTIyU/qRHZpf1hQD6d2La
 6eP0auxRrj850a5oKvQMOCS/Au9kr26SmtaWDVX0Ftwpl87XnvcWa4ZPEuYlxVRs6lFS
 PoCJxAdEP/ZOS66UUsxonhAdNp7w7ZnMZw9mS71Y9OQxg/mJbdwn16CSP44Ney7y/1OS
 1ubA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhrbTbad7gyb+xsZVd2d/oa/kayJXC7baSvPUtz4S3cb1BVOhH1bSYo09Nuhn2xvn3Hs4TJok=@lists.denx.de
X-Gm-Message-State: AOJu0YxV2PN6aUUpriQO8278WH9UchA6pRkViyHaA9Q74h2F9ChZUelO
 5bNqOsB5Krli9nfPiA6zWFrsDr37U/RyHxc++53FLn+o2vgIFBPcuZiYdE22nLp/53R6OOCEXUW
 hCuZx
X-Gm-Gg: ASbGnctKv69Ij6MAGQ9+GoIeAdwRSqQaNJFtmkJTXmv/pqbhobEpj51v9pX8uCtD0Sx
 PudrwtPCIBTt9q3tEcAXciSnbKd9qsNrw7frbapLCzXQ+lcI5PFFOiCPvOWpba+NxM6alhVPidP
 gQUI3z4gLd6MVCZFc1k+AC6CfcMDGqXi65a2ZIZkZUNlPZshT4VkgeVmXLWvVaPJ+QotExrb1WY
 7Tuw1suv42bHyi/c5gyZ/hQKiVzr+Q7U3wpOeVifgKKr90RRqhUGUrt6wTZLd2neVLagyDFxJxH
 6N5i0aATOkz25GXJPZhVLHi1jwAQ1xsXzlG8BzHJ/5p2cLPYpqdL4Q96NOXjehvErA6Uuh+62dk
 NYkkDxvfGaAUEqLq6IMGLztRTCkvSszVqaKcJy3UkV+8Bs2NquNgQN4dUNRej33Dk/8rXa5QjjA
 1Mcm6gttYw/w==
X-Google-Smtp-Source: AGHT+IF8F38JyVj2RQHpDSWCiRNLViVz0+aCGC0YNtjb3LPugtg7UYkgqr5vsq/V93k+Vl/pxOp55Q==
X-Received: by 2002:a05:600c:1c1f:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-45892ba267cmr2401725e9.13.1753804344295; 
 Tue, 29 Jul 2025 08:52:24 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588dda59cfsm18948535e9.3.2025.07.29.08.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:52:23 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:52:01 +0200
Subject: [PATCH v4 03/10] Kconfig: make CONFIG_FRAMEPOINTER available on arm64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v4-3-8d8bda8e22c1@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2793;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Mw4RH2YSTpmzvYgrGKinq7mtwPHmaYZ0Rd4QoQyJZCs=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO4jVBERcW9p4p+UlYO664Mi3yRGcQOXY/dPk
 lEIJt4dxqqJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjuIwAKCRAFgzErGV9k
 tpncD/0WsVSJZkMtWZdfZu7Rn9gr3akrpPQWSt/SVuZWXYXolATDe5n1TpbnU0C8mNOhcg99QMt
 ZkBSoelrs1GZUsA+lr8JPb39fbxOwdog0/NeD8ba8cfSa6dGKeGFUtirS1+mwvFx1dP/tu7avPg
 qFBjfHtd09mRYqkaMeVVlPCzHQMqZHv8E/5nqjhg4rAXDJlXc8bUXuSCfwlpX3gTZA2JsIv9b2Y
 PaNYdYACJEu+rWRih2ACwt1tWgEGafJughbrMDBTLsxPk9YfzfHqUEGxaO+pa1oS/K5q11puhgO
 21qrmSmTprOpFa7IxFfN+9pQ/RE8YY2Uex/XvTc+Vm6XpAUnpim/M3POc64/cCFNsQqQTG++oEe
 UVRJD6vlWacg6Ijc2A/Ug6BHvJn/T5dEkSVRheICpNh2abdKs7klkXM1beSUI95sKyZyq+XVIZR
 RccaSBE2G3Djr6WEKXY3p5vY08u2mxcI4B0LRDu0hZfgmBCg502DIuo5HUosWy7EUKwV5R/9qYx
 GBggqqstJ9qLndwyzMjlJgk+UJEeEO676uRPQZ3zBuof1/wNn+qzlxnX2QNCxdjyBRWGullOxPA
 eK3pjLe2V1p3tqx5sUifKf28GJd4fdgfRJl2Gfrrd3cO+Oo3JyR6tsuCOMhpRHe+U54TzTbhaOH
 axayjFEPKMrrN5A==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

Move the frame pointer configuration to the generic setup section as it is
applicable for multiple architectures (RISC-V, arm64).

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 Kconfig            | 25 +++++++++++++++++++++++++
 arch/riscv/Kconfig | 21 ---------------------
 2 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/Kconfig b/Kconfig
index c883f11545952588aff574fdceb88b43407352d9..d8e117d0b1a511f12f7a54be1c84f4c45634828a 100644
--- a/Kconfig
+++ b/Kconfig
@@ -178,8 +178,33 @@ config CC_COVERAGE
 	help
 	  Enabling this option will pass "--coverage" to gcc to compile
 	  and link code instrumented for coverage analysis.
 
+if ARM64 || RISCV
+
+config FRAMEPOINTER
+	bool "Build with frame pointer for stack unwinding"
+	help
+	  Choose this option to use the frame pointer so the stack can be
+	  unwound if needed. This is useful for tracing where faults came
+	  from as the source may be several functions back
+
+	  If you say Y here, then the code size will be increased due to
+	  having to store the fp.
+
+config SPL_FRAMEPOINTER
+	bool "Build SPL with frame pointer for stack unwinding"
+	depends on SPL
+	help
+	  Choose this option to use the frame pointer so the stack can be
+	  unwound if needed. This is useful for tracing where faults came
+	  from as the source may be several functions back
+
+	  If you say Y here, then the code size will be increased due to
+	  having to store the fp.
+
+endif
+
 config ASAN
 	bool "Enable AddressSanitizer"
 	depends on SANDBOX
 	help
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8c6feae5735592ad12880f1d460568768b848a44..f60ad5e9acec76aca773fb77a4016cecf41fc679 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -149,29 +149,8 @@ config ARCH_RV64I
 	  Choose this option to target the RV64I base integer instruction set.
 
 endchoice
 
-config FRAMEPOINTER
-	bool "Build with frame pointer for stack unwinding"
-	help
-	  Choose this option to use the frame pointer so the stack can be
-	  unwound if needed. This is useful for tracing where faults came
-	  from as the source may be several functions back
-
-	  If you say Y here, then the code size will be increased due to
-	  having to store the fp.
-
-config SPL_FRAMEPOINTER
-	bool "Build SPL with frame pointer for stack unwinding"
-	depends on SPL
-	help
-	  Choose this option to use the frame pointer so the stack can be
-	  unwound if needed. This is useful for tracing where faults came
-	  from as the source may be several functions back
-
-	  If you say Y here, then the code size will be increased due to
-	  having to store the fp.
-
 choice
 	prompt "Code Model"
 	default CMODEL_MEDLOW
 

-- 
2.50.0

