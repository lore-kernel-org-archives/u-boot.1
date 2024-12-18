Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34063E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7587B8021D;
	Wed, 18 Dec 2024 13:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ywOT91UK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47E6880243; Wed, 18 Dec 2024 13:46:06 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C87D80214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 13:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BICjnmS008627;
 Wed, 18 Dec 2024 06:45:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734525949;
 bh=jwgAIjmjoA9XQib+2i9UpAwXbhRoi/1DcJfHPEvc7V4=;
 h=From:To:CC:Subject:Date;
 b=ywOT91UKITYckN+z2ilfTGBrlp2tgHxSOwmhPAjcoKQgnz6zXc55WIfOYxeggCkg+
 dTk4jvMrvMjUF8lggrhrogc7v+UcO7xz0fIruSJLG55FMVpQ8U6DyFbO4DS4llIzzz
 u+z6/RFTl2OWUXueqDNSG7pxp/IHs07baOMakjBg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BICjnMH016293
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2024 06:45:49 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 06:45:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 06:45:47 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BICjgTC003797;
 Wed, 18 Dec 2024 06:45:43 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <lukma@denx.de>,
 <n-francis@ti.com>, <mkorpershoek@baylibre.com>, <afd@ti.com>,
 <glaroque@baylibre.com>, <sjoerd@collabora.com>,
 <martyn.welch@collabora.com>, <rasmus.villemoes@prevas.dk>,
 <caleb.connolly@linaro.org>, <j-humphreys@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/5] Add support for USB DFU boot on AM62Px
Date: Wed, 18 Dec 2024 18:15:30 +0530
Message-ID: <20241218124542.3519447-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
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

This series add support for USB DFU boot on TI's AM62Px SoC which has
two instances of USB Controllers, of which the USB0 instance of USB
which is a DWC3 USB Controller is used for USB DFU Boot:
ROM => tiboot3.bin => tispl.bin => u-boot.img

v1 of this series is at:
https://patchwork.ozlabs.org/project/uboot/cover/20241217131658.2920799-1-s-vadapalli@ti.com/
Changes since v1:
- Dropped the first patch of the v1 series since its equivalent has been
  posted by Jonathan Humphreys <j-humphreys@ti.com> at:
  https://patchwork.ozlabs.org/project/uboot/patch/20241217204835.3312765-1-j-humphreys@ti.com/
- Based on the feedback from Mattijs Korpershoek on the second patch of
  the v1 series, the patches in this series have been updated. More
  details regarding the changes have been described below the tearline
  of the respective patches.
- Collected Reviewed-by tags.

NOTE: I did *not* collect the Tested-by tag since this series has
significant changes when compared to the v1 series. Though I have tested
this series before posting it, I intend to get a Tested-by on this v2
series itself after it gets tested.

Series is based on commit
3b3c7280b82 smbios: address build warning
of the next branch of U-Boot.

NOTE: Series *depends* on:
  https://patchwork.ozlabs.org/project/uboot/patch/20241217204835.3312765-1-j-humphreys@ti.com/
since the corresponding patch has been dropped in this series when
compared with the v1 of this series.

The USB DFU config fragments for AM62x are to be re-used for enabling
USB DFU boot on AM62Px as follows:
R5  => am62px_evm_r5_defconfig + am62x_r5_usbdfu.config
A53 => am62px_evm_a53_defconfig + am62x_a53_usbdfu.config

Series has been tested on AM62P5-SK. Logs validating USB DFU boot on
AM62P5-SK with this series:
https://gist.github.com/Siddharth-Vadapalli-at-TI/d70cff3bfff53ef094d3a775e44f84c7

Since am62px_evm_a53_defconfig has significant changes in this series,
SD Boot has also been validated on AM62P5-SK with the
am62px_evm_a53_defconfig of this series. Logs for the same are at:
https://gist.github.com/Siddharth-Vadapalli-at-TI/971df121c8b69a2b8fb17f1c585ee0f4

Series has also been validated on AM625-SK to ensure that the changes
made to "am62x_r5_usbdfu.config" config fragment being used by AM625-SK
for USB DFU boot do not cause a regression on AM625-SK w.r.t. USB DFU
boot. Logs validating USB DFU Boot on AM625-SK with this series:
https://gist.github.com/Siddharth-Vadapalli-at-TI/627c69150c34171b065204839c410e92

Regards,
Siddharth.

Siddharth Vadapalli (5):
  board: ti: am62px: env: include environment for DFU Boot
  configs: am62x_r5_usbdfu: extend for AM62Px
  configs: am62px_evm_a53_defconfig: enable USB DFU support
  arm: dts: k3-am62p5-sk-u-boot: enable USB0 for USB DFU boot
  doc: board: document support for USB DFU boot on AM62Px SoC

 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 10 +++++++++
 board/ti/am62px/am62px.env            |  5 +++--
 configs/am62px_evm_a53_defconfig      | 24 +--------------------
 configs/am62x_r5_usbdfu.config        |  3 +++
 doc/board/ti/am62px_sk.rst            | 31 +++++++++++++++++++++++++++
 5 files changed, 48 insertions(+), 25 deletions(-)

-- 
2.43.0

