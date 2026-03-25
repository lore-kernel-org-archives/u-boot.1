Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50A0FEA835
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 09:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F3A583EAC;
	Wed, 25 Mar 2026 10:20:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NboMf0MJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91C7081E18; Wed, 25 Mar 2026 10:20:14 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6932C838BB
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
 bh=MUk+Ta7qE/G5TDypdW7Btj+VnsRRwlfwH0A2G7IInFw=; b=NboMf0MJJ8Z/q0l8hQGDSVSmTv
 zH4q/MIElb8HdrmbpW8u0oAwxmF65sE+QO9AFhSyvKKIjVnfxpi5oTfclh6mQiuOkUSKvWKIurM7U
 Ssw9ehqqHnOmIS6JQX7vd2Yp+UgnLxN+YOt4Flqyj+V7nog+btqqrwTIQvXgWajj6OHmap7oLvxDo
 JkltV1SgGk0hLi83hLHwX7gf20Xl+Zj03onlwcc/VZtQtnd5pk4wnYgO2i7eqvPY+TLlUWe857UyC
 ce31M4P0u+iHm0d/LfGMD6twTPAVGRbj9bPWcYw6abDFHTFzR2ODRZelRc9J/ZHhOBPd+cKpGffI7
 05JF3TNg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w5KPD-0004Aq-2P; Wed, 25 Mar 2026 10:20:03 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w5KPC-0005cv-21; Wed, 25 Mar 2026 10:20:03 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 3/3] tqma6: remove board MAINTAINERS
Date: Wed, 25 Mar 2026 10:19:54 +0100
Message-ID: <20260325091957.906400-4-Max.Merchel@ew.tq-group.com>
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

All information is contained in the global MAINTAINERS or
TQ board MAINTAINERS.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/MAINTAINERS | 7 -------
 1 file changed, 7 deletions(-)
 delete mode 100644 board/tq/tqma6/MAINTAINERS

diff --git a/board/tq/tqma6/MAINTAINERS b/board/tq/tqma6/MAINTAINERS
deleted file mode 100644
index 1d3f7d2cf63..00000000000
--- a/board/tq/tqma6/MAINTAINERS
+++ /dev/null
@@ -1,7 +0,0 @@
-TQ-SYSTEMS TQMA6 BOARD
-M:	Markus Niebel <Markus.Niebel@ew.tq-group.com>
-L:	TQ-Systems OSS Team <u-boot@ew.tq-group.com>
-S:	Maintained
-F:	board/tq/tqma6/
-F:	include/configs/tqma6.h
-F:	configs/tqma6*_defconfig
-- 
2.43.0

