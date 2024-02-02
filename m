Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0A8C47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 12:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBC9387C8E;
	Fri,  2 Feb 2024 13:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QWyPDcjy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C94187447; Fri,  2 Feb 2024 10:38:08 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C358187061
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 10:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d746ce7d13so15651025ad.0
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 01:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706866683; x=1707471483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vPsjQwuDwIPkVeLCUZC2sYnvhv2dijZDQVdlJFwBqSE=;
 b=QWyPDcjye622sY3+u+lbbR2ws2ZhgzAQy9r9o6imACXkdxE33prAQf8hsYJDxsSRO4
 jmX30UTJl7SFYh2d09/zJf+Vh1XJ6R23+ossUxys+E+UfABoy7httaLMcTlqzjN7T8T2
 W6GmMm5Uu2UZKfSLcOt3zeC8vbHKb3OTRAm97ZCdzyOLwe/CAd6VjHlqvVuo1WneK7Bx
 Kt78jX/IThRmdcokjoPKPqmosXdHUC6yYzhdWGI0ehwIEIZzAQdfDL5PoioG9CEKRrX/
 d07tLhZ+ElzHkleKIaQ0bFPoAPe8gjlgMvFCRBC8PChaKT/PabVec3rJMV1g2DflaSdw
 b6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706866683; x=1707471483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vPsjQwuDwIPkVeLCUZC2sYnvhv2dijZDQVdlJFwBqSE=;
 b=dfaEob9l9wYQeVNcJBVllP3DBId2BsvXhG4+JJ5BrkDbjtXH8mpnfspXfR1NFgmtax
 C5NZTlFT1vXlprCCn2wP/PEH7DIduBMiRA6nt3OGNiT0D9yrjtZDZu0cN0UxFkpLmcng
 O1ESm9O8yzJ0UfN/+3OuaQNxzDmKf5Tr6ciUWNXmNs6+pRmDQW/+KxwCCXtCBqhFOqIp
 WEV2SSfjYHUcTveghWMWFMhUcQJm9eNL7GC26U3o56Vz0hqaxkKEZRcTJdzXbZ9GTpEi
 v/ReYLsMKYa0KexQ/SJh6gAEi7f8Zru8DIg7XCa2cnP4ZJcf6U3NzNN7ExvCUxD0wFrc
 3SiQ==
X-Gm-Message-State: AOJu0YxuvJT2hPl5JL3RBsEqtB0ju3/wLVMMft9EoUDLeHFDCuRDo5cW
 KMqr1V9+9haEw97rrVzcQVigOpKxq9L1ndAoF/rP9hph81NuwRqGqS4x2k28D5lySyI+
X-Google-Smtp-Source: AGHT+IHaa5o2U9ahPEBE5kJnocWTYxYua9CAMNBsQw/KHfYYYtPmJhoWAFVKjEzO8dvH/0bVSleLqg==
X-Received: by 2002:a17:90a:ce08:b0:295:b4af:6600 with SMTP id
 f8-20020a17090ace0800b00295b4af6600mr4763526pju.7.1706866682971; 
 Fri, 02 Feb 2024 01:38:02 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWdsq2PiN2HrT8djBl3+YWvrl3wCx3UVnLZQnqKOMLRW0b6Zeci1khUufcJqhxpmhRVljQ9KRCWf2b8R7iuHYsDFqqnktt745sUljzkvKTt9OtfmODt8DvOCh5ClqF7jzhoidO+W5N7AtW678Ih9WhkuxkTXrDAwKsJ1lQe5CEyZtRQA+LnNph5FE9ggNryfbWNKZuQCBwNuB3vayDJUKd3JmiRfS7MO8wR1ak/GrWKjrA13lxFT4UG2IpXtrWI7UpkklneR5CyfT+RpHGHCHkQ/ZhH6K84jHM7+APzggfPyGcQLOU4J2+/5CeWTqc+QP5cYQl6dAL+Jg/bXushZsVD4jmV1LE=
Received: from localhost.localdomain ([125.126.161.226])
 by smtp.gmail.com with ESMTPSA id
 mf7-20020a17090b184700b0028e2a0d297csm1331612pjb.41.2024.02.02.01.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 01:38:02 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Randolph <randolph@andestech.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Shengyu Qu <wiagn233@outlook.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH 0/2] riscv: cpu: Add support for cv1800b SoC
Date: Fri,  2 Feb 2024 17:37:17 +0800
Message-ID: <20240202093748.330658-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Feb 2024 13:31:24 +0100
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


Kongyang Liu (2):
  riscv: cpu: cv1800b: Add support for cv1800b SoC
  riscv: cache: Implement dcache for cv1800b

 arch/riscv/Kconfig              |  1 +
 arch/riscv/cpu/cv1800b/Kconfig  | 12 +++++++++
 arch/riscv/cpu/cv1800b/Makefile |  7 +++++
 arch/riscv/cpu/cv1800b/cache.c  | 45 +++++++++++++++++++++++++++++++++
 arch/riscv/cpu/cv1800b/cpu.c    | 22 ++++++++++++++++
 arch/riscv/cpu/cv1800b/dram.c   | 21 +++++++++++++++
 board/sophgo/milkv_duo/Kconfig  |  4 +--
 7 files changed, 110 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/cpu/cv1800b/Kconfig
 create mode 100644 arch/riscv/cpu/cv1800b/Makefile
 create mode 100644 arch/riscv/cpu/cv1800b/cache.c
 create mode 100644 arch/riscv/cpu/cv1800b/cpu.c
 create mode 100644 arch/riscv/cpu/cv1800b/dram.c

-- 
2.41.0

