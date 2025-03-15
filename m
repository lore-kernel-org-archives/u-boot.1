Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC3CC282EC
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E843E8210A;
	Sat, 15 Mar 2025 02:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="agGLrlYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF8A82148; Sat, 15 Mar 2025 02:29:32 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1154B8215B
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7c54c52d8easo417963085a.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002167; x=1742606967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CUaGsTsXThcOcf3KZs6F4xD7DLWGCtoTQwpyVZIJ5nU=;
 b=agGLrlYrmYVfb0P8zX3V9JsuToC/474UNxy0A3GtD1xlB4+0WmHr+qvJRQm3OQS53l
 togb+t9tiofK5mGIEBXVTlRl14IJahgZ+/OLB9cHB/eNIjmibNv80tdUxMiCOMxHOcnd
 RQ2fnjGdRG44Wm2KjUzklLmUjhlr4A0UY1NVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002167; x=1742606967;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CUaGsTsXThcOcf3KZs6F4xD7DLWGCtoTQwpyVZIJ5nU=;
 b=pNu7CjhvszxjyW8dklUld8iwFFqzFXdIX0kcj98f1wzhKZ9IfsCQUx/4suKaMir3bO
 0FLa0JAOQyI0NQAzqESr3rhIVi7jyJfU4ngWkufsGJFa7QPCIYrCyNgUUFKYUBOQfsi5
 bGkmlLG+AjZa/iJ3nAgEIOsQ0d02dmF60xW9hufJeS8g9Lg2FvXLH0xJIT4mtxDypppc
 Z8CHmTwvzuKdRqihES96o8apOZsI/UmGZml4fx4Oj4NO3svnwBEzH38aGcyDA0/81Atk
 rBEMrMfB5ddXPxaaCDJ9GoNa6E3bXBFZvzu3QUM8kZi8EaFj7IBFwP76R71BcFC/yGjy
 y+MA==
X-Gm-Message-State: AOJu0Yxh1kWIr2QWFG9FRdUfRLMUgWLEL+EPaREhXdUatApVstBUbxuT
 9cgwBY5f5zqO03xLkEpOP9pl5F7N+T0iwtXQAlhHUt4mx885SWFpk5zPLJ3ixLDIVgvE153FPfq
 p
X-Gm-Gg: ASbGncvuzSslx3QYgHva1pov8DSZMv0hQSZVfF8amHvrttNBCE1unMku09m5xPVKPNM
 KqaB1FV9wIaEcsxM7RkHPGjod5AI05f1ovZcAL1CPuBaYhfWaL3WG5TY0v5Wa7U+CzFlvClPxLz
 2LCvRd66nY+RGMwxHJ6o37TkLLoGJ6nfGPMvCVrIx2zvy0HllvsroBi7a08HbLnrLU+tUigkvyf
 fcjZ1yMDDIdP5dp249fbtONnG9/kA85AiTHm+ZwF5kpBjjC8VkwNw76h4SCmxAEOUk+dhYnxXwK
 4xgMLfOx+ryqpX+NmZZ1R8Sbmitq5XGO98bWGmaZwe/xfZ2M
X-Google-Smtp-Source: AGHT+IF3dx5W7zki7nm0SsYYvpQIKepfY4JJ8f8enDP71dIQGZP1M4FQTQtthx0oFWkDQvE9JKSNRw==
X-Received: by 2002:a05:620a:439e:b0:7c5:5cc4:ca67 with SMTP id
 af79cd13be357-7c57c6aad7cmr569358285a.23.1742002166901; 
 Fri, 14 Mar 2025 18:29:26 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d89b16sm322555485a.92.2025.03.14.18.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:29:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uboot-snps-arc@synopsys.com
Subject: [PATCH 1/2] arc: Rework Kconfig choice menus
Date: Fri, 14 Mar 2025 19:29:22 -0600
Message-ID: <20250315012923.399465-1-trini@konsulko.com>
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

Currently we get a number of warnings about using "select" statements
on "choice" options and that this as no effect. Rework some of these so
that we use "depends on" rather than select for the CPU, and have the
CPU select the MMU version. The MMU version is no longer prompted for.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: uboot-snps-arc@synopsys.com
---
 arch/arc/Kconfig | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 6ae66bb163c0..be9774dc2896 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -66,28 +66,20 @@ config CPU_ARCHS38
 
 endchoice
 
-choice
-	prompt "MMU Version"
-	default ARC_MMU_V3 if CPU_ARC770D
-	default ARC_MMU_V2 if CPU_ARC750D
-	default ARC_MMU_ABSENT if CPU_ARCEM6
-	default ARC_MMU_ABSENT if CPU_ARCHS36
-	default ARC_MMU_V4 if CPU_ARCHS38
-
 config ARC_MMU_ABSENT
-	bool "No MMU"
+	bool
 	help
 	  No MMU
 
 config ARC_MMU_V2
-	bool "MMU v2"
+	bool
 	depends on CPU_ARC750D
 	help
 	  Fixed the deficiency of v1 - possible thrashing in memcpy sceanrio
 	  when 2 D-TLB and 1 I-TLB entries index into same 2way set.
 
 config ARC_MMU_V3
-	bool "MMU v3"
+	bool
 	depends on CPU_ARC770D
 	help
 	  Introduced with ARC700 4.10: New Features
@@ -95,13 +87,11 @@ config ARC_MMU_V3
 	  Shared Address Spaces (SASID)
 
 config ARC_MMU_V4
-	bool "MMU v4"
+	bool
 	depends on CPU_ARCHS38
 	help
 	  Introduced as a part of ARC HS38 release.
 
-endchoice
-
 config ARC_MMU_VER
 	int
 	default 0 if ARC_MMU_ABSENT
@@ -172,14 +162,14 @@ config TARGET_AXS103
 
 config TARGET_EMSDP
 	bool "Synopsys EM Software Development Platform"
-	select CPU_ARCEM6
+	depends on CPU_ARCEM6
 
 config TARGET_HSDK
 	bool "Support Synopsys HSDK or HSDK-4xD board"
 
 config TARGET_IOT_DEVKIT
 	bool "Synopsys Brite IoT Development kit"
-	select CPU_ARCEM6
+	depends on CPU_ARCEM6
 
 endchoice
 
-- 
2.43.0

