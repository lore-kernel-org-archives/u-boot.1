Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50233D5A6EA
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 07:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A74FE89736;
	Tue, 26 Nov 2024 08:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fA7yBu6D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B95788973E; Tue, 26 Nov 2024 08:06:22 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53B1989651
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQ76HEu790794
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2024 01:06:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732604777;
 bh=aOilaUX2TAuei6pDL/mcom5iiiGPiCT8jGuH1grVTOo=;
 h=From:To:CC:Subject:Date;
 b=fA7yBu6Da2tOr3yZ5fPWODxMQhvGGZjSZxdCSXT5tYVAAiwr/M+fFgtBsiF39+oJ7
 FnkED7G7D5aTlqXSZ+kOZU2iz3RspWAKjgm+wUxrpGRLH+lc2N9FMk7XbN0pDhMx4j
 yTDHXLdmFnc2piSFPVcYoqQpF++XVX+W5TrmHhAw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQ76Hub024350
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Nov 2024 01:06:17 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 01:06:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 01:06:16 -0600
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com
 [10.24.72.175])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ76FMW092896;
 Tue, 26 Nov 2024 01:06:16 -0600
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <bb@ti.com>
CC: <vaishnav.a@ti.com>, <afd@ti.com>, <n-francis@ti.com>, <seanga2@gmail.com>,
 <francesco.dolcini@toradex.com>, <sjg@chromium.org>,
 <w.egorov@phytec.de>, <devarsht@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH v2 0/4] Add QOS support for J722S and AM62P
Date: Tue, 26 Nov 2024 12:36:10 +0530
Message-ID: <20241126070614.47136-1-j-choudhary@ti.com>
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

Add QOS support for DSS in TI K3 SoC to route the DSS traffic through
RT queue by setting orderID as 15:
- J722S
- AM62P

Changelog v1->v2:
- Rebased on the tip of next branch
- Corrected the commit message in patch 2/4

v1:
<https://lore.kernel.org/all/20241106063930.59870-1-j-choudhary@ti.com/>

Jayesh Choudhary (4):
  arm: mach-k3: j722s: Add QoS support for DSS
  arm: mach-k3: am62p: Add QoS support for DSS
  configs: j722s_evm_r5_defconfig: Enable CONFIG_K3_QOS
  configs: am62p_evm_r5_defconfig: Enable CONFIG_K3_QOS

 arch/arm/mach-k3/am62px/am62p5_init.c        |  2 +
 arch/arm/mach-k3/j722s/j722s_init.c          |  1 +
 arch/arm/mach-k3/r5/am62px/Makefile          |  1 +
 arch/arm/mach-k3/r5/am62px/am62p_qos.h       | 42 ++++++++++++++
 arch/arm/mach-k3/r5/am62px/am62p_qos_uboot.c | 58 ++++++++++++++++++++
 arch/arm/mach-k3/r5/j722s/Makefile           |  1 +
 arch/arm/mach-k3/r5/j722s/j722s_qos.h        | 51 +++++++++++++++++
 arch/arm/mach-k3/r5/j722s/j722s_qos_uboot.c  | 58 ++++++++++++++++++++
 configs/am62px_evm_r5_defconfig              |  1 +
 configs/j722s_evm_r5_defconfig               |  1 +
 10 files changed, 216 insertions(+)
 create mode 100644 arch/arm/mach-k3/r5/am62px/am62p_qos.h
 create mode 100644 arch/arm/mach-k3/r5/am62px/am62p_qos_uboot.c
 create mode 100644 arch/arm/mach-k3/r5/j722s/j722s_qos.h
 create mode 100644 arch/arm/mach-k3/r5/j722s/j722s_qos_uboot.c

-- 
2.34.1

