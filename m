Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BEDC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 11:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 174558033D;
	Thu, 16 Jan 2025 12:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KFTuY06l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A403A80214; Thu, 16 Jan 2025 12:39:30 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA1868033D
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 12:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0EA7A3FACF
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737027565;
 bh=XWgNEPBl9wrZi/qwUSu5mf/ZQkBdptdL1WS9lW2HYp0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=KFTuY06lvy9KhBrMNvQScbhVX6GpAH39W9gNWH/3Yage5/MYaUC/ihGPqgbjUwLKB
 En27lW9Su7IM4XTlv4Cd5yzedQ5DvYr8WaMaPoKj8ZRQVb3eTYJPy7ZFS+K/ginQ14
 t3DiZ+1tMqcep6nq78T4HmgJRUGc1sbRUIFyZOe6GrmfSTwcntApBJV/ek3AooBL7G
 Gt977iHRuQdqTWMxME1SiffXvfZIBghjxyIzP0TxQkYTLK0XGt1p+NGeOQ1AZrQFf/
 3esjVl+DZIrDyWlX6vYqLTvcStxGmbrNTRC2VV80/SzRkbXkCynmB7DrVe8LLoxPDG
 XUFf4SqE9zIxw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361d4e8359so5118545e9.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 03:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737027563; x=1737632363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWgNEPBl9wrZi/qwUSu5mf/ZQkBdptdL1WS9lW2HYp0=;
 b=SmsqCtVrs36WHyWN0UTOJwCqVHa46/T3EcR9wnP1y+lcGs3tqHXEKSEaZBOW7UY1nB
 /rY28KwQ+3fcPlshLmG/XtDZsPGRUFF/hU2jBnaRjDsg2csENACUI+YFRV5OgrQcQ0T4
 bPTMD60vPo7N6LiEqeD8cHWgFuCVT3677WV7RF79TRvVjnzU0W1iABjBAsdilz6uHJEf
 b3e+HrZKkeURwdJUZoAXeF7goSeCx+YlKUQL99KWBem8oB58xgppPzZirXhfiR/z13rd
 XfaE0isQ7nx6/VKlaboq1x0rsnqBN5R5eIXE3ObafgxIrzMgrq7NgMrhdrIOZsu81dTU
 pBmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ7v7PH0EQfPgUdpasxAc2ooP1xi74/f7kBxDXCB6OtumFMGduhBS/XiKiLMYQ6b37aEfY/MA=@lists.denx.de
X-Gm-Message-State: AOJu0YxdUjw2LR4XF08AFiHGxbIZBjfYjDyUseLbHeZG8x/7dUF4aBEI
 82HePdmzAfCCUWIVqtWlUMgtVigvXy0B3BMuP1EuZP8C+ls6VH0PBNFFRx8c+RwvxhzwsS0FEZk
 BrRjQZR9sxWnxSUrBrktGXbonP19jAPYqgLd3hFEQN1aJ5aeCrl3+1F/Kj6C/JKh0aMI=
X-Gm-Gg: ASbGncuZdfohwYRKPGKl8WNRqg7pGBGlW/ROZWjHs35rDPn0ZqOjM7L2iydETXLyEvu
 Fpy8Dj6PUwg2vk2i3s31NrKhTXWTA/WrkBda1gOChDMHI/bXnCjKJBp4rLY5cjs+1ewFDE5SKMb
 0yjZPVEaU8YwxpzWzrGvuGXoLSqCL5/EVcps02lqg0Vv1wGaSRsP8FYtVCTr454tvbmG6JHyt1e
 RaT031OiLPihRzKngyJfZE2M9DleXCkbj+gaX2YiSx3PgekR2sE7hQWUMXz/hNL1C34F/0HGF2j
 AO9TOxZ3SzrQbw==
X-Received: by 2002:a05:600c:45c3:b0:434:a90b:94fe with SMTP id
 5b1f17b1804b1-436e26c3c3fmr338799815e9.10.1737027562792; 
 Thu, 16 Jan 2025 03:39:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgp4mKPDaLgmwYWNKRiHFd3dehp0As0+jTTtKOZfYXK2eyURBpPQmS52mnPAp3sjUxyKE04w==
X-Received: by 2002:a05:600c:45c3:b0:434:a90b:94fe with SMTP id
 5b1f17b1804b1-436e26c3c3fmr338799465e9.10.1737027562389; 
 Thu, 16 Jan 2025 03:39:22 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3840bfsm20606320f8f.39.2025.01.16.03.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 03:39:21 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 5/5] efi_loader: use include in ARM EFI linker script
Date: Thu, 16 Jan 2025 12:39:09 +0100
Message-ID: <20250116113909.113950-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116113909.113950-1-heinrich.schuchardt@canonical.com>
References: <20250116113909.113950-1-heinrich.schuchardt@canonical.com>
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

Use the same include as arm64 for the linker script.

Adjust the 32-bit ARM PE-COFF header accordingly and harmonize it with the
64-bit ARM header.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Do not rename field image_base to ImageBase.
	Move SizeOfCode change to separate patch.
---
 arch/arm/lib/crt0_arm_efi.S  |  9 +++--
 arch/arm/lib/elf_arm_efi.lds | 71 +-----------------------------------
 2 files changed, 6 insertions(+), 74 deletions(-)

diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
index 3664cce8412..91b0fe12c51 100644
--- a/arch/arm/lib/crt0_arm_efi.S
+++ b/arch/arm/lib/crt0_arm_efi.S
@@ -46,8 +46,8 @@ optional_header:
 	.long	0				/* BaseOfData */
 
 extra_header_fields:
-	.long	0				/* image_base */
-	.long	0x200				/* SectionAlignment */
+	.long	0				/* ImageBase */
+	.long	0x1000				/* SectionAlignment */
 	.long	0x200				/* FileAlignment */
 	.short	0				/* MajorOperatingSystemVersion */
 	.short	0				/* MinorOperatingSystemVersion */
@@ -84,6 +84,7 @@ extra_header_fields:
 	.quad	0				/* CertificationTable */
 	.quad	0				/* BaseRelocationTable */
 
+	/* Section table */
 section_table:
 
 	/*
@@ -111,9 +112,9 @@ section_table:
 	.byte	0
 	.byte	0
 	.byte	0			/* end of 0 padding of section name */
-	.long	_text_size		/* VirtualSize */
+	.long	_etext - _start		/* VirtualSize */
 	.long	_start - image_base	/* VirtualAddress */
-	.long	_text_size		/* SizeOfRawData */
+	.long	_etext - _start		/* SizeOfRawData */
 	.long	_start - image_base	/* PointerToRawData */
 	.long	0			/* PointerToRelocations */
 	.long	0			/* PointerToLineNumbers */
diff --git a/arch/arm/lib/elf_arm_efi.lds b/arch/arm/lib/elf_arm_efi.lds
index 41440594aa6..eb16fae74cf 100644
--- a/arch/arm/lib/elf_arm_efi.lds
+++ b/arch/arm/lib/elf_arm_efi.lds
@@ -8,73 +8,4 @@
 OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
 OUTPUT_ARCH(arm)
 
-PHDRS
-{
-	data PT_LOAD FLAGS(3); /* PF_W | PF_X */
-}
-
-ENTRY(_start)
-SECTIONS
-{
-	.text 0x0 : {
-		_text = .;
-		*(.text.head)
-		*(.text)
-		*(.text.*)
-		*(.gnu.linkonce.t.*)
-		*(.srodata)
-		*(.rodata*)
-		. = ALIGN(16);
-		*(.dynamic);
-		. = ALIGN(512);
-	}
-	_etext = .;
-	_text_size = . - _text;
-	. = ALIGN(4096);
-	.data : {
-		_data = .;
-		*(.sdata)
-		*(.data)
-		*(.data1)
-		*(.data.*)
-		*(.got.plt)
-		*(.got)
-
-		/*
-		 * The EFI loader doesn't seem to like a .bss section, so we
-		 * stick it all into .data:
-		 */
-		. = ALIGN(16);
-		_bss = .;
-		*(.sbss)
-		*(.scommon)
-		*(.dynbss)
-		*(.bss)
-		*(.bss.*)
-		*(COMMON)
-		. = ALIGN(512);
-		_bss_end = .;
-		_edata = .;
-	} :data
-	_data_size = . - _data;
-
-	/DISCARD/ : {
-		/*
-		 * We don't support relocations. These would have to be
-		 * translated from ELF to PE format and added to the .reloc
-		 * section.
-		 */
-		*(.rel.dyn)
-		*(.rel.plt)
-		*(.rel.got)
-		*(.rel.data)
-		*(.rel.data*)
-		*(.rel.reloc)
-		*(.eh_frame)
-		*(.note.GNU-stack)
-		*(.dynsym)
-		*(.dynstr)
-		*(.note.gnu.build-id)
-		*(.comment)
-	}
-}
+INCLUDE lib/efi_loader/elf_efi.ldsi
-- 
2.47.1

