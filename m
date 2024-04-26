Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5FCC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 08:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C71F189145;
	Fri, 26 Apr 2024 10:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="JblzyeKd";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="OtLjTrTC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CEA988EF8; Fri, 26 Apr 2024 10:03:03 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A793F89141
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 10:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1714118579; x=1745654579;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=komg8GauXcsCHzgcAjcOHLd3Ikxp+w0VFSzGtBJ+Y+U=;
 b=JblzyeKd0lGGQphXpg4MatMiKI96FUklOgiipMp5AYouRAPLSmgMmokJ
 Gl0DKQSTk1/bvMfk19gGXxIuIx5eb2Fp2dObKI4U9KDJDbbfBzrmi2pyh
 /b2gUAh8c3kil7pV8Tby17CD8T1Qgln8vVaQtbEFpf9fWPxB0izK8CW4g
 uCUz+1VQo3RaR14mlmd9Iu5BEAtw9w9D8FCQNGwbxmRO0QggRHiHZI/as
 bwP2p4W0Se1KFsCeU8gOe+R12fCibNv651L6wWu61sacxonMk/zMizZrO
 nRU6Jtw/dysKz3UAGcxw0QxkKQ41quQB1B5suYZDvwMqtlPTZ4GY7TI96 w==;
X-IronPort-AV: E=Sophos;i="6.07,231,1708383600"; d="scan'208";a="36629248"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 26 Apr 2024 10:02:58 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CB73517136D; Fri, 26 Apr 2024 10:02:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1714118575;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=komg8GauXcsCHzgcAjcOHLd3Ikxp+w0VFSzGtBJ+Y+U=;
 b=OtLjTrTCXU7NsOkH7CTfwqdIPYy0OhuMIDdn3Hyr2vm4vjiuwHDOtQzxB8dx8KEEIybey0
 5BD/Kcy2c4CqrqRE1KXUAsxrxl7ACL567cyKuRw/NaQTLbc1Wk+BSla849mnTIfnMz4mW8
 yLX1OxvtG1KKEbXuA7Zts04ZILZ1+7e0K/dtq/uj/2GUXKA4uPJTK5tj3wdIni65GtYSsd
 B2GeVODVSa09bKoPFGlyYtHP/JSUmwm9l4ufAgijzkcrrlrMcMFsP3x/cp5WKTx6/+o4Ej
 W+c+54Ght6c4mvN39veWcbytnDvzZEFel5rNI+meIT5IbRvJJFYhlFpjPR/bXQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, MD Danish Anwar <danishanwar@ti.com>,
 Jai Luthra <j-luthra@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Suman Anna <s-anna@ti.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 4/5] dma: ti: k3-udma: add missing <net.h> include
Date: Fri, 26 Apr 2024 10:02:27 +0200
Message-ID: <c39dbe0a099b13b8b691d60b64053958fd6e915e.1714117337.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <de7fe2da7ae4a85252d63904fae61585e4641936.1714117337.git.matthias.schiffer@ew.tq-group.com>
References: <de7fe2da7ae4a85252d63904fae61585e4641936.1714117337.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

net.h is needed for PKTBUFSRX. Without this definition, the driver will
always use 4 RX buffers, causing am65-cpsw-nuss initialization to fail
when a higher number of buffers is requested.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/dma/ti/k3-udma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index ef3074aa13f..4e6f7f570c5 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 #include <malloc.h>
+#include <net.h>
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/sizes.h>
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

