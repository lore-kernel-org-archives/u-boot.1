Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEA1C27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 20:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAA5C87D14;
	Sat, 22 Jun 2024 22:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LbkYYARL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86AD988122; Sat, 22 Jun 2024 22:18:42 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 821B7879AF
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 22:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F3AB960EF0;
 Sat, 22 Jun 2024 20:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106BEC3277B;
 Sat, 22 Jun 2024 20:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719087518;
 bh=HDIluU6dax6qVKQtqtv7tgNO0OONhvLOVXnUBFvDhtI=;
 h=From:To:Cc:Subject:Date:From;
 b=LbkYYARL/ixcuUmmsD4Kbe5c2NT71cd6kcgnYkzm227zkIByd82qHTJI8xBl9lDHz
 OBXkELBCOlFeo5weE49LccRkaDSOA6a/7D2ORMa5WMDThCDAg6L9bQEjeJh3d8yjvZ
 r/hLuoJQBENxz8pSIrMS+gias9DgvrLuAEv9IOs2efxBaSHkxvrl3BLIoLP4Wgzl9R
 UWgKQxn71oXvAtrW4WS0w5BTaj6YSUrvIK7+LBudy+1GFxxH+dP+LJ0mBBUyACxM77
 UaF0HnDwXCD9zNSBs18bb8LmcIBMa9JqYdWBuDxJ5a3gbtanAS6zJzN62AVUEF/r2v
 YZKfX+b9RZz+w==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: mpfs_icicle: change maintainer to Conor
Date: Sat, 22 Jun 2024 21:18:31 +0100
Message-ID: <20240622201832.4103353-1-conor@kernel.org>
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

Padmarao is leaving Microchip soon, and suggested that I should take
over maintaining the Icicle in U-Boot in his stead.

Suggested-by: Padmarao Begari <padmarao.begari@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Padmarao Begari <padmarao.begari@microchip.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Cyril Jean <cyril.jean@microchip.com>
CC: Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de
---
 board/microchip/mpfs_icicle/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/microchip/mpfs_icicle/MAINTAINERS b/board/microchip/mpfs_icicle/MAINTAINERS
index 22f3b97d8b1..d092b5a8111 100644
--- a/board/microchip/mpfs_icicle/MAINTAINERS
+++ b/board/microchip/mpfs_icicle/MAINTAINERS
@@ -1,5 +1,5 @@
 Microchip MPFS icicle
-M:	Padmarao Begari <padmarao.begari@microchip.com>
+M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Cyril Jean <cyril.jean@microchip.com>
 S:	Maintained
 F:	board/microchip/mpfs_icicle/
-- 
2.43.0

