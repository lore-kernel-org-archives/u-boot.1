Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A623BC7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 03:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C590A82E27;
	Tue,  1 Jul 2025 05:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="leTylbDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF7382E27; Tue,  1 Jul 2025 05:49:38 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD1AB8006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 05:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so3732801f8f.2
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751341773; x=1751946573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=nzYtu7qTYgjXDk9/TQlc3S3ju1i44cODTOohjui3c90=;
 b=leTylbDSDJLJ0a+rzvPsz1dPaR9nb28LymqiwRhatC9CdCW74NdHM6Ag8lsK7c3uNR
 g+nBoVSoisckGY+HlgqQvJpQRImz765ZrcE9d1F0xUnM+LKWahfjhvyVL07rVCMbjMUL
 qaiZz5G3d/7djrOqQCiseYVrraAq7EwkdsE2boesPQO/xVJuGStYM53ZPy475DEyu3EU
 341b8nxm2nbGJnTm+9zClByswF3QTHNr5CvbZfzIFj3BbtvCWdqguKArAhUEuyi6QaOu
 fOsLHCPKfesjslV01e8/gWygewKPzIBAutctWZAXAcS/3u5S7p4tDtPsyChXcOFQBBHX
 VFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751341773; x=1751946573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzYtu7qTYgjXDk9/TQlc3S3ju1i44cODTOohjui3c90=;
 b=UOTBPiBWr9Xktzv5TUy8XAW33zfCw4HVUCw7iPaB7FDeeWzCnefplomHlft5qC0tJ5
 bQc1J0zCWQYZ988thiyB4cl+bfhURQZKCK+C2WMIASoO8ck9xDfLDrQmfJHfN62Dfprh
 jRIparqKthTP6urAphzzjfI20zmXh1O/3i1Ra/JAIhD07LXEWKSN3zSuWeb7W5mUoFTz
 khUTkMhtHsm4Q3s1ecHwhP/PB30PcnITqwQ+eRgD4j9RTJ11gM9MgkZXHJj88N1/5ob1
 ulgn84lS35YI8zVs1MYye2tBdynyH0LgA5cMkOKh0f1ZGHTHyY3OkDckWvV7+/aq4xX3
 kJ4A==
X-Gm-Message-State: AOJu0YyqbIuI+yBUwi3zFh5xFcsyLZT7u16E46AquPZQFDrimmxAwMbQ
 s9saY8poP2HApQ1ng4EXLWHOD589JlJDYLslZpK2w/PwCqIsRdcwDZlQjastWA2v
X-Gm-Gg: ASbGnct9Fr9bSKe5nFSSmhBVrR4E6h6e1fDYw1FTauZGTHFlROU4RkkOtt4stHfVpIa
 Im9bmQNA236G6wiBg9DhjQzMFTRYxHiNVm/JkE8s34UOgFqDsqG3z1VyYUxprwL9ofxERL84XQY
 eNuwcmVifgc5NNF4IrhcEasI9MqBz/dAgUfhmcywCcTGivM9IABGVm7ocA1jUECIP3JL5a4f2Zj
 jSCqjCYS4+gov4yuA4fbeBvZfW3CwPaArWHvw8tH9ZdmKeXqs/Y/tT2DYhxsyplo3iCZ0uNwYzZ
 WNQJ6QZfdG9elUH17mwUnsXgDx85wx49NGvz2JpfgLvav2CcMfhLnJgcq1bglbOVPRqp+jSQ
X-Google-Smtp-Source: AGHT+IGqo8bkHLnHZU71JGVAFSoclFI6pIKRSSvFY3fb/76ltmE48TiyMAarUM+u2Duelem018byBA==
X-Received: by 2002:a05:6000:402a:b0:3a5:300d:5e17 with SMTP id
 ffacd0b85a97d-3a917603734mr13909709f8f.29.1751341772433; 
 Mon, 30 Jun 2025 20:49:32 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52a5asm12077347f8f.54.2025.06.30.20.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 20:49:32 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v7 0/6] Add EFI Debug Support Table feature
Date: Tue,  1 Jul 2025 04:49:20 +0100
Message-Id: <20250701034926.83536-1-paulliu@debian.org>
X-Mailer: git-send-email 2.39.5
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

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

I implemented the UEFI Specification version 2.10, specifically focusing on
the functionality described in Section 18.4, which details the EFI Debug
Support Table feature. This implementation ensures support for
hardware-assisted debugging and provides a standardized mechanism for
debuggers to discover and interact with system-level debug resources.

V2: add Kconfig options to turn on/off this feature.
V3: Fix the way of removing debug_image_info.
V4: Fix efi_realloc return failure code and efi_alloc_aligned_pages() for
    system_table_pointer.
V5: Fix function comments and move the code into a separate module.
V6: Fix error handling. Refine the code.
V7: Add unittest

Ying-Chun Liu (PaulLiu) (6):
  efi: add EFI_SYSTEM_TABLE_POINTER for debug
  efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
  lib: efi_loader: efi_memory.c: add efi_realloc() for realloc memory
  efi: add EFI_DEBUG_IMAGE_INFO for debug
  efi: selftest: add selftest for EFI_DEBUG_SUPPORT
  configs: sandbox_defconfig: enable CONFIG_EFI_DEBUG_SUPPORT

 configs/sandbox_defconfig                     |   1 +
 include/efi_api.h                             |  71 +++++++
 include/efi_loader.h                          |  19 ++
 lib/efi_loader/Kconfig                        |   8 +
 lib/efi_loader/Makefile                       |   1 +
 lib/efi_loader/efi_boottime.c                 |   7 +
 lib/efi_loader/efi_debug_support.c            | 183 ++++++++++++++++++
 lib/efi_loader/efi_memory.c                   |  58 ++++++
 lib/efi_loader/efi_setup.c                    |  18 ++
 lib/efi_selftest/Makefile                     |   2 +
 lib/efi_selftest/efi_selftest_debug_support.c |  58 ++++++
 11 files changed, 426 insertions(+)
 create mode 100644 lib/efi_loader/efi_debug_support.c
 create mode 100644 lib/efi_selftest/efi_selftest_debug_support.c

-- 
2.39.5

