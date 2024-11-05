Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C401CD3176B
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 17:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20EFD891D2;
	Tue,  5 Nov 2024 18:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA22D891CD; Tue,  5 Nov 2024 18:22:11 +0100 (CET)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::1909])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E80898904C
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XjZrx4Z0VzTv7;
 Tue,  5 Nov 2024 18:22:09 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4XjZrw50ZBzw6J; Tue,  5 Nov 2024 18:22:08 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next RFC 0/5] rockchip: panic() when DRAM init fails
Date: Tue, 05 Nov 2024 18:21:54 +0100
Message-Id: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADJUKmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwNT3aJsY2NLS92UosRc3cy8zBJdIwNzYyPTZKMUy+REJaC2gqLUtMw
 KsJHRSnmpFSUgwSA3Z6XY2loAt3FSW28AAAA=
X-Change-ID: 20241105-rk3399-dram-init-207325c2d9ca
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

I am the unfortunate owner of an RK3399 Puma that is failing DRAM init
every now and then with the following cryptic error message:
"""
pctl_start: Failed to init pctl channel 0
"""

When it fails, the current logic is implemented in such a way that the
board enters an infinite while loop. This is not ideal for embedded
systems that are not easily accessible and also an issue when having
devices in a CI lab for example.

Therefore, let's simply panic if the DRAM fails to init. This was tested
only on RK3399 Puma, similar changes may be required for other SoCs to
properly propagate the errors.

While this is all but a work-around instead of fixing the DRAM init
sequence, I believe it is important for resilience of devices in the
field.

Marking this as RFC because:
1) panic()s for all Rockchip SoCs but only tested on RK3399
2) unsure about error return values (ENODEV and the likes), not sure
   what would be better than that though :/

Note that one can still hang() if they want by setting PANIC_HANG
symbol.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (5):
      ram: rk3399: allow to fail DRAM init if pctl_start fails
      ram: rk3399: fail probe if DRAM init failed
      rockchip: spl/tpl: panic when DRAM init failed
      ram: rk3399: merge two consecutive ifs with same condition
      ram: rk3399: fail DRAM init when pctl channel init fails instead of hanging

 arch/arm/mach-rockchip/spl.c        |  7 +++----
 arch/arm/mach-rockchip/tpl.c        |  6 ++----
 drivers/ram/rockchip/sdram_rk3399.c | 24 +++++++++++-------------
 3 files changed, 16 insertions(+), 21 deletions(-)
---
base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
change-id: 20241105-rk3399-dram-init-207325c2d9ca

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

