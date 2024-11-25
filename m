Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D406D5806A
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 11:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1395689A32;
	Mon, 25 Nov 2024 12:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G0MVngAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B798A89A34; Mon, 25 Nov 2024 12:56:27 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6BD989A31
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so39626525e9.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 03:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732535785; x=1733140585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mK8XrJIHh0NqaeGQGqZph7D4cJAJlCNB4jCXvQFzlr8=;
 b=G0MVngAB9x/Ygd/eI8hzK1iqSnj25imBmirHmBsxEJZ6CYksGbf4pcd9E3Ky3BNozv
 G4P2X+/EZl3D5qBHd8EtofX+oqfnaeKDwfuauNIYoaf2CfmltpG194z5jaCaqN9r4YmJ
 pS7+GSfR8CDKiHiImJo0C2fCMMW8s3nWirymMOB+KD3T4j9FKDyzbRfXl56VpTNAb+jt
 yqECRu2b+fMbiLaSaeBTZN2AZEK0aedX6/eMDlD57hkXiPkDBhB3CAaPv5cNThnsJNBi
 6wX6M9EdUBMuqSFLJUlCeFzub6BdHqL2xah6tEfDYiHh9O2tnfKdCTSZo44laK7ApaoW
 BJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732535785; x=1733140585;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mK8XrJIHh0NqaeGQGqZph7D4cJAJlCNB4jCXvQFzlr8=;
 b=bwDkHKQ7cg8dAsEaUDsdFKG1jNuFiPtoHyUfI2W+nTmUeIznS+cv1UcSFe6TaWxJIw
 p0qGV0l/4T6Lx7jqR71rF7eUyg4QzfKiC8rSBR2R9FexOIuEQzEJN2ktBQ1amILGpSAO
 eD3+wHCngff/hQihGaAI31HtmXPPauN1Gf3V/yWyWciU3zyN/lWYQqG1cTd6loFnWD4+
 Q+YMYpZpgRuwDiAC6/xKwvE7nN3yF8yp4b0jXG8AwTpbbEd3+Gq0nySPcNhtuHP6JOgV
 xZf/JnYy3jVKZ7HWN8d3OVhkXmyslE9i3ObqvRAZyWJ2GT2O4ww8AtThtzRfmJKWOXZZ
 ETzQ==
X-Gm-Message-State: AOJu0YzOexIbXbUUHFuRsavtfU/7LoicxiZZEJPereHZnIOLN2pf4adc
 XpokIshz6Gg+sVjiNbfw2V9qCc9Hs2iWiuXO3ijQOLLQBFCYAggy/1UEK1ZXBQhUfjbL7Dp9du/
 j4bhPhw==
X-Gm-Gg: ASbGncsZ0Fxg2WUPPUoET1keTMnPnTqlP0HA1PY232KssrjolbpSN+8H+jHiLXGG0E0
 EP/zYm8PHvdosqxKoDIRp1TdWz07zWofD+U7NhDv7SsRE7DbRx/Fm5AauWkoz6ffsNk3JthUmVq
 5lD9saV+6kO66kIgjITmryZPUuBqXjPcXnM8cWTsd11SjTeD7G5twQeGJipqrxNMTWXy4f1PDxQ
 IABElknlyzwqmkQeZj8ucZIYFQOxOv7YennpICJ8QCyPP28BdDleIGmKdDb5b5AuXciOg==
X-Google-Smtp-Source: AGHT+IH3fFCl+L6y9Vy3X+NH6bAZ7r7lvmmRMK8YmFvIeJk/lhExH059bV8KF+EVS/8AJ6V4DozYYg==
X-Received: by 2002:a05:600c:3516:b0:432:d797:404a with SMTP id
 5b1f17b1804b1-433ce49105emr95045595e9.22.1732535785101; 
 Mon, 25 Nov 2024 03:56:25 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:7b40:ce24:60a6:e419])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb271ffsm10139626f8f.53.2024.11.25.03.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 03:56:24 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 0/4] Select CONFIG_64BIT for sandbox64 and x86_64
Date: Mon, 25 Nov 2024 11:55:50 +0000
Message-Id: <20241125115554.1707080-1-andrew.goodbody@linaro.org>
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

Changes in v4:
 - Add help text to describe new symbol CONFIG_SPL_64BIT
 - Split the statement in bloblist.c to be more readable

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

 arch/Kconfig                  |  8 ++++++++
 arch/arm/Kconfig              |  1 +
 arch/mips/Kconfig             |  4 ++++
 arch/riscv/Kconfig            |  1 +
 arch/sandbox/Kconfig          |  2 ++
 arch/sandbox/include/asm/io.h |  4 ++--
 arch/x86/Kconfig              |  1 +
 common/bloblist.c             | 11 +++++++----
 include/limits.h              |  3 ++-
 test/lib/str.c                |  8 ++++----
 10 files changed, 32 insertions(+), 11 deletions(-)

-- 
2.39.5

