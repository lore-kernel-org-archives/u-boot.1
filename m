Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED0DCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 13:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A541083F70;
	Fri, 10 Oct 2025 15:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q3bbifqD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47B1983FCE; Fri, 10 Oct 2025 15:18:37 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1F4B83F6A
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 15:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59ADIWK2694395;
 Fri, 10 Oct 2025 08:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760102312;
 bh=a7YdsNFWB43fqMR3E7iK+cP4ZNlF6OTaiPrVycQ02tU=;
 h=From:To:CC:Subject:Date;
 b=q3bbifqD7w0IaVAnZeA44K+TwIce8Zg6xkxsUTnh9vidG1x1raDVjWgIrQ1rnWeDa
 5x3gy0y6lC9+DgZ0zffTBajkrVzzw8lr2wVGQ6t0YyiNa+wA37FV1NcrbCt4im343J
 yhm99cLZ23gufKg3jQVpHT4uKJ7mY7ILNScD0SMs=
Received: from DLEE203.ent.ti.com (dlee203.ent.ti.com [157.170.170.78])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59ADIWiM1700660
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 Oct 2025 08:18:32 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 08:18:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Oct 2025 08:18:32 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59ADIV771692548;
 Fri, 10 Oct 2025 08:18:31 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v1 0/5] Allow falcon boot from A-core SPL on K3 devices
Date: Fri, 10 Oct 2025 18:48:22 +0530
Message-ID: <20251010131829.3737258-1-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
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

Hi all,

With the addition of secure falcon mode from my last few series[1], this series
now adds support for the same to TI's K3 devices and documents the feature
taking AM62x EVM as an example.

The patch [5/5] (doc: develop: falcon: document unsetting CMD_BOOTx) of the
series is a workaround for now since we first need to refactor out the usage of
CMD_BOOTI/CMD_BOOTZ options from the SPL boot flow[2].

I will be working on a respin of my older series[3] addressing the same but for
now the workaround of disabling respective CMD_BOOTx option works well enough.
With that in place we should be able to revert the patch [5/5].

Regards,
Anshul

[1]: Patch series adding secure falcon mode support (in order of dependency):
  https://lore.kernel.org/u-boot/20250923124639.667718-1-anshuld@ti.com/ [MERGED]
  https://lore.kernel.org/u-boot/20251006101057.4172248-1-anshuld@ti.com/
  https://lore.kernel.org/u-boot/20251009115846.897186-1-anshuld@ti.com/
[2]: https://lore.kernel.org/u-boot/20250310135544.GV2640854@bill-the-cat/
[3]: https://lore.kernel.org/u-boot/20250408141436.712387-1-anshuld@ti.com/
---
Anshul Dalal (5):
  spl: Kconfig: allow falcon mode for TI secure devices
  board: ti: common: Kconfig: add CMD_SPL
  arm: mach-k3: enable support for falcon mode
  doc: develop: add docs for secure falcon mode
  doc: develop: falcon: document unsetting CMD_BOOTI

 arch/arm/mach-k3/common.c |   7 ++
 board/ti/common/Kconfig   |   1 +
 common/spl/Kconfig        |   2 +-
 doc/develop/falcon.rst    | 255 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 264 insertions(+), 1 deletion(-)

-- 
2.51.0

