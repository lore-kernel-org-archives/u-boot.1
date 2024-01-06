Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D12C46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 22:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F2F879E4;
	Sat,  6 Jan 2024 23:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=users.sf.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ED13879E4; Sat,  6 Jan 2024 23:21:49 +0100 (CET)
Received: from asu.lan.rzr.cloudns.org (unknown
 [IPv6:2a01:e34:ec57:d710::c2f9:90f6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 672968798C
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 23:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=users.sf.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rzr@users.sf.net
Received: from asu.. (localhost [IPv6:::1])
 by asu.lan.rzr.cloudns.org (Postfix) with ESMTP id B827824B8DD;
 Sat,  6 Jan 2024 23:21:46 +0100 (CET)
From: Philippe Coval <rzr@users.sf.net>
To: u-boot@lists.denx.de
Cc: Philippe Coval <rzr@users.sf.net>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Sam Edwards <CFSworks@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: sunxi: Reduce inrush current on Olimex
 A20-OLinuXino_MICRO
Date: Sat,  6 Jan 2024 23:21:34 +0100
Message-ID: <20240106222142.170219-1-rzr@users.sf.net>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 06 Jan 2024 23:43:24 +0100
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

This change fix reboot, it was tested on debian-12

It was inspired from for-master-20181206-10-g8311e84b18

Relate-to: https://github.com/rzr/u-boot/issues/2
Thanks-to: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Philippe Coval <rzr@users.sf.net>
---

 configs/A20-OLinuXino_MICRO_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/A20-OLinuXino_MICRO_defconfig b/configs/A20-OLinuXino_MICRO_defconfig
index db4270f9b2..673ab85c8a 100644
--- a/configs/A20-OLinuXino_MICRO_defconfig
+++ b/configs/A20-OLinuXino_MICRO_defconfig
@@ -20,6 +20,7 @@ CONFIG_ETH_DESIGNWARE=y
 CONFIG_MII=y
 CONFIG_SUN7I_GMAC=y
 CONFIG_SUN7I_GMAC_FORCE_TXERR=y
+CONFIG_AXP_ALDO3_INRUSH_QUIRK=y
 CONFIG_AXP_ALDO3_VOLT=2800
 CONFIG_AXP_ALDO4_VOLT=2800
 CONFIG_SCSI=y
-- 
2.43.0

