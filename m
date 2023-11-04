Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15662C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 02:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2313F87147;
	Sat,  4 Nov 2023 03:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zMBvP2At";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01B5386FE8; Sat,  4 Nov 2023 03:46:27 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE82D870BC
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 03:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A42jD3w081646;
 Fri, 3 Nov 2023 21:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699065913;
 bh=Z4rQ/bO2TRzb+uGDIdlPEnNKt1qawFgXvUEd2eILJ3M=;
 h=From:To:CC:Subject:Date;
 b=zMBvP2AtuZ8H59IUNI+gzOxDecKcQ5sJ+y7bzQ9CqJDkTQqU882aCkqToQc4TZ8Pd
 IFnI6T+kpZBjBPvYglPzCXrTmY1Tid6ZSpRiNravGpTUgbp9V90pQDWnjuVipSzDoP
 N3phaBBd+W7fACXNARVwU+wi5DGHMmeExwXRRmUA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A42jDN6117863
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 Nov 2023 21:45:13 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 Nov 2023 21:45:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 Nov 2023 21:45:12 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A42jC9W010123;
 Fri, 3 Nov 2023 21:45:12 -0500
From: Nishanth Menon <nm@ti.com>
To: <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Francesco Dolcini <francesco@dolcini.it>, Andrew Davis
 <afd@ti.com>, <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/2] arm: mach-k3: Move TI keys out of board folder
Date: Fri, 3 Nov 2023 21:45:09 -0500
Message-ID: <20231104024511.3597476-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Hi,

V2 of the series broadening the scope a bit more here.

Changes in V2:
* Drop the override from verdin binman files since the default depends
  on k3-binman.dtsi
* Move the TI dummy keys out to arch as well (new patch)

V1: https://lore.kernel.org/all/20231103224453.3264313-1-nm@ti.com/

Nishanth Menon (2):
  arm: mach-k3: Move K3 degenerate keys out of board folder
  arm: mach-k3: Move TI dummy keys out of board folder

 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi         | 8 --------
 arch/arm/dts/k3-binman.dtsi                               | 4 ++--
 {board/ti => arch/arm/mach-k3}/keys/custMpk.crt           | 0
 {board/ti => arch/arm/mach-k3}/keys/custMpk.key           | 0
 {board/ti => arch/arm/mach-k3}/keys/custMpk.pem           | 0
 {board/ti => arch/arm/mach-k3}/keys/ti-degenerate-key.pem | 0
 6 files changed, 2 insertions(+), 10 deletions(-)
 rename {board/ti => arch/arm/mach-k3}/keys/custMpk.crt (100%)
 rename {board/ti => arch/arm/mach-k3}/keys/custMpk.key (100%)
 rename {board/ti => arch/arm/mach-k3}/keys/custMpk.pem (100%)
 rename {board/ti => arch/arm/mach-k3}/keys/ti-degenerate-key.pem (100%)

-- 
2.40.0

