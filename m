Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D17C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 15:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88C058879E;
	Tue,  7 May 2024 17:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="cqNHJIY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41E3488746; Tue,  7 May 2024 17:18:11 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF62F88749
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 17:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1715095086; x=1717687086;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qunyx4pRK94wBpKVL1/+6zA0QvviwZjwxrukJVrePwY=;
 b=cqNHJIY8EfhT45BPik5ypVGgGGOg69ss3iyq9a96G1aOzK8wiPRQrFaBllkT/CP7
 4lOwPLKRt4U65UVT0AIASZrqtnlupy4GxbaMslF5HmkLob+NroSeboGKNjooib3+
 OLIHeiccWarMKwBieqlZgJCEgOvMdjAk9mgG+6y14L4=;
X-AuditID: ac14000a-fadff7000000290d-9f-663a462ec57f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 89.49.10509.E264A366;
 Tue,  7 May 2024 17:18:06 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 7 May 2024
 17:18:06 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <nm@ti.com>, <bb@ti.com>, <y.moog@phytec.de>,
 <t.remmet@phytec.de>, <d.schultz@phytec.de>, <festevam@gmail.com>,
 <mkorpershoek@baylibre.com>, <joao.goncalves@toradex.com>, <n-jain1@ti.com>,
 <michael@amarulasolutions.com>, <d-gole@ti.com>, <sjg@chromium.org>,
 <clamor95@gmail.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <jma@phytec.com>
Subject: [PATCH 3/5] arm: mach-k3: am625: Call do_board_detect() before DDR
 probing
Date: Tue, 7 May 2024 17:17:55 +0200
Message-ID: <20240507151757.1202825-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507151757.1202825-1-w.egorov@phytec.de>
References: <20240507151757.1202825-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWyRpKBR1fPzSrN4PoHCYv3pyayW8x9c4DV
 4kB/L6NFy1oPi4dX/S2edTYxW1y+f5PV4tKDVItTja0sFi+OzWW36P//nMnizY+zTBbftmxj
 tJg6aTO7xdu9newW3e/UHQQ81n68z+rx/kYru8fshossHjtn3WX3eHVgFbvH2Ts7GD36u1tY
 Pf5cfMfqcfzGdiaPTa88AriiuGxSUnMyy1KL9O0SuDIOXF3DXHCHteLeoT3MDYz3WLoYOTkk
 BEwkPu57y97FyMUhJLCESeLZ2ZXMEM4jRolZPyayg1SxCahL3NnwjRXEFhEwk1i09jwbSBGz
 wDsmifWHp7CBJIQFgiV2zTwPNpZFQEViaeMRsDivgKVE5/9d7BDr5CVmXvoOZnMKWElMWfGG
 EcQWAqp5fvwzM0S9oMTJmU/A5jAD1Tdvnc0MYUtIHHzxghmiXl7ixaXlLDAzp517zQxhh0oc
 2bSaaQKj0Cwko2YhGTULyagFjMyrGIVyM5OzU4sys/UKMipLUpP1UlI3MYLiUoSBawdj3xyP
 Q4xMHIyHGCU4mJVEeI+2m6cJ8aYkVlalFuXHF5XmpBYfYpTmYFES513dEZwqJJCeWJKanZpa
 kFoEk2Xi4JRqYExn2RpwRFfhz2+3S9fYuFZGRD1esOPn22drc4SDglo2B/7oibONn3lUbcZu
 5bCtvMdK/mbv/8XYGSNwwGyOVq2WwvY5C5fNS6n6JCPUwGJ689Xq7Xsv9H/OmeWl3RZo9HvO
 x1X3psbV593St2w4m+tvbJkp/kxYMXOm4sFLC8M2hIg97Lh9978SS3FGoqEWc1FxIgA75Jgj
 uQIAAA==
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
---
 arch/arm/mach-k3/am625_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
index 668f9a51ef4..672de1c03de 100644
--- a/arch/arm/mach-k3/am625_init.c
+++ b/arch/arm/mach-k3/am625_init.c
@@ -212,6 +212,8 @@ void board_init_f(ulong dummy)
 
 	preloader_console_init();
 
+	do_board_detect();
+
 	/*
 	 * Allow establishing an early console as required for example when
 	 * doing a UART-based boot. Note that this console may not "survive"
-- 
2.34.1

