Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705ECC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E798A88BC7;
	Thu,  8 Aug 2024 18:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d8jeSANx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9B8E88BC1; Thu,  8 Aug 2024 18:21:29 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9513588B9B
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5ba482282d3so1455288a12.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134087; x=1723738887; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ip6TgCcpMt8nf/GRSkOUSlUR6Ev59ND2JfSI8X5le1g=;
 b=d8jeSANxI8dxnMa7ZuWtLdbt83hOn8jns3EpOLMKP6lS3HXwWBoYXQfAXFGblADGlk
 pi5BFijaM3EtIgXm75RJqKrpiOKd5WRjmYDG6/QOQNDABSIgireRVIuvjZOxg4O0Na+g
 ptcCLt5xQ8IWmHvBjltRfCGtaOZZk1jxdPq4p+iC6Hy32LkTSDXZsSueT/ZCXFGul8UH
 l22dGxWlOPpMVIwpVVY269lE04XZ2052orzzyyYNLbRzjP3XX6Cr1pXqL6VP4ZrJdBFd
 aOMIpxOCCiclHE+6dwiWAKA9ZCKhcDdCAq5/6ILkgtgz9fo38brmo0Cw3TD3ZMd+WLb3
 NcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134087; x=1723738887;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ip6TgCcpMt8nf/GRSkOUSlUR6Ev59ND2JfSI8X5le1g=;
 b=HzpVgof69uJJxa1wxUi/v/aJd7G2WxL6eXIeXhaR834IPKSMvX0hXNWBIcqYm1AAHq
 JnA6/nu51xxBfJCM6n3GlN9DgDiY0HDCKNg4SUpfL7dP386aGi/cwQ7Gx/8vVUzbHR0k
 zFh5tiqCqI64fguwQW6uMoQnlgN8ia8MWDdIUUur6gifCzUUzIiACdcowbR6B7otCNIj
 hukwhD0w/EN+CbaPmIUxmna4aa2ig6YfMFEMdCyKwhPRQAu5nYN2+oE+FW1X+iPrqoox
 VjU0mlLpY3ih2qcltg/GMqnw82F8QV1UdhsglG8NjAYW7ZeybxPCmAFOHHczNp7T8BPQ
 eVvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJmVynLp9H9Jp+dekQ+oIz8VC2bfS2gJM8kWXaZd3f+0z7f64vfW7j3vhHijDdqZUcAWqQMe4=@lists.denx.de
X-Gm-Message-State: AOJu0YzgKtjC1UrzbcXhDG/3W5cbEXST0mBwXJRNx74GxtAH9B59uZWs
 1s8q4XG2LJ8tLdUNCqUXgDLQDwGy01UAsPcusQ97L06TBvVgBw1lndwccvTAIayRZZuP4caiq8K
 dVM4=
X-Google-Smtp-Source: AGHT+IHL4i736b5HL9BfL5TfJWvjPXTHNqH0HrfJKwGxIaSEqc2N6O+OPGPzmQwtFZKDP6oER4LLKw==
X-Received: by 2002:a05:6402:518d:b0:5ab:3174:9e1f with SMTP id
 4fb4d7f45d1cf-5bbb21a418amr1930030a12.15.1723134086643; 
 Thu, 08 Aug 2024 09:21:26 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5d76dsm770396a12.80.2024.08.08.09.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:21:26 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/3] ARM64: add symbol name lookup and print a backtrace
 on exception
Date: Thu, 08 Aug 2024 18:21:23 +0200
Message-Id: <20240808-arm64-backtrace-v2-0-29665a2265cf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAITwtGYC/3WNQQ6CMBBFr0JmbU07KaCuvIdhMbQFJio1U0I0p
 He3snf5XvLf3yAF4ZDgUm0gYeXEcS6AhwrcRPMYFPvCgBqtbo1WJM/Gqp7cfRFyQeEZm6FtrO+
 9g7J6SRj4vRdvXeGJ0xLlsx+s5mf/t1ajtKoJe6q1PdXeXx88k8RjlBG6nPMXFUTAs68AAAA=
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2932;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=g/XScmJ8U4dE2e3gjQH6UVeT6tcCwve7hvULv32gg0o=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtPCFWe2vVRLAWsaH1uk380TDPoE5M/cYryQFs
 PGXkAT53BSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrTwhQAKCRAFgzErGV9k
 tmR/EACXPLQQM3XLs4XDIXsVa/CpIU2mXqqzV7v2EOB+0V3nQNecW1r+HjMerTc6hzVouFZt+M1
 pdJJSN+Srfc/XrK0GjIiTtQ9AGEPXzgmzrGIiJdZWRZGuoajG1NVKgjvK2v2rclw0brbWd8gpvn
 e9dX3QPTC/8LUq0ugdE+cOc6lU4iMkMNC6xD2j/dg9G6Xoxh81nCG0Xg0qRwfUbPdKGiJv15TSJ
 zvdaR35QYlaksrNFqYV+s660HJG4JlaVBVrDu2K8JaiI6lh5kCxw4ZVI3LW7VTsyiQIVNPeltkw
 aN6ZK8AaQkLR0b/7YIgF1SyYdXz/EtjehgBT23py7wVTfz4oM4OIm1DjRdcy7Ye2c3Gu/HDM5gQ
 7+s+VT9eNBM2U/XnoiWlYNmUMr12r1Le+hM6XGIX1Xkozrf8ldFt7+RGrXqAPGtdvTXyLdEclS5
 d+h+ttxTJ1iU/Q0BXjtSeqH+VSdnuRcavMZp2U9KLQjdIj13shdromm6YcuU3VXSZxrDh0oYUV1
 W/CAFnL4PTH39X7OtGN7loCJn7XMJun/wCM6qy9hgzxnAN074x3kWAqvR6bTTCy1eCa2WQEl2AQ
 ahFZ67gXxJvTP6cdn/TkYn9Z1PWRFiMRkngkiz8f9jrARZ6fl61K0bAth871W273rdHcNgxXGWz
 MSSIDVAm4kgGIKQ==
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
Changes in v2:
- Remove unused last_fp pointer
- Apply Tom's suggestions (cleanup hunks, don't guard unwind_stack()).
- Link to v1: https://lore.kernel.org/r/20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org

---
Caleb Connolly (3):
      drop unused kallsyms support
      add support for symbol lookups
      arm64: unwind stack on exception

 Makefile                      |  24 +-
 arch/arm/include/asm/ptrace.h |   2 +
 arch/arm/lib/interrupts_64.c  |  75 +++++
 common/Makefile               |   1 -
 common/kallsyms.c             |  43 ---
 common/system_map.c           |   8 -
 include/symbols.h             |  19 ++
 lib/Kconfig                   |   8 +
 lib/symbols.c                 | 126 ++++++++
 tools/Makefile                |   3 +
 tools/symbols.c               | 646 ++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 892 insertions(+), 63 deletions(-)
---
change-id: 20240710-arm64-backtrace-2926f764dbdc
base-commit: 13f9c5668411aa18ef64846d5bc86e9e6be52082

// Caleb (they/them)

