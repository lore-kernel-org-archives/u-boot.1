Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7B5E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 17:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3771D80312;
	Wed, 18 Dec 2024 18:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kZ+KuUK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 439AD80241; Wed, 18 Dec 2024 18:12:41 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D813E80269
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-ramamoorthy@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BIHCajY189489
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 11:12:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734541957;
 bh=6kLgKZTdfVafDQtX1DwYriOv7UNj6hVNVIG+lA8QC8Y=;
 h=From:To:CC:Subject:Date;
 b=kZ+KuUK7MtRDOqvmHdesdpNPw7IUw4UG9PKzaSzayote4KnuWHjXUVxdr4yDtBbIx
 3Y3aW3sesKbeKrhKoYd6162LO+Po1CnMxRJ6iiIXoUF/OHlk8Xb0Hdq5EgUy1cK8vs
 U+1dFUfQFFc3GTu4T+1c4yZCUO9i8IoKCm3ktICQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BIHCav2079882
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2024 11:12:36 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 11:12:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 11:12:36 -0600
Received: from DMZ007XYY.dhcp.ti.com (dmz007xyy.dhcp.ti.com [128.247.29.8])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIHCaRX112285;
 Wed, 18 Dec 2024 11:12:36 -0600
From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
To: <u-boot@lists.denx.de>, <jh80.chung@samsung.com>, <trini@konsulko.com>
CC: <m-leonard@ti.com>, <praneeth@ti.com>
Subject: [PATCH v1 0/2] TPS65219 U-Boot Driver Clean-Up
Date: Wed, 18 Dec 2024 11:12:34 -0600
Message-ID: <20241218171236.1022565-1-s-ramamoorthy@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 18 Dec 2024 18:36:03 +0100
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

This clean-up series is sent in preparation to add 2 PMIC devices to the 
TPS65219 Driver. The changes involve replacing magic numbers with macros 
and replacing printf() instances with pr_err(). The intention is to remove 
unnecessary noise from the new PMIC device patches added to this driver.

Test Log (AM62B-P1 + TPS65219 EVM):
https://gist.github.com/ramamoorthyhs/8c81e33cf6d46c8b5fc135424a5f224b

Kernel baseline used in test log:
Reg: https://lore.kernel.org/all/20241217204526.1010989-1-s-ramamoorthy@ti.com/
GPIO: https://lore.kernel.org/all/20241217204755.1011731-1-s-ramamoorthy@ti.com/
MFD: https://lore.kernel.org/all/20241217204935.1012106-1-s-ramamoorthy@ti.com/

Shree Ramamoorthy (2):
  power: regulator: replace printf() with pr_err()
  power: replace magic numbers with macros

 drivers/power/regulator/tps65219_regulator.c | 30 ++++++++++----------
 include/power/tps65219.h                     | 14 +++++++--
 2 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.34.1

