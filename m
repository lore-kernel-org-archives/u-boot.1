Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8EDC48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 12:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D122687CB0;
	Tue,  6 Feb 2024 13:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p1awyKDw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A519987C78; Tue,  6 Feb 2024 13:21:24 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8809A87CAC
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 13:21:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416CLKOf002599;
 Tue, 6 Feb 2024 06:21:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707222080;
 bh=MMaVsoZjMSw9tyrVgR7L0I4FvNbmGa3wVDwY1qRPTLg=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=p1awyKDwW36CFaO6mn/wmeGDpqUdPjo0CzpzusqvJfU0pulfTuMXOLLTF7z54Ivi7
 z3MciMY6oHtBF7fyjx6sFRzupMmyfcLhOUcTW3slnwQf3HnF8t+rGyQBukk9WarnfC
 nY/0agqhX/laZ9HyuKmwMT+sdIX2deIk4Ij8rwdQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416CLKvj032050
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Feb 2024 06:21:20 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 06:21:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 06:21:20 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416CLAi1081923;
 Tue, 6 Feb 2024 06:21:17 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 6 Feb 2024 17:51:09 +0530
Subject: [PATCH 02/10] arm: dts: k3-am68*: Sync with 6.8-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240206-b4-upstream-j721s2-avs-v1-2-b75043c59969@ti.com>
References: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
In-Reply-To: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707222070; l=655;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=VmvxJgn42Q3w0/3+iyDlmgqLyeUfovPm6XZmmrtklco=;
 b=hnQYMoovYhcRLaOvESdZxLaWch+0w53VHATYZwckS2xqjXslDMBhXh6AQLxPMj/0/aSzrMTqO
 Nz9ZcH2kIn2CvgpgbKNRK06WphpUD4R9hkaUSsyarys71N9zdqdm5rn
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Syncs the DT from Linux v6.8-rc1.

Remove udmap overrides and handle location change of chipid node.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am68-sk-base-board.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/k3-am68-sk-base-board.dts b/arch/arm/dts/k3-am68-sk-base-board.dts
index 1e1a82f9d2b8..d0cfdeac21fb 100644
--- a/arch/arm/dts/k3-am68-sk-base-board.dts
+++ b/arch/arm/dts/k3-am68-sk-base-board.dts
@@ -31,6 +31,7 @@
 		can1 = &mcu_mcan1;
 		can2 = &main_mcan6;
 		can3 = &main_mcan7;
+		ethernet0 = &cpsw_port1;
 	};
 
 	vusb_main: regulator-vusb-main5v0 {

-- 
2.43.0

