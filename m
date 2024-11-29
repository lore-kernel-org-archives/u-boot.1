Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5DBD6EC05
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 12:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEBCC892D9;
	Fri, 29 Nov 2024 13:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XD9EJMdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D7789392; Fri, 29 Nov 2024 12:32:04 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E512893C9
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 12:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBVmmn083517;
 Fri, 29 Nov 2024 05:31:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732879908;
 bh=+AvxZz/v9FTR24u1wwgIHmUO+UDHmta+q2aXQO16iu0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=XD9EJMdjs4Lickn+HaZ0QzgrU9Rs025OnHEJwYeaatKn/BeFRBXBta5TYK40WtCQg
 zIH+jl22Uvbck5/y0EAPeOMji+xjWktpA/6lbh9rXmjAiCbDxaGpWM51J9HnEoqq+K
 eMh2kSoMTTzHje1td8UG8RwgPsj3wWzrRKXJ48Gk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ATBVmBd029568
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Nov 2024 05:31:48 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Nov 2024 05:31:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Nov 2024 05:31:46 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBVabO106135;
 Fri, 29 Nov 2024 05:31:42 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <a-dutta@ti.com>, <sjg@chromium.org>,
 <marex@denx.de>, <jonas@kwiboo.se>, <kever.yang@rock-chips.com>,
 <william.zhang@broadcom.com>, <a-limaye@ti.com>, <u-kumar1@ti.com>,
 <vaishnav.a@ti.com>, <sumit.garg@linaro.org>,
 <quentin.schulz@cherry.de>, <p-mantena@ti.com>,
 <ilias.apalodimas@linaro.org>, <afd@ti.com>, <nm@ti.com>,
 <avromanov@salutedevices.com>, <michael@amarulasolutions.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 1/8] mux: Makefile: Add config for mux drivers
Date: Fri, 29 Nov 2024 17:01:29 +0530
Message-ID: <20241129113136.383277-2-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129113136.383277-1-a-dutta@ti.com>
References: <20241129113136.383277-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 29 Nov 2024 13:45:54 +0100
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

Add config required to build mmio-mux driver and dependencies.

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 drivers/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/Makefile b/drivers/Makefile
index 9440af1b09..0e1f58c515 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_$(PHASE_)INPUT) += input/
 obj-$(CONFIG_$(PHASE_)LED) += led/
 obj-$(CONFIG_$(PHASE_)MMC) += mmc/
 obj-y += mtd/
+obj-$(CONFIG_MULTIPLEXER) += mux/
 obj-$(CONFIG_$(PHASE_)ETH) += net/
 obj-$(CONFIG_$(PHASE_)PCH) += pch/
 obj-$(CONFIG_$(PHASE_)PCI) += pci/
-- 
2.34.1

