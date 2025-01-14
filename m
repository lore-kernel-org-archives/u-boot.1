Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B69E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 10:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98AD480690;
	Tue, 14 Jan 2025 11:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XbNAv+Ux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6A828069A; Tue, 14 Jan 2025 11:30:06 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1937080285
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 11:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 30D773F1CC
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 10:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1736850603;
 bh=wOtFSQOwOa2kqDdaLjeeVeXdo1nU4NGCvuGn+JPb6zM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=XbNAv+UxzS918qGaO+ESoBLtPWN1ARc24sl7vmVC4qbgz5XCwy4BGV7JDjmVGg/OZ
 Jtmwo7OtnRUK1b+LuqMWBus2YrxLHkKJ1Jnx7UqTQd2A7dxyPCr/uB/LzIZ4V0BRl8
 M0sGGoVXS7uSaPFqDxCDsjk90y8dp6qe60kdN4ApraGYTrCKzdQFLHT967Rb4lX1PW
 LoZpPV4ZNMA1e6dujTiJiQYE+D0kmLy8tblEebZPF2TKBMIaUuAsz6xYBNaG9gvJbX
 +AGNEeEald3ncBl+zwyV5ZdJX9ohjIxC1K9HL0lDVRL0YEGrCgSSRghHAmexLIdAE0
 MQ+zHCxBUwVCA==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436723bf7ffso16809865e9.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 02:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736850602; x=1737455402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wOtFSQOwOa2kqDdaLjeeVeXdo1nU4NGCvuGn+JPb6zM=;
 b=IbgbbIGFPEp3l3fK3kQzPb0tPar6l6vI3r3a1W1NkIre7nrinc1/ffZJghg6qz6Zrs
 MrQLzMJy+a9NNkRnYP8Auk4XpR4RYxSMyFrIYNVjV2uto2n3TkemCEKMgP1VK1I11lBS
 0yw+UcOBOncMWT87Jeyc2sx+wKKrSxUswObyNAQJOR9C3pAiQpxQlkwHLn0CEN0ZwQy7
 KZmBAVGg80Aah6oFUevK8bo8reNZ1wG3sojN46Xd3xsBBjwSDlzIK1XhyP60lNX0lvGg
 8FWp29czcAdN3N7ZBiU1QBlcsuKFpZHqr9vQfqdHhX9zDwPKB02jAIoVdWGwPwPm6m2U
 uN4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEwwAhJv6kCHCpkptTPycAWQMVTsdxqCDKKUJ5ZLYWzYPVZZdJC2V0yKH9Z7mvltJVS5tnUyk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw54D9Jb2V56/a917VOX8EWPi0/tgPAaHVZ+nUkTRk2XYaHkKYc
 l3AlqvRK3mYkE98xmKd7FWhls2uTfBznV5xvzYVZyu4MIFRfGhJ/0KitZSRDD4fv1TNL6LCC02U
 szNe94TvTPH6L2wpBYtpNzmp37u4Z6/1ev/lm+Csyjd8tB3NZi0mRZLk8fGoWeQSMdT4=
X-Gm-Gg: ASbGncvJmojMeW063MLH9ovT5E+wdpDL0l2YJmGqsB447ZAgi9fTvxEYU+jJ+66sYYB
 0+W5l/32WvMdQ9OLob8WTALQTr/GSw4E5iquv+1QLYqBa2DklO0AGcSiWDWgKuujcZUROjD2zhy
 JLLkj4wIVYAL/fbOnoOoG/f6xpKCjfF1bMciCgLXe67dRPpnrsjnxITqMlufA0hjDuXz8OF4kyX
 WwSg8ha00KNRJ1x+eGS+gHOQlKpNlR3cRnNJFuU22ZkD5Wfy+ft72ROzM6zt4TznGSeRreEAiyz
 lf0bcXwhIhTudCA=
X-Received: by 2002:a05:600c:54c5:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-436e3fb231cmr200552725e9.27.1736850602570; 
 Tue, 14 Jan 2025 02:30:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcRoxu9i8G77wnpxnfmx2Ed+O/7Zp+v1C+iKTJ/UNqp6Vsqg9khK5RbmWZl3XOq+eatcXXPw==
X-Received: by 2002:a05:600c:54c5:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-436e3fb231cmr200552525e9.27.1736850602204; 
 Tue, 14 Jan 2025 02:30:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:642a:6b6a:606c:5383:21d9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc8826sm169996455e9.11.2025.01.14.02.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 02:30:01 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/4] efi_loader: Fix section alignment on EFI binaries
Date: Tue, 14 Jan 2025 11:29:49 +0100
Message-ID: <20250114102953.64381-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

When creating EFI binaries, the alignment of the text section isn't
correctly factored in. As a result trying to load signed EFI binaries
throws an error with:

    efi_image_region_add() efi_image_region_add:
    new region already part of another Image
    not authenticated

Except for the fixing each linker script individually carve out a linker
script include for ARM and RISC-V.

Heinrich Schuchardt (3):
  scripts/Makefile.lib: add -L option to LD command for EFI binaries
  efi_loader: use INCLUDE in EFI linker scripts
  efi_loader: use include in ARM EFI linker script

Ilias Apalodimas (1):
  efi_loader: Fix section alignment on EFI binaries

 arch/arm/lib/crt0_arm_efi.S        | 37 +++++++--------
 arch/arm/lib/elf_aarch64_efi.lds   | 68 +--------------------------
 arch/arm/lib/elf_arm_efi.lds       | 71 +---------------------------
 arch/riscv/lib/elf_riscv32_efi.lds | 68 +--------------------------
 arch/riscv/lib/elf_riscv64_efi.lds | 68 +--------------------------
 lib/efi_loader/elf_efi.ldsi        | 74 ++++++++++++++++++++++++++++++
 scripts/Makefile.lib               |  4 +-
 7 files changed, 99 insertions(+), 291 deletions(-)
 create mode 100644 lib/efi_loader/elf_efi.ldsi

-- 
2.47.1

