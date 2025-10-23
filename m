Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA99CCD1BF
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 09:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 306BC835FE;
	Thu, 23 Oct 2025 11:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="n2OJ6k32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD3B835FD; Thu, 23 Oct 2025 11:47:34 +0200 (CEST)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc0b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F1F807C0
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 11:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4csh5v3pdVzCD1;
 Thu, 23 Oct 2025 11:47:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1761212851;
 bh=CRlBC98qIBuZMIDDfj1njZetNOGVPfXIQy3FsAPqZg0=;
 h=From:To:Cc:Subject:Date:From;
 b=n2OJ6k322w2JslBOGH8CaMzP77WVYTRm4OJUEdGsKOpEXhzVebcOFeObhiqGs/Mn/
 N+XGYYBzXEEyKfpDqTb0e4yu7JVjM15yAcro6L55X7ayCgtVy/fA8MpCZ4eh8lFTW+
 VdvZgAbjl5EJP9hlG2ikL9VyKN3+pYHcTu06BOJ4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4csh5t4L7VzHRX; Thu, 23 Oct 2025 11:47:30 +0200 (CEST)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Andrew Davis <afd@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Beleswar Padhi <b-padhi@ti.com>, Daniel Schultz <d.schultz@phytec.de>,
 Hari Nagalla <hnagalla@ti.com>, Judith Mendez <jm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/6] remoteproc: k3-r5: Build fixes and security
 improvements
Date: Thu, 23 Oct 2025 11:46:18 +0200
Message-ID: <20251023094631.16742-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Philippe Schenker <philippe.schenker@impulsing.ch>


This series fixes compilation errors when building for R5 cores and
addresses a security issue where authenticated images were not being
used correctly.

Patch 1: Cosmetic removal of duplicate code

Patches 2-3: Fix build errors caused by type mismatches between
function signatures and the types used in R5 builds.

Patches 4-5: fix a bug where ti_secure_image_post_process() relocates
images during authentication, but callers were still using the original
unverified addresses.

Patch 6: Implements is_running operation to allow querying R5F core status.

Note: If preferred, I can split this series.


Philippe Schenker (6):
  arm: dts: k3-am642-evm: Remove duplicate node
  remoteproc: k3-r5: cast size to size_t
  soc: ti: pruss: Fix size ptr type in probe
  mach-k3: security: Propagate verified image addr
  remoteproc: k3-r5: Use verified image address
  remoteproc: k3-r5: Implement is_running operation

 arch/arm/dts/k3-am642-evm-u-boot.dtsi |  4 ----
 arch/arm/mach-k3/security.c           |  2 ++
 drivers/remoteproc/ti_k3_r5f_rproc.c  | 23 ++++++++++++++++++++---
 drivers/soc/ti/pruss.c                |  2 +-
 4 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.51.1

base-commit: 813a0df27a8af587bd25a6a4719f68066b370091
branch: am64x-various-fixes__master
