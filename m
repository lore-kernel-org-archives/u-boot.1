Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13950C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2617E81A0E;
	Sat, 15 Mar 2025 23:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PtNk1vPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB60A81BEE; Sat, 15 Mar 2025 23:18:37 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABAF810E8
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so943555a91.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077114; x=1742681914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JmYEnZygaDYl10iJdaZbDjupkhGBuIBaksOLX3jHGA=;
 b=PtNk1vPC9bTGoGUNp0OO/5/6KZnjHtfGRRro4KVatIoyEdXexSAL6M1u+yAvBnIfKt
 0cuviVDKessxxc5qHKoidLyq1AHyTsexVqsykZjlnN9ZlrxEi60C7zHvOXFKz0t4weZk
 aEuo5BYz9PaMX5J83GB5FpokCnEXrQuKeaAkVnMorjLV0GoevZNoH9/5Z7VroHIuTbfI
 kzxgDI4vy/Sc+++VZn8RJte+881NHT+AAHR8ZFL3A4dMTWlmE/jrEePg1efz8id4ccij
 5TXamdu7X0ip/9HndcHJAGfM1xwp50QvL7F9Bn8JFbdULv3Eq7pZElJHB+YBNFpfI+SN
 aKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077114; x=1742681914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+JmYEnZygaDYl10iJdaZbDjupkhGBuIBaksOLX3jHGA=;
 b=UajC6Rx+UUC4UAWDp7ISDusWtTh/jOz0DgLprPn9B7rYOa23mIsiRhUIewVXGSJHXz
 Rf/flNTEoKvWcs8dl/B8uqOWkQ3WCxwV0qyakXDSWQPaXOsmP7U1jWhlKOQ4CJLpWb5N
 yWBn7RrljVIbJHpmqDmJs/OORd9PNze2FDpiRt2Nf0zS4NtqMIh31frhNpY6Gauy8VQv
 5e7FCad+LHELLP0kJu4sBzUu6SnSciIgpsH254LC76lq/oabd10XYVwPTgzfu2v/TfcG
 lD344e8e1ubXW1UimyRtVeQiFomlXU4LIsd/14suC7i3bRLCcE9a83T7EwI1Rnulkm/p
 T34w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFRA/XQp5BP29lyl3Vhtuuas42oMlyUUv4e53p5a6RH6o2InJb9D9PmxAYDJ0nHLFGIY5d234=@lists.denx.de
X-Gm-Message-State: AOJu0YxqeVETS9HOF41bM1F8TU3HpvdLJ8VFDEgGfywtPywd6C9Pn6bi
 sW9WVKt8hEDrf8/u01DSKchg0cm4VRHgL/yevvtHAjI3WJy9LoDk
X-Gm-Gg: ASbGncttZE5Uk6hhx40Fo4w/lzDaHCTLRqAFH6biQ1n8GNA7RyJC0sXBW4HZUq2oIQJ
 Y4AQLyTsPa5zifVWavfjr9sb+NSILQ78pFfbhTP+4LqiL6u7I/okryz03n0YK6pkGnkvBpmVCLX
 /fhySQ5pAdhRCajL11IQy7FHxhTsUZwmR3vW9t5X9TbKv3hTUbMlBPA8s2NeWtcBsaHsV6j8sAl
 b9tn9o3WSwM9SXLcNCMckr7twDn8Yq0GN2Q+kqCtX6OpDbpg2RbmR08SGpZBMabDHmn1VnA6Beb
 xtIWZWDAlRF5dGnReIYBYjNekIZoFblO1gQ/z4BiqESjZECzqltraAw=
X-Google-Smtp-Source: AGHT+IHQfgpJ9ZIy2CPyezkQOLzy80aBdKXTLbAcHZuYJNkp+uHrD8n6Ohag/BXiYfzyPDO5MGpeYQ==
X-Received: by 2002:a05:6a21:78a9:b0:1f3:26e5:55bc with SMTP id
 adf61e73a8af0-1f5c132278emr8427216637.42.1742077114086; 
 Sat, 15 Mar 2025 15:18:34 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:33 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 12/15] efi_loader: Move .dynamic out of .text in EFI
Date: Sat, 15 Mar 2025 15:18:10 -0700
Message-ID: <20250315221813.1265193-13-CFSworks@gmail.com>
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

EFI applications need to be relocatable. Ordinarily, this is achieved
through a PE-format .reloc section, but since that requires toolchain
tricks to achieve, U-Boot's EFI applications instead embed ELF-flavored
relocation information and use it for self-relocation; thus, the
.dynamic section needs to be preserved.

Before this patch, it was tacked on to the end of .text, but this was
not proper: A .text section is SHT_PROGBITS, while the .dynamic section
is SHT_DYNAMIC. Attempting to combine them like this creates a section
type mismatch. While GNU ld doesn't seem to complain, LLVM's lld
considers this a fatal linking error.

This patch moves .dynamic out to its own section, so that the output ELF
has the correct types. (They're all mashed together when converting to
binary anyway, so this patch causes no change in the final .efi output.)

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/elf_efi.ldsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/elf_efi.ldsi b/lib/efi_loader/elf_efi.ldsi
index 190a88fb69e..4fa5ca43872 100644
--- a/lib/efi_loader/elf_efi.ldsi
+++ b/lib/efi_loader/elf_efi.ldsi
@@ -21,10 +21,10 @@ SECTIONS
 		*(.gnu.linkonce.t.*)
 		*(.srodata)
 		*(.rodata*)
-		. = ALIGN(16);
-		*(.dynamic);
-		. = ALIGN(512);
 	}
+	. = ALIGN(16);
+	.dynamic : { *(.dynamic) }
+	. = ALIGN(512);
 	.rela.dyn : { *(.rela.dyn) }
 	.rela.plt : { *(.rela.plt) }
 	.rela.got : { *(.rela.got) }
-- 
2.48.1

