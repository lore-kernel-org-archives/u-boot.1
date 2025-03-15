Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8FCC282EC
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C4A8211B;
	Sat, 15 Mar 2025 02:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CILA+doz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7335E82116; Sat, 15 Mar 2025 02:28:53 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C345820FE
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c54f67db99so340295985a.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002128; x=1742606928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6RPl/C18JMMwcrtgzUnJEMXF3tJO2APzot0RoqltdI8=;
 b=CILA+dozbigHnZ7eVCpG8DXawqm+rFa9y6qKArHRLamWggRA0pF6MT5mWV1hiIWndA
 Q6OQ3ciw4zC0lSWpgukBf/wb+2E24Ne8pqc6es8kq0qBpUcwNrUGikKQkVeSewGb5U32
 1XgEamVwf4iHviTMFPBPBOKIaXwpsn5CtUm3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002128; x=1742606928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6RPl/C18JMMwcrtgzUnJEMXF3tJO2APzot0RoqltdI8=;
 b=Adcst3Vy85whIgVHKr4taZlWdjFRYRpKFxkpgKBKwln7dTmVI0jxwA0UekTiC5KkmO
 zHMxkR3cB1OT2vqPD8qqHAdI1eAdWMKxU7AeTMKEe04hZO6zQo9A1twQtxaODBTfEKNS
 1kJ5nG4aWtF1m9ylJ/PXlSR2WrptOpRk7GJW6iWp6itVEHag34CAbXYxwUTvQkzb5Lle
 MsyVDNXLdjTut6A7g0PAqtvW+cPveOhugICrcqr6q8L7n53T2wYV6ZGHwCxhU94Uqiy1
 fQC/dxj6h5hNeseVh0O/j/mVnMhZC8LERimMiKJf0BMFvlZoAJKxyOoNGOIX+TJn/NqM
 wBKg==
X-Gm-Message-State: AOJu0YxQozmiPdGIIwusmd3rnDpi/ifvbmy+4MRIHDbll76NqaqgdfI6
 Y5n3wRWzCvFBXlkfhec7YOjd9XRNsIwv3j29GEVWt4dx0Z/1przAyVLyIZwxrEl4EwcJuqr0qZw
 V
X-Gm-Gg: ASbGncuQZ/9kvwaNzrkEbxv2vckFKPgVol5u1Y0Kc82zpNSN3k+9mDKz+R+YJI+S4uz
 WIIMD74IP+wkhI+DGM/JhGbarN/qnlI+VrY27h4QQmISjf4a+XMdB2PH1nf3N8snena+EAlT2tD
 rhPC4j9nYzIQlMnZ8cK6nVw9gRq24NAtOtCucU12mL/pOmjLVddQAd8xCqW8UlKXnXVN614t+JQ
 fe9aP4wmMsocrq307qOWRBJThF4YfL+MeVPD/b9RD0wVMnIjcCF/I/Fj+95+HsLp1kph7PIAGGf
 Shx5Q7Kd1R3kM3mk75n0OaL34RJoE1/vDclcy/djzmUC239l
X-Google-Smtp-Source: AGHT+IHKHS1vo/z+RWnXqa8qRLdcS96/LISN+Nf7uXeQGXvJ6uRiWFqFIzfzNlw4MOX3C9OjHr9ubw==
X-Received: by 2002:a05:620a:628d:b0:7c5:4750:9300 with SMTP id
 af79cd13be357-7c57c6ed62dmr679031885a.29.1742002128200; 
 Fri, 14 Mar 2025 18:28:48 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d72b62sm323756685a.86.2025.03.14.18.28.46
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:28:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] x86: Correct usage of FSP_VERSION2
Date: Fri, 14 Mar 2025 19:28:45 -0600
Message-ID: <20250315012845.399316-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As the code is today, we get a warning about "select" statements on
"choice" options not doing anything. In this case, we move to having a
"default FSP_VERSION2 if INTEL_APOLLOLAKE" in order to get the desired
outcome.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/x86/Kconfig                   | 1 +
 arch/x86/cpu/apollolake/Kconfig    | 1 -
 configs/chromebook_coral_defconfig | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 006a59d6fa63..9f33cc75501a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -382,6 +382,7 @@ config USE_CAR
 choice
 	prompt "FSP version"
 	depends on HAVE_FSP
+	default FSP_VERSION2 if INTEL_APOLLOLAKE
 	default FSP_VERSION1
 	help
 	  Selects the FSP version to use. Intel has published several versions
diff --git a/arch/x86/cpu/apollolake/Kconfig b/arch/x86/cpu/apollolake/Kconfig
index c7f26d171cb0..5dd866ffcfe4 100644
--- a/arch/x86/cpu/apollolake/Kconfig
+++ b/arch/x86/cpu/apollolake/Kconfig
@@ -5,7 +5,6 @@
 
 config INTEL_APOLLOLAKE
 	bool
-	select FSP_VERSION2
 	select HAVE_FSP
 	select ARCH_MISC_INIT
 	select USE_CAR
diff --git a/configs/chromebook_coral_defconfig b/configs/chromebook_coral_defconfig
index 93e3355219b7..3d5d3619a141 100644
--- a/configs/chromebook_coral_defconfig
+++ b/configs/chromebook_coral_defconfig
@@ -16,7 +16,6 @@ CONFIG_DEBUG_UART_BOARD_INIT=y
 CONFIG_VENDOR_GOOGLE=y
 CONFIG_TARGET_CHROMEBOOK_CORAL=y
 CONFIG_DEBUG_UART=y
-CONFIG_FSP_VERSION2=y
 CONFIG_HAVE_ACPI_RESUME=y
 CONFIG_INTEL_CAR_CQOS=y
 CONFIG_X86_OFFSET_U_BOOT=0xffd00000
-- 
2.43.0

