Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25296C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 12:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E1F482CBC;
	Tue, 17 Jun 2025 14:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MCAD7EOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2437682CFA; Tue, 17 Jun 2025 14:09:10 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7257582BA1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 14:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so4778565f8f.3
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 05:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750162145; x=1750766945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHDo/2ai+Zzt+115SnB54cjGekDxgyAGB34SAek4SJM=;
 b=MCAD7EOUfH/H5dvUOHwv+HOlSOlMokisSA7BX2JteT0UhSPrl4Y396HWALguIUahas
 5Lv2O+gV4dH6nA6UU7G2z4ZJWdi0LTgIIkNUFUMTg6gECxXDfqylTeQB6KmSdDnW2G5z
 LxeSP7Eoq8foGAY/V3GS3+FaR0AB63QhsIVnt30uOJcaXDeHb9RbhPo5TAXr7DHFt7dd
 FLQRHp5lXhdnAs0xlkRJWuQ9NPrKmE9eHv3PULPeMtlMiSD5tjEbBmyczWE7+NVGcMuQ
 5fftf867eW2jfHrurzMfGEWdFCNO9dqM+6JATxAJnUyvW0yOfk9n8XzfO3umDiZSEmNl
 NHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750162145; x=1750766945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHDo/2ai+Zzt+115SnB54cjGekDxgyAGB34SAek4SJM=;
 b=doy5ZhVizXQDug/Gq3ruDYVcm6GLx1bvqkm1ZT1OzlARVZ/XdpctaVZYiteWeXKmB8
 e7aAZwJFF1DqbMEg3ZJyEMkahXccVtL9pH1cpbD0Yz5/aHoLXgWGr0t1/81DAPQvI3uM
 E9FJzJbLg0zxtpGRaUXn0PPvlDTL6YLRaTx6txzNNzGIEJUpxeaIOUzSWTewQG/nqIKX
 /zammoa8836am4brQOxAtQ/Mgo5e6fF5dkJkCQTP/+iawNHpr4j7VHPe08iDyhrTDbVu
 h4qYzzAzeoKRtbbNctzwETLS6DOI8+rK+JCmXpOspcADyjN1L+wsayOiW5lHpHMVAM4l
 y+WA==
X-Gm-Message-State: AOJu0Yye08ibIPXgk1BNpbNmez8AffQ34S5FtPdQ0H1QG2F6YKGiczZr
 Hh7j3FvejMEGaLhUTLVV15WUBx8b9adXI2gMH2ZF2GJz25ef5Bs4HFul7iKuNM2y
X-Gm-Gg: ASbGncvTplNe4hv8V9/pou4P3vdrvFVNiO2wSXsXfGtzswFU8Q/o8p7D84pzKWFsi82
 uS2+jnRo7t9rvLMcZJ4hy/KNxfEYlQsTqByr4BUSoUBjFfXwkdj28RLKlGPPYTsc6kZlfYtkz18
 6R/nK9OI4IY8vlOAVYxw+bXaASHzFJwPKhliRIvPNophrq9wQd4h+JZ43HHBqr3MrrwQD0Jq6zi
 WjzzbP8I3BOXK6FzUrwWPjcG3x7FWSJX46iV1G14o7V2ex1L6S1pT7Asu95JOhmk7oehkMFQBfk
 VA8MSV4/ANmyNn82eLpyoNgHOEBy7MLV29LsjqILAubbaAlpw6hSqMF6phwcmg==
X-Google-Smtp-Source: AGHT+IHLqZJJtCmfKUDeEi7Umc6zHoKg4fQnGOWNKDl1YJza3SbpwUXp2wh1w8m3VLAEM3t1EdkOwg==
X-Received: by 2002:a5d:5f4e:0:b0:3a4:f893:3f03 with SMTP id
 ffacd0b85a97d-3a572e79692mr9249140f8f.45.1750162145328; 
 Tue, 17 Jun 2025 05:09:05 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a54423sm13485758f8f.20.2025.06.17.05.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 05:09:04 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v6 0/4] Add EFI Debug Support Table feature
Date: Tue, 17 Jun 2025 13:08:51 +0100
Message-Id: <20250617120855.87492-1-paulliu@debian.org>
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

Ying-Chun Liu (PaulLiu) (4):
  efi: add EFI_SYSTEM_TABLE_POINTER for debug
  efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
  lib: efi_loader: efi_memory.c: add efi_realloc() for realloc memory
  efi: add EFI_DEBUG_IMAGE_INFO for debug

 include/efi_api.h                  |  71 +++++++++++
 include/efi_loader.h               |  19 +++
 lib/efi_loader/Kconfig             |   8 ++
 lib/efi_loader/Makefile            |   1 +
 lib/efi_loader/efi_boottime.c      |   8 ++
 lib/efi_loader/efi_debug_support.c | 189 +++++++++++++++++++++++++++++
 lib/efi_loader/efi_memory.c        |  58 +++++++++
 lib/efi_loader/efi_setup.c         |  20 +++
 8 files changed, 374 insertions(+)
 create mode 100644 lib/efi_loader/efi_debug_support.c

-- 
2.39.5

