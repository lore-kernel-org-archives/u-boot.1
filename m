Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCA7C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0DE5885B3;
	Mon, 10 Jun 2024 15:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="tYrHiOqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB8A884E7; Mon, 10 Jun 2024 15:34:15 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC6188854A
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718026450; x=1720618450;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mz3Bi+GlXSmfCHLmxYiCo0QtBTYP6j19bPbTWOCJ17I=;
 b=tYrHiOqVuteKjbSHBPJtfs30Dfbnt3dbSsxsbbhyZxq4y2uQ8v2+z+1OPT9jjq7b
 EH/JolEqLgT0+O2Rs9agxlKld7GCk1dkm0VTsqo7ZGEKB6AMnrAMGJluTyzFIn1a
 4EKvSiAfz8p9I9DiuKP8OO97g7SmHri42SBTru11OGU=;
X-AuditID: ac14000a-03e52700000021bc-ed-666700d205c9
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 08.7D.08636.2D007666;
 Mon, 10 Jun 2024 15:34:10 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 15:34:10 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>, <nmorrisson@phytec.com>
Subject: [PATCH 09/13] board: phytec: phycore-am62x: Pull in k3_dfu.env
Date: Mon, 10 Jun 2024 15:33:48 +0200
Message-ID: <20240610133352.2473414-10-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWyRpKBR/cSQ3qawdeDJhYfGjezWUydtJnd
 4u3eTnaLd337mSy636k7sHq8OrCK3ePsnR2MHv3dLawefy6+Yw1gieKySUnNySxLLdK3S+DK
 ePF9G2vBaZaKOeu3sjQwNrJ0MXJySAiYSCw+vYipi5GLQ0hgCZPE1H3tbBDOY0aJ341PmECq
 2ATUJe5s+MYKYosIBEn0XvrECGIzC3hIbP27ASwuLOAusai5H2wqi4CqxM+n35lBbF4BK4m9
 l2ezQ2yTl5h56TuYzQkU/7FmL1ivkIClxKJPa1gg6gUlTs58wgIxX16ieetsZghbQuLgixfM
 EPXyEi8uLWeBmTnt3GtmCDtUYuuX7UwTGIVmIRk1C8moWUhGLWBkXsUolJuZnJ1alJmtV5BR
 WZKarJeSuokRFPIiDFw7GPvmeBxiZOJgPMQowcGsJMIrlJGcJsSbklhZlVqUH19UmpNafIhR
 moNFSZx3dUdwqpBAemJJanZqakFqEUyWiYNTqoGxhL/V+Q5PWGGF3pEreeHTflz83MQkFhS9
 NXip/PsDOcdNLN2cWN1VP0Yd0rL+m6pUF3U9wWrNnsDDrBGzG0oPzdyt7WXgedWneJpDC4eW
 pYKgXNTS97ENWScT1Lw8LDn+PnhteOFiv1aPsGZN88zkzumVNxOEFqhtf/Q38Gf1bYvI5JJ/
 E5VYijMSDbWYi4oTAbifjsBnAgAA
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

Pull in ti/k3_dfu.env for dfu_alt_info_ram in SPL stage.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62x/phycore_am62x.env | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index ada3a9233be..42db26a5990 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -1,3 +1,5 @@
+#include <env/ti/k3_dfu.env>
+
 fdtaddr=0x88000000
 loadaddr=0x82000000
 scriptaddr=0x80000000
-- 
2.34.1

