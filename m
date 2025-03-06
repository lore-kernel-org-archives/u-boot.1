Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F72C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1088C8191C;
	Thu,  6 Mar 2025 17:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h12M4V8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C612805D7; Thu,  6 Mar 2025 17:05:23 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5154D81879
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85ada0cf40fso22204039f.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277119; x=1741881919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/I+YsWmD57JmEgspLMSrGHa8l+bjENXNCyTdNebzy8=;
 b=h12M4V8AisytPLFVYzT6a3q+5GZccebjDiReyxxvS0N/A356lW8ZOqxAtCLz+L3eeF
 jPVgekoohJGmlPxkQTCxyz4T5ufZ4cXoFeUSGGaZzv8MYy5ysARLGKd8sQdFV7h19fcH
 sUnIeo0GIEjQa74U/rIrxmZVbGSjrenxJ+16Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277119; x=1741881919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/I+YsWmD57JmEgspLMSrGHa8l+bjENXNCyTdNebzy8=;
 b=KqbE6svbhadP5p2bKQ1S47JGZBSCyDt7Q3NMIYrc5SxYGRQ0APBhWcOBNdXEVd+Iv/
 gLHvceVsPu+lTWXZEcs9oGkFqIo/RwIKJ1eJr23o7IcgUxReuucdrivkRXfDZERojAR9
 vV4RHL9WXcExorB++qfSGRH7eAELZHjRBe5u/9kzKgC+1g4OQEOWuSdiE5WT10q2Lsrt
 XB2grRkAf8IqxyvPHAF3h/s6GgLx1rlLqbjDW4jy8XvTZpnCVUulIN5IdVJjs9Y8hIrU
 p04cYi7nV+tBxL1+UJWAPeEZikw19Z7bmyXPtUVpIsJs1V18VLmLrRRKK36VtDSaTaCV
 7WnQ==
X-Gm-Message-State: AOJu0YzlxgEORc3qFMz8Ttlti7vFGor3uHbamBrDbwAqEojJdQAhih2n
 u521UX7ZuvP1yJm+Rc3GreJ8T6q4eppJ7MjoH4EUIbof51NnDkeMYlSBay4+lHPVUg+IhFwCll8
 =
X-Gm-Gg: ASbGncvR7ddF3g7PLMIhm4gO5ZABQByfmnhyI5MJ/wzWsCFcYnprIqLa9PS09QA0QYn
 6wixojo7pIzu/dpBEnn9rll+Ti6UD5UFIWjcItmlAlYcG5jyDlMy4qfJBJQOzQaQdGx8rPGcUIU
 QGToC6EV9J1E/FIDBSZYcEEYDwsCdHvBE8jc3MEfBCCLfV7cg7PKcqCNekNVSC7Z43cLBQONZik
 MgsjtwgE+pOh4Xd0wuQXdxKWKxXxbl2nhSVXbjXTBR1TNXsij0YZhT3bHIDx49l5qECLSzvocoG
 rjYq7+gayA4Xi0ndPfJcugFldO8+l78F2iKNGDBocgUT/HAqiClS9aqFrII28wMMXAFn3WJRVyV
 nmaKWrQ==
X-Google-Smtp-Source: AGHT+IES12+PjBptPp9XT57+xOohbt/DnTij9IsmPnV6h1uDXX1JuyLzoI5RWnOL1EloZMGht3EsjQ==
X-Received: by 2002:a05:6e02:1c0b:b0:3a7:87f2:b010 with SMTP id
 e9e14a558f8ab-3d4419712a9mr200745ab.5.1741277119470; 
 Thu, 06 Mar 2025 08:05:19 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 16/47] x86: Tidy up the GDT size in start/16.S
Date: Thu,  6 Mar 2025 09:03:43 -0700
Message-ID: <20250306160428.3041057-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

