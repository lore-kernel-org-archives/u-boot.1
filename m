Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFD7FEA835
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 09:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A7C583CE3;
	Wed, 25 Mar 2026 10:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Jyq/GWpi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD65E83DA6; Wed, 25 Mar 2026 10:20:10 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AFD083A91
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
 bh=qAvuCKByXfmQv3OrZN2XBV8azIShQgw1VpjYJcYQiNU=; b=Jyq/GWpiSiPIVhnbDotHaIKCNT
 y6KDmlqDxBJ4FiMsbji9RQ3PEbmSN3sfRpr3bCFTMzXq9lNO29c19qjNiG9OJjCyo1tRt9XMZkfNi
 zWbdT6hdmBPBIWHUyCRnXVT/mqcWU/pz3Vk8pq+uqptCADVhpeKwkp8F6naiY1BV0GPa8p8la6/A+
 vSO2bl5WcvWj2BuNJZPyonyqoib9ElM/ean/gN3JcpKQlthi/gHPMKBX5ucjfD3UBrVD2nDHA6T1I
 9iyNX8WPCAiGs6zyySqnSCtzduBcE3WnuZc6Zbh6W3nXzeFVwcu4dde7aiqQkSFhAg0dHszw4VPFN
 TbE6XksQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w5KPD-0004Ai-1n; Wed, 25 Mar 2026 10:20:03 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w5KPC-0005cv-1I; Wed, 25 Mar 2026 10:20:03 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 2/3] tq: add TQ board MAINTAINERS
Date: Wed, 25 Mar 2026 10:19:53 +0100
Message-ID: <20260325091957.906400-3-Max.Merchel@ew.tq-group.com>
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

Add MAINTAINERS file containing board-specific information and
the name of the board maintainer.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 board/tq/MAINTAINERS

diff --git a/board/tq/MAINTAINERS b/board/tq/MAINTAINERS
new file mode 100644
index 00000000000..e6f3dc4da21
--- /dev/null
+++ b/board/tq/MAINTAINERS
@@ -0,0 +1,8 @@
+TQMA6
+M:	Max Merchel <max.merchel@ew.tq-group.com>
+L:	u-boot@ew.tq-group.com
+S:	Maintained
+W:	https://www.tq-group.com/en/products/tq-embedded/
+F:	arch/arm/dts/*mba6*.dts*
+F:	arch/arm/dts/*tqma6*.dts*
+F:	configs/tqma6*config
-- 
2.43.0

