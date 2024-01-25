Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB68DC47422
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 08:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85AA986FC9;
	Thu, 25 Jan 2024 09:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ug5ssw/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8282870E3; Thu, 25 Jan 2024 09:38:29 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C700F86DEE
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 09:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 395C73F739; 
 Thu, 25 Jan 2024 08:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706171906;
 bh=tUqCWcwqMBVUba6SdBQwZ8bXUzhxx9CypypYcc4z8Hs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Ug5ssw/p5rzIguLpSKW3/c3g4DBmowky8EEFyQcjsMLcPKfbXmIEFjfxOADzA3znz
 fXfKPjFIlt+S6OGZJrOViDyvtWfljN6hCdxn3R5Lf9uyItScEkwZONQNj6dq16z+y7
 Re3wN7olM3aGx0EhJ6R/UvMRSJC1RtgIguJL071xqR5KC7vjq2Nmscd2GZ3hgPQKKm
 kaOV+M13b+lYWWhZpBunyF9zCnkuUE/Z35UbmpJuJ6u+12oIzkSalaaFv2SmUle4RM
 Huwsg9zUL6t8IOSvWiPtXyG7XdVhAKtZGU7yT0W+FuEVHPUoyKgDoM3R+I2g9A1Nnc
 dWveUHOtDwzrQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/3] riscv: conflicting SPDX license linker scripts
Date: Thu, 25 Jan 2024 09:38:13 +0100
Message-ID: <20240125083815.12623-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125083815.12623-1-heinrich.schuchardt@canonical.com>
References: <20240125083815.12623-1-heinrich.schuchardt@canonical.com>
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

Fix conflicting SPDX license information in linker scripts introduced by
commit 7215787c4ea4 ("SPDX: Convert single license tags to Linux Kernel
style").

Fixes: 7215787c4ea4 ("SPDX: Convert single license tags to Linux Kernel style")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	split patches
---
 arch/riscv/lib/elf_riscv32_efi.lds | 4 +---
 arch/riscv/lib/elf_riscv64_efi.lds | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/lib/elf_riscv32_efi.lds b/arch/riscv/lib/elf_riscv32_efi.lds
index c3e0d20d577..940a5816b82 100644
--- a/arch/riscv/lib/elf_riscv32_efi.lds
+++ b/arch/riscv/lib/elf_riscv32_efi.lds
@@ -1,9 +1,7 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: BSD-2-Clause */
 /*
  * U-Boot riscv32 EFI linker script
  *
- * SPDX-License-Identifier:	BSD-2-Clause
- *
  * Modified from arch/arm/lib/elf_aarch64_efi.lds
  */
 
diff --git a/arch/riscv/lib/elf_riscv64_efi.lds b/arch/riscv/lib/elf_riscv64_efi.lds
index ecb91395486..be9f0ac6022 100644
--- a/arch/riscv/lib/elf_riscv64_efi.lds
+++ b/arch/riscv/lib/elf_riscv64_efi.lds
@@ -1,9 +1,7 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: BSD-2-Clause */
 /*
  * U-Boot riscv64 EFI linker script
  *
- * SPDX-License-Identifier:	BSD-2-Clause
- *
  * Modified from arch/arm/lib/elf_aarch64_efi.lds
  */
 
-- 
2.43.0

