Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BCBC021AA
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E371080CB0;
	Mon, 17 Feb 2025 14:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YIWsZOwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5DF180F64; Mon, 17 Feb 2025 11:57:35 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70E080C7E
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 11:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51HAvTWJ507825
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 04:57:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739789849;
 bh=i69iYAdU88LvKB2mZpq3W6uIeky4Ebq8aGwd10WAGxU=;
 h=From:To:CC:Subject:Date;
 b=YIWsZOwNNXOqau1zsFKlAalCFX9G28VCDJarWDe0AmQFDcfKPTvpuB8WujVzXpFjL
 djeyJTNZsyy17oJ7J0g76AKczu0bOJOd3eKK11F30ygGFtKUR6DHR7eP+IBliyd3Mb
 P70zqRTdyU6ThmEVyAULSX1bSy7mv9igrQ+O5GWo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51HAvTNK009211
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Feb 2025 04:57:29 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Feb 2025 04:57:28 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Feb 2025 04:57:28 -0600
Received: from ubuntu.myguest.virtualbox.org ([10.249.128.48])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51HAvPXk071781;
 Mon, 17 Feb 2025 04:57:26 -0600
From: Keerthy <j-keerthy@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>
CC: <j-keerthy@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 0/2] arm: mach-k3: j722s: Enable ESM to support watchdogs 
Date: Mon, 17 Feb 2025 16:27:16 +0530
Message-ID: <20250217105718.3109-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 17 Feb 2025 14:28:17 +0100
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

The series enables watchdog support on J722S. It adds ESM initialization
to enable routing the watchdog events to trigger a SOC reset.

Tested on J722S-EVM.

Keerthy (2):
  arm: mach-k3: j722s: Initialize MCU & MAIN Domain ESMs
  configs: j722s_evm_r5_defconfig: Enable the ESM Configs to support
    watchdog

 arch/arm/mach-k3/j722s/j722s_init.c | 32 +++++++++++++++++++++++++++++
 configs/j722s_evm_r5_defconfig      |  3 +++
 2 files changed, 35 insertions(+)

-- 
2.17.1

