Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9B6D11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 13:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 553A98431E;
	Thu, 27 Nov 2025 14:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F15843C1; Thu, 27 Nov 2025 14:29:47 +0100 (CET)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [185.125.25.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F4A184312
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 14:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dHHN764d3zgsp;
 Thu, 27 Nov 2025 14:29:43 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dHHN7126ZzHM1; Thu, 27 Nov 2025 14:29:43 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next v2 0/3] CI: use mirrors for GNU tools
Date: Thu, 27 Nov 2025 14:29:25 +0100
Message-Id: <20251127-gnu-mirror-v2-0-c86fa2e8d464@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBBEf4Xs2TVttQQ98R+GQykL7MFitthAS
 P/dhrPHN5N5c0AkYYrwrA4QShx5CQXMpQI/uzAR8lAYjDJWa6NxCl98s8gi+Gj6fnQ3Zb1zUAY
 foZG3U/aCQNsKXUlnjusi+/mQ9Nn9kyWNCu29odoPpq4ttX4mkf06EHQ55x9scpK9qgAAAA==
X-Change-ID: 20251121-gnu-mirror-98bbfa305caa
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymondmaoca@gmail.com>
X-Mailer: b4 0.14.3
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

I have to add one (1) package to the Dockerfile as a new dependency and
wanted to build the image to verify it works. I wasn't able to because
GNU servers are just not reliable at all.

The git server URL we're using doesn't seem to be a mirrored one, and
switching to mirror URLs seem to make fetching possible again.

Unfortunately, we don't have the option to do that for coreboot's
dependencies, though we can ask coreboot to download the dependencies
through its own mirror, which we do in this series.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- use GNULIB_URL for bootstrapping grub instead of manually cloning the
  git repo as done in v1,
- added R-b,
- rebased on top of next,
- Link to v1: https://patch.msgid.link/20251121-gnu-mirror-v1-0-548e6cd2665e@cherry.de

---
Quentin Schulz (3):
      CI: use GNU mirror for grub (and switch to HTTPS)
      CI: use mirror for gnulib dependency of grub
      CI: use coreboot mirror for GNU dependencies of coreboot

 tools/docker/Dockerfile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 4a4871e3dc38f3f771d2713b805e79e6191b4297
change-id: 20251121-gnu-mirror-98bbfa305caa

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

