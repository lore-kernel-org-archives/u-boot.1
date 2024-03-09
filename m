Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96059C54791
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 21:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E0DB87D2D;
	Sat,  9 Mar 2024 22:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WgFOJjNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D3587D5F; Sat,  9 Mar 2024 17:55:54 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8242F87861
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 17:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so23940155ad.3
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 08:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710003350; x=1710608150; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mszI6YvCD/rm7Q3+nsKwWLgsEJh1CaeNS4ltpfBalx0=;
 b=WgFOJjNkmvkv++KOHr0e4/sKDYsDJ29lcCf5okmOa9HUXCdOHFRxucHpcJEvKFpYkC
 3YR3vC/+zt3y7QhHJUdi6VYu95TToE+Zpw6limOc1SKjJ1Ipeyib0bhtbdupKu1Ou3L7
 ACpKfnBDZ0DPtKRiNTaiXv00p1rC/0NfDH4giETPMKlXLrpd3U5QDZ2Ehkpf/tnsGPwD
 XRthL/n2aKwnUQptf680Yf7WktwHaU5qRGkL7HVG5bnwcd4DqDNbP9n0XxSYf1uVTHJT
 n+lBQxm6uBuGkzyX+4jXKV5/glS9pc4ZHM8Ml4yvGMdsLMNdvIxkCryGx34VxMpfYJYf
 5/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710003350; x=1710608150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mszI6YvCD/rm7Q3+nsKwWLgsEJh1CaeNS4ltpfBalx0=;
 b=KvgkEVo6SQaAvXeHP51bH1cc8+PtHUgJZ8g0KjE9cOfhkKxAnL2fakeJHXId2qzw+X
 zR5h0AgKs771qtN/LVdfeWwb746X/XHYsaob+X5/X92Tpamc/dZon0E4xOwFFKzndfYU
 uL+Kfuf/4TUP2kk/rIReya49SFbYbk6Is/z/0+h9FwbGP2U7T67XuOUyVJIrldoKGqXz
 0FG4UW0dC5cVsauFIxdunPhtCpH/8H3+DOGte6bARYB7wAsdt4AuanTnXVz5eqOre0xJ
 v/JfUzu2g2eLBwbDditgqoFMGsJ6QZausk24AdrW5aZ8KZ1x69HQM9SV+YoLmjTDW7Gt
 MEgA==
X-Gm-Message-State: AOJu0YxblqVD7OQHy7EJMammnwsn31B/R/fZao4+mgc5mP/Dbo7Oz9DT
 Sfve6dxCnht1tTatRUORdvuVAp5qm3tUIOIi13MAgAaDTA8yIqoK508oFn+r8Vqndg==
X-Google-Smtp-Source: AGHT+IGgSN6AcnVY1zCW9hSpn53vFCXGMqFyehfga5QyXgfxU9pMNR22OgDJLH6+JcpxItkgF2Eohw==
X-Received: by 2002:a17:902:c409:b0:1dd:6be8:3839 with SMTP id
 k9-20020a170902c40900b001dd6be83839mr1807045plk.55.1710003349592; 
 Sat, 09 Mar 2024 08:55:49 -0800 (PST)
Received: from localhost.localdomain ([117.135.91.249])
 by smtp.gmail.com with ESMTPSA id
 ju11-20020a170903428b00b001dd5ba34f3esm1529252plb.278.2024.03.09.08.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 08:55:49 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Randolph <randolph@andestech.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Shengyu Qu <wiagn233@outlook.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v2 0/2] riscv: cpu: Add support for cv1800b SoC
Date: Sun, 10 Mar 2024 00:54:55 +0800
Message-ID: <20240309165533.48795-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 Mar 2024 22:59:35 +0100
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

This series add basic support for cv1800b SoC and enable dcache support.

The cv1800b utilizes CSR instructions to manipulate the first and second
bits in the MHCR register (0x7C1) to indicate the activation status of icache
and dcache. As the icache and dcache are already enabled in the FSBL
(first stage bootloader) provided by the vendor, and the U-Boot running in
S-Mode is unable to manipulate CSR registers, support for operations related
to enabling, disabling, or checking the status of the cache is not provided.

Changes in v2:
- Remove duplicate code in function cleanup_before_linux

Kongyang Liu (2):
  riscv: cpu: cv1800b: Add support for cv1800b SoC
  riscv: cache: Implement dcache for cv1800b

 arch/riscv/Kconfig              |  1 +
 arch/riscv/cpu/cv1800b/Kconfig  | 12 +++++++++
 arch/riscv/cpu/cv1800b/Makefile |  7 +++++
 arch/riscv/cpu/cv1800b/cache.c  | 45 +++++++++++++++++++++++++++++++++
 arch/riscv/cpu/cv1800b/cpu.c    |  9 +++++++
 arch/riscv/cpu/cv1800b/dram.c   | 21 +++++++++++++++
 board/sophgo/milkv_duo/Kconfig  |  4 +--
 7 files changed, 97 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/cpu/cv1800b/Kconfig
 create mode 100644 arch/riscv/cpu/cv1800b/Makefile
 create mode 100644 arch/riscv/cpu/cv1800b/cache.c
 create mode 100644 arch/riscv/cpu/cv1800b/cpu.c
 create mode 100644 arch/riscv/cpu/cv1800b/dram.c

-- 
2.41.0

