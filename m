Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813BBC83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 09:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DE383623;
	Thu, 31 Jul 2025 11:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=voidland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=voidland.org header.i=@voidland.org header.b="xHqbnQ2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D51AF83440; Thu, 31 Jul 2025 10:30:04 +0200 (CEST)
Received: from mspa.bulsat.com (mspa.bulsat.com [46.40.72.5])
 by phobos.denx.de (Postfix) with ESMTP id C25EB833ED
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 10:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=voidland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=gbr@voidland.org
Received: from localhost (localhost [127.0.0.1])
 by mspa.bulsat.com (Postfix) with ESMTP id 6437D8002B4;
 Thu, 31 Jul 2025 11:30:01 +0300 (EEST)
Received: from mspa.bulsat.com ([127.0.0.1])
 by localhost (mspa.bulsat.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ylJdgb8ow-4R; Thu, 31 Jul 2025 11:30:00 +0300 (EEST)
Received: from olinuxino.voidland.org (unknown [46.40.126.124])
 by mspa.bulsat.com (Postfix) with ESMTP id 51345800112;
 Thu, 31 Jul 2025 11:30:00 +0300 (EEST)
Authentication-Results: olinuxino.voidland.org; dkim=pass (1024-bit key;
 unprotected) header.d=voidland.org header.i=@voidland.org header.a=rsa-sha256
 header.s=mail header.b=xHqbnQ2P; dkim-atps=neutral
Received: from es.voidland.org (es.voidland.org [192.168.255.1])
 by olinuxino.voidland.org (Postfix) with ESMTP id 29388203F0;
 Thu, 31 Jul 2025 08:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=voidland.org; s=mail;
 t=1753950599; bh=PEpGB3NJxsteRqRxCK0Ebe0hEUoJRlCXJQ799i7hJNE=;
 h=From:To:Cc:Subject:Date:From;
 b=xHqbnQ2PUk/3jJlMMS4vF3VRVvkskflIfIN42U2kMgws7E3tI28I/PXmEPfs8X/fA
 1N/8BgcYlDc1UnuHt0pC+LSCGWaEu99nVHKfMb2jpOaQegd+tOu2EdY+Qpq+YszEK1
 TmIvcvLAMZOazb0/pzYWpO7qSHcZb9N0u3sjjhso=
Received: from voidland.voidland.org (router.voidland.org [192.168.255.16])
 by es.voidland.org (Postfix) with ESMTPSA id C34C657B0840;
 Thu, 31 Jul 2025 11:29:59 +0300 (EEST)
From: Vladimir Panov <gbr@voidland.org>
To: u-boot@lists.denx.de
Cc: Vladimir Panov <gbr@voidland.org>, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sunil Mohan Adapa <sunil@medhas.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] sunxi: OLinuXino-A64 needs the CONFIG_GMAC_TX_DELAY=4
 workaround.
Date: Thu, 31 Jul 2025 11:29:51 +0300
Message-ID: <20250731082953.2006406-1-gbr@voidland.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Jul 2025 11:34:03 +0200
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

Olimex OLinuXino-A64's ethernet does not work reliably by default.

It needs the CONFIG_GMAC_TX_DELAY=4 workaround mentioned here:
https://linux-sunxi.org/Olimex_A20-OLinuXino-Lime2#GMAC_quirks

Signed-off-by: Vladimir Panov <gbr@voidland.org>
---

 configs/a64-olinuxino-emmc_defconfig | 1 +
 configs/a64-olinuxino_defconfig      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/a64-olinuxino-emmc_defconfig b/configs/a64-olinuxino-emmc_defconfig
index a5989fab1c6..7f333011b48 100644
--- a/configs/a64-olinuxino-emmc_defconfig
+++ b/configs/a64-olinuxino-emmc_defconfig
@@ -7,5 +7,6 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_SUN8I_EMAC=y
+CONFIG_GMAC_TX_DELAY=4
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
diff --git a/configs/a64-olinuxino_defconfig b/configs/a64-olinuxino_defconfig
index 0b469c25d0d..0dd93ffa238 100644
--- a/configs/a64-olinuxino_defconfig
+++ b/configs/a64-olinuxino_defconfig
@@ -6,5 +6,6 @@ CONFIG_MACH_SUN50I=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
+CONFIG_GMAC_TX_DELAY=4
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
-- 
2.47.2

base-commit: 79f3e77133bd7248e4579827effc13f97a32a8a8
branch: master
