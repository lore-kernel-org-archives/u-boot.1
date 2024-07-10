Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B414BC3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 16:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0ECB885F5;
	Wed, 10 Jul 2024 18:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yBLOmgsA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8523F88025; Wed, 10 Jul 2024 18:26:42 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9970B885F5
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 18:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-58be2b8b6b2so8274428a12.3
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720628800; x=1721233600; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5L/oIEp8BuPbA5/x6FBO/nnZzURFUSmD/fvOSCPuJ28=;
 b=yBLOmgsAonWTxuCKTtPZVDnXKzopjC5GEgQt9rcaEKjlDL8lcndw1OMDpGU6i0gT+H
 seAB6q+lsn8FX31BE28XtSq8v6ypxujUZkD2ssqVwowXb1tytymR5Cu3TABDJLqOGEQ+
 IjoUQvTg7dfRqQ0oBjUpp/cmIgl74SWV0Uq2uLu00RYDdbiX6niljDTTuf1e7Is/F+rd
 dpgvapJC8k33VbDyxnBXogSJQyG+lwsx6fOPvmwGyf2nG/97qVDH0oPT83x9t/lBP2k6
 CUdrKEKyfH7dO9SBRXIvPF1KkXAsDzcCLgBmT0z7TaTjntfI9B5ldd5U/kwL38xgZGFL
 A80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720628800; x=1721233600;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5L/oIEp8BuPbA5/x6FBO/nnZzURFUSmD/fvOSCPuJ28=;
 b=R3qTF7gJRTuQsYPCX6rW2yD5vBBh1cyfUgdaZO9CkUnLBilj5PvqcwDlc3ZvHReEi/
 /6q8nxdg+s3Liyq7Fyn50h/upGRzeuxRO9a+IuzkLPZkJvhGbpVtK9O++MeJe17I5Iqs
 x6nv8qr7bk0UCfZd3kLsvUMYEjY+Y2NUNSCap1E4N7tFVfpJwjYuUSxoYoShX6TOQBJv
 QscRA7QuxK7Vrc14vn9/krJ+LCYzvtgf5+NzW94hMGMrPc0RbdZdUyRDZ8GCnkXcwi9f
 7OrQwYZDGEnvBybSwKotV2YYkYTPKQ12EqNrPcd7I/OtAVClbksb86+/fEWHKtYS9z3A
 SQ+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL7q1MYqXDZaQtt6TbUei2WXNMmttDDYOhimcizZZ4LdwmjVWy07RPdtdCy0qN3Xi0wHd1V8xcG99TXCYC0G22Sw99yQ==
X-Gm-Message-State: AOJu0Ywy4dQb1/ouxlWnpuuFxBslYH1WtmOw6xAXqAPtgKRqEsC/zaxR
 NpafW6rf9LDdcj8fJKODSS8zoEo+VwkqN1swP/rQIV/FGS3Bu4yEFdwid+mBHrw2ySPrQ7zK5TA
 1
X-Google-Smtp-Source: AGHT+IFz/yEfWOiqVSIW0xu20TjTJ7vOMZ18f2AACHfVflDo++Jby9z6iHf6Re11Umqkxlw0qkB6jQ==
X-Received: by 2002:a05:6402:1eca:b0:57d:5098:c7a0 with SMTP id
 4fb4d7f45d1cf-594baf9120emr3999735a12.17.1720628799675; 
 Wed, 10 Jul 2024 09:26:39 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bc4e8255sm2370348a12.48.2024.07.10.09.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 09:26:39 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH RFC 0/3] ARM64: add symbol name lookup and print a
 backtrace on exception
Date: Wed, 10 Jul 2024 18:26:17 +0200
Message-Id: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACq2jmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0MD3cSiXDMT3aTE5OySosTkVF0jSyOzNHMzk5SklGQloK6CotS0zAq
 widFKQW7OSrG1tQAPccp9ZgAAAA==
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2749;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=1jixm16E07C3IhW/OBt7Yx5vOk5TV3n7SllsKFzzLGs=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjrY+UoneA1WfOLu5zZyPTfBjriGrqQIINLhBS
 ZicPC7bv4OJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo62PgAKCRAFgzErGV9k
 tpHID/9zU6+ye93OER2YelQb3RoGLZLdaHAp9wztJfDURBOHr5vhdFVqlP+eC3a49Qw5u86GZNY
 4fUreHK57zMCx83eHogVfB2h6G2cHLDg+gm8GWj8rDgkQJc2cc4+JjsCENKryj3NYOPrtcKlnif
 wv8zNFf7h7iSFCoIMnJsyAjawygXMfx+y6EoiOwm782tTcCGzD4UjhXoH4jKOjN0J+CAgf8egIh
 YjGNsXxjg+aDc4ImA5b7sphffljSLtLhE+yrSBV7nU8Ij1ZDI3r/o9SEpRNJkSGtoSJYp/CmnOC
 vQcsOcqb79TuA9G2LJ62M3E0+o86C7+uefbbLifs7sE0WTrhhVFFcEmrLz+6hPdg0QeeqXJ/kiy
 oB3vSntjhNL5CWoTRMPNiM//eZcHFkek+j6eZgBLYkY77S/ZfBfzR/nMUNeJEDukHun11enzMKd
 H9Gj9LYAIeddAshlRaLGdidveWCqHo5ZJ9VWhN/neEy9KpllaGL1ntAbxeeawFF1+YW2Kku8jmS
 eNADNrjr+1fJ4PcU8LiQH16P5Qufr4QngjMPM1Zd8JF6xHixztDR6tuUUSXzWdUp4R3p0mAKJA/
 6sye28H/pgxB+B39zQzJHuAb9cG25OQ/ITvrIgTUvLCm9cRWQvWVef/VUDHYSJa4e/3bC8WuDrt
 KBIxpaKCTVPxKUg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

U-Boot already emits frame pointers on ARM64, but lacks the code to
parse them, as well as a mechanism for looking up symbol names at
runtime.

There was some (seemingly?) leftover code for symbols lookups in
common/kallsyms.c and associated parts in the makefile, however it
appears to be entirely unused and unsupported. It relied on generating
one long string of all symbol addresses and names.

The approach taken here is instead largely based on the implementation
in the Xen hypervisor, it performs basic compression using non-ASCII
bytes to tokenize repeated string segments which can later be expanded
back out at runtime.

This is then utilized in the ARM64 interrupt handling routine to dump a
backtrace in the show_regs() debug function. As well as providing a
general purpose unwind_stack() function which can be used for debugging.

== Relocation ==

Since U-Boot relocates itself at runtime, and can be built to be
position independent in the first place (effectively "relocating" itself
when it first starts too), we can't really rely on gd->reloc_off.

The approach taken here is to subtract CONFIG_TEXT_BASE from the address
of each symbol in the lookup table (while it's being generated), then
when decoding we just subtract the address of the _start label. Since
this label address is updated to make U-Boot position independent and
during relocation, it allows us to avoid re-implementing the relocation
state handling stuff in the symbol decoder.

== Size ==

By default this feature is off, and will not effect the size of U-Boot
binaries. The generated symbols object file is ~85k with the (fairly
hefty) qcom_defconfig, so there is certainly a cost to be taken into
account.

I hope that this implementation can be later extended for other
platforms. However this is currently beyond my (skill, time)
capabilities.

---
Caleb Connolly (3):
      drop unused kallsyms support
      add support for symbol lookups
      arm64: unwind stack on exception

 Makefile                      |  24 +-
 arch/arm/include/asm/ptrace.h |   4 +
 arch/arm/lib/interrupts_64.c  |  76 +++++
 common/Makefile               |   1 -
 common/kallsyms.c             |  43 ---
 common/system_map.c           |   8 -
 include/symbols.h             |  19 ++
 lib/Kconfig                   |   8 +
 lib/Makefile                  |   1 +
 lib/symbols.c                 | 126 ++++++++
 tools/Makefile                |   3 +
 tools/symbols.c               | 646 ++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 896 insertions(+), 63 deletions(-)
---
change-id: 20240710-arm64-backtrace-2926f764dbdc
base-commit: 13f9c5668411aa18ef64846d5bc86e9e6be52082

// Caleb (they/them)

