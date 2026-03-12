Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A520BFED2FA
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C067084148;
	Thu, 12 Mar 2026 10:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ON5drMv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F0C84189; Thu, 12 Mar 2026 10:57:39 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59ECE84051
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=NDt4hrWP0uhTBk08vTZ+ERgUfxPk9TD+VFaVxgTW6C0=; b=ON5drMv376l/3IJYrrrOi3A5Uv
 TaQ32I3uuLP4h0cP1YaNbu6155ngQ4d/HiG2jXi5pFc+xUW25PZpd1sp2Mw9SpwlKsodi03VM2zbA
 eDLbEeonoYbhlj0TPdHd1kggtK7b+yvkE8eMEzxvZmnyKL33N5+CgjetADxJweyE6ZaxF64YknvKT
 4ddWlUs4O5s00qiGGEWZuM8kn7XhJvqY+lMcIS3Od1p0Bc6b6g327bXXHTArIO7hpe96DjTdCChlo
 UdEmJFvu1xJqW9eWz5s8PzP4HSVSvfoAA+2iO9Z/t+CZ/QlLof4WSxHM7PcuIxdjU/NOOJ2Nnp6xG
 E3zEFQIQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnQ-0007xI-1E; Thu, 12 Mar 2026 10:57:36 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnQ-000Fyo-03; Thu, 12 Mar 2026 10:57:36 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 01/13] MAINTAINERS: update entry for TQ-Systems
Date: Thu, 12 Mar 2026 10:56:57 +0100
Message-ID: <20260312095711.3219756-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

- change TQ GROUP to TQ-Systems
- add TQ mailing list
- remove custodian tree
- add board directory
- add board configs
- add board device trees
- add board documentation directory
- add shared environment directory

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 MAINTAINERS | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d2508d90c33..2a99aa486b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1845,10 +1845,17 @@ F:	drivers/tpm/
 F:	include/tpm*
 F:	lib/tpm*
 
-TQ GROUP
-#M:	Martin Krause <martin.krause@tq-systems.de>
-S:	Orphaned (Since 2016-02)
-T:	git git://git.denx.de/u-boot-tq-group.git
+TQ-Systems
+L:	u-boot@ew.tq-group.com
+S:	Maintained
+W:	https://www.tq-group.com/en/products/tq-embedded/
+F:	arch/arm/dts/*mba6*.dts*
+F:	arch/arm/dts/*tqma6*.dts*
+F:	board/tq/*
+F:	configs/tq*config
+F:	doc/board/tq/*
+F:	include/configs/tq*.h
+F:	include/env/tq/*
 
 TEE
 M:	Jens Wiklander <jens.wiklander@linaro.org>
-- 
2.43.0

