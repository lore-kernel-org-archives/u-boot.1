Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AD7C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 04:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9664980805;
	Sat,  8 Feb 2025 05:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hypec/8p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6285F80812; Sat,  8 Feb 2025 05:39:46 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7185807F1
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 05:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5184dfF53047962
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Feb 2025 22:39:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738989581;
 bh=3nwmDbFOlyYx+a7MJisKyiTQhDwKd3mWsEtk5p/rm2k=;
 h=From:To:CC:Subject:Date;
 b=hypec/8pJBzNdVqh+pNeOBtxU9lV6mwoUb62YUaysYspnGZsnWDFzPkCF8fR2tyVE
 DNAgy4oTqy5O1csWqA3H1wF5LJ85tPRLGriuZlIfubfImjAgCETT99VnHL2GKsZw2M
 iuVI6QcKICkZRG2s9Vy3Ivc30VJaJaBfYxaM3bgc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5184dfAp016075
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Feb 2025 22:39:41 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Feb 2025 22:39:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Feb 2025 22:39:41 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5184dcKm045742;
 Fri, 7 Feb 2025 22:39:39 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <afd@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <a-dutta@ti.com>, <a-chavda@ti.com>,
 <u-kumar1@ti.com>
Subject: [PATCH 0/2] Remove "saveenv" functionality from am57xx evms 
Date: Sat, 8 Feb 2025 10:09:36 +0530
Message-ID: <20250208043938.52832-1-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Previously saved environment introduce discrepancies and may lead to
incompatibilities without default settings. This series removes the saved
environment functionality on am57xx evms so that the default configuration
is always loaded

Test result: https://gist.github.com/anuragdutta731/b253ddb0a5538ab6588a3535d7bbecf7

Anurag Dutta (2):
  configs: am57xx_hs: Remove saved environments
  configs: am57xx: Remove saved environments

 configs/am57xx_evm_defconfig    | 4 +---
 configs/am57xx_hs_evm_defconfig | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.34.1

