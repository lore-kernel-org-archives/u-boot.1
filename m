Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0E3C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 07:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F68D8845C;
	Wed, 22 May 2024 09:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="YgbR7KVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB2E688470; Wed, 22 May 2024 09:55:17 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5937488287
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716364514; x=1718956514;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JxzHmhBQR4x0GiJkcil68bWr2AuTxqMWrLlxKh24WhM=;
 b=YgbR7KVf9Zm8DSVVuTAFfpNTVRSBUAPshVU+yb28NQiIqpvrhKcQIziB8liMjSjH
 q8iGYJOUuIL0T+JlqQLz4eOsoPQJDAh3NbPe53Rtbb9xdGWRMC8wBw7Dk5nnOCGP
 cR6ADwz6icub18dPwCZXAzzSwRlaeucylPsUykhNtjk=;
X-AuditID: ac14000a-03251700000021bc-b0-664da4e2bbd3
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 07.F0.08636.2E4AD466;
 Wed, 22 May 2024 09:55:14 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 09:55:14 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <nm@ti.com>, <trini@konsulko.com>, <clamor95@gmail.com>,
 <d.schultz@phytec.de>, <bb@ti.com>, <jma@phytec.com>,
 <mkorpershoek@baylibre.com>, <d-gole@ti.com>, <m-chawdhry@ti.com>,
 <n-jain1@ti.com>, <afd@ti.com>, <joao.goncalves@toradex.com>,
 <michael@amarulasolutions.com>, <festevam@gmail.com>, <sjg@chromium.org>
Subject: [PATCH v2 3/5] arm: mach-k3: am625: Call do_board_detect() before DDR
 probing
Date: Wed, 22 May 2024 09:55:03 +0200
Message-ID: <20240522075505.3339347-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522075505.3339347-1-w.egorov@phytec.de>
References: <20240522075505.3339347-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWyRpKBR/fREt80gxkXeC3en5rIbjH3zQFW
 iwP9vYwWLWs9LB5e9bd41tnEbHH5/k1Wi0sPUi1ONbayWLw4Npfdov//cyaLNz/OMll827KN
 0WLqpM3sFm/3drJbdL9TdxDwWPvxPqvH+xut7B6zGy6yeOycdZfd49WBVeweZ+/sYPTo725h
 9fhz8R2rx/Eb25k8Nr3yCOCK4rJJSc3JLEst0rdL4Mq4tWYxW8F8torLpxrZGxjnsHYxcnBI
 CJhIXJiX1cXIxSEksIRJ4vHqhWwQzmNGiZmvNgE5nBxsAuoSdzZ8YwWxRQTMJBatPQ9WxCxw
 BKjj1D5GkISwQJjE6133wRpYBFQlPu68xgJi8wpYSnw9c5wZxJYQkJeYeek7O4jNKWAlMWPL
 GrAaIaCa05cnMEPUC0qcnPkELM4MVN+8dTYzhC0hcfDFC2aIenmJF5eWs8DMnHbuNdT8UImt
 X7YzTWAUmoVk1Cwko2YhGbWAkXkVo1BuZnJ2alFmtl5BRmVJarJeSuomRlBUijBw7WDsm+Nx
 iJGJg/EQowQHs5II76YtnmlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVd3BKcKCaQnlqRmp6YW
 pBbBZJk4OKUaGEuMO26pvVHvZzE7tWKv5wHGB+FiEhs+KKtyPy6eXrT2l8zF4Pm3/AS9MhOv
 TBfsflXN8zs1zp5T6kLB5plstpKlv8xTH9V0qvTNa3n0U1+8WInV21mVneNppyajy1y5v+xh
 95ZHM7j8e56zs87V7pZbe8Mbr4UCK/JyF62UjBa8mHblQeteJZbijERDLeai4kQAYDMJJrgC
 AAA=
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

Call do_board_detect() hook before the K3 DDRSS driver gets probed.
It will allow boards to adjust DDR timings in do_board_detect().

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: John Ma <jma@phytec.com>
---
 arch/arm/mach-k3/am62x/am625_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index ed8d24e0433..72a752d38e8 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -213,6 +213,8 @@ void board_init_f(ulong dummy)
 
 	preloader_console_init();
 
+	do_board_detect();
+
 	/*
 	 * Allow establishing an early console as required for example when
 	 * doing a UART-based boot. Note that this console may not "survive"
-- 
2.34.1

