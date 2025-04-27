Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18923C369D5
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 07:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A0D882105;
	Sun, 27 Apr 2025 09:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XMmFA6v7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D098209F; Sun, 27 Apr 2025 09:03:38 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 769EE82075
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 09:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53R73Rhs3123567
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 27 Apr 2025 02:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745737407;
 bh=L4cd5M93EP6DtYqmGKC0l5LYvImNPkS27Vf+fonfZT8=;
 h=From:To:CC:Subject:Date;
 b=XMmFA6v7gdcAw468UaX9mpRvMPaZDV12Dsj2Eb/aaxexVinfy2Ng9awVkS8B7QHAT
 q7Kvt3VCjhGW1cJHhCiMKvpa/gl9xEkwLfLxVt0OBFstU3XxL38cvIpEopXOoHofa3
 KrKmpALUugoP1GYxiqE4k5rlmATS9Gcp56oZ6FUU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53R73RVO100798
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 27 Apr 2025 02:03:27 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 27
 Apr 2025 02:03:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 27 Apr 2025 02:03:27 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53R73Ou9011250;
 Sun, 27 Apr 2025 02:03:24 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <eballetbo@redhat.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <b-padhi@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>
Subject: [v3 PATCH 0/4] k3-j784s4*: Enable ESMs and related PMIC
Date: Sun, 27 Apr 2025 12:33:19 +0530
Message-ID: <20250427070323.590449-1-u-kumar1@ti.com>
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

This series enables the ESMs and the associated PMIC. Programming these bits is
a requirement to make the watchdog actually reset the board.

Series supports WDT reset on all TI platforms based upon J784S4 SOC
including cut down (J742S2).


Bootlogs for reset

AM69: https://gist.github.com/uditkumarti/dca2171aafd6d50c82159346f9a0102f#file-am69-L2466 

J784S4: https://gist.github.com/uditkumarti/dca2171aafd6d50c82159346f9a0102f#file-j784s4-L2704

J742S2: https://gist.github.com/uditkumarti/dca2171aafd6d50c82159346f9a0102f#file-j742s2-L2614
 
Changes in v3:
- Rebased to 2025.04
- Link to v2: https://lore.kernel.org/all/20240911-j784s4-esm-enable-v2-0-957f56b588d9@redhat.com/

Changes in v2:
- Loop over ESMs, only configure if prior was successful
  as without all of them they're not useful (Udit)
- Add am69-sk PMIC ESM node (Udit)
- Link to v1: https://lore.kernel.org/r/20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com


Andrew Halaney (2):
  arm: dts: k3-am69-r5-evm: Add the PMIC ESM node
  configs: j784s4_evm_r5: Enable ESM related configs

Keerthy (1):
  board: ti: j784s4: Initialize the ESM & PMIC ESM

Neha Malcom Francis (1):
  arm: dts: k3-j784s4-r5-evm: Add the PMIC ESM node

 arch/arm/dts/k3-am69-r5-sk.dts    |  7 +++++++
 arch/arm/dts/k3-j784s4-r5-evm.dts |  7 +++++++
 board/ti/j784s4/evm.c             | 24 ++++++++++++++++++++++++
 configs/j784s4_evm_r5_defconfig   |  5 +++++
 4 files changed, 43 insertions(+)

-- 
2.34.1

