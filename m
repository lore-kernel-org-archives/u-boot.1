Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D845C41513
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 09:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83A9E88477;
	Thu,  9 May 2024 11:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f+y7OqjH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DEA68847B; Thu,  9 May 2024 11:53:32 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 497F288470
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 11:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4499rPWO031277;
 Thu, 9 May 2024 04:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715248405;
 bh=6M47DW2/dJs/cQ9m8E/lypYhY2PR0vNYYI4ySe3JHeQ=;
 h=From:Subject:Date:To:CC;
 b=f+y7OqjHuq3gv8ALSXWXW9yHUEgHmKQ1XYIOYM4IUZhK1ZARuUqRIMxVoCrl2TFWM
 j4Zai18avtVouxk1EKYBXB/9sz7yleed3WL8eQhaAhsVRObgEPKvEnOOXXs3sHibHQ
 Q5okZdK7xmM4lwgIkjrcbSGA/zM/tlnPe3TtaT/U=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4499rP5n055215
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 04:53:25 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 04:53:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 04:53:24 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4499rKt1075143;
 Thu, 9 May 2024 04:53:21 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v2 0/6] Enable OF_UPSTREAM for J721s2 and AM68
Date: Thu, 9 May 2024 15:23:14 +0530
Message-ID: <20240509-b4-upstream-j721s2-of-upstream-v2-0-149563cd4901@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAqdPGYC/4WNQQ6CMBAAv0L27Jp2qYCe/IfhgLCVNYGSFomG9
 O9WEuPR48xhZoXAXjjAKVvB8yJB3JiAdhm0fTPeGKVLDKTIqIMq8GrwMYXZczPgvSQdCJ39qby
 lylpNXVEYSJHJs5XnNrjUiXsJs/Ov7bfoj/2mq3/pRaNC7tQxz3VJRqvzLPvWDVDHGN85PgqRy
 QAAAA==
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715248400; l=2571;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=12r+Y0XImVldgis8MO+uHT6xWW5FeEXh5n7yYVl3MP8=;
 b=HqyAUXRiGKe5RMfoPWpswI1DJMPU2BPsGvsuaQ/I55gwJHVESot5PwftUO2OjMTMaCgB4zavI
 3dfOxIXKPpVC46Vl/DX1XToYjceWIPtGBVFMGcFic/JZLQSIM7Eeylg
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

Series splits AM68 and J721s2 support along with enabling OF_UPSTREAM
and adding stdboot support for both the platforms.

Boot logs: https://gist.github.com/manorit2001/6c669e4273933bc46c3b28a631a96ae3

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v2:
- Improve the commit message (Neha)
- Re-order the patches to not break bisectability
- Link to v1: https://lore.kernel.org/r/20240508-b4-upstream-j721s2-of-upstream-v1-0-ed0933172410@ti.com

---
Manorit Chawdhry (4):
      arch: arm: dts: k3-am68-sk-r5: Sync with J721s2 R5 file
      arch: arm: dts: k3-j721s2-r5: Introduce k3-j721s2-r5.dtsi
      configs: am68_sk: Move to separate defconfig for AM68 SK board
      arm: dts: k3-j721s2|am68: Migrate to OF_UPSTREAM

Neha Malcom Francis (2):
      board: ti: j721s2: j721s2.env: Add explicit boot_targets
      configs: j721s2_evm_a72_defconfig: Switch to bootstd

 arch/arm/dts/Makefile                              |    4 +-
 arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi     |   41 +-
 arch/arm/dts/k3-am68-sk-base-board.dts             |  611 -------
 arch/arm/dts/k3-am68-sk-r5-base-board.dts          |   75 +-
 arch/arm/dts/k3-am68-sk-som.dtsi                   |  259 ---
 arch/arm/dts/k3-j721s2-binman.dtsi                 |   91 +-
 .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    |   18 +-
 arch/arm/dts/k3-j721s2-common-proc-board.dts       |  504 -----
 arch/arm/dts/k3-j721s2-main.dtsi                   | 1928 --------------------
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi             |  738 --------
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts    |   78 +-
 arch/arm/dts/k3-j721s2-r5.dtsi                     |   81 +
 arch/arm/dts/k3-j721s2-som-p0.dtsi                 |  361 ----
 arch/arm/dts/k3-j721s2-thermal.dtsi                |  101 -
 arch/arm/dts/k3-j721s2.dtsi                        |  175 --
 board/ti/j721s2/MAINTAINERS                        |   11 +-
 board/ti/j721s2/j721s2.env                         |    1 +
 configs/am68_sk_a72_defconfig                      |   10 +
 configs/am68_sk_r5_defconfig                       |   10 +
 configs/j721s2_evm_a72_defconfig                   |   10 +-
 configs/j721s2_evm_r5_defconfig                    |    2 +-
 include/configs/j721s2_evm.h                       |    1 -
 22 files changed, 155 insertions(+), 4955 deletions(-)
---
base-commit: 2f1e76bcfee75b9f99ade63002c05ffaaec86afb
change-id: 20240506-b4-upstream-j721s2-of-upstream-3c28ff12d664

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

