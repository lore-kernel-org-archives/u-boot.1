Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CFCC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F79E83989;
	Fri, 25 Jul 2025 14:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fKiLaDCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8028983979; Fri, 25 Jul 2025 14:57:31 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A73381E06
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a522224582so1042459f8f.3
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753448248; x=1754053048; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zFRX/AFDTm7B2uhhg7S83juLGFvRE6NkCFwXs2nuNSM=;
 b=fKiLaDCGlDGA/LfjnA5jYyS9mrk06Fg+2GMx0R/pKZsVfwGstkO4FL2e0lrRKbQsZ6
 DvrDN3tnb1Sg+v2k8dK5SoLUYSKpX9YJsRP6kDfenaPXRsdQbUCfn6jd5+ZpXc/1sIH3
 f3gcPWLJ8E3SY6NiM5OzrUdLrskJiJVwncbKOlF4Qj84cDlBpr8YHO6haRo72zkPBrFe
 e9yUg3jKMlepkLXbnyDECHzmFgb7V89PfiHBPEEvPjCZkN8yh+LLMxFwUmJlNd4vHYep
 x9FXePNISWs4HibmL61/M9bkLO0KMEBHH/Gdoqi8vcAlqZvwBy22V23K7BV0r8cBZb5Y
 3fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448248; x=1754053048;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zFRX/AFDTm7B2uhhg7S83juLGFvRE6NkCFwXs2nuNSM=;
 b=vG3SKJcAjfJSYyJsx+E54V30hpofR8Sb9J9fH6C36lkiSb+Fh4U14vGV5DtBPYoAYC
 pHceRmswjMHskV2XL1HsH/3qjOOvIQRHP4MBzxIjW38H+a3mN3FhM8koobx6SaNl1n+w
 eYi5qLgUk0rJJzmXdClVXBmnIG7r6jtMCKvcVl4ZownyaUX6LvsR7UgnwacPywNBohUF
 16chbQT48IPDwWCWwAkVp+Qho2JOs41iTxW+seS963D6EtRJJMpqO5cEpTKKtnyhZ370
 OohaM90XvVtIjBQt6v7eInN99CcZugS9egIogt3nDS2jwr9pwDfjcVs9VPGdF1Lea44h
 KIfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE56eM9K9/SuOdriaP+S95BJ1hOLggljGWItrBCyHdOF242ueG1sezsvqxQHl2J4caeC9enr8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/2TX+FxfxBPQyyTH14zWeaJ4Emd24BsrbrtNjNmmpddmfGYvN
 ucwag21QNRAwxFcYtqiWSWQioyMAiT/1U7YJjppZbtHyRnrnM7v+lvoiDDHfWwwsIyo=
X-Gm-Gg: ASbGncsEB5c1RAh88HebUnNk0474oQ8UpliRGyQeu2CCVC9kpT3C+GNoQnFgP04rFRi
 n6iQ7QrxgvDHsW7QjRGgXo45mA1tOnAj6AeSnLcefaLaT7oeoQ++Ry76WXCgMjCfNPUxLkZ/vhs
 5daM2rZz3rkJIFz20UyjlbqXEgEq2wZuwr4nywctW61VBgJFv3lvnEZY6dnbiE9V3BZYl/DGy4A
 iMfim70yk8Fhx9wPH2Zsei+SbTfg6OgzjCQEKR7+scwOaTdnhiNbDcOtfF98J2so2AMfvghSaX6
 AW05nWGer0tdh7IAoT8ofCFfxLJf9V0c6xRJDanh/+SgxSD7zbL6MsS9QAJymfT/dFYFxUAp4Ik
 F9NeEwnMToOqLOCo3G+ZjH/UQmJ1t30P/hbgodxV0c2kB+mRjuJLj45v6DmbmaNTDlw==
X-Google-Smtp-Source: AGHT+IGF6R81I8bbETMnABhsI5M7wWcAPxzE7T8Mvx/mR+mOXqJJZam161yYfEV4swOG9slai6eVSw==
X-Received: by 2002:a05:6000:2484:b0:3a4:cbc6:9db0 with SMTP id
 ffacd0b85a97d-3b77677defbmr1831872f8f.51.1753448247631; 
 Fri, 25 Jul 2025 05:57:27 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fcfsm53115355e9.29.2025.07.25.05.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:57:26 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v2 0/7] arm64: stack backtraces
Date: Fri, 25 Jul 2025 14:57:04 +0200
Message-Id: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACB/g2gC/x3MSwrCQAwA0KuUrA20YcZ+riIuMmOqQfshEVFK7
 97B5du8DVxMxWGoNjD5qOsyF9Cpgvzg+S6ot2KgmmLdUsQUkG06B0ycn2/jLOi/KS0vRx772Pb
 UBOo6KMFqMur3n1+u+34Angaa7WwAAAA=
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4928;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=/rR3gczKWlOX+cBd8kbmHgxNb+kOmCwOApaEQkez0Nc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhozmetP19rdnSu1m6u6t+yUzI6dr4ZVXvJvXH1jVYcjof
 ljbbt/cjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRfScZ/unML+tSO8Q0w4fl
 Yo68jj7j+WcxH1fH9onEbZMt2BrxX4Lhr2z6lo7/yhfzq+LyWvpcfPYXXj92Y8niOSUrq7S3724
 vNgUA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Implement support for printing stack backtraces on ARM64, make
framepointer support configurable by the build system with
CONFIG_FRAMEPOINTER and teach U-Boot to walk the framepointers and
unwind the stack when an exception occurs. Also show all 64 bits of the
exception syndrom register (ESR).

Additionally, a new global unwind_stack() function is added, this can
be called from anywhere to print a backtrace which can be useful when
debugging certain problems.

In the future, stack unwinding with symbol support could be extended
to for example only emit log messages when a function is called in a
specific code path. This would allow for less noise when debugging hot
paths under certain conditions, but this feature is left as future work.

=== Handling relocation ===

Since U-Boot relocates itself at runtime, and can be built to be
position independent in the first place (effectively "relocating" itself
when it first starts too), we can't really rely on gd->reloc_off.

The approach taken here is to subtract CONFIG_TEXT_BASE from the address
of each symbol in the lookup table (while it's being generated), then
when decoding we just subtract the address of the _start label since it
is always correct pre and post relocation. This allows us to avoid all
the awkward maths since the symbols are always relative to 0x0 in the
lookup table.

Example output:

"Synchronous Abort" handler, esr 0x0000000096000004, far 0xfffffffffffff
elr: 000000009fc6f768 lr : 000000009fc6f710 (reloc)
elr: 00000001ffe49768 lr : 00000001ffe49710
x0 : 000fffffffffffff x1 : 0000000000000009
x2 : 00000001efdbadd0 x3 : 0000000000000000
x4 : 00000001efd99a28 x5 : 00000001ffec7676
x6 : 00000001efdbac70 x7 : 0000000000000000
x8 : 0000000000000002 x9 : 0000000000000034
x10: 000000000000000d x11: 0000000000000006
x12: 0000000000001000 x13: 00000000c3400000
x14: 00000000fffffff8 x15: 00000001efd99837
x16: 00000001ffe146b8 x17: 0000000000000000
x18: 00000001efdbac70 x19: 000000000a6f8800
x20: 00000001efe06fd0 x21: 0000000000000001
x22: 00000001ffef5b80 x23: 00000001ffee08c0
x24: 0000000000000002 x25: 0000000000000000
x26: 0000000000000000 x27: 0000000000000000
x28: 00000001efe512c0 x29: 00000001efd99c80

Code: 2a010000 b9001260 d5033fbf 92fffe00 (39400001)

CONFIG_TEXT_BASE   : 0x9fc00000
Relocated base addr: 0x1ffdda000
Backtrace:
	<0x000001ffe496d0> dwc3_qcom_glue_configure+0x40
	<0x000001ffe494a4> dwc3_glue_probe+0x10c
	<0x000001ffe1757c> device_probe+0x254
	<0x000001ffe1757c> device_probe+0x114
	<0x000001ffe4ff70> usb_init+0x158
	<0x000001ffe00fe4> do_usb_start+0xc
	<0x000001ffe01018> do_usb+0x78
	<0x000001ffe0dec4> cmd_process+0x140
	<0x000001ffe04e24> run_list_real+0x6f0
	<0x000001ffe05554> parse_stream_outer+0x148
	<0x000001ffe04d30> parse_string_outer+0x90
	<0x000001ffe0d148> run_command_list+0x50
	<0x000001ffe02be0> main_loop+0x28
	<0x000001ffe065c0> board_init_r+0x3c8
	<0x000001ffddd00c> relocation_return+0x4

Resetting CPU ...

---
Changes in v2:
- Include calling function in backtrace (current LR)
- Implement support for runtime symbol lookup
- Use symbol lookup to print more informative backtraces when available
- Adjust backtrace format and print U-Boot base address
- Link to v1: https://lore.kernel.org/u-boot/20250703051951.43372-1-heinrich.schuchardt@canonical.com

To: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Rick Chen <rick@andestech.com>
Cc: Leo <ycliang@andestech.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de

---
Casey Connolly (3):
      drop unused kallsyms support
      add support for symbol lookups
      arm64: implement printing backtraces with symbols

Heinrich Schuchardt (4):
      cmd/exception: missing include string.h
      Kconfig: make CONFIG_FRAMEPOINTER available on arm64
      arm64: initialize the frame pointer register
      arm64: simplify interrupt code

 Kconfig                      |  25 ++
 Makefile                     |  24 +-
 arch/arm/Makefile            |   9 +-
 arch/arm/lib/crt0_64.S       |   1 +
 arch/arm/lib/interrupts_64.c | 133 ++++++---
 arch/riscv/Kconfig           |  21 --
 common/Makefile              |   1 -
 common/kallsyms.c            |  42 ---
 common/system_map.c          |   8 -
 include/exception.h          |   1 +
 include/symbols.h            |  22 ++
 lib/Kconfig                  |   9 +
 lib/symbols.c                | 141 ++++++++++
 tools/Makefile               |   3 +
 tools/symbols.c              | 646 +++++++++++++++++++++++++++++++++++++++++++
 15 files changed, 965 insertions(+), 121 deletions(-)
---
base-commit: f2f451d9d6d3756458d5037e3e5135e5211582d7

// Caleb (they/them)

