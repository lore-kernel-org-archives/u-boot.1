Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C8CC4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 01:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50B9580517;
	Sun, 19 Jul 2026 03:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BEE282991; Sun, 19 Jul 2026 03:49:26 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A97680398
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 03:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlGef-000000001lc-3VR3; Sun, 19 Jul 2026 01:49:21 +0000
Date: Sun, 19 Jul 2026 02:49:14 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 u-boot@lists.denx.de
Subject: [PATCH 0/2] rtc: pcf8563: HYM8563 support and unreliable-time
 reporting
Message-ID: <cover.1784423738.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The Haoyu HYM8563, found for example on the Radxa ROCK 5B, is a clone of
the NXP PCF8563 with an identical timekeeping register layout, but the
pcf8563 driver does not match its compatible used in upstream DT.

Boards fitted with it end up without DM_RTC and, as a consequence,
without usable EFI GetTime and SetTime runtime services. On top of
that, when the chip reports that the time may be unreliable after a
supply voltage drop, the driver returns a bare -1, which callers
interpret as -EPERM rather than as invalid data.

This series makes the existing driver serve the HYM8563 and lets callers
distinguish an unreliable time from a permission problem.

The driver gains the additional compatible string and returns -EINVAL
when the voltage-low flag is set, matching the rv3032 driver and the
behaviour of the Linux driver for the same chips.

Daniel Golle (2):
  rtc: pcf8563: add haoyu,hym8563 compatible
  rtc: pcf8563: return -EINVAL when the voltage-low flag is set

 drivers/rtc/pcf8563.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


base-commit: ece349ade2973e220f524ce59e59711cc919263f
-- 
2.55.0
