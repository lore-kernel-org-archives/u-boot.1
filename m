Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2971C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69387810F2;
	Tue, 25 Feb 2025 00:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DCpILlRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E189810F4; Tue, 25 Feb 2025 00:07:32 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37CFC80FD1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-855a7e3be3fso354859439f.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438447; x=1741043247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/I+YsWmD57JmEgspLMSrGHa8l+bjENXNCyTdNebzy8=;
 b=DCpILlRgnMw5VSKIJc5HhIchaN/tW5gSMnNAf6KJjAHL+8jtSkjKvQ1DmHqaVJKpUN
 J3AFcsIWuj9kI1/0zbJS0ACtTvId04ke8fuLfYepo7l3XRDF0lmkPxnSEx9/s0fQd0ed
 s0iENjk7fZpnwFfx0m88WFneIu9kFARawXpdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438447; x=1741043247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/I+YsWmD57JmEgspLMSrGHa8l+bjENXNCyTdNebzy8=;
 b=rsm2Neh//QHrdRMS7OiLbhsaWXrvoEE/tXu2Q7wn+p+sB5H/09fzOTlOi7nSAGE07u
 tT1nvr7JYfos3RHq8mykOPARF2+ME0eC5usQebCDuK2QXeA0pijhyVqv61IZhEi0U0MB
 MhVD3MQfV377aIurK3f2nUPkdaEHTW4m2cXcmlZxlqu9lRYsMJeTwc8VjaUvtdG+J1Ta
 AKY4bn0qyFaDiuOIc10Z4Glk+nKaTbFDTMdbC4yoehe6RwpZe7xP/FEms1Wy7vQuvzPx
 FdoEM40/Cn7K63M1ln5QsdLpV9rgtIYS08t/WJOkJD5rvuG2/gcbqKbhPoD3ZUllLdqT
 X0Hg==
X-Gm-Message-State: AOJu0Yw1IMIaVmU78xz+LOUAvoRT7SxnZgD//HnmrtQAK65O/qGOluzL
 GMhQagANa8gX9aiKY4PT3a4jY3ghGoBuqEpOq9xJgZus2YzBGWRtnphcJ2yaFtXHfuqA6kILEXI
 =
X-Gm-Gg: ASbGncsNUCjCV7eIPbrPP+L74yowfDor9jgm1hsuFi4bAETzjN+Rc5n/jMw6oRMhZOk
 q555bfjgHNer0eOFECkWvereuvnxypuL5kzSxdy5j1wnJL2ijHirTrrYaUlh3gmgeIOqIejamZT
 0Jukfjj3kbxa8QbdXX10wdzr8KBoTOr+3J55GCAy03H/bsZHXfN3qXjoEUqt5OmIkg1ESBYZGSE
 Skh9qJ3EkYB+azgZTBfhzLyiHoI54l7f94G5j+C36MCqsE7AuUWqfxaqCvfU37889c26zCwHj6O
 nci/YQXtL6BdcdcEXq4TvQw+RVI/x2xmdltKBoFeyBX6JKXTl+qTqCr/qIOS8Zo=
X-Google-Smtp-Source: AGHT+IGtZmcOtnkyrVE3YlxW36yRplGRjqhDU3dieBymkRJfVIxPj8F1NFz8blDfS1xyDq63e57TLg==
X-Received: by 2002:a05:6602:2dc9:b0:855:b1bb:1bd4 with SMTP id
 ca18e2360f4ac-855da9be4d8mr1724905339f.1.1740438447101; 
 Mon, 24 Feb 2025 15:07:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 14/44] x86: Tidy up the GDT size in start/16.S
Date: Mon, 24 Feb 2025 16:06:03 -0700
Message-ID: <20250224230640.2665206-15-sjg@chromium.org>
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

