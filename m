Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048EAC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B5A683966;
	Fri, 25 Jul 2025 14:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OThsUy/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 535168397B; Fri, 25 Jul 2025 14:57:33 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DD0E8397B
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4560d176f97so24437515e9.0
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 05:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753448250; x=1754053050; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bUr1ntJTKtSZwRhZMuguAr9hfTqEdgw1JBwmB0WPSqc=;
 b=OThsUy/nlMMPJ66r3YsAdV97bo9xhz1VP2OX/HD7oAZtm821Z/Fmk8pYSMpwbLw+Pj
 zV6IKhL/4XF5yHoOvdtVhVOslRCm8Y54gFuylls34is9aV9sTqxo44VsV/H8VPK8ld3L
 cbZmXJwRhVrTBs4EoDs7WMdX+O6NHz4pM+ELxNOIegwzdPvvjUkRNJXyvKm2Ea/8CwRb
 wjJDB+zJgxjfQwuv9ckiGKO6Qu5K8p7TgeTAI5NF/MRWkaGWQ9mA3b8VG+CTavq8bQ/N
 BJceAsdjQFjROJkHUh4gfEVNlXXhlyYhPqFZ9uDi3qBfVNtCcRRft3CXXmnJSskVe42U
 3VLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448250; x=1754053050;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUr1ntJTKtSZwRhZMuguAr9hfTqEdgw1JBwmB0WPSqc=;
 b=g9q4xd3cIWQq63BVODxAceX5lydYn/Qc0vSO8Px8TaRCIATd4Q/r+uRoFn9iWyGG7f
 lLhbVtq1Uo6LgqQHvWZX+vowgRwRHrIiSSgW0FvKD72pTA9DpV1TdWNGrmg9oJ6N6XSI
 XZKotnkkX+OBaXWxQ+WVsvQhXzjcnm7f22GcIPYU82pddoeP5d77qNeWNRAmlQL+ILF1
 w5lMhtAknk7oWOYsXXDpYnQJmdPDv3dKUpjkGITaBuTPEM3j6s7NVoDuafZrGghbpZqC
 xRpwUvjN10+/Pc/mjZIwUxFwJVB1l7WAtYabCAiOepzyrDGfFVPrW46HqF1KxVEDBJ71
 7pVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJjnhHejZHMpxFDDFXBQi0voQpE6fh8ZLj1fy5oT8HUtUeBdpIEGitp9y/wy6hFjphJiHcpCI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6NrYN9Kwljj043lzUOt0v+fnmQ0uRaIXyiMQC0SwMwCbvwYiF
 7JaqPZoOO9pLE5YfKlkLa35ewkrdttOYkQ7BIVaLG9ZWn0wCsVPOh/4IK1vv1UqLPss=
X-Gm-Gg: ASbGncvIFzEvIpGQ8iNB0D+VomDVk/B4QrMe5h2ZKdTPTUKBazuFj3M1oWstSWGTpDC
 uuI8XbQxKKYyLvPHWcUZbV8PJHtDMzhhgGYSwx5Yd7OlIHkaKQm2Eiqe0OkhjW3FhH+ytLh+gVy
 CYqnE5t0CzaYc/BfIGAoJR9PnEyy+5z9NyVvuhmcIeecclxdI50HJGJWTck8LY6FPQ4+DJoN4vv
 gBmECgxkWejPFJEdlEzeWXTJ0JOPrQzvK7Zo4vo4+lLSLLFyw9vczsGBVQwkkm0D3v2pOSbwWax
 39isEt0los3aEYJV5sU2RFn9W22WC6YPPhJlw8CLDrZlEKfiFb+7QrG0IalXvmJWLHD8P2Ao6do
 yluaz43hqJm9dTx1kKTfDFT8G0iQ3h08Vl9rcXdOdTBWDpOI4I8JsTk6E4SjxWbjafA==
X-Google-Smtp-Source: AGHT+IHyJcGSga9tKaHsUF38fUYbBo7i0R0GAOurNv3e2FjuLQzak4+v+4S16PrPfM+4Qf10A5z8yA==
X-Received: by 2002:a05:600c:a012:b0:456:11cc:360d with SMTP id
 5b1f17b1804b1-4587630f640mr19421645e9.9.1753448249995; 
 Fri, 25 Jul 2025 05:57:29 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fcfsm53115355e9.29.2025.07.25.05.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:57:29 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 25 Jul 2025 14:57:06 +0200
Subject: [PATCH v2 2/7] Kconfig: make CONFIG_FRAMEPOINTER available on
 arm64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-b4-arm64-backtrace-symbols-v2-2-230a9665085b@linaro.org>
References: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
In-Reply-To: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=6LVP21CReSikHgEyvk3ABq+QJcxpezV3n/tyLmGg1NQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhozmelM3nn/9+4ybRKy0hScczyqREXmU5sPTp6v16KJq8
 pdj/Q86SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwET+pTD8z0nxz2EQnT2Tq+PC
 S7aoZc/sKm9bbz5exsj8Mnlivfz2Cob/2Wmn9vTGWj7ceDNslsmm2gYpe8a/xsd/Xq6Xjm48ohj
 CCgA=
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
index c883f1154595..d8e117d0b1a5 100644
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
index 8c6feae57355..f60ad5e9acec 100644
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
2.50.1

