Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161CBC28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEC3081CFD;
	Sat, 15 Mar 2025 15:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QfjwepQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 847A781CE7; Sat, 15 Mar 2025 15:27:44 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B8EB80FF7
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso7017465e9.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048861; x=1742653661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/I+YsWmD57JmEgspLMSrGHa8l+bjENXNCyTdNebzy8=;
 b=QfjwepQQ/Sc58yNn9Zp6p/cgt12YbIospRgC/j1QlO5RirBVpeF7bX7Y8Yn/3cy7RO
 0lXOrZJdiArbpjlPaLycBrG61z4w5Fk+w2juSh9iVLlqa2fn5pYqWoTvQQS2bU2bouDB
 fxNIGIfavnrZfgKbVMZEebUGH675+QUunW57Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048861; x=1742653661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/I+YsWmD57JmEgspLMSrGHa8l+bjENXNCyTdNebzy8=;
 b=ZOMMNfgLy/LoliDUTSRGc0hM7AWtCS9ET+WdzZ4SDojiuzDWPtUVT2YPVtzSo8h40o
 87kBNtHA+JXO9z3etPwvjaLRnhDFBXbc4f7w3tOU8FA5gTUVaIcfglQE+Td5FLOXfWuw
 IpUMAMcCW8/D3Lhn1J3YOkTSzfCsO1E4xipxmDm1VV7ag23AGiDgg5Tbcrj7O/ABT6it
 pGOlduEShJLqlwcUQdFLHV8CLg/O7eLp+/NDSXimZ3tHtrhPbef96HMwvtdioXbfsxgQ
 RcoAdhMSGhvbyMNmdUSiDgKqaO+h05+jOAffvigmgu2FOzAiXRFLFbW0/4EuAL3U/syw
 m2uQ==
X-Gm-Message-State: AOJu0YziHV7UMgcwjGzesugyZpCMpKN5MxBXjDLruZmvShL6QcrkXMWZ
 Bz1IpaKVSx07AOn7ZZ9NhJxtV/v4YhBPjMXwyAelK7vasDNVduvVob2Vgo0+S1L/FQxWKaySvKv
 +uw==
X-Gm-Gg: ASbGncu2E1Yx7di/9KSAN7rkYXtgBk65dz+MTzVSoFaS9/assC7hdjSDiHk95xl3hAa
 1kTZbllcZ24Crvpv8IuTL+F8//K3qSKoQSeFvy/nQuA+Vkvvl0+FZDx0O5nB0KrnKuoefXPw0wy
 OXzGPxdmYobWaMUx6SOeN3hQWZ8Cuvzix9oHeKRhNW0RPcwkzrjWUz2ma1PwLUxOBMFTclORpb8
 a1xgFgPwti/vtHNonUDw71hIBmB2MkU7cZxkzilbROlDKLFpt7CggFx928QZ/JRoM0xXPnAP12f
 6OgenX3KhwATm8yHXTPo3tdtt8vwDKQx0aEwHDI3sw==
X-Google-Smtp-Source: AGHT+IEbnzkQIfv2fNS7yBQaBdKguly5BDo7ElCCYrjMRsMJiLrBZXUSloCMAAXACn0cwRUyb/MxOA==
X-Received: by 2002:a05:600c:1908:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-43d1ec80980mr87646675e9.7.1742048861171; 
 Sat, 15 Mar 2025 07:27:41 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 16/46] x86: Tidy up the GDT size in start/16.S
Date: Sat, 15 Mar 2025 14:25:36 +0000
Message-ID: <20250315142643.2600605-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

Use a symbol to select the size of the GDT, rather than hard-coding a
value. This matches how it is done in start64

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/start.S   | 4 +++-
 arch/x86/cpu/start16.S | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/cpu/start.S b/arch/x86/cpu/start.S
index 0ef27cc5a00..385a691265e 100644
--- a/arch/x86/cpu/start.S
+++ b/arch/x86/cpu/start.S
@@ -254,7 +254,7 @@ multiboot_header:
 	 * GDT is setup in a safe location in RAM
 	 */
 gdt_ptr2:
-	.word	0x1f		/* limit (31 bytes = 4 GDT entries - 1) */
+	.word	gdt2_end - gdt_ptr2 - 1
 	.long	gdt_rom2	/* base */
 
 	/* Some CPUs are picky about GDT alignment... */
@@ -313,4 +313,6 @@ gdt_rom2:
 	.byte	0x93		/* access */
 	.byte	0xcf		/* flags + limit_high */
 	.byte	0x00		/* base_high */
+gdt2_end:
+
 #endif
diff --git a/arch/x86/cpu/start16.S b/arch/x86/cpu/start16.S
index 865a49731e5..8d9acb193e0 100644
--- a/arch/x86/cpu/start16.S
+++ b/arch/x86/cpu/start16.S
@@ -61,7 +61,7 @@ idt_ptr:
 	 * GDT is setup in a safe location in RAM
 	 */
 gdt_ptr:
-	.word	0x1f		/* limit (31 bytes = 4 GDT entries - 1) */
+	.word	gdt_end - gdt_rom - 1
 	.long	BOOT_SEG + gdt_rom	/* base */
 
 	/* Some CPUs are picky about GDT alignment... */
@@ -120,3 +120,4 @@ gdt_rom:
 	.byte	0x93		/* access */
 	.byte	0xcf		/* flags + limit_high */
 	.byte	0x00		/* base_high */
+gdt_end:
-- 
2.43.0

