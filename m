Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23383E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87B7B80241;
	Wed, 18 Dec 2024 14:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZJo5mI3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13FF380269; Wed, 18 Dec 2024 14:13:55 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D1E8022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BIDDmtR074944;
 Wed, 18 Dec 2024 07:13:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734527628;
 bh=s+k+KneSdc0RHBnC49WXPYrJ8iac8R+v+jU1Er8TkbQ=;
 h=From:To:CC:Subject:Date;
 b=ZJo5mI3WlDuG6YTNhrzBkiYMa9H/F/uGLYJrYbgYTHitn0hAqF3WLOd4APLW2phso
 +WuXDj5AzEMuUZJo9nKEsQnCVr9VSD+XNvRfDDL0dvJbQHJp5wNh9s3u7VWHtqARvp
 jWGl9BgTKGsBsWfojwil7VnQHkSn+jZ8tJ6dsiEI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIDDmgK059399;
 Wed, 18 Dec 2024 07:13:48 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 07:13:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 07:13:48 -0600
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIDDjRY035276;
 Wed, 18 Dec 2024 07:13:46 -0600
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2 0/4] Fix OSPI boot for J722S
Date: Wed, 18 Dec 2024 18:43:37 +0530
Message-ID: <20241218131341.2073823-1-p-mantena@ti.com>
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

This series fixes OSPI boot for J722S. It contains fixes for DMSC
communication, R5 regmap for ospi and dma specific overrides for ospi.

Test log: https://gist.github.com/PrasanthBabuMantena/ad469dd09ab7263f85f87dadda46c86d

v2 <==> v1
* Add Fixes tag wherever required.
* Improve commit message.

Vaishnav Achath (4):
  mailbox: k3-sec-proxy: Add DM to DMSC communication thread for J722S
  arm: dts: k3-j722s-r5-evm: Fix DM2TIFS secproxy thread ID
  arm: mach-k3: j722_spl: Add FAST XSPI boot mode
  arm: dts: k3-j722s*: Add overrides specific to OSPI

 arch/arm/dts/k3-j722s-evm-u-boot.dtsi     |  4 ++++
 arch/arm/dts/k3-j722s-r5-evm.dts          | 17 +++++++++++++++--
 arch/arm/mach-k3/include/mach/j722s_spl.h |  1 +
 arch/arm/mach-k3/j722s/j722s_init.c       |  2 ++
 drivers/mailbox/k3-sec-proxy.c            |  2 +-
 5 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.34.1

