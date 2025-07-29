Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F8EC87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5570E829E7;
	Tue, 29 Jul 2025 17:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rdejn7bE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4E5B82BA7; Tue, 29 Jul 2025 17:52:12 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7BEA81E14
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4563a57f947so7235e9.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804329; x=1754409129; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XmFoVS5npp68ax8rGbe/2Fk9yEYAGJaMi95SAZlzFvo=;
 b=rdejn7bERCtriKjB7FELJaZ2UM9UZeRFXAVrQSFshCK7ianwP1vMQsOjA5uMqQAkXa
 3x5bzjvgt3VT2mPahl+57XQlfJ8I9hgYyHQDce3G8tS6YqvBdtt3bQuiLwg2jIi+PtnJ
 aKFEc/Q4Dln/EIPETHDAoD9Vc2hnvELHs0osYsgGWGsKIJ0Lhwt67eAL6hrr4nszk20z
 xKro5E6L3RGaJRUa+IFy6u36/Xl5Ne26ZCDDy7POusn6I781LgX+EMW0osDrd68HrQ3Z
 FiQPA8rw+9FrJymZgRYHozLalWm64DFTTN4bNtYi6xwJSa9upzySQF0aqFFq7joLyIzA
 4MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804329; x=1754409129;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XmFoVS5npp68ax8rGbe/2Fk9yEYAGJaMi95SAZlzFvo=;
 b=fXX6sjHk15qUqXeTBMHBf7eNt4kjdf0B2Z9UaVxYj6NYwF3+ADwSq2clwtmtUbNnkg
 gpPK+/60hPLwSx49b2/ilsPfAwdKHNKQK7JzrEQHS/VtPi9P3fcOBq7KJhCSuH0bnUiu
 yEl83w6sTAz619T1ng11xYWMXEruWut9O7l/EgzsVOBwV2RIj5o+obK6X/Sqfuk57Xhd
 qyXKhTxvlvJFll2IalHNsLEH5EB59aBxY+N9aIwQ0hXNaj9W2eysTXBV3MJmaaZajKgP
 bcS/VT23YQvf9JBRdtCcU3byC7GFaVu80wJVqcwo8lfcQlEyCb84JplojvYbzkCu7nyq
 Xtkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx/MhiNSb5mbHkiYavVZ5TYKiWN6qdOEoMJCIkmM2xfyBSqGwa9v6FzRicYQMqeVbr5ilTGKY=@lists.denx.de
X-Gm-Message-State: AOJu0YyPbP8NZeDi/2WxWMwe3xDNUMBMExIyM2ETMDR855dMRhzYHiHZ
 Xg4zcNHB5R90jgBnIXhNnd6jrJcL3y0JzXYQ00x32tWuA0+iu/iq45vZMlckY0c5urwFsMphHL5
 5ID2T
X-Gm-Gg: ASbGncv745VuDlN8AEmPdTyMr5NCD4Eeon5M4YSP1KZhKYdjrURmSdf9YlYzJTQWmiZ
 Ar5gtqnPuV0d7c20aGwowu8vv8teDkQSuZbJc+BtgXSkPTB2qePyqWFPY6PQtNDC5Za9MBOGh6I
 JDkqbuqq8hRewwYHPVGXQjapMHRyq2JrJTazRG7J/swi2Frtmp4WnZxStfdjakCcObeNFFQIBGh
 0jpv7lqWbr2OHB5kX6DlKnc/uFqJp9wM2Nr912m5oCX3woN9T67ZZCaz+lJ7rlDEfKAvnvG6clh
 6uXaygbL4T2dPT/WvKkyfzVckY9e+JhM9BrmFlbpQlZ+tGnJKe+cw6LDjWrGA4GiRO/bND8Bi+I
 sNS81Uv9/yTVKQ31ZO2H9XxawKxXlrXIFaVIYFRDemW7P05D3GX9yozGSV2qH0cQzwQwdBTkBBB
 ju2yJhi+yOokdgKWizr0p8
X-Google-Smtp-Source: AGHT+IGewgScwyz+fECBygMbB5O16FfNW1WNt3NB2LHGrB187qJn4Xh44qdLUZ/xCaRLR7r4dfRhBw==
X-Received: by 2002:a05:600c:c173:b0:455:f7d5:1224 with SMTP id
 5b1f17b1804b1-458930f7d85mr280485e9.9.1753804329008; 
 Tue, 29 Jul 2025 08:52:09 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588dda59cfsm18948535e9.3.2025.07.29.08.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:52:08 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v4 00/10] arm64: stack backtraces
Date: Tue, 29 Jul 2025 17:51:58 +0200
Message-Id: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB7uiGgC/43NvQ7CIBiF4VtpmMXgx0+pk/dhHAChJbbFQENsm
 t67tJMuxvE9w3MWlGz0NqFztaBos08+jCXYoUKmU2Nrsb+XRkCAkxo41gyrOAiGtTKPKSpjcZo
 HHfqElWt43cCJgZSoAM9onX/t+PVWuvNpCnHevzJs619sBkwwUKIaITiRXF96P6oYjiG2aHMz/
 bSanxYtlnDApabMWWm+rHVd3/sNjJ0RAQAA
X-Change-ID: 20250725-b4-arm64-backtrace-symbols-af9579214288
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6015;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=b60Mw6lJDUHKnStQ+VFZhxwBzW/tLQRCbj2v2LQu8vI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO4j5VcZeMoEXJkP8by9sHtLzoymLX/vCB3Cl
 ExBZSefXRCJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjuIwAKCRAFgzErGV9k
 tsY0D/92b+9gC/y1XYxqxwG9qWBt6uoXmRkDXZqEzFV4f0hkezPDw0HEr9PpfvswSgNHbclH066
 BtEWs2/X/YamurP8Se6a1Sa5O83rW/pvtdZTXwN37IB7dbG66UiVx227DHkS3gwtToUI3rG/cy+
 aIyvIr9OdCcl3Guk7iUN6lt8QHfeoHva0MupeuoeagYMtgmdpqP7k34MPLQUEYceIqCPquunxzj
 YVI6boy3j0C48Wu7lJmdcafYJCadgy72Wkfn/I9EQ0muCWcQDq8aQH4lIHv/EOgp/debHntA78x
 TJhNYHsHNH3PDQIjEpGGLIg1UPKYYXlhwKpbOKptJLSD5d5v3J4kmdXpZfxWD8+sx9BtIuFjm7I
 5Ajwz/a7K4xZUM6GHoalApkI/fcPvGtS06dCblA6eufPUt7hyOFO8d7UqIu/s9fgXlgTjmR4mUS
 sb8O/obZ+XwfjbyB5Vzaq5ddxRfnizIcSWvk6AO48CvXcC+60nclnC4z9P9tJTpG1OLj728yHKk
 DCCWSUm2X0y8ulLq/ZTfJCc4lKJkxuF82nEd/wH2b1xEfLHqH/GAgusuzIAZ7vuuhBlORUTZGsi
 lofaFoJjwf6OnEG3M/Ac8Xb0DLEA8dEn+ejJb4Qk1Yf4Gzjbw27qWH/2b8P8LpvOhfQGBEL1GfR
 HnmLlYOqe3SXNSw==
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
Changes in v4:
- Remove unnecessary call to symbol_lookup() in interrupts_64.c
- Link to v3: https://lore.kernel.org/r/20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org

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
 arch/arm/lib/interrupts_64.c | 141 +++++++---
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
 18 files changed, 1016 insertions(+), 122 deletions(-)
---
base-commit: 182cb30084516c3085d2ca5dde3f105f7625d774
change-id: 20250725-b4-arm64-backtrace-symbols-af9579214288

Casey Connolly <casey.connolly@linaro.org>

