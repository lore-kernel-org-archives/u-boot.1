Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D26C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE97886AD;
	Tue, 11 Jun 2024 15:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB1F88681; Tue, 11 Jun 2024 15:04:44 +0200 (CEST)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ADA188655
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vz85j6yfvzFVt;
 Tue, 11 Jun 2024 15:04:41 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vz85j1Z1HzB0S; Tue, 11 Jun 2024 15:04:41 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v2 0/4] dm: core: fix several debug messages and migrate
 debug() to dm_warn
Date: Tue, 11 Jun 2024 15:04:23 +0200
Message-Id: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFdLaGYC/3XMQQ7CIBCF4as0sxbDEIrWlfcwXSgMMgtbMxhi0
 3B3sQt3Lr+XvH+FTMKU4dStIFQ48zw1mF0HPl2nOykOzWC0sdqhVg/OXv0Uh+BJ9xqP7gbt8xS
 K/N56l7E5cX7Nsmz5gt/1X6mg0soNaCMeTB+CPftEIss+EIy11g8BxRUSqgAAAA==
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
Changes in v2:
- add missing dm/util.h header includes
- Link to v1: https://lore.kernel.org/r/20240610-misc-20240610-v1-0-6914f1725dd4@cherry.de

---
Quentin Schulz (4):
      dm: core: fix misleading debug message when matching compatible
      dm: core: fix signedness in debug messages
      dm: core: migrate debug() messages to use dm_warn
      dm: core: fix typo in SPL_DM_WARN prompt text

 drivers/core/Kconfig     |  2 +-
 drivers/core/device.c    |  2 +-
 drivers/core/fdtaddr.c   |  7 +++--
 drivers/core/lists.c     |  7 ++---
 drivers/core/of_access.c | 51 +++++++++++++++---------------
 drivers/core/of_addr.c   | 41 ++++++++++++------------
 drivers/core/of_extra.c  | 33 ++++++++++----------
 drivers/core/ofnode.c    | 81 ++++++++++++++++++++++++------------------------
 drivers/core/regmap.c    | 57 +++++++++++++++++-----------------
 drivers/core/root.c      | 14 ++++-----
 drivers/core/uclass.c    |  4 +--
 11 files changed, 152 insertions(+), 147 deletions(-)
---
base-commit: f9886bc60f42d5bcfcfa4e474af7dc230400b6be
change-id: 20240610-misc-20240610-f9dce050186b

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

