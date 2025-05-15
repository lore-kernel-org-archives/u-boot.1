Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2118AC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 11:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8604082B39;
	Thu, 15 May 2025 13:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wnbSNwj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAE2B82B54; Thu, 15 May 2025 13:38:50 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B7DE82B20
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54FBchpO3433352
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 06:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747309123;
 bh=qa1wUxktE7HIKqV2MZc8PGhf/i8weTVjBowD3tcrYoE=;
 h=From:Subject:Date:To:CC;
 b=wnbSNwj0kVDwvfu4Zy9z/YiNgA/HD2LX9EiNa6+545baYpnVMSXvBZ9dCcNq93P03
 48QVorIx5z9VkiyErkIU3vRBh3c4koAkDM2FsFSMdUjobBTpgVTi+L6nws6CFCwfQf
 jf9J8ZdY+CtyMaNe/uZHZT8cNPcPQ5nJANFzYb14=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54FBchvf035778
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 May 2025 06:38:43 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 May 2025 06:38:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 May 2025 06:38:42 -0500
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54FBccg6059730;
 Thu, 15 May 2025 06:38:39 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH 0/4] Remove clocks from R5 dtsi for missed boards.
Date: Thu, 15 May 2025 17:08:33 +0530
Message-ID: <20250515-b4-upstream-k3-pll-miss-v1-0-e38b89f027b8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADnSJWgC/x3MQQqDMBBA0avIrB3IGEO1VxEXRsc6VG3IaCkE7
 97g8i3+T6AchRWeRYLIX1H57BlUFjAuw/5ilCkbKlM548ihr/EMekQeNnxbDOuKm6jiaKmhh6f
 Wcwu5DpFn+d3nrr+uPyMzgaZpAAAA
X-Change-ID: 20250515-b4-upstream-k3-pll-miss-c31817b19be9
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, Francesco
 Dolcini <francesco.dolcini@toradex.com>, Garrett Giordano
 <ggiordano@phytec.com>
CC: <u-boot@lists.denx.de>, Vishal Mahaveer <vishalm@ti.com>, Chandru
 Dhavamani <chandru@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747309118; l=1402;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=wjC5CMONciLURHoti15eqRZmaMIfjrjXpM+aTyvAkkA=;
 b=R0pUozYEIELqK+QGi31kyJ8HROGPGEWDaSqMCPOXXPUHNJ3VZ0qHTxj66hJaP3/8yYjxiOFfB
 mlSAol/OSXnCOwZGQoVBl45JA1KWHkxtKe02pslFfAm6UBo/uQiIDK2
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Fix some of the boards that could be affected by the change done in [0].

I can't test the changes. Please give Tested-by.

[0]: https://lore.kernel.org/u-boot/20241121-b4-upstream-pll-fix-v1-0-904f618897a7@ti.com/T/#mecb70b415a364fdf322a94241438db7b5607e92b

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Manorit Chawdhry (4):
      arm: dts: k3-am625-beagleplay-r5*: Remove clocks from main_timer0
      arm: dts: k3-am625-phycore-r5*: Remove clocks from main_timer0
      arm: dts: k3-am625-verdin-r5*: Remove clocks from main_timer0
      arm: dts: k3-am62a7-phycore-r5*: Remove clocks from main_timer0

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi         | 8 --------
 arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi  | 5 -----
 arch/arm/dts/k3-am625-r5-beagleplay.dts              | 8 ++++++++
 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts         | 8 ++++++++
 arch/arm/dts/k3-am625-verdin-r5.dts                  | 8 ++++++++
 arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi    | 8 --------
 arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi | 5 -----
 arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts        | 9 +++++++++
 8 files changed, 33 insertions(+), 26 deletions(-)
---
base-commit: 4c26de2eea6bcf5f27b13da0372d27d767cd38e3
change-id: 20250515-b4-upstream-k3-pll-miss-c31817b19be9

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

