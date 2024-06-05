Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58ADC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 09:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4797E88303;
	Wed,  5 Jun 2024 11:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF9358836E; Wed,  5 Jun 2024 11:33:42 +0200 (CEST)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [185.125.25.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E24C3879F3
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 11:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VvMj03ypVzg5P;
 Wed,  5 Jun 2024 11:33:40 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VvMhz4j6hzL01; Wed,  5 Jun 2024 11:33:39 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/3] rockchip: rk8xx: fix broken [np]ldo callbacks
Date: Wed, 05 Jun 2024 11:33:20 +0200
Message-Id: <20240605-pmic-rk8xx-v1-0-2349fdf68aa0@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOAwYGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwNT3YLczGTdomyLigpdU6M0IyMLs6RUY2MTJaCGgqLUtMwKsGHRsbW
 1AJiSY7FcAAAA
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

This is for master branch, merge ASAP as it's known to break at least
Chromebook Jerry.

@Simon, can you please check that this fixes your CB?

The wrong udevice was passed to the functions, making them call the
pmic callbacks on the parent of the pmic udevice instead of the pmic
udevice itself.

While at it, ensure consistency by having all internal functions use
pmic udevice instead of the regulator udevice.

Finally, clarify operator precedence in ternary condition as reported by
my linter.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      regulator: rk8xx: fix incorrect device used for _ldo_[sg]et_suspend_value
      regulator: rk8xx: pass pmic udevice instead of regulator to all internal functions
      regulator: rk8xx: clarify operator precedence

 drivers/power/regulator/rk8xx.c | 54 ++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 27 deletions(-)
---
base-commit: c0ea27bccfb7d2d37fd36806ac2a2f7389099420
change-id: 20240605-pmic-rk8xx-52f2286be334

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

