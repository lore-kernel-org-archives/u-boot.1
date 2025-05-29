Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10477C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 04:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D153A835CE;
	Thu, 29 May 2025 06:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BYx8itfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE6A8354B; Thu, 29 May 2025 06:05:35 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB878354B
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 06:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso303443b3a.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 21:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748491530; x=1749096330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=Iwhh+u2PpZJJqbqISwQAoOlVl7I7H7XyoQlcJ1YnWm8=;
 b=BYx8itfmUBCTkj0FWQwLxa+0lII2Eo6SY4sAvhtn5wJzrqDfVd96fI8rSAyTnJNpE5
 Tdpc01fu/wBxaHl5jwr7XGHd/eSnFqd/1z7Uf6PnATQbCDjg6i4K3ryvv+gOtBgi9frp
 HTPKqJjJclA8wm7YVhzVtkijXI7pxIARC7/J5pZms+Niq9NFAmtlXlF+65ccb7aJyrxY
 eSLUz6+ep7ubgytHcEX/pqcZ43B7QphFLJn8r7Gv1jIiH/y9pEVi2JifXIIqeDfJIioT
 JaM/ssEVVkEqdrvKe1EtW4mVuvrwJbiN8p4IPwwXOYJ2r1LLa9QsGDfsIkpa86F3UXIt
 GV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748491530; x=1749096330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iwhh+u2PpZJJqbqISwQAoOlVl7I7H7XyoQlcJ1YnWm8=;
 b=rWVkjzZJgOnju331MQabjuWulfZvzR9RT8NoKv/EQVYkO6r8SOYUfSP465aHSVIsqv
 xuu0tmaUaRQbq3N+HkgGHlBVou6xZ7RqS9OLQKcjYwM0x8QLNn8Z8jnP7rzhph0m/M2U
 Ve77sNX1W+AhOddjNlKgOmcyqFQHg0FilBW5yxYRrxFrEbhnijUxnI3C+QslAmALUarg
 KwoYRtabEDIP2fuSjUEJLCE2qiq8Wjkv6LxfhgXFeQgOtBN3v4kTtIamHd/RO3rRrwrL
 QVHQ/IksjEPGVuQebFazAfbaw87nivFcoJXLGVuFprUEhhe9EcR51HqBsJL8FYp8Fd9j
 nb8A==
X-Gm-Message-State: AOJu0YwWQI/yqwvjyKsWj28gDm4QniFknzin34SBzaQsryMzgbJoO/HH
 /7KQwfJZc2AlpEFylCeZwrwSb1Bt2zpm5Ivl4gkQOZmsYpAr6u9j9jLwfur40w==
X-Gm-Gg: ASbGncv2V0YnEULexiRJWd7E+kfXble8WrQ9cEWQ6vXqOGjy5bcXfRMUYHkpTyu31bK
 YQzX5URcOQU/6aezlHSRcwaeLqxXfiyPy+HYluzxmg7EhCdJTHoVbT9hJyeoUI0GbFC0nDHM54h
 kYHlrM5OQ0GcW1bLXCEmSEPcJklylK1+XdyEWjuziZBx5CVWReS1lRjhMj0w29gEk9DMMNsoLm0
 6tz6M+AQKmo+38ywDoATmZobCPZqn3l+ZISx9e3cv6MpyfoN6pv412CYdNst6wg5kzxdOszplc2
 eYjv/42CIOrMUrVWATfWrEpgTOSaGxNoX5pylTSzKUZQBIk=
X-Google-Smtp-Source: AGHT+IHSO1TTRnZr2Z8kpVbZNNUK4pPgVR8wHVXpELGj/S6s6iLSLrvPNnsNU8pATPVl6kKqW6O2aw==
X-Received: by 2002:a05:6a00:6f1b:b0:746:2706:a7fc with SMTP id
 d2e1a72fcca58-7462706a9a7mr13561435b3a.12.1748491530238; 
 Wed, 28 May 2025 21:05:30 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-747affafad4sm392143b3a.116.2025.05.28.21.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 21:05:29 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v4 0/4] Add EFI Debug Support Table feature
Date: Thu, 29 May 2025 12:05:16 +0800
Message-ID: <20250529040520.3799600-1-paulliu@debian.org>
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

Ying-Chun Liu (PaulLiu) (4):
  efi: add EFI_SYSTEM_TABLE_POINTER for debug
  efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
  lib: efi_loader: efi_memory.c: add efi_realloc() for realloc memory
  efi: add EFI_DEBUG_IMAGE_INFO for debug

 include/efi_api.h             |  71 ++++++++++++++
 include/efi_loader.h          |  19 ++++
 lib/efi_loader/Kconfig        |   7 ++
 lib/efi_loader/efi_boottime.c | 174 ++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_memory.c   |  56 +++++++++++
 lib/efi_loader/efi_setup.c    |  25 +++++
 6 files changed, 352 insertions(+)

-- 
2.39.5

