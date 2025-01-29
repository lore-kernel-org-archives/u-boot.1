Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F33C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A474E80885;
	Wed, 29 Jan 2025 11:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBDE481727; Wed, 29 Jan 2025 11:43:51 +0100 (CET)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24DE807E4
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yjf050t5hzsB5;
 Wed, 29 Jan 2025 11:43:49 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Yjf040xbnzBx6; Wed, 29 Jan 2025 11:43:48 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next 0/3] rockchip: px30: enable RNG globally + DT overlay
 support for PX30 Ringneck
Date: Wed, 29 Jan 2025 11:43:31 +0100
Message-Id: <20250129-px30-overlay-v1-0-4729b3fcb4c0@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMGmmcC/x3MTQqAIBBA4avErBvwp4K6SrSwmmogNDTECO+et
 PwW770QyDMFGKoXPEUO7GyBrCtYDmN3Ql6LQQnVCql6vJIW6CL50zwol66ZhdSNIQUluTxtnP7
 dCJbSDVPOH78HrKxkAAAA
X-Change-ID: 20250129-px30-overlay-1c64b0134ae2
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

The RNG device is within the SoC on PX30, so there's no reason to enable
it on a per-board basis, therefore, let's enable it in the PX30 SoC DTSI
and remove the now empty (and therefore useless) U-Boot-specific DTSI
for PX30 EVB.

This adds support for applying device tree overlays on PX30 Ringneck,
for that to work the fdtoverlay_addr_r env variable needs to be set and
the OF_LIBFDT_OVERLAY symbol to be enabled.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      rockchip: px30: enable RNG for all boards
      rockchip: px30: add fdtoverlay_addr_r default value to support FDTO
      rockchip: ringneck-px30: enable DT overlay support

 arch/arm/dts/px30-evb-u-boot.dtsi | 10 ----------
 arch/arm/dts/px30-u-boot.dtsi     |  1 -
 configs/ringneck-px30_defconfig   |  1 +
 include/configs/px30_common.h     |  1 +
 4 files changed, 2 insertions(+), 11 deletions(-)
---
base-commit: a2b489b170f8382f746202c36616eaf2bc38fe86
change-id: 20250129-px30-overlay-1c64b0134ae2

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

