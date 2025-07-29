Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2108C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A65830F6;
	Tue, 29 Jul 2025 18:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fHjH9c93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB8B082EB8; Tue, 29 Jul 2025 18:07:36 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEC3A8304F
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45617887276so33205385e9.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805253; x=1754410053; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XguFqZRh7gq82p1kqovvdUdbkh1oLB7V6BzKotbC7gM=;
 b=fHjH9c93B6ELDIsps8BPTjd5orZ8XnkM3Dn6dvTr8/N7szTrsr/lqipzonB1e+LeGu
 0M/8ywWObBiZyEu71SevpzHpVr58FeO6MrZbYOgT04YkUz1zn1U6T3UwCpaxof5/3+7x
 Ei1hVKoTOMrOLM3p6+lFMCYY7sJe1+yxcXgUAWXVHwrbJ4klbTOLrFqtNdD+XROqggc0
 /ksj29+imKJOKj6lwZ0nR8yU73tptV5DLvyWoVIEv0Qgj3Nca4pKyqoxZVozn4hOccwY
 zh5htM8hUl0rkDjdONRYFLBc3MCHNpDFXSUWmBUSTNuFcdCLOyM5uO+GyW4UJsMzxR76
 a/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805253; x=1754410053;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XguFqZRh7gq82p1kqovvdUdbkh1oLB7V6BzKotbC7gM=;
 b=ilioBosXw3rLYJ1AU6iEkAfcaUqFpoV9DK7k67wNh3p68czZ+RKhXBrly8p8B+tY7h
 iNnQ4JM20jZZjACbzf68NceE+7KHFuVwZRR7k5qVYLp5IAkotoME2PKQhSY4F0T97f+v
 +4yQANizBtm1gkyyWjWSfUtQYUTjh37IuNwPzdeYfLFvvGP6Imvmust+DBjzEw7/wJK8
 1OsdGVIWjrDJtTugiVuRA2RFq39aREhIuijaWVNs6sDUj8TvU8ckObQEkGnUq2thyZ/8
 GyotRQ9F973Y/vkeJ1WSLT2zBYmTs6CsA8YT11vS41tBuH4LKQzbGuevU2th1eHAaEQA
 SRHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWJkdkNICL3m7tXPSyNPld7+QoK/+eVg+rHmlNdIoCQOrIQtQTTqZaBhnFiIxwjX7NlGtO6A8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1ZmoLZb+h7DO9aPFxgj7g2JY4fJ4zbYD6jIjRL46NqmAWGjnG
 TQ5bvkK3RmXRm0TUN5ZNWu0i8ZHQoS6bKuo+6HTtS+ZnLxoVlqhtlvU8Sq4WYzd9U33yH3V++0G
 WCEix
X-Gm-Gg: ASbGncs1aRvFTGOMzXOWbgFuAEPjjzn4VlPASVYjF0Q8+Qb9B3r8j3rxKBV5Cky3qhn
 UkIe/oWkqtOwtgdNH/MGEkF7ipy6yTn5GWmxUhIYlA67JHtjWlCRurkSItywFwJI3l/MlXCxhb0
 22B1pip2Yx/u7jafyuFv3bzvIy5Uq38FrdCOkZ/OfF5lkjJHYlEIKPKnXjDVrBdftTbh/Z1b0Rw
 MKePVYhEKwqhtHJGObRGGUMkQ4zncy6Pbi0XZhD260lc6j0Kew8MiLLBrBou95ilH4VuPY9ycwE
 fR+LJQhYiwz4mor/c12BRO6telyRCVU0ilh8U7xPDg1CG2Ro6del0NnYasQ9GYBnA+n6Da6J7OW
 UsDZRe90QxChQ53ntVwMUYKAVhiC9Wpf9oj2u4hj9pAFjXoG4PnGHVRtlmOHLCZenpznGumMzQo
 YpsxruV00+cQ==
X-Google-Smtp-Source: AGHT+IGaK2OK57zD5djgKBJIvvRg6y9ZjB3svNZ3BeDhrRVajvE0bgQjzLaj2o/anQREU8n+m3Fhbw==
X-Received: by 2002:a05:600c:64c7:b0:456:1752:2b44 with SMTP id
 5b1f17b1804b1-45892bd2722mr2856205e9.23.1753805253248; 
 Tue, 29 Jul 2025 09:07:33 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b781d2fc1csm10512075f8f.5.2025.07.29.09.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:07:32 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v5 00/10] arm64: stack backtraces
Date: Tue, 29 Jul 2025 18:07:21 +0200
Message-Id: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALnxiGgC/43NvQ6DIBiF4VsxzKXBjx+xU++j6QCISqrSgDE1x
 nsvOrVp0ji+Z3jOgqINzkZ0yRYU7OSi80MKfsqQadXQWOyq1AgIcFIAx5phFXrBsFbmMQZlLI5
 zr30XsapLXpSQM5ASJeAZbO1eO367p25dHH2Y968JtvUQOwEmGChRpRCcSK6vnRtU8GcfGrS5E
 /20yr8WTZaogUtNWW2l+bHYcYslS1ZSV0paAJN/Weu6vgGr3rtNXQEAAA==
X-Change-ID: 20250725-b4-arm64-backtrace-symbols-af9579214288
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6232;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Op0F01B2oUSVhaE2ozgydQ1gj5c41JhygobmXCr1/Vg=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiPHB0Nr0Oz3bSFGLtwOtZAnwfYQbqs12Yb9qv
 H4Ygt6FjHmJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjxwQAKCRAFgzErGV9k
 tpW2D/4sPL1ZL6nlB2Md2tmHUYG/Oc3nsTpGgQMhmKTtEYli2zCFRj4hcFIqWacGki67SEbo+ut
 q8JwwRwaGRJydL1ous9JJxoHhgR9QiMMU6wmALAPuXK1fN3R4QCyHT8Oxb8KavkfVYcb4ZlQ94y
 A7KZsp5e3IAma4Dt/9zTRl4MgVuBguODSJmg2xD4FDN1+ZD1C7iYHIrAPS7Viqb7eIhXVFRnGna
 9NjlktX7JRQfQVjwoLvVD7NHkqCDoeIvHgS1VZY131qYh9sKpMWTD1R3YkhRUzJB7J92ZDqrppO
 Q/cU3Fzy1JSqHOjh0uco+zuo3KyO97RWNOEpylcbsaacyn3JdeTjZglfLlXMYSI8KIp65ZcqVg1
 W9TYgc7Jk0lJwjdUMsdvA97ZhnixYGfwkDKY+kSegXNTU0OrWzAoUKsFuQgHybNl0NYxZj9SczZ
 a0KAtA/BAzY6fxykAI2reXFjSjmdoYwMWgskxePP08Ww+c6ar31D657titVrBhQfoE1niWgnuuo
 oTR0cPn2vV61omWBnTcBWlchzTQ5aGg7x9o0DgwrkRl0HhuEXLlLMG4ChjgtlD78csK/b/MKlkv
 vDzIIo2SBJ34d5W1L4fikVjq18CsHd36xUS4BExVWR0yF5fXmA1hiArfWg2zeH6KgQlPrfFTY9j
 BizM0q006I4pdLw==
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
Changes in v5:
- Fix bad fixup with changes in print_sym()
- Link to v4: https://lore.kernel.org/r/20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org

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
Cc: Casey Connolly <casey.connolly@linaro.org>
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

