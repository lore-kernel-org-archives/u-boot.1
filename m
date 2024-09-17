Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC25FC35FF1
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 08:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6D6888D02;
	Tue, 17 Sep 2024 10:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="k/6LNWPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C98288D31; Tue, 17 Sep 2024 10:10:55 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4769E881E7
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 10:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-243.46.114.pool.telefonica.de
 [46.114.106.243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 26BDD3F14D; 
 Tue, 17 Sep 2024 08:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726560652;
 bh=leA46HAtJBj9NlCWG3lljhrmhGSyHc+OLvq9OlVNGQ4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=k/6LNWPI4o78J25i3mw7ikRPQbhhiEdi2DlGmbNtLJ748Pq8np0xhQS40/r+ajGNQ
 8NGm1n5RRA9Y33K/m8DI2xPExheGwWYZXJ+ImICEl14zHXrbnXGR0IsUscTXm6dO9T
 FRTmRNo+U9Lk3vpHQE9U+zp+pj3JlRGlj6zx/MkdaIo1j78c28+PkUgiumpfzCCkFm
 JlWNXc8tQysBuJLuHWiPn4TdVvx0yqULL38zjgN13+TWXxW7HkKP+lPNVpvJMt3Pp5
 jwoklyaM9Y7wG7rizJyLLGhz67W7AZy9/q3yIdVksDIfWrV4Am7fu1xCSME+/C2xMN
 ThPUr2OrGV0tA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: sbi: Add FWFT, MPXY extensions
Date: Tue, 17 Sep 2024 10:10:36 +0200
Message-ID: <20240917081036.24943-1-heinrich.schuchardt@canonical.com>
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

The SBI 3.0 specification [1] adds the following extensions:

* Firmware Features Extension
* Message Proxy Extension

Let the sbi command detect their availability.

The Firmware Features Extension is already implemented in OpenSBI.

Correct the text for the DBTR extension and move it to the same position
as in the specification.

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/vv3.0-rc1/riscv-sbi.pdf

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/include/asm/sbi.h | 4 +++-
 cmd/riscv/sbi.c              | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index ad32dedb589..47124dbaac8 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -33,8 +33,10 @@ enum sbi_ext_id {
 	SBI_EXT_CPPC = 0x43505043,
 	SBI_EXT_NACL = 0x4E41434C,
 	SBI_EXT_STA = 0x535441,
-	SBI_EXT_DBTR = 0x44425452,
 	SBI_EXT_SSE = 0x535345,
+	SBI_EXT_FWFT = 0x46574654,
+	SBI_EXT_DBTR = 0x44425452,
+	SBI_EXT_MPXY = 0x4D505859,
 };
 
 enum sbi_ext_base_fid {
diff --git a/cmd/riscv/sbi.c b/cmd/riscv/sbi.c
index a231604e492..5ecf56781c1 100644
--- a/cmd/riscv/sbi.c
+++ b/cmd/riscv/sbi.c
@@ -54,8 +54,10 @@ static struct sbi_ext extensions[] = {
 	{ SBI_EXT_CPPC,			      "Collaborative Processor Performance Control Extension" },
 	{ SBI_EXT_NACL,			      "Nested Acceleration Extension" },
 	{ SBI_EXT_STA,			      "Steal-time Accounting Extension" },
-	{ SBI_EXT_DBTR,			      "Debug Trigger Extension" },
 	{ SBI_EXT_SSE,			      "Supervisor Software Events" },
+	{ SBI_EXT_FWFT,			      "Firmware Features Extension" },
+	{ SBI_EXT_DBTR,			      "Debug Triggers Extension" },
+	{ SBI_EXT_MPXY,			      "Message Proxy Extension" },
 };
 
 static int do_sbi(struct cmd_tbl *cmdtp, int flag, int argc,
-- 
2.45.2

