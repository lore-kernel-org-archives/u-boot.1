Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F323BD60D17
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88177895E2;
	Wed, 20 Nov 2024 11:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RdIeEAWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33AA3895F2; Wed, 20 Nov 2024 11:02:27 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CA26895D2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53da24e9673so2285348e87.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732096944; x=1732701744; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jCg84BvrkY3a2v3KeHxijlV+1Y2r+avk2JXOwJB4ljU=;
 b=RdIeEAWFDgo10O776PhWAtA3yuJ48bI23nLIoesL0JsL60+iyR3WXlygwi0EfxrR7z
 c3zobY8+63jPIFGo4rDdJYPKmBk/b+VMK4rF428UKqW8x06LFczuXPKkBzu9mDXzmod7
 Pz2sP9+Dfd02FRQSLQxKY4F6NGlv2S3doGH2vPJUSWo4V4NrGlYrLdb5v8idYxQN9JnH
 PvXUL7+QCoT77cHyKDdYjkeJBka6rl450DUjeq5J/apY6AhgbAx35UsUAcO2xZ3KxoMN
 EBqGkka+xSfrululKDaQJC004B2f8mhutQXBroufDVr9OQ6cAwoG4gqEQ400Xo4czw0V
 vfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732096944; x=1732701744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jCg84BvrkY3a2v3KeHxijlV+1Y2r+avk2JXOwJB4ljU=;
 b=grCccX5uSEfhiAQhymF63H8jEn8cFksrQZL4BJlKjHG6fdXDrtgngjh+ZVHiYN+8XL
 TXx7NjB/Uda4gMrtX5caU9foUtPIf3f9UfRjbN4qhVzyzOtYp9A9wRrLQ+qgjqzmZ3Qy
 mMKJ8/v3VADyQlJ27pEYsfZhH4nsO6wdRFY6oEJ9zVNo94RpZDs9l9PuoK8cQawHR9OF
 RLzblJlKNCuflcXk/4myti0fCTCEL3lAZnoz4oyIiTuY8OkEV/JLqrs7uMsS96u7O10Y
 awodwZ6o8XrloTaoWd89IehiHJ87Fw5dv/pDzRQZdxcT2r4v5SskSBS7LUH1UO2rN5EY
 dLAw==
X-Gm-Message-State: AOJu0Yz/bInFCJW0bv8YEkiu4Wt16yOBOABccoD9GGx3oHNN7a3MFO6U
 bjpRtupfbWoNel04jjFn643nYXdt0aZ8GdQd+AV2uark/U4aD5uce165a18/QxfT5+bNMI7CZ79
 6yVVqyA==
X-Google-Smtp-Source: AGHT+IGc/T7SXm6OkvH62sDAQAAxlqYnGFKUaBspMq2lauV2qmCTBSzLLcJ3G2tTX9ooVaf8SgDacA==
X-Received: by 2002:a05:6512:3d27:b0:53d:a93c:649e with SMTP id
 2adb3069b0e04-53dc136a0demr904491e87.35.1732096944208; 
 Wed, 20 Nov 2024 02:02:24 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:24e0:2f5f:4be2:4309])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45fa706sm13572655e9.16.2024.11.20.02.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 02:02:23 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 LekKit <50500857+LekKit@users.noreply.github.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3 0/4] Select CONFIG_64BIT for sandbox64 and x86_64
Date: Wed, 20 Nov 2024 10:01:53 +0000
Message-Id: <20241120100157.485418-1-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
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

Picking up a series from Dan Carpenter and applying requested
changes for v2.

I had previously set CONFIG_64BIT for arm64.  This patchset does the
same thing for sandbox and x86_64.  (Mips and riscv were already
doing it).  This CONFIG option is used in the Makefile to determine
if it's a 32 or 64 bit system for the CHECKER.

Makefile
  1052  # the checker needs the correct machine size
  1053  CHECKFLAGS += $(if $(CONFIG_64BIT),-m64,-m32)

Changes in v3:
Added a new patch 1/4 to make fixes to the source needed
by the sandbox patch 2/4.
Updated 3/4 to account for x86 being built with a 64 bit
U-Boot proper but a 32 bit SPL.
Added another patch 4/4 to fix an incorrect use of
CONFIG_PHYS_64BIT which should be CONFIG_64BIT at the request
of Tom Rini.

Changes in v2:
Resubmitted by Andrew Goodbody with changes requested by reviewer

Andrew Goodbody (4):
  sandbox: Correct guard around readq/writeq
  sandbox: select CONFIG_64BIT for sandbox
  x86: select CONFIG_64BIT for X86_64
  test: lib: Use CONFIG_64BIT to detect 64 bit compile

 arch/Kconfig                  | 3 +++
 arch/arm/Kconfig              | 1 +
 arch/mips/Kconfig             | 4 ++++
 arch/riscv/Kconfig            | 1 +
 arch/sandbox/Kconfig          | 2 ++
 arch/sandbox/include/asm/io.h | 4 ++--
 arch/x86/Kconfig              | 1 +
 common/bloblist.c             | 3 ++-
 include/limits.h              | 3 ++-
 test/lib/str.c                | 8 ++++----
 10 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.39.5

