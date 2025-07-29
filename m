Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA84DC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AC598304F;
	Tue, 29 Jul 2025 18:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HzvU9dei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BCDC83145; Tue, 29 Jul 2025 18:07:49 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08221831A4
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so37899345e9.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805264; x=1754410064; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OAU8u7dJ3enNuLl7+lbjMPH36mBB6d7JKMJPH8OPjp8=;
 b=HzvU9deikmLGAfFYmryrfeXt0Wd+iFnH/GG8A662shWRCY9JexNNiHzyOmdJ4zUiF6
 xT7veT/Ne21Hrw3kwfVZcPjm9ONJkZc5afj4Kl4DMo1G5frl3CCwZCUuBLJopkdKjZuv
 Am1uKvlOwXrNFyRvNldl+lJv8dAO4NpdeeF8etp+xntfL0HNViSG9z+j4xSBG5gND+HQ
 DIBn8kfw4XBPSzhceQ99HrY3deyFxHIrcBWOijVNF5IKJ6iWgJKNBw/ukwmVVm+wMh/q
 7JMKfk/NvUFqjHVmD3SV9xu0DSYvhEpo1GW0UhNNDiI1/uVaZYIiiSFSkeeYMFjoTRU0
 +xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805264; x=1754410064;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OAU8u7dJ3enNuLl7+lbjMPH36mBB6d7JKMJPH8OPjp8=;
 b=BjkzGfgVMTtD62coU1ajxQ0wUGp0dmE+U2zmuOTVzj+HJX3aQhBDcnCfj8sXOnukCY
 xo5wc7DUq8MrnfAxwRH6Lp1d9BC0nffOrbBrdoeDCVzUKrRuLWomhizuSKRl+lxWqNaS
 9tNA4mDhZJzFfRo96VuKTvB6NIcZMY9b3ey7cBaaF6xRiSBN3TYXBsU+pMnCZK+QeSpz
 6CHUAGe07/B1aIXwqB7BtVNWi+MWbg3iVym3uxdomSb2QB7DmYwAV08DZ7YyzJUWGMri
 xoIkvKqji6PA8mP/p/eBiCQdgkC1ba6P8ZUY/gSj11bBLL/KsjolyCjPMPmgbfdCmRwS
 ITsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXErEtb0jlZJCqyxeXY8JoV/klQ+4AF8HXh9QCMVGNtMGthweFXO4iwMMI1w14iYwgGzL3YHT0=@lists.denx.de
X-Gm-Message-State: AOJu0YzzHN45oySfc30LXuTTmaUD/LPzIYufno1fS2YgQVUY/+ewRVnO
 kc2yW0mjH8syxaHxmRKRvZzjwgtvYKv+wML2pkJhQwQ2ZmHO71MU7hEfM1CsoMVYlOU=
X-Gm-Gg: ASbGncv2Q3spMpSEZi7ej6GLBvOz8q2uC57NokX8BJbrkivlsz9VH2R2ly+pnhW8nLA
 SNhysz28KznYElEKdnWZwdvSMYsrM98CrGVVhhLqCNA7x50QTCf5Ugudmf+PfBmCStJHr3pvlri
 uv2D3llw3ZqKbcF2f5/bt7T1UNwAFoDzYXoDHz6cmYkuq7sSoLcxe222dHg7vhYpcgBXnlcWCMJ
 JP8Vq9X6B89quduhHM5XhNS0BMSk8UZZmevDg/Ejccj1xYgXM0iOFGJo8uI4jRWJV/CieZbcqvi
 1u8gbUOjT1p2GAIpkgNeHe67wqx+cP/ktmO0SX8DGDDY/rUOrqbcSjKYXfkIIkCltla9PSsIYn2
 yA4WDc8sQ8u6CiMje+oGf9VcxL4GSrtSk2kxSJY6btZxsVGjMqpdHkNzppUywGFWvjyLGGD0Cjr
 8YqJXn5weHTQ==
X-Google-Smtp-Source: AGHT+IGkHomiPDfo6EkoWYTlSUmZinAyI6IFcckXkdDGopWsjQsa3fWP9RBxb5J/97GyBB+XtWBjgQ==
X-Received: by 2002:a05:600c:1d19:b0:456:18f3:b951 with SMTP id
 5b1f17b1804b1-45892ba16b5mr3684805e9.15.1753805264362; 
 Tue, 29 Jul 2025 09:07:44 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b781d2fc1csm10512075f8f.5.2025.07.29.09.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:07:43 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 18:07:24 +0200
Subject: [PATCH v5 03/10] Kconfig: make CONFIG_FRAMEPOINTER available on arm64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v5-3-0009c4620a46@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2793;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Mw4RH2YSTpmzvYgrGKinq7mtwPHmaYZ0Rd4QoQyJZCs=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiPHB/LbcBMnNOMXh4TCNmUwIr2rcfF/08q9KD
 LZdKcVWWXeJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjxwQAKCRAFgzErGV9k
 tpD0D/0S2BgxZIEQWwWnn9zW3yqbLyQTClINGoYzYEezZ5yay68bL3WUPTPuxRmO2u9CImNWqpm
 24ljKRGtZnYdZjU8cqsgYglfIcwxrDEQUNHyfh3t727drZb50cyGElRlqvPL/Pr3URVplaafM+T
 cP7NCyGy+daR3xj78J9szrIr1H1kaEjamx8IEagZIGBtaiDbWoo36CVU4Ui8psRptGcp1YJqygM
 V/STUfnJ6biVYrKH167NNzlo1gRZsVHWmYoPEoampHqXQYytbmP3hLbBzK+AAw41MAs2tk2hawk
 nKphCdi8TOxLGUXB5qiLD+28oYDgHQTv3QVbNzqyM0FF2ebfF8eizdTlP+hNc5FwWPALN9ICaGf
 B+H7tE3dyhiMI3e8y0Eu1G60luYXwggX3EfTUTjdYWE2B1gpvtJPVSR4Eh1GAd708VkyvfBvAdW
 aMEvYbOleZIsAkPSrpGGd/1+o97wfnJMKRIJ2k1FK+2Y65Xjfco+7nkhpWXQgyPYW6c8KH2fyuU
 4q8MkW6nW0HkslxynCnWUTwTpQ6KSS/OuOPEb4VeYgA/Cn+Dqd4fOnTvFYBN+LtvJoPP/ehqzNS
 2lF0vVOg9GZyOv+DlO4NFdSBKsdxoQmnNE8kEAyHf6h6nhhqisMYsyxfcto2Qq7wYcTYiVdgPBi
 kDl6d19RetmAMgg==
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

