Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD97C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 09:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4672810E8;
	Tue, 22 Apr 2025 11:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XiV7B1h3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033578171B; Tue, 22 Apr 2025 11:54:39 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 497B2809A5
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 11:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53M9sYm01906125
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 04:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745315674;
 bh=SbFwUyYWlZIqqnDY+yaSH/CSGzoycyjOsq86Sz/Cx5Y=;
 h=From:To:CC:Subject:Date;
 b=XiV7B1h3GH8l4G2el5pUGpr2zk6a5/4ipJh7IRBGHZgp7JMfUbeFtlpW+M1uBvtDX
 4lRQLwAPgf3DpFZxl+ynTmZbHbd6IKr8ImB84FPEfD1Uvm2+YMIUsaTbfUAIIpKn7J
 cZHy59x9lnFmlF6AiQE18NXZMqNehrW6S70AKdYY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53M9sY9S050821
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 04:54:34 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 04:54:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 04:54:34 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53M9sVGT088247;
 Tue, 22 Apr 2025 04:54:31 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 0/4] Add support to boot TI K3 HSM M4 core
Date: Tue, 22 Apr 2025 15:24:26 +0530
Message-ID: <20250422095430.363792-1-b-padhi@ti.com>
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

Some TI K3 SoCs like J721S2, and J784S4 have a HSM (High Security
Module) M4F core in the Wakeup Voltage Domain which could be used to
run secure services like Authentication. Boot flow for HSM M4 core is
different than the general purpose M4F cores, and is as below:

1. Request control of HSM M4F remote processor.
2. Assert Reset on the HSM M4F remote processor.
3. Request Secure Entity to Authenticate and Load HSM firmware into
   core's internal SRAM memory region. For GP device, load the firmware
   manually into core's SRAM region.
4. Deassert Reset on the HSM M4F remote processor.
5. Release control of HSM M4F remote processor.

This series adds support to boot HSM M4 core from R5 SPL stage. The HSM
firmware is packed inside the tispl.bin fit image. The firmware is
unpacked into a temporary DDR address which is then used to load HSM
core. The configs to boot HSM M4 core are disabled by default.

Test logs after enabling HSM boot configs:
https://gist.github.com/3V3RYONE/608f16c7c60c27be1343957b4955dc1a

Beleswar Padhi (4):
  arm: mach-k3: Add config option for booting HSM core
  arm: dts: k3-binman: Add template for packing HSM firmware
  arm: dts: k3-{j721s2/j784s4}-binman: Pack HSM firmware inside
    tispl.bin
  arm: mach-k3: r5: common: Add support to boot HSM M4 core

 arch/arm/dts/k3-binman.dtsi        | 11 ++++
 arch/arm/dts/k3-j721s2-binman.dtsi | 12 +++++
 arch/arm/dts/k3-j784s4-binman.dtsi | 14 +++++
 arch/arm/mach-k3/Kconfig           |  8 +++
 arch/arm/mach-k3/r5/common.c       | 84 +++++++++++++++++++++++++++++-
 5 files changed, 128 insertions(+), 1 deletion(-)

-- 
2.34.1

