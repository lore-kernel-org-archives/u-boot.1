Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B1FC3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 09:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF0788A41;
	Tue, 20 Aug 2024 11:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AgFbRWKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1342288A27; Tue, 20 Aug 2024 11:38:33 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AFCE889D2
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 11:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3db1956643bso3504994b6e.3
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724146709; x=1724751509; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EyDCfGOUSYTNgehkDw+36HpYzwiRnsCoZXgTSSLjZe0=;
 b=AgFbRWKpf+fcMOg5AQD+NOaIAYqVpjezZRbnQ3/cApuEa0x9HBDEMMHCHl4ggnjEG7
 yN5XL1qCWi51BeJEcV6684HopSgQRcnZ2bFhZI+JDwtsPDJtB9C2dpE9I3JRjoOf0E97
 jRd3eilZrkJh/NsiN/aN1fMgX71NQ4PJsFRepms3APpqgIEzyPGFBpPbPZht3KULLEpQ
 RN2ZY6nZXlyT42kfRLP7SyUHeiWrIMANmZpc3GAyZPvd8s/TusYg1eAIpTdYZxLXvBu/
 KOoI8KA2RjOxb+sc9xhMXPrzYxzNOCy7ATVfuCdDsenZ/ULTiV6Uq1b2Ee8KaXggJCsW
 3Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724146709; x=1724751509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EyDCfGOUSYTNgehkDw+36HpYzwiRnsCoZXgTSSLjZe0=;
 b=n5GZOgV6Og8t/fDvzcPhzq8G7dpU0Re2tdJJn7sYXsqYQ3YjR/fKf7pQu0hbpSmApG
 WsTKl/iiFWpDUKi4KGZxwAOthFqWgmWCp1Fx/cqhzfqAQgLGVOUK817YWtkEGtyLBQfx
 ObtuYrWbms4q79aVQU1/j28loLxlIA0SuzEE9zonCKU00N43o7GqXPMuNZsCX6LA3LxC
 QWP4ssAAWyVo9rT0b7Y/63dTsW2ssZcmvQe5WJ1dzn1P8yLpN7uDcneU5IJxgxqfIjFU
 HELXqhaUNYRw9Ty5gnsEycNLH/+XoYpGxUSnWinLnKzr7FuNfe0YvVg+PijDndognlsP
 99pw==
X-Gm-Message-State: AOJu0Yystm4e1qKkHv01Us8eS0m9pYc1cjiGWtWUV+1d/M1R3IutRJuT
 q3tQ719zLW5dX5lnvdSqNqf7HJLDJkw8+XGGlzxRpg3E0pX4ELv8D24vYJO45aLXljwg86qCr68
 q
X-Google-Smtp-Source: AGHT+IFe16im+533BXOvLaQSPo8AUcTMmR2RQvALXh3zBqYflFQJJ5kAedrX6ntSUX7RmPh6gfzRlw==
X-Received: by 2002:a05:6808:1250:b0:3dd:3651:d2eb with SMTP id
 5614622812f47-3dd3ad2ec7fmr12014143b6e.22.1724146708812; 
 Tue, 20 Aug 2024 02:38:28 -0700 (PDT)
Received: from localhost.localdomain ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-3dd33d3fe91sm2795674b6e.9.2024.08.20.02.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 02:38:28 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Randolph <randolph@andestech.com>, Michal Simek <michal.simek@amd.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Samuel Holland <samuel@sholland.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v1 0/3] Risc-V cache operations
Date: Tue, 20 Aug 2024 09:37:49 +0000
Message-Id: <20240820093800.5436-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
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

This patchset adds support for using the CBO instructions to perform the
dcache flush/inval operations for the qemu-riscv board when those are
enabled. The CBO instructions are defined in the Risc-V CMO specification
which can be found at the link below:
https://github.com/riscv/riscv-CMOs/blob/master/specifications/cmobase-v1.0.pdf

Mayuresh Chitale (3):
  riscv: Add support for defining instructions
  riscv: cache: Add CBO instructions
  board: qemu-riscv: Override enable_caches

 arch/riscv/Kconfig                      |  4 ++
 arch/riscv/include/asm/cache.h          |  3 +
 arch/riscv/include/asm/insn-def.h       | 42 ++++++++++++
 arch/riscv/lib/cache.c                  | 90 +++++++++++++++++++++++++
 board/emulation/qemu-riscv/qemu-riscv.c | 16 +++++
 5 files changed, 155 insertions(+)
 create mode 100644 arch/riscv/include/asm/insn-def.h

-- 
2.34.1

