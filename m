Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECABC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B99B889A8;
	Fri, 14 Jun 2024 13:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A710E889BB; Fri, 14 Jun 2024 13:05:08 +0200 (CEST)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::190b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 489A7889A1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W0xJK67SWzYW6;
 Fri, 14 Jun 2024 13:05:05 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W0xJK1C5BzQ9c; Fri, 14 Jun 2024 13:05:04 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next 0/4] rockchip: imply ARMV8_CRYPTO on px30 +
 px30-ringneck/rk3399-puma defconfig changes
Date: Fri, 14 Jun 2024 13:04:52 +0200
Message-Id: <20240614-ringneck-no-gadget-v1-0-d3bc6e5088de@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANQjbGYC/x3MMQqAMAxA0auUzAZSLVK8ijgUjTUIUdoignh3i
 +Mb/n8gcxLOMJgHEl+S5dAK2xiYt6CRUZZqaKl11NsOk2hUnnfUA2NYIhf0zjsicl1PHmp4Jl7
 l/qcjKN8Fpvf9APRiOspqAAAA
To: Klaus Goger <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
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

This implies ARMV8_CRYPTO + CONFIG_ARMV8_SET_SMPEN for cache
coherency on PX30.

Disable USB gadget support on PX30 as I've never been able to make it
work in either Linux upstream or Rockchip's downstream 5.10, and while
it exposes a device when executing the ums command in U-Boot, it never
works. So disable for now to not mislead users.

Additionally, add full fit support in SPL for PX30 Ringneck.

Finally, add button support for Puma since its Haikou devkit exposes 4
over GPIO.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (4):
      rockchip: ringneck-px30: disable broken USB gadget
      rockchip: ringneck-px30: enable FIT verification in SPL
      rockchip: px30: imply ARMV8_CRYPTO
      rockchip: puma-rk3399: add button support

 arch/arm/mach-rockchip/Kconfig  |  2 ++
 configs/puma-rk3399_defconfig   |  2 ++
 configs/ringneck-px30_defconfig | 10 ++++------
 3 files changed, 8 insertions(+), 6 deletions(-)
---
base-commit: ae4aaa44977cbe522e9f38f2ac2ac07a784bf867
change-id: 20240613-ringneck-no-gadget-848400043608

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

