Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8078EC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 06:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A017580F12;
	Wed, 26 Feb 2025 07:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gocfAet4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25EE880F53; Wed, 26 Feb 2025 07:39:51 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A305E807EE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:39:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6djQJ1996420
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 00:39:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740551985;
 bh=t55kXV7b7xIVYPruy54/SH1/kjTmTocXLLKaCcqYGpo=;
 h=From:To:CC:Subject:Date;
 b=gocfAet4TDwbaZnJ807NNixYzLefbwvmADxJCg6+DY0mHxucoeK9dxuGwBsj2Pg58
 rLVb+hmsmRUyxAciWPjbZd2a0GhtNVnikCMu2eAvkgPSKsSlBC21BQLmcmzePV917m
 GkrTL5S99E1x8qWr8ofHuhYAQN67q5WRqYF1GQbQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6djvT007124
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Feb 2025 00:39:45 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 00:39:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 00:39:44 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51Q6dgM7049984;
 Wed, 26 Feb 2025 00:39:43 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH 0/5] Update DDR Configurations
Date: Wed, 26 Feb 2025 12:09:18 +0530
Message-ID: <20250226063923.2266288-1-s-k6@ti.com>
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

This series is to update the DDR configurations of AM64x EVM, AM62x SK,
AM62x LP SK, AM62Ax SK and AM62Px SK boards according to the SysConfig
DDR Configuration tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02.

Test logs: https://gist.github.com/santhosh21/43723900f3615e4cf98da57ed9618cf9

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Santhosh Kumar K (5):
  arm: dts: k3-am64: Update DDR Configurations
  arm: dts: k3-am62x: Update DDR Configurations
  arm: dts: k3-am62-lp: Update DDR Configurations
  arm: dts: k3-am62a: Update DDR Configurations
  arm: dts: k3-am62p: Update DDR Configurations

 arch/arm/dts/k3-am62-lp4-50-800-800.dtsi     | 16 ++++---
 arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi | 50 ++++++++++----------
 arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi   | 12 ++---
 arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi   | 14 +++---
 arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi   | 16 ++++---
 5 files changed, 58 insertions(+), 50 deletions(-)

-- 
2.34.1

