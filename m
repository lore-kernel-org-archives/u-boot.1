Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E4DC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 13:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AE7B884DC;
	Tue, 28 May 2024 15:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k8jzP99X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8920B88511; Tue, 28 May 2024 15:13:25 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A18188349
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 15:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SDD6CY089570;
 Tue, 28 May 2024 08:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716901986;
 bh=kiauB+2NMETKdA9DYKC0dAS7euJ747R0P1FBVuLWw1A=;
 h=From:Subject:Date:To:CC;
 b=k8jzP99XqbcXH6kiD9heiWAJZSQyj+pwASM2dx4J3ZNIE4ZzNHp8k8+4qqtTdqyjF
 GdaEyk0G/eyd0y6Ys3721YO57k4aCv4URWzJK3i3YDr98sVYTmAK3wWrHGVbci7PUz
 YQHLJXICzRjFYMEoDIk8WwntSz8QPu3z8wtRnpaU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SDD6hL052232
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 08:13:06 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 08:13:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 08:13:06 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SDD25c099882;
 Tue, 28 May 2024 08:13:03 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v2 0/4] Enable OSPI boot for j721s2
Date: Tue, 28 May 2024 18:42:54 +0530
Message-ID: <20240528-b4-upstream-j721s2-ospi-support-v2-0-b2e372ebcdd7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbYVWYC/4WNQQ6CMBBFr0K6dkw7Vg2uvIdhUeggYwJtOoVoC
 He36gFcvp/891YllJhEXapVJVpYOEwFcFepbnDTnYB9YYUarT4gQmthjpITuREeZzSCECQyyBx
 jSBm8PfreuRpPvlPFEhP1/PwWbk3hgSWH9PoGF/NZf26rzV/3YkADarJOl4tv62vmfRdG1Wzb9
 gbOqz3rywAAAA==
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, "Tom
 Rini" <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>, Apurva Nandan <a-nandan@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Pratyush Yadav <p.yadav@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716901982; l=1240;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=SS5+6rg2wr9gPYN2wQohZjjfGUHEk2QOGDUnr052E4M=;
 b=6ApUkBHKF9fQSjeUdijRTmsdD7to6/i9HOz8Zj7dWudGSuQZleQ8VC0+HHWllKYraNMUYPaVr
 COCHs6Um0wXAllQbjsjuZDYEqkZ82cU75hXnUlAjcmmT4JwoS9yhyIu
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

The series enables ospi boot for j721s2.

Test logs: https://gist.github.com/manorit2001/6bb91885c608e3a8cb0267ab2c614781

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v2:
- Rebase on top of -next
- Link to v1: https://lore.kernel.org/r/20240401-b4-upstream-j721s2-ospi-support-v1-0-20e4a0024db9@ti.com

---
Manorit Chawdhry (3):
      arch: arm: dts: k3-j721s2-r5: Override ospi and fss for 32-bit mode
      arch: arm: dts: k3-j721s2-*-u-boot.dtsi: Enable the ospi0 node
      configs: j721s2_evm_*_defconfig: Enable OSPI configs

Pratyush Yadav (1):
      mtd: spi-nor-core: Do not start or end writes at odd address in DTR mode

 .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    |  4 +-
 arch/arm/dts/k3-j721s2-r5.dtsi                     | 13 +++++
 configs/j721s2_evm_a72_defconfig                   |  3 ++
 configs/j721s2_evm_r5_defconfig                    |  3 ++
 drivers/mtd/spi/spi-nor-core.c                     | 59 ++++++++++++++++++++--
 5 files changed, 77 insertions(+), 5 deletions(-)
---
base-commit: 377e91c162ab09ec20f96f966f380cb55c590edd
change-id: 20240322-b4-upstream-j721s2-ospi-support-d45dfaa926dc

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

