Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92986C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F14BD8891C;
	Mon, 15 Jul 2024 15:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oaexBRWh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 645B5888C7; Mon, 15 Jul 2024 15:31:46 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AB28888E0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b760dc7e08so13502366d6.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050303; x=1721655103; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4e35rUa6TCzcp95Nw7Nj4sh1aKhktBkD+pAqy1TL6fM=;
 b=oaexBRWh5FtPUNiROkSkxlk3Jw9UvoDwygimeqr3wMcvkuODPxKHvMuinSp5C4xYFl
 ZhpMfVHWI1tXky4v9iJ89Xw/RmrQxuQoTDRIl2KgKABPICJN5QXHkczBGnt6gfxJFyVo
 oUCBx7hWF1DEkORnZjEMV24Igreotg+pEuloA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050303; x=1721655103;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4e35rUa6TCzcp95Nw7Nj4sh1aKhktBkD+pAqy1TL6fM=;
 b=oqhPxRkRGNmfFdY0AZoRuW1JCw2nH2miyFHqwwbG40s2y0McvnEIWH9Nphv80lN/KO
 Ok34QuQYsR736Z4ux2v9zO8w3PsCt+MzEL9SEVp8QGcCasxwXGT91jL6qtkJv+g6eCQ5
 1bjA05FtpLLw0Z0BEtLaoEigDg2U+94LyEG9HNJS713zXg+OcozhQ6cGhfO41+CyvC6C
 IDT5KTvuJDq+KEfhMazWbFdg/eBHG3+BdjtJj9FP6Cvoh9PyzY+N11fHNxPORVYDFa14
 RSWSd+mqP7wVJS6sQw2Hr6eDe3tbCfnDZd6c+kq7+XZlU8zYPStdSOhvk2gD9h05LbBl
 zhHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxitG+skqf1oyQBIaoKnT6ZGuZhvSQ9HLSbxddg7pNA6biTDftd6wFUovwwhyukNS9IqlcxPCIzWmfZuNp5WlTDtq4BQ==
X-Gm-Message-State: AOJu0Yz7AooTTM1kG1uQKf3/jHo+yaOL55/GOfmrUlxG6em2szf2Dz+k
 dY3FQVz/6bMLfMntc75MIz+mZhrcP+5USPp0BzOmE6LUleV9Hs1Wb2TgVL6KxgMMqe4N7pM7QPg
 U3WDCHuEqeTybpzQ0Um9oL4K4evY0j/5s4uis
X-Google-Smtp-Source: AGHT+IG7ZVzCobPhLnlyJYGly2TJouGVwUm2cpwq1tJ6M02xwpP4snHL7mBJWxfKLgZB4491oV+Sa7Xx3dsx4PYuMY8=
X-Received: by 2002:a05:6214:501b:b0:6b5:460d:5479 with SMTP id
 6a1803df08f44-6b61c1c3ab3mr262529166d6.47.1721050303186; Mon, 15 Jul 2024
 06:31:43 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:42 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240617151419.13383-1-ilias.apalodimas@linaro.org>
References: <20240617151419.13383-1-ilias.apalodimas@linaro.org>
Date: Mon, 15 Jul 2024 06:31:42 -0700
X-Google-Sender-Auth: Kyv0sBDJDe75rqpprEENv6veaDA
Message-ID: <CAFLszTj2-=dCnSq1c12w-i80-sgSyXtdAEANnf_S79wjcB2QNQ@mail.gmail.com>
Subject: Re: [PATCH v2] sandbox: cleanup linker scripts and sections
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: ascull@google.com, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, u-boot@lists.denx.de,
 sjg@chromium.org
Content-Type: text/plain; charset="UTF-8"
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

commit 6e2228fb052b ("Merge patch series "Clean up arm linker scripts"")
was cleaning up linker scripts for armv7 and v8 in a similar fashion.

Several commits in the past -- e.g
commit d0b5d9da5de2 ("arm: make _end compiler-generated")
was moving symbols to be compiler generated. They were defined as c
variables in its own section to force the compiler emit relative a
reference. However, defining those in the linker script will do the
same thing since [0].

So let's remove the special sections from the linker scripts, the
variable definitions from sections.c, and define them as a symbols.
It's worth noting that the linker was discarding the symbols in the
older binary completely since the symbol definition had an extra _.

- new binary
$~ aarch64-linux-gnu-readelf -sW u-boot | grep efi_runtim
   246: 000000000004acbe    13 FUNC    LOCAL  DEFAULT   14
vbe_req_efi_runtime_rand
  3198: 0000000000318690    16 OBJECT  LOCAL  DEFAULT   29 efi_runtime_mmio
  6359: 00000000000dedff   217 FUNC    LOCAL  DEFAULT   14 efi_runtime_relocate
  7942: 00000000003074c0   136 OBJECT  GLOBAL HIDDEN    29 efi_runtime_services
  8869: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27
__efi_runtime_rel_stop
  9159: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_stop
  9410: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_start
 10137: 00000000005981bd     0 NOTYPE  WEAK   HIDDEN    33
efi_runtime.c.de5bed54
 10470: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27
__efi_runtime_rel_start

- old binary
$~ aarch64-linux-gnu-readelf -sW u-boot.old | grep efi_runtim
   246: 000000000004acbe    13 FUNC    LOCAL  DEFAULT   14
vbe_req_efi_runtime_rand
  3198: 0000000000318690    16 OBJECT  LOCAL  DEFAULT   29 efi_runtime_mmio
  6359: 00000000000dedff   221 FUNC    LOCAL  DEFAULT   14 efi_runtime_relocate
  7942: 00000000003074c0   136 OBJECT  GLOBAL HIDDEN    29 efi_runtime_services
 10135: 0000000000598320     0 NOTYPE  WEAK   HIDDEN    33
efi_runtime.c.de5bed54

$~ bloat-o-meter u-bool.old u-boot
add/remove: 0/0 grow/shrink: 1/1 up/down: 7/-4 (3)
Function                                     old     new   delta
efi_memory_init                              343     350      +7
efi_runtime_relocate                         221     217      -4
Total: Before=2009902, After=2009905, chg +0.00%

[0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic
only for shared object")

Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de> #
sandbox_defconfig on amd64, arm64, riscv64
Reviewed-by: Simon Glass <sjg@chromium.org>
Fixes: commit aac53d3d96a2 ("sandbox: Rename EFI runtime sections")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1:
- Added Fixes tag
- Collected tags from Heinrich and Simon

 arch/sandbox/cpu/u-boot.lds | 20 ++++----------------
 arch/sandbox/lib/Makefile   |  2 +-
 arch/sandbox/lib/sections.c | 13 -------------
 3 files changed, 5 insertions(+), 30 deletions(-)
 delete mode 100644 arch/sandbox/lib/sections.c

Applied to u-boot-dm, thanks!
