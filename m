Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C35C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 12:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E08EA885D7;
	Thu,  4 Jul 2024 14:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2265886A3; Thu,  4 Jul 2024 14:53:55 +0200 (CEST)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [185.125.25.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A083588363
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 14:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WFGmd2CYjzTZ7;
 Thu,  4 Jul 2024 14:53:53 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4WFGmb4mpczlcq; Thu,  4 Jul 2024 14:53:51 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/3] rockchip: enable PCIe/NVMe support for Theobroma
 RK3588 devices
Date: Thu, 04 Jul 2024 14:53:30 +0200
Message-Id: <20240704-tsd-rk3588-nvme-v1-0-fb9e8dde9570@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEqbhmYC/x3MQQqAIBBA0avErBswNbKuEi3MphoiC40IpLsnL
 d/i/wSRAlOErkgQ6ObIh8+oygLcav1CyFM2SCG1aITGK04YNlUbg/7eCa2tlHJSu7ElyNUZaOb
 nP/bD+3698U7CYQAAAA==
To: Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
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

Jaguar has an M.2 M-KEY slot for NVMes and Tiger exposes the signals to
the Q7 connector which is then routed on the Haikou devkit's `PCI
Express` connector. With the help of a PCIe to NVMe adapter, NVMes can
be used on Tiger Haikou as well.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Heiko Stuebner (1):
      arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar

Quentin Schulz (2):
      rockchip: jaguar-rk3588: add PCIe M.2 M-KEY NVMe support
      rockchip: tiger-rk3588: add PCIe support

 configs/jaguar-rk3588_defconfig                   |  5 ++
 configs/tiger-rk3588_defconfig                    |  4 ++
 dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts | 59 +++++++++++++++++++++++
 3 files changed, 68 insertions(+)
---
base-commit: 0f073e022ddc5070e5df1d053e4bdc1874fbcc0f
change-id: 20240704-tsd-rk3588-nvme-aa133c24cb9e

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

