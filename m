Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651E0C19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:24:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12FAB81276;
	Wed, 26 Feb 2025 23:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZZR7SoPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E0408118A; Wed, 26 Feb 2025 23:16:25 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9BBB810F2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22128b7d587so4222255ad.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740608181; x=1741212981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQUouDDO9Qf2cBBf2T7FxsQoMG8pvyVMg0xYQitDZDI=;
 b=ZZR7SoPXodLIB+xP7+2Ih8XLNWqcByq6EIctKu+b/vjZNaVY4OFD+m7sR7XuDjENo9
 qYgipVdj2ADB/O9ZS4Q2bQEqvMXEWbBBewvCGnQtkjL9Wvl5zm+GmYv6lhQTI4WR1Wix
 LXZ7f/Oqm3KKOr3wa454QqLrdqo+mQIf0jDlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608181; x=1741212981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQUouDDO9Qf2cBBf2T7FxsQoMG8pvyVMg0xYQitDZDI=;
 b=WdZRdBcP+E4pWTM5V0L9vs1iAyBwecZLC+MWit6B/CfvhdQoBmcrwo2RbgJ773uyOv
 j4jn7SVdAjhfYRBQXAg+Cd4XqdIn62eI33nWGnrHsE2kg6aeo3tcK96Cc2VsOL6ZobVT
 yWK0JOPgpE5gQExsX3wvAxJlExOruOLwZU0oZYbKVlYROBnkgfjOJLLa1sBFNM4X5+Za
 ofDXf9I0c/upWAjBau5somRulyuZQMsD+kehMo/ayiZv+G3KzRAlqbJOp/okDYi8V2RY
 sXtadPw3FejjAXJpbmtkARNIFcKVJT4OCRq6ewO8ko2gQZp5FIfgvHbaLIdlxsM0uF6w
 15fA==
X-Gm-Message-State: AOJu0YyN3L7YXwZXca5qf4it2tRXB8lj5gigDGKuC/2L3aQoWQRhVsZB
 LjLbKb8U2I29ORU2TLsj/BTrVSwOgJuOsqW7SG9jH68BR0PtBfDCoPcn8iE9YuIo0V1z5lO+f78
 =
X-Gm-Gg: ASbGnctf4cEOnxGYikj+Wsh/WcxjbnOvZieP3g/JlDWttXB3c97+7GlbX9daZbzExYY
 8qh0SwEnrAX+usichQCVFzCCnOavuw5NnG4w1GryI+fpXtObTTtx8W8Y5I1U0bczMm0xX9Tc1Xe
 YeU8OT50hAb6FLVMyyUamndM3bmM7SCRSpc9daelWJnh2gF1gGaeI5iMMerYY8DtkRMVmns1+Am
 IRVlVLtEGHCrzX2s4DVrqsES70F0P1d33uhWgtefu/NyqU3EsVh8S02kBx04iWD7cF7W8AOJSj8
 vvwUvIreimYL3FrsVFqBP0lZ3QVpf5Rg8Z32AfQj7V7jdxgHdDwNc0vb2NWhlcQlHg==
X-Google-Smtp-Source: AGHT+IH/N49juWRF2vxeH1XhBru5ALqycVeMruLA0el4yfC/MxWtgKx+2jlELsBKA1ZbAFYyYGbPtg==
X-Received: by 2002:a17:902:e842:b0:220:e9f5:4b7c with SMTP id
 d9443c01a7336-22320080b3dmr74245915ad.17.1740608181172; 
 Wed, 26 Feb 2025 14:16:21 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-223501d3219sm1376375ad.38.2025.02.26.14.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:16:20 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v2 08/15] cmd/cbsysinfo: Allow on ARM as well
Date: Wed, 26 Feb 2025 14:15:54 -0800
Message-ID: <20250226221607.1283592-9-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250226221607.1283592-1-swboyd@chromium.org>
References: <20250226221607.1283592-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 23:23:35 +0100
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

This command isn't x86 specific. Move it up one level so that it can be
used on a platform that can find the coreboot table, i.e. x86 or ARM.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 cmd/Kconfig               | 4 ++--
 cmd/Makefile              | 1 +
 cmd/{x86 => }/cbsysinfo.c | 0
 cmd/x86/Makefile          | 1 -
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename cmd/{x86 => }/cbsysinfo.c (100%)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a04fcaa0e08b..aa6e91455653 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2905,8 +2905,8 @@ menu "Debug commands"
 
 config CMD_CBSYSINFO
 	bool "cbsysinfo"
-	depends on X86
-	default y if SYS_COREBOOT
+	depends on SYS_COREBOOT
+	default y
 	help
 	  This provides information about the coreboot sysinfo table stored in
 	  memory by coreboot before jumping to U-Boot. It can be useful for
diff --git a/cmd/Makefile b/cmd/Makefile
index 8410be576bb0..2e8034e9c5fd 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_CMD_BUTTON) += button.o
 obj-$(CONFIG_CMD_CAT) += cat.o
 obj-$(CONFIG_CMD_CACHE) += cache.o
 obj-$(CONFIG_CMD_CBFS) += cbfs.o
+obj-$(CONFIG_CMD_CBSYSINFO) += cbsysinfo.o
 obj-$(CONFIG_CMD_CEDIT) += cedit.o
 obj-$(CONFIG_CMD_CLK) += clk.o
 obj-$(CONFIG_CMD_CLS) += cls.o
diff --git a/cmd/x86/cbsysinfo.c b/cmd/cbsysinfo.c
similarity index 100%
rename from cmd/x86/cbsysinfo.c
rename to cmd/cbsysinfo.c
diff --git a/cmd/x86/Makefile b/cmd/x86/Makefile
index 5f3f5be2882f..870e941dcf00 100644
--- a/cmd/x86/Makefile
+++ b/cmd/x86/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-$(CONFIG_CMD_CBSYSINFO) += cbsysinfo.o
 obj-y += cpuid.o msr.o mtrr.o
 obj-$(CONFIG_CMD_CBCMOS) += cbcmos.o
 obj-$(CONFIG_CMD_EXCEPTION) += exception.o
-- 
Sent by a computer, using git, on the internet

