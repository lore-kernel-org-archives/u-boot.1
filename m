Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48A7FEA838
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 09:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E5F183BC7;
	Wed, 25 Mar 2026 10:20:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hfGfOf3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FEA581E18; Wed, 25 Mar 2026 10:20:09 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 218D783CD3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:20:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=5jWe5kafe9yRRXRno/QVuVE+e980f2q8efzIcqbWfec=; b=hfGfOf3WLNNo1h9BOnnPVXbuQG
 j+laZ0EBnabVPth6+Ax0aPgMmHodybZE8M5rEaUkw14Nap8+t5YAPLzyng4D4qZkyq6EhNEs09fSI
 PWxEhucfW1Vqm/aeMd6YAIvDuyKhkbq3qyfUlvua+/zPCJejfYMPtQ0fQx4w2r+SYgCcN/pVclG1p
 TiiLs80AutlxL3CZiGG9+r2WDC8/afLsRGz77bJ/7hhyoiljyGtxK42S5hWnZazHC3+5pgXy7Nvh0
 8tgTSdUS+hTwmGuTDsqQg2dNAOp+yDMWabIH6SiIABIThu6Czc+l45ikEME0QIxHRqSO0scB1dFPT
 7anna82A==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w5KPD-0004Ad-1I; Wed, 25 Mar 2026 10:20:03 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w5KPC-0005cv-0b; Wed, 25 Mar 2026 10:20:03 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 1/3] MAINTAINERS: update entry for TQ-Systems
Date: Wed, 25 Mar 2026 10:19:52 +0100
Message-ID: <20260325091957.906400-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325091957.906400-1-Max.Merchel@ew.tq-group.com>
References: <20260325091957.906400-1-Max.Merchel@ew.tq-group.com>
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
 MAINTAINERS | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f924565d1bf..dfeca3ee212 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1846,10 +1846,14 @@ F:	drivers/tpm/
 F:	include/tpm*
 F:	lib/tpm*
 
-TQ GROUP
-#M:	Martin Krause <martin.krause@tq-systems.de>
-S:	Orphaned (Since 2016-02)
-T:	git git://git.denx.de/u-boot-tq-group.git
+TQ-SYSTEMS
+L:	u-boot@ew.tq-group.com
+S:	Maintained
+W:	https://www.tq-group.com/en/products/tq-embedded/
+F:	board/tq/*
+F:	doc/board/tq/*
+F:	include/configs/tq*.h
+F:	include/env/tq/*
 
 TEE
 M:	Jens Wiklander <jens.wiklander@linaro.org>
-- 
2.43.0

