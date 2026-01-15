Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93751D3CC88
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 00:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C228080325;
	Thu, 15 Jan 2026 01:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="LuGAlIAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F2408063E; Thu, 15 Jan 2026 01:08:56 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8349680077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 01:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1768435730;
 bh=827rkXZURamgh7RNS1+k6489Rwvp5AAPKvCUJPdqUMo=;
 h=From:To:Cc:Subject:Date:From;
 b=LuGAlIAxxYXXFO2/OSyoL+WWank4aXC4z9lLVX/NmbxNxuaBQLKfJnfxedAN/rSYs
 Qc/DjPoswwQrCcF77AIfc4ONrzr7iEgY1AjZe2PL1KvS0uwVIAZkkhOk2vuaXnZ8kz
 ZDiC9NUgJ6OZ7/7lblkA/rayx1Ko+Yy97+HOLWLzFvi8eLKzU//udY6X4MrwBA1Ii2
 cnSARh8SJx6UmoMOLeSJi0pORnn16SZ0kGkWQKWw6IoyF8bXB5C/mzP37dCuG+Pc2N
 3KlJcUNriweScsyNCCwjYXOBNwHNM0r2Cja4fvvAUnocfMUMfIhzyGxDuJ+0tp5qHR
 pjfagWMIXG3KQ==
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 06CF9B221713;
 Thu, 15 Jan 2026 01:08:48 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH] drivers: phy: fix code documentation typo udevice_ops
Date: Wed, 14 Jan 2026 16:07:15 -0800
Message-ID: <20260115000724.21472-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

Amend code documentation referring to udevice_ops for struct phy_ops

Fixes: 72e5016f878d ("drivers: phy: add generic PHY framework")
Signed-off-by: E Shattow <e@freeshell.de>
---
 include/generic-phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/generic-phy.h b/include/generic-phy.h
index ba3321f4849..567dd3974ad 100644
--- a/include/generic-phy.h
+++ b/include/generic-phy.h
@@ -52,7 +52,7 @@ struct phy {
 };
 
 /*
- * struct udevice_ops - set of function pointers for phy operations
+ * struct phy_ops - set of function pointers for phy operations
  * @init: operation to be performed for initializing phy (optional)
  * @exit: operation to be performed while exiting (optional)
  * @reset: reset the phy (optional).

base-commit: d503633a36767d756c7de28305cf0de79440cbc0
-- 
2.50.0

