Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AF9C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 21:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1BA6881FD;
	Mon, 15 Apr 2024 23:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D4NOFLUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48BA188145; Mon, 15 Apr 2024 23:27:54 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF7E58819D
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 23:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43FLRmBR030464;
 Mon, 15 Apr 2024 16:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713216468;
 bh=mExe2YRcPgA0lXUNOuzn+em2PEtdvRCYdh7IArKJZ9U=;
 h=From:To:CC:Subject:Date;
 b=D4NOFLUuQvQ3nl/oGRfdO7Z60BXfgk3LJ2Y91drwMDybcVwT+z2z/43q40L5QwU8A
 J4RwB8xNHBi6814nsysTW9aUb4ivBBxj6g5k7P+WNUMPNxXmDOx8tT9QX3MuZNx5hL
 CXxYD2qwXeflapjxLlC7djDZiIikWy1unQwtjPaQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43FLRmSJ017638
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Apr 2024 16:27:48 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 16:27:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 16:27:47 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43FLRlu4070400;
 Mon, 15 Apr 2024 16:27:47 -0500
From: Judith Mendez <jm@ti.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
CC: Nitin Yadav <n-yadav@ti.com>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: [PATCH 0/5] Fix MMC tuning algorithm
Date: Mon, 15 Apr 2024 16:27:42 -0500
Message-ID: <20240415212747.2678974-1-jm@ti.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The following patch series includes a MMC tuning algorithm
fix according to the following published paper [0].

This seris also includes fixes for OTAP/ITAP delay values
in j721e_4bit_sdhci_set_ios_post and for HS400 mode.

For DDR52 mode, also set ENDLL=1 and call am654_sdhci_setup_dll()
instead of am654_sdhci_setup_delay_chain() according to
device datasheet[1].

[0] https://www.ti.com/lit/an/spract9/spract9.pdf
[1] https://www.ti.com/lit/ds/symlink/am62p.pdf

Judith Mendez (4):
  mmc: am654_sdhci: Add tuning algorithm for delay chain
  mmc: am654_sdhci: Add itap_del_ena[] to store itapdlyena bit
  mmc: am654_sdhci: Set ENDLL=1 for DDR52 mode
  mmc: am654_sdhci: Fix ITAPDLY for HS400 timing

Nitin Yadav (1):
  mmc: am654_sdhci: Fix OTAP/ITAP delay values

 drivers/mmc/am654_sdhci.c | 170 +++++++++++++++++++++++++++++++-------
 1 file changed, 138 insertions(+), 32 deletions(-)


base-commit: 27795dd717dadc73091e1b4d6c50952b93aaa819
-- 
2.43.2

