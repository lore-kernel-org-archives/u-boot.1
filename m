Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CDBC87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48294829E7;
	Tue, 29 Jul 2025 17:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OIkYLBx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E9BE81E14; Tue, 29 Jul 2025 17:50:11 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38AA4829E7
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-455ecacfc32so24074525e9.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804207; x=1754409007; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zUGtzTGIHp3lHHkhb7GjAGLV5i60tGv67auQDIXGt2o=;
 b=OIkYLBx2sRH3JR7kFgWu23y2VcFGHtMIt7xUWpz/fLK6TDSTl0JaXkaCIDGjekvska
 uilWiAyiff/inzmurxGB+paTfdc6jIKFpEx8PIGBJYolZdo67X0HVR6SLCtH7LFyTJ+M
 cxG4AX8J9dx5TZ0Y/n24O5mIwyWERsE3yACQDUtlFPmmei/rA9SJvjadPyG1TlUP9Tx3
 NhHGMuhrU6YbMrj9lGXvCnEVXXdJMMDpMeBm1sXTZwjBdcmTWU4i1XD7VMWIYYaN36br
 yPmKEq/33brwbFdJtPWMvxiGTy8+v/CkrjFAE7lXgsfgsCVtNGqAf5jq4f46ajZ8nnyF
 6n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804207; x=1754409007;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zUGtzTGIHp3lHHkhb7GjAGLV5i60tGv67auQDIXGt2o=;
 b=KrCU9AoHmBQlUA6roRwzGqfvHlOJJAClgvogy7zAjCnbJe4dN02lc/asJaN7Vd4tkr
 lSOfrExrrzYpkJYREn+va5jQuQFWLzgEcvKPfTXOUz6u21TOc6chdQTDTHvVJSf8RG/e
 A26KdDICN3+msEhKt321o0l0zdGQO3buvI4dIg1NprlHUNyPaVqMfWrTNvS8np07Qi00
 CkaXikqB7xz212HlbrgM2a1S/dq2aaJeQNxGkWi2x8BeQMike1l1ZTSBKNaeJAL+LZQP
 YxB6hxhBVKQWdpFtSDdNBF9YTLu+A+HDbr6hDEKPnFaXC7m2rNC9wK3pflU+BsVLtKfT
 wRkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyV0vej4g9Qdy5eGnfOA7ZFHd03WUendrdxMWAFHIVb1Mz5tV8ZNOeE602izB9qJbfIgOdtAs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2nSF6uh6wjZ1YEVkHFXlULkKuCXrBtWzYrTO4V7Vm8I7ohKLm
 FPikafl5aySaF4W4zEsHMTiqbzn1Sxg+EVE0oixUq+iAmaS3YFtgo1k4MPo9MHCvZBM=
X-Gm-Gg: ASbGncu3QBcBR/0h7g8TB/NTLTiAcUwINT8e7bIGcT+lAnBFe1Rp1vBO+LF+ZdiGQ4t
 N+cnVfmp9jUHXdWdmH0G0NcrY+GgLbaB6nYKQUzjeyBq6k4ZNvXteajMfWluFspBsJTufU86pVT
 O0oSfgFp0HqUlTL8q138wpCLiSTAk1P8CDrNbogr9i9d3cJP8lpopc5wFi3OF/uW+GmYM2LXVq5
 pDN051fL9jguTiqGREEz9UuuVlR7Bd7qceJp6HZkTw6zs8Ods7bGeVie+6pJn7G9Hw5SoCHtl7k
 kZnbR7l+nEQFhRN/LQI1e6gg+0Np1C9qxuSQJX10ibXE92HRNYaaGZTs6tW10JYBUkV9AIiYYRS
 zjOo7jF9uyIktofPn+nTDK7g2w+6mDqmSZyBkw7aiH0LqDCp1i3GTMOEmKiGldkr35lH2Nm1Q66
 Sd3XLzsNgcrw==
X-Google-Smtp-Source: AGHT+IGei7YBSVIn3jK0j3sW74hTyZXDgA0i7TtmqMa+e4fyoPp/IUheLx3BtedOtQrWl7twJWhGDA==
X-Received: by 2002:a05:6000:2486:b0:3b7:928e:b384 with SMTP id
 ffacd0b85a97d-3b79501e4efmr100282f8f.27.1753804206488; 
 Tue, 29 Jul 2025 08:50:06 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5c1a2fsm30635875e9.12.2025.07.29.08.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:50:05 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v3 00/10] arm64: stack backtraces
Date: Tue, 29 Jul 2025 17:49:58 +0200
Message-Id: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKbtiGgC/43NTQ6CMBCG4auQWTumDpS/lfcwLKZYoBGomRIiI
 dzdyglcPt/i/XYIVpwNUCc7iF1dcH6OSC8JtAPPvUX3jAZSpFVBGk2GLFOeoeH2tQi3FsM2GT8
 G5K7SRUW3jMoSYuAttnOfM/5oogcXFi/b+bXSb/0ruxIqpFRxledaldrcRzez+KuXHprjOL78M
 QD/xQAAAA==
X-Change-ID: 20250725-b4-arm64-backtrace-symbols-af9579214288
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5826;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=keLlREM7buT7FIH9mYonicyuThoExo5UqFVSc257h8I=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO2pnCevW98qV/KnLXjKPjbGwwfQDkuJDtu+v
 UXBRhrfQlyJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjtqQAKCRAFgzErGV9k
 tsYzD/43/kxCOEUJv3lU/Lt6AzYHxZp5VjzpKWZwsR2P7RxmSgm8DeotCx9grSmqaxdpwKgYZjN
 xkmeYGbqnbV1zkV/9Z+QWUhu2pgEOvBLrLJYPJyD6ATlD356jms//tvqeIRNgHO8A08BumvKeB9
 bLqeGNEwbY3Xm4hJQE9ev3y6hh5JOMLUreUug0nNVP/3SfkEkEoWSum4KpjxacuR7w56EZcaEvU
 D+PVquAzHQyFmQ5iyE+w9c1mJ9wpdQZ9w4DPw6/ShuNc4jmG+9YS5RAXriU6+RUE2VasC2tUHb3
 isVI17SAm6EMVi+LBNO6582DrQ+HiOXl0Um6+bWuoYG4FazH78s7fd/e+jdi8slpbC5TVHVq0Cj
 zLx2BbpW0ssF4sR6lIgb9smmFBP0mAjXva2kKY+nUu3oqE1G1wl1MjNIEMtcCxhp96P8IE3kp/4
 MM/l4whXGBgsDH5p3MD9GfORZrYpyH0L0LhsLw6kTtyqU24XOP72EUpE9Mca6OzYCBs3ZsZYfa5
 l43VfP77zy36gM1O0S6A70T5stwq1G3+/bXa3pWDEz6OiMUweFc+iml7cizUXr2SvuPNOMv9TxD
 Aa69nxuVd6jdHetf8UE3ntCto8ARmwaOMFfxVI6GmDcLti5LS7vaGp+zuJNMG/cdwjlKBegOhdy
 m509s4cC2JuxgYw==
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
debugging certain problems. It is now used during panic() when available
to provide more useful information for debugging.

A new printf format specifier is added: %pS will print a symbol name
from an address, this is particularly useful for function pointers

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

Example output (CONFIG_TEXT_BASE is 0 in this case):

"Synchronous Abort" handler, esr 0x0000000096000021, far 0x16dd3e2d3
elr: 0000000000028f64 lr : 00000000000344f0 (reloc)
elr: 000000017dda1f64 lr : 000000017ddad4f0
x0 : 0000000000001011 x1 : 000000016dd3e2d3
x2 : 0000000000000001 x3 : 000000016dde7eb8
x4 : 000000017dda1f30 x5 : 000000016dde7ef0
x6 : 0000000000000064 x7 : 000000016dde9000
x8 : 00000000ffffffd8 x9 : 000000016dd3e238
x10: 000000000000000d x11: 0000000000000006
x12: 0000000000000001 x13: 000000016dd3d920
x14: 00000000fffffffd x15: 0000000000000002
x16: 000000017dda1f30 x17: 0000000000000000
x18: 000000016dd59c70 x19: 000000017de87788
x20: 0000000000000000 x21: 0000000000000000
x22: 000000016dde7eb0 x23: 0000000000000002
x24: 000000017de9addc x25: 0000000000000000
x26: 0000000000000000 x27: 0000000000000000
x28: 000000016dde7f10 x29: 000000016dd3e2d0

Code: a8c17bfd d65f03c0 910003e1 b2400421 (c8dffc20) 
Relocated base addr: 0x17dd79000
Backtrace:
elr:    <0x00000000028f64 R-> 0x0000017dda1f64> do_unaligned+0x34
lr:     <0x000000000344f0 R-> 0x0000017ddad4f0> cmd_process+0x130
        <0x0000000002b99c R-> 0x0000017dda499c> run_list_real+0x718
        <0x0000000002bb28 R-> 0x0000017dda4b28> parse_stream_outer+0x14c
        <0x0000000002c06c R-> 0x0000017dda506c> parse_file_outer+0x34
        <0x00000000033818 R-> 0x0000017ddac818> cli_loop+0x18
        <0x00000000029084 R-> 0x0000017dda2084> main_loop+0x54
        <0x0000000002cdec R-> 0x0000017dda5dec> board_init_r+0x3c8
        <0x00000000003014 R-> 0x0000017dd7c014> relocation_return+0x4

Resetting CPU ...

---
Changes in v3:
- Reorder patches to try and avoid breaking bisects
- Include pre/post relocation addresses for symbols
- Print elr and lr in the exception case to capture the full callstack
- Change print_sym to print the LR value rather than the symbol address
- Make symaddr and offset optional in symbol_lookup()
- Implement %pS format specifier and use it in backtrace print
- Export unwind_stack() when CONFIG_FRAMEPOINTER enabled, call it from
  panic()
- Link to v2: https://lore.kernel.org/r/20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org

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
Casey Connolly (6):
      drop unused kallsyms support
      add support for symbol lookups
      lib: vsprintf: implement %pS format specifier
      arm64: implement printing backtraces with symbols
      lib: expose unwind_stack() and call it from panic()
      qcom_defconfig: enable framepointer for backtraces

Heinrich Schuchardt (4):
      cmd/exception: missing include string.h
      arm64: initialize the frame pointer register
      Kconfig: make CONFIG_FRAMEPOINTER available on arm64
      arm64: simplify interrupt code

 Kconfig                      |  26 ++
 Makefile                     |  24 +-
 arch/arm/Makefile            |   9 +-
 arch/arm/lib/crt0_64.S       |   1 +
 arch/arm/lib/interrupts_64.c | 146 +++++++---
 arch/riscv/Kconfig           |  21 --
 common/Makefile              |   1 -
 common/kallsyms.c            |  42 ---
 common/system_map.c          |   8 -
 configs/qcom_defconfig       |   1 +
 include/exception.h          |   1 +
 include/symbols.h            |  31 +++
 lib/Kconfig                  |   8 +
 lib/panic.c                  |   7 +
 lib/symbols.c                | 143 ++++++++++
 lib/vsprintf.c               |  25 ++
 tools/Makefile               |   3 +
 tools/symbols.c              | 646 +++++++++++++++++++++++++++++++++++++++++++
 18 files changed, 1021 insertions(+), 122 deletions(-)
---
base-commit: 182cb30084516c3085d2ca5dde3f105f7625d774
change-id: 20250725-b4-arm64-backtrace-symbols-af9579214288

Casey Connolly <casey.connolly@linaro.org>

