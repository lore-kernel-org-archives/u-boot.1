Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02463C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34B5F80F12;
	Sun, 16 Feb 2025 21:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VwyCVE0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B7DA80FCC; Sun, 16 Feb 2025 21:45:26 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B6CB80F95
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3cfeff44d94so11985445ab.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738722; x=1740343522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/I+YsWmD57JmEgspLMSrGHa8l+bjENXNCyTdNebzy8=;
 b=VwyCVE0CYE7waxoso/EjEXbYTSuDgZd9BuYHvmzI1dtRV9exaE9bUkB6SPADSkkQ1T
 a/9PcbR7rOO2zxeynn/gR3WblOUtg0K5amSa7GaklWyAm+5L584fgdbEqi7hv31Ce9nC
 YCtdI0eBo2EkuEUwYZYCsdyv0FrQNxrGlANgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738722; x=1740343522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/I+YsWmD57JmEgspLMSrGHa8l+bjENXNCyTdNebzy8=;
 b=O5a3w9/mR3LQvg/huHspYdcXZEmFEZrl2vxOfM8FdYodChOejDKAWGK2HvWBjJ1i6G
 X8TNA9tP1iKTG7g+88ViAQUaVm7caHFZSwoduvHsa3c8KNBHsIYcDV5+IP6dhIIcRjdy
 iyPfRh3ifgKJN7rB1jf8z/r9nPbFE5aQiKN91JuIGl4umDgqrOayxNrdYazSNpU1kcni
 NO5zXYGGHUgoAEFcuQqFbZUzvGwa+La35sAxz+caw9b46Be1y45wfzfF1cjn4/HT8DeT
 KEWH2qZeS+5rHvLZnTdhBt9DO5vl7l9hiakmfPcveo5M19uYVE4suc5YA7ZU2ri7cgki
 kBmQ==
X-Gm-Message-State: AOJu0YyObUgEkfdSD4V8vEuMKQmfyuwRadIZ07v9sIKZaogM/sUbkFSm
 l0R1kH5pKdUHKhhcNUlfIUUGmUo4xu0VN0C7NfjWzGr40PyYVcI3NMT6ftL9H0FMBPTanyqMDOY
 =
X-Gm-Gg: ASbGncsKqWYk/nJRI3oQpS+8QnrzHJqmyx41P1NW5DBJsTbmD1ffFA65rvpFoCkZTS1
 wUrHPiD/owRsU9soqohgEXHdL053oP0XpkkZxz88Hyp5KdJhSIXWZF/BsNAh+/DX6CYbvcJ8hyX
 IiEJN91Q6cSuwzLlIlF3aovPjmjBObAj8KPDv4Kamo3SWtGrTv+kFJK4OrRkuYHlVRWFIEi7eEi
 i8IZj+66r72dKjr9TqgKn/fsXvliud0k+i9ArECefrxkZzzQk3hVtfTen7xS0QAhHSA0BWn9OHA
 4lxctgpP+c8IbC3EKWiZx/Jxo1ozr3gUkEK5zW24T2zDJcVKQO9E
X-Google-Smtp-Source: AGHT+IE59NlemO9mbSlYlwUIQeITYgz3NHSKN+YuUyb8CiVzz6WsmfxV/BAnZ9MGEeOqOeelyB/MMg==
X-Received: by 2002:a92:ca0f:0:b0:3d0:4b3d:75ba with SMTP id
 e9e14a558f8ab-3d280764a20mr53567175ab.4.1739738721935; 
 Sun, 16 Feb 2025 12:45:21 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/28] x86: Tidy up the GDT size in start/16.S
Date: Sun, 16 Feb 2025 13:43:59 -0700
Message-ID: <20250216204421.3560012-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

