Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B318C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 06:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 975B780E9A;
	Thu,  3 Jul 2025 08:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XW/WyBds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BF1E81FEE; Thu,  3 Jul 2025 08:28:20 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 751B881FEE
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 08:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so2926361f8f.2
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 23:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751524097; x=1752128897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=IG5eFMVyDdFNO8tJmQZ+N2t/mEoV2f8enMt9Q2RPDCY=;
 b=XW/WyBdsbotzWbQUBq+HeebrSVK6d0vlb/oJ7wr/4zU5SSOVhXmCQCyGi+G9KGN+dL
 JpayFq5wc4xHAmlyBmEreLk3jAWYNcLSQv/xKwed0jzQ9sRpHQx6VXZQxmXcr6yB4nC7
 9Hy7E/Prb3wveVxjtpsKjNgtwux68gET50bk5lZwqYsOk7rgyR+RcmsyQq4AzjXbEuSg
 u/YjFSNqvycJ8eWfdreR5eQ5qApE8FAXfe2V05rNZmap+Motws9Vw6V8rj0EW9SbpJS3
 VNfDdAavKypH7nGHYaVHJS9ZmZc7shWF2UJy8yQUWff9wsZbIG+nEHrUIF/QBVjnAWJN
 RlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751524097; x=1752128897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IG5eFMVyDdFNO8tJmQZ+N2t/mEoV2f8enMt9Q2RPDCY=;
 b=YvoMBDFv8Q2xRh1GCRtNbEePVqpFRFoNPs8tNFlR1VsRUFRa5adFR0E4v7Yu6yyXgG
 GEg26fMaQjlA/P4TqVdtSIkX6fzCs8M6uErmxm0Luww/Ddpq3eDHwDOaz07powcgWy+3
 KhnA2kEizqpaYBYoQzz+P9tGkPHz/CXkJHjV/rtEUHrj1+HY02y0WwrAgjsKtV1gZ6QB
 hBVo+ujVURmNUxtRI1w8NVWeXk0AXoEIcT7nPhI158kbt4ZoCHrd9mgGDcFpyCeUCOHK
 Cr1khmPARpkq2bX1TWVp1ayD8O0WzSp/KJKXAFiAX2eH9IA7c4LD3csVluj5F72/kMj+
 Anvg==
X-Gm-Message-State: AOJu0Yz3S/pYv/vzTnYhqTWqjVhSsjw5uwV7P+hVtInQ/Dj9GdjofOba
 1tNlMKMtlmu6P6JON2g/LEr87HNEU3cmhsiRN5Ftf0dsJEDpzGIb4gzK1jC1WsVv
X-Gm-Gg: ASbGncuX37FvJdkpU9lYZScyRxL5yQka640i/0vJyjBjJ+hzxMCXjl16nLXyLtx4FFM
 hK0qW+QSSiaVRidyAyylXnbUEg2xF7fnWVkVwZ5YTH0KL6hilWKfM4P2sOSs7jhSwC2rvsKhiB1
 q3INEH0nLolIKC1WCpRQK6zmgUBVuXnoqhLH2rFis1Z0ArwVCuyG7oR0/H9xyhuKoQrU+Hs1X0H
 ZpU/AeB9+bPRSdknHDAmcnPaTWnQ7t/GFV/9lqdnXt9XXrqPBa32gH1yaAS71SZs8gsublC/CFS
 q8AvuTOlVkBXIxJ0oDQ37dCV7mW5X1vYHXWv2NmqsrRxDL9nSUtBFqKDir8WRg==
X-Google-Smtp-Source: AGHT+IERitZ+XFc6AgwIOG3H2G3uNP9SJme7i3JhmRraK0dpCSKuToSrB16RdzvltTWtwhQXJdXtMA==
X-Received: by 2002:a05:6000:4a19:b0:3a5:2b75:56cc with SMTP id
 ffacd0b85a97d-3b32c758856mr1542260f8f.23.1751524097340; 
 Wed, 02 Jul 2025 23:28:17 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e595d1sm17939618f8f.71.2025.07.02.23.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 23:28:16 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v8 0/5] Add EFI Debug Support Table feature
Date: Thu,  3 Jul 2025 07:28:06 +0100
Message-Id: <20250703062811.72871-1-paulliu@debian.org>
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
V8: Fix casting which causes qemu_arm build failure. Fix selftest. Fix Kconfig
    to enable building on more targets.

Ying-Chun Liu (PaulLiu) (5):
  efi: add EFI_SYSTEM_TABLE_POINTER for debug
  efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
  lib: efi_loader: efi_memory.c: add efi_realloc() for realloc memory
  efi: add EFI_DEBUG_IMAGE_INFO for debug
  efi: selftest: add selftest for EFI_DEBUG_SUPPORT

 include/efi_api.h                             |  71 +++++++
 include/efi_loader.h                          |  19 ++
 lib/efi_loader/Kconfig                        |   9 +
 lib/efi_loader/Makefile                       |   1 +
 lib/efi_loader/efi_boottime.c                 |   7 +
 lib/efi_loader/efi_debug_support.c            | 183 ++++++++++++++++++
 lib/efi_loader/efi_memory.c                   |  58 ++++++
 lib/efi_loader/efi_setup.c                    |  18 ++
 lib/efi_selftest/Makefile                     |   2 +
 lib/efi_selftest/efi_selftest_debug_support.c |  40 ++++
 10 files changed, 408 insertions(+)
 create mode 100644 lib/efi_loader/efi_debug_support.c
 create mode 100644 lib/efi_selftest/efi_selftest_debug_support.c

-- 
2.39.5

