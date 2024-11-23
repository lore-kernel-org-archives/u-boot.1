Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63440E6ADE7
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 08:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 825E4891E8;
	Sat, 23 Nov 2024 09:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="t+HxCTlX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 016C288E00; Sat, 23 Nov 2024 09:48:20 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF73288E00
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 09:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C157F3F77D; 
 Sat, 23 Nov 2024 08:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732351696;
 bh=GsFODjXq/e1ej6lF37yNn0VOzl/Rf6HdfAoaPnFI0ZU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=t+HxCTlXG9ZOjJvZpp+1H72gQ0cBcyFkHrYccGArdpcu2JMn0TURgagKn6ApYbO1k
 Y3QShvFY+BJ2UAqnrXDdRkFYIHEFn2NaAwxTF+6+ZyhE/Kku5CLtnlOMH6N9BeB5dh
 KC/fV8/Jw6GPTLtuWMyGsfxBkWLkKuumoZXdTkOTAYRTLss3/zDy6jmw0ppP/B3c/R
 Eh0skrpZqnp7Xw6CGObJkBTBthoBwXrGj5LJLU+FLuBNa66fuHqT8doEotzbi9b1P2
 ndz86J1oWBpHd0l7OzZKtk589wTiyPgDJ9tOEJe10PFMS45Ho99qh27vMYDMpXeheU
 /q0qPUjCB8ihg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kalen Brunham <kalen.brunham@intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/4] examples: allow building API examples on RISC-V
Date: Sat, 23 Nov 2024 09:47:50 +0100
Message-ID: <20241123084754.59182-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

With the current series the demo code can be built an executed
on qemu-riscv64_smode_defconfig.

The following bug still needs to be investigated:

The demo binary overwrites the gp register that points to the
global data structure.

Heinrich Schuchardt (4):
  API: unify platform_sys_info() implementations
  examples: implement _start and syscall for RISC-V
  examples: use architecture specific memset() on RISC-V
  examples: use QEMU compatible LOAD_ADDR on RISC-V

 api/Makefile            |  9 ++++++---
 api/api_platform-arm.c  | 35 -----------------------------------
 api/api_platform-mips.c | 29 -----------------------------
 api/api_platform.c      | 25 +++++++++++++++++++++++++
 examples/api/Makefile   |  7 +++++--
 examples/api/crt0.S     | 32 ++++++++++++++++++++++++++++++++
 6 files changed, 68 insertions(+), 69 deletions(-)
 delete mode 100644 api/api_platform-arm.c
 delete mode 100644 api/api_platform-mips.c
 create mode 100644 api/api_platform.c

-- 
2.45.2

