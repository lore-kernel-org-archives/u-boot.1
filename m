Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C34C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07D2B80FE1;
	Tue, 25 Feb 2025 00:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LDigP9lz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B039D810EA; Tue, 25 Feb 2025 00:07:22 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD1680FDA
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85598a3e64bso405486539f.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438438; x=1741043238; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OL+SdnJwpe5BOmmnoV9SoNZInavcIsY+uTHTCChoPA=;
 b=LDigP9lzrEzioD8Yvu8mdM/Lgn9VWqcLllZ74arZ3jNHt8gqTIdV4m8cAkXLdsz0i4
 8Boor/z3sK4gdGVSaAOIekGxsVzfZ711i0ndSHVTr6Uvoqhl0lYvPCs3es2Qd8JiasDm
 IImMmimmO4LhpEhpKaWb3JvYQZvUT/kxjCP3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438438; x=1741043238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0OL+SdnJwpe5BOmmnoV9SoNZInavcIsY+uTHTCChoPA=;
 b=kOz2xQOpGcyIwmD+o8kgadH2BjP4ONn0vFSTT1JUOAdKqE1oGAWk/HZTWaejNAWVhd
 IOL8Ac0j15f80hheYJg97LHazPG/zxUujiOcDQoUH5YBRYPKhlQ4qrglvoZFetbD+DbM
 M0UmXWxkuxcSs5/Y6jGccBNi6bcUAMVfNZeDVEmoT9XqIk5ymvBbLPnZ6JdBZmbHTq6M
 p0QhuxBKsUEc5bcXCphtwnVUTMDJ3fy1xJvqyhcniJElAgsIBSmGlC6TqABLTA2a5CQv
 2aQQWZS3AvwQVR2eJRvF55xz7DffzqUEG4hZPLWQEmyaxHSvzYNudRllj2h+H5Y53d6S
 qhEw==
X-Gm-Message-State: AOJu0YxrNX1XjCnsndYAbTWp6YQYnzb5yN/9gFWbdVhkRhfUfJodWBM4
 6P6AMg7XIXArCtxYwLcISLfqQt+soCnpLwUj10oiU5TJBVEHtsKoi/5A/e348NL+43xovYXNzrw
 =
X-Gm-Gg: ASbGncvy3SZ1Xkc+Ig7kUVEnTyhry95C2s+ONrDX/qJdI4jfFonkkLlG2gAdyIJV2or
 PKDmaMgUr4oJB0AqAr/p74k3IejkJmPWTTRYIutQaHxieaBE9A8tVbLmlQBpyvzoMHnnuR4SQJH
 2x/xvzRALI2dVNcqCXL7P+n6e6n8n/LlAMFHjZju7fsDCwSDK3CKIJgF8PR5ihMgoSO9E6kw+2L
 01pgcn9zF0AA3dg4ySbNG2cHtCmiEORGEldrLGe2ATBqfM7lLZaS94hMMvmEljI6blv0Bdsqliu
 r2Coe1TQ6iwoO/wvJs6ayUSjuw5sXgtQEUpgFRv3SZIvSmEJBayH4PT3jneJui4=
X-Google-Smtp-Source: AGHT+IEB85gvocKG3CieNaG59qVLUwSwN21gRX0OxgrTuGpEobwrz6hY9TYNtZT66n9/QOk4+XcNaw==
X-Received: by 2002:a05:6602:158c:b0:855:b0fe:1837 with SMTP id
 ca18e2360f4ac-855da9d0862mr1639884439f.5.1740438438169; 
 Mon, 24 Feb 2025 15:07:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 10/44] x86: Use defines for the cache flags
Date: Mon, 24 Feb 2025 16:05:59 -0700
Message-ID: <20250224230640.2665206-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

Use some named flags when setting up the cache, so it is easier to see
what is going on.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/i386/cpu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 3bbad3b2eca..845e00ca439 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -592,6 +592,13 @@ int cpu_has_64bit(void)
 #define PAGETABLE_BASE		0x80000
 #define PAGETABLE_SIZE		(6 * 4096)
 
+#define _PRES BIT(0)	/* present */
+#define _RW   BIT(1)	/* write allowed */
+#define _US   BIT(2)	/* user-access allowed */
+#define _A    BIT(5)	/* has been accessed */
+#define _D    BIT(6)	/* has been written to */
+#define _PS   BIT(7)	/* indicates 2MB page size here */
+
 /**
  * build_pagetable() - build a flat 4GiB page table structure for 64-bti mode
  *
@@ -604,15 +611,17 @@ static void build_pagetable(uint32_t *pgtable)
 	memset(pgtable, '\0', PAGETABLE_SIZE);
 
 	/* Level 4 needs a single entry */
-	pgtable[0] = (ulong)&pgtable[1024] + 7;
+	pgtable[0] = (ulong)&pgtable[1024] + _PRES + _RW + _US + _A;
 
 	/* Level 3 has one 64-bit entry for each GiB of memory */
 	for (i = 0; i < 4; i++)
-		pgtable[1024 + i * 2] = (ulong)&pgtable[2048] + 0x1000 * i + 7;
+		pgtable[1024 + i * 2] = (ulong)&pgtable[2048] + 0x1000 * i +
+			_PRES + _RW + _US + _A;
 
 	/* Level 2 has 2048 64-bit entries, each repesenting 2MiB */
 	for (i = 0; i < 2048; i++)
-		pgtable[2048 + i * 2] = 0x183 + (i << 21UL);
+		pgtable[2048 + i * 2] = _PRES + _RW + _US + _PS + _A +  _D +
+					 (i << 21UL);
 }
 
 int cpu_jump_to_64bit(ulong setup_base, ulong target)
-- 
2.43.0

