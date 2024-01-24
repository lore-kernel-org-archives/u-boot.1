Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05E3C47422
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 07:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8231E87BC3;
	Wed, 24 Jan 2024 08:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MLzwEmr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BA2287BDE; Wed, 24 Jan 2024 08:26:39 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7438087613
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 08:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40O7QWnE035746
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 01:26:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706081192;
 bh=7CF4FaKXN7AD1h6KdtqNKz99AXOUCqQDrZK8xMQyS3Q=;
 h=From:Subject:Date:To:CC;
 b=MLzwEmr6TtR9Nqpd/w6TQgVUxbZTYVXm/tJi2HJzByVeKQIZYmukYid7cztKa+1cT
 xCY+Q562tmHl2MhhvIPOwBghPeQj1Wmlw07kJdopW0cnOP4vqT/7dXqos3DlTsJGaI
 2PaOldUi2C2RrlFM11fhDiFEMxAU+bxe9/nCCTe0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40O7QWl0010913
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 01:26:32 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 01:26:32 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 01:26:32 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40O7QTGh015268;
 Wed, 24 Jan 2024 01:26:30 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH 0/2] Add save_uenv command
Date: Wed, 24 Jan 2024 12:56:24 +0530
Message-ID: <20240124-b4-upstream-save_uenv-v1-0-4a4dfbd3eca9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKC7sGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyMT3SQT3dKC4pKi1MRc3eLEstT40tS8Ml1DcwsTEzPjtFSTlEQloN6
 CotS0zAqwudGxtbUAYFSZkmcAAAA=
To: Udit Kumar <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Aniket Limaye <a-limaye@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706081189; l=653;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=3FxUgnSCDpQKEvZCBWM77ptzwgXE8di6J2KKPtm8dZ8=;
 b=ftNM+42wE9Hy0j5i+CnafZEg+G9uJAvlajLQLToI6u3sNEZ6xL7EvqU8k1K5wMBu15yl6HwpQ
 YQv6BP5NTZOCMcQTqo4WSlvl/OQH/1nhgqJ5wNQWERbLmc4rdrkOZGj
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Adding this command for easier development to update uEnv.txt from
u-boot on the u-boot prompt and track the variables being updated in
uEnv.txt as well.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Manorit Chawdhry (2):
      env: ti: mmc: add save_uenv command
      doc: k3: update documentation for uEnv.txt

 doc/board/ti/k3.rst    | 24 ++++++++++++++----------
 include/env/ti/mmc.env |  3 +++
 2 files changed, 17 insertions(+), 10 deletions(-)
---
base-commit: f28a77589e7505535a4eebdc7269df98f67dbe68
change-id: 20240124-b4-upstream-save_uenv-1784463fe4da

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

