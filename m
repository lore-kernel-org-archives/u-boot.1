Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2415C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 10:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CFE780F12;
	Wed, 26 Feb 2025 11:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qOpI43/0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E13AF80F3F; Wed, 26 Feb 2025 11:35:12 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4910080805
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 11:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QAZ7nN2045859
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 04:35:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740566107;
 bh=XOTMFc0m2CEJajkPrnyElLY7lbjL0KsGgKoGj7vmc6c=;
 h=From:To:CC:Subject:Date;
 b=qOpI43/0BZXF69M9P9PmiHcS8zhT2Jegp5acJlrSPzscnnNv7xpeP6/oqHcIbV/K2
 fSp0DMLSSEmRj1WfmWv1r8vQ6fhRpaarOmz1FgI8yc9bYTTdiIp8IwdBPfujRl+UA2
 Iu6NbbQzVL2Au/UqB5E2sjH360wtGkxeJAQoH75E=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51QAZ7pi084088
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Feb 2025 04:35:07 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 04:35:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 04:35:07 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QAZ5q9051536; 
 Wed, 26 Feb 2025 04:35:05 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <j-humphreys@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH 0/2] Enable USB MSC Boot for AM62, AM62A and AM62P
Date: Wed, 26 Feb 2025 16:05:02 +0530
Message-ID: <20250226103504.1841697-1-s-vadapalli@ti.com>
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

Hello,

This series adds config fragment for enabling USB MSC boot and USB
Storage devices which are applicable to AM62, AM62A and AM62P SoCs.

Series is based on commit
8dd7186ca7 Merge patch series "Remove "saveenv" functionality from am57xx evms"
of the next branch of U-Boot.

Series has been tested on AM62A7-SK, AM625-SK and AM62P5-SK for USB MSC
boot where the bootloaders were generated in the following manner:
1. AM62A7-SK (AM62A SoC):
- tiboot3.bin
	=> am62ax_evm_r5_defconfig + am62x_r5_usbmsc.config
- tispl.bin and u-boot.img
	=> am62ax_evm_a53_defconfig + am62x_a53_usbmsc.config
2. AM625-SK (AM62 SoC):
- tiboot3.bin
	=> am62x_evm_r5_defconfig + am62x_r5_usbmsc.config
- tispl.bin and u-boot.img
	=> am62x_evm_a53_defconfig + am62x_a53_usbmsc.config
3. AM62P5-SK (AM62P SoC):
- tiboot3.bin
	=> am62px_evm_r5_defconfig + am62x_r5_usbmsc.config
- tispl.bin and u-boot.img
	=> am62px_evm_a53_defconfig + am62x_a53_usbmsc.config

The images were flashed to a USB Flash Drive and were connected to the
Type-C interface on each of the boards which supports USB MSC Boot.

Logs:
1. AM62A7-SK:
https://gist.github.com/Siddharth-Vadapalli-at-TI/d1a6149d54d352eb996929fa6db58934
2. AM625-SK:
https://gist.github.com/Siddharth-Vadapalli-at-TI/594938bd7a0b059e604526142015266c
3. AM62P5-SK:
https://gist.github.com/Siddharth-Vadapalli-at-TI/47f5ed39818dc67d6ec11fa4066e4586

The following device-tree changes were made across all of the boards:
https://gist.github.com/Siddharth-Vadapalli-at-TI/2afb913838c1d4005bc059910c09ab4b

Regards,
Siddharth.

Siddharth Vadapalli (2):
  configs: am62x_r5: introduce fragment for USB MSC boot
  configs: am62x_a53: introduce fragment for USB MSC boot

 configs/am62x_a53_usbmsc.config | 20 ++++++++++++++++++++
 configs/am62x_r5_usbmsc.config  | 22 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 configs/am62x_a53_usbmsc.config
 create mode 100644 configs/am62x_r5_usbmsc.config

-- 
2.34.1

