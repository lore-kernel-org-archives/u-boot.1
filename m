Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63ABC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 05:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AD2287469;
	Fri, 17 Nov 2023 06:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Jw1C+Lr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D305286E64; Fri, 17 Nov 2023 06:03:10 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A11787463
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 06:03:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AH52xHh121921;
 Thu, 16 Nov 2023 23:02:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700197379;
 bh=rgFseKBBoo5hda8UXU+sTaeKg/uVLamDUyg56qvKZJc=;
 h=From:Subject:Date:To:CC;
 b=Jw1C+Lr+Xu7qwqQLUNsyUmPcu8EbEAGaeOC6gCeINIdKjLNBSyh2OlMLMmN267pIg
 eauk5TvSUkqNrQ0+6bh3dsv5Bxigy6nVtDOMZAGSHTu4OS0v8R0i9e/7Nu/tQPsV9R
 i8OveljcIZKjr9TKG/aWkKMpackKFSx0nH+b2FOk=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AH52x6e035343
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 16 Nov 2023 23:02:59 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 Nov 2023 23:02:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 Nov 2023 23:02:59 -0600
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AH52uM3002965;
 Thu, 16 Nov 2023 23:02:57 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH 0/2] J721S2/AM68 DT Sync with Linux DT v6.7-rc1
Date: Fri, 17 Nov 2023 10:32:55 +0530
Message-ID: <20231117-b4-upstream-j721s2-dt-sync-6-7-rc1-v1-0-d9a8cfbf1be7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP/zVmUC/x3NwQrCMAyA4VcZORtY4mLFVxEPaxs1gnU0U5Sxd
 1/x+F3+fwHXaupw6hao+jG3V2mgXQfpPpabouVm4J73RCQYB3xPPlcdn/gITM6YZ/RfSXjAgDU
 RimQJ0vMxxwgtNFW92vc/OV/WdQPJDmQTdAAAAA==
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>, Reid Tonking
 <reidt@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700197376; l=975;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=YgB/61TU/9vlOxIIyV+5LMLw1RNdQFm1xqf59D4bjxM=;
 b=VzwuRFpjvc01d1tQk7m0aLH6LjAERg+PxDB3PDPUvK4YvCA4sfBnU9W2PxvDH1D/A7wPUwJv1
 hbi9zpK2kjwCui7cmRkiafVKJ8CqRnGvHaaX5OBeLPy+Kplzpo1+ii5
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The series syncs the DT from Linux v6.7-rc1 to U-boot.

Boot Logs: https://gist.github.com/manorit2001/4f810a2a84fd3acf3a58d40e50120c53

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Manorit Chawdhry (2):
      arm: dts: k3-j721s2*: Sync with kernel v6.7-rc1
      arm: dts: k3-am68*: Sync with kernel v6.7-rc1

 arch/arm/dts/k3-am68-sk-base-board.dts |  56 ++++++++
 arch/arm/dts/k3-am68-sk-som.dtsi       | 208 +++++++++++++++++++++++++++++
 arch/arm/dts/k3-j721s2-main.dtsi       | 232 ++++++++++++++++++++++++++++++++-
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi |  82 +++++++++++-
 arch/arm/dts/k3-j721s2-som-p0.dtsi     | 208 +++++++++++++++++++++++++++++
 arch/arm/dts/k3-serdes.h               |   2 +-
 6 files changed, 785 insertions(+), 3 deletions(-)
---
base-commit: 17e9db18f17b6cad278694d4a61df95e96bdf4f5
change-id: 20231115-b4-upstream-j721s2-dt-sync-6-7-rc1-55d575028dbb

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

