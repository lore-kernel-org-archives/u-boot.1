Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF1AC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4570D829F5;
	Tue, 29 Jul 2025 17:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rWWTRavm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 415A482E05; Tue, 29 Jul 2025 17:50:26 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25F0C81E14
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso31730795e9.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804223; x=1754409023; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OAU8u7dJ3enNuLl7+lbjMPH36mBB6d7JKMJPH8OPjp8=;
 b=rWWTRavmT47IAGr5bQkO9hN3yP2k8zVP23VIU2m70zdbK7Z+Q0gELCrHCyQo8bIJ0r
 FEDe7Leh5EN0eUUBaSRvAV+KDERV7VDsaCfgiF5fDASfMzGuwarMjmC8guJnS8aJbIdo
 vNUlFFewpbxnCic03hlnYugIuU6lXkGuxavn4Y62m2F1ecmKSR19WlNHyZVOILkVYH97
 9JBJAUQ9lsIHFAMiJVXdJk1Pj9X+yeQ3VScIAD9XdqHoBINSr6NEze5sCPj2R8jwPDwD
 fk1L1GouPACG2AEliKMbwuQtEq5coj/PSBBcB9xXvJoEjm/+3SqxgSH/mUQr0TrjQTf8
 bTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804223; x=1754409023;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OAU8u7dJ3enNuLl7+lbjMPH36mBB6d7JKMJPH8OPjp8=;
 b=lmNC9bxcPl+dw2fl6RMIPz5EvIA/EQhA1sTqHKDHJiApVyti2XJ1cNpOx5oEVL9ni/
 dURIXvqHF/DGWPvhIFdMVdJfzkyM+phs77nImSwmoC46Ft+lwbQiz4fkeEObK2dYNR/w
 bEK4yI362zhysdFDiL0CeYmk0k385mnCXIKSR3azLLAAoaMi51Osa/kNptUwyTUZDfNU
 R1EXQ3ZwahvyvB8sTPcHtVATW0AZGwiiD97O0hBCfNU2LfVfOxVcn28TZScZOtJ+/NTb
 thEQrinF8fM1Vuda7Bwx5ayG7XEEl5EmNiMvVIbVsk68Fh5SIYyAZJWFSibHptv1QBmQ
 HlhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVklETdxHYadzCLdZKTVwo1j3t9M+uaOnEdMSaTRKosfJwy+VCjg5LB3b/Mf27f8kUR3RSU+K4=@lists.denx.de
X-Gm-Message-State: AOJu0YyTRx35v4xqGE3SJbU9MnlHys7QEsucv0FZcg9TLmQCQoqSEiG4
 2YI32yu7+RzpFl7vPaIcp1PjtaV7d4oMor/yWy4Q6ExGEczbgIXfRDLoo+BjSlXBJReSmX2eNZf
 iHrOH
X-Gm-Gg: ASbGncs/G4eTUSXVMrKyzUrfaO2wN29N/dHkL3PkPtFN3f+aSK6wOmeRmz0HZ6uqnsL
 KQNiVzJEdXPS6pTB8plzoo3L3A9jLhCXy1QBxLDZ4W14tBjX2XNHmm9uQ2qGLLeXoeY6yPJhKVe
 yAJdQm0wcxB3Va2lEnJjLMgIavtME4YoFt9p533SCy/87k/ol6dO0LPJn9JxsmaS8fXbvUrcmB+
 23zxM0y2PjbZSiwn/nGat5uRUUfxrMbUku70q/7PK7Pb39apimEoueOqOO6RMmOSZVnCde1z4Cm
 HkV0py5XMIyawf7CLcSZwz6yC8yAL4voWbyOVO6mI9YEgOWPCb/A6AAiqDDT4nTeG7LmJal68SQ
 uzHDCVANnIasVR8A1FUK7BVgRINtiDyzRMUXtVf9Sx97YMvmq+bSJzgxLFq/io15J7NbB9ouBeO
 +lQ1OBGiL3XQ==
X-Google-Smtp-Source: AGHT+IGidp1fuHRIQdADE3DUuxVpHQxnJ/+OTKvl6UkggBvJfBtb5r/StL2DV4vfySDgl4mFm7gtDQ==
X-Received: by 2002:a05:600c:5027:b0:456:1204:e7e2 with SMTP id
 5b1f17b1804b1-45892b9f1e1mr3382915e9.12.1753804223241; 
 Tue, 29 Jul 2025 08:50:23 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5c1a2fsm30635875e9.12.2025.07.29.08.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:50:22 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:50:01 +0200
Subject: [PATCH v3 03/10] Kconfig: make CONFIG_FRAMEPOINTER available on arm64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v3-3-6f258b34fe8c@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
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
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO2qXajn37VaxNSxmmqK6uWEnFlzKEJVkmEh0
 vngZ2X7K2aJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjtqgAKCRAFgzErGV9k
 tpwfEACB9W+mJCPQWAKv7Of6oSYRZx5sw3Tw7SYSVSWzWdBFMtjEhpyFbDn0iWoh4OqvRDmZ7d+
 D6r/mVmFUGcN9C+pgIZ42zy8VzcLJ1TmqkLFcmbKe4VioqwLFejmtYyj9alS6bsFWQuIPNightR
 NNld7q0KlltSYXNLHZB+FFCkNIpSBCXzkM6enY6JSVWcvMO/BSXxoHoHTWmuI15eeW0HUsm/TBq
 DGdAmfXvA0z8mMJyM/jrRt7dBSDxfhVq94c6UqP1cYCRDROrW8vwi1jhuLVoFXk9wC4lThFnpfI
 WbhOoE8yB/Eb5ScWfUQ4YkTThJy/4RyZrll/aFRBSV1/WvKP4lYkhsAMSpJn7Me/AmjY6l6lWh4
 ekDDkBvdOxJ9y2DzY6gg10djZYKTqeNkWLZYVYK7ishlsWXhaXBIdU6UgNGFyA6T88dfv7vSWmI
 xCsEPLl8pdiznHUkvACAfIo4wu4JbPHYlBe3saQydKxw1XZU2/3W3EYJFGCWnKXhJGOv4BrWgZd
 oXoV3gH3YjSWEFBIIYQh5jDpDE7aq55diroX1spvPbByR0WGGl08QYiCJFDK08sz+d9ylq6X2VV
 zJuLjljvA0VMS5bVubUqJqfWQUKGAabkfjzCdWqVlhxkVjvxYYUrflknDE6xCDIjDI+fjI3b+hd
 awWaKGfNZ8/6DRg==
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

