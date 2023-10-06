Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A66AE92FE1
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 04:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9357E86D17;
	Fri,  6 Oct 2023 06:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pPbdeyQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 407CB86D17; Fri,  6 Oct 2023 06:46:10 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D4958653E
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 06:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3964k3HJ125668;
 Thu, 5 Oct 2023 23:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696567563;
 bh=3yEAHkdP1/yP81h9AxoYpsfdSqm3vJNv1gtC5n02bfI=;
 h=From:Subject:Date:To:CC;
 b=pPbdeyQ+VFBRSt1RD61I+aqVPEfIJB5bGNXJzVihTYxuN1rnCZ5F6MIynZUYCnyGq
 heYLlIs4e3Cypq82FCuzVxvTnDkH3dQtFMgjTxFGPul124vQKmJ5Lf6g+yv2YffqCP
 RfuqPkjjSqiHnV/vDTjI78AdA9Ss4RTwF237fZDg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3964k3Ps005809
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 23:46:03 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 23:46:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 23:46:03 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3964jxUg030710;
 Thu, 5 Oct 2023 23:46:00 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v7 0/7] J721S2 DTS Sync from v6.6-rc1 to u-boot
Date: Fri, 6 Oct 2023 10:15:54 +0530
Message-ID: <20231006-b4-upstream-j721s2-r5-pinmux-v7-0-5d31f765dd2c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAKRH2UC/5XPy26EMAwF0F8ZZd1UsfMAZtX/qLpIgimpxEMJg
 6hG/HsDi05ZTVneWDm+vrNEMVBi18udRZpDCkOfQ/FyYb61/SfxUOfMUKAUJRjuFL+NaYpkO/5
 VICTkUfMx9N1t4ai98rUBh7pkmXA2EXfR9r7dkN+PPS3TNh8jNWHZ179/5NyGNA3xe28zw/b6z
 8UzcMEbpVWpNBZG2LcpvPqhY5s64xkJs2R1AwocKeH8QZJnJLl1qo0RWAFqaQ6SOiOpLNUeQDn
 ypOviIOmHVEH1RNL7dao2RGgkiINk/kgITySTJW8rIysP1ptHp3VdfwBkPJr9VwIAAA==
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Nikhil M Jain <n-jain1@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696567559; l=2870;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=fnW2hzqOBfa2R7QbXzYBf8YJRQkgrHPI2lHgLsBX8nA=;
 b=HetBQjFCSHlEbyT+1mJwjsJ9czbKDYrCg09GEjVyEeiSjvfJRuLoRcvabl27gZL80fmkciWpd
 FjNelyMf7tqAz/MQV3n90BJD+/56NOjuRebPDipP3kyrIlEvGECKzqe
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

The sync tries to ensure that U-boot remains functional with the updated
Linux DTS and all the fixes from Linux move to U-boot during the sync.

The series tries to sync from Linux v6.6-rc1 along with addition of
the documentation for J721S2 that had been previously missing.

DMA fixes [0] are currently being upstreamed to Linux. 

Test Logs are included in [1]

[0]: https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
[1]: https://gist.github.com/manorit2001/dbad09fd00e8b7c3872e85874c8e648c

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v7:
- Convert bootph-pre-ram to bootph-all in -u-boot.dtsi 
  (Refer to https://lore.kernel.org/all/CAPnjgZ3MgWX8T0A0SofphEr_Xd77pE3hte9DNye1RuBVeB9N8Q@mail.gmail.com/)
- Link to v6: https://lore.kernel.org/r/20230921-b4-upstream-j721s2-r5-pinmux-v6-0-ca9639c1ac67@ti.com

---
Manorit Chawdhry (6):
      Revert "arm: dts: k3-j7*: ddr: Update to 0.10 version of DDR config tool"
      arm: mach-k3: j721s2: Add mcu_timer0 id to the dev list
      arm: dts: k3-j721s2: Sync from Linux tag v6.6-rc1
      arm: dts: k3-am68: Sync from Linux tag v6.6-rc1
      docs: board: ti: Add j721s2_evm documentation
      board: ti: j721s2: MAINTAINERS: Update the MAINTAINERS File.

Udit Kumar (1):
      configs: j721s2_evm_r5_defconfig: Increase malloc pool size in DRAM

 arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi     | 119 ++--
 arch/arm/dts/k3-am68-sk-base-board.dts             | 524 +++++++++-----
 arch/arm/dts/k3-am68-sk-r5-base-board.dts          | 151 +---
 arch/arm/dts/k3-am68-sk-som.dtsi                   | 112 +--
 arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi        |  98 +--
 .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    | 112 ++-
 arch/arm/dts/k3-j721s2-common-proc-board.dts       | 376 ++++++----
 arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi       | 464 ++++++------
 arch/arm/dts/k3-j721s2-main.dtsi                   | 777 ++++++++++++++++++++-
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi             | 374 +++++++++-
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts    | 158 +----
 arch/arm/dts/k3-j721s2-som-p0.dtsi                 | 172 ++---
 arch/arm/dts/k3-j721s2-thermal.dtsi                | 101 +++
 arch/arm/dts/k3-j721s2.dtsi                        |  12 +-
 arch/arm/mach-k3/j721s2/dev-data.c                 |   1 +
 board/ti/j721s2/MAINTAINERS                        |  11 +-
 configs/j721s2_evm_r5_defconfig                    |   1 +
 doc/board/ti/j721s2_evm.rst                        | 341 +++++++++
 doc/board/ti/k3.rst                                |   1 +
 19 files changed, 2700 insertions(+), 1205 deletions(-)
---
base-commit: e29b932aa07fa0226d325b35d96cd4eea0370129
change-id: 20230816-b4-upstream-j721s2-r5-pinmux-25c4cd61b258

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

