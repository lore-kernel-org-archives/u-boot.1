Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2DCC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A9CB8861D;
	Mon, 10 Jun 2024 18:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4016A88625; Mon, 10 Jun 2024 18:09:35 +0200 (CEST)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 475718812B
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VycFS6T8SzQsN;
 Mon, 10 Jun 2024 18:09:32 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VycFR5GftzVV; Mon, 10 Jun 2024 18:09:31 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/4] dm: core: fix several debug messages and migrate
 debug() to dm_warn
Date: Mon, 10 Jun 2024 18:09:12 +0200
Message-Id: <20240610-misc-20240610-v1-0-6914f1725dd4@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACglZ2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0MD3dzM4mRdOC/NMiU51cDUwNDCLEkJqKegKDUtswJsXnRsbS0A2zJ
 IC18AAAA=
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Dario Binacchi <dariobin@libero.it>
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

Fix a few misleading or incorrect debug messages and prompt text for a
Kconfig symbol.

Migrate debug() messages to use dm_warn() instead so that we can print
them without selecting DM_DEBUG which does too much (e.g. makes assert()
reset U-boot if it fails).

Tested on top of next branch but it applies without complaints on top of
master as well, so up to you to which branch to merge it.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (4):
      dm: core: fix misleading debug message when matching compatible
      dm: core: fix signedness in debug messages
      dm: core: migrate debug() messages to use dm_warn
      dm: core: fix typo in SPL_DM_WARN prompt text

 drivers/core/Kconfig     |  2 +-
 drivers/core/device.c    |  2 +-
 drivers/core/fdtaddr.c   |  6 ++--
 drivers/core/lists.c     |  7 ++---
 drivers/core/of_access.c | 50 +++++++++++++++---------------
 drivers/core/of_addr.c   | 40 ++++++++++++------------
 drivers/core/of_extra.c  | 32 +++++++++----------
 drivers/core/ofnode.c    | 80 ++++++++++++++++++++++++------------------------
 drivers/core/regmap.c    | 56 ++++++++++++++++-----------------
 drivers/core/root.c      | 14 ++++-----
 drivers/core/uclass.c    |  4 +--
 11 files changed, 146 insertions(+), 147 deletions(-)
---
base-commit: 4f836fb324ba500ecabdba4146c3ca9e1600cdf5
change-id: 20240610-misc-20240610-f9dce050186b

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

