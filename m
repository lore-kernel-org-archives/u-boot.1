Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160CFC87FCA
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 18:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A59582B20;
	Tue, 29 Jul 2025 20:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G9BOXFqj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D9382E52; Tue, 29 Jul 2025 20:37:07 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA7282B07
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 20:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56TIb1CB2606033;
 Tue, 29 Jul 2025 13:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753814221;
 bh=jIr2yNovRPh4k8Z302ToLtj2abNI/MlB9ZO/mBRxk2w=;
 h=From:Subject:Date:To:CC;
 b=G9BOXFqjnWwS6E/zYBfOX8KOMu2Ev6jfFg5+v8+SMHdvGj14nJIQTyUTSE1gcZOna
 FlH9ML3f6Phb2iUoRq3XDStDAXtNhZaIoRH7d97ZGsIrRmOCOaPLoQPna2nU1fQ4/Y
 tAxtwli/5UFT0gvOO2bBa/YkTP5XpgkSpMhaP2rs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56TIb12X1313190
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 29 Jul 2025 13:37:01 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 29
 Jul 2025 13:37:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 29 Jul 2025 13:37:01 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56TIb1E94172145;
 Tue, 29 Jul 2025 13:37:01 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/2] arm: dts: k3-am62a: remove GP security variant for AM62A
Date: Tue, 29 Jul 2025 13:36:55 -0500
Message-ID: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMcUiWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNL3bx8XTOjRN30At1kM0tLA3Pj1CQzk0QloPqCotS0zAqwWdGxtbU
 A4/eMBFsAAAA=
X-Change-ID: 20250729-no-62a-gp-c699073eb64a
To: Tom Rini <trini@konsulko.com>, Garrett Giordano <ggiordano@phytec.com>,
 Wadim Egorov <w.egorov@phytec.de>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=bb@ti.com;
 h=from:subject:message-id; bh=ehL6xIp9lWVU6kzfRR3EOZwZesBudgmNpesJ0cRH4m0=;
 b=owNCWmg5MUFZJlNZcOGjNwAAbX////7tU/f3G8vLe+/K8eb//V7v63/P3dfZ+Kj5vPbek22wA
 RmsDFGmgaABoDQZA0NABoaAZGmjRoAAAAA0MgGQyAD1DIPUbSabSep5IyZkRA0ZDRoMjQaDQMCA
 BiANGgDABMgGmgDRiDJkDRo0NMCMmEMJoMQ0DDIj1NPU9JtEPKGj1DQNNGgAAZNNBoaANAAA00A
 9Q9RoaGQAAB6mIeoaGgeoaNABBKO0p0zuCXCu72IulRkMeXhT8SHdWLFtlIA4EUD5U9polLmkWa
 lIn2/E1rfTsviAJM8Ex30qxOyboVv3UTrAdujEl9EBg45lpe1LKhvJzqXhEiWN4GI14Gq3zejRr
 NAI/6vCZfYqM+bP6Tzpm6fJx8pHgboGp/JBlgjOZ9xMAPDPcCR+u79fWVBj9lBvGwmnGGbQFEIh
 XDlQogrkQptcZZ4UeMSZzMzAxURnC8PKwkGS6Nxks8tEwuA7Vn0Fk4IjPrLIzolefJWvpO6u2Ps
 RehPGiDTWZaXMe6FLsbxkM4rmyRGSeBfrdUn/flxqpTLBnShqBywvwOcFX/i0+pVsmmdcYasYhC
 /vAZCYJE2mMgAA6GDYJ6odUVFhabZzR+BkxQgnERDcY3wOm/i10INj7pv71LpHJRO8lKNgqXah2
 w/xdyRThQkHDhozcA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Hello Everyone,

The AM62Ax was created right when TI was shifting to their high security 
(HS-FS and HS-SE) processes. During this transition a small subset of 
AM62A parts where configured to use the old "GP" security for internal 
and for select groups of partners but never sold for the wider public.

To help simplify the build and to avoid any confusion of which security 
configurations are supported going forward remove the GP builds for the 
AM62A SoCs.

Happy Hacking
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (2):
      arm: dts: k3-am62a-sk: remove GP tiboot3 builds
      arm: dts: k3-am62a-phycore: remove GP tiboot3 builds

 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 182 +-------------------------
 arch/arm/dts/k3-am62a-sk-binman.dtsi          | 181 +------------------------
 doc/board/ti/am62ax_sk.rst                    |   7 +-
 3 files changed, 3 insertions(+), 367 deletions(-)
---
base-commit: 182cb30084516c3085d2ca5dde3f105f7625d774
change-id: 20250729-no-62a-gp-c699073eb64a

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

