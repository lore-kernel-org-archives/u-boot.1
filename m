Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7439FC369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA488219C;
	Mon, 14 Apr 2025 22:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="djZT8HcO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C2D18269F; Mon, 14 Apr 2025 22:20:08 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D26608219C
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EKK3cc2857151
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 15:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744662004;
 bh=hGIqAOsTOM0vk+v6zGH3QtYk2M3ONXubi9cdKCK8L7s=;
 h=From:Subject:Date:To:CC;
 b=djZT8HcO6z8mKQhiUDaGzB55ZhxAKAQOoqOG45kIsFft+15YMw8SpfdD5PKB/SsUP
 FrVJzM1DNgjvsdlgfgtA8u7zWqfDQynILScmar9ZK+cDpwJbHWDNISXly9qzazRorV
 ulQ1FwT7Tk+MaZh7nQ21XISGimzS+fwF9TEit/vo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EKK4bW027053
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Apr 2025 15:20:04 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 15:20:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 15:20:03 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EKK3eY036849;
 Mon, 14 Apr 2025 15:20:03 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/2] arm: mach-k3: remove some firewalls left over by ROM
Date: Mon, 14 Apr 2025 15:20:01 -0500
Message-ID: <20250414-firewalls-v1-0-89090085c08b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPJt/WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMz3bTMotTyxJycYl0DIzNTozQTi5Sk5EQloPqCotS0zAqwWdGxtbU
 ADPWXp1sAAAA=
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
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

Hello everyone!

This small series is here to remove some firewalls setup by ROM during 
their boot and clean things up for Linux later on. Ideally this would be 
a simple call to remove_fwl_configs() however the location of the 
firewall is problematic (could potentially crash the core) when we're 
currently executing from the memory region protected by the firewall. 

So we need to introduce a function which allows us to disable specific 
firewall regions and skip others to ensure boot stability.

Happy Hacking
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (2):
      arm: mach-k3: support disabling a single firewall region
      arm: mach-k3: am625: remove any firewalls ROM has configured for HSRAM

 arch/arm/mach-k3/am62x/am625_init.c | 12 ++++++++++++
 arch/arm/mach-k3/common.h           |  1 +
 arch/arm/mach-k3/r5/common.c        | 25 +++++++++++++++++++++++++
 3 files changed, 38 insertions(+)
---
base-commit: 739ad58dbee874a3ad3bddd116e995212a254e07
change-id: 20250326-firewalls-02652f48dbca

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

