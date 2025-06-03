Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8B4C5B549
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 03:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874D282103;
	Tue,  3 Jun 2025 05:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X9od6WWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB1B81F0D; Tue,  3 Jun 2025 05:06:25 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CEC281E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 05:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+smelamud.redhat.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D1DB95C5428;
 Tue,  3 Jun 2025 03:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5817CC4CEED;
 Tue,  3 Jun 2025 03:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748919980;
 bh=1jLyNp9OLZlEl3G2bx9eOEVl4koCn3TPWeSL6l4fnbQ=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=X9od6WWZvebvBpEov3AkjRWQpfuftREMcNTYdDhsFZtaCJCc/eTPXG1wfYVtSQCa+
 dSOa8luy9TrpclnbiVnLOYgNequaz3rsfbWNcXrKu4qHnAvOYI8OPCKZdw70hL9T9d
 naOSvYlSpSc2PLbK5mjM00EnVoaUwbt14t/flaH89qLxLgBSuI6DBpJCD/59WrYaR9
 ygHBc85710G3wp0A6fWyn98LB/pyBzId4E1IzIW7ZFNULJmUBuANI4bkCgIzyQHNPO
 erjMsEZ9xIirQ21S6wRqDDO2wNyZMYCHJtiydNxrI+v6MNdFYRdHSUHDd+Rb7oo9tR
 e3oKRgod894og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3082EC5AD49;
 Tue,  3 Jun 2025 03:06:20 +0000 (UTC)
From: Shmuel Leib Melamud via B4 Relay <devnull+smelamud.redhat.com@kernel.org>
Subject: [PATCH v3 0/2] renesas: Renesas R-Car Gen4 watchdog driver
Date: Tue, 03 Jun 2025 06:06:03 +0300
Message-Id: <20250603-us-renesas-watchdog-v3-0-af3a65afd03e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJtmPmgC/32NQQ6CMBBFr0Jm7ZhaBMWV9zAsysxAu5CaDqKGc
 HcrB3D5XvLfX0AlBVG4FAskmYOGOGYodwWQd+MgGDgzWGMrU5UGn4pJRlGn+HITeY4DWjo13HV
 cEVvIy0eSPry36q3N7INOMX22k9n+7P/ebPGAneFz39RUH5muSdi7aU/xDu26rl9bqop8twAAA
 A==
X-Change-ID: 20250530-us-renesas-watchdog-2c79dbbd5cd2
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Shmuel Leib Melamud <smelamud@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748919978; l=1660;
 i=smelamud@redhat.com; s=20250530; h=from:subject:message-id;
 bh=1jLyNp9OLZlEl3G2bx9eOEVl4koCn3TPWeSL6l4fnbQ=;
 b=JWLFX1cWBEAfQb+hiMKFVfIicYofSQHtIkxZz2ZYBzpa2jVakZ0KA1sY0OKwFNSlcokBdY43o
 8UzEeCQ0YL0C4NX+Ob7zTw5IowNekl6wTVjyh1ubuLUtS/vK43/ExWJ
X-Developer-Key: i=smelamud@redhat.com; a=ed25519;
 pk=B1DFtpdxDPQudtnqMHSFRRSJziu3zB49J6oZUBo0qI8=
X-Endpoint-Received: by B4 Relay for smelamud@redhat.com/20250530 with
 auth_id=418
X-Original-From: Shmuel Leib Melamud <smelamud@redhat.com>
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
Reply-To: smelamud@redhat.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

These series add support of Renesas R-Car Gen4 watchdog timer.
Timeouts up to 8184.0s are supported (CKS1 register is not involved).
The watchdog uses the clock type CLK_TYPE_GEN4_MDSEL, so a separate
patch adds handling of this constant to gen3_clk_get_rate64() function.

The series were tested on real Renesas R8A779F0 hardware. If the
watchdog driver is enabled at the build time, the watchdog timer is
initialized when U-Boot starts. Under normal circumstances, U-Boot loads
the kernel, it starts systemd and systemd continues to pet the watchdog.
If systemd is not started before the timeout expires, the watchdog
resets the board.

Signed-off-by: Shmuel Leib Melamud <smelamud@redhat.com>

---
Changes in v3:
- Reference to the Linux driver added.
- Clock driver change moved to a separate patch.
- rwdt_ prefix used everywhere instead of renesas_wdt_.
- Disable the clock if rwdt_probe() fails.
- List of compatibles updated.
- Link to v2: https://lore.kernel.org/r/20250530-us-renesas-watchdog-v2-1-b0d8f96c64dc@redhat.com

---
Shmuel Leib Melamud (2):
      renesas: Handle CLK_TYPE_GEN4_MDSEL in gen3_clk_get_rate64()
      renesas: Renesas R-Car Gen4 watchdog driver

 drivers/clk/renesas/clk-rcar-gen3.c |   4 +-
 drivers/watchdog/Kconfig            |   8 ++
 drivers/watchdog/Makefile           |   1 +
 drivers/watchdog/renesas_wdt.c      | 182 ++++++++++++++++++++++++++++++++++++
 4 files changed, 194 insertions(+), 1 deletion(-)
---
base-commit: 3b6760ddeb4ef940226921017cd9088c89784b01
change-id: 20250530-us-renesas-watchdog-2c79dbbd5cd2

Best regards,
-- 
Shmuel Leib Melamud <smelamud@redhat.com>


