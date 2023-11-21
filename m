Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7FCC61D98
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4B8D87604;
	Tue, 21 Nov 2023 23:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bedrocksystems.com header.i=@bedrocksystems.com header.b="jO8nkY//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C7F9870BC; Tue, 21 Nov 2023 23:54:39 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF5186784
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmitry@bedrocksystems.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5c194b111d6so4711568a12.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bedrocksystems.com; s=google; t=1700607275; x=1701212075; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XZ3VxugoH/+9RMRkNt2IhO/7UZGHRhx8hFkjm/bc/Xc=;
 b=jO8nkY//TGE9ppYMFgnswL2Ks9PYdNWuo8exuqfcfcKiH8hsPnOY6okwpZI9f+/kiY
 UtvERrsOLPxaVQ+0zDcU4+FeXd9UyRIGIf1Oy6ISZMlm700MVLAkMH+Eue3gLF5Sj4Pc
 QE8eZDzhWN3gzEEfWISBw5yF9pxPLpbpMermkFNudaOpVrZmPY6v6uLE7U9S+MR6regI
 WJw9+su7Z/szGRqleRfMQBna1RZD5yCPeDJ9aeUVGCT0+0zGU5Ucd6lVoIr3kGZepSQV
 ZI12mo3dNL/e9Egpt/s6gPkjXR0B4StJ9ovaiPGlWf/D2XP81Q4wk0bP5aBr+tvNlEcL
 yDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700607275; x=1701212075;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XZ3VxugoH/+9RMRkNt2IhO/7UZGHRhx8hFkjm/bc/Xc=;
 b=XhCp4rkchMLLYUh0kYt3qjTwyEnrJTebXgMm3nlDJK7KRSPWNzhCck1a7BGZ4+RsPp
 ZMVOxNNWwPmNLHyA7zJ+A0emRGCOKooVIv+8TFa+vnJQXvmXwStgC8qNDhhkC5ONmP9h
 nrrVlr2MAq6RTOkMBxbgIQ3mEF8vbN/yjNrPt1QyrWUuHXqBIgCfnsoQGEn6Ff2vWa6/
 gLliyE27Hf6GIbPupgd9uJbCrWfBKCPr7mNDqrcYut3rhPr9J+9RBxFBKUSFZl94Rejl
 fjZwM1Ps/jmfFfquIT9BG03YxA6hBuV6qbUeWtcV00GfehC9qMduuEaxJmReHhIHLxVG
 Q4cQ==
X-Gm-Message-State: AOJu0YyEsZkN2ioJEzMsft+00bNuXF9d47HRVij2ChJagjYrbyHvleUX
 LO5Lfb4p00L90ibGa98a8Hn6UsUziwBSaAKYC5DMU//9+q+vmawqVK/ktA==
X-Google-Smtp-Source: AGHT+IFXbYRuITdSd5QMdMeyKnHNhOY01pNxInzVclmiPzHixjUhPzH0RbKvFZWSZREJXG2xEWjGT104e5ZWhDbPR9I=
X-Received: by 2002:a17:90a:e7ca:b0:27d:3f08:cc21 with SMTP id
 kb10-20020a17090ae7ca00b0027d3f08cc21mr770630pjb.5.1700607275031; Tue, 21 Nov
 2023 14:54:35 -0800 (PST)
MIME-Version: 1.0
From: Dmitry Malkin <dmitry@bedrocksystems.com>
Date: Tue, 21 Nov 2023 23:54:24 +0100
Message-ID: <CAKRNjQ3nt3huy9Pt9eesxrKcirBR8aQH5Y8SKsGSbaXmny=_vA@mail.gmail.com>
Subject: [PATCH v2 1/3] rpi5: initial support
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, mbrugger@suse.com, pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 21 Nov 2023 23:57:42 +0100
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

includes:
* 1GB of RAM (from 4GB or 8GB total)
* VPU memory interface
* SOC range (main peripherals)

Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>
---
v2:
      new patch
---
 arch/arm/mach-bcm283x/init.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index 7265faf6ce..362838e9b9 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -68,6 +68,33 @@ static struct mm_region
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
+        .virt = 0x3f800000UL,
+        .phys = 0x3f800000UL,
+        .size = 0x00800000UL,
+        .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+             PTE_BLOCK_NON_SHARE |
+             PTE_BLOCK_PXN | PTE_BLOCK_UXN
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
@@ -78,6 +105,7 @@ static const struct udevice_id board_ids[] = {
     { .compatible = "brcm,bcm2837", .data = (ulong)&bcm283x_mem_map},
     { .compatible = "brcm,bcm2838", .data = (ulong)&bcm2711_mem_map},
     { .compatible = "brcm,bcm2711", .data = (ulong)&bcm2711_mem_map},
+    { .compatible = "brcm,bcm2712", .data = (ulong)&bcm2712_mem_map},
     { },
 };

-- 
2.40.1
