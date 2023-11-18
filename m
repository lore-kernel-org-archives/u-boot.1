Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72775C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 16:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3CFA86F7C;
	Sat, 18 Nov 2023 17:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bedrocksystems.com header.i=@bedrocksystems.com header.b="oJCRQwqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECEF186BAC; Sat, 18 Nov 2023 17:42:25 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFDEB86BF7
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 17:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmitry@bedrocksystems.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5bd5809f63aso1891997a12.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 08:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bedrocksystems.com; s=google; t=1700325730; x=1700930530; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ofIv+UPSh3veN4mOPCftCPIlk0Oo16b32ZnIYd7U1wI=;
 b=oJCRQwqd4iIzriW2wpT48SJJGSI3BxmWeX7xVmbryIapsNH9JDUM+0uNR2OYkBBhwN
 OIfygozbxdZJaIzh3Pe9QFM4Nioj53lTCOYKK/ws5Kr8S67rHbqxOABOJyqN/PErTV9q
 pjwtU08ez6RqSRvHjz1oACFWr+XpJH6QGrwSYEbrWMnz7BPfWStcz3JPKzjEJSWOvJrK
 +/a7oeBYGZcMO3Z6eDlQqMPAjjdultiLV1rR+6UeKH1edr//JD/XR3LBoTyzZE71Nhfo
 WGCuKzroa/YaYwt3utPclIQ9WEOVUaWxsqexYXGlY9HlXt33IsJlaEc+wXhydvMH8jz5
 7ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700325730; x=1700930530;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ofIv+UPSh3veN4mOPCftCPIlk0Oo16b32ZnIYd7U1wI=;
 b=GIX3M0eFVxUq9P8pdQQYU8zpDYKhDmoz2VhShPQqPpMM2oByHRq2S5RUFGqDyqLSWA
 3mT16wpAihRc4baOTmXCgKMpnKPK0VU/1wmGk1ULQ20QZdsbf6nA8p5u9UhZPB9gDBDn
 LYgzpDoq6gsAv4IXLfdJrKiK6FDBndCXcwPX251aCCWqpmToruUbYp1lo5tG5VrcxrSD
 +782CxuJovr1RVenk6XOKmpd55bDFQYL/M4sSqrvAn4KzT2aH/RBzVSHUoJYjndCtX0N
 lJFGNwkpxo13XDp2Ao06tbwJRNI3Z8ETHEQZggQh8ALY2zZthQlWOqaCohAP1eaKH9VB
 W/Yg==
X-Gm-Message-State: AOJu0YxOrxMiJ/voWSK/XFPqzXeBZdbWMNBc7Cx+/MsNgfXPc3WGu0gF
 oeGztgPFRlMkfFUn1Ov7/6MZ3o3sQFCAtGACjPJia8MXu929B5HFpg3+mw==
X-Google-Smtp-Source: AGHT+IE4M2+fzyjViOXI861nCWiCWlkPYWWybnlUexJAiRPLzuyUy2X22vwgZRmp8k0SSTtokcWXqqQtq3lEVMU1pJc=
X-Received: by 2002:a05:6a21:3804:b0:187:865f:b3d1 with SMTP id
 yi4-20020a056a21380400b00187865fb3d1mr1667229pzb.36.1700325730214; Sat, 18
 Nov 2023 08:42:10 -0800 (PST)
MIME-Version: 1.0
From: Dmitry Malkin <dmitry@bedrocksystems.com>
Date: Sat, 18 Nov 2023 17:41:59 +0100
Message-ID: <CAKRNjQ0CKPJkR8ONivsOrb3fr=J-0f7ubvVfD7KWdo=g2dKCrA@mail.gmail.com>
Subject: [RFC PATCH 2/2] rpi5: initial support
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 18 Nov 2023 17:42:48 +0100
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

rpi5: add initial memory map for bcm2712

---
 arch/arm/mach-bcm283x/init.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index d76c8e5eb2..3424b116d5 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -68,6 +68,26 @@ static struct mm_region
bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
     }
 };

+static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
+    {
+        .virt = 0x00000000UL,
+        .phys = 0x00000000UL,
+        .size = 0x3f800000UL,
+        .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+             PTE_BLOCK_INNER_SHARE
+    }, {
+        .virt = 0x107c000000UL,
+        .phys = 0x107c000000UL,
+        .size = 0x0004000000UL,
+        .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+             PTE_BLOCK_NON_SHARE |
+             PTE_BLOCK_PXN | PTE_BLOCK_UXN
+    }, {
+        /* List terminator */
+        0,
+    }
+};
+
 struct mm_region *mem_map = bcm283x_mem_map;

 /*
@@ -78,6 +98,7 @@ static const struct udevice_id board_ids[] = {
     { .compatible = "brcm,bcm2837", .data = (ulong)&bcm283x_mem_map},
     { .compatible = "brcm,bcm2838", .data = (ulong)&bcm2711_mem_map},
     { .compatible = "brcm,bcm2711", .data = (ulong)&bcm2711_mem_map},
+    { .compatible = "brcm,bcm2712", .data = (ulong)&bcm2712_mem_map},
     { },
 };

-- 
2.40.1
