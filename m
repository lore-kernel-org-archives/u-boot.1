Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB65C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 10:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D58888E7;
	Thu, 13 Jun 2024 12:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24D48888E8; Thu, 13 Jun 2024 12:59:11 +0200 (CEST)
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
 by phobos.denx.de (Postfix) with ESMTP id 30BE9888D1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 12:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris@arachsys.com
Received: from chris by delta.arachsys.com with local (Exim 4.80)
 (envelope-from <chris@arachsys.com>) id 1sHiAb-0007tq-Lc
 for u-boot@lists.denx.de; Thu, 13 Jun 2024 11:59:05 +0100
Date: Thu, 13 Jun 2024 11:59:05 +0100
From: Chris Webb <chris@arachsys.com>
To: u-boot@lists.denx.de
Subject: [PATCH RFC] gpio: Fix probing of gpio-hogs
Message-ID: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
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

48b3ecbe replumbed the gpio-hog probing to use DM_FLAG_PROBE_AFTER_BIND.

Unfortunately gpio_post_bind is called after the non-preloc recursive
dm_probe_devices completes, so setting this flag does not have the intended
effect and the gpio-hogs never get probed. With instrumentation:

  [...]
  CPU:   MediaTek MT7981
  Model: GL.iNet GL-X3000
  DRAM:  512 MiB
  <mtk_pinctrl_mt7981_bind called>
  <dm_probe_devices called: root root_driver root_driver [+] [ ]>
  <dm_probe_devices called: clk fixed_clock gpt_dummy20m [ ] [ ]>
  [...]
  <dm_probe_devices called: led gpio_led signal-4 [ ] [ ]>
  Core:  34 devices, 14 uclasses, devicetree: separate
  MMC:   <gpio_post_bind called>
  mmc@11230000: 0
  [...]

Probe them directly in gpio_post_bind instead.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 drivers/gpio/gpio-uclass.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 4234cd91..1c6e1715 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -1539,7 +1539,9 @@ static int gpio_post_bind(struct udevice *dev)
 				 * since hogs can be essential to the hardware
 				 * system.
 				 */
-				dev_or_flags(child, DM_FLAG_PROBE_AFTER_BIND);
+				ret = device_probe(child);
+				if (ret)
+					return ret;
 			}
 		}
 	}
