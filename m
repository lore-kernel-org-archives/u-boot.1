Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E306C47258
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D125A87AE7;
	Thu, 11 Jan 2024 14:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WQXkVS/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D99287AEF; Thu, 11 Jan 2024 14:19:33 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5546E87AD8
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 14:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D951C61AC6;
 Thu, 11 Jan 2024 13:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEEFC32781;
 Thu, 11 Jan 2024 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704979168;
 bh=sLgJ41Wnid0bhujMb0LLB/nhZsqn0wo+UGmNSk/CVj8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WQXkVS/vnRshbMt/cciQdcE2JOR1UXSiph3sQ4cmwJ52A2ZIBMpkbdewkAFv/Gzdp
 fD2oMJ2J/XbKE9uQwh2suwQzpw8pi+XMGMY2JTN9ONnnJ2QuB1nI98gNZnUnWOBl+3
 mY7SWljo2br1ab20KPoIU5i4FsAM4jeBqSJKwj0lnhOs3i+WolGmp67jtPeuB2U9YS
 bGYfZ7YX0EMkN6LP2Lby9WbTGeX6hXS6eqN+7zDikNzQpJkjyYPwc/I+GwDwVxOlTU
 lcUilWIQ2/4Q9QtGwQM9x64lAhfaYa21w8AIjOvLYBhz3wCEVXD6CkYEg8cIaJ5XQp
 RhFiKmxVJfqvg==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com
Cc: vigneshr@ti.com, nm@ti.com, praneeth@ti.com, afd@ti.com, srk@ti.com,
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 1/4] memory: ti-gpmc: Fix build
Date: Thu, 11 Jan 2024 15:19:17 +0200
Message-Id: <20240111131920.73691-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111131920.73691-1-rogerq@kernel.org>
References: <20240111131920.73691-1-rogerq@kernel.org>
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

sys_proto.h no longer exists for K3 platform so drop it.
Include sizes.h to so SZ_16M is visible.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Notes:
    v2: no change

 drivers/memory/ti-gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/ti-gpmc.c b/drivers/memory/ti-gpmc.c
index 775e78c9a5..0b8674339e 100644
--- a/drivers/memory/ti-gpmc.c
+++ b/drivers/memory/ti-gpmc.c
@@ -6,7 +6,6 @@
  */
 
 #include <asm/io.h>
-#include <asm/arch/sys_proto.h>
 #include <clk.h>
 #include <common.h>
 #include <dm.h>
@@ -17,6 +16,7 @@
 #include <linux/mtd/omap_gpmc.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/sizes.h>
 #include "ti-gpmc.h"
 
 enum gpmc_clk_domain {
-- 
2.34.1

