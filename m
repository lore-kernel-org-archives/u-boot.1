Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A2BC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 235D880F9A;
	Sat, 15 Mar 2025 23:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YTfZqh/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2AC180F70; Sat, 15 Mar 2025 23:18:20 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE338058A
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224341bbc1dso60377805ad.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077097; x=1742681897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ciJgYrdT5YQqrCqFvqJv4Qxu7Kia0ISH/pcpHkP1KMI=;
 b=YTfZqh/l/k8xF5fpE2wPdvA6VhoKLmSZpNzemK9XDqQvjHA0syzE+kPuMeQGiWABWK
 RgHe4JnNGTnOFF1CewpKuqzsFxBuwyEclEn+12lYFdiZvWwJFLI9xAWHbypKgoFwlKr/
 nM6YOlvKMwdTtkofkVqFiCPyd4IG/zleqUnKVW3HvTRJgAmTuZhTSU5pTFXvT0HTOqRb
 Nq3DmTKHFY2fTyxehmJiQK71p3wDSlECn0cxAXMq4otqT9o5UR8WY6zrhuWUy9X66WUY
 U6su/SPZXcJhckYtv3JW4Fe/y2yQZpx0wlbWxoUN9Z0No+kD66Dc0Chk23G6W2ZKfLsJ
 3FKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077097; x=1742681897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ciJgYrdT5YQqrCqFvqJv4Qxu7Kia0ISH/pcpHkP1KMI=;
 b=DUB1xzkSMoq6a6pcR4D0ieOD2fuZ5kDF5PMeuGtpK3eIdqp4Eqez+doKXFSLuYPv7x
 Mf47fMNT1iTmYIp7Ezs0YR1jyiskfuVl8cPYCZ1vk72aB8AwiflDf/4fFtM/4qhg9yOB
 u4cEqDW87tjU2Ptd7wdJMqokpi6Pe4jr+KwpHpAuTVZ6NH6ePmBc60aIdX3puJU4p6K6
 BTUkj6+qr8qu9XcdBU86M2aFV/WRfi1HO0tO7fRiR6i39RG6NmlsaKGgNW0zBL4MfotF
 jNVk61M602OJciAHtku5RRKxnBLurtQ56TXzwNOrdp0HuHv82p0Zdv4ezhDw3Qioy3cF
 eoag==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4zlrmbpZZDsWJsAXoZ2OtZj3dRxxHTkvfXVvgdhaBapoWc0wMGACBHzurJIJK/GeJAPo/XB4=@lists.denx.de
X-Gm-Message-State: AOJu0YwvAHjIJuY6wJ9xUkrhVqb6VDjAagwPKtOQTY+dk1lHRCs4bBxq
 q6N+kBVv47/PFaVrzDe5JFiuD7arS9+nxhyK+jrEZ8lI3WORWzxy
X-Gm-Gg: ASbGncsSWvJ0ZFthMs38QGi6UMtRS9GaNV0DYxP0T6LZoqQnixPEpxUn51Jv3cp0Vu6
 nm92Ik5XmPd9Dh9E0sviQ8CBFYJPNpPfnftB6YPmRqmktawFOwJJPGheULX5eePaqKr02VwrCEo
 WBIyIRm9ZInqhoOfEwubgPFC8m9krmyv7C2bfa6dwSZHJ+rbb0ctZUViu9Ckhj/OLlV/Y81nzhN
 1DGHOQQRtMwerqrNO+J0/rbx0Sf7cGkzp3Tuoy6yeCDAtcwIpGkgjOobz/lOolsMwz81JwcVe7H
 m5zZPFezJYK7H6KsaHf77qLTkHoPqxlVeQaYBhfUlEsC5WruxvR2zDMjOP/Vqmcv+w==
X-Google-Smtp-Source: AGHT+IHm/d4apcCYdX3UXNgRXcXpht4FOtKlKo9HEDhZpf9Ug00NMZUK4Ofg0wX4rfofLdZpTbYn8w==
X-Received: by 2002:a05:6a00:3d4a:b0:736:a7ec:a366 with SMTP id
 d2e1a72fcca58-7372238a794mr6965492b3a.9.1742077097018; 
 Sat, 15 Mar 2025 15:18:17 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:16 -0700 (PDT)
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
Subject: [PATCH v2 00/15] Various toolchain compatibility fixes/improvements
Date: Sat, 15 Mar 2025 15:17:58 -0700
Message-ID: <20250315221813.1265193-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Hello again U-Boot list,

This is v2 of my "misc. fixes" series, sent to prepare the codebase for more
direct LLVM support in the near future. This series contains several fixes that
I found in the process of preparing that support and which address issues
independent of any future feature or enhancement. I am sending these now, both
so that their inclusion is not delayed by discussion on my upcoming series and
to make the latter more manageable.

PLEASE APPLY PARTIALLY! I have tried to sort these so that the most
straightforward changes come first. If any patch proves contentious, you can
either skip it or stop applying the series at that point. Any patches that need
revisions will be included in a future series, but I'm trying to avoid there
being a v3 of *this* series. :)

Happy Saturday,
Sam

Changes v1->v2:
- Carried forward acked/reviewed tags
- Dropped two patches (one was incorrect, the other can be fixed differently)
- Minor phrasing changes to commit messages
- Instead of removing `ENTRY(_start)`, I instead added `.globl _start` where
  appropriate, in the EFI apps

Sam Edwards (15):
  arm: Remove stray .mmutable reference in linker script
  arm: Exclude eabi_compat from LTO
  arm: Add __aeabi_memclr in eabi_compat
  arm: Add aligned-memory aliases to eabi_compat
  arm: Discard unwanted sections in linker script
  arm: Replace 'adrl' in EFI crt0
  x86: Fix call64's section flags
  makefile: Avoid objcopy --gap-fill for .hex/.srec
  makefile: Add `norelro` linker option
  makefile: Add READELF command variable
  arm: riscv: efi: Export _start symbol from crt0_*_efi stubs
  efi_loader: Move .dynamic out of .text in EFI
  scripts/Makefile.lib: efi: Preserve the .dynstr section as well
  spl: riscv: opensbi: Error on misaligned FDT
  spl: Align FDT load address

 Makefile                        | 14 ++++++++------
 arch/arm/cpu/u-boot.lds         | 29 ++++++++++-------------------
 arch/arm/lib/Makefile           |  1 +
 arch/arm/lib/crt0_aarch64_efi.S |  1 +
 arch/arm/lib/crt0_arm_efi.S     |  4 +++-
 arch/arm/lib/eabi_compat.c      | 17 +++++++++++++++++
 arch/riscv/lib/crt0_riscv_efi.S |  1 +
 arch/x86/cpu/i386/call64.S      |  2 +-
 common/spl/spl_fit.c            |  2 +-
 common/spl/spl_opensbi.c        |  5 +++++
 lib/efi_loader/elf_efi.ldsi     |  6 +++---
 scripts/Makefile.lib            |  4 ++--
 12 files changed, 53 insertions(+), 33 deletions(-)

-- 
2.48.1

