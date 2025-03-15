Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA78C35FF1
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3222810F4;
	Sat, 15 Mar 2025 23:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dy1obYlA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C748193A; Sat, 15 Mar 2025 23:18:36 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBCF480F70
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22398e09e39so66732095ad.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077112; x=1742681912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1NlGxBkObCp+1sPxyNkQJc1tDVLAMyJMRpZ2sjvG/w=;
 b=Dy1obYlA3sDnymcaR4u1o1qNeYfRtcE0LZqMue36IAluhKlWL7tMPuZ4gevFy7j4oD
 IelEHN7ZsxUAFJmteT/KGdrAVpCFju4Yt6j6K2n0ce4uIM9J7PrrRqOgHCXgPOdvRXgJ
 CP4DFIGr4EDpZ3kkcVp9/5PS8tgb2h6X0pLrINTXhKfpTdatsTZNUxkoCi0ev978NvV3
 kggd242AMzfnY6gPUaArJMMyLv3Ec2nX6X+exjFRBr0/JZtOYTckTTEezFERd50uNHFw
 xA6gyGAciRJHX7miup1MPoIYcpmNlgmPWImy3yXKDmCZZwNNCJ+gwJ6kVZr2fFhkFCZr
 rOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077112; x=1742681912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1NlGxBkObCp+1sPxyNkQJc1tDVLAMyJMRpZ2sjvG/w=;
 b=YLtfm+ZCFaDUtO4Qe0TwxqEHt8W8o7oQleWU9AMAbC3csFzwxQncjvvT79YJcdWBFQ
 vA1CWCfQJ7Uchcayl5TXpB26cX73ACnAdHgylIvd83ttJCH5c8HV4ghoWqA9ByujFI4D
 9V5UvYY6Ko65D9pXo+I6EzuypMGgEycINKRawJn4sLNJ43uSz91J4z0kRQ70kx6tqVUM
 lxXeym5BYTnSk/5j0XgDkFElaOW/fe2hndh7fo6In5e4hqpGe8+eednKT8LDehFRk0iT
 5kOvS3KNOhkiRkr63H5tL96/OX5IbmIGua5zmDFpTdZ1brqmEsiVZwzty9xDCXy2RrV1
 LaKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbCU/HGa6uV4t++ILNbpout5ecEa3NG6h7rUNr5agKrYed/VmAJ9alnv1aYtZkBS485PkKSds=@lists.denx.de
X-Gm-Message-State: AOJu0Yxfwczz0+L2emLwPapNC0/Oj2Lyr6voNi0X9LlMgGugMb3/8aG6
 TCDElQVYk41LhnfQn3EjwsidUOkXxs5MDAjAdgdruPz2j3RfD1dh
X-Gm-Gg: ASbGncuSjD0AXTt1UMz8xxHqEZnqUWmPdt+2H340n67ZeqeWJYj4ChTdbFEx1hjnrmS
 3d0eAX0S/P2MpWwAov7i/XF3w6h/w+kepcHU11j3GiCFomHUcqTZfIFHYogYAUqCdn/DAYi8/5A
 hW7ZVK39nWJrEUlmhpnXFz+2Pmw0q/L25UuCtXjY70nSCvPEiN4TXVXCS7eTpdrlczDA90TAhC7
 zqk8PE+o7V7Wb2I+y+Av1ZdQ3UCB1l54nEfdFhla4gDlMAtawzE3G/PDUBXSHiYayZHZMOJkGKD
 p16Kn18bFNwaBKj8NpkrqE6DRylMHnp3UQ1St/K4Xy9wzobarl/PWCQ=
X-Google-Smtp-Source: AGHT+IHo8vuA6gPZbNkr9VkRbwYJ0IBhXt7HV156OsqxZzFb8QjNUi+NgrGhfdwzihmJnSKMquYLuA==
X-Received: by 2002:a05:6a00:9286:b0:736:a694:1a0c with SMTP id
 d2e1a72fcca58-7372242ec49mr9092939b3a.21.1742077112451; 
 Sat, 15 Mar 2025 15:18:32 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:32 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 11/15] arm: riscv: efi: Export _start symbol from
 crt0_*_efi stubs
Date: Sat, 15 Mar 2025 15:18:09 -0700
Message-ID: <20250315221813.1265193-12-CFSworks@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315221813.1265193-1-CFSworks@gmail.com>
References: <20250315221813.1265193-1-CFSworks@gmail.com>
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

While the _start label is only intended for use locally to populate the
(hand-written) PE header, the linker script includes ENTRY(_start) which
designates it as the entry point in the output ELF, resulting in linker
warnings under some linkers (e.g. LLVM's lld) due to _start not being a
globally-visible symbol. Since  ELF is only an intermediary build
format, and the aforementioned PE header correctly points to _start, the
ENTRY(_start) directive could easily be removed to silence this warning.

However, since some developers who are debugging EFI by analyzing the
intermediary ELF may appreciate having correct entry-point information,
this patch instead promotes the _start labels to global symbols,
silencing the linker warning and making the intermediary ELF reflect the
true entry point.

This patch doesn't affect the final output binaries in any way.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/lib/crt0_aarch64_efi.S | 1 +
 arch/arm/lib/crt0_arm_efi.S     | 1 +
 arch/riscv/lib/crt0_riscv_efi.S | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/lib/crt0_aarch64_efi.S b/arch/arm/lib/crt0_aarch64_efi.S
index e21b54fdbcb..003d5f83041 100644
--- a/arch/arm/lib/crt0_aarch64_efi.S
+++ b/arch/arm/lib/crt0_aarch64_efi.S
@@ -144,6 +144,7 @@ section_table:
 		 IMAGE_SCN_CNT_INITIALIZED_DATA)
 
 	.align		12
+	.globl		_start
 _start:
 	stp		x29, x30, [sp, #-32]!
 	mov		x29, sp
diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
index 235b3a0c48f..593ee1e194a 100644
--- a/arch/arm/lib/crt0_arm_efi.S
+++ b/arch/arm/lib/crt0_arm_efi.S
@@ -143,6 +143,7 @@ section_table:
 		 IMAGE_SCN_CNT_INITIALIZED_DATA)
 
 	.align		12
+	.globl		_start
 _start:
 	stmfd		sp!, {r0-r2, lr}
 
diff --git a/arch/riscv/lib/crt0_riscv_efi.S b/arch/riscv/lib/crt0_riscv_efi.S
index 9eacbe4a859..f170e4b26d6 100644
--- a/arch/riscv/lib/crt0_riscv_efi.S
+++ b/arch/riscv/lib/crt0_riscv_efi.S
@@ -179,6 +179,7 @@ section_table:
 		 IMAGE_SCN_CNT_INITIALIZED_DATA)
 
 	.align		12
+	.globl		_start
 _start:
 	addi		sp, sp, -(SIZE_LONG * 3)
 	SAVE_LONG(a0, 0)
-- 
2.48.1

