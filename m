Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A39C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03DBD80207;
	Mon, 24 Feb 2025 06:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gcNPIiJo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8805880C77; Mon, 24 Feb 2025 06:55:58 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3581380017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fbfa8c73a6so8074249a91.2
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376555; x=1740981355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6lOJxvwjxcA9Cvc4/Ja924zAkybuZ2g34QDfEpu7Q5o=;
 b=gcNPIiJoohdzPGeTYX7XT2kXF6LKFlvVWFdsPkgIs1zrTbn1f+c8pd+Y1yyst04vf7
 EtDZb5s8xd4eHGaDPm+RAgi/AfL7ToItgyHij/COY0Cl2rMSYlgytQPePEuPlhhW7wME
 h7MoTly5Ztdh/FCoajw2e5+CyuqITe700//axFZgBaQwN5WoEvG+8aiX+G/f7nyiByw0
 shvJ1IoPpuPoXO/i/gdz44u1vlnlej25iA0Zkna65s04CGtZxon71jXKJy4SKdj5UYaK
 gzVy9kg926FJ6aGwsSQx7lkpn0hJzLrFqGPUEsumdRmoA0XqtDny9nO9P3n6Mry9Sxl2
 9Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376555; x=1740981355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6lOJxvwjxcA9Cvc4/Ja924zAkybuZ2g34QDfEpu7Q5o=;
 b=CjFRYXSTmPU/ACoE3eCdV6MQM5jTH7cLpYKhIVDduCv9aUeo22GTrzcef/o1/tHDXH
 hnRssDnvXqlj5EznHM9ztruZ6mmpOFbEMIPFoZU9O8tQBPBQcGyvaMO6zpl8rYcK1Y7H
 cQ1W9RS95FN8yxX50p6IPTGgbqxieQS8zFkL409XBL18jyf4mkfwInDbZQIldX4zFiaJ
 H4bt4O/G+XGUx9Q5xoATDgg+pS6UJlworRslTKFqJIe8VoPIAUv8cwWWC2Q3DthbrFfl
 Cdt3yDQQDku9yQI2b/hQLu/R/AaTfGmsgV3zvuxaesnPRt8TC1bWkvaC9Xwf1cIqjZKw
 c1Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDDlLxBIS+uf5jpE3vVvNINSMaGycRUniMftSb5OHdtyksOSMfC6S+xSiE1/wHAVyCGAX4oGg=@lists.denx.de
X-Gm-Message-State: AOJu0YyaWV0qukE3XG6lpekJ5cT1jJuLO8gvUgc8seMUz0KrcTbLxwAa
 DtTFwgB4RzlJhCjumMwd/gY3T0cn2JMYMBmRtPzDaZrfZxqHmyYv
X-Gm-Gg: ASbGncv+rYwqG2xkqGtXPJrj2HqrKYorRDGg7Vek4tQnv4jplUZW/8IMhD+oPXRUFik
 Br6lzu6729XjDkeNvmdcML4fldf7RD1X0Is/uln6YW2+RQzZBebSx6PkKCI94hsX3PZrzCI7tWO
 WGNDghmRX5Q3pgOKMPmzxtW8ZfeE2GUxrnn0JTRJGn1I4YSGvxIt/FSlN7FvHtfjUCOsbq6UbSc
 tuj/C+QHVE7JPGAkzWbzDb67eyX5Q2PRSGdC6NmRRZbAfnzB8wGb3Nt2x6l3hwdSXGxOlubwsIe
 FlnKizEi8/CC5tSysQBmNKPWNumafUUYuVL2lw==
X-Google-Smtp-Source: AGHT+IHUokSJqyXAmu9/Ndccbp1V5tt1kHVJC/aJup0SPjPgwVSdswLO/tv0AiTyQcdXcMGxpC/B4w==
X-Received: by 2002:a05:6a20:8403:b0:1ee:efa5:6573 with SMTP id
 adf61e73a8af0-1eef52c9981mr23984615637.8.1740376554590; 
 Sun, 23 Feb 2025 21:55:54 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:55:53 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 00/17] Various toolchain compatibility fixes/improvements
Date: Sun, 23 Feb 2025 21:55:07 -0800
Message-ID: <20250224055524.1334929-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
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

Long time no see, U-Boot folks!

This patchset consists of various bug fixes and correctness improvements that
I discovered while attempting to add first-class LLVM support to the build
system. These patches are NOT related to LLVM support directly; rather, they
address existing issues that should be resolved regardless of future changes.
For the most part, the patches are mutually independent and can be reviewed and
applied separately. If any patch is not suitable for merging now, feel free to
skip it: I will incorporate feedback and revisit those changes as part of the
upcoming LLVM support patchset. I'd like this patchset to be evaluated on its
own merits, based on the current state of the code, without consideration for
future LLVM support.

Note that the issues addressed in this patchset do not occur when U-Boot is
built using the GCC/GNU toolchain. These bugs seem to be specific to builds
using other toolchains, like LLVM, and do not appear to affect users relying on
GCC/GNU. Therefore, I see no need to rush these changes into the stable branch.

Again, these patches are mostly independent/reorderable...
...except that: "arm: Add aligned-memory aliases to eabi_compat"
...depends on: "arm: Add __aeabi_memclr in eabi_compat"

Warm regards,
Sam

Sam Edwards (17):
  arm: Remove stray .mmutable reference in linker script
  arm: Exclude eabi_compat from LTO
  arm: Add __aeabi_memclr in eabi_compat
  arm: Add aligned-memory aliases to eabi_compat
  arm: Discard unwanted sections in linker script
  arm: Use -mstrict-align when the MMU is off
  arm: Replace 'adrl' in EFI crt0
  x86: Fix call64's section flags
  spl: riscv: opensbi: Error on misaligned FDT
  spl: Align FDT load address
  makefile: Fix symbol typo in binary_size_check
  makefile: Avoid objcopy --gap-fill for .hex/.srec
  makefile: Add `norelro` linker option
  makefile: Add READELF command variable
  efi_loader: Remove ENTRY(_start) from linker script
  efi_loader: Move .dynamic out of .text in EFI
  scripts/Makefile.lib: efi: Preserve the .dynstr section as well

 Makefile                    | 16 +++++++++-------
 arch/arm/config.mk          |  4 ++++
 arch/arm/cpu/u-boot.lds     | 29 ++++++++++-------------------
 arch/arm/lib/Makefile       |  1 +
 arch/arm/lib/crt0_arm_efi.S |  3 ++-
 arch/arm/lib/eabi_compat.c  | 17 +++++++++++++++++
 arch/x86/cpu/i386/call64.S  |  2 +-
 common/spl/spl_fit.c        |  2 +-
 common/spl/spl_opensbi.c    |  5 +++++
 lib/efi_loader/elf_efi.ldsi |  7 +++----
 scripts/Makefile.lib        |  4 ++--
 11 files changed, 55 insertions(+), 35 deletions(-)

-- 
2.45.2

