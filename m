Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5180DC54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 15:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C00C387E67;
	Mon, 18 Mar 2024 16:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hLggwe4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F8987E67; Mon, 18 Mar 2024 16:17:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4871F874B1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 16:17:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BE9EC60C5F;
 Mon, 18 Mar 2024 15:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D104DC433F1;
 Mon, 18 Mar 2024 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710775046;
 bh=t5jwfzFwESDiK2cEvfiCmIbpqo8DPMclJKUuxBP2IAE=;
 h=From:To:Cc:Subject:Date:From;
 b=hLggwe4EWUsFSmBl2AKkTfw/Q2Dbzb+7mMc4EoxG2mp8XbYJAJPmEU2GyoHCyNZkN
 jxREoEbsHVXGuVLGZD8S64D+HHKE0GcFbODExdOmgr/mIDFM7Z7GDaX8NCih5A+z/o
 BmgLOjf4qSIuVDx1f/FzbE/bBiUUtxi8WI+cMGVr2ntaEL9WE1a7FEvp0tU8kl1gyO
 dIkGht/ShZjTUmnUUWM7zqKk5BD9d5slPByHBO8aiJ4kk1q8Eki9tQ6+egMjrW8mLq
 0jpc/pOrZzOULtwbIiATsFKdGGuxwSsjNp0TvKlpLQG5WAzu/oCPdr87WWPJtQesfQ
 gmA09x1RKna/g==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v1 0/2] Support new RISC-V ISA extension properties
Date: Mon, 18 Mar 2024 15:16:01 +0000
Message-ID: <20240318151604.865025-2-conor@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Conor Dooley <conor.dooley@microchip.com>

This would have just been a single patch (the second one), but as I
reported a while back there's a problem with extension detection when
the ISA string exceeds 32 characters:
https://lore.kernel.org/u-boot/20240221-daycare-reliably-8ec86f95fe71@spud/
The first patch here fixes what I see as a bit of a misuse of
cpu_get_desc() in supports_extension() as a preparatory patch for adding
the new properties. Or more accurately, new property, as U-Boot barely
makes use of extension detection as-is in s-mode and only one of the two
new properties is even needed.

Maybe it's not a misuse, but I left a comment under the --- line on that
patch about the before/after for the RISC-V cpu's cpu_get_desc() and
maybe my approach here would not be appreciated.

Cheers,
Conor.

CC: Rick Chen <rick@andestech.com>
CC: Leo <ycliang@andestech.com>
CC: Tom Rini <trini@konsulko.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: u-boot@lists.denx.de (open list)

Conor Dooley (2):
  riscv: don't read riscv,isa in the riscv cpu's get_desc()
  riscv: support extension probing using riscv,isa-extensions

 arch/riscv/cpu/cpu.c    | 60 ++++++++++++++++++++++++++---------------
 drivers/cpu/riscv_cpu.c |  8 +++---
 2 files changed, 42 insertions(+), 26 deletions(-)

-- 
2.43.0

