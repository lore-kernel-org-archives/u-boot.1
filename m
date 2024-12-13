Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ED0E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 09:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9690800AE;
	Fri, 13 Dec 2024 10:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="shqbdKkh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BAC3801A0; Fri, 13 Dec 2024 10:20:42 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B6B7800AD
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 10:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 85D4A3F27F
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 09:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1734081639;
 bh=l0tSHH+58pVAwXNW4R0HLcdx0h7ssRHsNEW/GDqj+Ds=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=shqbdKkhjFaIPNXOU9bG8G70ca0LOSTMG7jqvh7v+BCVvXOrCLkkrUWutG81jWcKA
 A6jY+PKPsztTfmTXAn9bhcXs1Qn3WQMkVAZkNmO22HyAxbsAPZIZgyzg5naDd9AlqU
 e51lkbS2uaDB77fazueCzjq/H1ITCV8fIHqduRxUg7Tysi2mHQpRakellQm6PTHTT/
 cjvFEbwGeenRnHMSIpfeR0WvY8dgs/LESdsz6SLeyLlHTRzDE/AHnO7VXrL8lsbFb8
 52x8piTzN1Afe/CfhzGLgtNG5OB+7oxFif72sP3HXQkdx10WSED1tqv/xtaUSLS/DT
 hWdbt7PqunK1A==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa68203d288so127962066b.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 01:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734081639; x=1734686439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l0tSHH+58pVAwXNW4R0HLcdx0h7ssRHsNEW/GDqj+Ds=;
 b=COQhMU9lXd5vPXgwNezToF/yM5wMaglA+csNyNmYmn1nZiGddbalGXZfiv4i2ReCG8
 anDJpGsMszjo3MlP5Ua2llZo+ZoozY9n36XnGseSk0ukKs0eidf8M+NeCT4/SaTg8o+K
 3x4rrpkqCRzcjzhxYnEBcOGL29Guf6NOZ5U4PY+6B1q+F05pbOJPJMY1+bOsuaX+rJIO
 oH+ea+Qjh5dw7Djan/H6UWBspWr8mF+A20TTydmeeWgamQ1cRPCw1x/XfWB9NXddww/C
 IS8Bl3pqQFqlBRXueUyqS3t+J5NWL1t3ectDW7yWKcayb40NCc2ghMvehGHbqBN96wCS
 c1ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk5+tWzRy11/qaR/sF1vHiyvpSSf764TI2FLNMknzSdraTy6VOTAx2PznHAIouPqWhxKxaq8s=@lists.denx.de
X-Gm-Message-State: AOJu0YxoMXR6kT+pOjZfAKNuVQvcVtH4dRRFqIUU94PSLUFcf1F3ZElM
 ubXIZ6qEz9cQj32SAJMCKoGhcO2dLTEivMHxDbvzbwxBBXJWIMMxh/zO+qWrWCoGgENnujf9At7
 HZKnZsMwhVGe1sLSemmTMjQEq9p8vFouXUE0JhnadQ0htZ/YtrThJbSObiqNRt2VKtvMTqoCJhE
 8=
X-Gm-Gg: ASbGncvg4ajwIBsPysysBXOjrNVFI9nE/qn8Mh8IvjFFBDcUs8SyXB2zGIvErfCPaf4
 fJE4V1aYXGCDZ8n/ta7cU71tYZc8n42xNBj/KuS1LcnSzi/2i/oouWOCplBlxZNXXSyTWxz+tIy
 7uiL2Pewr/OvipSCA68CPkIjmhzYxTRW5Zuc1tM3NQi0ua5x/AZxvSjX9IUeN/AdY+p8V0ky4OI
 IqSTxZeo/sp1V+nhtuHx94HKuIQsWq/GTOhaOqSRDGSV4pAu2p9PyCuQ5cW5XMVnOLzYBKVHljE
 4iA4g5oG//YraA8p9bbUgeMf8Y8jB3Jtdwyjh9FpogIZkTSn4rzhqVUxfIw=
X-Received: by 2002:a17:907:9627:b0:aa6:98b4:ba50 with SMTP id
 a640c23a62f3a-aab77e9d200mr182940766b.40.1734081639083; 
 Fri, 13 Dec 2024 01:20:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPjV2IULYikEMMJ5PWI+M57tXSwl36lNWcHS3rwEJ5Gy/WgG7cJqv6guqdwXUzkE+AUu7sCA==
X-Received: by 2002:a17:907:9627:b0:aa6:98b4:ba50 with SMTP id
 a640c23a62f3a-aab77e9d200mr182938066b.40.1734081638645; 
 Fri, 13 Dec 2024 01:20:38 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6873814d4sm682498966b.54.2024.12.13.01.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 01:20:37 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: efidebug: update output of memory attributes
Date: Fri, 13 Dec 2024 10:20:32 +0100
Message-ID: <20241213092032.28196-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

* add EFI_MEMORY_CPU_CRYPTO, EFI_MEMORY_HOT_PLUGGABLE
* correct output for EFI_MEMORY_XP
* remove duplicate list entry for EFI_MEMORY_UC

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/efidebug.c | 5 +++--
 include/efi.h  | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 02f1e080e88..2461425e291 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -554,7 +554,6 @@ static const struct efi_mem_attrs {
 	const u64 bit;
 	const char *text;
 } efi_mem_attrs[] = {
-	{EFI_MEMORY_UC, "UC"},
 	{EFI_MEMORY_UC, "UC"},
 	{EFI_MEMORY_WC, "WC"},
 	{EFI_MEMORY_WT, "WT"},
@@ -562,11 +561,13 @@ static const struct efi_mem_attrs {
 	{EFI_MEMORY_UCE, "UCE"},
 	{EFI_MEMORY_WP, "WP"},
 	{EFI_MEMORY_RP, "RP"},
-	{EFI_MEMORY_XP, "WP"},
+	{EFI_MEMORY_XP, "XP"},
 	{EFI_MEMORY_NV, "NV"},
 	{EFI_MEMORY_MORE_RELIABLE, "REL"},
 	{EFI_MEMORY_RO, "RO"},
 	{EFI_MEMORY_SP, "SP"},
+	{EFI_MEMORY_CPU_CRYPTO, "CRYPT"},
+	{EFI_MEMORY_HOT_PLUGGABLE, "HOTPL"},
 	{EFI_MEMORY_RUNTIME, "RT"},
 };
 
diff --git a/include/efi.h b/include/efi.h
index c559fda3004..899160f1546 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -266,6 +266,8 @@ enum efi_memory_type {
 #define EFI_MEMORY_RO		((u64)0x0000000000020000ULL)	/* read-only */
 #define EFI_MEMORY_SP		((u64)0x0000000000040000ULL)	/* specific-purpose memory (SPM) */
 #define EFI_MEMORY_CPU_CRYPTO	((u64)0x0000000000080000ULL)	/* cryptographically protectable */
+#define EFI_MEMORY_HOT_PLUGGABLE \
+				((u64)0x0000000000100000ULL)	/* hot pluggable */
 #define EFI_MEMORY_RUNTIME	((u64)0x8000000000000000ULL)	/* range requires runtime mapping */
 #define EFI_MEM_DESC_VERSION	1
 
-- 
2.45.2

