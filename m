Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2053C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 09:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 054D5885F6;
	Fri, 23 Aug 2024 11:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JQvmLQ7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE6D68870E; Fri, 23 Aug 2024 11:41:53 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E87288216
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 11:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42ab99fb45dso17714015e9.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724406111; x=1725010911; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SEXT4t6iqgeJyWRyZc+ZePkKCKHfNwuNASa5hHCMdzc=;
 b=JQvmLQ7Bg0upYAe6cQoEtJmD53zmW+3XNG/CvBMxU9sP7WTroOn9rGnJmhLLX2oJ32
 WbDHegwVx+KA4Gcjp5/I/nev0nBJsCzADaVl0+K4ZHuGQ283xlVL11AkwPieN9o7x982
 1Sx+m/Qt7/M2rt8nEZmAULEwdUFetQIQg6/p/LH7w/pxOmaqPLYtjcPSEjmjEphD71hk
 ur9NVL67FRj4aHmp0HvdHULR12kMY1h0QF6g0QoTryyxKbARCoiCYmMJD8Zo6Dt02fyc
 ua+5zm5FR5Q1RaJxKxmWj1vaP4jGkY4X1ZoWnakV9yBlJLuM05fEZ1/6BI5aTx6mNqrH
 ciDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724406111; x=1725010911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SEXT4t6iqgeJyWRyZc+ZePkKCKHfNwuNASa5hHCMdzc=;
 b=v6v1Ulb0vvVneqe4iXwbvfyqWqTzkqqOZnu7ay2LpE2/Ya9e9Pey1Iai5wj1i6Ov+9
 r4lCMSIOSrLLqimQQr9hYZa2q+LtVo19IMVv8uq3pvMkwjkRbyTrffsMaVucheodcBLB
 GzL3+z8bONo7TkmcuMvuMxD8qwOu0XqxnGL3aNbmeWAm9rzm5eD4SJGRgPD9ON1zsLpp
 9R0AJHEMwSvfahql0xyF3F//oU+VRfkqWymTXg0R0wWPsZdFvy/QNrsnQqB57rV0tyM7
 2cXHqYIQgo5W/4xy8rCObNqPTdOHOS6zTgxVD62saBVeGxWhI4x9z/W24B/kPzbg3BEH
 9OlQ==
X-Gm-Message-State: AOJu0YzHg++6B0Q0UNm/Y03pCfD29mzl8TMtc3TYKbHcPW0K6qZ8ktwR
 pTLeCaHb5QNyUrd3FnIhNX4rKH8PnmH6JPDJzXq0PeucIT378bB/41Q6/EffjLeinL7NmMwYJyK
 1
X-Google-Smtp-Source: AGHT+IHxCgZ7phAc+bkqHDxwo05QseILWeBaPHjpuzkx/Ei2IgBgGF2RIqqUdxeUtrnr59sZdoWu1Q==
X-Received: by 2002:a05:600c:4e8d:b0:426:593c:9359 with SMTP id
 5b1f17b1804b1-42acd5e69d6mr12747865e9.32.1724406110251; 
 Fri, 23 Aug 2024 02:41:50 -0700 (PDT)
Received: from localhost.localdomain ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-42ac516251fsm52909335e9.25.2024.08.23.02.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 02:41:49 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Randolph <randolph@andestech.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Samuel Holland <samuel@sholland.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 0/2] Risc-V cache operations
Date: Fri, 23 Aug 2024 09:41:24 +0000
Message-Id: <20240823094127.207866-1-mchitale@ventanamicro.com>
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

Changes in v2:
 - Use cache functions in generic cache code instead of board specific code
 - Print the zicbom init status in case of a failure

Mayuresh Chitale (2):
  riscv: Add support for defining instructions
  riscv: cache: Add CBO instructions

 arch/riscv/Kconfig                |  4 ++
 arch/riscv/include/asm/insn-def.h | 42 ++++++++++++++
 arch/riscv/lib/cache.c            | 96 +++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 arch/riscv/include/asm/insn-def.h

-- 
2.34.1

