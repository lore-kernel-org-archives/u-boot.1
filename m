Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DCDE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 04:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4FB28036B;
	Wed,  8 Jan 2025 05:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VMIqIrgR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 020168005B; Wed,  8 Jan 2025 05:49:50 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63A8D8036B
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 05:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-patra@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5084njti101941;
 Tue, 7 Jan 2025 22:49:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736311785;
 bh=RrSyUl08lHf9hZAc1LojzaEuVuZ3HIoaei2ylSlrHCI=;
 h=From:To:CC:Subject:Date;
 b=VMIqIrgR7IFny8OpeZP8esKJpYq4ra0ECcfLdcbSMdyJShe9ud3pmUBZ28kXnjc1/
 4KFo0BihLWrxp2BSnE+F9+Y8hDCwdmM/8o9pFMA0Gz5n/R5VfmHMMDEmWIW5Vx6WYa
 u4G8J/0Buvgnr7/kIfGRdwtbTH3ai/dcGM+b7zeI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5084njAE019101
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Jan 2025 22:49:45 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Jan 2025 22:49:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Jan 2025 22:49:44 -0600
Received: from aparna-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (aparna-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.31])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5084ngnw130961;
 Tue, 7 Jan 2025 22:49:42 -0600
From: Aparna Patra <a-patra@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <bb@ti.com>
CC: <d-gole@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 Aparna Patra <a-patra@ti.com>
Subject: [PATCH v2 0/4] Add fdt-fixups for AM62P variants
Date: Wed, 8 Jan 2025 10:19:35 +0530
Message-ID: <20250108044939.392785-1-a-patra@ti.com>
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

This series implements fdt fixups, by reading hardware
information from registers and accordingly delete/modify
the DT nodes, at run-time.

Logs for AM62P boot:
https://gist.github.com/itsme-aparna/b889fe59882c1acf0ef25a644bd325c4

Changes from v1 to v2:
- Add another patch to set A53 CPU freq before core boots, as 
  mentioned by Bryan.

Aparna Patra (4):
  arm: mach-k3: am62p: Fixup CPU core, CAN-FD and Video-codec nodes in
    fdt
  arm: mach-k3: am62p: Fixup thermal zone critical points
  arm: mach-k3: am62p: Fixup a53 max cpu frequency by speed-grade
  arm: mach-k3: am62p: Set a53 cpu freq based on speed-grade

 arch/arm/mach-k3/am62px/am62p5_fdt.c          | 83 +++++++++++++++++++
 arch/arm/mach-k3/am62px/am62p5_init.c         | 62 ++++++++++++++
 .../arm/mach-k3/include/mach/am62p_hardware.h | 65 +++++++++++++++
 3 files changed, 210 insertions(+)


base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
-- 
2.34.1

