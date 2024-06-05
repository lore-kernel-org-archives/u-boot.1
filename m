Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8416BC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 15:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB1E1882C4;
	Wed,  5 Jun 2024 17:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D473882E2; Wed,  5 Jun 2024 17:56:33 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8D987A09
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 17:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VvXBk6BNBz13Lr;
 Wed,  5 Jun 2024 17:56:30 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VvXBh55ysz9lg; Wed,  5 Jun 2024 17:56:28 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next v2 0/6] rockchip: display PMIC variant properly + misc
 fixes for Theobroma boards
Date: Wed, 05 Jun 2024 17:56:05 +0200
Message-Id: <20240605-misc-tsd-v2-0-12479432c90f@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJWKYGYC/2WMQQ7CIBBFr9LM2jGAEKsr72G6KDDKLGwNENKm4
 e4Sti7f/y/vgESRKcF9OCBS4cTr0kCdBnBhXt6E7BuDEkoLozR+ODnMySOJ0RjphHTjDE3/Rnr
 x1lNPWGjLMLU1cMpr3Hu/yP79p4pEgfZqPcmL1vZGDxcoxv3sCaZa6w8ZKq5RpgAAAA==
To: Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
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

This fixes how the Rockchip PMIC variant is shown for all but RK808 by
stripping the LSB.

Also fix the size of the environment on Jaguar to match the default
(smaller) size.

Fix SPL_PAD_TO on Ringneck.

Remove duplicated default value of ENV_OFFSET in puma defconfig.

Remove unnecessary override of the fit offset in u-boot dtsi for Puma
and Ringneck.

Fix TPL_MAX_SIZE for Ringneck to match the (valid) default value for
PX30 boards.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- add patch for fixing TPL_MAX_SIZE on PX30 Ringneck
- print show_variant when PMIC variant not found
- use bitfield_extract_by_mask instead of using hardcoded shift operator
- Link to v1: https://lore.kernel.org/r/20240524-misc-tsd-v1-0-b7bde1344b9e@cherry.de

---
Quentin Schulz (6):
      rockchip: jaguar-rk3588: use default env size for Rockchip on MMC
      rockchip: rk3399-puma: remove default value from defconfig
      rockchip: rk3399-puma: remove unnecessary simple-bin:fit:offset override
      rockchip: px30-ringneck: Update SPL_PAD_TO Kconfig option
      power: rk8xx: properly print all supported PMICs name
      rockchip: ringneck-px30: fix TPL_MAX_SIZE

 arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi | 8 --------
 arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi   | 6 ------
 configs/jaguar-rk3588_defconfig               | 1 -
 configs/puma-rk3399_defconfig                 | 1 -
 configs/ringneck-px30_defconfig               | 3 +--
 drivers/power/pmic/rk8xx.c                    | 5 ++---
 6 files changed, 3 insertions(+), 21 deletions(-)
---
base-commit: 8887ffb625f65475fd6619f8b05fb7a5a12b016b
change-id: 20240524-misc-tsd-e08551c01c8a

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

