Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BCFE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 13:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A836C89497;
	Tue, 10 Dec 2024 14:57:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PLCEYf3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D4F8949E; Tue, 10 Dec 2024 14:57:55 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03C6B8948F
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 14:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BADvoGh2678297
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 10 Dec 2024 07:57:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733839070;
 bh=XsW69EaPKnN7K9HEgUi8rQZczdiAYmtX5Kei16gFExQ=;
 h=From:To:CC:Subject:Date;
 b=PLCEYf3VoE5sTjzhKrxicxnBdSQOajF1ay3YL+8A906vdhv6kn4sJry+bfbe0rwxC
 7s/5aEavQIIwRzsJdfOtXfbjpZfTWNG+CKtNIgipFF+p87pQcE1nANnh/B7JmHA+FV
 Y0Bwnv9vXimmRpo/ugjlY4NJ4vOwL906+1GdCnVo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BADvoC7050729;
 Tue, 10 Dec 2024 07:57:50 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 07:57:50 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 07:57:50 -0600
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BADvkpD062352;
 Tue, 10 Dec 2024 07:57:47 -0600
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH 0/4] Fix OSPI boot for J722S
Date: Tue, 10 Dec 2024 19:27:27 +0530
Message-ID: <20241210135731.1043269-1-p-mantena@ti.com>
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

