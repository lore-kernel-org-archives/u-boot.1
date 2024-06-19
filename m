Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10A7C27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 15:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C49B8836D;
	Wed, 19 Jun 2024 17:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F10B883334; Wed, 19 Jun 2024 17:45:06 +0200 (CEST)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [185.125.25.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AECA8836D
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 17:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W47H40sgcz1FL;
 Wed, 19 Jun 2024 17:45:04 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W47H34ZkDzJ9s; Wed, 19 Jun 2024 17:45:03 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 19 Jun 2024 17:44:56 +0200
Subject: [PATCH next v2] rockchip: puma-rk3399: increase Ethernet PHY
 timeout to 30s
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-puma-eth-timeout-v2-1-a01c443d4445@cherry.de>
X-B4-Tracking: v=1; b=H4sIAPf8cmYC/3WNOw6DMBBEr4K2zkasMSGkyj0iCrCXeAs+sg0CI
 e4eiz7lm9G8OSCwFw7wyg7wvEqQaUygbhkY145fRrGJQeVK5w+qcV6GFjk6jDLwtETU1HFtlC7
 YVpBms+detkv5gZG3CE1KnYQ4+f36Wenq/itXQkLblYYqKov+qd7Gsff73TI053n+ALrTeMa2A
 AAA
To: Klaus Goger <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

From: Quentin Schulz <quentin.schulz@cherry.de>

On Puma v2.1 with a KSZ9031, the Ethernet PHY often doesn't detect the
link in the 4-second default timeout.

After some boot-loop test for about a thousand boots, 70% were below
10s, 90% below 15s and 100% below 30s. Let's play it safe and make it
30s so that hopefully all links that should be detected are.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- rebase on next
- use Kconfig symbol instead of constant in include/configs/
- Link to v1: https://lore.kernel.org/r/20240619-puma-eth-timeout-v1-1-db5c17153f82@cherry.de
---
 configs/puma-rk3399_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 5319239f989..4293cf0ae44 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -69,6 +69,7 @@ CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ANEG_TIMEOUT=30000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_ETH_DESIGNWARE=y

---
base-commit: 01a5d7547ed3a51a8ac5837c31a150f85bc475f8
change-id: 20240619-puma-eth-timeout-41be9c243ed7

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

