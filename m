Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82FBC021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 08:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 228DD810ED;
	Sat,  1 Mar 2025 09:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="T3NnHt81";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A59C810F6; Sat,  1 Mar 2025 09:00:58 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0998D80FE1
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 09:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52180q1s2870276
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 1 Mar 2025 02:00:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740816052;
 bh=iOWd1Bi2BnafV0Gix6+ZrWS2PbTcc7NFZdVqLc9/Mw0=;
 h=From:To:CC:Subject:Date;
 b=T3NnHt81GCM2YhfgQrV9dt4sI4gizfozD+uP/Am9dYjWBdC9ePts4kxAP3szv+jCN
 6GcQaOdUYDEIWNE1tzuy4kNvezlbAS60O3BVA5GWC2jmzWo0tc7CUl3uJifknCBXh0
 vAogyl6VqT+Je95xj1JO2cXeIBkQ+sMjU7oJl4e4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52180q0j102442
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 1 Mar 2025 02:00:52 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Mar 2025 02:00:52 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Mar 2025 02:00:52 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52180n7W117507; 
 Sat, 1 Mar 2025 02:00:50 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <j-humphreys@ti.com>, <javier.tia@linaro.org>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] Enable USB MSC Boot for AM62, AM62A and AM62P
Date: Sat, 1 Mar 2025 13:30:47 +0530
Message-ID: <20250301080049.965438-1-s-vadapalli@ti.com>
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
962217d218c Merge patch series "boards: siemens: iot2050: SM variant, sysinfo support, fixes & cleanups"
of the next branch of U-Boot.

v1 of this series is at:
https://patchwork.ozlabs.org/project/uboot/cover/20250226103504.1841697-1-s-vadapalli@ti.com/
Changes since v1:
- Updated the patch for am62x_r5_usbmsc.config by enabling
  CONFIG_USB_STORAGE based on the feedback provided by
  Jonathan Humphreys <j-humphreys@ti.com>
  at:
  https://patchwork.ozlabs.org/project/uboot/patch/20250226103504.1841697-2-s-vadapalli@ti.com/#3470589
- Since enabling CONFIG_USB_STORAGE led to exceeding the size limit for
  tiboot3.bin, I disabled CONFIG_SPL_RAM_DEVICE in am62x_r5_usbmsc.config.

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

Logs corresponding to this series:
1. AM62A7-SK:
https://gist.github.com/Siddharth-Vadapalli-at-TI/3518cba3edc57bf52d06a7df932928ca
2. AM625-SK:
https://gist.github.com/Siddharth-Vadapalli-at-TI/098568be7b482436d27fdc8adae15ce4
3. AM62P5-SK:
https://gist.github.com/Siddharth-Vadapalli-at-TI/50e29073033668e7d904a785bfbc9c0b

The following device-tree changes were made across all of the boards:
https://gist.github.com/Siddharth-Vadapalli-at-TI/2afb913838c1d4005bc059910c09ab4b

Regards,
Siddharth.

Siddharth Vadapalli (2):
  configs: am62x_r5: introduce fragment for USB MSC boot
  configs: am62x_a53: introduce fragment for USB MSC boot

 configs/am62x_a53_usbmsc.config | 20 ++++++++++++++++++++
 configs/am62x_r5_usbmsc.config  | 24 ++++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 configs/am62x_a53_usbmsc.config
 create mode 100644 configs/am62x_r5_usbmsc.config

-- 
2.34.1

