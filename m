Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38C2C0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 06:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33B9F80F9E;
	Mon, 27 Jan 2025 07:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KYu/HrnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D0CB80FC4; Mon, 27 Jan 2025 07:49:44 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A6C480F96
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 07:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 375B93FBD2; 
 Mon, 27 Jan 2025 06:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737960581;
 bh=fAQZOopPaLsGM7gjFVPpryLQgImtq0G886j8gftHxu8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=KYu/HrnN2uHdDlxikjDWvtcBtXft/NgWdNXEqc+AG3pl0vp+GigBo+uRLee8BIMAF
 g6q4ScKtDKGJS3Juqgz4itfhLhSjggP03lp1X2hVxiSOamxdLMskbu57TvVw6dS/tn
 /6P4zOtTprFsnGJnYPlKYIkNaqJurHkdLndg8RQ5APd69Pr+aAzRZIOc6uws06Y7EO
 cf+fHXBqnlEzPQ0dPIguJxvspvb8rWyfWmr8E0u+vCnY4OVs+oqsUGqaNH15G93CQj
 7Xx439QHWr9T1xwlEJGC9GP5pnPiycbHLktN/mAT8W3eWSvexQifQmKW4nNCMBbZCz
 lB6jcCIVuLaDw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Liya Huang <1425075683@qq.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] examples/api: improve determination of LOAD_ADDR
Date: Mon, 27 Jan 2025 07:49:36 +0100
Message-ID: <20250127064936.43539-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

The current load address for the 'demo' binary does not work for
qemu_arm_defconfig.

The suitability of an address to load an ELF binary and run it does
not only depend on the architecture but also on the memory layout of
the board.

On most boards we can assume that 8 MiB of memory is available above
$loadaddr. So $loadaddr + 0x400000 should work there.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 examples/api/Makefile | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/examples/api/Makefile b/examples/api/Makefile
index 722c7e45904..be97b8015bd 100644
--- a/examples/api/Makefile
+++ b/examples/api/Makefile
@@ -5,26 +5,9 @@
 # Provide symbol API_BUILD to signal that the API example is being built.
 KBUILD_CPPFLAGS += -DAPI_BUILD
 
-ifeq ($(ARCH),powerpc)
-LOAD_ADDR = 0x40000
-endif
-ifeq ($(ARCH),arm)
-ifdef CONFIG_64BIT
-LOAD_ADDR = 0x40400000
-else
-LOAD_ADDR = 0x1000000
-endif
-endif
-ifeq ($(ARCH),mips)
-ifdef CONFIG_64BIT
-LOAD_ADDR = 0xffffffff80200000
-else
-LOAD_ADDR = 0x80200000
-endif
-endif
-ifeq ($(ARCH),riscv)
-LOAD_ADDR = 0x84000000
-endif
+# Environment variable loadaddr is set from CONFIG_SYS_LOAD_ADDR.
+# Run the examples 4 MiB above this address.
+LOAD_ADDR:=${shell printf 0x%X $$(( $(CONFIG_SYS_LOAD_ADDR) + 0x400000 ))}
 
 # Resulting ELF and binary exectuables will be named demo and demo.bin
 extra-y = demo
-- 
2.47.1

