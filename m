Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52A3CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 21:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AFDD83252;
	Wed, 27 Aug 2025 23:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XyHMJSnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 662A083106; Wed, 27 Aug 2025 20:51:07 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DAA2831B4
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 20:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-mcarthur@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57RIoxBj1353081;
 Wed, 27 Aug 2025 13:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756320659;
 bh=h1IFSLtIV4GTyJ995mS5acJXOMHbhArT4sMPt1c5RvM=;
 h=From:To:CC:Subject:Date;
 b=XyHMJSnqfx9xaip6ScanB2+r67dYSzcoSIVQJcnEE/Hwk3I8rzj/x4QSzw7R8iwXE
 oBZh/T9kYPsySacwpS8v8uH4hA0US+UAFcoEdKpveJwTW5N+cczv8ZwpjlsAt3e9rb
 s5qz9ZW33kgSj0zfsVHhLitTUGBd/jruTBKK/HMY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57RIowZ53373247
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 27 Aug 2025 13:50:59 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 27
 Aug 2025 13:50:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 27 Aug 2025 13:50:58 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.81])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57RIowpB3262713;
 Wed, 27 Aug 2025 13:50:58 -0500
From: Jared McArthur <j-mcarthur@ti.com>
To: <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Jared McArthur
 <j-mcarthur@ti.com>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] ufs: Add support for setting bRefClkFreq attribute
Date: Wed, 27 Aug 2025 13:50:54 -0500
Message-ID: <20250827185056.954640-1-j-mcarthur@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 27 Aug 2025 23:55:07 +0200
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

Currently, U-Boot doesn't set the bRefClkFreq attribute before
changing power mode of the UFS device. If there is a difference
between the UFS device and the host controller, all commands will fail
after switching to high speed.

This behavior is rarely observed, because Linux sets the bRefClkFreq
attribute on probe, and the bRefClkFreq is a persistent attribute. In
other words, once Linux has booted once, the issue will never be seen.

If trying to provision and boot from an unprovisioned UFS device,
U-Boot will fail. Fix this by adding support for setting the
bRefClkFreq attribute.

Jared McArthur (2):
  ufs: Add support for sending UFS attribute requests
  ufs: Add bRefClkFreq attribute setting

 drivers/ufs/ufs.c | 184 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs.h |  10 +++
 2 files changed, 194 insertions(+)

-- 
2.34.1

