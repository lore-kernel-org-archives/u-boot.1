Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED90C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 05:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9BAF82B26;
	Wed, 11 Jun 2025 07:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GSTaniY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091DB82B20; Wed, 11 Jun 2025 07:08:55 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52CB80050
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 07:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-23636167afeso17935165ad.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 22:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749618531; x=1750223331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=6x3BQ+O0VH2D0oEG4/tXZlstrKUfrKr235KysvFdXPE=;
 b=GSTaniY1cb4y5N6XhknvhKIPoo+QTpZQ/4A7OfVJtByced1JJsi7C2Icz1PgVCb/I4
 DTAXU+SJvjvl1NntsH3fawNEJwva52mE3SDO9FEp3XJkB6bpTPO0yWlTIHlWapgqVvA5
 fdlvrPAa6iv/VgcnyzT9J6JmKA3tebd1YWSviwNhnKc8d3FF4XYAyDSEGBgFZfw3mH5T
 gZkTPdWWOul3lyMTwpqyin42drwPa80DZ2g7xLuRKrqR09PAf7Am/npV4FerjTPDa+F/
 tDakApP02+gqwdyvnyFi5vDzyxTosnaELSXPF9I342zgRCVI6I5ZsahJT8OeY2ftxgmM
 J1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749618531; x=1750223331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6x3BQ+O0VH2D0oEG4/tXZlstrKUfrKr235KysvFdXPE=;
 b=xKmnkIbZzemTRYNXBb/MZnyoPnverRbuz5tswcnnnQk2Yl2oyT35h35kUl/nZqGDdV
 MOQSS7cd27a9ojoGdGTqI5BuaxCrLreLnLOPkScx5a+vQ4p7A1dXSOsCek1ELqrbAJVK
 +DPw6rg3+jc/Y8bojFEKUPMnj292X8PYAo7VI6d0StNgrlnDpw4nvmUBTKu6OS6Fn4Ma
 gonpJUz6u7QNaLjE5eMVvEkeR61Zgg7bZPjPm6JgJcZoaR4BYSK2nzqhF0IxhTYJw3N7
 GcGX0xNoIvRooNpppDGX8FAYKv8s/XbDgI6g1VtGc4OP/AVuBcrDXjIEqbdFz6UbdDRl
 kYlQ==
X-Gm-Message-State: AOJu0Yzi00Fx6GbfFPQEtYqkwXh8SCCHPCS1eSpizuacS6n9LRSw6Pfk
 Q/YLy0ksINIXUAg5LijcFu5cmfbJYCWjMqYVUYUFBUMvA99IK12Umm5Hb5yMXg==
X-Gm-Gg: ASbGncu//sz66H2L7tUYx8z7t+9DxwaAEIow5SLGptzF49SCEBBqSAQxk2hoIIEanO4
 1XgNlKBI8GjqbjJTOXS7hTNF9xqeNkiVBCHMtbQVN5XTU/mNfAt0Ya9MyGo9sFEckmko5xQhWOh
 PlpmzbV7WPS0ejVwgsqv3ogIZHkg+/KdSI/vfuWG7amSyt718ezJ6wmsWb249GAko6h0werZ0zw
 wWxJAor3E0vq9Io2elCNkYBOfCMXsmjGAhZ2rm/ruQGCim/mStIhlSV/j27DhV0AC0vmZjR+iqg
 S3bFvv/KvIEaaITLzb9izArZqTJTqPFQri/XH4SzyspJsJZMSbpE6jkS4g==
X-Google-Smtp-Source: AGHT+IEry1VsPzCflr65hRlBrIO7B02q9LxF4LiVH+aXviGs3UnRvh4zMCju9PLcFuLUcbhxyw4MNQ==
X-Received: by 2002:a17:903:98d:b0:234:ef42:5d65 with SMTP id
 d9443c01a7336-23641b265d4mr28553265ad.52.1749618530573; 
 Tue, 10 Jun 2025 22:08:50 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-313b1e82668sm469193a91.0.2025.06.10.22.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 22:08:50 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v5 0/4] Add EFI Debug Support Table feature
Date: Wed, 11 Jun 2025 13:08:39 +0800
Message-ID: <20250611050844.210384-1-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
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

Ying-Chun Liu (PaulLiu) (4):
  efi: add EFI_SYSTEM_TABLE_POINTER for debug
  efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
  lib: efi_loader: efi_memory.c: add efi_realloc() for realloc memory
  efi: add EFI_DEBUG_IMAGE_INFO for debug

 include/efi_api.h                  |  71 +++++++++++
 include/efi_loader.h               |  19 +++
 lib/efi_loader/Kconfig             |   8 ++
 lib/efi_loader/Makefile            |   1 +
 lib/efi_loader/efi_boottime.c      |  11 ++
 lib/efi_loader/efi_debug_support.c | 181 +++++++++++++++++++++++++++++
 lib/efi_loader/efi_memory.c        |  56 +++++++++
 lib/efi_loader/efi_setup.c         |  20 ++++
 8 files changed, 367 insertions(+)
 create mode 100644 lib/efi_loader/efi_debug_support.c

-- 
2.39.5

